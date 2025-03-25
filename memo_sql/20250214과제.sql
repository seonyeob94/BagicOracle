2025-0214-숙제

 ` 사원테이블에서 사원수를 조회하시오
  SELECT COUNT(*) AS 사원수
    FROM C##HR.EMPLOYEES;

 ` 상품테이블에서 상품의수, 최대판매가, 최소판매가를 구하시오
  SELECT COUNT(*) AS 상품의수, 
         MAX(PROD_PRICE) AS 최대판매가, 
         MIN(PROD_PRICE) AS 최소판매가
    FROM PROD;
 
 ` 사원테이블에서 부서별 평균급여와 인원수를 조회하시오
  SELECT DEPARTMENT_ID AS 부서,
         ROUND(AVG(SALARY)) AS 평균급여,
         COUNT(*) AS 인원수
    FROM C##HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID 
   ORDER BY 1;
  
 ` 상품테이블에서 분류별 상품의 수, 평균판매가를 조회하시오
  SELECT LPROD_GU AS 분류코드,
         COUNT(*) AS "상품의 수",
         TRUNC(AVG(PROD_PRICE)) AS 평균판매가
    FROM PROD
   GROUP BY LPROD_GU
   ORDER BY 1;
  
 ` 매입테이블에서 2020년 상품별 매입수량합계를 조회하시오
  SELECT PROD_ID AS 상품코드,
         SUM(BUY_QTY) AS 매입수량합계
    FROM BUYPROD
   WHERE EXTRACT(YEAR FROM BUY_DATE)=2020 
   GROUP BY PROD_ID
   ORDER BY 1;
 
 ` 사원테이블에서 부서별, 년도별 입사한 사원수를 조회하시오
  SELECT DEPARTMENT_ID AS 부서,
         EXTRACT(YEAR FROM HIRE_DATE)||'년' AS 년도,
         COUNT(*)
    FROM C##HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID, EXTRACT(YEAR FROM HIRE_DATE)
   ORDER BY 1;
  
 ` 회원테이블에서 성별 평균마일리지를 조회하시오
 
  SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN 
                    '남성'
               ELSE '여성' END AS 성별,
         ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
    FROM MEMBER
   GROUP BY  CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN 
                    '남성'
               ELSE '여성' END 
   ORDER BY 1;          
  
 ` 회원테이블에서 년령대별 회원수와 평균마일리지를 조회하시오
  SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE)
              -EXTRACT(YEAR FROM MEM_BIR),-1)||'대' AS 년령대,
         ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
    FROM MEMBER
   GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE)
              -EXTRACT(YEAR FROM MEM_BIR),-1)||'대'
   ORDER BY 1;      
  
  
 ` 회원테이블에서 거주지별 평균 마일리지와 회원수를 조회하시오
  SELECT SUBSTR(MEM_ADD1,1,2) AS 거주지,
         ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지,
         COUNT(*) AS 회원수
    FROM MEMBER
   GROUP BY SUBSTR(MEM_ADD1,1,2) 
   ORDER BY 1;
  
 ` 매출테이블에서 상품별 판매수량합계를 조회하되 판매수량이 50개
   이상인 상품만 조회하시오
  SELECT PROD_ID AS 상품코드,
         SUM(CART_QTY) AS 판매수량합계
    FROM CART
   WHERE CART_QTY>=50
   GROUP BY PROD_ID
   ORDER BY 1;
   
 ` 사원테이블에서 부서별 사원수를 조회하되 사원수가 5인 이상인 자료만
   조회하시오.
   
  SELECT DEPARTMENT_ID AS 부서,
         COUNT(*) AS 사원수
    FROM C##HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID
   HAVING COUNT(*)>=5
   ORDER BY 1;
  
 ` 매출테이블에서 회원별 판매수량합계를 조회하여 상위 5명을 출력하시오
     SELECT *  FROM 
    (SELECT MEM_ID AS 회원,
            SUM(CART_QTY) AS 판매수량합계,
            RANK() OVER(ORDER BY SUM(CART_QTY) DESC) AS 순위
      FROM CART
     GROUP BY MEM_ID) A
     WHERE 순위<=5;
    
 




