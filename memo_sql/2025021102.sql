2025-0211-02)��Ÿ ������
 - BETWEEN, LIKE, IN, ANY(SOME), ALL, EXISTS ���� ����
1.BETWEEN
 - ��������
 - ��� ������Ÿ�Կ� ��밡��
 - AND�� ��ȯ����
�������)
 �÷��� BETWEEN ��1 AND ��2
 '��1'�� '��2'�� ���� �ڷ� Ÿ��(�ڵ���ȯ�� ���)
 
��뿹)��ǰ���̺��� ���԰����� 100000~200000�� �� ��ǰ��
     ��ǰ�ڵ�,��ǰ��,���԰���,�ŷ�ó�ڵ带 ��ȸ
 SELECT PROD_ID AS ��ǰ�ڵ�,
        PROD_NAME AS ��ǰ��,
        PROD_COST AS ���԰���,
        BUYER_ID AS �ŷ�ó�ڵ�
   FROM PROD
  WHERE PROD_COST BETWEEN 100000 AND 200000; 
     
��뿹) ȸ�����̺��� 20�� ����ȸ���� ȸ����ȣ,ȸ����,�ּ�,���ϸ����� ��ȸ
 SELECT MEM_ID AS ȸ����ȣ,
        MEM_NAME AS ȸ����,
        MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
        MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
        MEM_MILEAGE AS ���ϸ���
   FROM MEMBER
  WHERE (EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))
        BETWEEN 20 AND 29--20��
    AND (SUBSTR(MEM_REGNO2,1,1)='2' OR SUBSTR(MEM_REGNO2,1,1)='4');

��뿹) HR������ ������̺��� �ټӳ���� 10~15���� �����
       �����ȣ,�����,�Ի���,�����ڵ�,�޿��� ��ȸ�Ͻÿ�
       �ټӳ�� �������� ���Ͽ� �Ǵ�
       �ټӳ�� : TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)--TRUNC:�Ҽ������ϴ� ����
 SELECT EMPLOYEE_ID AS �����ȣ,
        EMP_NAME AS �����,
        HIRE_DATE AS �Ի���,
        JOB_ID AS �����ڵ�,
        SALARY AS �޿�
   FROM C##HR.EMPLOYEES
  WHERE TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)
        BETWEEN 10 AND 15;
        
2.LIKE ������
 -���Ϻ� ������
 -'%'�� '_'���Ϲ��ڸ� ����Ͽ� ���� ����
�������)--���� ���ڿ��� ��
 �÷��� LIKE '���Ϲ��ڿ�'
 1)'%'
 .'%'�� ���� ���� ��� ���ڿ�(NULL����)�� ����
 ex)
  '��%' : '��'���� �����ϴ� ��� ���ڿ��� ����('��'�� ����)
  '%��' : '��'���� ������ ��� ���ڿ��� ����('��'�� ����)
  '%��%' : 1���� �̻����� '��'�� �����ϴ� ��� ���ڿ�
 2)'_'
 .'_'�� ���� ���� 1���ڿ� ����--NULL ���Ե��� ����
 ex)
  '��_' : 2���ڷ� ������ '��'���� �����ϴ� ��� ���ڿ��� ����
  '_��' : 2���ڷ� ������ '��'���� ������ ��� ���ڿ��� ����
  '_��_' : 3���ڷ� ������ '��'�� �����ϴ� ��� ���ڿ� 
  
 ��뿹)ȸ�����̺��� 2000�� ���� ������� ȸ����ȣ,ȸ����,�ֹι�ȣ ���
  select MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ
    FROM MEMBER
   WHERE MEM_REGNO1 LIKE '0%' 
   ORDER BY 3;
 
 ��뿹)��ٱ������̺�(CART)���� 2020�� 7�� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�
      Alias�� ��¥,��ǰ��ȣ,�Ǹż���
 SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS ��¥,
        PROD_ID AS ��ǰ��ȣ,
        CART_QTY AS �Ǹż��� 
   FROM CART 
  WHERE CART_NO LIKE '202007%'
  ORDER BY 1; 
      
 ��뿹)�������̺��� 2020�� 6�� �����ڷ� ��ȣ
      Alias�� ��¥,��ǰ�ڵ�,���Լ���
 SELECT BUY_DATE AS ��¥,
        PROD_ID AS ��ǰ�ڵ�,
        BUY_QTY AS ���Լ���  
   FROM BUYPROD
  WHERE BUY_DATE BETWEEN '20200601' AND '20200630'; 
  --���ڿ��� �ƴѰ�� LIKE ������ ������ ��������
  
3. IN ������
 - ���õ� �������� �� �� ��� �ϳ��� ��ġ�ϸ� ��(true)�� ��ȯ�ϴ� ������
 - ������ ������
 - '='�� ����� ���Ե� �����ڷ� OR�����ڷ� ��ȯ����
 - ���������� �ʰų� �ұ�Ģ�� �ڷ� �񱳿� ���

�������)
  �÷��� IN(��1,��2,...)
  . '�÷�'�� ���� '��1'~'��n' �� ��� �ϳ��� ������ ���� ��ȯ
(OR ������)
��뿹)������̺� �� 20,70,90�� �μ��� ���ϰ� �޿��� 7000������ �������
     �����ȣ,�����,�μ���ȣ,��å�ڵ�,�޿��� ����Ͻÿ�
     ����� �μ��ڵ� ������, �޿��� ���������� �Ͻÿ�
  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         DEPARTMENT_ID AS �μ���ȣ,
         JOB_ID AS ��å�ڵ�,
         SALARY AS �޿�
    FROM C##HR.EMPLOYEES
   WHERE (DEPARTMENT_ID=20 OR DEPARTMENT_ID=70 OR DEPARTMENT_ID=90)
     AND SALARY <=7000
   ORDER BY 3,5 DESC;
  (IN ������)
  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         DEPARTMENT_ID AS �μ���ȣ,
         JOB_ID AS ��å�ڵ�,
         SALARY AS �޿�
    FROM C##HR.EMPLOYEES
   WHERE DEPARTMENT_ID IN(20,70,90)
     AND SALARY <=7000
   ORDER BY 3,5 DESC;
   
��뿹)��ǰ���̺��� �з��ڵ尡 'P101', 'P202'�� ���� ��ǰ��
     ��ǰ�ڵ�,��ǰ��,�ǸŰ�,�з��ڵ带 �з��ڵ� ������ ����Ͻÿ�
  SELECT PROD_ID AS ��ǰ�ڵ�,
         PROD_NAME AS ��ǰ��,
         PROD_PRICE AS �ǸŰ�,
         LPROD_GU AS �з��ڵ�
    FROM PROD
   WHERE LPROD_GU IN('P101','P202')
   ORDER BY 4; 
   
��뿹)�泲�� �����ϴ� ȸ������ 2020�� ��ݱ� ������ ��������(ȸ����ȣ,ȸ����,���űݾ��հ�)
     �� ��ȸ�Ͻÿ�
 SELECT B.MEM_ID AS ȸ����ȣ,
        C.MEM_NAME AS ȸ����,
        SUM(A.PROD_PRICE*B.CART_QTY) AS ���űݾ��հ�
   FROM PROD A, CART B, MEMBER C
  WHERE B.MEM_ID IN(SELECT MEM_ID
                    FROM MEMBER
                   WHERE MEM_ADD1 LIKE '�泲%') 
    AND B.PROD_ID=A.PROD_ID
    AND B.MEM_ID=C.MEM_ID
    AND SUBSTR(B.CART_NO,1,6) BETWEEN '202001' AND '202006'
  GROUP BY B.MEM_ID,C.MEM_NAME;
  
4.ANY(SOME) ������
�������)
 �÷��� ���迩���� ANY|SOME(��1, ��2,...��n)--ANY�� SOME �տ� ������ ���迬���ڰ� �;���
 - ���õ� �������� �� �� ��� �ϳ��� ���� ���迬���ڸ� �����ϸ� 
   ��(true)�� ��ȯ�ϴ� ������
 - ������ ������
 - '='�� ����� ���Ե� ��� IN�����ڿ� ����

��뿹)ȸ�����̺��� ������ 'ȸ���'�� ȸ���� ������ ���ϸ��� �� ���� ���� ���ϸ�������
      ���� ���ϸ����� ������ ȸ���� ȸ����ȣ,ȸ����,����,���ϸ����� ��ȸ�Ͻÿ�
 SELECT MEM_ID AS ȸ����ȣ,
        MEM_NAME AS ȸ����,
        MEM_JOB AS ����,
        MEM_MILEAGE AS ���ϸ���
   FROM MEMBER
  WHERE MEM_MILEAGE < ANY(SELECT MEM_MILEAGE
                            FROM MEMBER
                           WHERE MEM_JOB='ȸ���')
  ORDER BY 4; 
  
��뿹)HR�������� 90�� �μ��� ���� ��ġ�� �ִ� �μ��� �ٹ��ϴ� ����� 
     �����ȣ,�����,�μ���ȣ,�����ڵ带 ��ȸ�Ͻÿ�
  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         DEPARTMENT_ID AS �μ���ȣ,
         JOB_ID AS �����ڵ� 
    FROM C##HR.EMPLOYEES
  WHERE DEPARTMENT_ID=ANY(SELECT DEPARTMENT_ID
                            FROM C##HR.DEPARTMENTS
                           WHERE LOCATION_ID=(SELECT LOCATION_ID
                                                FROM C##HR.DEPARTMENTS
                                               WHERE DEPARTMENT_ID=90)
                             AND MANAGER_ID IS NOT NULL);
 --  WHERE DEPARTMENT_ID IN(10,30,100,110);  
     
     
(90�� �μ��� ���� ��ġ�� �ִ� �μ��� �μ���ȣ)
 SELECT DEPARTMENT_ID
   FROM C##HR.DEPARTMENTS
  WHERE LOCATION_ID=(SELECT LOCATION_ID
                       FROM C##HR.DEPARTMENTS
                      WHERE DEPARTMENT_ID=90)
    AND MANAGER_ID IS NOT NULL;
     
5.ALL ������
�������)
  �÷��� ���迬���� ALL(��1,��2,...��n)
 - ���õ� �������� �� ���ο� ���� ���迬���ڸ� �����ϸ� ��(true)�� ��ȯ�ϴ� ������
 - 'AND'�� ����� ������ ������
 - ���迬���� �� '='�� ����� �� ����
 
 ��뿹)ȸ�����̺��� ������ 'ȸ���'�� ȸ���� ������ ���ϸ��� �� ���� ���� ���ϸ�������
      �� ���� ���ϸ����� ������ ȸ���� ȸ����ȣ,ȸ����,����,���ϸ����� ��ȸ�Ͻÿ�
 SELECT MEM_ID AS ȸ����ȣ,
        MEM_NAME AS ȸ����,
        MEM_JOB AS ����,
        MEM_MILEAGE AS ���ϸ���
   FROM MEMBER
  WHERE MEM_MILEAGE < ALL(2300,1500,2600)
  ORDER BY 4; 
  
 (������ 'ȸ���'�� ȸ���� ������ ���ϸ���)
  SELECT MEM_MILEAGE
    FROM MEMBER
   WHERE MEM_JOB='ȸ���'
                           
6.EXISTS ������
�������)
  WHERE EXISTS(��������)
   - ���������� ����� �����ϸ� ��, ������ ������ ��ȯ
   - EXISTS ������ �ݵ�� ���������� ���;� ��