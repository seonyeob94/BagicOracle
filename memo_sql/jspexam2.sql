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
WHERE TABLE_NAME = 'CAR'
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














