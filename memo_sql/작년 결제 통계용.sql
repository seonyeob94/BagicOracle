-- TEAM1_202502F���� ����

CREATE OR REPLACE PROCEDURE GEN_SUBS_PAY_2024_2025_ONEPER_V2 (
  p_start           IN DATE     DEFAULT DATE '2024-01-01',
  p_end             IN DATE     DEFAULT DATE '2025-09-02',
  p_mem_min         IN NUMBER   DEFAULT 150,        -- ������̵� ����
  p_mem_max         IN NUMBER   DEFAULT 388,        -- ������̵� ����
  p_jan_cap         IN NUMBER   DEFAULT 120,
  p_jan_target      IN NUMBER   DEFAULT 70,
  p_step_month      IN NUMBER   DEFAULT 12,
  p_month_sigma_pct IN NUMBER   DEFAULT 0.55,        -- �� ������
  p_min_recur       IN NUMBER   DEFAULT 8,           -- �ּ� 8����
  p_max_recur       IN NUMBER   DEFAULT 14,          -- �ִ� 14����
  p_uid_tag         IN VARCHAR2 DEFAULT '_sim_one_v2',
  p_day_spike_prob  IN NUMBER   DEFAULT 0.22,        -- �� ������ũ Ȯ��
  p_day_spike_gain  IN NUMBER   DEFAULT 1.8,         -- �� ������ũ ����
  p_use_plan        IN CHAR     DEFAULT 'N'          -- 'Y'�� SIM_MONTH_TARGET ���
) AS
  v_ym        DATE;
  v_idx       PLS_INTEGER := 0;
  v_target_mu NUMBER;
  v_target    PLS_INTEGER;
  v_plan      NUMBER;

  v_avail     PLS_INTEGER;
  v_needed    PLS_INTEGER;

  v_mem_id       MEMBER.MEM_ID%TYPE;
  v_sub_id       SUBSCRIBE.SUB_ID%TYPE;
  v_price        SUBSCRIBE.SUB_PRICE%TYPE;
  v_start_dt     DATE;
  v_start_day    PLS_INTEGER;
  v_time_secs    PLS_INTEGER;
  v_recur_des    PLS_INTEGER;
  v_recur_eff    PLS_INTEGER;
  v_last_pay     DATE;
  v_ms_id        MEMBER_SUBSCRIPTION.MS_ID%TYPE;
  v_overlap_cnt  PLS_INTEGER;
  v_day_of_month PLS_INTEGER;

  v_days   PLS_INTEGER;
  v_sum_w  NUMBER;

  TYPE num_tab IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  w        num_tab;
  need_day num_tab;
  v_total  PLS_INTEGER;

  v_seed   PLS_INTEGER;   -- �� �����÷� ����
BEGIN
  ----------------------------------------------------------------------
  -- 0) �� ���� ���� ���� �õ� (PLS_INTEGER ������ ����)
  ----------------------------------------------------------------------
  SELECT ORA_HASH(
           RAWTOHEX(SYS_GUID())||
           TO_CHAR(SYSTIMESTAMP,'FFSSSS')||
           USERENV('SESSIONID'),
           2147483647
         )
    INTO v_seed
    FROM dual;

  DBMS_RANDOM.SEED(v_seed);

  v_ym := TRUNC(p_start,'MM');

  WHILE v_ym <= TRUNC(p_end,'MM') LOOP
    ------------------------------------------------------------------
    -- 1) �� ��ǥġ: ��ȹǥ(����) �� �߼� + ���Գ�����
    ------------------------------------------------------------------
    v_plan := NULL;
    IF p_use_plan = 'Y' THEN
      BEGIN
        SELECT t.TARGET INTO v_plan
        FROM SIM_MONTH_TARGET t
        WHERE t.MONTH_KEY = TO_CHAR(v_ym,'YYYYMM');
      EXCEPTION WHEN NO_DATA_FOUND THEN v_plan := NULL; END;
    END IF;

    IF v_plan IS NOT NULL THEN
      v_target_mu := v_plan;
    ELSE
      IF v_ym = DATE '2024-01-01' THEN
        v_target_mu := LEAST(p_jan_target, p_jan_cap);
      ELSE
        v_target_mu := GREATEST(8, p_jan_target + v_idx * p_step_month);
      END IF;
    END IF;

    -- ����(0, ��) ������ �� ĸ
    v_target := ROUND( GREATEST(0,
                      v_target_mu *
                      (1 + LEAST(1.5, GREATEST(-1.5, DBMS_RANDOM.NORMAL * p_month_sigma_pct)))
                    ) );

    ------------------------------------------------------------------
    -- 2) �ĺ�(���� ����X & ���Կ� �� v_ym)
    ------------------------------------------------------------------
    SELECT COUNT(*)
      INTO v_avail
    FROM MEMBER m
    WHERE m.MEM_ID BETWEEN p_mem_min AND p_mem_max
      AND NVL(m.DEL_YN,'N') = 'N'
      AND TRUNC(m.CREATED_AT,'MM') <= v_ym
      AND NOT EXISTS (
            SELECT 1 FROM MEMBER_SUBSCRIPTION ms
             WHERE ms.MEM_ID = m.MEM_ID
               AND ms.CUSTOMER_UID LIKE 'userInfo.id_%' || p_uid_tag || '%'
          );

    v_needed := LEAST(v_target, v_avail);
    IF v_needed <= 0 THEN
      v_idx := v_idx + 1; v_ym := ADD_MONTHS(v_ym,1); CONTINUE;
    END IF;

    ------------------------------------------------------------------
    -- 3) �� ��ǥ�� �Ϻ��� ������ ����(�������� + ������ũ)
    ------------------------------------------------------------------
    v_days  := TO_NUMBER(TO_CHAR(LAST_DAY(v_ym),'DD'));
    v_sum_w := 0;
    FOR d IN 1..v_days LOOP
      w(d) := -LN(DBMS_RANDOM.VALUE);
      IF DBMS_RANDOM.VALUE < p_day_spike_prob THEN
        w(d) := w(d) * (1 + DBMS_RANDOM.VALUE * p_day_spike_gain);
      END IF;
      v_sum_w := v_sum_w + w(d);
    END LOOP;

    v_total := 0;
    FOR d IN 1..v_days LOOP
      need_day(d) := TRUNC(v_needed * (w(d)/v_sum_w));
      v_total     := v_total + need_day(d);
    END LOOP;

    -- �ܿ� �ο� ���� ���ڿ� +1 ����
    WHILE v_total < v_needed LOOP
      DECLARE r PLS_INTEGER := TRUNC(DBMS_RANDOM.VALUE(1, v_days+1));
      BEGIN
        need_day(r) := need_day(r) + 1;
        v_total     := v_total + 1;
      END;
    END LOOP;

    ------------------------------------------------------------------
    -- 4) �Ϻ� ����
    ------------------------------------------------------------------
    FOR d IN 1..v_days LOOP
      IF need_day(d) <= 0 THEN CONTINUE; END IF;

      FOR cand IN (
        SELECT m.mem_id
        FROM MEMBER m
        WHERE m.MEM_ID BETWEEN p_mem_min AND p_mem_max
          AND NVL(m.DEL_YN,'N') = 'N'
          AND TRUNC(m.CREATED_AT,'MM') <= v_ym
          AND NOT EXISTS (
                SELECT 1 FROM MEMBER_SUBSCRIPTION ms
                WHERE ms.MEM_ID = m.MEM_ID
                  AND ms.CUSTOMER_UID LIKE 'userInfo.id_%' || p_uid_tag || '%'
              )
        ORDER BY DBMS_RANDOM.VALUE
      ) LOOP
        EXIT WHEN need_day(d) <= 0;

        v_mem_id := cand.mem_id;

        -- ��ǰ ����ġ 60/30/10
        IF DBMS_RANDOM.VALUE < 0.60 THEN
          v_sub_id := 1;
        ELSIF DBMS_RANDOM.VALUE < 0.90 THEN
          v_sub_id := 2;
        ELSE
          v_sub_id := 3;
        END IF;

        -- �ش��� ���� ��/��/��
        v_start_day := d;
        v_time_secs := TRUNC(DBMS_RANDOM.VALUE(0, 86400));
        v_start_dt  := LEAST(LAST_DAY(v_ym), v_ym + (v_start_day-1))
                       + NUMTODSINTERVAL(v_time_secs,'SECOND');

        -- ���� ����(�� ����)
        v_recur_des := TRUNC(DBMS_RANDOM.VALUE(p_min_recur, p_max_recur+1));
        v_recur_eff := 0; v_last_pay := NULL;
        v_day_of_month := TO_NUMBER(TO_CHAR(v_start_dt,'DD'));

        -- �� �Ⱓ ��ħ ����(��ü �Ⱓ���� üũ)
        SELECT COUNT(*) INTO v_overlap_cnt
          FROM MEMBER_SUBSCRIPTION ms
         WHERE ms.MEM_ID = v_mem_id
           AND ms.SUB_START_DT < ADD_MONTHS(v_start_dt, v_recur_des)
           AND ADD_MONTHS(ms.SUB_START_DT, ms.RECUR_PAY_CNT) > v_start_dt;
        IF v_overlap_cnt > 0 THEN CONTINUE; END IF;

        -- �ƿ��� �̳� ���� ȸ��/������ ������ ����
        FOR k IN 0..35 LOOP
          EXIT WHEN k >= v_recur_des;
          DECLARE v_base DATE; v_pay DATE; BEGIN
            v_base := LEAST(
                       LAST_DAY(ADD_MONTHS(TRUNC(v_start_dt), k)),
                       TRUNC(ADD_MONTHS(TRUNC(v_start_dt), k),'MM') + (v_day_of_month-1)
                     );
            v_pay  := v_base + (v_start_dt - TRUNC(v_start_dt));
            EXIT WHEN v_pay > p_end;
            v_recur_eff := v_recur_eff + 1;
            v_last_pay  := v_pay;
          END;
        END LOOP;
        IF v_recur_eff = 0 THEN CONTINUE; END IF;

        SELECT s.SUB_PRICE INTO v_price FROM SUBSCRIBE s WHERE s.SUB_ID = v_sub_id;

        -- ���� INSERT
        INSERT INTO MEMBER_SUBSCRIPTION (
          MS_ID, MEM_ID, SUB_ID, CUSTOMER_UID, SUB_STATUS,
          SUB_START_DT, SUB_END_DT, LAST_PAY_DT,
          RECUR_PAY_CNT, CREATED_DT, UPDATED_DT
        ) VALUES (
          MEMBER_SUBSCRIPTION_SEQ.NEXTVAL,
          v_mem_id, v_sub_id,
          'userInfo.id_'||v_mem_id||p_uid_tag, 'N',
          v_start_dt,
          ADD_MONTHS(v_start_dt, v_recur_eff),
          v_last_pay,
          v_recur_eff,
          v_start_dt,
          v_last_pay
        )
        RETURNING MS_ID INTO v_ms_id;

        -- ���� INSERT (�� ���� + ���� �ð� ����)
        FOR k IN 0..v_recur_eff-1 LOOP
          DECLARE v_base DATE; v_pay DATE; v_cnt NUMBER; BEGIN
            v_base := LEAST(
                       LAST_DAY(ADD_MONTHS(TRUNC(v_start_dt), k)),
                       TRUNC(ADD_MONTHS(TRUNC(v_start_dt), k),'MM') + (v_day_of_month-1)
                     );
            v_pay  := v_base + (v_start_dt - TRUNC(v_start_dt));

            IF v_sub_id = 1 THEN v_cnt := 3;
            ELSIF v_sub_id = 2 THEN v_cnt := 6;
            ELSE v_cnt := 8;
            END IF;

            INSERT INTO PAYMENT (
              PAY_ID, PAY_DATE, PAY_AMOUNT,
              PAY_RESUME_CNT, PAY_COVER_CNT, PAY_CONSULT_CNT, PAY_MOCK_CNT,
              MS_ID, IMP_UID, MERCHANT_UID
            ) VALUES (
              PAYMENT_SEQ.NEXTVAL,
              v_pay, v_price,
              v_cnt, v_cnt, v_cnt, v_cnt,
              v_ms_id,
              'imp_'   || v_ms_id || '_' || TO_CHAR(v_pay,'YYYYMMDDHH24MISS') || '_' || k,
              'order_' || v_mem_id|| '_' || TO_CHAR(v_pay,'YYYYMMDDHH24MISS') || '_' || k
            );
          END;
        END LOOP;

        need_day(d) := need_day(d) - 1;
      END LOOP; -- cand

      COMMIT; -- �� ���� Ŀ��
    END LOOP; -- day

    v_idx := v_idx + 1;
    v_ym  := ADD_MONTHS(v_ym, 1);
  END LOOP;
END;
/

BEGIN
  GEN_SUBS_PAY_2024_2025_ONEPER_V2(
    p_month_sigma_pct => 0.7,  -- �� ���� ũ��
    p_day_spike_prob  => 0.30, -- �� ������ũ ����
    p_day_spike_gain  => 2.5,  -- ������ũ ����
    p_use_plan        => 'N'   -- ��ȹǥ ����
  );
END;
/

