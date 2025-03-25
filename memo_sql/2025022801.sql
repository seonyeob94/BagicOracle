2025_0228-01) SEQUENCE
 - 차례대로 증가[감소]하는 값을 발생시키는 개체
 
사용예)시퀀스를 사용하여 다음 자료를 LPROD테이블에 삽입하시오
  [자료]
-------------------------------------
  LPROD_ID   LPROD_GU   LPROD_NAME
-------------------------------------
    10       P501         농산물
    11       P502         수산물
    
(시퀀스 생성)
  CREATE SEQUENCE seq_lprod_id
    START WITH 10;
    
  INSERT INTO LPROD VALUES(seq_lprod_id.NEXTVAL, 'P501','농산물');
  INSERT INTO LPROD VALUES(seq_lprod_id.NEXTVAL, 'P502','수산물');
  
  SELECT * FROM LPROD;
  
 ** 동의어(SYNONYM)
  - 개체에 부여한 또 다른 이름
  - 주로 다른 소유자의 개체에 부여하는 별칭으로 사용
사용형식)
  CREATE [OR REPLACE] SYNONYM 동의어명 FOR 개체명
  
사용예)HR계정의 EMPLOYEES테이블과 DEPARTMENTS테이블에 각각 EMP와 DEPT
     별칭을 부여하고 30번 부서에 속한 사원정보를 조회하시오
  CREATE OR REPLACE SYNONYM EMP FOR C##HR.EMPLOYEES;  
  CREATE OR REPLACE SYNONYM DEPT FOR C##HR.DEPARTMENTS;   
     
  SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_NAME, A.SALARY
    FROM EMP A, DEPT B
   WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
     AND A.DEPARTMENT_ID=30;
     
사용예)
  CREATE OR REPLACE SYNONYM MyDual FOR SYS.DUAL;
  
  SELECT SYSDATE FROM MYDUAL;
  
  
** index
 - 검색의 효율성을 증대시키는 목적
 - tree 개면을 사용하여 생성, 유지시키므로 데이터의 삽입/삭제/수정이 빈번히 발생되는
   경우에는 비효율적임
 
  CREATE [UNIQUE | BITMAP] INDEX 인덱스
    ON 테이블명(칼람명,...);
    
  DROP INDEX EMP_DEPARTMENT_IX;  
  DROP INDEX EMP_EMAIL_UK;  
  DROP INDEX EMP_EMP_ID_PK;  --기본키라서 삭제가 안됨
  DROP INDEX EMP_JOB_IX;  
  DROP INDEX EMP_MANAGER_IX;   
  COMMIT;
  
사용형식)
사용예)HR계정의 사원테이블에서 이름이 'Amit Banda'사원 정보를 조회해보고
     이름 컬럼으로 인덱스 생성 후 해당 사원정보를 조회하여 속도차이를 비교
  SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE, DEPARTMENT_ID, JOB_ID
    FROM EMP
   WHERE EMP_NAME='Amit Banda'; 
   
(INDEX 생성)
 CREATE INDEX idx_emp_name ON EMP(EMP_NAME);
 
  ALTER INDEX idx_emp_name REBUILD;
     