2025-0214-03) ROLLUP과 CUBE
 - GROUP BY 절 안에 기술하여 다양한 집계를 반환
1. ROLLUP
 - 레벨별 집계를 반환
 --따로는 못쓰고 GROUP BY절 안에 사용
사용형식)
  GROUP BY [컬럼명,] ROLLUP(컬럼명 [,...]) [,컬럼명...]
  - ROLLUP 절 안에 기술된 컬럼들이 모두 적용된 집계를 반환한 후
    오른쪽부터 하나씩 컬럼명을 제거한 집계를 반환함.
  - 최종적으로 모든 컬럼을 제거(ROLLUP절 안의 컬럼만 해당)한 집계(전체집계)
    를 반환하여 ROLLUP절에 사용된 컬럼의 수가 n개일때 n+1종류의 집계반환
  - ROLLUP 밖에 컬럼을 기술한 경우(ex GROUP BY 컬럼명, ROLLUP(col1,col2))
    부분 ROLLUP이라하며 이 경우 'GROUP BY 컬럼명'에서 '컬럼명'은 상수에 해당
    되어 전체 집계는 반환되지 않음

사용예)장바구니테이블에서 월별,회원별,상품별 판매수량합계를 조회하시오    
(ROLLUP을 미사용)
  SELECT SUBSTR(CART_NO,5,2) AS 월,
         MEM_ID AS 회원번호,
         PROD_ID AS 상품코드,
         SUM(CART_QTY) AS 판매수량합계 
    FROM CART
   GROUP BY SUBSTR(CART_NO,5,2), MEM_ID, PROD_ID
   ORDER BY 1;
   
(ROLLUP을 사용)
  SELECT SUBSTR(CART_NO,5,2) AS 월,
         MEM_ID AS 회원번호,
         PROD_ID AS 상품코드,
         SUM(CART_QTY) AS 판매수량합계 
    FROM CART
   GROUP BY ROLLUP(SUBSTR(CART_NO,5,2), MEM_ID, PROD_ID)
   ORDER BY 1;
   
   
(부분 ROLLUP을 사용)
  SELECT SUBSTR(CART_NO,5,2) AS 월,
         MEM_ID AS 회원번호,
         PROD_ID AS 상품코드,
         SUM(CART_QTY) AS 판매수량합계 
    FROM CART
   GROUP BY SUBSTR(CART_NO,5,2), ROLLUP(MEM_ID, PROD_ID)
   ORDER BY 1;
   
1. CUBE
 - CUBE절에 사용된 컬럼을 조회하여 발생하는 모든 경우의 수만큼의 집계반환
 
사용형식)
  GROUP BY [컬럼명,] CUBE(컬럼명 [,...]) [,컬럼명...]
  . CUBE 절에 기술된 컬럼의 수가 n개일때 결과는 2^n가지임
  . 나머지 특징은 ROLLUP과 동일
  월 회원 상품
  월 회원
  월 상품
  회원 상품
  월
  회원
  상품
  전체집계
   
(CUBE을 사용)
  SELECT SUBSTR(CART_NO,5,2) AS 월,
         MEM_ID AS 회원번호,
         PROD_ID AS 상품코드,
         SUM(CART_QTY) AS 판매수량합계 
    FROM CART
   GROUP BY CUBE(SUBSTR(CART_NO,5,2), MEM_ID, PROD_ID)
   ORDER BY 1;
   
   
(부분 CUBE을 사용)
  SELECT SUBSTR(CART_NO,5,2) AS 월,
         MEM_ID AS 회원번호,
         PROD_ID AS 상품코드,
         SUM(CART_QTY) AS 판매수량합계 
    FROM CART
   GROUP BY SUBSTR(CART_NO,5,2), CUBE(MEM_ID, PROD_ID)
   ORDER BY 1;