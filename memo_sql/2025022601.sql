2025-0226-01)���տ�����
 - ������(UNION, UNION ALL), ������(INTERSECT), ������(MINUS)
 - �������� SELECT���� ����� ���Ͽ� ���տ����� ����� ��ȯ
 - �� SELECT���� SELECT���� �÷��� ����, Ÿ��, ������ ��ġ�ؾ���
 - �÷��� ��Ī�� ù ��° SELECT���� ���� �����
 - ORDER BY���� ������ SELECT������ ��� �� �� ����
 
1. UNION, UNION ALL
  - �������� ����� ��ȯ
  - ������ �ٸ� ���� ���̺��� ���� ������ �ڷḦ �����ϴ� ��� �ַ� ����
  
��뿹) 2020�� 6���� 7���� ����Ȱ���� �� ��� ȸ�������� ��ȸ�Ͻÿ�
      Alias�� ȸ����ȣ,ȸ����,����,���ϸ���
(6�� ���� ȸ��)      
  SELECT DISTINCT A.MEM_ID AS ȸ����ȣ,
         B.MEM_NAME AS ȸ����,
         B.MEM_JOB AS ����,
         B.MEM_MILEAGE AS ���ϸ���
    FROM CART A, MEMBER B
   WHERE A.MEM_ID=B.MEM_ID
     AND A.CART_NO LIKE '202006%'
UNION      
  SELECT DISTINCT A.MEM_ID,
         B.MEM_NAME,
         B.MEM_JOB,
         B.MEM_MILEAGE
    FROM CART A, MEMBER B
   WHERE A.MEM_ID=B.MEM_ID
     AND A.CART_NO LIKE '202007%'
     
     
   
  SELECT DISTINCT A.MEM_ID AS ȸ����ȣ,
         B.MEM_NAME AS ȸ����,
         B.MEM_JOB AS ����,
         B.MEM_MILEAGE AS ���ϸ���
    FROM CART A, MEMBER B
   WHERE A.MEM_ID=B.MEM_ID
     AND A.CART_NO LIKE '202006%'
UNION ALL     
  SELECT DISTINCT A.MEM_ID,
         B.MEM_NAME,
         B.MEM_JOB,
         B.MEM_MILEAGE
    FROM CART A, MEMBER B
   WHERE A.MEM_ID=B.MEM_ID
     AND A.CART_NO LIKE '202007%'  
   ORDER BY 1;  
   
** ���̺� BUDGET, SALES�� ����
  CREATE TABLE BUDGET(
    PERIOD CHAR(6),
    BUDGET_AMT NUMBER(5));
    DROP TABLE SALES;
  CREATE TABLE SALES(
    PERIOD CHAR(6), 
    SALE_AMT NUMBER(5));
    
   INSERT INTO BUDGET VALUES('202401',1000);  
   INSERT INTO BUDGET VALUES('202402',800);  
   INSERT INTO BUDGET VALUES('202403',2000);  
   INSERT INTO BUDGET VALUES('202404',1500);  
   INSERT INTO BUDGET VALUES('202405',2500);  
   
   SELECT * FROM BUDGET;
   
    
   INSERT INTO SALES VALUES('202401',900);  
   INSERT INTO SALES VALUES('202402',1200);  
   INSERT INTO SALES VALUES('202403',2000);  
   INSERT INTO SALES VALUES('202404',2800);  
   INSERT INTO SALES VALUES('202405',2000);  
   
   UPDATE SALES
      SET SALES_AMT=900
    WHERE PERIOD='202401'  
    
 ��뿹)BUDGET, SALES ���̺��� �̿��Ͽ� ��ȹ��� ������ ��ȸ
  SELECT PERIOD, BUDGET_AMT, 0 AS SALE_AMT
    FROM BUDGET
  UNION
  SELECT PERIOD, 0, SALE_AMT
    FROM SALES
   ORDER BY 1;
   
 
  SELECT PERIOD AS �Ⱓ,
         SUM(BUDGET_AMT) AS ��ȹ,
         SUM(SALE_AMT) AS ����,
         TO_CHAR(ROUND(SUM(SALE_AMT)/SUM(BUDGET_AMT)*100),'999')||'%' AS �޼��� 
    FROM (SELECT PERIOD, BUDGET_AMT, 0 AS SALE_AMT
            FROM BUDGET
          UNION
          SELECT PERIOD, 0, SALE_AMT
            FROM SALES)
   GROUP BY PERIOD
   ORDER BY 1;
   
  ** �÷��� ������ ��ȯ
   CREATE TABLE SCORE(
     YEAR  CHAR(4),
     GUBUN VARCHAR2(20),
     KOR   NUMBER(3),
     ENG   NUMBER(3),
     MAT   NUMBER(3));
     
  INSERT INTO SCORE VALUES('2024','�߰����',80,70,85);  
  INSERT INTO SCORE VALUES('2024','�⸻���',70,90,90); 
  
  SELECT * FROM SCORE;
  
  SELECT YEAR AS �⵵, GUBUN AS ����, '����' AS ����, KOR AS ����
    FROM SCORE
  UNION ALL
  SELECT YEAR, GUBUN, '����', ENG
    FROM SCORE
  UNION ALL
  SELECT YEAR, GUBUN, '����', MAT
    FROM SCORE;
  
2. INTERSECT
  - ������(����κ�)�� ����� ��ȯ
  
��뿹) 2020�� 1���� 4���� ��� ���Ե� ��ǰ�� ��ȸ�Ͻÿ�
      Alias�� ��ǰ��ȣ, ��ǰ��, �ŷ�ó�ڵ�, ���Դܰ�

(2020�� 1�� ���Ե� ��ǰ�� ��ǰ��ȣ, ��ǰ��, �ŷ�ó�ڵ�, ���Դܰ�)    
  SELECT A.PROD_ID AS ��ǰ��ȣ, 
         B.PROD_NAME AS ��ǰ��, 
         B.BUYER_ID AS �ŷ�ó�ڵ�, 
         B.PROD_COST AS ���Դܰ�
    FROM BUYPROD A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
  INTERSECT
--(2020�� 4�� ���Ե� ��ǰ�� ��ǰ��ȣ, ��ǰ��, �ŷ�ó�ڵ�, ���Դܰ�)    
  SELECT A.PROD_ID,B.PROD_NAME, B.BUYER_ID,B.PROD_COST
    FROM BUYPROD A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND A.BUY_DATE BETWEEN TO_DATE('20200401') AND LAST_DAY(TO_DATE('20200401'))
--������ ��� 1���� 4���� ���Լ����� �ٸ��� �ٸ� �����ͷ� ��޵Ǿ� ��ġ�� �κ��� �ȳ��´�     

(EXISTS������ ���)
  SELECT A.PROD_ID AS ��ǰ��ȣ, 
         B.PROD_NAME AS ��ǰ��, 
         B.BUYER_ID AS �ŷ�ó�ڵ�, 
         B.PROD_COST AS ���Դܰ�
    FROM BUYPROD A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
     AND EXISTS (SELECT 1
                   FROM BUYPROD
                  WHERE BUY_DATE BETWEEN TO_DATE('20200401') AND LAST_DAY(TO_DATE('20200401'))
                    AND PROD_ID=A.PROD_ID)
                    
3. MINUS 
  - �������� ����� ��ȯ
  - MINUS ������ �� �Ǵ� ���� ��ġ�� ����Ǵ� ������ ���� ����� ������
  - NOT EXISTS �����ڷ� ���� ����
  
��뿹)2020�� 4���� 6�� ������ ȸ�� �� 4������ ������ ȸ�������� ��ȸ�Ͻÿ�
      Alias�� ȸ����ȣ,ȸ����,���ϸ���

(4�� ������ ȸ����ȣ)
  SELECT DISTINCT MEM_ID
    FROM CART
   WHERE CART_NO LIKE '202004%' 
  MINUS
--(7�� ������ ȸ����ȣ)
  SELECT DISTINCT MEM_ID
    FROM CART
   WHERE CART_NO LIKE '202007%' 
   ORDER BY 1;
  
  
(7�� ������ ȸ����ȣ)
  SELECT DISTINCT MEM_ID
    FROM CART
   WHERE CART_NO LIKE '202007%' 
  MINUS
--(4�� ������ ȸ����ȣ)
  SELECT DISTINCT MEM_ID
    FROM CART
   WHERE CART_NO LIKE '202004%' 
   ORDER BY 1;
  
(NOT EXISTS�����ڸ� ���)

(7�� ������ ȸ����ȣ)
  SELECT DISTINCT A.MEM_ID
    FROM CART A
   WHERE A.CART_NO LIKE '202007%' 
     AND NOT EXISTS(SELECT DISTINCT MEM_ID
                      FROM CART B
                     WHERE B.CART_NO LIKE '202004%'
                       AND B.MEM_ID=A.MEM_ID) 
   ORDER BY 1;
  
  
  
  