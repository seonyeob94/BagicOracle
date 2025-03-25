2025_0218_01)JOIN
 - 복수 개의 테이블 사이에 존재하는 공통 속성을 이용한 연산
 - 분류
   . 내부조인/외부조인
   . 일반조인/ANSI 조인
   . 동등조인/비동등조인/SELF JOIN
   
1) Cartesian Product (CROSS JOIN)
 - 조인조건이 없거나 조인조건이 잘못 기술된 경우
 - 반드시 필요치 않은 경우 사용해서는 안됨
 - 결과 : 각 테이블의 행은 모두 곱한 행의 수와 열은 더한 갯수가 결과로 반환
 
사용형식: 일반조인)
  SELECT 칼럼list
    FROM 테이블명1  [별칭1], 테이블명2 [별칭2],...
  [WHERE 조인조건]
    [AND 일반조건]   --조건은 AND로 연결

사용형식: ANSI조인)
  SELECT 칼럼list
    FROM 테이블명1  [별칭1]
   CROSS JOIN 테이블명2 [별칭2] [ON(조인조건)],... 
  [WHERE 일반조건] 
  
사용예)
  SELECT 'BUYPROD : '||COUNT(*) AS "행의 수" FROM BUYPROD
  UNION
  SELECT 'PROD : '||COUNT(*) FROM PROD
  UNION
  SELECT 'CART : '||COUNT(*) FROM CART;

  SELECT *
    FROM CART,PROD,BUYPROD;
    
  SELECT COUNT(*)
    FROM CART
   CROSS JOIN PROD
   CROSS JOIN BUYPROD;

2. 동등조인(EQUI-JOIN,INNER JOIN)
 - 대부분의 조인
 - 조인조건에 '=' 연산자가 사용된 경우
 - 조인조건을 만족하지 않는 자료는 무시함
 - 사용된 테이블의 수-1개 이상의 조인조건을 기술해야함
 
사용형식:일반조인) 
  SELECT 칼럼list
    FROM 테이블명1  [별칭1], 테이블명2 [별칭2],...
   WHERE 조인조건
    [AND 조인조건,...]
    [AND 일반조건]

사용형식: ANSI조인)
  SELECT 칼럼list
    FROM 테이블명1  [별칭1]
   INNER JOIN 테이블명2 [별칭2] ON(조인조건 [AND 일반조건1]) 
   INNER JOIN 테이블명3 [별칭2] ON(조인조건 [AND 일반조건2]) 
         :
  [WHERE 일반조건] --모든 테이클에 공통으로 해
  - '테이블명1'과 '테이블명2'는 반드시 직접 조인되어야 함--반드시 공통컬럼을 가지고 있어야함
  - '일반조건1'은 '테이블명1'과 '테이블명2'에 관련된 조건
  - '테이블명3'은 '테이블명1'과 '테이블명2'의 조인 결과와 조인
  - 'WHERE 일반조건' : 모든 테이블에 관련된 조건
  -**내부조인인 경우' 일반조건'이 ON절에 기술하거나 WHERE절에 기술해도 결과가 동일
     단, 외부조건인 경우 '일반조건'을 WHERE절에 기술하면 내부조인 결과로 바뀜
사용예)2020년 1월 매입정보를 출력하시오.(Alias는 일자,상품코드,상품명,수량)
(일반조인)--고유한 컬럼명이면 별칭 안붙혀도 됨
  SELECT BUYPROD.BUY_DATE AS 일자,
         PROD.PROD_ID AS 상품코드,
         PROD.PROD_NAME AS 상품명,
         BUYPROD.BUY_QTY AS 수량
    FROM BUYPROD,PROD
   WHERE BUYPROD.PROD_ID=PROD.PROD_ID
     AND BUYPROD.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
   ORDER BY 1;  
   
(ANSI FORMAT) 
  SELECT A.BUY_DATE AS 일자,
         A.PROD_ID AS 상품코드,
         B.PROD_NAME AS 상품명,
         A.BUY_QTY AS 수량
    FROM BUYPROD A 
 --  INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID AND A.BUY_DATE BETWEEN 
 --        TO_DATE('20200101') AND TO_DATE('20200131'))
 --  ORDER BY 1;      
   INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
   WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
   ORDER BY 1;      

사용예)사원테이블에서 10,20,60,90번 부서의 사원정보를 출력하시오.
     Alias는 사원번호,사원명,부서번호,부서명,직책코드,직책명
(일반조인)  
  SELECT A.EMPLOYEE_ID AS 사원번호,
         A.EMP_NAME AS 사원명,
         B.DEPARTMENT_ID AS 부서번호,
         B.DEPARTMENT_NAME AS 부서명,
         A.JOB_ID AS 직책코드,
         C.JOB_TITLE AS 직책명   
    FROM C##HR.EMPLOYEES A, C##HR.DEPARTMENTS B, C##HR.JOBS C 
   WHERE A.DEPARTMENT_ID IN (10,20,60,90) --일반조건
     AND A.DEPARTMENT_ID=B.DEPARTMENT_ID  -- 조인조건(부서명을 위한)
     AND A.JOB_ID=C.JOB_ID --조인조건(직책명을 위한)
   ORDER BY 3;  
     
(ANSI JOIN) 
  SELECT A.EMPLOYEE_ID AS 사원번호,
         A.EMP_NAME AS 사원명,
         B.DEPARTMENT_ID AS 부서번호,
         B.DEPARTMENT_NAME AS 부서명,
         A.JOB_ID AS 직책코드,
         C.JOB_TITLE AS 직책명   
    FROM C##HR.EMPLOYEES A
   INNER JOIN C##HR.JOBS C ON(A.JOB_ID=C.JOB_ID)
   INNER JOIN C##HR.DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID
     AND B.DEPARTMENT_ID IN (10,20,60,90))
   ORDER BY 3;  
    
사용예)2020년 6월 상품별 매출집계를 출력하시오.
    (Alias는 상품코드,상품명,매출수량합계,매출금액합계)
(일반조인)
  SELECT A.PROD_ID AS 상품코드,
         A.PROD_NAME AS 상품명,
         SUM(B.CART_QTY) AS 매출수량합계,
         SUM(A.PROD_PRICE*B.CART_QTY) AS 매출금액합계
    FROM PROD A, CART B
   WHERE A.PROD_ID=B.PROD_ID -- 조인조건(수량을 위해)
   --  AND SUBSTR(B.CART_NO,5,2) = 06 
     AND B.CART_NO LIKE '202006%'   
   GROUP BY A.PROD_ID, A.PROD_NAME
   ORDER BY 1;
    
(ANSI JOIN) 
  SELECT A.PROD_ID AS 상품코드,
         A.PROD_NAME AS 상품명,
         SUM(B.CART_QTY) AS 매출수량합계,
         SUM(A.PROD_PRICE*B.CART_QTY) AS 매출금액합계
    FROM PROD A
   INNER JOIN CART B ON(A.PROD_ID=B.PROD_ID AND B.CART_NO LIKE '202006%')
   GROUP BY A.PROD_ID, A.PROD_NAME
   ORDER BY 1;
    
    
사용예)사원테이블에서 부서별 인원수를 조회하시오
     Alias 부서번호,부서명,인원수
(일반 조인)
  SELECT A.DEPARTMENT_ID AS 부서번호,
         B.DEPARTMENT_NAME AS 부서명,
         COUNT(A.EMPLOYEE_ID) AS 인원수
    FROM C##HR.EMPLOYEES A, C##HR.DEPARTMENTS B
   WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
   GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
   ORDER BY 1;
   
(ANSI JOIN)
  SELECT A.DEPARTMENT_ID AS 부서번호,
         B.DEPARTMENT_NAME AS 부서명,
         COUNT(A.EMPLOYEE_ID) AS 인원수
    FROM C##HR.EMPLOYEES A
   INNER JOIN C##HR.DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
   GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
   ORDER BY 1;
   
     
     
사용예)2020년 상반기 매입정보를 조회하시오
     Alias는 월, 매입수량, 매입금액
(일반 조인)
  SELECT EXTRACT(MONTH FROM BUY_DATE)||'월' AS 월, 
         SUM(A.BUY_QTY) AS 매입수량, 
         SUM(B.PROD_COST*A.BUY_QTY) AS 매입금액
    FROM BUYPROD A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
   GROUP BY EXTRACT(MONTH FROM BUY_DATE); 
   
(ANSI JOIN)
  SELECT EXTRACT(MONTH FROM BUY_DATE)||'월' AS 월, 
         SUM(A.BUY_QTY) AS 매입수량, 
         SUM(B.PROD_COST*A.BUY_QTY) AS 매입금액
    FROM BUYPROD A
   INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
   GROUP BY EXTRACT(MONTH FROM BUY_DATE);  
     
     
     
사용예)2020년 거래처별 매출을 조회하시오. 
      매출액은 해당 거래처에서 납품하는 상품의 판매액
      Alias는 거래처코드,거래처명,매출액
(일반 조인)
  SELECT B.BUYER_ID AS 거래처코드,
         B.BUYER_NAME AS 거래처명,
         SUM(A.PROD_PRICE*C.CART_QTY) AS 매출액
    FROM PROD A, BUYER B, CART C
   WHERE C.CART_NO LIKE '2020%'
     AND A.BUYER_ID=B.BUYER_ID
     AND A.PROD_ID=C.PROD_ID
   GROUP BY B.BUYER_ID, B.BUYER_NAME  
   ORDER BY 1;
   
(ANSI JOIN)
  SELECT B.BUYER_ID AS 거래처코드,
         B.BUYER_NAME AS 거래처명,
         SUM(A.PROD_PRICE*C.CART_QTY) AS 매출액
    FROM PROD A
   INNER JOIN BUYER B ON(A.BUYER_ID=B.BUYER_ID)
   INNER JOIN CART C ON(A.PROD_ID=C.PROD_ID)
   WHERE C.CART_NO LIKE '2020%'
   GROUP BY B.BUYER_ID, B.BUYER_NAME  
   ORDER BY 1;

사용예)HR계정에서 사무실이 미국 이외의 나라에 있는 부서에 속한
      사원들을 조회하시오
      Alias는 사원번호,사원명,부서번호,부서명,주소
      주소는 STREET_ADDRESS+CITY+STATE_PROVINCE 및 국가명
(일반 조인)      
  SELECT B.EMPLOYEE_ID AS 사원번호,
         B.EMP_NAME AS 사원명,
         A.DEPARTMENT_ID AS 부서번호,
         A.DEPARTMENT_NAME AS 부서명,
         C.STREET_ADDRESS||', '||C.CITY||', '||C.STATE_PROVINCE||', '||D.COUNTRY_NAME AS 주소
    FROM C##HR.DEPARTMENTS A, C##HR.EMPLOYEES B, C##HR.LOCATIONS C, C##HR.COUNTRIES D
   WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
     AND A.LOCATION_ID=C.LOCATION_ID
     AND C.COUNTRY_ID=D.COUNTRY_ID
     AND C.COUNTRY_ID NOT IN ('US')
   ORDER BY 1; 

(ANSI JOIN)    
  SELECT B.EMPLOYEE_ID AS 사원번호,
         B.EMP_NAME AS 사원명,
         A.DEPARTMENT_ID AS 부서번호,
         A.DEPARTMENT_NAME AS 부서명,
         C.STREET_ADDRESS||', '||C.CITY||', '||C.STATE_PROVINCE||', '||D.COUNTRY_NAME AS 주소
    FROM C##HR.DEPARTMENTS A
   INNER JOIN C##HR.EMPLOYEES B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
   INNER JOIN C##HR.LOCATIONS C ON(A.LOCATION_ID=C.LOCATION_ID)
   INNER JOIN C##HR.COUNTRIES D ON(C.COUNTRY_ID=D.COUNTRY_ID)
   WHERE C.COUNTRY_ID != ('US')
   ORDER BY 3; 


