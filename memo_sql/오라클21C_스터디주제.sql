
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
       json_value(ORDER_DETAILS, '$.items.size()') AS "�ֹ��� �� ��ǰ ����", 
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
SELECT o.CUSTOMER_ID, SUM(jt.qty*jt.price)
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
GROUP BY  o.CUSTOMER_ID   

SELECT 
  CUSTOMER_ID,
  SUM(JSON_VALUE(ORDER_DETAILS, '$.total_amount')) AS total_spent
FROM ORDERS
GROUP BY CUSTOMER_ID;



--����Ŭ ����Ȯ��
SELECT * FROM V$VERSION;



CREATE BLOCKCHAIN TABLE AUDIT_LOG (
    LOG_ID RAW(16) DEFAULT SYS_GUID() NOT NULL,
    EVENT_TYPE VARCHAR2(50) NOT NULL,
    EVENT_DETAILS VARCHAR2(200),
    EVENT_TIMESTAMP TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    ACTOR_USER VARCHAR2(50) NOT NULL
) NO DROP UNTIL 0 DAYS NO DELETE UNTIL 0 DAYS;



INSERT INTO AUDIT_LOG (EVENT_TYPE, EVENT_DETAILS, ACTOR_USER) VALUES ('Login Success', 'User session started', 'admin');
INSERT INTO AUDIT_LOG (EVENT_TYPE, EVENT_DETAILS, ACTOR_USER) VALUES ('Data Update', 'Updated customer record 105', 'user_a');
INSERT INTO AUDIT_LOG (EVENT_TYPE, EVENT_DETAILS, ACTOR_USER) VALUES ('Login Failed', 'Invalid password attempt', 'hacker');
COMMIT;


--���̺� ���� �� ������ ����
CREATE TABLE product_catalog (
    product_id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    product_info CLOB, -- JSON �����͸� ������ �÷�
    CONSTRAINT pk_product_catalog PRIMARY KEY (product_id),
    CONSTRAINT chk_product_info_json CHECK (product_info IS JSON) -- JSON ���� ���� ���� ����
);

-- JSON �˻� �ε��� ���� (���� ����ȭ)
CREATE SEARCH INDEX product_info_sidx ON product_catalog (product_info) FOR JSON;


INSERT INTO product_catalog (product_info) VALUES (
    '{"name": "Laptop Pro", "category": "Electronics", "price": 1200.00, "features": ["16GB RAM", "512GB SSD", "Intel i7"], "reviews": [{"user": "Alice", "rating": 5, "comment": "Excellent performance"}, {"user": "Bob", "rating": 4, "comment": "Good value for money"}]}'
);

INSERT INTO product_catalog (product_info) VALUES (
    '{"name": "Wireless Mouse", "category": "Accessories", "price": 25.50, "features": ["Ergonomic design", "Bluetooth"], "reviews": [{"user": "Charlie", "rating": 5, "comment": "Very comfortable"}, {"user": "David", "rating": 3, "comment": "Sometimes disconnects"}]}'
);

INSERT INTO product_catalog (product_info) VALUES (
    '{"name": "Mechanical Keyboard", "category": "Accessories", "price": 99.99, "features": ["RGB Backlight", "Tactile switches"], "reviews": [{"user": "Eve", "rating": 4, "comment": "Great for typing"}, {"user": "Frank", "rating": 5, "comment": "Awesome for gaming"}]}'
);

INSERT INTO product_catalog (product_info) VALUES (
    '{"name": "Smartphone XYZ", "category": "Electronics", "price": 850.00, "features": ["AMOLED Display", "Dual Camera", "Fast Charging"], "reviews": [{"user": "Grace", "rating": 5, "comment": "Fantastic phone"}, {"user": "Henry", "rating": 4, "comment": "Battery life could be better"}]}'
);

-- 1-1. ��� ��ǰ�� **�̸�(name)**�� **����(price)**�� ��ȸ�Ͻÿ�.
SELECT  json_value(product_info, '$.name'),
        json_value(product_info, '$.price')
FROM    PRODUCT_CATALOG;


-- 1-2. ī�װ��� 'Electronics'�� ��ǰ�� �̸��� ��ȸ�Ͻÿ�.
SELECT  json_value(product_info, '$.name')
FROM    PRODUCT_CATALOG
WHERE   json_value(product_info, '$.category') = 'Electronics';

-- 1-3. '16GB RAM' ����� �����ϴ� ��ǰ�� �̸��� ������ ��ȸ�Ͻÿ�. (JSON �迭 ���� �˻�)
SELECT json_value(product_info, '$.name'),
        json_value(product_info, '$.price')
FROM    PRODUCT_CATALOG
WHERE   json_exists(product_info, '$?(@.features like "%16GB RAM%")')
;
-- 1-4. �� ��ǰ�� ���� �� ����(rating)�� 4�� �̻��� **���� �����(user)**�� �ش� **���� �ڸ�Ʈ(comment)**�� ��ǰ���� ��ȸ�Ͻÿ�. (SQL/JSON �Լ� JSON_TABLE Ȱ��)
SELECT  jt."USER", jt."COMMENT"
FROM    PRODUCT_CATALOG c,
        json_table(
            c.product_info,
            '$.reviews[*]'
            COLUMNS(
            "USER" VARCHAR2(100) PATH '$.user',
            "COMMENT" VARCHAR2(100) PATH '$.comment',
            "RATING" NUMBER PATH '$.rating'
            )
        ) jt
WHERE jt."RATING">=4;   
        
SELECT  json_value(product_info, '$.reviews[0].user'),
        json_value(product_info, '$.reviews[0].comment')
FROM    PRODUCT_CATALOG

SELECT product_info FROM product_catalog;

-- 1-5. ���� ��� ��ǰ�� �̸��� ��ȸ�Ͻÿ�.
SELECT  json_value(product_info, '$.name')
FROM    PRODUCT_CATALOG
ORDER BY TO_NUMBER(json_value(product_info, '$.price')) desc
FETCH FIRST 1 ROWS ONLY



--���̺� ���� �� ������ ����
CREATE TABLE sales_transactions (
    transaction_id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    product_category VARCHAR2(100) NOT NULL,
    item_name VARCHAR2(100) NOT NULL,
    transaction_date DATE NOT NULL,
    quantity NUMBER NOT NULL,
    unit_price NUMBER(10, 2) NOT NULL,
    region VARCHAR2(50),
    CONSTRAINT pk_sales_transactions PRIMARY KEY (transaction_id)
);

INSERT INTO sales_transactions (product_category, item_name, transaction_date, quantity, unit_price, region) VALUES ('Electronics', 'Laptop A', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 1, 1500.00, 'Seoul');
INSERT INTO sales_transactions (product_category, item_name, transaction_date, quantity, unit_price, region) VALUES ('Electronics', 'Mouse B', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 3, 25.00, 'Seoul');
INSERT INTO sales_transactions (product_category, item_name, transaction_date, quantity, unit_price, region) VALUES ('Apparel', 'T-Shirt C', TO_DATE('2024-05-02', 'YYYY-MM-DD'), 5, 15.00, 'Busan');
INSERT INTO sales_transactions (product_category, item_name, transaction_date, quantity, unit_price, region) VALUES ('Electronics', 'Keyboard D', TO_DATE('2024-05-03', 'YYYY-MM-DD'), 2, 80.00, 'Seoul');
INSERT INTO sales_transactions (product_category, item_name, transaction_date, quantity, unit_price, region) VALUES ('Apparel', 'Jeans E', TO_DATE('2024-05-03', 'YYYY-MM-DD'), 1, 60.00, 'Busan');
INSERT INTO sales_transactions (product_category, item_name, transaction_date, quantity, unit_price, region) VALUES ('Books', 'Novel F', TO_DATE('2024-05-04', 'YYYY-MM-DD'), 2, 20.00, 'Jeju');
INSERT INTO sales_transactions (product_category, item_name, transaction_date, quantity, unit_price, region) VALUES ('Electronics', 'Laptop A', TO_DATE('2024-05-05', 'YYYY-MM-DD'), 1, 1500.00, 'Busan');



-- 2-1. Ư�� ��¥ ����(start_date, end_date) ���� �� �Ǹž��� ����ϴ� SQL ��ũ�� �Լ��� �ۼ��ϰ� ����Ͻÿ�. �� ��ũ�δ� �Է¹��� ��¥ ������ ���� �������� WHERE ���� �����Ǿ�� �մϴ�.
--��Ʈ: DBMS_MACRO.CREATE_MACRO_FUNCTION�� ����Ͽ� ��ũ�θ� �����ϰ�, SQL_MACRO Ű���带 ����մϴ�.

-- 2-2. Ư�� product_category�� ��� �Ǹ� �ܰ��� ����ϴ� SQL ��ũ�� �Լ��� �ۼ��ϰ� ����Ͻÿ�. �� ��ũ�δ� product_category ���ڸ� �޾� �ش� ī�װ��� �����͸� ���͸��ؾ� �մϴ�.

-- 2-3. �Ǹŵ� **�� ����(quantity)**�� **�� �Ǹ� �ݾ�(quantity * unit_price)**�� ��ȯ�ϴ� SQL ��ũ�� �Լ��� �ۼ��Ͻÿ�. (���̺� ��ü �Ǵ� Ư�� ������ ���͸��Ͽ� ���� �����ϰ�)


--���̺� ���� �� ������ ����(���� ����)
-- HASHING USING ���� Oracle 23c���� ���Ե� ��� ���� �� ������ 21����

-- ���ü�� ���̺� ���� (Drop �� Insert �ɼ� ����)
CREATE BLOCKCHAIN TABLE sensor_readings (
    reading_id NUMBER GENERATED ALWAYS AS IDENTITY,
    sensor_name VARCHAR2(100) NOT NULL,
    reading_value NUMBER NOT NULL,
    reading_timestamp TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    location VARCHAR2(100)
) NO DROP UNTIL 7 DAYS AFTER INSERT -- ���� �� 7���� ������ DROP ����
    NO DELETE UNTIL 7 DAYS AFTER INSERT -- ���� �� 7���� ������ DELETE ����
    HASHING USING "SHA2_256" VERSION "V1"; -- �ؽ� �˰��� ����


INSERT INTO sensor_readings (sensor_name, reading_value, reading_timestamp, location) VALUES ('Temperature_Sensor_1', 25.5, SYSTIMESTAMP, 'Warehouse_A');
INSERT INTO sensor_readings (sensor_name, reading_value, reading_timestamp, location) VALUES ('Humidity_Sensor_2', 60.2, SYSTIMESTAMP, 'Server_Room_B');
INSERT INTO sensor_readings (sensor_name, reading_value, reading_timestamp, location) VALUES ('Pressure_Sensor_3', 101.3, SYSTIMESTAMP, 'Factory_Floor_C');
INSERT INTO sensor_readings (sensor_name, reading_value, reading_timestamp, location) VALUES ('Temperature_Sensor_1', 26.1, SYSTIMESTAMP, 'Warehouse_A');
INSERT INTO sensor_readings (sensor_name, reading_value, reading_timestamp, location) VALUES ('Humidity_Sensor_2', 61.5, SYSTIMESTAMP, 'Server_Room_B');


-----------------------------------------------------------




