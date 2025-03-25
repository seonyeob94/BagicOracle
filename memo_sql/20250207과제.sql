
다음 자료를 orders와 order_goods테이블에 저장하시오
------------------------------------------------------------------
장바구니 번호     회원번호    상품번호    구매수량
------------------------------------------------------------------
202502070001    1001        P102        5
202502070001    1001        P201        2
202502070002    2002        P102        2
202502070002    2002        P201        1
202502070002    2002        P101        4
------------------------------------------------------------------


 INSERT INTO ORDERS(ORDER_NUM,ORDER_AMT,CUST_ID) VALUES('202502070001',53500,'1001');
 INSERT INTO ORDERS(ORDER_NUM,ORDER_AMT,CUST_ID) VALUES('202502070002',27600,'2002');
 
 
 INSERT INTO ORDER_GOODS(ORDER_NUM,G_ID,ORDER_QTY) VALUES('202502070001','P102',5); 
 INSERT INTO ORDER_GOODS(ORDER_NUM,G_ID,ORDER_QTY) VALUES('202502070001','P201',2); 
 INSERT INTO ORDER_GOODS(ORDER_NUM,G_ID,ORDER_QTY) VALUES('202502070002','P102',2); 
 INSERT INTO ORDER_GOODS(ORDER_NUM,G_ID,ORDER_QTY) VALUES('202502070002','P201',1); 
 INSERT INTO ORDER_GOODS(ORDER_NUM,G_ID,ORDER_QTY) VALUES('202502070002','P101',4);
 
 
 SELECT * FROM ORDERS;
SELECT * FROM ORDER_GOODS;