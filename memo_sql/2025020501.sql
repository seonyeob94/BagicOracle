2025020501) ������ Ÿ��
 - ���ڿ�, ����, ��¥, 2�� �ڷ�Ÿ���� ����
 
 1. ���ڿ� �ڷ���
  - ��������: CHAR, NCHAR
  - ��������: VARCHAR, VARCHAR2, LONG, CLOB
  
  1) CHAR
   - ��������, 2000byte ���� ���尡��(�ѱ��� �ѱ��ڰ� 3byte)
   - ���� ����(������)�� ����ó��
   - �������� �����ϸ� ����
�������)
 �÷��� CHAR(ũ��[BYTE|CHAR])
 
��뿹)
 CREATE TABLE TEMP01(
   COL1 CHAR(50),
   COL2 CHAR(50 BYTE),
   COL3 CHAR(50 CHAR)
 );
 
 INSERT INTO ���̺��[(�÷���,...)] VAUES(��,...);
 
 INSERT INTO TEMP01 VALUES('������ �߱� ���� 846','������ �߱� ���� 846',
                           '������ �߱� ���� 846');
 
                           
SELECT * FROM TEMP01;
--lengthb ���ڿ��� ����Ʈ ���� ���ϴ� �Լ�
SELECT LENGTHB(COL1) AS "COL1",
       LENGTHB(COL2) AS "COL2",
       LENGTHB(COL3) AS "COL3"
  FROM TEMP01;
    DELETE FROM TEM01;
                           
 INSERT INTO TEMP01 VALUES('1234567890123456789012345678901234567890123456789012','',''); 
 
 2) VARCHAR,VARCHAR2, NVARCHAR, NVARCHAR2
   - ��������, 4000byte ���� ���尡��(�ѱ��� �ѱ��ڰ� 3BYTE)
   - �����͸� �����ϰ� ���°����� ��ȯ
   - �������� �����ϸ� ����
   
��뿹)
 CREATE TABLE TEMP02(
   COL1 VARCHAR2(4000),
   COL2 VARCHAR2(4000CHAR),
   COL3 NVARCHAR2(200)
 );
 
 INSERT INTO TEMP02 VALUES('������ �߱� ���� 846','������ �߱� ���� 846',
                           '������ �߱� ���� 846');
   
 SELECT*FROM TEMP02;
   
 SELECT LENGTHB(COL1) AS "COL1",
          LENGTHB(COL2) AS "COL2",
          LENGTHB(COL3) AS "COL3"
   FROM TEMP02;
   
  2) LONG, CLOB(Character Large OBject)
   - ��������, long�� 2GB/CLOB�� 4GB ���� ���尡��(�ѱ��� �ѱ��ڰ� 3BYTE)
   - �����͸� �����ϰ� ���°����� ��ȯ
   - �Ϻ� ���(�Լ�)�� ����
   - LONGŸ���� �� ���̺� 1���� ��� ����
   - CLOB�� LONGŸ���� ������ ���·� ��� ������ ���� ����
�������)
 �÷��� LONG|CLOB
   

��뿹)
 CREATE TABLE TEMP03(
   COL1 VARCHAR2(4000),
   COL2 LONG,
 --  COL3 LONG, --longŸ�� �÷��� �� ���̺�� �ϳ��� �� �� �ִ�
   COL4 CLOB,
   COL5 CLOB);

 INSERT INTO TEMP03(COL1,COL2,COL4)
   VALUES('������ �߱� ���� 846','������ �߱� ���� 846',
                           '������ �߱� ���� 846');
   
 SELECT*FROM TEMP03;
   
 SELECT LENGTHB(COL1) AS "COL1",
         -- LENGTHB(COL2) AS "COL2",
        DBMS_LOB.GETLENGTH(COL4) AS "COL4",
        LENGTH(COL4) AS "COL4-1"
   FROM TEMP03;  
   
   
   
   
   
   