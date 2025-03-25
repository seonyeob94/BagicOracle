2025-0207-03)
다음 자료를 customers테이블에 저장하시오
--------------------------------------------------------
 회원번호    회원명     주소
--------------------------------------------------------
  1001      홍길동
  2001      이순신     대전시 중구 계룡로 846
  2002      이성계     청주시 서원구 장암동 779
  3001      박지원     
--------------------------------------------------------

 INSERT INTO CUSTOMERS (CUST_ID,CUST_NAME) VALUES(1001,'홍길동');
 INSERT INTO CUSTOMERS VALUES(2001,'이순신','대전시 중구 계룡로 846');
 INSERT INTO CUSTOMERS VALUES(3001,'박지원','');
 INSERT INTO CUSTOMERS(CUST_ID,CUST_NAME,CUST_ADDR)
   VALUES(2002,'이성계','청주시 서원구 장암동 779'); 
   --컬럼수가 많을때 헷깔릴 수가 있으니
 DELETE FROM GOODS;
 
 
 SELECT * FROM CUSTOMERS;
 다음 자료를 GOODS테이블에 저장하시오
--------------------------------------------------------
 상품번호    상품명      가격
--------------------------------------------------------
 P101       신라면         1200
 P102       빼빼로          700
 P201       마우스        25000
 P202       무선키보드     60000
 P301       전기자전거   2500000
--------------------------------------------------------
 --문자열은 ''로 표기
 INSERT INTO GOODS(G_ID,G_NAME,G_PRICE) VALUES('P101','신라면',1200);
 INSERT INTO GOODS(G_ID,G_NAME,G_PRICE) VALUES('P102','빼빼로',700);
 INSERT INTO GOODS(G_ID,G_NAME,G_PRICE) VALUES('P201','마우스',25000);
 INSERT INTO GOODS(G_ID,G_NAME,G_PRICE) VALUES('P202','무선키보드',60000);
 INSERT INTO GOODS(G_ID,G_NAME,G_PRICE) VALUES('P301','전기자전거',2500000);
  SELECT * FROM GOODS;
  
  ALTER TABLE GOODS MODIFY(G_PRICE NUMBER(7));


사용예)PROD테이블의 PROD_TOTALTOC 컬럼에 PROD_POPERSTOCK 컬럼 값의 130% 값을 입력하시오(정수)








  
  
 
