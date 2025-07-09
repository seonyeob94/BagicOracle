20250703-

--카멜케이스 생성

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
     , LPAD('ㄴ',2*(LEVEL-1)) || TITLE
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

--DD(정의)L : ALTER / CEREATE / DROP
--ALTER 옵션 : ADD / MODIFY / DROP
ALTER TABLE TEST_BOARD
ADD LIKE_CNT NUMBER;

--구조 확인
DESC TEST_BOARD;


/

CREATE TABLE MEMBER (
    SEQ     NUMBER(10)      NOT NULL,    -- 회원 일련번호 (PK)
    MEM_ID      VARCHAR2(20)    PRIMARY KEY, -- 회원 ID (고유하며 NULL 불가)
    MEM_NAME    VARCHAR2(50)    NOT NULL,       -- 회원 이름
    MEM_PHONE   VARCHAR2(20),                   -- 회원 전화번호 (선택 사항)
    MEM_LOC     VARCHAR2(100)                   -- 회원 거주 지역 (선택 사항)
);
    
DROP TABLE CAR;

CREATE TABLE CAR (
    SEQ         NUMBER(10)      PRIMARY KEY,    -- 차량 일련번호 (PK)
    CAR_ID      VARCHAR2(10)    NOT NULL,       -- 차량 아이디
    MEM_ID      VARCHAR2(20)    NOT NULL,       -- 소유 회원 ID (FK)
    CAR_NM    VARCHAR2(50)      NOT NULL,       -- 차량 제조사/모델명
    CONSTRAINT FK_MEM_ID FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID)
);


    
/














