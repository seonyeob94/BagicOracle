2025-0217-01) NULL 함수
1. IS NULL, IS NOT NULL
 - NULL을 비교하는 연산자('='으로는 NULL여부 판단 불가
 
2. NVL(co1, value)
 - co1 값이 NULL이면 value를 출력하고 NULL이 아니면 col값을 출력
 - co1과 value는 같은 타입이어야 함
사용예) 상품테이블에서 크기정보(prod_size)를 조회하되
       그 값이 NULL이면 "크기정보없음"을 출력하시오
  SELECT PROD_ID AS 상품번호,
         PROD_NAME AS 상품명,
         NVL(PROD_SIZE, '크기정보없음') AS 크기
    FROM PROD;
    
사용예)2020년 7월 모든 상품별 판매수량,판매금액을 조회
     (상품번호,상품명,판매수량,판매금액)
  SELECT B.PROD_ID AS 상품번호,
         B.PROD_NAME AS 상품명,
         NVL(SUM(A.CART_QTY),0) AS 판매수량,
         NVL(SUM(A.CART_QTY*B.PROD_PRICE),0) AS 판매금액
    FROM CART A
   RIGHT OUTER JOIN PROD B ON(A.PROD_ID=B.PROD_ID AND
         A.CART_NO LIKE '202007%')
   GROUP BY B.PROD_ID, B.PROD_NAME 
   ORDER BY 1;
-- 코드를 그룹화 한 시점에서 이름을 따로 그룹할 필요는 없지만 규칙이기에 그룹화한다   
   
사용예) 사원테이블에서 영업실적코드에 따른 보너스를 계산하고 지급액을 조회하시오
      보너스= 영업실적코드* 기본급*50%
      지급액= 기본급+보너스. 단 영업실적코드가 NULL이면 0으로 계산할 것
  SELECT EMPLOYEE_ID AS 사원번호,
         EMP_NAME AS 사원명,
         NVL(COMMISSION_PCT,0) AS 영업실적,
         SALARY AS 기본급,
         ROUND(SALARY*NVL(COMMISSION_PCT,0)*0.5) AS 보너스,
         ROUND(SALARY*NVL(COMMISSION_PCT,0)*0.5)+SALARY AS 지급액  
    FROM C##HR.EMPLOYEES;
    
2. NVL2(co2, value1, value2)
 - co1값이 NULL이면 value2를 NULL이 아니면 value1을 반환
 - value1, value2는 같은 자료타입 이어야 함

사용예) 2020년 6월 모든 회원별 구매금액을 조회하되 구매정보가 없으면 '미구매'를,
      구매정보가 있으면 구매금액을 출력하시오
  SELECT A.MEM_ID AS 회원번호,
         A.MEM_NAME AS 회원명,
         NVL(TO_CHAR(SUM(B.CART_QTY*C.PROD_PRICE)),'미구매') AS 구매금액합계
    FROM MEMBER A-- FROM쪽에 많은 정보가 있으면 LEFT 아니면 RIGHT
    LEFT OUTER JOIN CART B ON(A.MEM_ID=B.MEM_ID)
    LEFT OUTER JOIN PROD C ON(B.PROD_ID=C.PROD_ID AND B.CART_NO LIKE '202006%')
   GROUP BY A.MEM_ID,A.MEM_NAME
   ORDER BY 1;
    
  SELECT A.MEM_ID AS 회원번호,
         A.MEM_NAME AS 회원명,
         NVL(TO_CHAR(SUM(B.CART_QTY*C.PROD_PRICE),'9,999,999'),
            LPAD('미구매',11)) AS 구매금액합계
    FROM MEMBER A-- FROM쪽에 많은 정보가 있으면 LEFT 아니면 RIGHT
    LEFT OUTER JOIN CART B ON(A.MEM_ID=B.MEM_ID)
    LEFT OUTER JOIN PROD C ON(B.PROD_ID=C.PROD_ID AND B.CART_NO LIKE '202006%')
   GROUP BY A.MEM_ID,A.MEM_NAME
   ORDER BY 1;
--NVL2   
사용예)상품테이블에서 색상정보(PROD_COLOR)를 조회하여 색상정보가 있으면 
     '유 색상제품', 없으면 '색상 없음'을 비교난에 출력하시오
     Alias는 상품번호,상품명,색상,비고
  SELECT PROD_ID AS 상품번호,
         PROD_ID AS 상품명,
         PROD_COLOR AS 색상,
         NVL2(PROD_COLOR,'유 색상제품','색상 없음') AS 비고
    FROM PROD;
    
** 상품테이블에서 분류코드 'F301' 상품들의 판매가를 매입가로 변경하시오  
  UPDATE PROD
     SET PROD_PRICE=PROD_COST
   WHERE LPROD_GU='P301';  
   
   COMMIT;
--NULIF  
사용예)상품테이블에서 판매가와 매입가가 동일하면 '단종예정상품'을
     다르면 판매가를 출력하시오
     Alias는 상품코드,상품명,매입가,판매가
  SELECT PROD_ID AS 상품코드,
         PROD_NAME AS 상품명,
         PROD_COST AS 매입가,
         NVL(TO_CHAR(NULLIF(PROD_PRICE,PROD_COST),'9,999,999'),
             '단종예정상품') AS 판매가
    FROM PROD;