2025-0219-01)

��뿹)ȸ�����̺��� ȸ������ ��ո��ϸ������� �� ���� ���ϸ����� ������
     ȸ�������� ��ȸ�Ͻÿ�(Alias�� ȸ����ȣ,ȸ����,���ϸ���,��ո��ϸ���)
  (��������)
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         ���ϸ���,
         (��������:��ո��ϸ���)
    FROM MEMBER
   WHERE MEM_MILEAGE > (��������:��ո��ϸ���)
   
(��������:��ո��ϸ���)
  SELECT AVG(MEM_MILEAGE)
    FROM MEMBER
 
(����)  
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_MILEAGE AS ���ϸ���,
         (SELECT ROUND(AVG(MEM_MILEAGE))
            FROM MEMBER) AS ��ո��ϸ���
    FROM MEMBER
   WHERE MEM_MILEAGE > (SELECT AVG(MEM_MILEAGE)
                          FROM MEMBER);  --�������� 24+7�� ����
                          
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_MILEAGE AS ���ϸ���,
         ROUND(A.MILE) AS ��ո��ϸ���
    FROM MEMBER,(SELECT AVG(MEM_MILEAGE) AS MILE 
                   FROM MEMBER) A
   WHERE MEM_MILEAGE > A.MILE;  --�������� 1�� ����
     
��뿹)��ǰ���̺��� ��� �ǸŰ����� ū ��ǰ�� ������ ���
      Alias�� ��ǰ�� ��
(��������)
  SELECT COUNT(PROD_ID) AS "��ǰ�� ��"
    FROM PROD
   WHERE PROD_PRICE > (��������:����ǸŰ�);
   
(��������:����ǸŰ�)
  SELECT ROUND(AVG(PROD_PRICE))
    FROM PROD;
    
(����)    
  SELECT COUNT(PROD_ID) AS "��ǰ�� ��"
    FROM PROD
   WHERE PROD_PRICE > (SELECT ROUND(AVG(PROD_PRICE))
                         FROM PROD);
      

��뿹)��ǰ���̺��� ��� �ǸŰ����� ū ��ǰ�� ����,��ǰ��, �ǸŰ��� ���
      Alias�� ��ǰ�� ��
      
  SELECT PROD_NAME AS ��ǰ��,
         PROD_PRICE AS �ǸŰ�,
         COUNT(PROD_ID) AS "��ǰ�� ��"
    FROM PROD
   WHERE PROD_PRICE > (SELECT ROUND(AVG(PROD_PRICE))
                         FROM PROD)
   GROUP BY PROD_NAME, PROD_PRICE;
   
��뿹) ��ٱ��� ���̺��� 2020�� 5�� ȸ���� ���űݾ��հ踦 ���ϰ� ���� ���� 
      ���Ÿ� �� ȸ���� ȸ����ȣ,ȸ����,����,���űݾ� �հ踦 ��ȸ�Ͻÿ�  
 (�������� : 2020�� 5�� ���� ���� ���Ÿ� �� ȸ���� ȸ����ȣ,ȸ����,����,���űݾ� �հ�) 
  SELECT D.AMID AS ȸ����ȣ,
         C.MEM_NAME AS ȸ����,
         C.MEM_JOB AS ����,
         D.ASUM AS ���űݾ� �հ�
    FROM MEMBER C,
        (SELECT A.MEM_ID AS AMID,
                SUM(A.CART_QTY*B.PROD_PRICE) AS ASUM
           FROM CART A, PROD B
          WHERE A.PROD_ID=B.PROD_ID
            AND A.CART_NO LIKE '202005%'
          GROUP BY A.MEM_ID
          ORDER BY 2 DESC) D
   WHERE C.MEM_ID=D.AMID
     AND ROWNUM =1;
 
 --FROM �� ���������� �γ��� �������� 
 (�������� : 2020�� 5�� ȸ���� ���űݾ� �հ�)
 
  SELECT A.MEM_ID AS AMID,
         SUM(A.CART_QTY*B.PROD_PRICE) AS ASUM
    FROM CART A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND A.CART_NO LIKE '202005%'
   GROUP BY A.MEM_ID
   ORDER BY 2 DESC;
      
      
      
      
(��������)    
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_JOB AS ����,
         "���űݾ� �հ�"
    FROM  MEMBER 
   WHERE  

(��������:2020�� 5�� ȸ���� ���űݾ��հ� �� ���� ���� 
      ���Ÿ� �� ȸ��)  
  SELECT MEM_ID AS MID,
         SUM(PROD_PRICE*CART_QTY) AS COSSUM
    FROM CART A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND SUBSTR(CART_NO,1,6)='202005'
   GROUP BY MEM_ID
   ORDER BY 2 DESC;
   
(����)   
  SELECT M.MEM_ID AS ȸ����ȣ,
         M.MEM_NAME AS ȸ����,
         M.MEM_JOB AS ����,
         S.SUM AS "���űݾ� �հ�"
    FROM  MEMBER M,
           (SELECT MEM_ID AS MID,
               SUM(PROD_PRICE*CART_QTY) AS SUM
              FROM CART A, PROD B
             WHERE A.PROD_ID=B.PROD_ID
               AND SUBSTR(CART_NO,1,6)='202005'
             GROUP BY MEM_ID
             ORDER BY 2 DESC) S
   WHERE M.MEM_ID=S.MID
   FETCH FIRST 1 ROWS ONLY;
    
��뿹) �泲�� �����ϴ� ȸ���� �ֹ��� ��� �ֹ������� ��ȸ�Ͻÿ�
       Alias�� ȸ����ȣ,ȸ����,�ֹ�����,��ǰ��ȣ,��ǰ��,�ֹ�����
    
           
       
(��������)     
  SELECT B.MEM_ID AS ȸ����ȣ,
         B.MEM_NAME AS ȸ����,
         A.CART_NO AS �ֹ�����,
         A.PROD_ID AS ��ǰ��ȣ,
         C.PROD_NAME AS ��ǰ��,
         B.CART_QTY AS �ֹ�����
    FROM CART A, MEMBER B, PROD C
   WHERE A.PROD_ID=C.PROD_ID 
     AND A.MEM_ID=B.MEM_ID 
     AND (��������:�泲�� �����ϴ� ȸ��)
 
 (��������:�泲�� �����ϴ� ȸ��)
  SELECT MEM_ID AS MID
    FROM MEMBER
   WHERE SUBSTR(MEM_ADD1,1,2) LIKE '�泲%' 
   
(����)
  SELECT B.MEM_ID AS ȸ����ȣ,
         B.MEM_NAME AS ȸ����,
         NVL(A.CART_NO,0) AS �ֹ�����,
         NVL(A.PROD_ID,0) AS ��ǰ��ȣ,
         C.PROD_NAME AS ��ǰ��,
         NVL(A.CART_QTY,0) AS �ֹ�����
    FROM CART A, MEMBER B, PROD C
   WHERE A.PROD_ID=C.PROD_ID 
     AND A.MEM_ID=B.MEM_ID 
     AND B.MEM_ID IN (SELECT MEM_ID AS MID
                        FROM MEMBER
                       WHERE SUBSTR(MEM_ADD1,1,2) LIKE '�泲%')
   ORDER BY 1;
       
��뿹) ��ո��ϸ������� ���� ���ϸ����� ������ ��� ȸ������ 2020�� 7��
       ������Ȳ�� ��ȸ�Ͻÿ�. Alias�� ȸ����ȣ, ȸ����, ���ž�
(��������)
  SELECT A.MEM_ID AS ȸ����ȣ, 
         C.MEM_NAME AS ȸ����, 
         SUM(A.CART_QTY*B.PROD_PRICE) AS ���ž�
    FROM CART A, PROD B, MEMBER C
   WHERE CART_NO LIKE 202007% 
     AND A.MEM_ID IN (�������� :��ո��ϸ������� ���� ���ϸ����� ������ ȸ���� ȸ����ȣ)
   GROUP BY A.MEM_ID, C.MEM_NAME 
   
(�������� :��ո��ϸ������� ���� ���ϸ����� ������ ȸ���� ȸ����ȣ)
  SELECT MEM_ID
    FROM MEMBER
   WHERE MEM_MILEAGE>(SELECT AVG(MEM_MILEAGE)
                        FROM MEMBER) 
(����) 
  SELECT A.MEM_ID AS ȸ����ȣ, 
         C.MEM_NAME AS ȸ����, 
         SUM(A.CART_QTY*B.PROD_PRICE) AS ���ž�
    FROM CART A, PROD B, MEMBER C
   WHERE A.PROD_ID=B.PROD_ID
     AND A.MEM_ID=C.MEM_ID
     AND CART_NO LIKE '202007%'
     AND A.MEM_ID IN (SELECT MEM_ID
                        FROM MEMBER
                       WHERE MEM_MILEAGE>(SELECT AVG(MEM_MILEAGE)
                                            FROM MEMBER))
   GROUP BY A.MEM_ID, C.MEM_NAME ;

(EXISTS ������ ��� ����) 
 - EXISTS ������ ���ʿ� �÷����� ������� ����
 - EXISTS ������ ������ �ݵ�� ���������� ����Ǿ�� �ϸ�
   ����� 1���̶� �����ϸ� ��(true)�� ��ȯ��
   
   
  SELECT A.MEM_ID AS ȸ����ȣ, 
         C.MEM_NAME AS ȸ����, 
         SUM(A.CART_QTY*B.PROD_PRICE) AS ���ž�
    FROM CART A, PROD B, MEMBER C
   WHERE A.PROD_ID=B.PROD_ID
     AND A.MEM_ID=C.MEM_ID
     AND CART_NO LIKE '202007%'
     AND EXISTS (SELECT 1 --�ǹ̾��� ���� ���� ������ ��µǴ��� Ȯ���ϱ� ���� ����
                   FROM (SELECT MEM_ID
                           FROM MEMBER
                          WHERE MEM_MILEAGE>(SELECT AVG(MEM_MILEAGE)
                                               FROM MEMBER))D
                  WHERE D.MEM_ID=A.MEM_ID)
   GROUP BY A.MEM_ID, C.MEM_NAME ;
   
   
   
(��������)
  SELECT B.MEM_ID AS ȸ����ȣ, 
         B.MEM_NAME AS ȸ����, 
         SUM(C.PROD_PRICE*A.CART_QTY) AS ���ž�
    FROM CART A, MEMBER B, PROD C
   WHERE A.PROD_ID=C.PROD_ID 
     AND A.MEM_ID=B.MEM_ID 
     AND MEM_MILEAGE > (��������:��ո��ϸ��� )
     AND SUBSTR(A.CART_NO,1,6)='202007'
   GROUP BY B.MEM_ID, B.MEM_NAME;
 
 (��������:��ո��ϸ���) 
  SELECT AVG(MEM_MILEAGE)
    FROM MEMBER 
    
 (����)
  SELECT B.MEM_ID AS ȸ����ȣ, 
         B.MEM_NAME AS ȸ����, 
         SUM(C.PROD_PRICE*A.CART_QTY) AS ���ž�
    FROM CART A, MEMBER B, PROD C
   WHERE A.PROD_ID=C.PROD_ID 
     AND A.MEM_ID=B.MEM_ID
     AND MEM_MILEAGE > (SELECT AVG(MEM_MILEAGE)
                          FROM MEMBER )
     AND SUBSTR(A.CART_NO,1,6)='202007'
   GROUP BY B.MEM_ID, B.MEM_NAME;  
       
     
**���������� �̿��� ���̺� ����
 - ���̺��� ������ �����͸� ����
 - �⺻Ű, �ܷ�Ű�� ������� ����
 
  CREATE TABLE ���̺� ��[(�÷�LIST)] AS
   ��������--��ȣ�� ���� �ʴ´� (CREAT,INSERT INTO�� ���̴� ���������� ���� �ʴ´�)
   
��뿹) HR������ ������̺��� �����ȣ,�����,�μ���ȣ,�Ի��� �÷��� �����Ͽ�
       EMP ���̺��� �����Ͻÿ�
   DROP TABEL C##HR.EMP;
       
   CREATE TABLE C##HR.EMP AS 
     SELECT EMPLOYEE_ID,EMP_NAME,DEPARTMENT_ID,HIRE_DATE,SALARY
       FROM C##HR.EMPLOYEES;
       
** RETIRE ���̺� ����  
   �����ȣ,�μ���ȣ,�Ի���,������
 
��뿹) ������̺��� 2020�� ������ �Ի��� ��� �� �޿��� ���� 10���� ����ó���Ͻÿ�    
    
(��������: �����ڸ� RETIRE ���̺� ����)    
  INSERT INTO C##HR.RETIRE A
     ��������:2020�� ������ �Ի��� ��� �� �޿��� ���� 10���� �����ȣ B
   WHERE A.EMPLOYEE_ID= B.�����ȣ
   
(��������:2020�� ������ �Ի��� ��� �� �޿��� ���� 10���� �����ȣ)    
  SELECT A.EMPLOYEE_ID
    FROM (SELECT EMPLOYEE_ID, SALARY
            FROM C##HR.EMP
           WHERE HIRE_DATE < TO_DATE('20200101') 
           ORDER BY SALARY DESC) A
   WHERE ROWNUM <=10    
   
(����)   
  INSERT INTO C##HR.RETIRE A
     SELECT B.EMPLOYEE_ID, B.DEPARTMENT_ID, SYSDATE
       FROM (SELECT EMPLOYEE_ID, DEPARTMENT_ID
               FROM C##HR.EMP
              WHERE HIRE_DATE < TO_DATE('20200101') 
              ORDER BY SALARY DESC) B
      WHERE ROWNUM <=10; 
      
      COMMIT;
      
      SELECT *
        FROM C##HR.RETIRE;
  
  DELETE FROM C##HR.EMP
   WHERE EMPLOYEE_ID IN(SELECT B.EMPLOYEE_ID
                          FROM (SELECT EMPLOYEE_ID
                                  FROM C##HR.EMP
                                 WHERE HIRE_DATE < TO_DATE('20200101') 
                              ORDER BY SALARY DESC) B
                         WHERE ROWNUM <=10)
    
    

   INSERT INTO C##HR.JOB_HISTORY
  (SELECT A.EID AS EMPLOYEES_ID,
          A.HIRDA AS START_DATE,
          A.RETIRE AS END_DATE,
          A.JOBID AS JOB_ID,
          A.DEPART AS DEPARTMENT_ID
     FROM (SELECT EMPLOYEE_ID AS EID, 
                  HIRE_DATE AS HIRDA,
                  SYSDATE AS RETIRE,
                  JOB_ID AS JOBID,
                  DEPARTMENT_ID AS DEPART
             FROM C##HR.EMPLOYEES
            WHERE EXTRACT(YEAR FROM HIRE_DATE)<('2020')
            ORDER BY SALARY DESC) A
     WHERE ROWNUM<=10);  
     
  --GLGLG
  SELECT* FROM C##HR.JOB_HISTORY;
  
  ROLLBACK;
   COMMIT;
   
    
