2025-0211-11)SELECT문
  - 조건절 사용
사용예)상품테이블에서 판매가격이 100만원 이상인 상품을 조회하시오
      Alias는 상품번호, 상품명, 판매가격
조건: 판매가격이 100만원 이상)
 SELECT PROD_ID AS 상품번호, 
        PROD_NAME AS 상품명, 
        PROD_PRICE AS 판매가격
   FROM PROD
  WHERE PROD_PRICE>=1000000
  ORDER BY 3 DESC;
          
사용예)회원테이블에서 마일리지가 2000미만인 회원정보를 조회하시오
      Alias는 회원번호, 회원명, 직업 ,마일리지
 SELECT MEM_ID AS 회원번호, 
        MEM_NAME AS 회원명, 
        MEM_JOB AS 직업,
        MEM_MILEAGE AS 마일리지
   FROM MEMBER
  WHERE MEM_MILEAGE<2000
  ORDER BY 4 ASC;
      
사용예)서울에 거주하는 회원정보를 조회하시오
      Alias는 회원번호, 회원명, 주소
 SELECT MEM_ID AS 회원번호,
        MEM_NAME AS 회원명,
        MEM_ADD1||' '||MEM_ADD2 AS 주소
   FROM C##sy94.MEMBER
  WHERE MEM_ADD1 LIKE '서울%'; 
      
사용예)2020년 6월에 구매하지 않은 회원들을 조회하시오
      Alias는 회원번호, 회원명, 성별, 마일리지
 SELECT MEM_ID AS 회원번호,
        MEM_NAME AS 회원명,
        CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN
                  '여성회원'
             ELSE '남성회원' END AS 성별,
        MEM_MILEAGE AS 마일리지
   FROM MEMBER
  WHERE MEM_ID NOT IN(SELECT DISTINCT MEM_ID
                        FROM CART
                       WHERE CART_NO LIKE '202006%');
 
3. 논리연산자 : NOT, AND, OR(우선순위순서)
 - 두 개 이상의 조건문을 결합할 때(AND, OR)
   또는 조건문의 결과를 반전시키는 경우(NOT)

사용예)키보드로 년도를 입력받아 윤년과 평년을 조회하시오
      윤년: (4의배수이며 그리고 100의 배수가 아니거나) 또는 
            (400의 배수가 되는 해)
 ACCEPT P_YEAR PROMPT '년도입력(YYYY) : '
 DECLARE
   L_YEAR NUMBER:=&P_YEAR;
   L_RESULT VARCHAR2(100);
 BEGIN
   IF(MOD(L_YEAR,4)=0 AND MOD(L_YEAR,100)!=0) OR--MOD:나머지
     (MOD(L_YEAR,400)=0) THEN
    L_RESULT:=L_YEAR||'년은 윤년입니다!'; 
   ELSE
    L_RESULT:=L_YEAR||'년은 평년입니다!';  
   END IF;--오라클에는 중괄호가 없으니 명령문으로 구분
   DBMS_OUTPUT.PUT_LINE(L_RESULT);--_LINE 줄바꿈
  END;
사용예) 마일리지가 2000이상이면서 직업이 주부인 회원정보를 조회하시오
       Alias는 회원번호, 회원명, 직업 ,마일리지
 SELECT MEM_ID AS 회원번호, 
        MEM_NAME AS 회원명, 
        MEM_JOB AS 직업,
        MEM_MILEAGE AS 마일리지
   FROM MEMBER
  WHERE MEM_MILEAGE>=2000 --마일리지가 2000이상
    AND MEM_JOB='주부'; --직업이 주부
    
사용예) 매입테이블에서 2020년 2월 매입정보를 조회하시오
       ALais는 날짜, 상품코드, 매입수량
 SELECT BUY_DATE AS 날짜, --범위를 나타날땐 AND사용
        PROD_ID AS 상품코드, 
        BUY_QTY AS 매입수량
   FROM BUYPROD
  WHERE BUY_DATE>='20200201' AND BUY_DATE<=LAST_DAY('20200201') 
  ORDER BY 1;
  --우선 양쪽의 데이터타입을 맞춘다(숫자,날짜,문자로 우선순위)
  
사용예) HR계정의 사원테이블에서 입사일이 2015년 이후 이거나 급여가 15000이상인
      사워의 사원번호,사원명,입사일,급여,부서코드를 출력하되 부서순으로 출력
 SELECT EMPLOYEE_ID AS 사원번호,
        EMP_NAME AS 사원명,
        HIRE_DATE AS 입사일,
        SALARY AS 급여,
        DEPARTMENT_ID AS 부서코드
   FROM C##HR.EMPLOYEES
  WHERE HIRE_DATE>'20151231' OR SALARY>=15000
  ORDER BY 5;

사용예) 대전에 거주하는 여성회원정보를 조회하시오
       Alias는 회원번호, 회원명, 주민등록번호, 주소
 SELECT MEM_ID AS 회원번호, 
        MEM_NAME AS 회원명, 
        MEM_REGNO1||'-'||MEM_REGNO2 AS 주민등록번호, 
        MEM_ADD1||' '||MEM_ADD2 AS 주소
   FROM MEMBER
  WHERE MEM_ADD1 LIKE '대전%' --대전거주
--  AND SUBSTR(MEM_REGNO2,1,1) IN('2','4'); --여성
    AND (SUBSTR(MEM_REGNO2,1,1)='2' OR SUBSTR(MEM_REGNO2,1,1)='4');
