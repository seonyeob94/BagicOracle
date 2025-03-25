2025_0214-02)집계함수
 - 데이터를 특정값(컬럼)을 기준으로 그룹화하고 각 그룹에 대하여
   합(SUM), 평균(AVG), 자료의 수(COUNT), 최대값(MAX), 최소값(MIN)을
   반환하는 함수
 - 집계함수는 다른 집계함수를 포함할 수 없다. 단, 일반함수는 집계함수를
   포함 할수도, 포함 될수도 있음
사용형식
  SELECT [컬럼,''',]--COUNT는 결과의 행의수를 센다 *을 사용하면 NULL이여도 하나의 행으로 취급한다
         SUM(CO1|expr) | AVG(co1| expr) | COUNT(*| co1) |
         MAX(co1|expr) | MIN(co1| expr) 
   FROM 테이블명
 [WHERE 조건]
 [GROUP BY 컬럼명[,컬럼명,''']]
[HAVING 조건
 - 'GROUP BY'절 : SELECT절에 집계함수가 아닌 일반컬럼(기준컬럼)이
   사용되면 반드시 기술되어야 하며 GROUP BY 절에 SELECT 절의 일반 컬럼은
   생략할 수 없다
 - 'GROUP BY'절에 기술되는 일반컬럼은 왼쪽부터 대그룹->중그룹->소그룹,...
   으로 적용됨
 - HAVING절 : 그룹함수에 조건이 부여된 경우 사용
 - SELECT절에 일반 컬럼이 사용되지 않으면 GROUP BY절 생략
--집계함수가 사용되면 기준컬럼별 EX)멤버별, 상품별 등등 
사용예)
 ` 회원테이블에서 모든 회원들의 마일리지합계, 평균마일리지, 인원수,
   최대마일리지, 최소마일리지를 구하시오
  SELECT SUM(MEM_MILEAGE) AS 마일리지합계, 
         ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지, 
         COUNT(*) AS 인원수,
         MAX(MEM_MILEAGE) AS 최대마일리지, 
         MIN(MEM_MILEAGE) AS 최소마일리지
    FROM MEMBER; 
  --회원명이 들어가면 회원수만큼 그룹이 생겨서 원하는 값을 구할수 없다
 ` 상품테이블에서 상품의수, 최대판매가, 최소판매가를 구하시오
  SELECT COUNT(PROD_ID) AS 상품의수, 
         MAX(PROD_PRICE) AS 최대판매가, 
         MIN(PROD_PRICE) AS 최소판매가
    FROM PROD;
  
 ` 2020년 4월 판매 수량합계를 구하시오
  SELECT SUM(CART_QTY) AS "판매 수량합계"
    FROM CART
   WHERE CART_NO LIKE '202004%';  
 
 ` 사원테이블에서 사원수를 조회하시오
  SELECT COUNT(*) AS 사원수
    FROM C##HR.EMPLOYEES;
  
 
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
         ROUND(AVG(PROD_PRICE)) AS 평균판매가
    FROM PROD
   GROUP BY LPROD_GU
   ORDER BY 1;
    
 
 ` 매입테이블에서 2020년 월별 매입수량합계를 조회하시오
  SELECT EXTRACT(MONTH FROM BUY_DATE)||'월' AS 월,
         SUM(BUY_QTY) AS 매입수량합계
    FROM BUYPROD
   WHERE EXTRACT(YEAR FROM BUY_DATE)=2020 
   GROUP BY EXTRACT(MONTH FROM BUY_DATE)
   ORDER BY 1; 
  
 ` 매입테이블에서 2020년 상품별 매입수량합계를 조회하시오
  SELECT PROD_ID AS 상품코드,
         SUM(BUY_QTY) AS 매입수량합계
    FROM BUYPROD
   WHERE EXTRACT(YEAR FROM BUY_DATE)=2020 
   GROUP BY PROD_ID
   ORDER BY 1;
 
 ` 매출테이블에서 월별, 상품별 판매수량합계를 조회하시오
  SELECT SUBSTR(CART_NO,5,2) AS 월,
         PROD_ID AS 상품번호,
         SUM(CART_QTY) AS 판매수량합계
    FROM CART
   GROUP BY SUBSTR(CART_NO,5,2), PROD_ID
   ORDER BY 1; 
 
 ` 사원테이블에서 부서별, 년도별 입사한 사원수를 조회하시오
  SELECT DEPARTMENT_ID AS 부서코드,
         EXTRACT(YEAR FROM HIRE_DATE)||'년' AS 입사년도,
         COUNT(*)
    FROM C##HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID, EXTRACT(YEAR FROM HIRE_DATE)
   ORDER BY 1;
  
 ` 회원테이블에서 성별 평균마일리지를 조회하시오
  SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN
                   '남성회원'
              ELSE '여성회원' END AS 성별,
         ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지     
    FROM MEMBER
   GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN
                  '남성회원'
             ELSE '여성회원' END
   ORDER BY 1;           
  
 ` 회원테이블에서 년령대별 회원수와 평균마일리지를 조회하시오
  SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)*10||'대' AS 년령대,
         COUNT(*) AS 회원수,
         ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
    FROM MEMBER
   GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE)-
                   EXTRACT(YEAR FROM MEM_BIR))/10)*10
   ORDER BY 1;      
   
  SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE)
               -EXTRACT(YEAR FROM MEM_BIR),-1)||'대' AS 년령대,
         COUNT(*) AS 회원수,
         ROUND(AVG(MEM_MILEAGE)) AS 평균마일리지
    FROM MEMBER
   GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE)-
                  EXTRACT(YEAR FROM MEM_BIR),-1)
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
  HAVING COUNT(DEPARTMENT_ID)>=5
   ORDER BY 1;
  
 ` 매출테이블에서 회원별 판매수량합계를 조회하여 상위 5명을 출력하시오
    
    SELECT * FROM
    (SELECT 
        MEM_ID AS 회원,
        SUM(CART_QTY) AS 판매수량합계,
        RANK()OVER(ORDER BY SUM(CART_QTY) DESC) AS RANK
    FROM CART
   GROUP BY MEM_ID) A
   WHERE RANK <= 5;
   
   SELECT MEM_ID AS 회원,
          SUM(CART_QTY) AS 판매수량합계
     FROM CART
    GROUP BY MEM_ID
    ORDER BY SUM(CART_QTY) DESC
    FETCH FIRST 5 ROWS ONLY;
    
   SELECT A.MID AS 회원번호,
          A.CSUM AS 판매수량합계
     FROM  ( SELECT MEM_ID AS MID,
              SUM(CART_QTY) AS CSUM
              FROM CART
             GROUP BY MEM_ID
              ORDER BY 2 DESC)A
    WHERE ROWNUM<=5 ;
    
    --의사컬럼

















