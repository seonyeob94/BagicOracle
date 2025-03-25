2025-0219-01)

사용예)회원테이블에서 회원들의 평균마일리지보다 더 많은 마일리지를 보유한
     회원정보를 조회하시오(Alias는 회원번호,회원명,마일리지,평균마일리지)
  (메인쿼리)
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         마일리지,
         (서브쿼리:평균마일리지)
    FROM MEMBER
   WHERE MEM_MILEAGE > (서브쿼리:평균마일리지)
   
(서브쿼리:평균마일리지)
  SELECT AVG(MEM_MILEAGE)
    FROM MEMBER
 
(결합)  
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_MILEAGE AS 마일리지,
         (SELECT ROUND(AVG(MEM_MILEAGE))
            FROM MEMBER) AS 평균마일리지
    FROM MEMBER
   WHERE MEM_MILEAGE > (SELECT AVG(MEM_MILEAGE)
                          FROM MEMBER);  --서브쿼리 24+7번 실행
                          
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_MILEAGE AS 마일리지,
         ROUND(A.MILE) AS 평균마일리지
    FROM MEMBER,(SELECT AVG(MEM_MILEAGE) AS MILE 
                   FROM MEMBER) A
   WHERE MEM_MILEAGE > A.MILE;  --서브쿼리 1번 실행
     
사용예)상품테이블에서 평균 판매가보다 큰 상품의 갯수를 출력
      Alias는 상품의 수
(메인쿼리)
  SELECT COUNT(PROD_ID) AS "상품의 수"
    FROM PROD
   WHERE PROD_PRICE > (서브쿼리:평균판매가);
   
(서브쿼리:평균판매가)
  SELECT ROUND(AVG(PROD_PRICE))
    FROM PROD;
    
(결합)    
  SELECT COUNT(PROD_ID) AS "상품의 수"
    FROM PROD
   WHERE PROD_PRICE > (SELECT ROUND(AVG(PROD_PRICE))
                         FROM PROD);
      

사용예)상품테이블에서 평균 판매가보다 큰 상품의 갯수,상품명, 판매가를 출력
      Alias는 상품의 수
      
  SELECT PROD_NAME AS 상품명,
         PROD_PRICE AS 판매가,
         COUNT(PROD_ID) AS "상품의 수"
    FROM PROD
   WHERE PROD_PRICE > (SELECT ROUND(AVG(PROD_PRICE))
                         FROM PROD)
   GROUP BY PROD_NAME, PROD_PRICE;
   
사용예) 장바구니 테이블에서 2020년 5월 회원별 구매금액합계를 구하고 가장 많이 
      구매를 한 회원의 회원번호,회원명,직업,구매금액 합계를 조회하시오  
 (메인쿼리 : 2020년 5월 가장 많이 구매를 한 회원의 회원번호,회원명,직업,구매금액 합계) 
  SELECT D.AMID AS 회원번호,
         C.MEM_NAME AS 회원명,
         C.MEM_JOB AS 직업,
         D.ASUM AS 구매금액 합계
    FROM MEMBER C,
        (SELECT A.MEM_ID AS AMID,
                SUM(A.CART_QTY*B.PROD_PRICE) AS ASUM
           FROM CART A, PROD B
          WHERE A.PROD_ID=B.PROD_ID
            AND A.CART_NO LIKE '202005%'
          GROUP BY A.MEM_ID
          ORDER BY 2 DESC) D
   WHERE C.MEM_ID=D.AMID
     AND ROWNUM =1;
 
 --FROM 절 서브쿼리는 인나인 서브쿼리 
 (서브쿼리 : 2020년 5월 회원별 구매금액 합계)
 
  SELECT A.MEM_ID AS AMID,
         SUM(A.CART_QTY*B.PROD_PRICE) AS ASUM
    FROM CART A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND A.CART_NO LIKE '202005%'
   GROUP BY A.MEM_ID
   ORDER BY 2 DESC;
      
      
      
      
(메인쿼리)    
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_JOB AS 직업,
         "구매금액 합계"
    FROM  MEMBER 
   WHERE  

(서브쿼리:2020년 5월 회원별 구매금액합계 중 가장 많이 
      구매를 한 회원)  
  SELECT MEM_ID AS MID,
         SUM(PROD_PRICE*CART_QTY) AS COSSUM
    FROM CART A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND SUBSTR(CART_NO,1,6)='202005'
   GROUP BY MEM_ID
   ORDER BY 2 DESC;
   
(결합)   
  SELECT M.MEM_ID AS 회원번호,
         M.MEM_NAME AS 회원명,
         M.MEM_JOB AS 직업,
         S.SUM AS "구매금액 합계"
    FROM  MEMBER M,
           (SELECT MEM_ID AS MID,
               SUM(PROD_PRICE*CART_QTY) AS SUM
              FROM CART A, PROD B
             WHERE A.PROD_ID=B.PROD_ID
               AND SUBSTR(CART_NO,1,6)='202005'
             GROUP BY MEM_ID
             ORDER BY 2 DESC) S
   WHERE M.MEM_ID=S.MID
   FETCH FIRST 1 ROWS ONLY;
    
사용예) 충남에 거주하는 회원이 주문한 모든 주문사항을 조회하시오
       Alias는 회원번호,회원명,주문일자,상품번호,상품명,주문수량
    
           
       
(메인쿼리)     
  SELECT B.MEM_ID AS 회원번호,
         B.MEM_NAME AS 회원명,
         A.CART_NO AS 주문일자,
         A.PROD_ID AS 상품번호,
         C.PROD_NAME AS 상품명,
         B.CART_QTY AS 주문수량
    FROM CART A, MEMBER B, PROD C
   WHERE A.PROD_ID=C.PROD_ID 
     AND A.MEM_ID=B.MEM_ID 
     AND (서브쿼리:충남에 거주하는 회원)
 
 (서브쿼리:충남에 거주하는 회원)
  SELECT MEM_ID AS MID
    FROM MEMBER
   WHERE SUBSTR(MEM_ADD1,1,2) LIKE '충남%' 
   
(결합)
  SELECT B.MEM_ID AS 회원번호,
         B.MEM_NAME AS 회원명,
         NVL(A.CART_NO,0) AS 주문일자,
         NVL(A.PROD_ID,0) AS 상품번호,
         C.PROD_NAME AS 상품명,
         NVL(A.CART_QTY,0) AS 주문수량
    FROM CART A, MEMBER B, PROD C
   WHERE A.PROD_ID=C.PROD_ID 
     AND A.MEM_ID=B.MEM_ID 
     AND B.MEM_ID IN (SELECT MEM_ID AS MID
                        FROM MEMBER
                       WHERE SUBSTR(MEM_ADD1,1,2) LIKE '충남%')
   ORDER BY 1;
       
사용예) 평균마일리지보다 많은 마일리지를 보유한 모든 회원들의 2020년 7월
       구매현황을 조회하시오. Alias는 회원번호, 회원명, 구매액
(메인쿼리)
  SELECT A.MEM_ID AS 회원번호, 
         C.MEM_NAME AS 회원명, 
         SUM(A.CART_QTY*B.PROD_PRICE) AS 구매액
    FROM CART A, PROD B, MEMBER C
   WHERE CART_NO LIKE 202007% 
     AND A.MEM_ID IN (서브쿼리 :평균마일리지보다 많은 마일리지를 보유한 회원의 회원번호)
   GROUP BY A.MEM_ID, C.MEM_NAME 
   
(서브쿼리 :평균마일리지보다 많은 마일리지를 보유한 회원의 회원번호)
  SELECT MEM_ID
    FROM MEMBER
   WHERE MEM_MILEAGE>(SELECT AVG(MEM_MILEAGE)
                        FROM MEMBER) 
(결합) 
  SELECT A.MEM_ID AS 회원번호, 
         C.MEM_NAME AS 회원명, 
         SUM(A.CART_QTY*B.PROD_PRICE) AS 구매액
    FROM CART A, PROD B, MEMBER C
   WHERE A.PROD_ID=B.PROD_ID
     AND A.MEM_ID=C.MEM_ID
     AND CART_NO LIKE '202007%'
     AND A.MEM_ID IN (SELECT MEM_ID
                        FROM MEMBER
                       WHERE MEM_MILEAGE>(SELECT AVG(MEM_MILEAGE)
                                            FROM MEMBER))
   GROUP BY A.MEM_ID, C.MEM_NAME ;

(EXISTS 연산자 사용 결합) 
 - EXISTS 연산자 왼쪽에 컬럼명을 기술하지 않음
 - EXISTS 연산자 우측은 반드시 서브쿼리가 기술되어야 하며
   결과가 1행이라도 존재하면 참(true)를 반환함
   
   
  SELECT A.MEM_ID AS 회원번호, 
         C.MEM_NAME AS 회원명, 
         SUM(A.CART_QTY*B.PROD_PRICE) AS 구매액
    FROM CART A, PROD B, MEMBER C
   WHERE A.PROD_ID=B.PROD_ID
     AND A.MEM_ID=C.MEM_ID
     AND CART_NO LIKE '202007%'
     AND EXISTS (SELECT 1 --의미없는 숫자 그저 한줄이 출력되는지 확인하기 위해 쓰임
                   FROM (SELECT MEM_ID
                           FROM MEMBER
                          WHERE MEM_MILEAGE>(SELECT AVG(MEM_MILEAGE)
                                               FROM MEMBER))D
                  WHERE D.MEM_ID=A.MEM_ID)
   GROUP BY A.MEM_ID, C.MEM_NAME ;
   
   
   
(메인쿼리)
  SELECT B.MEM_ID AS 회원번호, 
         B.MEM_NAME AS 회원명, 
         SUM(C.PROD_PRICE*A.CART_QTY) AS 구매액
    FROM CART A, MEMBER B, PROD C
   WHERE A.PROD_ID=C.PROD_ID 
     AND A.MEM_ID=B.MEM_ID 
     AND MEM_MILEAGE > (서브쿼리:평균마일리지 )
     AND SUBSTR(A.CART_NO,1,6)='202007'
   GROUP BY B.MEM_ID, B.MEM_NAME;
 
 (서브쿼리:평균마일리지) 
  SELECT AVG(MEM_MILEAGE)
    FROM MEMBER 
    
 (결합)
  SELECT B.MEM_ID AS 회원번호, 
         B.MEM_NAME AS 회원명, 
         SUM(C.PROD_PRICE*A.CART_QTY) AS 구매액
    FROM CART A, MEMBER B, PROD C
   WHERE A.PROD_ID=C.PROD_ID 
     AND A.MEM_ID=B.MEM_ID
     AND MEM_MILEAGE > (SELECT AVG(MEM_MILEAGE)
                          FROM MEMBER )
     AND SUBSTR(A.CART_NO,1,6)='202007'
   GROUP BY B.MEM_ID, B.MEM_NAME;  
       
     
**서브쿼리를 이용한 테이블 복사
 - 테이블의 구조와 데이터만 복사
 - 기본키, 외래키는 복사되지 않음
 
  CREATE TABLE 테이블 명[(컬럼LIST)] AS
   서브쿼리--괄호로 묶지 않는다 (CREAT,INSERT INTO에 쓰이는 서브쿼리는 묶지 않는다)
   
사용예) HR계정의 사원테이블에서 사원번호,사원명,부서번호,입사일 컬럼을 복사하여
       EMP 테이블을 생성하시오
   DROP TABEL C##HR.EMP;
       
   CREATE TABLE C##HR.EMP AS 
     SELECT EMPLOYEE_ID,EMP_NAME,DEPARTMENT_ID,HIRE_DATE,SALARY
       FROM C##HR.EMPLOYEES;
       
** RETIRE 테이블 생성  
   사원번호,부서번호,입사일,퇴직일
 
사용예) 사원테이블에서 2020년 이전에 입사한 사원 중 급여가 많은 10명을 퇴직처리하시오    
    
(메인쿼리: 퇴직자를 RETIRE 테이블에 삽입)    
  INSERT INTO C##HR.RETIRE A
     서브쿼리:2020년 이전에 입사한 사원 중 급여가 많은 10명의 사원번호 B
   WHERE A.EMPLOYEE_ID= B.사원번호
   
(서브쿼리:2020년 이전에 입사한 사원 중 급여가 많은 10명의 사원번호)    
  SELECT A.EMPLOYEE_ID
    FROM (SELECT EMPLOYEE_ID, SALARY
            FROM C##HR.EMP
           WHERE HIRE_DATE < TO_DATE('20200101') 
           ORDER BY SALARY DESC) A
   WHERE ROWNUM <=10    
   
(결합)   
  INSERT INTO C##HR.RETIRE A
     SELECT B.EMPLOYEE_ID, B.DEPARTMENT_ID, SYSDATE
       FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID
               FROM C##HR.EMP
              WHERE HIRE_DATE < TO_DATE('20200101') 
              ORDER BY SALARY DESC) B
      WHERE ROWNUM <=10; 
      
      COMMIT;
      
      SELECT *
        FROM C##HR.RETIRE;
  
  DELETE FROM C##HR.EMP
   WHERE EMPLOYEE_ID IN(SELECT B.EMPLOYEE_ID
                          FROM (SELECT EMPLOYEE_ID
                                  FROM C##HR.EMP
                                 WHERE HIRE_DATE < TO_DATE('20200101') 
                              ORDER BY SALARY DESC) B
                         WHERE ROWNUM <=10)
    
    

   INSERT INTO C##HR.JOB_HISTORY
  (SELECT A.EID AS EMPLOYEES_ID,
          A.HIRDA AS START_DATE,
          A.RETIRE AS END_DATE,
          A.JOBID AS JOB_ID,
          A.DEPART AS DEPARTMENT_ID
     FROM (SELECT EMPLOYEE_ID AS EID, 
                  HIRE_DATE AS HIRDA,
                  SYSDATE AS RETIRE,
                  JOB_ID AS JOBID,
                  DEPARTMENT_ID AS DEPART
             FROM C##HR.EMPLOYEES
            WHERE EXTRACT(YEAR FROM HIRE_DATE)<('2020')
            ORDER BY SALARY DESC) A
     WHERE ROWNUM<=10);  
     
  --GLGLG
  SELECT* FROM C##HR.JOB_HISTORY;
  
  ROLLBACK;
   COMMIT;
   
    
