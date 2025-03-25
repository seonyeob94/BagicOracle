2025-0226-01)집합연산자
 - 합집합(UNION, UNION ALL), 교집합(INTERSECT), 차집합(MINUS)
 - 복수개의 SELECT문의 결과에 대하여 집합연산의 결과를 반환
 - 각 SELECT문의 SELECT절의 컬럼의 갯수, 타입, 순서가 일치해야함
 - 컬럼의 별칭은 첫 번째 SELECT문의 것이 적용됨
 - ORDER BY절은 마지막 SELECT문에만 기술 할 수 있음
 
1. UNION, UNION ALL
  - 합집합의 결과를 반환
  - 구조가 다른 여러 테이블에서 동일 형태의 자료를 추출하는 경우 주로 사용됨
  
사용예) 2020년 6월과 7월에 구매활동을 한 모든 회원정보를 조회하시오
      Alias는 회원번호,회원명,직업,마일리지
(6월 구매 회원)      
  SELECT DISTINCT A.MEM_ID AS 회원번호,
         B.MEM_NAME AS 회원명,
         B.MEM_JOB AS 직업,
         B.MEM_MILEAGE AS 마일리지
    FROM CART A, MEMBER B
   WHERE A.MEM_ID=B.MEM_ID
     AND A.CART_NO LIKE '202006%'
UNION      
  SELECT DISTINCT A.MEM_ID,
         B.MEM_NAME,
         B.MEM_JOB,
         B.MEM_MILEAGE
    FROM CART A, MEMBER B
   WHERE A.MEM_ID=B.MEM_ID
     AND A.CART_NO LIKE '202007%'
     
     
   
  SELECT DISTINCT A.MEM_ID AS 회원번호,
         B.MEM_NAME AS 회원명,
         B.MEM_JOB AS 직업,
         B.MEM_MILEAGE AS 마일리지
    FROM CART A, MEMBER B
   WHERE A.MEM_ID=B.MEM_ID
     AND A.CART_NO LIKE '202006%'
UNION ALL     
  SELECT DISTINCT A.MEM_ID,
         B.MEM_NAME,
         B.MEM_JOB,
         B.MEM_MILEAGE
    FROM CART A, MEMBER B
   WHERE A.MEM_ID=B.MEM_ID
     AND A.CART_NO LIKE '202007%'  
   ORDER BY 1;  
   
** 테이블 BUDGET, SALES을 생성
  CREATE TABLE BUDGET(
    PERIOD CHAR(6),
    BUDGET_AMT NUMBER(5));
    DROP TABLE SALES;
  CREATE TABLE SALES(
    PERIOD CHAR(6), 
    SALE_AMT NUMBER(5));
    
   INSERT INTO BUDGET VALUES('202401',1000);  
   INSERT INTO BUDGET VALUES('202402',800);  
   INSERT INTO BUDGET VALUES('202403',2000);  
   INSERT INTO BUDGET VALUES('202404',1500);  
   INSERT INTO BUDGET VALUES('202405',2500);  
   
   SELECT * FROM BUDGET;
   
    
   INSERT INTO SALES VALUES('202401',900);  
   INSERT INTO SALES VALUES('202402',1200);  
   INSERT INTO SALES VALUES('202403',2000);  
   INSERT INTO SALES VALUES('202404',2800);  
   INSERT INTO SALES VALUES('202405',2000);  
   
   UPDATE SALES
      SET SALES_AMT=900
    WHERE PERIOD='202401'  
    
 사용예)BUDGET, SALES 테이블을 이용하여 계획대비 실적을 조회
  SELECT PERIOD, BUDGET_AMT, 0 AS SALE_AMT
    FROM BUDGET
  UNION
  SELECT PERIOD, 0, SALE_AMT
    FROM SALES
   ORDER BY 1;
   
 
  SELECT PERIOD AS 기간,
         SUM(BUDGET_AMT) AS 계획,
         SUM(SALE_AMT) AS 실적,
         TO_CHAR(ROUND(SUM(SALE_AMT)/SUM(BUDGET_AMT)*100),'999')||'%' AS 달성률 
    FROM (SELECT PERIOD, BUDGET_AMT, 0 AS SALE_AMT
            FROM BUDGET
          UNION
          SELECT PERIOD, 0, SALE_AMT
            FROM SALES)
   GROUP BY PERIOD
   ORDER BY 1;
   
  ** 컬럼을 행으로 변환
   CREATE TABLE SCORE(
     YEAR  CHAR(4),
     GUBUN VARCHAR2(20),
     KOR   NUMBER(3),
     ENG   NUMBER(3),
     MAT   NUMBER(3));
     
  INSERT INTO SCORE VALUES('2024','중간고사',80,70,85);  
  INSERT INTO SCORE VALUES('2024','기말고사',70,90,90); 
  
  SELECT * FROM SCORE;
  
  SELECT YEAR AS 년도, GUBUN AS 구분, '국어' AS 과목, KOR AS 점수
    FROM SCORE
  UNION ALL
  SELECT YEAR, GUBUN, '영어', ENG
    FROM SCORE
  UNION ALL
  SELECT YEAR, GUBUN, '수학', MAT
    FROM SCORE;
  
2. INTERSECT
  - 교집합(공통부분)의 결과를 반환
  
사용예) 2020년 1월과 4월에 모두 매입된 상품을 조회하시오
      Alias는 상품번호, 상품명, 거래처코드, 매입단가

(2020년 1월 매입된 상품의 상품번호, 상품명, 거래처코드, 매입단가)    
  SELECT A.PROD_ID AS 상품번호, 
         B.PROD_NAME AS 상품명, 
         B.BUYER_ID AS 거래처코드, 
         B.PROD_COST AS 매입단가
    FROM BUYPROD A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
  INTERSECT
--(2020년 4월 매입된 상품의 상품번호, 상품명, 거래처코드, 매입단가)    
  SELECT A.PROD_ID,B.PROD_NAME, B.BUYER_ID,B.PROD_COST
    FROM BUYPROD A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND A.BUY_DATE BETWEEN TO_DATE('20200401') AND LAST_DAY(TO_DATE('20200401'))
--수량의 경우 1월과 4월의 매입수량이 다르니 다른 데이터로 취급되어 겹치는 부분이 안나온다     

(EXISTS연산자 사용)
  SELECT A.PROD_ID AS 상품번호, 
         B.PROD_NAME AS 상품명, 
         B.BUYER_ID AS 거래처코드, 
         B.PROD_COST AS 매입단가
    FROM BUYPROD A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
     AND EXISTS (SELECT 1
                   FROM BUYPROD
                  WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND LAST_DAY(TO_DATE('20200401'))
                    AND PROD_ID=A.PROD_ID)
                    
3. MINUS 
  - 차집합의 결과를 반환
  - MINUS 연산자 앞 또는 뒤의 위치에 기술되는 순서에 따라 결과가 상이함
  - NOT EXISTS 연산자로 구현 가능
  
사용예)2020년 4월과 6월 구매한 회원 중 4월에만 구매한 회원정보를 조회하시오
      Alias는 회원번호,회원명,마일리지

(4월 구매한 회원번호)
  SELECT DISTINCT MEM_ID
    FROM CART
   WHERE CART_NO LIKE '202004%' 
  MINUS
--(7월 구매한 회원번호)
  SELECT DISTINCT MEM_ID
    FROM CART
   WHERE CART_NO LIKE '202007%' 
   ORDER BY 1;
  
  
(7월 구매한 회원번호)
  SELECT DISTINCT MEM_ID
    FROM CART
   WHERE CART_NO LIKE '202007%' 
  MINUS
--(4월 구매한 회원번호)
  SELECT DISTINCT MEM_ID
    FROM CART
   WHERE CART_NO LIKE '202004%' 
   ORDER BY 1;
  
(NOT EXISTS연산자를 사용)

(7월 구매한 회원번호)
  SELECT DISTINCT A.MEM_ID
    FROM CART A
   WHERE A.CART_NO LIKE '202007%' 
     AND NOT EXISTS(SELECT DISTINCT MEM_ID
                      FROM CART B
                     WHERE B.CART_NO LIKE '202004%'
                       AND B.MEM_ID=A.MEM_ID) 
   ORDER BY 1;
  
  
  
  