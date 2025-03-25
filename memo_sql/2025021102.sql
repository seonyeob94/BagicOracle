2025-0211-02)기타 연산자
 - BETWEEN, LIKE, IN, ANY(SOME), ALL, EXISTS 등이 제공
1.BETWEEN
 - 범위지정
 - 모든 데이터타입에 사용가능
 - AND로 변환가능
사용형식)
 컬럼명 BETWEEN 값1 AND 값2
 '값1'과 '값2'는 동일 자료 타입(자동변환도 허용)
 
사용예)상품테이블에서 매입가격이 100000~200000원 인 상품의
     상품코드,상품명,매입가격,거래처코드를 조회
 SELECT PROD_ID AS 상품코드,
        PROD_NAME AS 상품명,
        PROD_COST AS 매입가격,
        BUYER_ID AS 거래처코드
   FROM PROD
  WHERE PROD_COST BETWEEN 100000 AND 200000; 
     
사용예) 회원테이블에서 20대 여성회원의 회원번호,회원명,주소,마일리지를 조회
 SELECT MEM_ID AS 회원번호,
        MEM_NAME AS 회원명,
        MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
        MEM_ADD1||' '||MEM_ADD2 AS 주소,
        MEM_MILEAGE AS 마일리지
   FROM MEMBER
  WHERE (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))
        BETWEEN 20 AND 29--20대
    AND (SUBSTR(MEM_REGNO2,1,1)='2' OR SUBSTR(MEM_REGNO2,1,1)='4');

사용예) HR계정의 사원테이블에서 근속년수가 10~15년인 사원의
       사원번호,사원명,입사일,직무코드,급여를 조회하시오
       근속년수 개월수를 구하여 판단
       근속년수 : TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)--TRUNC:소수점이하는 제거
 SELECT EMPLOYEE_ID AS 사원번호,
        EMP_NAME AS 사원명,
        HIRE_DATE AS 입사일,
        JOB_ID AS 직무코드,
        SALARY AS 급여
   FROM C##HR.EMPLOYEES
  WHERE TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)
        BETWEEN 10 AND 15;
        
2.LIKE 연산자
 -패턴비교 연산자
 -'%'와 '_'패턴문자를 사용하여 패턴 구성
사용형식)--오직 문자열만 비교
 컬럼명 LIKE '패턴문자열'
 1)'%'
 .'%'이 사용된 이후 모든 문자열(NULL포함)과 대응
 ex)
  '김%' : '김'으로 시작하는 모든 문자열과 대응('김'도 가능)
  '%김' : '김'으로 끝나는 모든 문자열과 대응('김'도 가능)
  '%김%' : 1글자 이상으로 '김'을 포함하는 모든 문자열
 2)'_'
 .'_'이 사용된 이후 1글자와 대응--NULL 포함되지 않음
 ex)
  '김_' : 2글자로 구성된 '김'으로 시작하는 모든 문자열과 대응
  '_김' : 2글자로 구성된 '김'으로 끝나는 모든 문자열과 대응
  '_김_' : 3글자로 구성된 '김'을 포함하는 모든 문자열 
  
 사용예)회원테이블에서 2000년 이후 출생자의 회원번호,회원명,주민번호 출력
  select MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호
    FROM MEMBER
   WHERE MEM_REGNO1 LIKE '0%' 
   ORDER BY 3;
 
 사용예)장바구니테이블(CART)에서 2020년 7월 판매현황을 조회하시오
      Alias는 날짜,상품번호,판매수량
 SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS 날짜,
        PROD_ID AS 상품번호,
        CART_QTY AS 판매수량 
   FROM CART 
  WHERE CART_NO LIKE '202007%'
  ORDER BY 1; 
      
 사용예)매입테이블에서 2020년 6월 매입자료 조호
      Alias는 날짜,상품코드,매입수량
 SELECT BUY_DATE AS 날짜,
        PROD_ID AS 상품코드,
        BUY_QTY AS 매입수량  
   FROM BUYPROD
  WHERE BUY_DATE BETWEEN '20200601' AND '20200630'; 
  --문자열이 아닌경우 LIKE 연산자 억지로 쓰지말자
  
3. IN 연산자
 - 제시된 복수개의 값 중 어느 하나와 일치하면 참(true)로 반환하는 연산자
 - 다중행 연산자
 - '='의 기능이 포함된 연산자로 OR연산자로 변환가능
 - 연속적이지 않거나 불규칙한 자료 비교에 사용

사용형식)
  컬럼명 IN(값1,값2,...)
  . '컬럼'에 값이 '값1'~'값n' 중 어느 하나와 같으면 참을 반환
(OR 연산자)
사용예)사원테이블 중 20,70,90번 부서에 속하고 급여가 7000이하인 사원들의
     사원번호,사원명,부서번호,직책코드,급여를 출력하시오
     출력은 부서코드 순으로, 급여가 많은순으로 하시오
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         DEPARTMENT_ID AS 부서번호,
         JOB_ID AS 직책코드,
         SALARY AS 급여
    FROM C##HR.EMPLOYEES
   WHERE (DEPARTMENT_ID=20 OR DEPARTMENT_ID=70 OR DEPARTMENT_ID=90)
     AND SALARY <=7000
   ORDER BY 3,5 DESC;
  (IN 연산자)
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         DEPARTMENT_ID AS 부서번호,
         JOB_ID AS 직책코드,
         SALARY AS 급여
    FROM C##HR.EMPLOYEES
   WHERE DEPARTMENT_ID IN(20,70,90)
     AND SALARY <=7000
   ORDER BY 3,5 DESC;
   
사용예)상품테이블에서 분류코드가 'P101', 'P202'에 속한 상품의
     상품코드,상품명,판매가,분류코드를 분류코드 순으로 출력하시오
  SELECT PROD_ID AS 상품코드,
         PROD_NAME AS 상품명,
         PROD_PRICE AS 판매가,
         LPROD_GU AS 분류코드
    FROM PROD
   WHERE LPROD_GU IN('P101','P202')
   ORDER BY 4; 
   
사용예)충남에 거주하는 회원들이 2020년 상반기 구매한 구매집계(회원번호,회원명,구매금액합계)
     를 조회하시오
 SELECT B.MEM_ID AS 회원번호,
        C.MEM_NAME AS 회원명,
        SUM(A.PROD_PRICE*B.CART_QTY) AS 구매금액합계
   FROM PROD A, CART B, MEMBER C
  WHERE B.MEM_ID IN(SELECT MEM_ID
                    FROM MEMBER
                   WHERE MEM_ADD1 LIKE '충남%') 
    AND B.PROD_ID=A.PROD_ID
    AND B.MEM_ID=C.MEM_ID
    AND SUBSTR(B.CART_NO,1,6) BETWEEN '202001' AND '202006'
  GROUP BY B.MEM_ID,C.MEM_NAME;
  
4.ANY(SOME) 연산자
사용형식)
 컬럼명 관계여산자 ANY|SOME(값1, 값2,...값n)--ANY나 SOME 앞에 무조건 관계연산자가 와야함
 - 제시된 복수개의 값 중 어느 하나와 사용된 관계연산자를 만족하면 
   참(true)를 반환하는 연산자
 - 다중행 연산자
 - '='의 기능이 포함된 경우 IN연산자와 같다

사용예)회원테이블에서 직업이 '회사원'인 회원이 보유한 마일리지 중 가장 많은 마일리지보다
      적은 마일리지를 보유한 회원의 회원번호,회원명,직업,마일리지를 조회하시오
 SELECT MEM_ID AS 회원번호,
        MEM_NAME AS 회원명,
        MEM_JOB AS 직업,
        MEM_MILEAGE AS 마일리지
   FROM MEMBER
  WHERE MEM_MILEAGE < ANY(SELECT MEM_MILEAGE
                            FROM MEMBER
                           WHERE MEM_JOB='회사원')
  ORDER BY 4; 
  
사용예)HR계정에서 90번 부서와 같은 위치에 있는 부서에 근무하는 사원의 
     사원번호,사원명,부서번호,직무코드를 조회하시오
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         DEPARTMENT_ID AS 부서번호,
         JOB_ID AS 직무코드 
    FROM C##HR.EMPLOYEES
  WHERE DEPARTMENT_ID=ANY(SELECT DEPARTMENT_ID
                            FROM C##HR.DEPARTMENTS
                           WHERE LOCATION_ID=(SELECT LOCATION_ID
                                                FROM C##HR.DEPARTMENTS
                                               WHERE DEPARTMENT_ID=90)
                             AND MANAGER_ID IS NOT NULL);
 --  WHERE DEPARTMENT_ID IN(10,30,100,110);  
     
     
(90번 부서와 같은 위치에 있는 부서의 부서번호)
 SELECT DEPARTMENT_ID
   FROM C##HR.DEPARTMENTS
  WHERE LOCATION_ID=(SELECT LOCATION_ID
                       FROM C##HR.DEPARTMENTS
                      WHERE DEPARTMENT_ID=90)
    AND MANAGER_ID IS NOT NULL;
     
5.ALL 연산자
사용형식)
  컬럼명 관계연산자 ALL(값1,값2,...값n)
 - 제시되 복수개의 값 전부와 사용된 관계연산자를 만족하면 참(true)를 변환하는 연산자
 - 'AND'로 연결된 다중행 연산자
 - 관계연산자 중 '='은 사용할 수 없다
 
 사용예)회원테이블에서 직업이 '회사원'인 회원이 보유한 마일리지 중 가장 작은 마일리지보다
      더 적은 마일리지를 보유한 회원의 회원번호,회원명,직업,마일리지를 조회하시오
 SELECT MEM_ID AS 회원번호,
        MEM_NAME AS 회원명,
        MEM_JOB AS 직업,
        MEM_MILEAGE AS 마일리지
   FROM MEMBER
  WHERE MEM_MILEAGE < ALL(2300,1500,2600)
  ORDER BY 4; 
  
 (직업이 '회사원'인 회원이 보유한 마일리지)
  SELECT MEM_MILEAGE
    FROM MEMBER
   WHERE MEM_JOB='회사원'
                           
6.EXISTS 연산자
사용형식)
  WHERE EXISTS(서브쿼리)
   - 서브쿼리의 결과가 존재하면 참, 없으면 거짓을 반환
   - EXISTS 다음에 반드시 서브쿼리가 나와야 함