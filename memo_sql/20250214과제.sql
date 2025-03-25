2025-0214-����

 ` ������̺��� ������� ��ȸ�Ͻÿ�
  SELECT COUNT(*) AS �����
    FROM C##HR.EMPLOYEES;

 ` ��ǰ���̺��� ��ǰ�Ǽ�, �ִ��ǸŰ�, �ּ��ǸŰ��� ���Ͻÿ�
  SELECT COUNT(*) AS ��ǰ�Ǽ�, 
         MAX(PROD_PRICE) AS �ִ��ǸŰ�, 
         MIN(PROD_PRICE) AS �ּ��ǸŰ�
    FROM PROD;
 
 ` ������̺��� �μ��� ��ձ޿��� �ο����� ��ȸ�Ͻÿ�
  SELECT DEPARTMENT_ID AS �μ�,
         ROUND(AVG(SALARY)) AS ��ձ޿�,
         COUNT(*) AS �ο���
    FROM C##HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID 
   ORDER BY 1;
  
 ` ��ǰ���̺��� �з��� ��ǰ�� ��, ����ǸŰ��� ��ȸ�Ͻÿ�
  SELECT LPROD_GU AS �з��ڵ�,
         COUNT(*) AS "��ǰ�� ��",
         TRUNC(AVG(PROD_PRICE)) AS ����ǸŰ�
    FROM PROD
   GROUP BY LPROD_GU
   ORDER BY 1;
  
 ` �������̺��� 2020�� ��ǰ�� ���Լ����հ踦 ��ȸ�Ͻÿ�
  SELECT PROD_ID AS ��ǰ�ڵ�,
         SUM(BUY_QTY) AS ���Լ����հ�
    FROM BUYPROD
   WHERE EXTRACT(YEAR FROM BUY_DATE)=2020 
   GROUP BY PROD_ID
   ORDER BY 1;
 
 ` ������̺��� �μ���, �⵵�� �Ի��� ������� ��ȸ�Ͻÿ�
  SELECT DEPARTMENT_ID AS �μ�,
         EXTRACT(YEAR FROM HIRE_DATE)||'��' AS �⵵,
         COUNT(*)
    FROM C##HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID, EXTRACT(YEAR FROM HIRE_DATE)
   ORDER BY 1;
  
 ` ȸ�����̺��� ���� ��ո��ϸ����� ��ȸ�Ͻÿ�
 
  SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN 
                    '����'
               ELSE '����' END AS ����,
         ROUND(AVG(MEM_MILEAGE)) AS ��ո��ϸ���
    FROM MEMBER
   GROUP BY  CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN 
                    '����'
               ELSE '����' END 
   ORDER BY 1;          
  
 ` ȸ�����̺��� ��ɴ뺰 ȸ������ ��ո��ϸ����� ��ȸ�Ͻÿ�
  SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE)
              -EXTRACT(YEAR FROM MEM_BIR),-1)||'��' AS ��ɴ�,
         ROUND(AVG(MEM_MILEAGE)) AS ��ո��ϸ���
    FROM MEMBER
   GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE)
              -EXTRACT(YEAR FROM MEM_BIR),-1)||'��'
   ORDER BY 1;      
  
  
 ` ȸ�����̺��� �������� ��� ���ϸ����� ȸ������ ��ȸ�Ͻÿ�
  SELECT SUBSTR(MEM_ADD1,1,2) AS ������,
         ROUND(AVG(MEM_MILEAGE)) AS ��ո��ϸ���,
         COUNT(*) AS ȸ����
    FROM MEMBER
   GROUP BY SUBSTR(MEM_ADD1,1,2) 
   ORDER BY 1;
  
 ` �������̺��� ��ǰ�� �Ǹż����հ踦 ��ȸ�ϵ� �Ǹż����� 50��
   �̻��� ��ǰ�� ��ȸ�Ͻÿ�
  SELECT PROD_ID AS ��ǰ�ڵ�,
         SUM(CART_QTY) AS �Ǹż����հ�
    FROM CART
   WHERE CART_QTY>=50
   GROUP BY PROD_ID
   ORDER BY 1;
   
 ` ������̺��� �μ��� ������� ��ȸ�ϵ� ������� 5�� �̻��� �ڷḸ
   ��ȸ�Ͻÿ�.
   
  SELECT DEPARTMENT_ID AS �μ�,
         COUNT(*) AS �����
    FROM C##HR.EMPLOYEES
   GROUP BY DEPARTMENT_ID
   HAVING COUNT(*)>=5
   ORDER BY 1;
  
 ` �������̺��� ȸ���� �Ǹż����հ踦 ��ȸ�Ͽ� ���� 5���� ����Ͻÿ�
     SELECT *  FROM 
    (SELECT MEM_ID AS ȸ��,
            SUM(CART_QTY) AS �Ǹż����հ�,
            RANK() OVER(ORDER BY SUM(CART_QTY) DESC) AS ����
      FROM CART
     GROUP BY MEM_ID) A
     WHERE ����<=5;
    
 




