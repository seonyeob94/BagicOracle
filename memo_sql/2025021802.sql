2025-0218-02)OUTER JOIN
 - �ڷᰡ ���� ���� �������� ������ ���̺� NULL�� ������ 
   ���� �߰��Ͽ� JOIN�� ����--(���, ���ζ�� ǥ���� ����)
 - '(+)' �����ڸ� ������ �ʿ� �߰��Ͽ� ���������� ����  
 - COUNT�Լ��� ����� �� '*' ��� �÷���(���� PK)�� ����ؾ� ��
 
������� : �Ϲ� �ܺ�����)
  SELECT Į��list
    FROM ���̺��1  [��Ī1], ���̺��2 [��Ī2],...
   WHERE ���̺��1.�÷���(+)=���̺��2.�÷���
    [AND ���̺��2.�÷���=���̺��3.�÷���(+)]
          :
    [AND �Ϲ�����]
  . �ܺ������� �ʿ��� ���� ��ο� '(+)'�� ����ؾ���(��ǥ�� ����� �� ����)
  . �ϳ��� ���̺��� ���ÿ� �ܺ����ε� �� ����(��, A,B,C ���̺��� �����ϴ� ���
    A=B(+) AND C=B(+)�� ������ ����. A=B(+) AND B=C(+)�� ����)
  . �ܺ��������ǰ� �Ϲ������� ���ÿ� ���Ǹ� ������������ ��ȯ��=> �ذ�å����
    ANSI �ܺ������̳� SUBQUERY�� ����ؾ� ��

������� : ANSI)
  SELECT Į��list
    FROM ���̺��1  [��Ī1]
   (RIGHT|LEFT|FULL) OUTER JOIN ���̺��2 [��Ī2] ON(��������1[AND �Ϲ�����])
   (RIGHT|LEFT|FULL) OUTER JOIN ���̺��3 [��Ī3] ON(��������2[AND �Ϲ�����])
          :
   [WHERE �Ϲ�����]
   
  . 'RIGHT': OUTER JOIN �� ������ ����� ���̺��� ���� FROM ���� �����
             ���̺��� ������ ������ ���� ���
  . 'LEFT' : OUTER JOIN �� ������ ����� ���̺��� ���� FROM ���� �����
             ���̺��� ������ ������ ���� ��� 
  . 'FULL' : ���� ��� ������ ���
  . WHERE ���� ����ϸ� ���� ���� ����� ��ȯ��
     
    
��뿹)��ǰ���̺��� ��� �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�.
      Alias�� �з��ڵ�,�з���,��ǰ�� ��

��ǰ���̺��� ����ϴ� �з��ڵ�)
  SELECT DISTINCT LPROD_GU
    FROM PROD;
      
  SELECT A.LPROD_GU AS �з��ڵ�,
         A.LPROD_NAME AS �з���,
         COUNT(B.PROD_ID) AS "��ǰ�� ��"
    FROM LPROD A, PROD B
   WHERE A.LPROD_GU=B.LPROD_GU(+)
   GROUP BY A.LPROD_GU, A.LPROD_NAME
   ORDER BY 1; 
   
(ANSI JOIN) 
  SELECT A.LPROD_GU AS �з��ڵ�,
         A.LPROD_NAME AS �з���,
         COUNT(B.PROD_ID) AS "��ǰ�� ��"
    FROM LPROD A
    LEFT OUTER JOIN PROD B ON(A.LPROD_GU=B.LPROD_GU)
   GROUP BY A.LPROD_GU, A.LPROD_NAME
   ORDER BY 1; 
    
��뿹)������̺��� ��� �μ��� ������� ��� �޿��� ��ȸ�Ͻÿ�
      Alias�� �μ��ڵ�, �μ���, �ο���,��ձ޿�
  SELECT A.DEPARTMENT_ID AS �μ��ڵ�, 
         A.DEPARTMENT_NAME AS �μ���, 
         COUNT(B.EMPLOYEE_ID) AS �ο���,
         NVL(ROUND(AVG(B.SALARY)),0) AS ��ձ޿�
    FROM C##HR.DEPARTMENTS A, C##HR.EMPLOYEES B
   WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID(+)
   GROUP BY A.DEPARTMENT_ID, A.DEPARTMENT_NAME
   ORDER BY 1;
   
(ANSI OUTER)
  SELECT A.DEPARTMENT_ID AS �μ��ڵ�, 
         A.DEPARTMENT_NAME AS �μ���, 
         COUNT(B.EMPLOYEE_ID) AS �ο���,
         NVL(ROUND(AVG(B.SALARY)),0) AS ��ձ޿�
    FROM C##HR.DEPARTMENTS A
    FULL OUTER JOIN C##HR.EMPLOYEES B ON(A.DEPARTMENT_ID=B.DEPARTMENT_ID)
   GROUP BY A.DEPARTMENT_ID, A.DEPARTMENT_NAME
   ORDER BY 1;
   
 **��ǰ���̺��� ��ǰ�� ���ϸ���(PROD_MILEAGE)�÷��� ���� ������ 
   ��� ������ �����Ͻÿ�
   ��ǰ�� ���ϸ���(PROD_MILEAGE)=TRUNC(���԰��� 0.06%)
   SELECT TRUNC(PROD_COST*0.0006)
     FROM PROD;
   
   UPDATE PROD
      SET PROD_MILEAGE=TRUNC(PROD_COST*0.0006);
      
      COMMIT;
 
��뿹)��� ȸ���� ���� ���ϸ����� ��ȸ�Ͻÿ� 
     Alias�� ȸ����ȣ,ȸ����,���Ÿ��ϸ���
  SELECT B.MEM_ID AS ȸ����ȣ,
         B.MEM_NAME AS ȸ����,
         NVL(SUM(A.CART_QTY*C.PROD_MILEAGE),0) AS ���Ÿ��ϸ���
    FROM CART A, MEMBER B, PROD C
   WHERE A.MEM_ID(+) = B.MEM_ID
     AND C.PROD_ID = A.PROD_ID(+)
   GROUP BY B.MEM_ID, B.MEM_NAME
   ORDER BY 1;
   
 (ANSI OUTRER)
  SELECT B.MEM_ID AS ȸ����ȣ,
         B.MEM_NAME AS ȸ����,
         NVL(SUM(A.CART_QTY*C.PROD_MILEAGE),0) AS ���Ÿ��ϸ���
    FROM CART A
   RIGHT OUTER JOIN MEMBER B ON(A.MEM_ID = B.MEM_ID)
    LEFT OUTER JOIN PROD C ON(C.PROD_ID = A.PROD_ID)
   GROUP BY B.MEM_ID, B.MEM_NAME
   ORDER BY 1;
      
��뿹)2020�� 1�� ��� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�
      Alias�� ��ǰ��ȣ,��ǰ��,���Լ���,���Աݾ�
  SELECT B.PROD_ID AS ��ǰ��ȣ,
         B.PROD_NAME AS ��ǰ��,
         NVL(SUM(BUY_QTY),0) AS ���Լ���,
         NVL(SUM(BUY_QTY*PROD_COST),0) AS ���Աݾ�
    FROM BUYPROD A, PROD B
   WHERE A.PROD_ID(+)=B.PROD_ID
     AND BUY_DATE(+) BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
   GROUP BY B.PROD_ID, B.PROD_NAME
   ORDER BY 1;
   
   
 (ANSI OUTER)
  SELECT B.PROD_ID AS ��ǰ��ȣ,
         B.PROD_NAME AS ��ǰ��,
         NVL(SUM(BUY_QTY),0) AS ���Լ���,
         NVL(SUM(BUY_QTY*PROD_COST),0) AS ���Աݾ�
    FROM BUYPROD A
   RIGHT OUTER JOIN PROD B ON(A.PROD_ID=B.PROD_ID AND 
         A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))
   GROUP BY B.PROD_ID, B.PROD_NAME
   ORDER BY 1;
   
(SUBQUERY)
  SELECT P.PROD_ID AS ��ǰ��ȣ,
         P.PROD_NAME AS ��ǰ��
         C. AS ���Լ����հ�,
         C. AS ���Աݾ��հ�
    FROM PROD P, 
         (2020�� 1�� ��ǰ�� ���Լ����հ�, ���Աݾ��հ�) C
   WHERE P.PROD_ID=C.��ǰ�ڵ�(+)
   ORDER BY 1;      
 
 (2020�� 1�� ��ǰ�� ���Լ����հ�, ���Աݾ��հ�)
  SELECT A.PROD_ID AS APID,
         SUM(A.BUY_QTY) AS AQTY,
         SUM(A.BUY_QTY*B.PROD_COST) AS ASUM
    FROM BUYPROD A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
   GROUP BY  A.PROD_ID; 
 
 (����)
  SELECT P.PROD_ID AS ��ǰ��ȣ,
         P.PROD_NAME AS ��ǰ��,
         NVL(C.AQTY,0) AS ���Լ����հ�,
         NVL(C.ASUM,0) AS ���Աݾ��հ�
    FROM PROD P, 
         (SELECT A.PROD_ID AS APID,
                 SUM(A.BUY_QTY) AS AQTY,
                 SUM(A.BUY_QTY*B.PROD_COST) AS ASUM
            FROM BUYPROD A, PROD B
           WHERE A.PROD_ID=B.PROD_ID
             AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
           GROUP BY  A.PROD_ID) C
   WHERE P.PROD_ID=C.APID(+)
   ORDER BY 1;     
      
      
    
    
    
    
    , ���̺��2 [��Ī2],...
   WHERE ���̺��1.�÷���(+)=���̺��2.�÷���
    [AND ���̺��2.�÷���=���̺��3.�÷���(+)]
          :
    [AND �Ϲ�����]
