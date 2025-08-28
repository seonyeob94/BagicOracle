20250703-

--ī�����̽� ����

SELECT COLUMN_NAME
, DATA_TYPE
, CASE WHEN DATA_TYPE='NUMBER' THEN 'private int ' || FN_GETCAMEL(COLUMN_NAME) || ';'
WHEN DATA_TYPE IN('VARCHAR2','CHAR') THEN 'private String ' || FN_GETCAMEL(COLUMN_NAME) || ';'
WHEN DATA_TYPE='DATE' THEN 'private Date ' || FN_GETCAMEL(COLUMN_NAME) || ';'
ELSE 'private String ' || FN_GETCAMEL(COLUMN_NAME) || ';'
END AS CAMEL_CASE
, '<result property="'||FN_GETCAMEL(COLUMN_NAME)||'" column="'||COLUMN_NAME||'"/>' RESULTMAP
, '#{' || FN_GETCAMEL(COLUMN_NAME) || '},'
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'HIGH_SCHOOL'
AND    OWNER = 'JSPEXAM';


/

SELECT A.NUM
     , A.TITLE
     , A.WRITER
     , (SELECT B.NAME FROM TBL_USERS B WHERE B.EMAIL = A.WRITER) NAME
     , (
            SELECT C.FILE_SAVE_LOCATE FROM FILE_DETAIL C 
            WHERE  C.FILE_GROUP_NO = (
                    SELECT D.FILE_GROUP_NO FROM TBL_USERS D WHERE D.EMAIL = A.WRITER
                )
        ) FILE_SAVE_LOCATE
     , PARENT_NUM
FROM   TEST_BOARD A
WHERE NUM = 11

;

SELECT A.NUM
     , LPAD('��',2*(LEVEL-1)) || TITLE
     , A.WRITER
     , (SELECT B.NAME FROM TBL_USERS B WHERE B.EMAIL = A.WRITER) NAME
     , (
            SELECT C.FILE_SAVE_LOCATE FROM FILE_DETAIL C 
            WHERE  C.FILE_GROUP_NO = (
                    SELECT D.FILE_GROUP_NO FROM TBL_USERS D WHERE D.EMAIL = A.WRITER
                )
        ) FILE_SAVE_LOCATE
     , PARENT_NUM, LEVEL
FROM   TEST_BOARD A
START WITH A.PARENT_NUM IS NULL AND NUM = 11
CONNECT BY PRIOR A.NUM = A.PARENT_NUM
;

--DD(����)L : ALTER / CEREATE / DROP
--ALTER �ɼ� : ADD / MODIFY / DROP
ALTER TABLE TEST_BOARD
ADD LIKE_CNT NUMBER;

--���� Ȯ��
DESC TEST_BOARD;


/

CREATE TABLE MEMBER (
    SEQ     NUMBER(10)      NOT NULL,    -- ȸ�� �Ϸù�ȣ (PK)
    MEM_ID      VARCHAR2(20)    PRIMARY KEY, -- ȸ�� ID (�����ϸ� NULL �Ұ�)
    MEM_NAME    VARCHAR2(50)    NOT NULL,       -- ȸ�� �̸�
    MEM_PHONE   VARCHAR2(20),                   -- ȸ�� ��ȭ��ȣ (���� ����)
    MEM_LOC     VARCHAR2(100)                   -- ȸ�� ���� ���� (���� ����)
);
    
DROP TABLE CAR;

CREATE TABLE CAR (
    SEQ         NUMBER(10)      PRIMARY KEY,    -- ���� �Ϸù�ȣ (PK)
    CAR_ID      VARCHAR2(10)    NOT NULL,       -- ���� ���̵�
    MEM_ID      VARCHAR2(20)    NOT NULL,       -- ���� ȸ�� ID (FK)
    CAR_NM    VARCHAR2(50)      NOT NULL,       -- ���� ������/�𵨸�
    CONSTRAINT FK_MEM_ID FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID)
);


    
/

SELECT A.ID, A.EMAIL, A.PASSWORD, A.CREATED_AT, A.UPDATED_AT
     , A.NAME
     , A.IMG_URL
     , (SELECT C.FILE_SAVE_LOCATE FROM FILE_DETAIL C WHERE C.FILE_GROUP_NO=A.FILE_GROUP_NO) IMG_URL
     , B.AUTH
     , A.FILE_GROUP_NO
FROM   TBL_USERS A INNER JOIN TBL_USERS_AUTH B
ON(A.EMAIL = B.EMAIL)
WHERE  A.EMAIL = 'test@test.com';

SELECT FILE_SAVE_LOCATE FROM FILE_DETAIL WHERE FILE_GROUP_NO=""

SELECT *
FROM BOOK
WHERE INSERT_DATE LIKE '2025/05%';

SELECT *
FROM TEST_BOARD;


///

SELECT S.MON || '��' MON
     , COUNT(EMPLOYEE_ID) CNT
FROM
(
    SELECT LEVEL MON
    FROM   DUAL C
    CONNECT BY LEVEL <= 12
) S LEFT OUTER JOIN
(
    SELECT A.EMPLOYEE_ID
         , TO_CHAR(HIRE_DATE,'MM')+0 MON
    FROM   EMP A
    WHERE  SUBSTR(A.HIRE_DATE,1,4) IN (2020,2021)
) T
ON(S.MON = T.MON)
GROUP BY S.MON
ORDER BY S.MON;

SELECT 
    HS.HS_ID
  , HS.HS_CODE AS "�б��ڵ�"
  , HS.HS_NAME AS "�б���"
  , REGION.CC_NAME AS "�õ���" --�ڵ�
  , JURIS.CC_ETC AS "���� ����û �ڵ�" --�ڵ�
  , FOUND.CC_NAME AS "��������" --�ڵ�
  , HS.HS_ZIPCODE AS "�����ȣ"
  , HS.HS_ADDR AS "�⺻�ּ�"
  , HS.HS_TEL AS "��ȭ��ȣ"
  , HS.HS_HOMEPAGE AS "Ȩ������ URL"
  , COEDU.CC_NAME AS "������� ����" --�ڵ�
  , TYPE.CC_NAME AS "�б� ����" --�ڵ�
  , GENERAL.CC_NAME AS "�Ϲݰ�/������" --�ڵ�
  , HS.HS_FOUND_DATE AS "��������"
  , HS.HS_ANNIV_AT AS "���������"
  , HS.HS_LAT AS "����"
  , HS.HS_LOT AS "�浵"
FROM 
    HIGH_SCHOOL HS
LEFT JOIN
    COM_CODE REGION  
    ON HS.HS_REGION_CODE = REGION.CC_ID 
    AND REGION.CL_CODE = 'G23' 
LEFT JOIN
    COM_CODE JURIS  
    ON HS.HS_JURIS_CODE = JURIS.CC_ID 
    AND JURIS.CL_CODE = 'G22' 
LEFT JOIN
    COM_CODE FOUND  
    ON HS.HS_FOUND_TYPE = FOUND.CC_ID 
    AND FOUND.CL_CODE = 'G21' 
LEFT JOIN
    COM_CODE COEDU  
    ON HS.HS_COEDU_TYPE = COEDU.CC_ID 
    AND COEDU.CL_CODE = 'G24' 
LEFT JOIN
    COM_CODE TYPE  
    ON HS.HS_TYPE_NAME = TYPE.CC_ID 
    AND TYPE.CL_CODE = 'G25' 
LEFT JOIN
    COM_CODE GENERAL  
    ON HS.HS_GENERAL_TYPE = GENERAL.CC_ID 
    AND GENERAL.CL_CODE = 'G26' 
    
    

--����б� �а� ���̺� ����б� �� : 499
SELECT COUNT(DISTINCT HS_ID)
FROM HIGH_SCHOOL_DEPT

--����б� �а� ���̺� ��� : 2786
SELECT COUNT(*)
FROM HIGH_SCHOOL_DEPT

--����б� ���̺� ��� : 2395
SELECT COUNT(HS_ID)
FROM HIGH_SCHOOL

/
SELECT HS_NAME, COUNT(*) AS CNT
FROM HIGH_SCHOOL
GROUP BY HS_NAME
HAVING COUNT(*)>1
ORDER BY 2 DESC;
/
SELECT
    HSD.HSD_ID,
    HSD.HS_ID,
    HS.HS_NAME AS �б���,
    HSD.HSD_CODE,        -- �а� �ڵ� (G27���� �����ϴ� CC_ID)
    CC_MAJOR.CC_NAME AS �а���, -- �а��� (COM_CODE���� ������)
    HSD.HSD_TRACK_NAME AS HSD_TRACK_CODE, -- �迭 �ڵ� (G31�� �����ϴ� CC_ID)
    CC_TRACK.CC_NAME AS �迭�� -- �迭�� (COM_CODE���� ������)
FROM
    HIGH_SCHOOL_DEPT HSD
JOIN
    COM_CODE CC_MAJOR ON HSD.HSD_CODE = CC_MAJOR.CC_ID
JOIN
    COM_CODE CC_TRACK ON HSD.HSD_TRACK_NAME = CC_TRACK.CC_ID
JOIN
    HIGH_SCHOOL HS ON HS.HS_ID=HSD.HS_ID
ORDER BY
    HSD.HS_ID, CC_MAJOR.CC_NAME;
/

commit;

UPDATE COM_CODE
SET CREATED_BY = 'LSY',
    UPDATED_BY = 'LSY';
    
--CONTEST_SEQ ������ ����
CREATE SEQUENCE CONTEST_SEQ
   START WITH 1      -- 1���� ���� (���ϴ� ���۰����� ���� ����)
   INCREMENT BY 1    -- 1�� ����
   NOMAXVALUE        -- �ִ밪 ����
   NOCYCLE           -- �ݺ����� ����
   CACHE 20;         -- ĳ�� ũ�� (���� ���, �⺻�� 20)
       
-- FILE_GROUP_SEQ ������ ����
CREATE SEQUENCE FILE_GROUP_SEQ
       START WITH 1         -- 1���� ���� (���۰��� ���ϴ� ��� ���� ����)
       INCREMENT BY 1       -- 1�� ����
       NOMAXVALUE           -- �ִ밪 ����
       NOCYCLE              -- �ݺ����� ���� (������ ���� �ٽ� �������� ����)
       CACHE 20;            -- ĳ�� ũ�� (���� ����� ����, �⺻�� 20)

-- FILE_DETAIL_SEQ ������ ����
CREATE SEQUENCE FILE_DETAIL_SEQ
       START WITH 1
       INCREMENT BY 1
       NOMAXVALUE
       NOCYCLE
       CACHE 20;
-------------------------------------------------

DROP SEQUENCE PAYMENT_SEQ;
DROP SEQUENCE MEMBER_SUBSCRIPTION_SEQ;

-- PAYMENT_SEQ ������ ����
CREATE SEQUENCE PAYMENT_SEQ
       START WITH 860
       INCREMENT BY 1
       NOMAXVALUE
       NOCYCLE
       CACHE 20;

-- MEMBER_SUBSCRIPTION_SEQ ������ ����
CREATE SEQUENCE MEMBER_SUBSCRIPTION_SEQ
       START WITH 610
       INCREMENT BY 1
       NOMAXVALUE
       NOCYCLE
       CACHE 20;