2025-0204-02) 테이블 생성
 - RDB에서 자료를 저장하는 기본단위가 테이블
 - 테이블은 행(row)과 열(colmn)로 구성
 사용형식)
  create table 테이블명(
   컬럼명 데이터 타입[(크기)] [not null] [default value],
              :
   컬럼명 데이터 타입[(크기)] [not null] [default value],
   
   [constraint 기본키설정명 primary key(컬럼명[,컬럼명,...])[,]]
   [constraint 외래키설정명 foreign key(컬럼명) references 테이블명(컬럼명)][,]
                   :
   [constraint 외래키설정명 foreign key(컬럼명) references 테이블명(컬럼명)]);
 - '기본키설정명'과 '외래키설정명'은 중복된 이름을 사용할 수 없다.
 - 'references 테이블명(컬럼명)'의 테이블명은 부모 테이블의 이름이고 컬럼명은 부모 테이블의 컬럼명임
 - 'foreign key(컬럼명)'과 'primary key (컬럼명[,컬럼명,...])' 은 컬럼명은 생성한 테이블의 컬럼명임
 - 'not nul'로 선언된 컬럼은 자료 입력시(insert into 명령) 반드시 기술하거나 자료를 정의 해야 함
 
 
 
 
사용예) 주문 사항을 을 테이블로 생성하시오
 1) 고객 테이블 생성
 CREATE TABLE CUSTOMERS (
   CUST_ID CHAR(4),
   CUST_NAME VARCHAR2(30),
   CUST_ADDR VARCHAR2(250),
   CONSTRAINT pk_CUSTOMERS PRIMARY KEY(CUST_ID)
 );
 
 2) 상품 테이플 생성
 CREATE TABLE GOODS (
   G_ID VARCHAR2(5),
   G_NAME VARCHAR2(50),
   G_PRICE NUMBER(6), DEFAULT 0,
   CONSTRAINT pk_GOODS PRIMARY KEY(G_ID)
 );
 
  
 3) 주문 테이플 생성
 CREATE TABLE ORDERS (
  ORDER_NUM CHAR(12),
  ORDER_AMT NUMBER(7) DEFAULT 0,
  CUST_ID CHAR(4),
  CONSTRAINT pk_orders PRIMARY KEY(ORDER_NUM),
  CONSTRAINT fk_order_cust FOREIGN KEY(CUST_ID)
    REFERENCES CUSTOMERS(CUST_ID)
 );
 
 4) 주문 상품테이플 생성
 CREATE TABLE ORDER_GOODS(
   G_ID VARCHAR2(5),
   ORDER_NUM CHAR(12),
   ORDER_QTY NUMBER(2),
   CONSTRAINT pk_order_goods PRIMARY KEY(G_ID,ORDER_NUM),
   CONSTRAINT fk_order_goods FOREIGN KEY(G_ID) REFERENCES GOODS(G_ID),
   CONSTRAINT fk_order FOREIGN KEY(ORDER_NUM) REFERENCES ORDERS(ORDER_NUM)
 );
 
    
 