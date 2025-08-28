--------------------------------------------------------------------------------
-- 전년도 데이터 생성 프로시저 (TEAM1_202502F 계정 전용)
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE GEN_LAST_YEAR_DATA (
  p_2025_start   IN DATE DEFAULT DATE '2025-01-01',
  p_2025_end     IN DATE DEFAULT DATE '2025-09-03',
  p_2024_start   IN DATE DEFAULT DATE '2024-01-01',
  p_2024_end     IN DATE DEFAULT DATE '2024-09-03',
  p_jitter_days  IN NUMBER DEFAULT 20   -- PAYMENT 날짜 지터(±p_jitter_days)
) AS
BEGIN
  ------------------------------------------------------------------------------
  -- 0) 보조 테이블 초기화
  ------------------------------------------------------------------------------
  EXECUTE IMMEDIATE 'TRUNCATE TABLE TEMP_MS_MAP';
  EXECUTE IMMEDIATE 'TRUNCATE TABLE MONTHLY_TARGET';

  ------------------------------------------------------------------------------
  -- 1) 월별 목표 구독자 비율 값 삽입 (예시 값)
  ------------------------------------------------------------------------------
  INSERT INTO MONTHLY_TARGET (MONTH_KEY, RATIO)
  SELECT '01',0.8 FROM DUAL UNION ALL
  SELECT '02',0.7 FROM DUAL UNION ALL
  SELECT '03',1.2 FROM DUAL UNION ALL
  SELECT '04',0.9 FROM DUAL UNION ALL
  SELECT '05',1.3 FROM DUAL UNION ALL
  SELECT '06',0.7 FROM DUAL UNION ALL
  SELECT '07',0.8 FROM DUAL UNION ALL
  SELECT '08',1.4 FROM DUAL UNION ALL
  SELECT '09',0.9 FROM DUAL;

  ------------------------------------------------------------------------------
  -- 2) 올해 결제 등장 MS_ID → 신규 전년도 MS_ID 매핑
  ------------------------------------------------------------------------------
  INSERT INTO TEMP_MS_MAP (OLD_MS_ID, NEW_MS_ID)
  SELECT t.MS_ID, MEMBER_SUBSCRIPTION_SEQ.NEXTVAL
  FROM (
    SELECT DISTINCT p.MS_ID
    FROM PAYMENT p
    WHERE p.PAY_DATE BETWEEN p_2025_start AND p_2025_end
  ) t;

  COMMIT;

  ------------------------------------------------------------------------------
  -- 3) 전년도 MEMBER_SUBSCRIPTION 생성 (월별 목표비율 반영)
  ------------------------------------------------------------------------------
  INSERT INTO MEMBER_SUBSCRIPTION (
    MS_ID, MEM_ID, SUB_ID, CUSTOMER_UID, SUB_STATUS,
    SUB_START_DT, SUB_END_DT, LAST_PAY_DT,
    RECUR_PAY_CNT, CREATED_DT, UPDATED_DT
  )
  WITH BASE AS (
    SELECT
      m.NEW_MS_ID,
      ms.MEM_ID,
      ms.SUB_ID,
      ms.CUSTOMER_UID,
      ms.SUB_STATUS,
      ADD_MONTHS(ms.SUB_START_DT, -12) AS BASE_START,
      ADD_MONTHS(ms.SUB_END_DT,   -12) AS BASE_END,
      ADD_MONTHS(ms.LAST_PAY_DT,  -12) AS BASE_LAST,
      ADD_MONTHS(ms.CREATED_DT,   -12) AS BASE_CREATED,
      ADD_MONTHS(ms.UPDATED_DT,   -12) AS BASE_UPDATED,
      (ms.SUB_END_DT - ms.SUB_START_DT) AS DURATION_DAYS,
      ( SELECT COUNT(*)
          FROM PAYMENT p2025
         WHERE p2025.MS_ID = ms.MS_ID
           AND p2025.PAY_DATE BETWEEN p_2025_start AND p_2025_end
      ) AS TARGET_CNT
    FROM MEMBER_SUBSCRIPTION ms
    JOIN TEMP_MS_MAP m ON m.OLD_MS_ID = ms.MS_ID
    WHERE NOT EXISTS (
      SELECT 1 FROM MEMBER_SUBSCRIPTION ms2
      WHERE ms2.CUSTOMER_UID = ms.CUSTOMER_UID || '_ly'
    )
  ),
  WITH_RATIO AS (
    SELECT
      b.*,
      mt.RATIO,
      TO_CHAR(b.BASE_START,'MM') AS MM
    FROM BASE b
    JOIN MONTHLY_TARGET mt ON mt.MONTH_KEY = TO_CHAR(b.BASE_START,'MM')
  ),
  SHIFTED AS (
    SELECT
      w.*,
      CASE
        WHEN DBMS_RANDOM.VALUE(0,1) < (w.RATIO - 1) AND w.RATIO > 1
          THEN +1
        WHEN DBMS_RANDOM.VALUE(0,1) < (1 - w.RATIO) AND w.RATIO < 1
          THEN -1
        ELSE 0
      END AS MONTH_DELTA,
      TRUNC(DBMS_RANDOM.VALUE(-10, 11)) AS JIT_DAYS
    FROM WITH_RATIO w
  )
  SELECT
    NEW_MS_ID,
    MEM_ID,
    SUB_ID,
    CUSTOMER_UID || '_ly',
    'N',
    ADD_MONTHS(BASE_START, MONTH_DELTA) + JIT_DAYS,
    ADD_MONTHS(BASE_START, MONTH_DELTA) + JIT_DAYS + DURATION_DAYS,
    CASE WHEN BASE_LAST IS NULL THEN NULL
         ELSE ADD_MONTHS(BASE_LAST, MONTH_DELTA) + JIT_DAYS END,
    TARGET_CNT,
    ADD_MONTHS(BASE_CREATED, MONTH_DELTA) + JIT_DAYS,
    ADD_MONTHS(BASE_UPDATED, MONTH_DELTA) + JIT_DAYS
  FROM SHIFTED;

  COMMIT;

  ------------------------------------------------------------------------------
  -- 4) 전년도 PAYMENT 생성 (가격 고정 + 지터 + 개수 일치)
  ------------------------------------------------------------------------------
  INSERT INTO PAYMENT (
    PAY_ID, PAY_DATE, PAY_AMOUNT,
    PAY_RESUME_CNT, PAY_COVER_CNT, PAY_CONSULT_CNT, PAY_MOCK_CNT,
    MS_ID, IMP_UID, MERCHANT_UID
  )
  WITH BASE AS (
    SELECT
      p.PAY_ID,
      p.MS_ID AS OLD_MS_ID,
      ADD_MONTHS(p.PAY_DATE, -12) AS BASE_DATE,
      p.IMP_UID,
      p.MERCHANT_UID
    FROM PAYMENT p
    WHERE p.PAY_DATE BETWEEN p_2025_start AND p_2025_end
  ),
  RAND_DATE AS (
    SELECT
      b.*,
      b.BASE_DATE + TRUNC(DBMS_RANDOM.VALUE(-p_jitter_days, p_jitter_days+1)) AS SHIFTED_RAW
    FROM BASE b
  ),
  CLAMPED AS (
    SELECT
      r.*,
      CASE
        WHEN r.SHIFTED_RAW <  p_2024_start THEN p_2024_start
        WHEN r.SHIFTED_RAW >  p_2024_end   THEN p_2024_end
        ELSE r.SHIFTED_RAW
      END AS SHIFTED_DATE
    FROM RAND_DATE r
  ),
  JOINED AS (
    SELECT
      c.*,
      m.NEW_MS_ID,
      nm.SUB_ID,
      nm.RECUR_PAY_CNT,
      s.SUB_PRICE,
      CASE s.SUB_ID WHEN 1 THEN 3 WHEN 2 THEN 6 WHEN 3 THEN 8 END AS RESUME_CNT_PER_PAY,
      CASE s.SUB_ID WHEN 1 THEN 3 WHEN 2 THEN 6 WHEN 3 THEN 8 END AS COVER_CNT_PER_PAY,
      CASE s.SUB_ID WHEN 1 THEN 3 WHEN 2 THEN 6 WHEN 3 THEN 8 END AS CONSULT_CNT_PER_PAY,
      CASE s.SUB_ID WHEN 1 THEN 3 WHEN 2 THEN 6 WHEN 3 THEN 8 END AS MOCK_CNT_PER_PAY,
      ROW_NUMBER() OVER (PARTITION BY m.NEW_MS_ID ORDER BY c.SHIFTED_DATE, c.PAY_ID) AS RN
    FROM CLAMPED c
    JOIN TEMP_MS_MAP m          ON m.OLD_MS_ID = c.OLD_MS_ID
    JOIN MEMBER_SUBSCRIPTION nm ON nm.MS_ID     = m.NEW_MS_ID
    JOIN SUBSCRIBE s            ON s.SUB_ID    = nm.SUB_ID
    WHERE c.SHIFTED_DATE BETWEEN p_2024_start AND p_2024_end
  )
  SELECT
    PAYMENT_SEQ.NEXTVAL,
    j.SHIFTED_DATE,
    j.SUB_PRICE,
    j.RESUME_CNT_PER_PAY,
    j.COVER_CNT_PER_PAY,
    j.CONSULT_CNT_PER_PAY,
    j.MOCK_CNT_PER_PAY,
    j.NEW_MS_ID,
    j.IMP_UID || '_ly',
    'LY_' || j.MERCHANT_UID
  FROM JOINED j
  WHERE j.RN <= j.RECUR_PAY_CNT
    AND NOT EXISTS (
          SELECT 1 FROM PAYMENT p2
           WHERE p2.MERCHANT_UID = 'LY_' || j.MERCHANT_UID
              OR p2.IMP_UID      = j.IMP_UID || '_ly'
        );

  COMMIT;
END;
/
BEGIN
  GEN_LAST_YEAR_DATA;
END;
/


select *
from payment
where PAY_DATE like '2024%'

select *
from MEMBER_SUBSCRIPTION
where SUB_START_DT like '2024%'

delete 
from payment
where PAY_DATE like '2024%';


delete 
from MEMBER_SUBSCRIPTION
where SUB_START_DT like '2024%';

commit;