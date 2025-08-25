--------------------------------------------------------------------------------
-- 0) 전년도(2024-01-01 ~ 2024-09-03) 샘플 데이터를 올해(2025) 데이터 기반으로 생성
--    - 날짜: PAY_DATE/구독기간 -12개월 + 소폭 랜덤(결제)
--    - 금액/카운트: 월별 스케일(올해보다 전반적으로 적게, 몇 달은 많게) + 랜덤
--    - 중복 방지: 동일 고객UID(_ly) / MERCHANT_UID(LY_)가 있으면 스킵
--    - 외래키: 올해 MS_ID → 전년 신규 MS_ID로 매핑하여 결제에 연결
--------------------------------------------------------------------------------

-- (선택) 동일 세션 내 임시 매핑 테이블
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE TEMP_MS_MAP PURGE';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE GLOBAL TEMPORARY TABLE TEMP_MS_MAP (
  OLD_MS_ID NUMBER PRIMARY KEY,
  NEW_MS_ID NUMBER NOT NULL
) ON COMMIT PRESERVE ROWS;

--------------------------------------------------------------------------------
-- 1) 올해 결제에 등장한 구독건만 대상 매핑(전년도용 신규 MS_ID 미리 할당)
--------------------------------------------------------------------------------
-- 0) 임시 매핑 테이블 초기화 (이미 있다면)
TRUNCATE TABLE TEMP_MS_MAP;

-- 1) 매핑 생성: DISTINCT는 안쪽, NEXTVAL은 바깥
INSERT INTO TEMP_MS_MAP (OLD_MS_ID, NEW_MS_ID)
SELECT
  t.MS_ID,
  MEMBER_SUBSCRIPTION_SEQ.NEXTVAL
FROM (
  SELECT DISTINCT p.MS_ID
  FROM PAYMENT p
  WHERE p.PAY_DATE BETWEEN DATE '2025-01-01' AND DATE '2025-12-31'
) t;

COMMIT;

--------------------------------------------------------------------------------
-- 2) 전년도용 MEMBER_SUBSCRIPTION 생성
--    * 날짜 -12개월, RECUR_PAY_CNT는 0.7±0.2 배 정도로 조정 (최소 1)
--    * CUSTOMER_UID에 "_ly" 접미사 부여 (중복 방지)
--    * 이미 같은 CUSTOMER_UID(_ly)가 있으면 스킵
--------------------------------------------------------------------------------
INSERT INTO MEMBER_SUBSCRIPTION (
  MS_ID, MEM_ID, SUB_ID, CUSTOMER_UID, SUB_STATUS,
  SUB_START_DT, SUB_END_DT, LAST_PAY_DT,
  RECUR_PAY_CNT, CREATED_DT, UPDATED_DT
)
SELECT
  m.NEW_MS_ID,
  ms.MEM_ID,
  ms.SUB_ID,
  ms.CUSTOMER_UID || '_ly',
  'N',
  ADD_MONTHS(ms.SUB_START_DT, -12),
  ADD_MONTHS(ms.SUB_END_DT,   -12),
  CASE WHEN ms.LAST_PAY_DT IS NULL THEN NULL ELSE ADD_MONTHS(ms.LAST_PAY_DT, -12) END,
  GREATEST(1, ROUND(ms.RECUR_PAY_CNT * (0.7 + DBMS_RANDOM.VALUE(-0.2, 0.2)))),
  ADD_MONTHS(ms.CREATED_DT, -12),
  ADD_MONTHS(ms.UPDATED_DT, -12)
FROM MEMBER_SUBSCRIPTION ms
JOIN TEMP_MS_MAP m ON m.OLD_MS_ID = ms.MS_ID
WHERE NOT EXISTS (
  SELECT 1
  FROM MEMBER_SUBSCRIPTION ms2
  WHERE ms2.CUSTOMER_UID = ms.CUSTOMER_UID || '_ly'
);

COMMIT;

--------------------------------------------------------------------------------
-- 3) 전년도용 PAYMENT 생성
--    * 기준: 올해 결제 → -12개월 + (-5~+5일) 랜덤 이동
--    * 결과 날짜가 2024-01-01 ~ 2024-09-03 범위만 삽입
--    * 금액: 월별 스케일 * (±8% 랜덤), 100원 단위 반올림
--    * 카운트: 월별 스케일 * (±12% 랜덤), 음수 방지
--    * MS_ID: TEMP_MS_MAP으로 전년도 MS_ID 연결
--    * IMP_UID: 원본 + '_ly', MERCHANT_UID: 'LY_' || 원본 (중복 방지)
--------------------------------------------------------------------------------
INSERT INTO PAYMENT (
  PAY_ID, PAY_DATE, PAY_AMOUNT,
  PAY_RESUME_CNT, PAY_COVER_CNT, PAY_CONSULT_CNT, PAY_MOCK_CNT,
  MS_ID, IMP_UID, MERCHANT_UID
)
SELECT
  PAYMENT_SEQ.NEXTVAL,
  x.SHIFTED_DATE,
  -- 금액: 월별 스케일 * (±8%) → 100원 단위 반올림
  ROUND(x.PAY_AMOUNT * x.AMT_FACTOR / 100) * 100,
  -- 카운트: 월별 스케일 * (±12%) → 0 미만 방지
  GREATEST(0, ROUND(x.PAY_RESUME_CNT  * x.CNT_FACTOR)),
  GREATEST(0, ROUND(x.PAY_COVER_CNT   * x.CNT_FACTOR)),
  GREATEST(0, ROUND(x.PAY_CONSULT_CNT * x.CNT_FACTOR)),
  GREATEST(0, ROUND(x.PAY_MOCK_CNT    * x.CNT_FACTOR)),
  m.NEW_MS_ID,
  x.IMP_UID || '_ly',
  'LY_' || x.MERCHANT_UID
FROM (
  SELECT
    p.*,
    -- 전년도 날짜로 이동 + 소폭 랜덤(-5~+5일)
    (ADD_MONTHS(p.PAY_DATE, -12) + ROUND(DBMS_RANDOM.VALUE(-5, 5))) AS SHIFTED_DATE,

    -- *** 월별 스케일(전반적으로 2024년이 작게, 몇 달은 크게) ***
    -- 카운트 스케일(±12% 랜덤 포함)
    (
      CASE TO_CHAR(ADD_MONTHS(p.PAY_DATE, -12), 'MM')
        WHEN '01' THEN 0.60
        WHEN '02' THEN 0.60
        WHEN '03' THEN 1.15
        WHEN '04' THEN 0.80
        WHEN '05' THEN 1.30
        WHEN '06' THEN 0.45
        WHEN '07' THEN 0.55
        WHEN '08' THEN 1.28   
        WHEN '09' THEN 0.78
        ELSE 0.85
      END
    ) * (1 + DBMS_RANDOM.VALUE(-0.12, 0.12)) AS CNT_FACTOR,

    -- 금액 스케일(±8% 랜덤 포함) ? 8월만 살짝 크게, 나머진 작게
    (
      CASE TO_CHAR(ADD_MONTHS(p.PAY_DATE, -12), 'MM')
        WHEN '01' THEN 0.60
        WHEN '02' THEN 0.60
        WHEN '03' THEN 1.15
        WHEN '04' THEN 0.80
        WHEN '05' THEN 1.30
        WHEN '06' THEN 0.45
        WHEN '07' THEN 0.55
        WHEN '08' THEN 1.28   
        WHEN '09' THEN 0.78
        ELSE 0.85
      END
    ) * (1 + DBMS_RANDOM.VALUE(-0.08, 0.08)) AS AMT_FACTOR
  FROM PAYMENT p
  WHERE p.PAY_DATE BETWEEN DATE '2025-01-01' AND DATE '2025-12-31'
) x
JOIN TEMP_MS_MAP m ON m.OLD_MS_ID = x.MS_ID
WHERE x.SHIFTED_DATE BETWEEN DATE '2024-01-01' AND DATE '2024-09-03'
  -- 이미 만들어둔 전년도 결제가 있으면 중복 방지
  AND NOT EXISTS (
    SELECT 1 FROM PAYMENT p2
    WHERE p2.MERCHANT_UID = 'LY_' || x.MERCHANT_UID
  );

COMMIT;

--------------------------------------------------------------------------------
-- (선택) 임시 매핑 테이블 정리
--------------------------------------------------------------------------------
TRUNCATE TABLE TEMP_MS_MAP;
-- DROP TABLE TEMP_MS_MAP PURGE;  -- 필요하면 드롭
