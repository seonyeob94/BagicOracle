2025-0313-04)
 재고UPDATE - 판매되었을때
 
  CREATE OR REPLACE TRIGGER tg_change_cart
    AFTER INSERT OR UPDATE OR DELETE ON CART
    FOR EACH ROW
  DECLARE
    L_QTY NUMBER:=0;
    L_PROD_ID PROD.PROD_ID%TYPE;
    L_MILEAGE NUMBER:=0;
    L_MID MEMBER.MEM_ID%TYPE;
    L_DATE DATE;
  BEGIN
    IF INSERTING THEN
       L_MID:=(:NEW.MEM_ID);
       L_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
       L_PROD_ID:=(:NEW.PROD_ID);
       L_QTY:=(:NEW.CART_QTY);
    ELSIF UPDATING THEN   
       L_MID:=(:NEW.MEM_ID);
       L_DATE:=TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
       L_PROD_ID:=(:NEW.PROD_ID);
       L_QTY:=(:NEW.CART_QTY - :OLD.CART_QTY);
    ELSIF DELETING THEN   
       L_MID:=(:OLD.MEM_ID);
       L_DATE:=TO_DATE(SUBSTR(:OLD.CART_NO,1,8));
       L_PROD_ID:=(:OLD.PROD_ID);
       L_QTY:= (-:OLD.CART_QTY);
   END IF;
   
   UPDATE REMAIN
      SET REMAIN_O=REMAIN_O+L_QTY,
          REMAIN_J_99=REMAIN_J_99 - L_QTY,
          REMAIN_DATE=L_DATE
    WHERE PROD_ID=L_PROD_ID;  
    
   SELECT PROD_MILEAGE*L_QTY INTO L_MILEAGE
     FROM PROD
    WHERE PROD_ID=L_PROD_ID;
    
   UPDATE MEMBER
      SET MEM_MILEAGE=MEM_MILEAGE+L_MILEAGE
    WHERE MEM_ID=L_MID;  
    
  END;
  
  [실행] 2020년 6월 13일 'a001'회원이 다음 물품을 구매하였다
         이를 처리하시오
 -----------------------------
 상품코드        구매수량
 -----------------------------
 P301000002      10
                    기초 입  출   현
 2020	P301000002	52	32	15	69	2020/07/31
                            25  59  2020/06/13
 2020	P301000002	52	32	25	59	2020/06/13                           
 
  INSERT INTO CART
     VALUES('a001', fn_create_cart_no('a001',TO_DATE('20200613')),'P301000002',10);