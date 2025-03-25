2025-0213-02) 날짜함수
 - SYSDATE, SYSTIMESTAMP
 - ADD_MONTHS,MONTHS_BETWEEN
 - NEXT_DAY, LAST_DAY
 
 --ADD_MONTHS/SYSDATE
사용예)HR계정의 사원테이블의 모든 입사일을 6년 뒤로 변경하시오
 UPDATE C##HR.EMPLOYEES
    SET HIRE_DATE=ADD_MONTHS(HIRE_DATE,70);

 SELECT MOD(TRUNC(SYSDATE)-TRUNC(TO_DATE('00010101'))-1,7)--오늘 요일 구하기
   FROM DUAL;
--요일   
 SELECT CASE MOD(TRUNC(SYSDATE)-TRUNC(TO_DATE('00010101'))-1,7)
             WHEN 0 THEN '일요일'
             WHEN 1 THEN '월요일'
             WHEN 2 THEN '화요일'
             WHEN 3 THEN '수요일'
             WHEN 4 THEN '목요일'
             WHEN 5 THEN '금요일'
             ELSE '토요일'
        END AS DYDLF     
   FROM DUAL;  
   
--NEXT_DAT/LAST_DAY
  SELECT TO_CHAR(SYSDATE,'DAY'),
        NEXT_DAY(SYSDATE,'목'),
        NEXT_DAY(SYSDATE,'화요일')
   FROM DUAL;    
   
사용예)매입 테이블에서 2020년 2월 제품별 매입수량고 매입금액을 조회하시오
  SELECT A.PROD_ID AS 상품코드,
         B.PROD_NAME AS 상품명,
         SUM(A.BUY_QTY) AS 매입수량,
         SUM(A.BUY_QTY*B.PROD_COST) AS 매입금액
    FROM BUYPROD A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND A.BUY_DATE BETWEEN TO_DATE('20200201') AND 
                   LAST_DAY(TO_DATE('20200201'))
   GROUP BY A.PROD_ID, B.PROD_NAME;                

  SELECT TRUNC(TO_DATE('20200819'),'Q') FROM DUAL;
  
--EXTRACT
사용예)회원테이블에서 회원들의 출생월에 따라 보너스를 지급하려 한다
      이번달 보너스를 받는 회원정보를 조회하시오
      Alias는 회원정보,회원명,생년월일,마일리지
  SELECT MEM_ID AS 회원정보,
         MEM_NAME AS 회원명,
         MEM_BIR AS 생년월일,
         MEM_MILEAGE AS 마일리지
    FROM MEMBER
   WHERE EXTRACT(MONTH FROM SYSDATE)=EXTRACT(MONTH FROM MEM_BIR);
   
--MONTHS_BETWEEN(date1, date2)
 .date1과 date2 사이에 존재하는 개월 수
 .소수점 발생 가능(TRUNC 사용해서 제거)

사용예) 사원테이블에서 각 사원들의 근속년수를 XX년 XX개월 형식으로 출력
  SELECT EMPLOYEE_ID,
         EMP_NAME,
         HIRE_DATE,
         TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)||'년 '||
         TRUNC(MOD(MONTHS_BETWEEN(SYSDATE,HIRE_DATE),12))||'개월'
    FROM C##HR.EMPLOYEES;   

  


