2025020501) 데이터 타입
 - 문자열, 숫자, 날짜, 2진 자료타입이 제공
 
 1. 문자열 자료형
  - 고정길이: CHAR, NCHAR
  - 가변길이: VARCHAR, VARCHAR2, LONG, CLOB
  
  1) CHAR
   - 고정길이, 2000byte 까지 저장가능(한글은 한글자가 3byte)
   - 남는 공간(오른쪽)은 공백처리
   - 기억공간이 부족하면 오류
사용형식)
 컬럼명 CHAR(크기[BYTE|CHAR])
 
사용예)
 CREATE TABLE TEMP01(
   COL1 CHAR(50),
   COL2 CHAR(50 BYTE),
   COL3 CHAR(50 CHAR)
 );
 
 INSERT INTO 테이블명[(컬럼명,...)] VAUES(값,...);
 
 INSERT INTO TEMP01 VALUES('대전시 중구 계룡로 846','대전시 중구 계룡로 846',
                           '대전시 중구 계룡로 846');
 
                           
SELECT * FROM TEMP01;
--lengthb 문자열의 바이트 수를 구하는 함수
SELECT LENGTHB(COL1) AS "COL1",
       LENGTHB(COL2) AS "COL2",
       LENGTHB(COL3) AS "COL3"
  FROM TEMP01;
    DELETE FROM TEM01;
                           
 INSERT INTO TEMP01 VALUES('1234567890123456789012345678901234567890123456789012','',''); 
 
 2) VARCHAR,VARCHAR2, NVARCHAR, NVARCHAR2
   - 가변길이, 4000byte 까지 저장가능(한글은 한글자가 3BYTE)
   - 데이터를 저장하고 남는공간은 반환
   - 기억공간이 부족하면 오류
   
사용예)
 CREATE TABLE TEMP02(
   COL1 VARCHAR2(4000),
   COL2 VARCHAR2(4000CHAR),
   COL3 NVARCHAR2(200)
 );
 
 INSERT INTO TEMP02 VALUES('대전시 중구 계룡로 846','대전시 중구 계룡로 846',
                           '대전시 중구 계룡로 846');
   
 SELECT*FROM TEMP02;
   
 SELECT LENGTHB(COL1) AS "COL1",
          LENGTHB(COL2) AS "COL2",
          LENGTHB(COL3) AS "COL3"
   FROM TEMP02;
   
  2) LONG, CLOB(Character Large OBject)
   - 가변길이, long은 2GB/CLOB는 4GB 까지 저장가능(한글은 한글자가 3BYTE)
   - 데이터를 저장하고 남는공간은 반환
   - 일부 기능(함수)은 제한
   - LONG타입은 한 테이블에 1개만 사용 가능
   - CLOB는 LONG타입을 개선한 형태로 사용 갯수에 제한 없음
사용형식)
 컬럼명 LONG|CLOB
   

사용예)
 CREATE TABLE TEMP03(
   COL1 VARCHAR2(4000),
   COL2 LONG,
 --  COL3 LONG, --long타입 컬럼은 한 테이블당 하나만 쓸 수 있다
   COL4 CLOB,
   COL5 CLOB);

 INSERT INTO TEMP03(COL1,COL2,COL4)
   VALUES('대전시 중구 계룡로 846','대전시 중구 계룡로 846',
                           '대전시 중구 계룡로 846');
   
 SELECT*FROM TEMP03;
   
 SELECT LENGTHB(COL1) AS "COL1",
         -- LENGTHB(COL2) AS "COL2",
        DBMS_LOB.GETLENGTH(COL4) AS "COL4",
        LENGTH(COL4) AS "COL4-1"
   FROM TEMP03;  
   
   
   
   
   
   