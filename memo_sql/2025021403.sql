2025-0214-03) ROLLUP�� CUBE
 - GROUP BY �� �ȿ� ����Ͽ� �پ��� ���踦 ��ȯ
1. ROLLUP
 - ������ ���踦 ��ȯ
 --���δ� ������ GROUP BY�� �ȿ� ���
�������)
  GROUP BY [�÷���,] ROLLUP(�÷��� [,...]) [,�÷���...]
  - ROLLUP �� �ȿ� ����� �÷����� ��� ����� ���踦 ��ȯ�� ��
    �����ʺ��� �ϳ��� �÷����� ������ ���踦 ��ȯ��.
  - ���������� ��� �÷��� ����(ROLLUP�� ���� �÷��� �ش�)�� ����(��ü����)
    �� ��ȯ�Ͽ� ROLLUP���� ���� �÷��� ���� n���϶� n+1������ �����ȯ
  - ROLLUP �ۿ� �÷��� ����� ���(ex GROUP BY �÷���, ROLLUP(col1,col2))
    �κ� ROLLUP�̶��ϸ� �� ��� 'GROUP BY �÷���'���� '�÷���'�� ����� �ش�
    �Ǿ� ��ü ����� ��ȯ���� ����

��뿹)��ٱ������̺��� ����,ȸ����,��ǰ�� �Ǹż����հ踦 ��ȸ�Ͻÿ�    
(ROLLUP�� �̻��)
  SELECT SUBSTR(CART_NO,5,2) AS ��,
         MEM_ID AS ȸ����ȣ,
         PROD_ID AS ��ǰ�ڵ�,
         SUM(CART_QTY) AS �Ǹż����հ� 
    FROM CART
   GROUP BY SUBSTR(CART_NO,5,2), MEM_ID, PROD_ID
   ORDER BY 1;
   
(ROLLUP�� ���)
  SELECT SUBSTR(CART_NO,5,2) AS ��,
         MEM_ID AS ȸ����ȣ,
         PROD_ID AS ��ǰ�ڵ�,
         SUM(CART_QTY) AS �Ǹż����հ� 
    FROM CART
   GROUP BY ROLLUP(SUBSTR(CART_NO,5,2), MEM_ID, PROD_ID)
   ORDER BY 1;
   
   
(�κ� ROLLUP�� ���)
  SELECT SUBSTR(CART_NO,5,2) AS ��,
         MEM_ID AS ȸ����ȣ,
         PROD_ID AS ��ǰ�ڵ�,
         SUM(CART_QTY) AS �Ǹż����հ� 
    FROM CART
   GROUP BY SUBSTR(CART_NO,5,2), ROLLUP(MEM_ID, PROD_ID)
   ORDER BY 1;
   
1. CUBE
 - CUBE���� ���� �÷��� ��ȸ�Ͽ� �߻��ϴ� ��� ����� ����ŭ�� �����ȯ
 
�������)
  GROUP BY [�÷���,] CUBE(�÷��� [,...]) [,�÷���...]
  . CUBE ���� ����� �÷��� ���� n���϶� ����� 2^n������
  . ������ Ư¡�� ROLLUP�� ����
  �� ȸ�� ��ǰ
  �� ȸ��
  �� ��ǰ
  ȸ�� ��ǰ
  ��
  ȸ��
  ��ǰ
  ��ü����
   
(CUBE�� ���)
  SELECT SUBSTR(CART_NO,5,2) AS ��,
         MEM_ID AS ȸ����ȣ,
         PROD_ID AS ��ǰ�ڵ�,
         SUM(CART_QTY) AS �Ǹż����հ� 
    FROM CART
   GROUP BY CUBE(SUBSTR(CART_NO,5,2), MEM_ID, PROD_ID)
   ORDER BY 1;
   
   
(�κ� CUBE�� ���)
  SELECT SUBSTR(CART_NO,5,2) AS ��,
         MEM_ID AS ȸ����ȣ,
         PROD_ID AS ��ǰ�ڵ�,
         SUM(CART_QTY) AS �Ǹż����հ� 
    FROM CART
   GROUP BY SUBSTR(CART_NO,5,2), CUBE(MEM_ID, PROD_ID)
   ORDER BY 1;