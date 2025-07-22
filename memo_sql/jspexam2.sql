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

SELECT S.MON || '월' MON
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

SELECT HS_ID
     , HS_CODE
     , HS_NAME
     , HS_REGION_CODE
     , HS_JURIS_CODE
     , HS_FOUND_TYPE
     , HS_ZIPCODE
     , HS_ADDR
     , HS_ADDR_DETAIL
     , HS_TEL
     , HS_HOMEPAGE
     , HS_COEDU_TYPE
     , HS_TYPE_NAME
     , HS_GENERAL_TYPE
     , HS_FOUND_DATE
     , HS_ANNIV_AT
     , HS_LAT
     , HS_LOT
FROM HIGH_SCHOOL

--고등학교 학과 테이블 고등학교 수 : 499
SELECT COUNT(DISTINCT HS_ID)
FROM HIGH_SCHOOL_DEPT

--고등학교 학과 테이블 행수 : 2786
SELECT COUNT(*)
FROM HIGH_SCHOOL_DEPT

--고등학교 테이블 행수 : 2395
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
    HS.HS_NAME AS 학교명,
    HSD.HSD_CODE,        -- 학과 코드 (G27으로 시작하는 CC_ID)
    CC_MAJOR.CC_NAME AS 학과명, -- 학과명 (COM_CODE에서 가져옴)
    HSD.HSD_TRACK_NAME AS HSD_TRACK_CODE, -- 계열 코드 (G31로 시작하는 CC_ID)
    CC_TRACK.CC_NAME AS 계열명 -- 계열명 (COM_CODE에서 가져옴)
FROM
    HIGH_SCHOOL_DEPT HSD
LEFT JOIN
    COM_CODE CC_MAJOR ON HSD.HSD_CODE = CC_MAJOR.CC_ID
LEFT JOIN
    COM_CODE CC_TRACK ON HSD.HSD_TRACK_NAME = CC_TRACK.CC_ID
LEFT JOIN
    HIGH_SCHOOL HS ON HS.HS_ID=HSD.HS_ID
ORDER BY
    HSD.HS_ID, CC_MAJOR.CC_NAME;
/

commit;

UPDATE COM_CODE
SET CREATED_BY = 'LSY',
    UPDATED_BY = 'LSY';
    
--CONTEST_SEQ 시퀀스 생성
CREATE SEQUENCE CONTEST_SEQ
   START WITH 1      -- 1부터 시작 (원하는 시작값으로 변경 가능)
   INCREMENT BY 1    -- 1씩 증가
   NOMAXVALUE        -- 최대값 없음
   NOCYCLE           -- 반복하지 않음
   CACHE 20;         -- 캐시 크기 (성능 향상, 기본값 20)
       
-- FILE_GROUP_SEQ 시퀀스 생성
CREATE SEQUENCE FILE_GROUP_SEQ
       START WITH 1         -- 1부터 시작 (시작값은 원하는 대로 변경 가능)
       INCREMENT BY 1       -- 1씩 증가
       NOMAXVALUE           -- 최대값 없음
       NOCYCLE              -- 반복하지 않음 (끝까지 가면 다시 시작하지 않음)
       CACHE 20;            -- 캐시 크기 (성능 향상을 위해, 기본값 20)

-- FILE_DETAIL_SEQ 시퀀스 생성
CREATE SEQUENCE FILE_DETAIL_SEQ
       START WITH 1
       INCREMENT BY 1
       NOMAXVALUE
       NOCYCLE
       CACHE 20;