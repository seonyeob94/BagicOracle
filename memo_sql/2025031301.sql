2025-0313-01)
사용예)상품코드를 입력 받아 2020년 판매횟수와 판매금액 합계를 조회하는 함수를
     작성하시오
(판매횟수 반환)
  CREATE OR REPLACE FUNCTION fn_count_sale(P_PID IN PROD.PROD_ID%TYPE)
    RETURN NUMBER
    IS
      L_CNT NUMBER:=0; --판매횟수
    BEGIN
      SELECT COUNT(*) INTO L_CNT
        FROM CART
       WHERE PROD_ID=P_PID;
      RETURN L_CNT;    
    END;
    
(판매금액 반환)
  CREATE OR REPLACE FUNCTION fn_sum_sale(P_PID IN PROD.PROD_ID%TYPE)
    RETURN NUMBER
    IS
      L_SUM NUMBER:=0; --판매금액합계
    BEGIN
      SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO L_SUM
        FROM CART A, PROD B
       WHERE A.PROD_ID=B.PROD_ID
         AND A.PROD_ID=P_PID;
      RETURN L_SUM;    
    END;
    
(실행)    
  SELECT PROD_ID AS 상품코드,
         PROD_NAME AS 상품명,
         NVL(fn_count_sale(PROD_ID),0) AS 판매횟수,
         TO_CHAR(NVL(fn_sum_sale(PROD_ID),0),'999,999,999') AS 판매금액
    FROM PROD; 