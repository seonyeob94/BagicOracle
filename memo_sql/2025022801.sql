2025_0228-01) SEQUENCE
 - ���ʴ�� ����[����]�ϴ� ���� �߻���Ű�� ��ü
 
��뿹)�������� ����Ͽ� ���� �ڷḦ LPROD���̺� �����Ͻÿ�
  [�ڷ�]
-------------------------------------
  LPROD_ID   LPROD_GU   LPROD_NAME
-------------------------------------
    10       P501         ��깰
    11       P502         ���깰
    
(������ ����)
  CREATE SEQUENCE seq_lprod_id
    START WITH 10;
    
  INSERT INTO LPROD VALUES(seq_lprod_id.NEXTVAL, 'P501','��깰');
  INSERT INTO LPROD VALUES(seq_lprod_id.NEXTVAL, 'P502','���깰');
  
  SELECT * FROM LPROD;
  
 ** ���Ǿ�(SYNONYM)
  - ��ü�� �ο��� �� �ٸ� �̸�
  - �ַ� �ٸ� �������� ��ü�� �ο��ϴ� ��Ī���� ���
�������)
  CREATE [OR REPLACE] SYNONYM ���Ǿ�� FOR ��ü��
  
��뿹)HR������ EMPLOYEES���̺�� DEPARTMENTS���̺� ���� EMP�� DEPT
     ��Ī�� �ο��ϰ� 30�� �μ��� ���� ��������� ��ȸ�Ͻÿ�
  CREATE OR REPLACE SYNONYM EMP FOR C##HR.EMPLOYEES;  
  CREATE OR REPLACE SYNONYM DEPT FOR C##HR.DEPARTMENTS;   
     
  SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_NAME, A.SALARY
    FROM EMP A, DEPT B
   WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
     AND A.DEPARTMENT_ID=30;
     
��뿹)
  CREATE OR REPLACE SYNONYM MyDual FOR SYS.DUAL;
  
  SELECT SYSDATE FROM MYDUAL;
  
  
** index
 - �˻��� ȿ������ �����Ű�� ����
 - tree ������ ����Ͽ� ����, ������Ű�Ƿ� �������� ����/����/������ ����� �߻��Ǵ�
   ��쿡�� ��ȿ������
 
  CREATE [UNIQUE | BITMAP] INDEX �ε���
    ON ���̺��(Į����,...);
    
  DROP INDEX EMP_DEPARTMENT_IX;  
  DROP INDEX EMP_EMAIL_UK;  
  DROP INDEX EMP_EMP_ID_PK;  --�⺻Ű�� ������ �ȵ�
  DROP INDEX EMP_JOB_IX;  
  DROP INDEX EMP_MANAGER_IX;   
  COMMIT;
  
�������)
��뿹)HR������ ������̺��� �̸��� 'Amit Banda'��� ������ ��ȸ�غ���
     �̸� �÷����� �ε��� ���� �� �ش� ��������� ��ȸ�Ͽ� �ӵ����̸� ��
  SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE, DEPARTMENT_ID, JOB_ID
    FROM EMP
   WHERE EMP_NAME='Amit Banda'; 
   
(INDEX ����)
 CREATE INDEX idx_emp_name ON EMP(EMP_NAME);
 
  ALTER INDEX idx_emp_name REBUILD;
     