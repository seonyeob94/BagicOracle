CREATE TABLE "orders" (
	"order_num"	char(12)		NOT NULL,
	"cust_id"	number(4)		NOT NULL,
	"order_amt"	NUMBER(8)		NULL
);

CREATE TABLE "goods" (
	"gid"	char(4)		NOT NULL,
	"g_name"	varchar2(50)		NULL,
	"g_price"	number(6)		NULL
);

CREATE TABLE "customers" (
	"cust_id"	number(4)		NOT NULL,
	"cust_name"	varchar2(30)		NULL,
	"cust_addr"	varchar2(250)		NULL
);

CREATE TABLE "order_goods" (
	"gid"	char(4)		NOT NULL,
	"order_num"	char(12)		NOT NULL,
	"order_qty"	number(3)		NULL
);

ALTER TABLE "orders" ADD CONSTRAINT "PK_ORDERS" PRIMARY KEY (
	"order_num"
);

ALTER TABLE "goods" ADD CONSTRAINT "PK_GOODS" PRIMARY KEY (
	"gid"
);

ALTER TABLE "customers" ADD CONSTRAINT "PK_CUSTOMERS" PRIMARY KEY (
	"cust_id"
);

ALTER TABLE "order_goods" ADD CONSTRAINT "PK_ORDER_GOODS" PRIMARY KEY (
	"gid",
	"order_num"
);

ALTER TABLE "order_goods" ADD CONSTRAINT "FK_goods_TO_order_goods_1" FOREIGN KEY (
	"gid"
)
REFERENCES "goods" (
	"gid"
);

ALTER TABLE "order_goods" ADD CONSTRAINT "FK_orders_TO_order_goods_1" FOREIGN KEY (
	"order_num"
)
REFERENCES "orders" (
	"order_num"
);

