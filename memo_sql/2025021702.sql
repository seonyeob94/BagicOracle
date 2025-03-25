2025-0217_02) 순위함수
- SELECT 절에서만 사용
사용형식)
  {RANK() | DENSE_RANK() | ROW_NUMBER()} OVER(ORDER BY 컬럼명[DESC|ASC],...)
  
사용예) 회원테이블에서 여성회원들의 마일리지를 조회하여 많은 값부터 순위를 부여하시오
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_MILEAGE AS 마일리지,
         RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS "순위(RANK())",
         DENSE_RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS "순위(DENSE_RANK())",
         ROW_NUMBER() OVER(ORDER BY MEM_MILEAGE DESC) AS "순위(ROW_NUMBER())"
    FROM MEMBER;
   WHERE SUBSTR(MEM_REGNO2,1,1) IN('2','4'); 
   
사용예) 2020년 6월 회원별 구매금액을 구하고 순위를 부여하시오   
  SELECT A.MEM_ID AS 회원번호, 
         SUM(A.CART_QTY*B.PROD_PRICE) AS 구매금액,
         RANK() OVER(ORDER BY SUM(A.CART_QTY*B.PROD_PRICE) DESC) AS 순위
    FROM CART A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND A.CART_NO LIKE '202006%'
   GROUP BY  A.MEM_ID; 
   
--PARTITION BY 그룹별 순위   
사용예) 사원테이블에서 각 부서별 급여가 많은 순으로 순위를 부여하시오
       Alias는 사원번호,사원명,부서번호,급여,순위
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         DEPARTMENT_ID AS 부서번호,
         SALARY AS 급여,
         RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS 순위
    FROM C##HR.EMPLOYEES
  ORDER BY 3;
  
사용예) 사원테이블에서 부서별 평균급여를 구하고 많은 값부터 순위를 출력하시오  
       Alias는 부서번호, 인원수, 평균급여, 순위
  SELECT DEPARTMENT_ID AS 부서번호, 
         COUNT(EMPLOYEE_ID) AS 인원수, 
         ROUND(AVG(SALARY)) AS 평균급여, 
         RANK() OVER(ORDER BY ROUND(AVG(SALARY)) DESC) AS 순위
    FROM C##HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID;