2025-0210-03)SELECT ��

��뿹) ���ι� �����ͺ��̽��� �з����̺�(LPRD)�� ��� �ڷḦ �˻��Ͻÿ�
  SELECT *
    FROM C##sy94.LPROD;
    
  SELECT LPROD_ID AS ����,
         LPROD_GU AS �з��ڵ�,
         LPROD_NAME AS �з���
    FROM C##sy94.LPROD;   
    
 CREATE SYNONYM LPROD FOR C##sy94.LPROD;
 CREATE SYNONYM PROD FOR C##sy94.PROD;
 CREATE SYNONYM CART FOR C##sy94.CART;
 CREATE SYNONYM MEMBER FOR C##sy94.MEMBER;
 CREATE SYNONYM BUYER FOR C##sy94.BUYER;
 CREATE SYNONYM BUYPROD FOR C##sy94.BUYPROD;

��뿹) HR������ �μ����̺�(DEPARTMENTS)�� ��� �ڷḦ ��ȸ�Ͻÿ�

 CREATE SYNONYM DEPARTMENTS FOR C##HR.DEPARTMENTS;
 
 SELECT *
   FROM DEPARTMENTS;
 
��뿹) ���ι� �����ͺ��̽��� �� ���̺�(MEMBER)�� ��� �������� ��ȸ�Ͻÿ�

 SELECT *
   FROM MEMBER;
��뿹) ���ι� �����ͺ��̽��� ��ǰ���̺�(PROD)�� ���� �з��ڵ带 �ߺ����� 
       ��ȸ�Ͻÿ� --�ߺ��� �����ϱ� ���� DISTINCT ���
  SELECT DISTINCT LPROD_GU AS �з��ڵ�
    FROM PROD;

��뿹) ���ι� �����ͺ��̽��� ȸ�����̺�(MEMBER)���� ����ȸ����
       ȸ����ȣ, ȸ����, �ּ�, ���ϸ����� ��ȸ�ϵ� ���ϸ����� ���� ȸ������
       ����Ͻÿ�
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE SUBSTR(MEM_REGNO2,1,1) IN('2','4') --�����ڷ�
--  ORDER BY MEM_MILEAGE DESC;
--  ORDER BY 4 DESC;
   ORDER BY ���ϸ��� DESC;