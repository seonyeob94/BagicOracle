2025-0313-01)
��뿹)��ǰ�ڵ带 �Է� �޾� 2020�� �Ǹ�Ƚ���� �Ǹűݾ� �հ踦 ��ȸ�ϴ� �Լ���
     �ۼ��Ͻÿ�
(�Ǹ�Ƚ�� ��ȯ)
  CREATE OR REPLACE FUNCTION fn_count_sale(P_PID IN PROD.PROD_ID%TYPE)
    RETURN NUMBER
    IS
      L_CNT NUMBER:=0; --�Ǹ�Ƚ��
    BEGIN
      SELECT COUNT(*) INTO L_CNT
        FROM CART
       WHERE PROD_ID=P_PID;
      RETURN L_CNT;    
    END;
    
(�Ǹűݾ� ��ȯ)
  CREATE OR REPLACE FUNCTION fn_sum_sale(P_PID IN PROD.PROD_ID%TYPE)
    RETURN NUMBER
    IS
      L_SUM NUMBER:=0; --�Ǹűݾ��հ�
    BEGIN
      SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO L_SUM
        FROM CART A, PROD B
       WHERE A.PROD_ID=B.PROD_ID
         AND A.PROD_ID=P_PID;
      RETURN L_SUM;    
    END;
    
(����)    
  SELECT PROD_ID AS ��ǰ�ڵ�,
         PROD_NAME AS ��ǰ��,
         NVL(fn_count_sale(PROD_ID),0) AS �Ǹ�Ƚ��,
         TO_CHAR(NVL(fn_sum_sale(PROD_ID),0),'999,999,999') AS �Ǹűݾ�
    FROM PROD; 