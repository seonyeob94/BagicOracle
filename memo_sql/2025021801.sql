2025_0218_01)JOIN
 - ���� ���� ���̺� ���̿� �����ϴ� ���� �Ӽ��� �̿��� ����
 - �з�
   . ��������/�ܺ�����
   . �Ϲ�����/ANSI ����
   . ��������/�񵿵�����/SELF JOIN
   
1) Cartesian Product (CROSS JOIN)
 - ���������� ���ų� ���������� �߸� ����� ���
 - �ݵ�� �ʿ�ġ ���� ��� ����ؼ��� �ȵ�
 - ��� : �� ���̺��� ���� ��� ���� ���� ���� ���� ���� ������ ����� ��ȯ
 
�������: �Ϲ�����)
  SELECT Į��list
    FROM ���̺��1  [��Ī1], ���̺��2 [��Ī2],...
  [WHERE ��������]
    [AND �Ϲ�����]   --������ AND�� ����

�������: ANSI����)
  SELECT Į��list
    FROM ���̺��1  [��Ī1]
   CROSS JOIN ���̺��2 [��Ī2] [ON(��������)],... 
  [WHERE �Ϲ�����] 
  
��뿹)
  SELECT 'BUYPROD : '||COUNT(*) AS "���� ��" FROM BUYPROD
  UNION
  SELECT 'PROD : '||COUNT(*) FROM PROD
  UNION
  SELECT 'CART : '||COUNT(*) FROM CART;

  SELECT *
    FROM CART,PROD,BUYPROD;
    
  SELECT COUNT(*)
    FROM CART
   CROSS JOIN PROD
   CROSS JOIN BUYPROD;

2. ��������(EQUI-JOIN,INNER JOIN)
 - ��κ��� ����
 - �������ǿ� '=' �����ڰ� ���� ���
 - ���������� �������� �ʴ� �ڷ�� ������
 - ���� ���̺��� ��-1�� �̻��� ���������� ����ؾ���
 
�������:�Ϲ�����) 
  SELECT Į��list
    FROM ���̺��1  [��Ī1], ���̺��2 [��Ī2],...
   WHERE ��������
    [AND ��������,...]
    [AND �Ϲ�����]

�������: ANSI����)
  SELECT Į��list
    FROM ���̺��1  [��Ī1]
   INNER JOIN ���̺��2 [��Ī2] ON(�������� [AND �Ϲ�����1]) 
   INNER JOIN ���̺��3 [��Ī2] ON(�������� [AND �Ϲ�����2]) 
         :
  [WHERE �Ϲ�����] --��� ����Ŭ�� �������� ��
  - '���̺��1'�� '���̺��2'�� �ݵ�� ���� ���εǾ�� ��--�ݵ�� �����÷��� ������ �־����
  - '�Ϲ�����1'�� '���̺��1'�� '���̺��2'�� ���õ� ����
  - '���̺��3'�� '���̺��1'�� '���̺��2'�� ���� ����� ����
  - 'WHERE �Ϲ�����' : ��� ���̺� ���õ� ����
  -**���������� ���' �Ϲ�����'�� ON���� ����ϰų� WHERE���� ����ص� ����� ����
     ��, �ܺ������� ��� '�Ϲ�����'�� WHERE���� ����ϸ� �������� ����� �ٲ�
��뿹)2020�� 1�� ���������� ����Ͻÿ�.(Alias�� ����,��ǰ�ڵ�,��ǰ��,����)
(�Ϲ�����)--������ �÷����̸� ��Ī �Ⱥ����� ��
  SELECT BUYPROD.BUY_DATE AS ����,
         PROD.PROD_ID AS ��ǰ�ڵ�,
         PROD.PROD_NAME AS ��ǰ��,
         BUYPROD.BUY_QTY AS ����
    FROM BUYPROD,PROD
   WHERE BUYPROD.PROD_ID=PROD.PROD_ID
     AND BUYPROD.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
   ORDER BY 1;  
   
(ANSI FORMAT) 
  SELECT A.BUY_DATE AS ����,
         A.PROD_ID AS ��ǰ�ڵ�,
         B.PROD_NAME AS ��ǰ��,
         A.BUY_QTY AS ����
    FROM BUYPROD A 
 --  INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID AND A.BUY_DATE BETWEEN 
 --        TO_DATE('20200101') AND TO_DATE('20200131'))
 --  ORDER BY 1;      
   INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
   WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
   ORDER BY 1;      

��뿹)������̺��� 10,20,60,90�� �μ��� ��������� ����Ͻÿ�.
     Alias�� �����ȣ,�����,�μ���ȣ,�μ���,��å�ڵ�,��å��
(�Ϲ�����)  
  SELECT A.EMPLOYEE_ID AS �����ȣ,
         A.EMP_NAME AS �����,
         B.DEPARTMENT_ID AS �μ���ȣ,
         B.DEPARTMENT_NAME AS �μ���,
         A.JOB_ID AS ��å�ڵ�,
         C.JOB_TITLE AS ��å��   
    FROM C##HR.EMPLOYEES A, C##HR.DEPARTMENTS B, C##HR.JOBS C 
   WHERE A.DEPARTMENT_ID IN (10,20,60,90) --�Ϲ�����
     AND A.DEPARTMENT_ID=B.DEPARTMENT_ID  -- ��������(�μ����� ����)
     AND A.JOB_ID=C.JOB_ID --��������(��å���� ����)
   ORDER BY 3;  
     
(ANSI JOIN) 
  SELECT A.EMPLOYEE_ID AS �����ȣ,
         A.EMP_NAME AS �����,
         B.DEPARTMENT_ID AS �μ���ȣ,
         B.DEPARTMENT_NAME AS �μ���,
         A.JOB_ID AS ��å�ڵ�,
         C.JOB_TITLE AS ��å��   
    FROM C##HR.EMPLOYEES A
   INNER JOIN C##HR.JOBS C ON(A.JOB_ID=C.JOB_ID)
   INNER JOIN C##HR.DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID
     AND B.DEPARTMENT_ID IN (10,20,60,90))
   ORDER BY 3;  
    
��뿹)2020�� 6�� ��ǰ�� �������踦 ����Ͻÿ�.
    (Alias�� ��ǰ�ڵ�,��ǰ��,��������հ�,����ݾ��հ�)
(�Ϲ�����)
  SELECT A.PROD_ID AS ��ǰ�ڵ�,
         A.PROD_NAME AS ��ǰ��,
         SUM(B.CART_QTY) AS ��������հ�,
         SUM(A.PROD_PRICE*B.CART_QTY) AS ����ݾ��հ�
    FROM PROD A, CART B
   WHERE A.PROD_ID=B.PROD_ID -- ��������(������ ����)
   --  AND SUBSTR(B.CART_NO,5,2) = 06 
     AND B.CART_NO LIKE '202006%'   
   GROUP BY A.PROD_ID, A.PROD_NAME
   ORDER BY 1;
    
(ANSI JOIN) 
  SELECT A.PROD_ID AS ��ǰ�ڵ�,
         A.PROD_NAME AS ��ǰ��,
         SUM(B.CART_QTY) AS ��������հ�,
         SUM(A.PROD_PRICE*B.CART_QTY) AS ����ݾ��հ�
    FROM PROD A
   INNER JOIN CART B ON(A.PROD_ID=B.PROD_ID AND B.CART_NO LIKE '202006%')
   GROUP BY A.PROD_ID, A.PROD_NAME
   ORDER BY 1;
    
    
��뿹)������̺��� �μ��� �ο����� ��ȸ�Ͻÿ�
     Alias �μ���ȣ,�μ���,�ο���
(�Ϲ� ����)
  SELECT A.DEPARTMENT_ID AS �μ���ȣ,
         B.DEPARTMENT_NAME AS �μ���,
         COUNT(A.EMPLOYEE_ID) AS �ο���
    FROM C##HR.EMPLOYEES A, C##HR.DEPARTMENTS B
   WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
   GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
   ORDER BY 1;
   
(ANSI JOIN)
  SELECT A.DEPARTMENT_ID AS �μ���ȣ,
         B.DEPARTMENT_NAME AS �μ���,
         COUNT(A.EMPLOYEE_ID) AS �ο���
    FROM C##HR.EMPLOYEES A
   INNER JOIN C##HR.DEPARTMENTS B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
   GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
   ORDER BY 1;
   
     
     
��뿹)2020�� ��ݱ� ���������� ��ȸ�Ͻÿ�
     Alias�� ��, ���Լ���, ���Աݾ�
(�Ϲ� ����)
  SELECT EXTRACT(MONTH FROM BUY_DATE)||'��' AS ��, 
         SUM(A.BUY_QTY) AS ���Լ���, 
         SUM(B.PROD_COST*A.BUY_QTY) AS ���Աݾ�
    FROM BUYPROD A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
   GROUP BY EXTRACT(MONTH FROM BUY_DATE); 
   
(ANSI JOIN)
  SELECT EXTRACT(MONTH FROM BUY_DATE)||'��' AS ��, 
         SUM(A.BUY_QTY) AS ���Լ���, 
         SUM(B.PROD_COST*A.BUY_QTY) AS ���Աݾ�
    FROM BUYPROD A
   INNER JOIN PROD B ON(A.PROD_ID=B.PROD_ID)
   GROUP BY EXTRACT(MONTH FROM BUY_DATE);  
     
     
     
��뿹)2020�� �ŷ�ó�� ������ ��ȸ�Ͻÿ�. 
      ������� �ش� �ŷ�ó���� ��ǰ�ϴ� ��ǰ�� �Ǹž�
      Alias�� �ŷ�ó�ڵ�,�ŷ�ó��,�����
(�Ϲ� ����)
  SELECT B.BUYER_ID AS �ŷ�ó�ڵ�,
         B.BUYER_NAME AS �ŷ�ó��,
         SUM(A.PROD_PRICE*C.CART_QTY) AS �����
    FROM PROD A, BUYER B, CART C
   WHERE C.CART_NO LIKE '2020%'
     AND A.BUYER_ID=B.BUYER_ID
     AND A.PROD_ID=C.PROD_ID
   GROUP BY B.BUYER_ID, B.BUYER_NAME  
   ORDER BY 1;
   
(ANSI JOIN)
  SELECT B.BUYER_ID AS �ŷ�ó�ڵ�,
         B.BUYER_NAME AS �ŷ�ó��,
         SUM(A.PROD_PRICE*C.CART_QTY) AS �����
    FROM PROD A
   INNER JOIN BUYER B ON(A.BUYER_ID=B.BUYER_ID)
   INNER JOIN CART C ON(A.PROD_ID=C.PROD_ID)
   WHERE C.CART_NO LIKE '2020%'
   GROUP BY B.BUYER_ID, B.BUYER_NAME  
   ORDER BY 1;

��뿹)HR�������� �繫���� �̱� �̿��� ���� �ִ� �μ��� ����
      ������� ��ȸ�Ͻÿ�
      Alias�� �����ȣ,�����,�μ���ȣ,�μ���,�ּ�
      �ּҴ� STREET_ADDRESS+CITY+STATE_PROVINCE �� ������
(�Ϲ� ����)      
  SELECT B.EMPLOYEE_ID AS �����ȣ,
         B.EMP_NAME AS �����,
         A.DEPARTMENT_ID AS �μ���ȣ,
         A.DEPARTMENT_NAME AS �μ���,
         C.STREET_ADDRESS||', '||C.CITY||', '||C.STATE_PROVINCE||', '||D.COUNTRY_NAME AS �ּ�
    FROM C##HR.DEPARTMENTS A, C##HR.EMPLOYEES B, C##HR.LOCATIONS C, C##HR.COUNTRIES D
   WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
     AND A.LOCATION_ID=C.LOCATION_ID
     AND C.COUNTRY_ID=D.COUNTRY_ID
     AND C.COUNTRY_ID NOT IN ('US')
   ORDER BY 1; 

(ANSI JOIN)    
  SELECT B.EMPLOYEE_ID AS �����ȣ,
         B.EMP_NAME AS �����,
         A.DEPARTMENT_ID AS �μ���ȣ,
         A.DEPARTMENT_NAME AS �μ���,
         C.STREET_ADDRESS||', '||C.CITY||', '||C.STATE_PROVINCE||', '||D.COUNTRY_NAME AS �ּ�
    FROM C##HR.DEPARTMENTS A
   INNER JOIN C##HR.EMPLOYEES B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
   INNER JOIN C##HR.LOCATIONS C ON(A.LOCATION_ID=C.LOCATION_ID)
   INNER JOIN C##HR.COUNTRIES D ON(C.COUNTRY_ID=D.COUNTRY_ID)
   WHERE C.COUNTRY_ID != ('US')
   ORDER BY 3; 


