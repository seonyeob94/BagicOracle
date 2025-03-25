2025-0206-03)기타자료형
 - RAW, LONG RAW, BFILE, BLOB등이 제공
 - 주로 이진자료(디지털 자료)를 저장하는 데이터 타입
 - 해석되거나 변환되지 않음
1. RAW
 - 비교적 작은 크기의 이진자료 저장 
사용형식)
 컬럼명 RAW(크기)
  - 2000 BYTE까지 저장 가능
  - 인텍스처리 가능
  - 16진수와 2진수 형태로 저장
사용예)
  CREATE TABLE TEMP06(
    COL1 RAW(2000)
  );
 
  INSERT INTO TEMP06 VALUES(HEXTORAW('A5FC'));
  INSERT INTO TEMP06 VALUES(HEXTORAW('1010100111111100'));
  
 
  SELECT * FROM TEMP06;

2. BFILE
 - 4GB의 이진자료 저장
 - 원본자료를 테이블 밖에 저장하고 테이블에는 경로(path)와 파일명만 저장
 - 원본자료가 자주 변경되는 경우 효과적
사요형식)
 컬럼명 BEFILE
 
사용예)
  CREATE TABLE TEMP07(
    COL BFILE
  );
  1) 원본준비
   CREATE [OR REPLACE]DIRECTORY 디덱토리객체명 AS '절대경로;
   CREATE OR REPLACE DIRECTORY TEST_DIR AS
      'D:\A_TeachingMaterial\02_Oracle\work';
  2) 디렉토리 객체 생성
    INSERT INTO TEMP07 VALUES(BFILENAME('TEST_DIR','LUPPY.jpg'));
    
    SELECT*FROM TEMP07;
  3) 원본을 테이블에 저장
  
  
  
  
3. BLOB(Binary Large OBject)
 - 4GB의 이진자료 저장
 - 원본자료를 테이블 안에 저장
 - 원본자료 변경이 발생되지 않는 경우 효과적
사용형식)
 컬럼명 BLOB
 
사용예)
 CREATE TABLE TEMP08(
   NO NUMBER,
   BLOB_FILE BLOB
 );  
 
  CREATE TABLE TEMP08(
   NO NUMBER,
   BLOB_FILE BLOB
 );  
 
  CREATE SEQUENCE SEQ_BLOB
    START WITH 1;
 
  CREATE OR REPLACE PROCEDURE proc_blob_insert(
   P_FILENAME IN VARCHAR2)
  IS
    V_LOCATOR BLOB; --변수
    V_SOURCE_DATE_FILE BFILE := BFILENAME('TEST_DIR',P_FILENAME);
    V_DOFFSET NUMBER := 1; -- 기준
    V_SOFFSET NUMBER := 1;
  BEGIN
    INSERT INTO TEMP08(NO,BLOB_FILE) VALUES(SEQ_BLOB.NEXTVAL,EMPTY_BLOB())
      RETURNING BLOB_FILE INTO V_LOCATOR;
      
      DBMS_LOB.OPEN(V_SOURCE_DATE_FILE, DBMS_LOB.LOB_READONLY);
      DBMS_LOB.LOADBLOBFROMFILE(V_LOCATOR,
                               V_SOURCE_DATE_FILE,
                               DBMS_LOB.GETLENGTH(V_SOURCE_DATE_FILE),--파일의 길이만큼
                               V_DOFFSET,
                               V_SOFFSET);
      DBMS_LOB.CLOSE(V_SOURCE_DATE_FILE);
      COMMIT;
  END;    
  
  
  EXECUTE proc_blob_insert('LUPPY.jpg');