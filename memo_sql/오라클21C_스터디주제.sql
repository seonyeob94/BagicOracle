
--���̺� ���� �� ������ ����
CREATE TABLE ORDERS (
    ORDER_ID NUMBER PRIMARY KEY,
    CUSTOMER_ID NUMBER,
    ORDER_DATE DATE,
    ORDER_DETAILS JSON -- �ֹ� �� ������ JSON ���·� ����
);

INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, ORDER_DATE, ORDER_DETAILS) VALUES (101, 1, DATE '2025-01-15', '{"items": [{"product_name": "Laptop", "qty": 1, "price": 1200}, {"product_name": "Mouse", "qty": 1, "price": 25}], "shipping_address": {"street": "123 Main St", "city": "Seoul","zip": "03100"}, "total_amount": 1225}');
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, ORDER_DATE, ORDER_DETAILS) VALUES (102, 2, DATE '2025-02-20', '{"items": [{"product_name": "Keyboard", "qty": 1, "price": 75}, {"product_name": "Monitor", "qty": 2, "price": 300}], "shipping_address": {"street": "456 Park Ave", "city": "Busan", "zip": "48000"}, "total_amount": 675}');
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, ORDER_DATE, ORDER_DETAILS) VALUES (103, 1, DATE '2025-03-10', '{"items": [{"product_name": "Webcam", "qty": 1, "price": 50}], "shipping_address": {"street": "123 Main St", "city": "Seoul", "zip": "03100"}, "total_amount": 50}');
INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, ORDER_DATE, ORDER_DETAILS) VALUES (104, 3, DATE '2025-04-05', '{"items": [{"product_name": "Headphones", "qty": 1, "price": 150}, {"product_name": "Microphone", "qty": 1, "price": 80}], "shipping_address": {"street": "789 River Rd", "city": "Daegu", "zip": "41900"}, "total_amount": 230}');
COMMIT;

--1. ��� �ֹ��� ORDER_ID�� ORDER_DETAILS ��ü�� ��ȸ�ϼ���.
SELECT ORDER_ID, ORDER_DETAILS
FROM ORDERS

SELECT ORDER_ID, 
json_query(ORDER_DETAILS,'$')
FROM ORDERS


--2. ORDER_ID�� 101�� �ֹ��� ����� city�� ��ȸ�ϼ���.
SELECT
  json_value(ORDER_DETAILS, '$.shipping_address.city') as city
FROM ORDERS
WHERE ORDER_ID=101

--json_value() : �迭���� ���� Ű ����
--json_query() : �迭���� ��ü/�迭 �״�� ����
--$.shipping_address : shipping_address Ű

--3. ��� �ֹ��� ���� ORDER_ID, �ֹ��� �� ��ǰ ����(items �迭�� ����), �׸��� total_amount�� ��ȸ�ϼ���.
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
       ) AS "�ֹ��� �� ��ǰ ����", 
       json_value(o.ORDER_DETAILS, '$.total_amount')
FROM ORDERS o

--json_table(...) : items �迭 ��ü ��Ҹ� ��ħ
--$.items[*] item���� �迭 ��ü ��Ҹ� ������� ��
--FOR ORDINALITY: �� ��ҿ� 1, 2, 3 ��ȣ ����
--COLUMNS () : json_table ���� ���̺��� �÷����� ��������� ���� ���⼭�� 


--��� .size() : JSON Path �ȿ��� ����ϴ� size() ���� �Լ�
SELECT ORDER_ID, 
       json_value(ORDER_DETAILS, '$.items.size()'), 
       json_value(ORDER_DETAILS, '$.total_amount')
FROM ORDERS 


--4. �ֹ� ��ǰ �� 'Laptop'�� ���Ե� ��� �ֹ��� ORDER_ID�� CUSTOMER_ID�� ��ȸ�ϼ���.
SELECT ORDER_ID, CUSTOMER_ID
FROM ORDERS
WHERE json_exists(ORDER_DETAILS, '$.items[*]?(@.product_name like "%Laptop%")')

--json_exists() : �迭 �ȿ� Ư�� ���� �����ϴ��� �ľ�
--items[*] : item���� �迭 ��ü ���
--?() : ���� ����
--@.product_name : ��ü���� Ư���ʵ�(product_name) ����


--5. ORDER_DETAILS�� items �迭 �� �� ��ǰ�� product_name, qty, price�� ���� �÷����� �и��Ͽ� ��ȸ�ϰ�, �ش� �ֹ��� ORDER_ID�� �Բ� ����ϼ���. (��Ʈ: JSON_TABLE)
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

--��� items�� ù��° �迭�� ����
SELECT o.ORDER_ID, 
       json_value(o.ORDER_DETAILS, '$.items[0].product_name') AS first_product,
       json_value(o.ORDER_DETAILS, '$.items[0].qty') AS qty,
       json_value(o.ORDER_DETAILS, '$.items[0].price') AS price
FROM ORDERS o;

--6. �� ��(CUSTOMER_ID)���� �ֹ��� ��ǰ���� �� �ݾ��� �ջ��Ͽ� ��ȸ�ϼ���.
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




--����Ŭ ����Ȯ��
SELECT * FROM V$VERSION;












