CREATE OR REPLACE PROCEDURE GEN_NEW_SIGNUPS_2025 (
  p_year            IN NUMBER   DEFAULT 2025,
  p_min_recur       IN NUMBER   DEFAULT 8,
  p_max_recur       IN NUMBER   DEFAULT 9,
  p_basic_weight    IN NUMBER   DEFAULT 0.60,
  p_plus_weight     IN NUMBER   DEFAULT 0.30,
  p_pro_weight      IN NUMBER   DEFAULT 0.10,
  p_cutoff_date     IN DATE     DEFAULT DATE '2025-09-02',
  p_uid_tag         IN VARCHAR2 DEFAULT '_sim_new'   -- UID 접미사(재실행 구분용)
) AS
BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE NEW_SUBS_BUF';

  ------------------------------------------------------------------
  -- 1) 버퍼 작성: 상품 배정, 회수 계산, "월당 1건" 보장 + 컷오프 적용
  ------------------------------------------------------------------
  INSERT INTO NEW_SUBS_BUF (
    MS_ID, MEM_ID, SUB_ID, START_DT, END_DT, LAST_PAY_DT, RECUR_CNT, CUSTOMER_UID
  )
  WITH
  BASE AS (
    SELECT
      n.MEM_ID,
      TO_DATE(p_year || '-' || n.MONTH_KEY || '-01','YYYY-MM-DD') AS MONTH_START,
      TRUNC(DBMS_RANDOM.VALUE(1,28)) AS START_DAY,
      DBMS_RANDOM.VALUE(0,1) AS R
    FROM NEW_SUB_MEMBERS n
  ),
  DECIDED AS (
    SELECT
      b.MEM_ID,
      LEAST(LAST_DAY(b.MONTH_START), b.MONTH_START + (b.START_DAY-1)) AS START_DT,
      CASE
        WHEN b.R < p_basic_weight THEN 1
        WHEN b.R < p_basic_weight + p_plus_weight THEN 2
        ELSE 3
      END AS SUB_ID
    FROM BASE b
  ),
  DESIRED AS (
    SELECT
      d.MEM_ID, d.SUB_ID, d.START_DT,
      TRUNC(DBMS_RANDOM.VALUE(p_min_recur, p_max_recur+1)) AS DESIRED_CNT
    FROM DECIDED d
  ),
  N AS (SELECT LEVEL-1 K FROM DUAL CONNECT BY LEVEL <= 12),
  EXP AS (
    SELECT
      w.MEM_ID, w.SUB_ID, w.START_DT, n.K,
      LEAST(
        LAST_DAY(ADD_MONTHS(w.START_DT, n.K)),
        TRUNC(ADD_MONTHS(w.START_DT, n.K),'MM') + (TO_NUMBER(TO_CHAR(w.START_DT,'DD'))-1)
      ) AS PAY_DATE
    FROM DESIRED w
    JOIN N ON n.K < w.DESIRED_CNT
  ),
  CUT AS (
    SELECT
      e.MEM_ID, e.SUB_ID, e.START_DT,
      COUNT(*) AS RECUR_CNT,
      MAX(e.PAY_DATE) AS LAST_PAY_DT
    FROM EXP e
    WHERE e.PAY_DATE <= p_cutoff_date
    GROUP BY e.MEM_ID, e.SUB_ID, e.START_DT
  ),
  -- 같은 MEM_ID가 동일 월(YYYYMM)에 여러 번 들어있어도 1건만 채택
  ONE_PER_MONTH AS (
    SELECT
      c.*,
      TO_CHAR(c.START_DT,'YYYYMM') AS YM,
      ROW_NUMBER() OVER (PARTITION BY c.MEM_ID, TO_CHAR(c.START_DT,'YYYYMM')
                         ORDER BY c.START_DT) AS RN
    FROM CUT c
  )
  SELECT
    MEMBER_SUBSCRIPTION_SEQ.NEXTVAL,
    o.MEM_ID,
    o.SUB_ID,
    o.START_DT,
    ADD_MONTHS(o.START_DT, o.RECUR_CNT) AS END_DT,
    o.LAST_PAY_DT,
    o.RECUR_CNT,
    'userInfo.id_' || o.MEM_ID || p_uid_tag || '_' || o.YM  -- ★ 월 포함 UID
  FROM ONE_PER_MONTH o
  WHERE o.RECUR_CNT > 0
    AND o.RN = 1
    -- ★ DB에 같은 달 구독이 이미 있으면 스킵
    AND NOT EXISTS (
      SELECT 1
      FROM MEMBER_SUBSCRIPTION ms
      WHERE ms.MEM_ID = o.MEM_ID
        AND TRUNC(ms.SUB_START_DT,'MM') = TRUNC(o.START_DT,'MM')
    );

  COMMIT;

  ------------------------------------------------------------------
  -- 2) MEMBER_SUBSCRIPTION 인서트 (중복 가드 한번 더)
  ------------------------------------------------------------------
  INSERT INTO MEMBER_SUBSCRIPTION (
    MS_ID, MEM_ID, SUB_ID, CUSTOMER_UID, SUB_STATUS,
    SUB_START_DT, SUB_END_DT, LAST_PAY_DT,
    RECUR_PAY_CNT, CREATED_DT, UPDATED_DT
  )
  SELECT
    b.MS_ID, b.MEM_ID, b.SUB_ID, b.CUSTOMER_UID, 'N',
    b.START_DT,
    LEAST(b.START_DT + b.RECUR_CNT*30, p_cutoff_date),
    b.LAST_PAY_DT,
    b.RECUR_CNT,
    b.START_DT, b.LAST_PAY_DT
  FROM NEW_SUBS_BUF b
  WHERE NOT EXISTS (
    SELECT 1 FROM MEMBER_SUBSCRIPTION ms
    WHERE ms.MEM_ID = b.MEM_ID
      AND TRUNC(ms.SUB_START_DT,'MM') = TRUNC(b.START_DT,'MM')
  );

  COMMIT;

  ------------------------------------------------------------------
  -- 3) PAYMENT 인서트 (컷오프/중복 가드)
  ------------------------------------------------------------------
  INSERT INTO PAYMENT (
    PAY_ID, PAY_DATE, PAY_AMOUNT,
    PAY_RESUME_CNT, PAY_COVER_CNT, PAY_CONSULT_CNT, PAY_MOCK_CNT,
    MS_ID, IMP_UID, MERCHANT_UID
  )
  WITH EXP AS (
    SELECT
      b.MS_ID, b.MEM_ID, b.SUB_ID, b.RECUR_CNT, b.START_DT,
      LEVEL - 1 AS K,
      ADD_MONTHS(b.START_DT, LEVEL - 1) AS PAY_DT_BASE
    FROM NEW_SUBS_BUF b
    CONNECT BY PRIOR b.MS_ID = b.MS_ID
           AND PRIOR SYS_GUID() IS NOT NULL
           AND LEVEL <= b.RECUR_CNT
  ),
  PAY_ROWS AS (
    SELECT
      e.MS_ID, e.MEM_ID, e.SUB_ID, e.K,
      LEAST(
        LAST_DAY(e.PAY_DT_BASE),
        TRUNC(e.PAY_DT_BASE,'MM') + (TO_NUMBER(TO_CHAR(e.START_DT,'DD'))-1)
      ) AS PAY_DATE
    FROM EXP e
  ),
  JOINED AS (
    SELECT
      p.*,
      s.SUB_PRICE,
      CASE p.SUB_ID WHEN 1 THEN 3 WHEN 2 THEN 6 WHEN 3 THEN 8 END AS RESUME_CNT,
      CASE p.SUB_ID WHEN 1 THEN 3 WHEN 2 THEN 6 WHEN 3 THEN 8 END AS COVER_CNT,
      CASE p.SUB_ID WHEN 1 THEN 3 WHEN 2 THEN 6 WHEN 3 THEN 8 END AS CONSULT_CNT,
      CASE p.SUB_ID WHEN 1 THEN 3 WHEN 2 THEN 6 WHEN 3 THEN 8 END AS MOCK_CNT
    FROM PAY_ROWS p
    JOIN SUBSCRIBE s ON s.SUB_ID = p.SUB_ID
  )
  SELECT
    PAYMENT_SEQ.NEXTVAL,
    j.PAY_DATE,
    j.SUB_PRICE,
    j.RESUME_CNT, j.COVER_CNT, j.CONSULT_CNT, j.MOCK_CNT,
    j.MS_ID,
    'imp_'   || j.MS_ID || '_' || TO_CHAR(j.PAY_DATE,'YYYYMMDD') || '_' || j.K,
    'order_' || j.MEM_ID|| '_' || TO_CHAR(j.PAY_DATE,'YYYYMMDD') || '_' || j.K
  FROM JOINED j
  WHERE j.PAY_DATE <= p_cutoff_date
    AND NOT EXISTS (
      SELECT 1 FROM PAYMENT p2
      WHERE (p2.MS_ID = j.MS_ID AND p2.PAY_DATE = j.PAY_DATE)
         OR p2.IMP_UID = ('imp_'   || j.MS_ID || '_' || TO_CHAR(j.PAY_DATE,'YYYYMMDD') || '_' || j.K)
         OR p2.MERCHANT_UID = ('order_' || j.MEM_ID|| '_' || TO_CHAR(j.PAY_DATE,'YYYYMMDD') || '_' || j.K)
    );

  COMMIT;
END;
/
-- 같은 세션에서 NEW_SUB_MEMBERS 채워서 COMMIT 후 실행
BEGIN
  GEN_NEW_SIGNUPS_2025(p_uid_tag => '_sim_new');  -- UID에 YYYYMM 포함되어 월당 1건 보장
END;
/

DECLARE
  v_add_jun NUMBER := 8;   -- 6월 추가 구독 수
  v_add_jul NUMBER := 12;  -- 7월 추가 구독 수
  v_add_aug NUMBER := 20;  -- 8월 추가 구독 수
BEGIN
  -- 1) 이번 증설용 입력 버퍼 채우기 (같은 세션!)
  EXECUTE IMMEDIATE 'TRUNCATE TABLE NEW_SUB_MEMBERS';

  -- 6월: 6월 가입자 중 6월 구독 없는 사람 랜덤 선별
  INSERT INTO NEW_SUB_MEMBERS (MONTH_KEY, MEM_ID)
  SELECT '06', mem_id
  FROM (
    SELECT m.mem_id
    FROM MEMBER m
    WHERE TRUNC(m.CREATED_AT,'MM') = DATE '2025-06-01'
      AND NOT EXISTS (
            SELECT 1 FROM MEMBER_SUBSCRIPTION ms
            WHERE ms.MEM_ID = m.MEM_ID
              AND TRUNC(ms.SUB_START_DT,'MM') = DATE '2025-06-01'
          )
    ORDER BY DBMS_RANDOM.VALUE
  )
  WHERE ROWNUM <= v_add_jun;

  -- 7월
  INSERT INTO NEW_SUB_MEMBERS (MONTH_KEY, MEM_ID)
  SELECT '07', mem_id
  FROM (
    SELECT m.mem_id
    FROM MEMBER m
    WHERE TRUNC(m.CREATED_AT,'MM') = DATE '2025-07-01'
      AND NOT EXISTS (
            SELECT 1 FROM MEMBER_SUBSCRIPTION ms
            WHERE ms.MEM_ID = m.MEM_ID
              AND TRUNC(ms.SUB_START_DT,'MM') = DATE '2025-07-01'
          )
    ORDER BY DBMS_RANDOM.VALUE
  )
  WHERE ROWNUM <= v_add_jul;

  -- 8월
  INSERT INTO NEW_SUB_MEMBERS (MONTH_KEY, MEM_ID)
  SELECT '08', mem_id
  FROM (
    SELECT m.mem_id
    FROM MEMBER m
    WHERE TRUNC(m.CREATED_AT,'MM') = DATE '2025-08-01'
      AND NOT EXISTS (
            SELECT 1 FROM MEMBER_SUBSCRIPTION ms
            WHERE ms.MEM_ID = m.MEM_ID
              AND TRUNC(ms.SUB_START_DT,'MM') = DATE '2025-08-01'
          )
    ORDER BY DBMS_RANDOM.VALUE
  )
  WHERE ROWNUM <= v_add_aug;

  COMMIT;

  -- 2) 구독/결제 생성 (태그로 구분)
  GEN_NEW_SIGNUPS_2025(
    p_uid_tag   => '_sim_topup_678',   -- 접미사만 바꾸면 재실행도 안전
    p_min_recur => 3,
    p_max_recur => 6
  );
END;
/
