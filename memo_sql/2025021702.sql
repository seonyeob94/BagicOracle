2025-0217_02) �����Լ�
- SELECT �������� ���
�������)
  {RANK() | DENSE_RANK() | ROW_NUMBER()} OVER(ORDER BY �÷���[DESC|ASC],...)
  
��뿹) ȸ�����̺��� ����ȸ������ ���ϸ����� ��ȸ�Ͽ� ���� ������ ������ �ο��Ͻÿ�
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_MILEAGE AS ���ϸ���,
         RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS "����(RANK())",
         DENSE_RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS "����(DENSE_RANK())",
         ROW_NUMBER() OVER(ORDER BY MEM_MILEAGE DESC) AS "����(ROW_NUMBER())"
    FROM MEMBER;
   WHERE SUBSTR(MEM_REGNO2,1,1) IN('2','4'); 
   
��뿹) 2020�� 6�� ȸ���� ���űݾ��� ���ϰ� ������ �ο��Ͻÿ�   
  SELECT A.MEM_ID AS ȸ����ȣ, 
         SUM(A.CART_QTY*B.PROD_PRICE) AS ���űݾ�,
         RANK() OVER(ORDER BY SUM(A.CART_QTY*B.PROD_PRICE) DESC) AS ����
    FROM CART A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND A.CART_NO LIKE '202006%'
   GROUP BY  A.MEM_ID; 
   
--PARTITION BY �׷캰 ����   
��뿹) ������̺��� �� �μ��� �޿��� ���� ������ ������ �ο��Ͻÿ�
       Alias�� �����ȣ,�����,�μ���ȣ,�޿�,����
  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         DEPARTMENT_ID AS �μ���ȣ,
         SALARY AS �޿�,
         RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS ����
    FROM C##HR.EMPLOYEES
  ORDER BY 3;
  
��뿹) ������̺��� �μ��� ��ձ޿��� ���ϰ� ���� ������ ������ ����Ͻÿ�  
       Alias�� �μ���ȣ, �ο���, ��ձ޿�, ����
  SELECT DEPARTMENT_ID AS �μ���ȣ, 
         COUNT(EMPLOYEE_ID) AS �ο���, 
         ROUND(AVG(SALARY)) AS ��ձ޿�, 
         RANK() OVER(ORDER BY ROUND(AVG(SALARY)) DESC) AS ����
    FROM C##HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID;