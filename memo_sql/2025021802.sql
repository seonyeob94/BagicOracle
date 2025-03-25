2025-0218-02)OUTER JOIN
 - 자료가 많은 쪽을 기준으로 부족한 테이블에 NULL로 구성된 
   행을 추가하여 JOIN을 수행--(모든, 전부라는 표현이 나옴)
 - '(+)' 연산자를 부족한 쪽에 추가하여 조인조건을 구성  
 - COUNT함수를 사용할 때 '*' 대신 컬럼명(보통 PK)을 사용해야 함
 
사용형식 : 일반 외부조인)
  SELECT 칼럼list
    FROM 테이블명1  [별칭1], 테이블명2 [별칭2],...
   WHERE 테이블명1.컬럼명(+)=테이블명2.컬럼명
    [AND 테이블명2.컬럼명=테이블명3.컬럼명(+)]
          :
    [AND 일반조건]
  . 외부조인이 필요한 조건 모두에 '(+)'를 사용해야함(대표로 사용할 수 없음)
  . 하나의 테이블이 동시에 외부조인될 수 없다(즉, A,B,C 테이블을 조인하는 경우
    A=B(+) AND C=B(+)는 허용되지 않음. A=B(+) AND B=C(+)는 허용됨)
  . 외부조인조건과 일반조건이 동시에 사용되면 내부조인으로 변환됨=> 해결책으로
    ANSI 외부조인이나 SUBQUERY를 사용해야 함

사용형식 : ANSI)
  SELECT 칼럼list
    FROM 테이블명1  [별칭1]
   (RIGHT|LEFT|FULL) OUTER JOIN 테이블명2 [별칭2] ON(조인조건1[AND 일반조건])
   (RIGHT|LEFT|FULL) OUTER JOIN 테이블명3 [별칭3] ON(조인조건2[AND 일반조건])
          :
   [WHERE 일반조건]
   
  . 'RIGHT': OUTER JOIN 절 다음에 기술한 테이블의 값이 FROM 절에 기술한
             테이블의 값보다 종류가 많은 경우
  . 'LEFT' : OUTER JOIN 절 다음에 기술한 테이블의 값이 FROM 절에 기술한
             테이블의 값보다 종류가 적은 경우 
  . 'FULL' : 양쪽 모두 부족한 경우
  . WHERE 절을 사용하면 내부 조인 결과로 변환됨
     
    
사용예)상품테이블에서 모든 분류별 상품의 수를 조회하시오.
      Alias는 분류코드,분류명,상품의 수

상품테이블에서 사용하는 분류코드)
  SELECT DISTINCT LPROD_GU
    FROM PROD;
      
  SELECT A.LPROD_GU AS 분류코드,
         A.LPROD_NAME AS 분류명,
         COUNT(B.PROD_ID) AS "상품의 수"
    FROM LPROD A, PROD B
   WHERE A.LPROD_GU=B.LPROD_GU(+)
   GROUP BY A.LPROD_GU, A.LPROD_NAME
   ORDER BY 1; 
   
(ANSI JOIN) 
  SELECT A.LPROD_GU AS 분류코드,
         A.LPROD_NAME AS 분류명,
         COUNT(B.PROD_ID) AS "상품의 수"
    FROM LPROD A
    LEFT OUTER JOIN PROD B ON(A.LPROD_GU=B.LPROD_GU)
   GROUP BY A.LPROD_GU, A.LPROD_NAME
   ORDER BY 1; 
    
사용예)사원테이블에서 모든 부서별 사원수와 평균 급여를 조회하시오
      Alias는 부서코드, 부서명, 인원수,평균급여
  SELECT A.DEPARTMENT_ID AS 부서코드, 
         A.DEPARTMENT_NAME AS 부서명, 
         COUNT(B.EMPLOYEE_ID) AS 인원수,
         NVL(ROUND(AVG(B.SALARY)),0) AS 평균급여
    FROM C##HR.DEPARTMENTS A, C##HR.EMPLOYEES B
   WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID(+)
   GROUP BY A.DEPARTMENT_ID, A.DEPARTMENT_NAME
   ORDER BY 1;
   
(ANSI OUTER)
  SELECT A.DEPARTMENT_ID AS 부서코드, 
         A.DEPARTMENT_NAME AS 부서명, 
         COUNT(B.EMPLOYEE_ID) AS 인원수,
         NVL(ROUND(AVG(B.SALARY)),0) AS 평균급여
    FROM C##HR.DEPARTMENTS A
    FULL OUTER JOIN C##HR.EMPLOYEES B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
   GROUP BY A.DEPARTMENT_ID, A.DEPARTMENT_NAME
   ORDER BY 1;
   
 **상품테이블에서 상품별 마일리지(PROD_MILEAGE)컬럼을 다음 계산식의 
   결과 값으로 갱신하시오
   상품별 마일리지(PROD_MILEAGE)=TRUNC(매입가의 0.06%)
   SELECT TRUNC(PROD_COST*0.0006)
     FROM PROD;
   
   UPDATE PROD
      SET PROD_MILEAGE=TRUNC(PROD_COST*0.0006);
      
      COMMIT;
 
사용예)모든 회원별 구매 마일리지를 조회하시오 
     Alias는 회원번호,회원명,구매마일리지
  SELECT B.MEM_ID AS 회원번호,
         B.MEM_NAME AS 회원명,
         NVL(SUM(A.CART_QTY*C.PROD_MILEAGE),0) AS 구매마일리지
    FROM CART A, MEMBER B, PROD C
   WHERE A.MEM_ID(+) = B.MEM_ID
     AND C.PROD_ID = A.PROD_ID(+)
   GROUP BY B.MEM_ID, B.MEM_NAME
   ORDER BY 1;
   
 (ANSI OUTRER)
  SELECT B.MEM_ID AS 회원번호,
         B.MEM_NAME AS 회원명,
         NVL(SUM(A.CART_QTY*C.PROD_MILEAGE),0) AS 구매마일리지
    FROM CART A
   RIGHT OUTER JOIN MEMBER B ON(A.MEM_ID = B.MEM_ID)
    LEFT OUTER JOIN PROD C ON(C.PROD_ID = A.PROD_ID)
   GROUP BY B.MEM_ID, B.MEM_NAME
   ORDER BY 1;
      
사용예)2020년 1월 모든 상품별 매입현황을 조회하시오
      Alias는 상품번호,상품명,매입수량,매입금액
  SELECT B.PROD_ID AS 상품번호,
         B.PROD_NAME AS 상품명,
         NVL(SUM(BUY_QTY),0) AS 매입수량,
         NVL(SUM(BUY_QTY*PROD_COST),0) AS 매입금액
    FROM BUYPROD A, PROD B
   WHERE A.PROD_ID(+)=B.PROD_ID
     AND BUY_DATE(+) BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
   GROUP BY B.PROD_ID, B.PROD_NAME
   ORDER BY 1;
   
   
 (ANSI OUTER)
  SELECT B.PROD_ID AS 상품번호,
         B.PROD_NAME AS 상품명,
         NVL(SUM(BUY_QTY),0) AS 매입수량,
         NVL(SUM(BUY_QTY*PROD_COST),0) AS 매입금액
    FROM BUYPROD A
   RIGHT OUTER JOIN PROD B ON(A.PROD_ID=B.PROD_ID AND 
         A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))
   GROUP BY B.PROD_ID, B.PROD_NAME
   ORDER BY 1;
   
(SUBQUERY)
  SELECT P.PROD_ID AS 상품번호,
         P.PROD_NAME AS 상품명
         C. AS 매입수량합계,
         C. AS 매입금액합계
    FROM PROD P, 
         (2020년 1월 상품별 매입수량합계, 매입금액합계) C
   WHERE P.PROD_ID=C.상품코드(+)
   ORDER BY 1;      
 
 (2020년 1월 상품별 매입수량합계, 매입금액합계)
  SELECT A.PROD_ID AS APID,
         SUM(A.BUY_QTY) AS AQTY,
         SUM(A.BUY_QTY*B.PROD_COST) AS ASUM
    FROM BUYPROD A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
   GROUP BY  A.PROD_ID; 
 
 (결합)
  SELECT P.PROD_ID AS 상품번호,
         P.PROD_NAME AS 상품명,
         NVL(C.AQTY,0) AS 매입수량합계,
         NVL(C.ASUM,0) AS 매입금액합계
    FROM PROD P, 
         (SELECT A.PROD_ID AS APID,
                 SUM(A.BUY_QTY) AS AQTY,
                 SUM(A.BUY_QTY*B.PROD_COST) AS ASUM
            FROM BUYPROD A, PROD B
           WHERE A.PROD_ID=B.PROD_ID
             AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
           GROUP BY  A.PROD_ID) C
   WHERE P.PROD_ID=C.APID(+)
   ORDER BY 1;     
      
      
    
    
    
    
    , 테이블명2 [별칭2],...
   WHERE 테이블명1.컬럼명(+)=테이블명2.컬럼명
    [AND 테이블명2.컬럼명=테이블명3.컬럼명(+)]
          :
    [AND 일반조건]
