2025-0217-01) NULL �Լ�
1. IS NULL, IS NOT NULL
 - NULL�� ���ϴ� ������('='���δ� NULL���� �Ǵ� �Ұ�
 
2. NVL(co1, value)
 - co1 ���� NULL�̸� value�� ����ϰ� NULL�� �ƴϸ� col���� ���
 - co1�� value�� ���� Ÿ���̾�� ��
��뿹) ��ǰ���̺��� ũ������(prod_size)�� ��ȸ�ϵ�
       �� ���� NULL�̸� "ũ����������"�� ����Ͻÿ�
  SELECT PROD_ID AS ��ǰ��ȣ,
         PROD_NAME AS ��ǰ��,
         NVL(PROD_SIZE, 'ũ����������') AS ũ��
    FROM PROD;
    
��뿹)2020�� 7�� ��� ��ǰ�� �Ǹż���,�Ǹűݾ��� ��ȸ
     (��ǰ��ȣ,��ǰ��,�Ǹż���,�Ǹűݾ�)
  SELECT B.PROD_ID AS ��ǰ��ȣ,
         B.PROD_NAME AS ��ǰ��,
         NVL(SUM(A.CART_QTY),0) AS �Ǹż���,
         NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) AS �Ǹűݾ�
    FROM CART A
   RIGHT OUTER JOIN PROD B ON(A.PROD_ID=B.PROD_ID AND
         A.CART_NO LIKE '202007%')
   GROUP BY B.PROD_ID, B.PROD_NAME 
   ORDER BY 1;
-- �ڵ带 �׷�ȭ �� �������� �̸��� ���� �׷��� �ʿ�� ������ ��Ģ�̱⿡ �׷�ȭ�Ѵ�   
   
��뿹) ������̺��� ���������ڵ忡 ���� ���ʽ��� ����ϰ� ���޾��� ��ȸ�Ͻÿ�
      ���ʽ�= ���������ڵ�* �⺻��*50%
      ���޾�= �⺻��+���ʽ�. �� ���������ڵ尡 NULL�̸� 0���� ����� ��
  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         NVL(COMMISSION_PCT,0) AS ��������,
         SALARY AS �⺻��,
         ROUND(SALARY*NVL(COMMISSION_PCT,0)*0.5) AS ���ʽ�,
         ROUND(SALARY*NVL(COMMISSION_PCT,0)*0.5)+SALARY AS ���޾�  
    FROM C##HR.EMPLOYEES;
    
2. NVL2(co2, value1, value2)
 - co1���� NULL�̸� value2�� NULL�� �ƴϸ� value1�� ��ȯ
 - value1, value2�� ���� �ڷ�Ÿ�� �̾�� ��

��뿹) 2020�� 6�� ��� ȸ���� ���űݾ��� ��ȸ�ϵ� ���������� ������ '�̱���'��,
      ���������� ������ ���űݾ��� ����Ͻÿ�
  SELECT A.MEM_ID AS ȸ����ȣ,
         A.MEM_NAME AS ȸ����,
         NVL(TO_CHAR(SUM(B.CART_QTY*C.PROD_PRICE)),'�̱���') AS ���űݾ��հ�
    FROM MEMBER A-- FROM�ʿ� ���� ������ ������ LEFT �ƴϸ� RIGHT
    LEFT OUTER JOIN CART B ON(A.MEM_ID=B.MEM_ID)
    LEFT OUTER JOIN PROD C ON(B.PROD_ID=C.PROD_ID AND B.CART_NO LIKE '202006%')
   GROUP BY A.MEM_ID,A.MEM_NAME
   ORDER BY 1;
    
  SELECT A.MEM_ID AS ȸ����ȣ,
         A.MEM_NAME AS ȸ����,
         NVL(TO_CHAR(SUM(B.CART_QTY*C.PROD_PRICE),'9,999,999'),
            LPAD('�̱���',11)) AS ���űݾ��հ�
    FROM MEMBER A-- FROM�ʿ� ���� ������ ������ LEFT �ƴϸ� RIGHT
    LEFT OUTER JOIN CART B ON(A.MEM_ID=B.MEM_ID)
    LEFT OUTER JOIN PROD C ON(B.PROD_ID=C.PROD_ID AND B.CART_NO LIKE '202006%')
   GROUP BY A.MEM_ID,A.MEM_NAME
   ORDER BY 1;
--NVL2   
��뿹)��ǰ���̺��� ��������(PROD_COLOR)�� ��ȸ�Ͽ� ���������� ������ 
     '�� ������ǰ', ������ '���� ����'�� �񱳳��� ����Ͻÿ�
     Alias�� ��ǰ��ȣ,��ǰ��,����,���
  SELECT PROD_ID AS ��ǰ��ȣ,
         PROD_ID AS ��ǰ��,
         PROD_COLOR AS ����,
         NVL2(PROD_COLOR,'�� ������ǰ','���� ����') AS ���
    FROM PROD;
    
** ��ǰ���̺��� �з��ڵ� 'F301' ��ǰ���� �ǸŰ��� ���԰��� �����Ͻÿ�  
  UPDATE PROD
     SET PROD_PRICE=PROD_COST
   WHERE LPROD_GU='P301';  
   
   COMMIT;
--NULIF  
��뿹)��ǰ���̺��� �ǸŰ��� ���԰��� �����ϸ� '����������ǰ'��
     �ٸ��� �ǸŰ��� ����Ͻÿ�
     Alias�� ��ǰ�ڵ�,��ǰ��,���԰�,�ǸŰ�
  SELECT PROD_ID AS ��ǰ�ڵ�,
         PROD_NAME AS ��ǰ��,
         PROD_COST AS ���԰�,
         NVL(TO_CHAR(NULLIF(PROD_PRICE,PROD_COST),'9,999,999'),
             '����������ǰ') AS �ǸŰ�
    FROM PROD;