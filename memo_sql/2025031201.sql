2025-0312-01)User Defined Function(Function)
 - 반환 값이 있는 모듈
 - select문이 DML명령 내부에서 사용할 수 있다.
 (사용형식)
   CREATE [OR REPLACE] FUNCTION 함수명
    [(변수명 [IN|OUT|INOUT] 데이터 타입,...)]
    RETURN 데이터 타입
   AS|IS
     선언영역
   BEGIN
     실행영역
   END;
   . 실행영역에서 반드시 하나 이상의 RETURN문이 존재하여 
     결과를 반환해야 함
   . 'RETURN 테이터 타입'이나 '변수명 [IN|OUT|INOUT] 데이터 타입'에서
     데이터 타입만 기술해야 함(크기기술하면 오류)
     
사용예)월을 입력받아 해당 월에 매입금액을 반환하는 프로시져를 출력하시오
  
  CREATE OR REPLACE PROCEDURE proc_amt_buyprod(
    P_MONTH IN VARCHAR2, 
    P_AMT_BUY OUT NUMBER)
  IS
    L_START DATE:=TO_DATE('2020'||TO_CHAR(P_MONTH, '00')||'01');  
    L_END DATE:=LAST_DAY(L_START);
  BEGIN
    SELECT SUM(A.BUY_QTY*B.PROD_COST) INTO P_AMT_BUY
      FROM BUYPROD A, PROD B
     WHERE A.PROD_ID=B.PROD_ID
       AND A.BUY_DATE BETWEEN L_START AND L_END;
       
     EXCEPTION
       WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('예외발상: '||SQLERRM);
  END;
  
[실행]
  DECLARE
    L_AMT_BUY NUMBER:=0;
  BEGIN
    proc_amt_buyprod(9,L_AMT_BUY);
    DBMS_OUTPUT.PUT_LINE('매입금액 합계:'||
                                   TO_CHAR(NVL(L_AMT_BUY,0),'999,999,999'));
  END;

사용예)오늘 날짜(2020년 7월 12일)에 다음 매입자료를 처리하시오.
-------------------------
  상품코드        매입수량
-------------------------
 P201000005     30
 2020  P201000005  9  58  4  63  2020/07/31
                   9  88  4  93  2020/07/12               
 P201000018     15
 2020	P201000018	11	544	108	490	2020/07/21
                        559 108 505 2020/07/12
2020	P201000018	11	559	108	505	2020/07/12                
 EXECUTE proc_insert_buyprod(TO_DATE('20200712'),'P201000018',15);
 P302000014     20
COMMIT;

  매입테이블에 INSERT -> 재고수불테이블 UPDATE
  INSERT INTO BUYPROD VALUES(TO_DATE('20200712'), 'P201000005',30);
  UPDATE REMAIN
     SET REMAIN_I=REMAIN_I+30,
         REMAIN_J_99=REMAIN_J_99+30,
         REMAIN_DATE=TO_DATE('20200712')
   WHERE REMAIN_YEAR='2020'
     AND PROD_ID='P201000005';
     

  CREATE OR REPLACE PROCEDURE proc_insert_buyprod(
    P_BUY_DATE IN DATE, P_PROD_ID IN VARCHAR2, P_QTY IN NUMBER)
  IS
  BEGIN
    INSERT INTO BUYPROD 
       VALUES(P_BUY_DATE, P_PROD_ID,p_QTY);
       
    UPDATE REMAIN
     SET REMAIN_I=REMAIN_I+P_QTY,
         REMAIN_J_99=REMAIN_J_99+P_QTY,
         REMAIN_DATE=P_BUY_DATE
   WHERE REMAIN_YEAR='2020'
     AND PROD_ID=P_PROD_ID;   
  COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('예외발생: '||SQLERRM);
      ROLLBACK;
  END;
  2020년 7월 12
사용예) 오늘날짜(2020년 7월 19일)의 매출자료가 다음과 같다.
     이를 처리하는 프로시저를 작성하시오
 ---------------------------------------
   구매회원   상품코드         수량
 ---------------------------------------  
--    f001    p201000003     2
--            p202000003     1
    U001    p201000003     2
    2020 P201000003 9 24 7 26 2020/07/31
    2020 P201000003 9 24 9 24 2020/07/19
    마일리지 2700->2726
    
    EXEC proc_insert_cart('20200719','u001','P201000003',2);
    
    f001    p202000003     1         
     마일리지 2700->2709(?)
     2020 p202000003 9 16 17 8 2020/0731
     
    EXEC proc_insert_cart('20200719','f001','P202000003',1);
     
     
            
  CREATE OR REPLACE PROCEDURE proc_insert_cart(
    P_DATE IN VARCHAR2, P_MID IN MEMBER.MEM_ID%TYPE,
    P_PID IN VARCHAR2, P_QTY IN NUMBER)
  IS
    L_CNT NUMBER:=0; --해당일자에 로그인한 회원수
    L_CART_NO CART.CART_NO%TYPE; --임시 장바구니 번호
    L_MID MEMBER.MEM_ID%TYPE; --최대바구니번호를 갖고있는 회원번호
    L_MILEAGE NUMBER:=0; -- 증가시킬 마일리지
  BEGIN
    --CART TABLE INSERT
    SELECT COUNT(*) INTO L_CNT
      FROM CART
     WHERE CART_NO LIKE P_DATE||'%'; 
     
    IF L_CNT= 0 THEN
       L_CART_NO := P_DATE||TRIM('00001');
    ELSE
       SELECT MAX(CART_NO) INTO L_CART_NO
         FROM CART
        WHERE CART_NO LIKE P_DATE||'%';
        
       SELECT DISTINCT MEM_ID INTO L_MID
         FROM CART
        WHERE CART_NO=L_CART_NO; 
        
        IF P_MID !=L_MID THEN
           L_CART_NO:=L_CART_NO+1;
         END IF;  
       END IF;
       
       
       INSERT INTO CART VALUES(P_MID,L_CART_NO,P_PID,P_QTY);
    --REMAIN TABLE UPDATE
    UPDATE REMAIN
       SET REMAIN_O=REMAIN_O+P_QTY,
           REMAIN_J_99=REMAIN_J_00-P_QTY,
           REMAIN_DATE=TO_DATE(P_DATE)
     WHERE PROD_ID=P_PID;     
    --MEMBER TABLE UPDATE
    SELECT P_QTY*PROD_MILEAGE INTO L_MILEAGE
      FROM PROD
     WHERE PROD_ID=P_PID;
     
    UPDATE MEMBER
       SET MEM_MILEAGE=MEM_MILEAGE+L_MILEAGE
     WHERE MEM_ID=P_MID;
     
     COMMIT;
  END;











