2025-0204-02) ���̺� ����
 - RDB���� �ڷḦ �����ϴ� �⺻������ ���̺�
 - ���̺��� ��(row)�� ��(colmn)�� ����
 �������)
  create table ���̺��(
   �÷��� ������ Ÿ��[(ũ��)] [not null] [default value],
              :
   �÷��� ������ Ÿ��[(ũ��)] [not null] [default value],
   
   [constraint �⺻Ű������ primary key(�÷���[,�÷���,...])[,]]
   [constraint �ܷ�Ű������ foreign key(�÷���) references ���̺��(�÷���)][,]
                   :
   [constraint �ܷ�Ű������ foreign key(�÷���) references ���̺��(�÷���)]);
 - '�⺻Ű������'�� '�ܷ�Ű������'�� �ߺ��� �̸��� ����� �� ����.
 - 'references ���̺��(�÷���)'�� ���̺���� �θ� ���̺��� �̸��̰� �÷����� �θ� ���̺��� �÷�����
 - 'foreign key(�÷���)'�� 'primary key (�÷���[,�÷���,...])' �� �÷����� ������ ���̺��� �÷�����
 - 'not nul'�� ����� �÷��� �ڷ� �Է½�(insert into ���) �ݵ�� ����ϰų� �ڷḦ ���� �ؾ� ��
 
 
 
 
��뿹) �ֹ� ������ �� ���̺�� �����Ͻÿ�
 1) �� ���̺� ����
 CREATE TABLE CUSTOMERS (
   CUST_ID CHAR(4),
   CUST_NAME VARCHAR2(30),
   CUST_ADDR VARCHAR2(250),
   CONSTRAINT pk_CUSTOMERS PRIMARY KEY(CUST_ID)
 );
 
 2) ��ǰ ������ ����
 CREATE TABLE GOODS (
   G_ID VARCHAR2(5),
   G_NAME VARCHAR2(50),
   G_PRICE NUMBER(6), DEFAULT 0,
   CONSTRAINT pk_GOODS PRIMARY KEY(G_ID)
 );
 
  
 3) �ֹ� ������ ����
 CREATE TABLE ORDERS (
  ORDER_NUM CHAR(12),
  ORDER_AMT NUMBER(7) DEFAULT 0,
  CUST_ID CHAR(4),
  CONSTRAINT pk_orders PRIMARY KEY(ORDER_NUM),
  CONSTRAINT fk_order_cust FOREIGN KEY(CUST_ID)
    REFERENCES CUSTOMERS(CUST_ID)
 );
 
 4) �ֹ� ��ǰ������ ����
 CREATE TABLE ORDER_GOODS(
   G_ID VARCHAR2(5),
   ORDER_NUM CHAR(12),
   ORDER_QTY NUMBER(2),
   CONSTRAINT pk_order_goods PRIMARY KEY(G_ID,ORDER_NUM),
   CONSTRAINT fk_order_goods FOREIGN KEY(G_ID) REFERENCES GOODS(G_ID),
   CONSTRAINT fk_order FOREIGN KEY(ORDER_NUM) REFERENCES ORDERS(ORDER_NUM)
 );
 
    
 