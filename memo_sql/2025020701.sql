2025-0207-01)ALTER
 - ����Ŭ ��ü�Ǳ��� ���� ����
 - ���̺� �̸� ����
 - �÷� : �߰�(ADD), ����(DROP), �̸�(RENAME) �� ������ Ÿ�� ����(MODIFY)
 - ���� ���� : �߰�, ����, ����
1. ���̺�� ����
�������)
  ALTER TABLE old_table_name RENAME TO new_table_name;
  
��뿹) GOODS���̺� �̸��� PREODUCTS�� ����
  ALTER TABLE GOODS RENAME TO PRODUCTS;
 
2. �÷�
 - ALTER TABLE ���̺�� ADD|DROP COLUMN|MODIFY(�÷���|�÷��� ������Ÿ��[(ũ��)])
 --DROP���� �÷��� �ʿ�
 --INSET�� ������� ���� �÷� �ϳ��� �߰��� ���� x(UPDATD���), INSERT�� �����/UPDATE�� �÷�����
��뿹) HR������ EMPLOYEES���̺� 'EMP_NAME'�÷��� VARCHAR2(40)�߰��ϰ�
       FRST_NAME �� LAST_NAME�� ���� �������� �����Ͽ� �������� �����Ͻÿ�
 1) ���̺� �߰�       
   ALTER TABLE C##HR.EMPLOYEES ADD(EMP_NAME VARCHAR2(40));
   
 2) EMP_NAME�÷��� ũ�⸦ VARCHAR2(50)���� ����--�������Ϻ��� ���� ������ �����ؼ��� �ʵȴ�
  ALTER TABLE C##HR.EMPLOYEES MODIFY(EMP_NAME VARCHAR2(50));
  
 3)FRST_NAME �� LAST_NAME�� ���� ������ �����Ͽ� ����
   UPDATE C##HR.EMPLOYEES
     SET EMP_NAME=TRIM(FIRST_NAME)||' '||TRIM(LAST_NAME);
  COMMIT;
 4)FIRST_NAME�� LAST_NAME�÷��� ����--���� ����
   ALTER TABLE C##HR.EMPLOYEES DROP COLUMN FIRST_NAME;
   ALTER TABLE C##HR.EMPLOYEES DROP COLUMN LAST_NAME;
   
 5)�÷��̸� ����
   ALTER TABLE ���̺�� RENAME COLUMN old_column_name TO new_column_name;

��뿹)PRODUCTS���̺��� �÷�(G_ID,G_NAME,G-PRICE)��
      PROD_ID,PROD_NAME,PROD_PRICE�� �����Ͻÿ�
   ALTER TABLE PRODUCTS RENAME COLUMN G_ID TO PROD_ID;    
   ALTER TABLE PRODUCTS RENAME COLUMN G_NAME TO PROD_NAME; 
   ALTER TABLE PRODUCTS RENAME COLUMN G_PRICE TO PROD_PRICE; 

   ALTER TABLE ORDER_GOODS RENAME COLUMN G_ID TO PROD_ID;
   
   COMMIT;
   
** PRACTICE ������ ��� ���̺��� �����Ͻÿ�
   DROP TABLE ���̺��;
   
   DROP TABLE "order_goods";
   DROP TABLE "orders";
   DROP TABLE "customers";
   DROP TABLE PRODUCTS;
   DROP TABLE "goods";
   
   DROP TABLE TEMP01;
   DROP TABLE TEMP02;
   DROP TABLE TEMP03;
   DROP TABLE TEMP04;
   DROP TABLE TEMP05;
   DROP TABLE TEMP06;
   DROP TABLE TEMP07;
   DROP TABLE TEMP08;
   