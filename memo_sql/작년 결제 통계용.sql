--------------------------------------------------------------------------------
-- 0) ���⵵(2024-01-01 ~ 2024-09-03) ���� �����͸� ����(2025) ������ ������� ����
--    - ��¥: PAY_DATE/�����Ⱓ -12���� + ���� ����(����)
--    - �ݾ�/ī��Ʈ: ���� ������(���غ��� ���������� ����, �� ���� ����) + ����
--    - �ߺ� ����: ���� ��UID(_ly) / MERCHANT_UID(LY_)�� ������ ��ŵ
--    - �ܷ�Ű: ���� MS_ID �� ���� �ű� MS_ID�� �����Ͽ� ������ ����
--------------------------------------------------------------------------------

-- (����) ���� ���� �� �ӽ� ���� ���̺�
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
-- 1) ���� ������ ������ �����Ǹ� ��� ����(���⵵�� �ű� MS_ID �̸� �Ҵ�)
--------------------------------------------------------------------------------
-- 0) �ӽ� ���� ���̺� �ʱ�ȭ (�̹� �ִٸ�)
TRUNCATE TABLE TEMP_MS_MAP;

-- 1) ���� ����: DISTINCT�� ����, NEXTVAL�� �ٱ�
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
-- 2) ���⵵�� MEMBER_SUBSCRIPTION ����
--    * ��¥ -12����, RECUR_PAY_CNT�� 0.7��0.2 �� ������ ���� (�ּ� 1)
--    * CUSTOMER_UID�� "_ly" ���̻� �ο� (�ߺ� ����)
--    * �̹� ���� CUSTOMER_UID(_ly)�� ������ ��ŵ
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
-- 3) ���⵵�� PAYMENT ����
--    * ����: ���� ���� �� -12���� + (-5~+5��) ���� �̵�
--    * ��� ��¥�� 2024-01-01 ~ 2024-09-03 ������ ����
--    * �ݾ�: ���� ������ * (��8% ����), 100�� ���� �ݿø�
--    * ī��Ʈ: ���� ������ * (��12% ����), ���� ����
--    * MS_ID: TEMP_MS_MAP���� ���⵵ MS_ID ����
--    * IMP_UID: ���� + '_ly', MERCHANT_UID: 'LY_' || ���� (�ߺ� ����)
--------------------------------------------------------------------------------
INSERT INTO PAYMENT (
  PAY_ID, PAY_DATE, PAY_AMOUNT,
  PAY_RESUME_CNT, PAY_COVER_CNT, PAY_CONSULT_CNT, PAY_MOCK_CNT,
  MS_ID, IMP_UID, MERCHANT_UID
)
SELECT
  PAYMENT_SEQ.NEXTVAL,
  x.SHIFTED_DATE,
  -- �ݾ�: ���� ������ * (��8%) �� 100�� ���� �ݿø�
  ROUND(x.PAY_AMOUNT * x.AMT_FACTOR / 100) * 100,
  -- ī��Ʈ: ���� ������ * (��12%) �� 0 �̸� ����
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
    -- ���⵵ ��¥�� �̵� + ���� ����(-5~+5��)
    (ADD_MONTHS(p.PAY_DATE, -12) + ROUND(DBMS_RANDOM.VALUE(-5, 5))) AS SHIFTED_DATE,

    -- *** ���� ������(���������� 2024���� �۰�, �� ���� ũ��) ***
    -- ī��Ʈ ������(��12% ���� ����)
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

    -- �ݾ� ������(��8% ���� ����) ? 8���� ��¦ ũ��, ������ �۰�
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
  -- �̹� ������ ���⵵ ������ ������ �ߺ� ����
  AND NOT EXISTS (
    SELECT 1 FROM PAYMENT p2
    WHERE p2.MERCHANT_UID = 'LY_' || x.MERCHANT_UID
  );

COMMIT;

--------------------------------------------------------------------------------
-- (����) �ӽ� ���� ���̺� ����
--------------------------------------------------------------------------------
TRUNCATE TABLE TEMP_MS_MAP;
-- DROP TABLE TEMP_MS_MAP PURGE;  -- �ʿ��ϸ� ���
