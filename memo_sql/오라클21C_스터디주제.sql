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


--��� .size()
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














CREATE BLOCKCHAIN TABLE AUDIT_LOG (
    LOG_ID RAW(16) DEFAULT SYS_GUID() NOT NULL,
    EVENT_TYPE VARCHAR2(50) NOT NULL,
    EVENT_DETAILS VARCHAR2(200),
    EVENT_TIMESTAMP TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    ACTOR_USER VARCHAR2(50) NOT NULL
    ) NO DROP UNTIL 0 DAYS NO DELETE UNTIL 0 DAYS;


CREATE BLOCKCHAIN TABLE AUDIT_LOG (
  LOG_ID RAW(16) DEFAULT SYS_GUID() NOT NULL,
  EVENT_TYPE VARCHAR2(50) NOT NULL,
  EVENT_DETAILS VARCHAR2(200),
  EVENT_TIMESTAMP TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
  ACTOR_USER VARCHAR2(50) NOT NULL
)
NO DROP UNTIL 0 DAYS 
NO DELETE UNTIL 0 DAYS
SEGMENT CREATION IMMEDIATE;











