
--테이블 생성 및 데이터 삽입
CREATE TABLE ORDERS (
    ORDER_ID NUMBER PRIMARY KEY,
    CUSTOMER_ID NUMBER,
    ORDER_DATE DATE,
    ORDER_DETAILS JSON -- 주문 상세 정보를 JSON 형태로 저장
);

INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, ORDER_DATE, ORDER_DETAILS) VALUES (101, 1, DATE '2025-01-15', '{"items": [{"product_name": "Laptop", "qty": 1, "price": 1200}, {"product_name": "Mouse", "qty": 1, "price": 25}], "shipping_address": {"street": "123 Main St", "city": "Seoul","zip": "03100"}, "total_amount": 1225}');
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, ORDER_DATE, ORDER_DETAILS) VALUES (102, 2, DATE '2025-02-20', '{"items": [{"product_name": "Keyboard", "qty": 1, "price": 75}, {"product_name": "Monitor", "qty": 2, "price": 300}], "shipping_address": {"street": "456 Park Ave", "city": "Busan", "zip": "48000"}, "total_amount": 675}');
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, ORDER_DATE, ORDER_DETAILS) VALUES (103, 1, DATE '2025-03-10', '{"items": [{"product_name": "Webcam", "qty": 1, "price": 50}], "shipping_address": {"street": "123 Main St", "city": "Seoul", "zip": "03100"}, "total_amount": 50}');
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, ORDER_DATE, ORDER_DETAILS) VALUES (104, 3, DATE '2025-04-05', '{"items": [{"product_name": "Headphones", "qty": 1, "price": 150}, {"product_name": "Microphone", "qty": 1, "price": 80}], "shipping_address": {"street": "789 River Rd", "city": "Daegu", "zip": "41900"}, "total_amount": 230}');
COMMIT;

--1. 모든 주문의 ORDER_ID와 ORDER_DETAILS 전체를 조회하세요.
SELECT ORDER_ID, ORDER_DETAILS
FROM ORDERS

SELECT ORDER_ID, 
json_query(ORDER_DETAILS,'$')
FROM ORDERS


--2. ORDER_ID가 101인 주문의 배송지 city를 조회하세요.
SELECT
  json_value(ORDER_DETAILS, '$.shipping_address.city') as city
FROM ORDERS
WHERE ORDER_ID=101

--json_value() : 배열안의 단일 키 추출
--json_query() : 배열안의 객체/배열 그대로 추출
--$.shipping_address : shipping_address 키

--3. 모든 주문에 대해 ORDER_ID, 주문의 총 상품 개수(items 배열의 길이), 그리고 total_amount를 조회하세요.
SELECT o.ORDER_ID, 
       (
       SELECT COUNT(*)
       FROM json_table(
       o.ORDER_DETAILS,
       '$.items[*]'
       COLUMNS(
        idx FOR ORDINALITY
       )
       )
       ) AS "주문의 총 상품 개수", 
       json_value(o.ORDER_DETAILS, '$.total_amount')
FROM ORDERS o

--json_table(...) : items 배열 전체 요소를 펼침
--$.items[*] item안의 배열 전체 요소를 대상으로 함
--FOR ORDINALITY: 각 요소에 1, 2, 3 번호 붙임
--COLUMNS () : json_table 에서 테이블의 컬럼으로 만들것인지 정의 여기서는 


--비고 .size() : JSON Path 안에서 사용하는 size() 내장 함수
SELECT ORDER_ID, 
       json_value(ORDER_DETAILS, '$.items.size()'), 
       json_value(ORDER_DETAILS, '$.total_amount')
FROM ORDERS 


--4. 주문 상품 중 'Laptop'이 포함된 모든 주문의 ORDER_ID와 CUSTOMER_ID를 조회하세요.
SELECT ORDER_ID, CUSTOMER_ID
FROM ORDERS
WHERE json_exists(ORDER_DETAILS, '$.items[*]?(@.product_name like "%Laptop%")')

--json_exists() : 배열 안에 특정 값이 존재하는지 파악
--items[*] : item안의 배열 전체 요소
--?() : 필터 조건
--@.product_name : 객체안의 특정필드(product_name) 접근


--5. ORDER_DETAILS의 items 배열 내 각 상품의 product_name, qty, price를 개별 컬럼으로 분리하여 조회하고, 해당 주문의 ORDER_ID도 함께 출력하세요. (힌트: JSON_TABLE)
SELECT o.ORDER_ID, jt.product_name, jt.qty, jt.price
FROM ORDERS O,
    json_table(
      o.ORDER_DETAILS,
      '$.items[*]'
      COLUMNS(
      product_name VARCHAR2(100) PATH '$.product_name',
      qty NUMBER PATH '$.qty',
      price NUMBER PATH '$.price'
      )
    ) jt

--비고 items의 첫번째 배열만 추출
SELECT o.ORDER_ID, 
       json_value(o.ORDER_DETAILS, '$.items[0].product_name') AS first_product,
       json_value(o.ORDER_DETAILS, '$.items[0].qty') AS qty,
       json_value(o.ORDER_DETAILS, '$.items[0].price') AS price
FROM ORDERS o;

--6. 각 고객(CUSTOMER_ID)별로 주문한 상품들의 총 금액을 합산하여 조회하세요.
SELECT o.ORDER_ID, SUM(jt.qty*jt.price)
FROM ORDERS O,
    json_table(
      o.ORDER_DETAILS,
      '$.items[*]'
      COLUMNS(
      product_name VARCHAR2(100) PATH '$.product_name',
      qty NUMBER PATH '$.qty',
      price NUMBER PATH '$.price'
      )
    ) jt
GROUP BY  o.ORDER_ID   




--오라클 버전확인
SELECT * FROM V$VERSION;












