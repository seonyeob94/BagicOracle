2025-0213-02) ��¥�Լ�
 - SYSDATE, SYSTIMESTAMP
 - ADD_MONTHS,MONTHS_BETWEEN
 - NEXT_DAY, LAST_DAY
 
 --ADD_MONTHS/SYSDATE
��뿹)HR������ ������̺��� ��� �Ի����� 6�� �ڷ� �����Ͻÿ�
 UPDATE C##HR.EMPLOYEES
    SET HIRE_DATE=ADD_MONTHS(HIRE_DATE,70);

 SELECT MOD(TRUNC(SYSDATE)-TRUNC(TO_DATE('00010101'))-1,7)--���� ���� ���ϱ�
   FROM DUAL;
--����   
 SELECT CASE MOD(TRUNC(SYSDATE)-TRUNC(TO_DATE('00010101'))-1,7)
             WHEN 0 THEN '�Ͽ���'
             WHEN 1 THEN '������'
             WHEN 2 THEN 'ȭ����'
             WHEN 3 THEN '������'
             WHEN 4 THEN '�����'
             WHEN 5 THEN '�ݿ���'
             ELSE '�����'
        END AS DYDLF     
   FROM DUAL;  
   
--NEXT_DAT/LAST_DAY
  SELECT TO_CHAR(SYSDATE,'DAY'),
        NEXT_DAY(SYSDATE,'��'),
        NEXT_DAY(SYSDATE,'ȭ����')
   FROM DUAL;    
   
��뿹)���� ���̺��� 2020�� 2�� ��ǰ�� ���Լ����� ���Աݾ��� ��ȸ�Ͻÿ�
  SELECT A.PROD_ID AS ��ǰ�ڵ�,
         B.PROD_NAME AS ��ǰ��,
         SUM(A.BUY_QTY) AS ���Լ���,
         SUM(A.BUY_QTY*B.PROD_COST) AS ���Աݾ�
    FROM BUYPROD A, PROD B
   WHERE A.PROD_ID=B.PROD_ID
     AND A.BUY_DATE BETWEEN TO_DATE('20200201') AND 
                   LAST_DAY(TO_DATE('20200201'))
   GROUP BY A.PROD_ID, B.PROD_NAME;                

  SELECT TRUNC(TO_DATE('20200819'),'Q') FROM DUAL;
  
--EXTRACT
��뿹)ȸ�����̺��� ȸ������ ������� ���� ���ʽ��� �����Ϸ� �Ѵ�
      �̹��� ���ʽ��� �޴� ȸ�������� ��ȸ�Ͻÿ�
      Alias�� ȸ������,ȸ����,�������,���ϸ���
  SELECT MEM_ID AS ȸ������,
         MEM_NAME AS ȸ����,
         MEM_BIR AS �������,
         MEM_MILEAGE AS ���ϸ���
    FROM MEMBER
   WHERE EXTRACT(MONTH FROM SYSDATE)=EXTRACT(MONTH FROM MEM_BIR);
   
--MONTHS_BETWEEN(date1, date2)
 .date1�� date2 ���̿� �����ϴ� ���� ��
 .�Ҽ��� �߻� ����(TRUNC ����ؼ� ����)

��뿹) ������̺��� �� ������� �ټӳ���� XX�� XX���� �������� ���
  SELECT EMPLOYEE_ID,
         EMP_NAME,
         HIRE_DATE,
         TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)||'�� '||
         TRUNC(MOD(MONTHS_BETWEEN(SYSDATE,HIRE_DATE),12))||'����'
    FROM C##HR.EMPLOYEES;   

  


