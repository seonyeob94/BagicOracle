2025-0206-03)��Ÿ�ڷ���
 - RAW, LONG RAW, BFILE, BLOB���� ����
 - �ַ� �����ڷ�(������ �ڷ�)�� �����ϴ� ������ Ÿ��
 - �ؼ��ǰų� ��ȯ���� ����
1. RAW
 - ���� ���� ũ���� �����ڷ� ���� 
�������)
 �÷��� RAW(ũ��)
  - 2000 BYTE���� ���� ����
  - ���ؽ�ó�� ����
  - 16������ 2���� ���·� ����
��뿹)
  CREATE TABLE TEMP06(
    COL1 RAW(2000)
  );
 
  INSERT INTO TEMP06 VALUES(HEXTORAW('A5FC'));
  INSERT INTO TEMP06 VALUES(HEXTORAW('1010100111111100'));
  
 
  SELECT * FROM TEMP06;

2. BFILE
 - 4GB�� �����ڷ� ����
 - �����ڷḦ ���̺� �ۿ� �����ϰ� ���̺��� ���(path)�� ���ϸ� ����
 - �����ڷᰡ ���� ����Ǵ� ��� ȿ����
�������)
 �÷��� BEFILE
 
��뿹)
  CREATE TABLE TEMP07(
    COL BFILE
  );
  1) �����غ�
   CREATE [OR REPLACE]DIRECTORY ���丮��ü�� AS '������;
   CREATE OR REPLACE DIRECTORY TEST_DIR AS
      'D:\A_TeachingMaterial\02_Oracle\work';
  2) ���丮 ��ü ����
    INSERT INTO TEMP07 VALUES(BFILENAME('TEST_DIR','LUPPY.jpg'));
    
    SELECT*FROM TEMP07;
  3) ������ ���̺� ����
  
  
  
  
3. BLOB(Binary Large OBject)
 - 4GB�� �����ڷ� ����
 - �����ڷḦ ���̺� �ȿ� ����
 - �����ڷ� ������ �߻����� �ʴ� ��� ȿ����
�������)
 �÷��� BLOB
 
��뿹)
 CREATE TABLE TEMP08(
   NO NUMBER,
   BLOB_FILE BLOB
 );  
 
  CREATE TABLE TEMP08(
   NO NUMBER,
   BLOB_FILE BLOB
 );  
 
  CREATE SEQUENCE SEQ_BLOB
    START WITH 1;
 
  CREATE OR REPLACE PROCEDURE proc_blob_insert(
   P_FILENAME IN VARCHAR2)
  IS
    V_LOCATOR BLOB; --����
    V_SOURCE_DATE_FILE BFILE := BFILENAME('TEST_DIR',P_FILENAME);
    V_DOFFSET NUMBER := 1; -- ����
    V_SOFFSET NUMBER := 1;
  BEGIN
    INSERT INTO TEMP08(NO,BLOB_FILE) VALUES(SEQ_BLOB.NEXTVAL,EMPTY_BLOB())
      RETURNING BLOB_FILE INTO V_LOCATOR;
      
      DBMS_LOB.OPEN(V_SOURCE_DATE_FILE, DBMS_LOB.LOB_READONLY);
      DBMS_LOB.LOADBLOBFROMFILE(V_LOCATOR,
                               V_SOURCE_DATE_FILE,
                               DBMS_LOB.GETLENGTH(V_SOURCE_DATE_FILE),--������ ���̸�ŭ
                               V_DOFFSET,
                               V_SOFFSET);
      DBMS_LOB.CLOSE(V_SOURCE_DATE_FILE);
      COMMIT;
  END;    
  
  
  EXECUTE proc_blob_insert('LUPPY.jpg');