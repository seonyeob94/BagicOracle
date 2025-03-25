2025_0213_01) 숫자함수
  - 수학적함수(ABS,SIGN,POWER,SQRT,LOG,...)
  - ROUND,TRUNC
  - FLOOR,CEIL
  - GREATEST, LEAST
  - MOD
  
사용예)
  SELECT ABS(90), ABS(-0.999),
         SIGN(20000), SIGN(-0.00009),
         TRUNC(SQRT(3.3),3),
         POWER(2,10)
    FROM DUAL;     
    
사용예)사원테이블에서 영업실적에 따른 보너스를 구하여 출력하시오
     단, 영업실적이 있는 사원만 출력하며 보너스는 반올림하여 소수1자리까지 출력
     보너스=기본금(SALARY)*영업실적(COMMISSION_PCT)
     Alias는 사원번호,사원명,부서번호,영업실적,보너스
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         DEPARTMENT_ID AS 부서번호,
         COMMISSION_PCT AS 영업실적,
         ROUND(SALARY*COMMISSION_PCT,1) AS 보너스
    FROM C##HR.EMPLOYEES
   WHERE COMMISSION_PCT IS NOT NULL; --NULL의 경우 반드시 IS를 이용해야함
   
사용예)회원테이블에서 각 회원의 연령대를 조회하시오 나이는 생년월일을
     이용하여 구하시오
  SELECT MEM_NAME,
         EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS 나이,
         LPAD(TRUNC((EXTRACT(YEAR FROM SYSDATE)-
                     EXTRACT(YEAR FROM MEM_BIR))/10)*10||'대',5) AS 연령대
    FROM MEMBER;     
    
-- GREATEST/LEAST
  SELECT GREATEST(100,500,20),
         GREATEST('홍길동','홍길순','홍성남'),
         LEAST('대한민국','KOREA','!!!@@'),
         ASCII('대'),ASCII('K'),ASCII('!')
    FROM DUAL;     
     
[문제] 회원테이블에서 마일리지가 1000미만인 회원의 마일리지는 1000으로, 1000이상인 회원의
     마일리지는 그대로 출력하시오
     Alisa는 회원번호,회원명,원본마일리지,변경마일리지
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_MILEAGE AS 원본마일리지,
         GREATEST(MEM_MILEAGE,1000) AS 변경마일리지
    FROM MEMBER;
     
