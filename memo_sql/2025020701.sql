2025-0207-01)ALTER
 - 오라클 객체의구조 등을 변경
 - 테이블 이름 변경
 - 컬럼 : 추가(ADD), 삭제(DROP), 이름(RENAME) 및 데이터 타입 변경(MODIFY)
 - 제약 사항 : 추가, 삭제, 변경
1. 테이블명 변경
사용형식)
  ALTER TABLE old_table_name RENAME TO new_table_name;
  
사용예) GOODS테이블 이름을 PREODUCTS로 변경
  ALTER TABLE GOODS RENAME TO PRODUCTS;
 
2. 컬럼
 - ALTER TABLE 테이블명 ADD|DROP COLUMN|MODIFY(컬럼명|컬럼명 테이터타입[(크기)])
 --DROP사용시 컬럼명만 필요
 --INSET는 빈곳에만 가능 컬럼 하나만 추가할 때는 x(UPDATD사용), INSERT는 행단위/UPDATE는 컬럼단위
사용예) HR계정의 EMPLOYEES테이블에 'EMP_NAME'컬럼을 VARCHAR2(40)추가하고
       FRST_NAME 및 LAST_NAME의 값을 공백으로 삽입하여 연결한후 저장하시오
 1) 테이블 추가       
   ALTER TABLE C##HR.EMPLOYEES ADD(EMP_NAME VARCHAR2(40));
   
 2) EMP_NAME컬럼의 크기를 VARCHAR2(50)으로 변경--원본파일보다 작은 공간을 배정해서는 않된다
  ALTER TABLE C##HR.EMPLOYEES MODIFY(EMP_NAME VARCHAR2(50));
  
 3)FRST_NAME 및 LAST_NAME의 값을 공백을 삽입하여 연결
   UPDATE C##HR.EMPLOYEES
     SET EMP_NAME=TRIM(FIRST_NAME)||' '||TRIM(LAST_NAME);
  COMMIT;
 4)FIRST_NAME과 LAST_NAME컬럼을 삭제--띄어쓰기 주의
   ALTER TABLE C##HR.EMPLOYEES DROP COLUMN FIRST_NAME;
   ALTER TABLE C##HR.EMPLOYEES DROP COLUMN LAST_NAME;
   
 5)컬럼이름 변경
   ALTER TABLE 테이블명 RENAME COLUMN old_column_name TO new_column_name;

사용예)PRODUCTS테이블의 컬럼(G_ID,G_NAME,G-PRICE)를
      PROD_ID,PROD_NAME,PROD_PRICE로 변경하시오
   ALTER TABLE PRODUCTS RENAME COLUMN G_ID TO PROD_ID;    
   ALTER TABLE PRODUCTS RENAME COLUMN G_NAME TO PROD_NAME; 
   ALTER TABLE PRODUCTS RENAME COLUMN G_PRICE TO PROD_PRICE; 

   ALTER TABLE ORDER_GOODS RENAME COLUMN G_ID TO PROD_ID;
   
   COMMIT;
   
** PRACTICE 계정의 모든 테이블을 삭제하시오
   DROP TABLE 테이블명;
   
   DROP TABLE "order_goods";
   DROP TABLE "orders";
   DROP TABLE "customers";
   DROP TABLE PRODUCTS;
   DROP TABLE "goods";
   
   DROP TABLE TEMP01;
   DROP TABLE TEMP02;
   DROP TABLE TEMP03;
   DROP TABLE TEMP04;
   DROP TABLE TEMP05;
   DROP TABLE TEMP06;
   DROP TABLE TEMP07;
   DROP TABLE TEMP08;
   