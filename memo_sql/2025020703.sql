2025-0207-03)
���� �ڷḦ customers���̺� �����Ͻÿ�
--------------------------------------------------------
 ȸ����ȣ    ȸ����     �ּ�
--------------------------------------------------------
  1001      ȫ�浿
  2001      �̼���     ������ �߱� ���� 846
  2002      �̼���     û�ֽ� ������ ��ϵ� 779
  3001      ������     
--------------------------------------------------------

 INSERT INTO CUSTOMERS (CUST_ID,CUST_NAME) VALUES(1001,'ȫ�浿');
 INSERT INTO CUSTOMERS VALUES(2001,'�̼���','������ �߱� ���� 846');
 INSERT INTO CUSTOMERS VALUES(3001,'������','');
 INSERT INTO CUSTOMERS(CUST_ID,CUST_NAME,CUST_ADDR)
   VALUES(2002,'�̼���','û�ֽ� ������ ��ϵ� 779'); 
   --�÷����� ������ ��� ���� ������
 DELETE FROM GOODS;
 
 
 SELECT * FROM CUSTOMERS;
 ���� �ڷḦ GOODS���̺� �����Ͻÿ�
--------------------------------------------------------
 ��ǰ��ȣ    ��ǰ��      ����
--------------------------------------------------------
 P101       �Ŷ��         1200
 P102       ������          700
 P201       ���콺        25000
 P202       ����Ű����     60000
 P301       ����������   2500000
--------------------------------------------------------
 --���ڿ��� ''�� ǥ��
 INSERT INTO GOODS(G_ID,G_NAME,G_PRICE) VALUES('P101','�Ŷ��',1200);
 INSERT INTO GOODS(G_ID,G_NAME,G_PRICE) VALUES('P102','������',700);
 INSERT INTO GOODS(G_ID,G_NAME,G_PRICE) VALUES('P201','���콺',25000);
 INSERT INTO GOODS(G_ID,G_NAME,G_PRICE) VALUES('P202','����Ű����',60000);
 INSERT INTO GOODS(G_ID,G_NAME,G_PRICE) VALUES('P301','����������',2500000);
  SELECT * FROM GOODS;
  
  ALTER TABLE GOODS MODIFY(G_PRICE NUMBER(7));


��뿹)PROD���̺��� PROD_TOTALTOC �÷��� PROD_POPERSTOCK �÷� ���� 130% ���� �Է��Ͻÿ�(����)








  
  
 
