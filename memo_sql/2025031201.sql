2025-0312-01)User Defined Function(Function)
 - ��ȯ ���� �ִ� ���
 - select���� DML��� ���ο��� ����� �� �ִ�.
 (�������)
   CREATE [OR REPLACE] FUNCTION �Լ���
    [(������ [IN|OUT|INOUT] ������ Ÿ��,...)]
    RETURN ������ Ÿ��
   AS|IS
     ���𿵿�
   BEGIN
     ���࿵��
   END;
   . ���࿵������ �ݵ�� �ϳ� �̻��� RETURN���� �����Ͽ� 
     ����� ��ȯ�ؾ� ��
   . 'RETURN ������ Ÿ��'�̳� '������ [IN|OUT|INOUT] ������ Ÿ��'����
     ������ Ÿ�Ը� ����ؾ� ��(ũ�����ϸ� ����)
     
��뿹)���� �Է¹޾� �ش� ���� ���Աݾ��� ��ȯ�ϴ� ���ν����� ����Ͻÿ�
  
  CREATE OR REPLACE PROCEDURE proc_amt_buyprod(
    P_MONTH IN VARCHAR2, 
    P_AMT_BUY OUT NUMBER)
  IS
    L_START DATE:=TO_DATE('2020'||TO_CHAR(P_MONTH, '00')||'01');  
    L_END DATE:=LAST_DAY(L_START);
  BEGIN
    SELECT SUM(A.BUY_QTY*B.PROD_COST) INTO P_AMT_BUY
      FROM BUYPROD A, PROD B
     WHERE A.PROD_ID=B.PROD_ID
       AND A.BUY_DATE BETWEEN L_START AND L_END;
       
     EXCEPTION
       WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('���ܹ߻�: '||SQLERRM);
  END;
  
[����]
  DECLARE
    L_AMT_BUY NUMBER:=0;
  BEGIN
    proc_amt_buyprod(9,L_AMT_BUY);
    DBMS_OUTPUT.PUT_LINE('���Աݾ� �հ�:'||
                                   TO_CHAR(NVL(L_AMT_BUY,0),'999,999,999'));
  END;

��뿹)���� ��¥(2020�� 7�� 12��)�� ���� �����ڷḦ ó���Ͻÿ�.
-------------------------
  ��ǰ�ڵ�        ���Լ���
-------------------------
 P201000005     30
 2020  P201000005  9  58  4  63  2020/07/31
                   9  88  4  93  2020/07/12               
 P201000018     15
 2020	P201000018	11	544	108	490	2020/07/21
                        559 108 505 2020/07/12
2020	P201000018	11	559	108	505	2020/07/12                
 EXECUTE proc_insert_buyprod(TO_DATE('20200712'),'P201000018',15);
 P302000014     20
COMMIT;

  �������̺� INSERT -> ���������̺� UPDATE
  INSERT INTO BUYPROD VALUES(TO_DATE('20200712'), 'P201000005',30);
  UPDATE REMAIN
     SET REMAIN_I=REMAIN_I+30,
         REMAIN_J_99=REMAIN_J_99+30,
         REMAIN_DATE=TO_DATE('20200712')
   WHERE REMAIN_YEAR='2020'
     AND PROD_ID='P201000005';
     

  CREATE OR REPLACE PROCEDURE proc_insert_buyprod(
    P_BUY_DATE IN DATE, P_PROD_ID IN VARCHAR2, P_QTY IN NUMBER)
  IS
  BEGIN
    INSERT INTO BUYPROD 
       VALUES(P_BUY_DATE, P_PROD_ID,p_QTY);
       
    UPDATE REMAIN
     SET REMAIN_I=REMAIN_I+P_QTY,
         REMAIN_J_99=REMAIN_J_99+P_QTY,
         REMAIN_DATE=P_BUY_DATE
   WHERE REMAIN_YEAR='2020'
     AND PROD_ID=P_PROD_ID;   
  COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('���ܹ߻�: '||SQLERRM);
      ROLLBACK;
  END;
  2020�� 7�� 12
��뿹) ���ó�¥(2020�� 7�� 19��)�� �����ڷᰡ ������ ����.
     �̸� ó���ϴ� ���ν����� �ۼ��Ͻÿ�
 ---------------------------------------
   ����ȸ��   ��ǰ�ڵ�         ����
 ---------------------------------------  
--    f001    p201000003     2
--            p202000003     1
    U001    p201000003     2
    2020 P201000003 9 24 7 26 2020/07/31
    2020 P201000003 9 24 9 24 2020/07/19
    ���ϸ��� 2700->2726
    
    EXEC proc_insert_cart('20200719','u001','P201000003',2);
    
    f001    p202000003     1         
     ���ϸ��� 2700->2709(?)
     2020 p202000003 9 16 17 8 2020/0731
     
    EXEC proc_insert_cart('20200719','f001','P202000003',1);
     
     
            
  CREATE OR REPLACE PROCEDURE proc_insert_cart(
    P_DATE IN VARCHAR2, P_MID IN MEMBER.MEM_ID%TYPE,
    P_PID IN VARCHAR2, P_QTY IN NUMBER)
  IS
    L_CNT NUMBER:=0; --�ش����ڿ� �α����� ȸ����
    L_CART_NO CART.CART_NO%TYPE; --�ӽ� ��ٱ��� ��ȣ
    L_MID MEMBER.MEM_ID%TYPE; --�ִ�ٱ��Ϲ�ȣ�� �����ִ� ȸ����ȣ
    L_MILEAGE NUMBER:=0; -- ������ų ���ϸ���
  BEGIN
    --CART TABLE INSERT
    SELECT COUNT(*) INTO L_CNT
      FROM CART
     WHERE CART_NO LIKE P_DATE||'%'; 
     
    IF L_CNT= 0 THEN
       L_CART_NO := P_DATE||TRIM('00001');
    ELSE
       SELECT MAX(CART_NO) INTO L_CART_NO
         FROM CART
        WHERE CART_NO LIKE P_DATE||'%';
        
       SELECT DISTINCT MEM_ID INTO L_MID
         FROM CART
        WHERE CART_NO=L_CART_NO; 
        
        IF P_MID !=L_MID THEN
           L_CART_NO:=L_CART_NO+1;
         END IF;  
       END IF;
       
       
       INSERT INTO CART VALUES(P_MID,L_CART_NO,P_PID,P_QTY);
    --REMAIN TABLE UPDATE
    UPDATE REMAIN
       SET REMAIN_O=REMAIN_O+P_QTY,
           REMAIN_J_99=REMAIN_J_00-P_QTY,
           REMAIN_DATE=TO_DATE(P_DATE)
     WHERE PROD_ID=P_PID;     
    --MEMBER TABLE UPDATE
    SELECT P_QTY*PROD_MILEAGE INTO L_MILEAGE
      FROM PROD
     WHERE PROD_ID=P_PID;
     
    UPDATE MEMBER
       SET MEM_MILEAGE=MEM_MILEAGE+L_MILEAGE
     WHERE MEM_ID=P_MID;
     
     COMMIT;
  END;











