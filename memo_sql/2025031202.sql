2025-0312-02)�Լ�
  
��뿹)�����ȣ�� �Է� �޾� �ټӳ���� XX�� MM�� �������� ����Ͻÿ�
     Alias�� �����ȣ,�����,�Ի���,�ټӳ��
  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         HIRE_DATE AS �Ի���,
         TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE) / 12) ||'��'|| 
         ROUND(MOD(MONTHS_BETWEEN(SYSDATE,HIRE_DATE) , 12)) ||'��' AS �ټӳ��
    FROM C##HR.EMPLOYEES;  
    
(�Լ� ���)
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
    
    L_RES:=L_YEAR||'�� '||TO_CHAR(L_MONTH,'99')||'��';
    RETURN L_RES; 
  END;
  
  
    
  
(����)  
  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         HIRE_DATE AS �Ի���,
         fn_period_emp(EMPLOYEE_ID) AS �ټӳ��
    FROM EMPLOYEES;  
    
    
��뿹)���������̺��� ��� ��ǰ�� ����򰡾��� ��ȸ�Ͻÿ�
     Alias�� ��ǰ�ڵ�,��ǰ��,������,�򰡱ݾ�
     ���Աݾ�=����*���Աݾ�
     �򰡱ݾ�=���Աݾ�+���Աݾ��� 10%
   (����)  
   SELECT B.PROD_ID AS ��ǰ�ڵ�,
          A.PROD_NAME AS ��ǰ��,
          B.REMAIN_J_99 AS ������,
          TO_CHAR(fn_amt_stock(B.PROD_ID),'999,999,999') AS �򰡱ݾ�
     FROM PROD A, REMAIN B 
    WHERE A.PROD_ID=B.PROD_ID
      AND B.REMAIN_YEAR='2020'
    ORDER BY 1;  
     
  (�Լ�)   
  CREATE OR REPLACE FUNCTION fn_amt_stock(P_PROD_ID PROD.PROD_ID%TYPE)
  RETURN NUMBER
  IS
    L_AMT_BUY NUMBER:=0;  --���Աݾ�
    L_AMT_STOCK NUMBER:=0; --����򰡾�
  BEGIN
    SELECT B.REMAIN_J_99*A.PROD_COST INTO L_AMT_BUY
      FROM PROD A, REMAIN B
     WHERE A.PROD_ID=B.PROD_ID
       AND B.PROD_ID=P_PROD_ID;
    L_AMT_STOCK:=ROUND(L_AMT_BUY*1.1);
      RETURN L_AMT_STOCK;
       
  END;


��뿹)ȸ����ȣ,��¥�� �Է¹޾� ��ٱ��Ϲ�ȣ�� �����Ͽ� ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�
  CREATE OR REPLACE FUNCTION fn_create_cart_no(
    P_MID IN MEMBER.MEM_ID%TYPE, P_DATE IN DATE)
    RETURN CHAR
  IS
    l_DATE VARCHAR2(8):=TO_CHAR(P_DATE,'YYYYMMDD');
    L_CNT NUMBER:=0; --�ش����ڿ� �α����� ȸ����
    L_CART_NO CART.CART_NO%TYPE; --�ӽ� ��ٱ��� ��ȣ
    L_MID MEMBER.MEM_ID%TYPE; --�ִ�ٱ��Ϲ�ȣ�� �����ִ� ȸ����ȣ
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
    L_MILEAGE NUMBER:=0; --������ų ���ϸ��� ��
  BEGIN
    --CART TABLE�� INSERT
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
  
 (����)
  EXEC proc_insert_cart('20200719', 'k001', 'P202000003', 1);