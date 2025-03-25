2025-0312-02)함수
  
사용예)사원번호를 입력 받아 근속년수를 XX년 MM월 형식으로 출력하시오
     Alias는 사원번호,사원명,입사일,근속년수
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         HIRE_DATE AS 입사일,
         TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE) / 12) ||'년'|| 
         ROUND(MOD(MONTHS_BETWEEN(SYSDATE,HIRE_DATE) , 12)) ||'월' AS 근속년수
    FROM C##HR.EMPLOYEES;  
    
(함수 사용)
  CREATE OR REPLACE FUNCTION fn_period_emp(
    P_EID IN EMPLOYEES.EMPLOYEE_ID%TYPE)
    RETURN VARCHAR2  
  IS
    L_RES VARCHAR2(100);
    L_YEAR NUMBER:=0;
    L_MONTH NUMBER:=0;
  BEGIN
    SELECT TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) INTO L_YEAR
      FROM EMPLOYEES
     WHERE EMPLOYEE_ID=P_EID;
     
    SELECT ROUND(MOD(MONTHS_BETWEEN(SYSDATE,HIRE_DATE),12)) INTO L_MONTH
      FROM EMPLOYEES
     WHERE EMPLOYEE_ID=P_EID;
    
    L_RES:=L_YEAR||'년 '||TO_CHAR(L_MONTH,'99')||'월';
    RETURN L_RES; 
  END;
  
  
    
  
(실행)  
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         HIRE_DATE AS 입사일,
         fn_period_emp(EMPLOYEE_ID) AS 근속년수
    FROM EMPLOYEES;  
    
    
사용예)재고수불테이블에서 모든 상품의 재고평가액을 조회하시오
     Alias는 상품코드,상품명,재고수량,평가금액
     매입금액=수량*매입금액
     평가금액=매입금액+매입금액의 10%
   (실행)  
   SELECT B.PROD_ID AS 상품코드,
          A.PROD_NAME AS 상품명,
          B.REMAIN_J_99 AS 재고수량,
          TO_CHAR(fn_amt_stock(B.PROD_ID),'999,999,999') AS 평가금액
     FROM PROD A, REMAIN B 
    WHERE A.PROD_ID=B.PROD_ID
      AND B.REMAIN_YEAR='2020'
    ORDER BY 1;  
     
  (함수)   
  CREATE OR REPLACE FUNCTION fn_amt_stock(P_PROD_ID PROD.PROD_ID%TYPE)
  RETURN NUMBER
  IS
    L_AMT_BUY NUMBER:=0;  --매입금액
    L_AMT_STOCK NUMBER:=0; --재고평가액
  BEGIN
    SELECT B.REMAIN_J_99*A.PROD_COST INTO L_AMT_BUY
      FROM PROD A, REMAIN B
     WHERE A.PROD_ID=B.PROD_ID
       AND B.PROD_ID=P_PROD_ID;
    L_AMT_STOCK:=ROUND(L_AMT_BUY*1.1);
      RETURN L_AMT_STOCK;
       
  END;


사용예)회원번호,날짜를 입력받아 장바구니번호를 생성하여 반환하는 함수를 작성하시오
  CREATE OR REPLACE FUNCTION fn_create_cart_no(
    P_MID IN MEMBER.MEM_ID%TYPE, P_DATE IN DATE)
    RETURN CHAR
  IS
    l_DATE VARCHAR2(8):=TO_CHAR(P_DATE,'YYYYMMDD');
    L_CNT NUMBER:=0; --해당일자에 로그인한 회원수
    L_CART_NO CART.CART_NO%TYPE; --임시 장바구니 번호
    L_MID MEMBER.MEM_ID%TYPE; --최대바구니번호를 갖고있는 회원번호
  BEGIN
    SELECT COUNT(*) INTO L_CNT
      FROM CART
     WHERE CART_NO LIKE L_DATE||'%'; 
     
    IF L_CNT= 0 THEN
       L_CART_NO := L_DATE||TRIM('00001');
    ELSE
       SELECT MAX(CART_NO) INTO L_CART_NO
         FROM CART
        WHERE CART_NO LIKE L_DATE||'%';
        
       SELECT DISTINCT MEM_ID INTO L_MID
         FROM CART
        WHERE CART_NO=L_CART_NO; 
        
        IF P_MID != L_MID THEN
           L_CART_NO:=L_CART_NO+1;
         END IF;  
       END IF;
       
       RETURN L_CART_NO;
  END;
  
  SELECT fn_create_cart_no('g001',TO_DATE('20200510'))
    FROM DUAL;
    
 ***********   
 CREATE OR REPLACE PROCEDURE proc_insert_cart_new(
    P_DATE IN VARCHAR2, P_MID IN MEMBER.MEM_ID%TYPE,
    P_PID IN VARCHAR2, P_QTY IN NUMBER)
  IS
    L_MILEAGE NUMBER:=0; --증가시킬 마일리지 값
  BEGIN
    --CART TABLE에 INSERT
    INSERT INTO CART
      VALUES(P_MID, fn_create_cart_no(P_PID, TO_DATE(P_DATE)), P_PID, P_QTY);

    --REMAIN TABLE UPDATE
    UPDATE REMAIN
       SET REMAIN_O = REMAIN_O+P_QTY,
           REMAIN_J_99 = REMAIN_J_99-P_QTY,
           REMAIN_DATE = TO_DATE(P_DATE)
     WHERE PROD_ID = P_PID;
     
    --MEMBER TABLE UPDATE
    SELECT P_QTY * PROD_MILEAGE INTO L_MILEAGE
      FROM PROD
     WHERE PROD_ID = P_PID;
    
    UPDATE MEMBER
       SET MEM_MILEAGE = MEM_MILEAGE+L_MILEAGE
     WHERE MEM_ID = P_MID;
    
   COMMIT;
  END;
  
 (실행)
  EXEC proc_insert_cart('20200719', 'k001', 'P202000003', 1);