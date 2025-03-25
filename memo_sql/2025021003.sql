2025-0210-03)SELECT 문

사용예) 쇼핑물 데이터베이스의 분류테이블(LPRD)의 모든 자료를 검색하시오
  SELECT *
    FROM C##sy94.LPROD;
    
  SELECT LPROD_ID AS 순번,
         LPROD_GU AS 분류코드,
         LPROD_NAME AS 분류명
    FROM C##sy94.LPROD;   
    
 CREATE SYNONYM LPROD FOR C##sy94.LPROD;
 CREATE SYNONYM PROD FOR C##sy94.PROD;
 CREATE SYNONYM CART FOR C##sy94.CART;
 CREATE SYNONYM MEMBER FOR C##sy94.MEMBER;
 CREATE SYNONYM BUYER FOR C##sy94.BUYER;
 CREATE SYNONYM BUYPROD FOR C##sy94.BUYPROD;

사용예) HR계정의 부서테이블(DEPARTMENTS)의 모든 자료를 조회하시오

 CREATE SYNONYM DEPARTMENTS FOR C##HR.DEPARTMENTS;
 
 SELECT *
   FROM DEPARTMENTS;
 
사용예) 쇼핑물 데이터베이스의 고객 테이블(MEMBER)의 모든 고객정보를 조회하시오

 SELECT *
   FROM MEMBER;
사용예) 쇼핑물 데이터베이스의 상품테이블(PROD)에 사용된 분류코드를 중복없이 
       조회하시오 --중복을 배제하기 위해 DISTINCT 사용
  SELECT DISTINCT LPROD_GU AS 분류코드
    FROM PROD;

사용예) 쇼핑물 데이터베이스의 회원테이블(MEMBER)에서 여성회원의
       회원번호, 회원명, 주소, 마일리지를 조회하되 마일리지가 많은 회원부터
       출력하시오
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_ADD1||' '||MEM_ADD2 AS 주소,
         MEM_MILEAGE AS 마일리지
    FROM MEMBER
   WHERE SUBSTR(MEM_REGNO2,1,1) IN('2','4') --여성자료
--  ORDER BY MEM_MILEAGE DESC;
--  ORDER BY 4 DESC;
   ORDER BY 마일리지 DESC;