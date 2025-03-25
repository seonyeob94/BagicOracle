2025_0225_01) SUBQUERY
** DML 명령과 SUBQUERY
 - INSERT INTO, UPDATE, DELETE 명령과 같이 사용

**재고수불테이블(REMAIN)을 생성하고 다음 조건에 맞게 데이터를 삽입하시오.
------------------------------------------------
 컬럼명         데이터타입     초기값      PK/FK
------------------------------------------------
REMAIN_YEAR   CHAR(14)                PK  --여러 년도를 취합하기 위해 존재
PROD_ID       VARCHAR2(10)            PK&FK
REMAIN_J_00   NUMBER(5)               기초재고 --변경할수 없는 값
REMAIN_I      NUMBER(5)      0        입고수량합계
REMAIN_O      NUMBER(5)      0        출고수량합계
REMAIN_J_99   NUMBER(5)      0        현재고
REMAIN_DATE   DATE         SYSDATE    갱신일
------------------------------------------------

예제1)다음 자료를 재고수불테이블에 입력하시오
---------------------------------------------
 컬럼명           값      
---------------------------------------------
 REMAIN_YEAR    2020
 PROD_ID        PROD 테이블의 모든 상품
 REMAIN_J_00    PROD 테이블의 PROD_PROPERSTOCK
 REMAIN_I
 REMAIN_O
 REMAIN_J_99    PROD 테이블의 PROD_PROPERSTOCK
 REMAIN_DATE    2020년 1월 1일
---------------------------------------------
1. INSERT문과 SUBQUERY
 - INSERT문과 서브쿼리를 사용할 때에는 VALUES절과 '()'를 생략
 - INTO절에 사용된 컬럼의 갯수, 순서와 서브쿼리의 SELECT절의 컬럼의 갯수, 순서는 일치

 INSERT INTO C##sy94.REMAIN(REMAIN_YEAR,PROD_ID,REMAIN_J_00,REMAIN_J_99,REMAIN_DATE)
   SELECT '2020',PROD_ID,PROD_PROPERSTOCK,PROD_PROPERSTOCK,TO_DATE('20200101')
     FROM PROD;
     COMMIT;
     
     
2. UPDATE문과 SUBQUERY
  - 가장 많이 사용되는 dml명령
(사용형식)
  UPDATE 테이블명 [별칭]
     SET (컬럼명 [,컬럼명,...])=(SELECT 컬럼명 [,컬럼명,...])
                                FROM 테이블명
                                      :
                             )
  [WHERE 조건] 
  - SET절에 복수개의 컬럼을 기술할 수 있으며 이경우 서브쿼리의 
    SELECT 절의 컬럼의 갯수, 순서와 일치해야 한다.
  - 서브쿼리는 반드시'( )'안에 기술해야 함  
  
사용예)2020년 1월 상품별 매입수량을 조회하여 재고수불테이블을 갱신하시오
(메인쿼리:재고수불테이블을 갱신)
 UPDATE C##sy94.REMAIN A
    SET (A.REMAIN_I,A.REMAIN_J_99,A.REMAIN_DATE)=
        (SELECT A.REMAIN_I+B.BSUM, A.REMAIN_J_99+B.BSUM,TO_DATE('20200131')
           FROM (SELECT PROD_ID,
                        SUM(BUY_QTY) AS BSUM
                   FROM BUYPROD
                  WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
                  GROUP BY PROD_ID) B
          WHERE A.PROD_ID=B.PROD_ID)        
   WHERE A.PROD_ID IN(SELECT DISTINCT PROD_ID
                        FROM BUYPROD
                       WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))
                  
     SELECT * FROM REMAIN;
     
     COMMIT;
    
(서브쿼리:2020년 1월 상품별 매입수량)
  SELECT B.BSUM
    FROM (SELECT PROD_ID,
                 SUM(BUY_QTY) AS BSUM
            FROM BUYPROD
           WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
           GROUP BY PROD_ID) B
           
사용예)2020년 1월부터 7월까지 모든 상품별 매입/매출 수량을 조회하시오          
     Alias는 상품코드,매입수량합계,매출수량합계

  SELECT A.PROD_ID AS 상품코드,
         SUM(B.BUY_QTY) AS 매입수량합계,
         SUM(C.CART_QTY) AS 매출수량합계
    FROM PROD A 
    LEFT OUTER JOIN BUYPROD B ON(A.PROD_ID=B.PROD_ID)
    LEFT OUTER JOIN CART C ON(A.PROD_ID=C.PROD_ID)
   GROUP BY A.PROD_ID

 (서브쿼리1: 2020년 2월부터 7월까지 매입집계)=>A
 (SELECT PROD_ID ,
         SUM(BUY_QTY) AS ASUM
    FROM BUYPROD
   WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200731')
   GROUP BY PROD_ID) A
    
 (서브쿼리2: 2020년 1월부터 7월까지 매출집계)=>B
 (SELECT PROD_ID, SUM(CART_QTY) AS BSUM
    FROM CART
   WHERE SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202007'
   GROUP BY PROD_ID) B

 
 메인쿼리:PROD테이블과 테이블A, 테이블B를 외부조인)

  SELECT C.PROD_ID AS 상품코드,
         NVL(A.ASUM,0) AS 매입수량합계,
         NVL(B.BSUM,0) AS 매출수량합계
    FROM PROD C,
         (SELECT PROD_ID ,
                 SUM(BUY_QTY) AS ASUM
            FROM BUYPROD
           WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200731')
           GROUP BY PROD_ID) A,
         (SELECT PROD_ID, SUM(CART_QTY) AS BSUM
            FROM CART
           WHERE SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202007'
           GROUP BY PROD_ID) B 
   WHERE A.PROD_ID(+)=C.PROD_ID
     AND B.PROD_ID(+)=C.PROD_ID
   ORDER BY 1; 

(ANSI OUTER)


  SELECT C.PROD_ID AS 상품코드,
         NVL(SUM(A.BUY_QTY),0) AS 매입수량합계,
         NVL(SUM(B.CART_QTY),0) AS 매출수량합계
    FROM PROD C
    LEFT OUTER JOIN BUYPROD A ON(A.PROD_ID=C.PROD_ID AND 
         BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200731'))
    LEFT OUTER JOIN CART B ON(A.PROD_ID=B.PROD_ID AND
         SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202007') 
   GROUP BY C.PROD_ID  
   ORDER BY 1;   
   
  SELECT C.PROD_ID AS 상품코드,
         NVL(A.ASUM,0) AS 매입수량합계,
         NVL(B.BSUM,0) AS 매출수량합계
    FROM PROD C
    LEFT OUTER JOIN (SELECT PROD_ID , SUM(BUY_QTY) AS ASUM
                       FROM BUYPROD
                      WHERE BUY_DATE BETWEEN TO_DATE('20200201') 
                        AND TO_DATE('20200731')
                      GROUP BY PROD_ID) A 
         ON(A.PROD_ID=C.PROD_ID)
    LEFT OUTER JOIN (SELECT PROD_ID, SUM(CART_QTY) AS BSUM
                       FROM CART
                      WHERE SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202007'
                      GROUP BY PROD_ID) B 
         ON(B.PROD_ID=C.PROD_ID) 
   ORDER BY 1; 
    
    

   
사용예) 위 예제에서 구한 결과로 재고수불테이블을 갱신하시오
  UPDATE REMAIN R
     SET (R.REMAIN_I,R.REMAIN_O,R.REMAIN_J_99,R.REMAIN_DATE)=
         (SELECT R.REMAIN_I+D.BUYSUM,
                 R.REMAIN_O+D.CARTSUM,
                 R.REMAIN_J_99+D.BUYSUM-D.CARTSUM,
                 TO_DATE('20200731')
            FROM ( SELECT C.PROD_ID AS PID,
                          NVL(A.ASUM,0) AS BUYSUM,
                          NVL(B.BSUM,0) AS CARTSUM
                     FROM PROD C,
                         (SELECT PROD_ID ,
                                 SUM(BUY_QTY) AS ASUM
                            FROM BUYPROD
                           WHERE BUY_DATE BETWEEN TO_DATE('20200201') 
                                 AND TO_DATE('20200731')
                           GROUP BY PROD_ID) A,
                         (SELECT PROD_ID, SUM(CART_QTY) AS BSUM
                            FROM CART
                           WHERE SUBSTR(CART_NO,1,6) BETWEEN '202001' 
                                 AND '202007'
                           GROUP BY PROD_ID) B 
                     WHERE A.PROD_ID(+)=C.PROD_ID
                       AND B.PROD_ID(+)=C.PROD_ID) D
            WHERE D.PID=R.PROD_ID); 
         
         COMMIT;
  SELECT * FROM REMAIN;        
  
  UPDATE REMAIN R
     SET (R.REMAIN_I,R.REMAIN_O,R.REMAIN_J_99,R.REMAIN_DATE) =
         (SELECT R.REMAIN_I+D.BUYSUM,
                 R.REMAIN_O+D.CARTSUM,
                 R.REMAIN_J_99+D.BUYSUM-D.CARTSUM,
                 TO_DATE('20200731')
            FROM (SELECT C.PROD_ID AS PID,
                         NVL(A.ASUM,0) AS BUYSUM,
                         NVL(B.BSUM,0) AS CARTSUM
                    FROM PROD C, 
                        (SELECT PROD_ID, SUM(BUY_QTY) AS ASUM
                           FROM BUYPROD
                          WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200731')
                          GROUP BY PROD_ID)A,
                        (SELECT PROD_ID, SUM(CART_QTY) AS BSUM
                           FROM CART
                          WHERE SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202007'
                          GROUP BY PROD_ID)B  
                  WHERE A.PROD_ID(+)=C.PROD_ID
                    AND B.PROD_ID(+)=C.PROD_ID)D
           WHERE D.PID=R.PROD_ID); 
      





