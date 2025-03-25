2025_0212-01)문자열 함수
 - CONCAT, LPAD,RPAD,LTRIM,RTRIM,TRIM, LENGTH,
   SUBRT,REPLACE, INSTR
   
사용예)
  SELECT MEM_ID, MEM_NAME, CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2),
         MEM_REGNO1||'-'||MEM_REGNO2
    FROM MEMBER;
--LOWER,UPPER,INITCAP    
사용예)회원테이블에서 'C001'회원의 회원명,전화번호(핸드폰)정보를 출력하시오
  SELECT MEM_NAME AS 회원명,
         MEM_HP AS "전화번호(핸드폰)" --오라클이 인식할 수 없는 ()를 사용했으니 ""로 인식할수 있게 해준다
    FROM MEMBER
   WHERE UPPER(MEM_ID)='C001';
   
  SELECT EMPLOYEE_ID AS 사원번호, 
         EMP_NAME AS "사원명(원)", 
         LOWER(EMP_NAME) AS "사원명2", 
         INITCAP(LOWER(EMP_NAME)) AS "사원명3"
    FROM C##HR.EMPLOYEES
   WHERE HIRE_DATE >='20180101'; 
   
--LPAD,RPAD
  SELECT PROD_NAME, PROD_SIZE, LPAD(PROD_SIZE, 10, '*'),
         LPAD(PROD_SIZE, 12)
    FROM PROD
--LTRIM,RTRIM,TRIM
  SELECT LTRIM('ABBAACPPLEABBA','AB'),RTRIM('ABBAACPPLEABBA','AB')
    FROM DUAL;
    COMMIT;
 --PROD의 편집에 들어가 PROD_NAME을 VARCHAR2(40)에서 CHAR(40)로 바꾼뒤 원복시킬때는 반드시 공백을 제거
  UPDATE PROD
     SET PROD_NAME=TRIM(PROD_NAME);
  
  SELECT PROD_ID,PROD_NAME,PROD_PRICE
    FROM PROD;
    
--SUBSTR -- CASE WHEN은 자바의 IF라고 생각
사용예)회원테이블에서 주민번호를 이용하여 나이를 구하고 연령대를 출력하시오
     Alias는 회원번호,회원명,주민번호,나이,연령대
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
         CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','2') THEN
            EXTRACT(YEAR FROM SYSDATE)- 
              TO_NUMBER(CONCAT('19',SUBSTR(MEM_REGNO1,1,2)))
      ELSE  EXTRACT(YEAR FROM SYSDATE)- 
              TO_NUMBER(CONCAT('20',SUBSTR(MEM_REGNO1,1,2)))
         END AS 나이,
         CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','2') THEN
              TRUNC((EXTRACT(YEAR FROM SYSDATE)- 
              TO_NUMBER(CONCAT('19',SUBSTR(MEM_REGNO1,1,2))))/10)*10
         ELSE TRUNC((EXTRACT(YEAR FROM SYSDATE)- 
              TO_NUMBER(CONCAT('20',SUBSTR(MEM_REGNO1,1,2))))/10)*10
         END AS 연령대
    FROM MEMBER;
    
사용예)장바구니테이블에서2020년 6월 ~7월 판매정보를 조회하시오
      Alias는 날짜,상품코드,판매수량
  SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS 날짜,
         PROD_ID AS 상품코드,
         CART_QTY AS 판매수량
    FROM CART
--   WHERE SUBSTR(CART_NO,1,6)>='202006' 
--     AND SUBSTR(CART_NO,1,6)<='202007' 
   WHERE SUBSTR(CART_NO,1,6) BETWEEN '202006' AND '202007'
   ORDER BY 1;
   
--REPLACE(data, 'char1', [, 'char2'])
  - 문자열 대치
  - data에서 'char1'을 찾아 'char2'로 바꿈
  - 'char2'가 생략되면 찾은 'char1'을 삭제
사용예)상품테이블의 PROD_OULINE칼럼의 값 중 '....'을 찾아 삭제하시오
  SELECT PROD_NAME,
         PROD_OUTLINE,
         REPLACE(PROD_OUTLINE,'.')
    FROM PROD; 
    
  SELECT PROD_NAME,
         REPLACE(PROD_NAME,'대우','APPLE'),
         REPLACE(PROD_NAME,' ')
    FROM PROD;