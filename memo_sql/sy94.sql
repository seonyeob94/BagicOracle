
--SET TERMOUT OFF
SET ECHO OFF


DROP TABLE cart;
DROP TABLE member;
DROP TABLE buyprod;
DROP TABLE prod;
DROP TABLE buyer;
DROP TABLE lprod;


-- ��ü�̸� 30�� �̳�, ������ ���ĺ�����, ���ĺ�, ����, _,$ 
-- ��ü�̸��� ������ �빮�ڷ� �����. 
CREATE TABLE lprod
(
  lprod_id  NUMBER(7)   NOT NULL,
  lprod_gu  CHAR(4)     NOT NULL,
  lprod_nm  VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_lprod PRIMARY KEY (lprod_gu)
);


INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(1,'P101','��ǻ����ǰ');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(2,'P102','������ǰ');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(3,'P201','����ĳ�־�');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(4,'P202','����ĳ�־�');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(5,'P301','������ȭ');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(6,'P302','ȭ��ǰ');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(7,'P401','����/CD');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(8,'P402','����');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(9,'P403','������');



-- DROP TABLE buyer
 
CREATE TABLE buyer
(  buyer_id           CHAR(6)       NOT NULL,   --�ŷ�ó�ڵ� 
   buyer_name         VARCHAR2(50)  NOT NULL,   --�ŷ�ó��
   buyer_lgu          CHAR(4)       NOT NULL,   --��޻�ǰ��з�
   buyer_bank         VARCHAR2(40),            --����
   buyer_bankno       VARCHAR2(40),             --���¹�ȣ
   buyer_bankname     VARCHAR2(15),             --������
   buyer_zip          CHAR(7),                  --�����ȣ
   buyer_add1         VARCHAR2(100),             --�ּ�1
   buyer_add2         VARCHAR2(80),             --�ּ�2
   buyer_comtel       VARCHAR2(14)  NOT NULL,   --��ȭ��ȣ 
   buyer_fax          VARCHAR2(20)  NOT NULL    --fax��ȣ 
);

 ALTER TABLE buyer add ( buyer_mail VARCHAR2(40) NOT NULL,
                         buyer_charger VARCHAR2(10),
                              buyer_telext VARCHAR2(2));

f
 ALTER TABLE buyer
   modify( buyer_name VARCHAR2(40));
 
 ALTER TABLE buyer
   add ( CONSTRAINT pk_buyer PRIMARY KEY(buyer_id),
           CONSTRAINT fr_buyer_lgu  foreign key(buyer_lgu) 
                               references lprod(lprod_gu) ); 

 
--INSERT INTO buyer (buyer_id, buyer_name, buyer_lgu, buyer_bank, 
--                   buyer_bankno, buyer_bankname, buyer_zip,
--                   buyer_add1, buyer_add2, buyer_comtel, buyer_fax,
--                   buyer_mail, buyer_charger)


INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P10101','�Ｚ��ǻ��','P101','��������','123-456-7890','�̰ǻ�','135-972','���� ������ ����2���������21','1125ȣ','02-522-7890','02-522-7891','samcom@samsung.co.kr','�۵���');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)  
  VALUES ('P10102','�ﺸ��ǻ��','P101','��������','732-702-195670','������','142-726','���� ���ϱ� �̾�6�� ��������','2712ȣ','02-632-5690','02-632-5699','sambo@sambo.co.kr','�輭��');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P10103','������ǻ��','P101','��������','112-650-397811','������','404-260','��õ ���� ������','157-899����','032-233-7832','032-233-7833','hyunju@hyunju.com','������') ;
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P10201','�������','P102','����','222-333-567890','�����','702-864','�뱸 �ϱ� ������','232����','053-780-2356','053-780-2357','daewoo@daewoo.co.kr','�����') ;
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P10202','�Ｚ����','P102','��ȯ����','989-323-567898','�ڻＺ','614-728','�λ� �λ����� ����1�� ���ƺ���','1708ȣ','051-567-5312','051-567-5313','samsung@samsung.com','���ο�');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger) 
  VALUES ('P20101','����','P201','��������','688-323-567898','�Ŵ���','306-785','���� ����� ������ ��Ϻ���','508ȣ','042-332-5123','042-332-5125','daehyun@daehyun.com','���뿵');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger) 
  VALUES ('P20102','������','P201','��������','123-777-7890','�̸���','135-972','���� ������ ����2�� �������21','1211ȣ','02-533-7890','02-533-5699','mar@marjo.co.kr','������')  ;
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P20201','LG�м�','P202','��������','732-702-556677','�����','142-726','���� ���ϱ� �̾�6�� ��������','5011ȣ','02-332-5690','02-332-5699','lgfashion.co.kr','������');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger) 
  VALUES ('P20202','ķ�긮��','P202','��������','112-888-397811','�Ⱥ�����','404-260','��õ ���� ������','535-899����','032-255-7832','032-255-7833','cambrige@cambrige.com','���ϼ�');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger) 
  VALUES ('P30101','����ġ','P301','����','211-333-511890','�輱��','702-864','�뱸 �ϱ� ������','555-66ȣ','053-535-2356','053-535-2357','gapachi@gapachi.co.kr','�̼���')  ;
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
   VALUES ('P30201','�ѱ�ȭ��ǰ','P302','��ȯ����','333-355-568898','���ѱ�','614-728','�λ� �λ����� ����1�� ���ƺ���','309ȣ','051-212-5312','051-212-5313','hangook@hangook.com','����');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P30202','�Ǹ��','P302','��������','677-888-569998','�Ż��','306-785','��������� ������ ��Ϻ���','612ȣ','042-222-5123','042-222-5125','pieoris@pieoris.com','������');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P30203','����','P302','��������','555-777-567778','������','306-785','��������� ������ ��Ϻ���','1007ȣ','042-622-5123','042-622-5125','chamjon@chamjon.com','���ֶ�');


CREATE TABLE  prod
(  prod_id             VARCHAR2(10)     NOT NULL,     -- ��ǰ�ڵ�
   prod_name           VARCHAR2(40)     NOT NULL,     -- ��ǰ��
   prod_lgu            CHAR(4 )         NOT NULL,     -- ��ǰ�з�
   prod_buyer          CHAR(6)          NOT NULL,     -- ���޾�ü(�ڵ�)
   prod_cost           NUMBER(10)       NOT NULL,     -- ���԰�
   prod_price          NUMBER(10)       NOT NULL,     -- �Һ��ڰ�
   prod_sale           NUMBER(10)       NOT NULL,     -- �ǸŰ�
   prod_outline        VARCHAR2(100)     NOT NULL,     -- ��ǰ��������
   prod_detail         CLOB,                          -- ��ǰ�󼼼���
   prod_img            VARCHAR2(40)     NOT NULL,     -- �̹���(��)
   prod_totalstock     NUMBER(10)       NOT NULL,     -- ������
   prod_insdate        DATE,                          -- �ű�����(�����)
   prod_properstock    NUMBER(10)       NOT NULL,     -- ����������
   prod_size           VARCHAR2(20),                  -- ũ��
   prod_color          VARCHAR2(20),                  -- ����
   prod_delivery       VARCHAR2(255),                 -- ���Ư�����
   prod_unit           VARCHAR2(6),                   -- ����(����)
   prod_qtyin          NUMBER(10),                    -- ���԰����
   prod_qtysale        NUMBER(10),                    -- ���Ǹż���
   prod_mileage        NUMBER(10),                    -- ���� ���ϸ��� ����
   CONSTRAINT pk_prod_id PRIMARY KEY (prod_id),
   CONSTRAINT fr_prod_lgu FOREIGN KEY (prod_lgu) REFERENCES lprod(lprod_gu),
   CONSTRAINT fr_prod_buyer FOREIGN KEY (prod_buyer) REFERENCES buyer(buyer_id)  
);

Insert into PROD values ('P101000001','����� �Ｚ����15��ġĮ��','P101','P10101',210000,290000,230000,'��������� ����',null,'P101000001.gif',0,to_date('2020/01/10','YYYY/MM/DD'),33,'15��ġ',null,'�ļ� ����','EA',0,0,null);
Insert into PROD values ('P101000002','����� �Ｚ����17��ġĮ��','P101','P10101',310000,390000,330000,'��������� ����',null,'P101000002.gif',0,to_date('2020/01/10','YYYY/MM/DD'),23,'17��ġ',null,'�ļ� ����','EA',0,0,null);
Insert into PROD values ('P101000003','����� �Ｚ����19��ġĮ��','P101','P10101',410000,490000,430000,'��������� ����',null,'P101000003.gif',0,to_date('2020/01/10','YYYY/MM/DD'),15,'19��ġ',null,'�ļ� ����','EA',0,0,null);
Insert into PROD values ('P101000004','�ﺸ��ǻ�� P-III 600Mhz','P101','P10102',1150000,1780000,1330000,'���� ���ͳ���.....',null,'P101000004.gif',0,to_date('2020/02/08','YYYY/MM/DD'),22,null,null,'�ļ� ����','EA',0,0,null);
Insert into PROD values ('P101000005','�ﺸ��ǻ�� P-III 700Mhz','P101','P10102',2150000,2780000,2330000,'���� ���ͳ���.....',null,'P101000005.gif',0,to_date('2020/02/08','YYYY/MM/DD'),31,null,null,'�ļ� ����','EA',0,0,null);
Insert into PROD values ('P101000006','�ﺸ��ǻ�� P-III 800Mhz','P101','P10102',3150000,3780000,3330000,'���� ���ͳ���.....',null,'P101000006.gif',0,to_date('2020/02/08','YYYY/MM/DD'),17,null,null,'�ļ� ����','EA',0,0,null);
Insert into PROD values ('P102000001','��� Į�� TV 25��ġ','P102','P10201',690000,820000,720000,'���ȿ� ��ȭ����.....',null,'P102000001.gif',0,to_date('2020/02/22','YYYY/MM/DD'),53,'25��ġ','���','�ļ� ����','EA',0,0,null);
Insert into PROD values ('P102000002','��� Į�� TV 29��ġ','P102','P10201',890000,1020000,920000,'���ȿ� ��ȭ����.....',null,'P102000002.gif',0,to_date('2020/02/22','YYYY/MM/DD'),21,'29��ġ','���','�ļ� ����','EA',0,0,null);
Insert into PROD values ('P102000003','�Ｚ Į�� TV 21��ġ','P102','P10202',590000,720000,620000,'���ȿ� ��ȭ����.....',null,'P102000003.gif',0,to_date('2020/01/22','YYYY/MM/DD'),11,'21��ġ','����','�ļ� ����','EA',0,0,null);
Insert into PROD values ('P102000004','�Ｚ Į�� TV 29��ġ','P102','P10202',990000,1120000,1020000,'���ȿ� ��ȭ����.....',null,'P102000004.gif',0,to_date('2020/01/22','YYYY/MM/DD'),19,'29��ġ','����','�ļ� ����','EA',0,0,null);
Insert into PROD values ('P102000005','�Ｚ Į�� TV 53��ġ','P102','P10202',1990000,2120000,2020000,'���ȿ� ��ȭ����.....',null,'P102000005.gif',0,to_date('2020/01/22','YYYY/MM/DD'),8,'53��ġ','����','�ļ� ����','EA',0,0,null);
Insert into PROD values ('P102000006','�Ｚ ķ�ڴ�','P102','P10202',660000,880000,770000,'������ ��ȭ�Կ���.....',null,'P102000006.gif',0,to_date('2020/02/23','YYYY/MM/DD'),17,null,null,'�ļ� ����','EA',0,0,null);
Insert into PROD values ('P102000007','��� VTR 6���','P102','P10201',550000,760000,610000,'������ ȭ��',null,'P102000007.gif',0,to_date('2020/01/23','YYYY/MM/DD'),36,null,null,'�ļ� ����','EA',0,0,null);
Insert into PROD values ('P201000001','���� �� ���� 1','P201','P20101',21000,42000,27000,'�ĸ��� ���� ����',null,'P201000001.gif',0,to_date('2020/01/09','YYYY/MM/DD'),9,'s','û��','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000002','���� �� ���� 2','P201','P20101',22000,43000,28000,'�ĸ��� ���� ����',null,'P201000002.gif',0,to_date('2020/01/09','YYYY/MM/DD'),9,'M','���','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000003','���� �� ���� 3','P201','P20101',23000,44000,29000,'�ĸ��� ���� ����',null,'P201000003.gif',0,to_date('2020/01/09','YYYY/MM/DD'),9,'L','����','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000004','���� ���� ���� 1','P201','P20101',12000,21000,25000,'�ÿ��� ������ ����',null,'P201000004.gif',0,to_date('2020/01/11','YYYY/MM/DD'),9,'s','û��','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000005','���� ���� ���� 2','P201','P20101',13000,22000,26000,'�ÿ��� ������ ����',null,'P201000005.gif',0,to_date('2020/01/11','YYYY/MM/DD'),9,'M','���','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000006','���� ���� ���� 3','P201','P20101',14000,23000,27000,'�ÿ��� ������ ����',null,'P201000006.gif',0,to_date('2020/01/11','YYYY/MM/DD'),9,'L','����','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000007','���� �ܿ� ���� ���� 1','P201','P20101',31000,45000,33000,'������ �ܿ��� ����',null,'P201000007.gif',0,to_date('2020/01/25','YYYY/MM/DD'),9,'s','û��','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000008','���� �ܿ� ���� ���� 2','P201','P20101',32000,46000,34000,'������ �ܿ��� ����',null,'P201000008.gif',0,to_date('2020/01/25','YYYY/MM/DD'),9,'M','���','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000009','���� �ܿ� ���� ���� 3','P201','P20101',33000,47000,35000,'������ �ܿ��� ����',null,'P201000009.gif',0,to_date('2020/01/25','YYYY/MM/DD'),9,'L','����','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000010','���� û���� 1','P201','P20102',55000,66000,57000,'���� Ȱ���ĸ� ����',null,'P201000010.gif',0,to_date('2020/01/31','YYYY/MM/DD'),38,'30',null,'��Ź ����','EA',0,0,null);
INSERT INTO prod values ('P201000011','���� û���� 2','P201','P20102',56000,67000,58000,'���� Ȱ���ĸ� ����',null,'P201000011.gif',0,to_date('2020/01/31','YYYY/MM/DD'),35,'32','','��Ź ����','EA',0,0,null) ;
Insert into PROD values ('P201000012','���� û���� 3','P201','P20102',57000,68000,59000,'���� Ȱ���ĸ� ����',null,'P201000012.gif',0,to_date('2020/01/31','YYYY/MM/DD'),33,'34',null,'��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000013','���� �� ���� 1','P201','P20101',110000,210000,170000,'���� Ȱ������ ���� ����',null,'P201000013.gif',0,to_date('2020/02/18','YYYY/MM/DD'),16,'66','û��','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000014','���� �� ���� 2','P201','P20101',120000,220000,180000,'���� Ȱ������ ���� ����',null,'P201000014.gif',0,to_date('2020/02/18','YYYY/MM/DD'),18,'77','���','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000015','���� �� ���� 3','P201','P20101',130000,230000,190000,'���� Ȱ������ ���� ����',null,'P201000015.gif',0,to_date('2020/02/18','YYYY/MM/DD'),17,'88','����','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000016','���� ���� ���� 1','P201','P20102',100000,160000,130000,'���� Ȱ������ ������ ����',null,'P201000016.gif',0,to_date('2020/02/21','YYYY/MM/DD'),12,'66','û��','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000017','���� ���� ���� 2','P201','P20102',110000,170000,140000,'���� Ȱ������ ������ ����',null,'P201000017.gif',0,to_date('2020/02/21','YYYY/MM/DD'),21,'77','���','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000018','���� ���� ���� 3','P201','P20102',120000,180000,150000,'���� Ȱ������ ������ ����',null,'P201000018.gif',0,to_date('2020/02/21','YYYY/MM/DD'),11,'77','����','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000019','���� �ܿ� ���� 1','P201','P20102',210000,270000,240000,'���� Ȱ������ ������ �ܿ��� ����',null,'P201000019.gif',0,to_date('2020/02/29','YYYY/MM/DD'),22,'66','û��','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000020','���� �ܿ� ���� 2','P201','P20102',220000,280000,250000,'���� Ȱ������ ������ �ܿ��� ����',null,'P201000020.gif',0,to_date('2020/02/29','YYYY/MM/DD'),29,'77','���','��Ź ����','EA',0,0,null);
Insert into PROD values ('P201000021','���� �ܿ� ���� 3','P201','P20102',230000,290000,260000,'���� Ȱ������ ������ �ܿ��� ����',null,'P201000021.gif',0,to_date('2020/02/29','YYYY/MM/DD'),19,'88','����','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000001','���� �� ���� 1','P202','P20201',10000,19000,15000,'�ĸ��� ���� ����',null,'P202000001.gif',0,to_date('2020/01/05','YYYY/MM/DD'),9,'M','û��','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000002','���� �� ���� 2','P202','P20201',13000,22000,18000,'�ĸ��� ���� ����',null,'P202000002.gif',0,to_date('2020/01/05','YYYY/MM/DD'),9,'L','���','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000003','���� �� ���� 3','P202','P20201',15000,24000,20000,'�ĸ��� ���� ����',null,'P202000003.gif',0,to_date('2020/01/05','YYYY/MM/DD'),9,'XL','����','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000004','���� ���� ���� 1','P202','P20201',18000,28000,23000,'�ÿ��� ������ ����',null,'P202000004.gif',0,to_date('2020/02/05','YYYY/MM/DD'),9,'M','û��','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000005','���� ���� ���� 2','P202','P20201',23000,33000,28000,'�ÿ��� ������ ����',null,'P202000005.gif',0,to_date('2020/02/05','YYYY/MM/DD'),9,'L','���','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000006','���� ���� ���� 3','P202','P20201',28000,38000,33000,'�ÿ��� ������ ����',null,'P202000006.gif',0,to_date('2020/02/05','YYYY/MM/DD'),9,'XL','����','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000007','���� �ܿ� ���� ���� 1','P202','P20201',25000,42000,31000,'������ �ܿ��� ����',null,'P202000007.gif',0,to_date('2020/01/13','YYYY/MM/DD'),9,'M','û��','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000008','���� �ܿ� ���� ���� 2','P202','P20201',27000,43000,33000,'������ �ܿ��� ����',null,'P202000008.gif',0,to_date('2020/01/13','YYYY/MM/DD'),9,'L','���','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000009','���� �ܿ� ���� ���� 3','P202','P20201',28500,44000,35000,'������ �ܿ��� ����',null,'P202000009.gif',0,to_date('2020/01/13','YYYY/MM/DD'),9,'XL','����','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000010','���� û���� 1','P202','P20202',55000,66000,58000,'���� Ȱ���ĸ� ����',null,'P202000010.gif',0,to_date('2020/01/16','YYYY/MM/DD'),38,'30',null,'��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000011','���� û���� 2','P202','P20202',55000,66000,58000,'���� Ȱ���ĸ� ����',null,'P202000011.gif',0,to_date('2020/01/16','YYYY/MM/DD'),35,'32',null,'��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000012','���� û���� 3','P202','P20202',55000,66000,58000,'���� Ȱ���ĸ� ����',null,'P202000012.gif',0,to_date('2020/01/16','YYYY/MM/DD'),33,'34',null,'��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000013','���� �� ���� 1','P202','P20201',110000,230000,150000,'���� Ȱ������ ���� ����',null,'P202000013.gif',0,to_date('2020/02/17','YYYY/MM/DD'),16,'M','û��','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000014','���� �� ���� 2','P202','P20201',120000,230000,160000,'���� Ȱ������ ���� ����',null,'P202000014.gif',0,to_date('2020/02/17','YYYY/MM/DD'),18,'L','���','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000015','���� �� ���� 3','P202','P20201',130000,230000,170000,'���� Ȱ������ ���� ����',null,'P202000015.gif',0,to_date('2020/02/17','YYYY/MM/DD'),17,'XL','����','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000016','���� ���� ���� 1','P202','P20202',99000,160000,130000,'���� Ȱ������ ������ ����',null,'P202000016.gif',0,to_date('2020/02/06','YYYY/MM/DD'),12,'M','û��','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000017','���� ���� ���� 2','P202','P20202',109000,170000,150000,'���� Ȱ������ ������ ����',null,'P202000017.gif',0,to_date('2020/02/06','YYYY/MM/DD'),21,'L','���','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000018','���� ���� ���� 3','P202','P20202',159000,190000,170000,'���� Ȱ������ ������ ����',null,'P202000018.gif',0,to_date('2020/02/06','YYYY/MM/DD'),11,'XL','����','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000019','���� �ܿ� ���� 1','P202','P20202',210000,370000,280000,'���� Ȱ������ ������ �ܿ��� ����',null,'P202000019.gif',0,to_date('2020/02/20','YYYY/MM/DD'),22,'M','û��','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000020','���� �ܿ� ���� 2','P202','P20202',220000,370000,290000,'���� Ȱ������ ������ �ܿ��� ����',null,'P202000020.gif',0,to_date('2020/02/20','YYYY/MM/DD'),29,'L','���','��Ź ����','EA',0,0,null);
Insert into PROD values ('P202000021','���� �ܿ� ���� 3','P202','P20202',230000,370000,300000,'���� Ȱ������ ������ �ܿ��� ����',null,'P202000021.gif',0,to_date('2020/02/20','YYYY/MM/DD'),19,'XL','����','��Ź ����','EA',0,0,null);
Insert into PROD values ('P301000001','�Ǿ� ���� ����','P301','P30101',21000,41000,33000,'���� ���븦 ������.....',null,'P301000001.gif',0,to_date('2020/01/15','YYYY/MM/DD'),32,null,null,null,'EA',0,0,null);
Insert into PROD values ('P301000002','���� ���� ������','P301','P30101',17000,37000,29000,'���� ������ ������.....',null,'P301000002.gif',0,to_date('2020/01/15','YYYY/MM/DD'),52,null,null,null,'EA',0,0,null);
Insert into PROD values ('P301000003','������ ������','P301','P30101',22000,33000,26000,'���� ������ ������.....',null,'P301000003.gif',0,to_date('2020/02/15','YYYY/MM/DD'),22,null,null,null,'EA',0,0,null);
Insert into PROD values ('P301000004','������ ĳ��� ��Ʈ','P301','P30101',27000,37000,29000,'���� ��Ʈ�� ������.....',null,'P301000004.gif',0,to_date('2020/02/15','YYYY/MM/DD'),21,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000001','��� NO 5','P302','P30201',89000,110000,93000,'��⸦ ������.....',null,'P302000001.gif',0,to_date('2020/01/24','YYYY/MM/DD'),11,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000002','���� NO 7','P302','P30201',99000,120000,103000,'��⸦ ������.....',null,'P302000002.gif',0,to_date('2020/01/24','YYYY/MM/DD'),17,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000003','������ ��Ų','P302','P30201',19000,32000,21000,'������ �ٸ���.....',null,'P302000003.gif',0,to_date('2020/01/24','YYYY/MM/DD'),21,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000004','������ �μ�','P302','P30201',21000,33000,23000,'������ �ٸ���.....',null,'P302000004.gif',0,to_date('2020/02/12','YYYY/MM/DD'),19,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000005','������ ��Ų','P302','P30201',18000,31000,20000,'������ �ٸ���.....',null,'P302000005.gif',0,to_date('2020/02/12','YYYY/MM/DD'),21,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000006','������ �μ�','P302','P30201',20000,32000,22000,'������ �ٸ���.....',null,'P302000006.gif',0,to_date('2020/02/12','YYYY/MM/DD'),19,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000011','���� ���','P302','P30202',59000,70000,63000,'���� ��⸦ ������.....',null,'P302000011.gif',0,to_date('2020/01/13','YYYY/MM/DD'),21,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000012','���� ���','P302','P30202',89000,110000,93000,'������⸦ ������.....',null,'P302000012.gif',0,to_date('2020/01/13','YYYY/MM/DD'),27,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000013','����ƽ','P302','P30202',17000,27000,23000,'������ �ٸ��� ����.....',null,'P302000013.gif',0,to_date('2020/01/13','YYYY/MM/DD'),11,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000014','�鵵ũ��','P302','P30202',25000,32000,26000,'������ �ٸ��� ����.....',null,'P302000014.gif',0,to_date('2020/01/14','YYYY/MM/DD'),29,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000015','ȭ��̼�','P302','P30202',22000,32000,23000,'������ �ٸ��� ����.....',null,'P302000015.gif',0,to_date('2020/01/14','YYYY/MM/DD'),15,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000016','�ӵ���','P302','P30202',120000,220000,172000,'������ �ٸ��� ����.....',null,'P302000016.gif',0,to_date('2020/01/14','YYYY/MM/DD'),32,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000021','���� ����ȭ��ǰ','P302','P30203',23500,37500,26000,'�Ǻθ� ����ϰ�.....',null,'P302000021.gif',0,to_date('2020/01/28','YYYY/MM/DD'),25,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000022','���� ���� ���','P302','P30203',78500,98500,83000,'�������� �Ǻθ� ����ϰ�.....',null,'P302000022.gif',0,to_date('2020/01/28','YYYY/MM/DD'),53,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000023','���� ����ƽ','P302','P30203',21500,26500,22500,'���� �Ǻθ� ����ϰ�.....',null,'P302000023.gif',0,to_date('2020/01/28','YYYY/MM/DD'),17,null,null,null,'EA',0,0,null);

CREATE TABLE  buyprod
(  buy_date  DATE           NOT NULL,             -- �԰�����
   buy_prod  VARCHAR2(10)   NOT NULL,             -- ��ǰ�ڵ�
   buy_qty   NUMBER(10)     NOT NULL,             -- ���Լ���
   buy_cost  NUMBER(10)     NOT NULL,             -- ���Դܰ�
   CONSTRAINT pk_buyprod PRIMARY KEY (buy_date,buy_prod), 
   CONSTRAINT fr_buy_prod FOREIGN KEY (buy_prod) REFERENCES prod(prod_id)
);

Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/08','YYYY/MM/DD'),'P202000001',18,10000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/08','YYYY/MM/DD'),'P202000002',19,13000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/08','YYYY/MM/DD'),'P202000003',11,15000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/12','YYYY/MM/DD'),'P201000001',21,21000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/12','YYYY/MM/DD'),'P201000002',13,22000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/12','YYYY/MM/DD'),'P201000003',15,23000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/13','YYYY/MM/DD'),'P101000001',22,210000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/13','YYYY/MM/DD'),'P101000002',23,310000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/13','YYYY/MM/DD'),'P101000003',21,410000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/14','YYYY/MM/DD'),'P201000004',15,12000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/14','YYYY/MM/DD'),'P201000005',32,13000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/14','YYYY/MM/DD'),'P201000006',11,14000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/16','YYYY/MM/DD'),'P202000007',22,25000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/16','YYYY/MM/DD'),'P202000008',33,27000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/16','YYYY/MM/DD'),'P202000009',14,28500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/16','YYYY/MM/DD'),'P302000011',125,59000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/16','YYYY/MM/DD'),'P302000012',16,89000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/16','YYYY/MM/DD'),'P302000013',13,17000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/17','YYYY/MM/DD'),'P302000014',21,25000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/17','YYYY/MM/DD'),'P302000015',33,22000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/17','YYYY/MM/DD'),'P302000016',17,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/18','YYYY/MM/DD'),'P301000001',15,21000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/18','YYYY/MM/DD'),'P301000002',19,17000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/19','YYYY/MM/DD'),'P202000010',21,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/19','YYYY/MM/DD'),'P202000011',91,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/19','YYYY/MM/DD'),'P202000012',15,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/25','YYYY/MM/DD'),'P102000003',11,590000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/25','YYYY/MM/DD'),'P102000004',13,990000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/25','YYYY/MM/DD'),'P102000005',22,1990000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/26','YYYY/MM/DD'),'P102000007',52,550000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/27','YYYY/MM/DD'),'P302000001',253,89000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/27','YYYY/MM/DD'),'P302000002',31,99000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/27','YYYY/MM/DD'),'P302000003',197,19000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/28','YYYY/MM/DD'),'P201000007',19,31000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/28','YYYY/MM/DD'),'P201000008',22,32000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/28','YYYY/MM/DD'),'P201000009',26,33000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/31','YYYY/MM/DD'),'P302000021',23,23500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/31','YYYY/MM/DD'),'P302000022',17,78500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/31','YYYY/MM/DD'),'P302000023',15,21500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/03','YYYY/MM/DD'),'P201000010',23,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/03','YYYY/MM/DD'),'P201000011',21,56000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/03','YYYY/MM/DD'),'P201000012',55,57000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/08','YYYY/MM/DD'),'P202000004',12,18000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/08','YYYY/MM/DD'),'P202000005',19,23000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/08','YYYY/MM/DD'),'P202000006',28,28000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/09','YYYY/MM/DD'),'P202000016',22,99000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/09','YYYY/MM/DD'),'P202000017',41,109000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/09','YYYY/MM/DD'),'P202000018',21,159000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/11','YYYY/MM/DD'),'P101000004',11,1150000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/11','YYYY/MM/DD'),'P101000005',10,2150000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/11','YYYY/MM/DD'),'P101000006',9,3150000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/15','YYYY/MM/DD'),'P302000004',33,21000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/15','YYYY/MM/DD'),'P302000005',191,18000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/15','YYYY/MM/DD'),'P302000006',39,20000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/18','YYYY/MM/DD'),'P301000003',46,22000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/18','YYYY/MM/DD'),'P301000004',41,27000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/20','YYYY/MM/DD'),'P202000013',16,110000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/20','YYYY/MM/DD'),'P202000014',18,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/20','YYYY/MM/DD'),'P202000015',13,130000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/21','YYYY/MM/DD'),'P201000013',16,110000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/21','YYYY/MM/DD'),'P201000014',28,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/21','YYYY/MM/DD'),'P201000015',25,130000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/23','YYYY/MM/DD'),'P202000019',22,210000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/23','YYYY/MM/DD'),'P202000020',19,220000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/23','YYYY/MM/DD'),'P202000021',13,230000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/25','YYYY/MM/DD'),'P102000001',15,690000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/25','YYYY/MM/DD'),'P102000002',12,890000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/26','YYYY/MM/DD'),'P102000006',13,660000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/03/02','YYYY/MM/DD'),'P201000016',725,100000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/03/02','YYYY/MM/DD'),'P201000017',341,110000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/03/02','YYYY/MM/DD'),'P201000018',111,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/03/03','YYYY/MM/DD'),'P201000019',16,210000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/03/03','YYYY/MM/DD'),'P201000020',39,220000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/03/03','YYYY/MM/DD'),'P201000021',32,230000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/16','YYYY/MM/DD'),'P202000001',12,10000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/16','YYYY/MM/DD'),'P202000002',13,13000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/16','YYYY/MM/DD'),'P202000003',5,15000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/20','YYYY/MM/DD'),'P201000001',15,21000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/20','YYYY/MM/DD'),'P201000002',7,22000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/20','YYYY/MM/DD'),'P201000003',9,23000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/21','YYYY/MM/DD'),'P101000001',16,210000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/21','YYYY/MM/DD'),'P101000002',17,310000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/21','YYYY/MM/DD'),'P101000003',15,410000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/22','YYYY/MM/DD'),'P201000004',9,12000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/22','YYYY/MM/DD'),'P201000005',26,13000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/22','YYYY/MM/DD'),'P201000006',5,14000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/24','YYYY/MM/DD'),'P202000007',16,25000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/24','YYYY/MM/DD'),'P202000008',27,27000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/24','YYYY/MM/DD'),'P202000009',8,28500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/24','YYYY/MM/DD'),'P302000011',19,59000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/24','YYYY/MM/DD'),'P302000012',10,89000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/24','YYYY/MM/DD'),'P302000013',7,17000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/25','YYYY/MM/DD'),'P302000014',15,25000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/25','YYYY/MM/DD'),'P302000015',27,22000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/25','YYYY/MM/DD'),'P302000016',11,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/26','YYYY/MM/DD'),'P301000001',9,21000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/26','YYYY/MM/DD'),'P301000002',13,17000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/27','YYYY/MM/DD'),'P202000010',15,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/27','YYYY/MM/DD'),'P202000011',25,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/27','YYYY/MM/DD'),'P202000012',9,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/03','YYYY/MM/DD'),'P102000003',5,590000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/03','YYYY/MM/DD'),'P102000004',7,990000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/03','YYYY/MM/DD'),'P102000005',16,1990000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/04','YYYY/MM/DD'),'P102000007',46,550000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/05','YYYY/MM/DD'),'P302000001',17,89000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/05','YYYY/MM/DD'),'P302000002',25,99000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/05','YYYY/MM/DD'),'P302000003',11,19000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/06','YYYY/MM/DD'),'P201000007',13,31000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/06','YYYY/MM/DD'),'P201000008',16,32000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/06','YYYY/MM/DD'),'P201000009',20,33000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/09','YYYY/MM/DD'),'P302000021',17,23500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/09','YYYY/MM/DD'),'P302000022',11,78500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/09','YYYY/MM/DD'),'P302000023',9,21500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/12','YYYY/MM/DD'),'P201000010',17,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/12','YYYY/MM/DD'),'P201000011',15,56000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/12','YYYY/MM/DD'),'P201000012',49,57000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/17','YYYY/MM/DD'),'P202000004',6,18000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/17','YYYY/MM/DD'),'P202000005',13,23000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/17','YYYY/MM/DD'),'P202000006',22,28000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/18','YYYY/MM/DD'),'P202000016',16,99000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/18','YYYY/MM/DD'),'P202000017',35,109000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/18','YYYY/MM/DD'),'P202000018',15,159000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/20','YYYY/MM/DD'),'P101000004',5,1150000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/20','YYYY/MM/DD'),'P101000005',4,2150000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/20','YYYY/MM/DD'),'P101000006',3,3150000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/24','YYYY/MM/DD'),'P302000004',27,21000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/24','YYYY/MM/DD'),'P302000005',25,18000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/24','YYYY/MM/DD'),'P302000006',33,20000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/27','YYYY/MM/DD'),'P301000003',40,22000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/27','YYYY/MM/DD'),'P301000004',35,27000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/29','YYYY/MM/DD'),'P202000013',10,110000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/29','YYYY/MM/DD'),'P202000014',12,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/29','YYYY/MM/DD'),'P202000015',7,130000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/30','YYYY/MM/DD'),'P201000013',10,110000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/30','YYYY/MM/DD'),'P201000014',22,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/30','YYYY/MM/DD'),'P201000015',19,130000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/01','YYYY/MM/DD'),'P202000019',16,210000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/01','YYYY/MM/DD'),'P202000020',13,220000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/01','YYYY/MM/DD'),'P202000021',7,230000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/03','YYYY/MM/DD'),'P102000001',9,690000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/03','YYYY/MM/DD'),'P102000002',6,890000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/04','YYYY/MM/DD'),'P102000006',7,660000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/09','YYYY/MM/DD'),'P201000016',19,100000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/09','YYYY/MM/DD'),'P201000017',35,110000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/09','YYYY/MM/DD'),'P201000018',25,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/10','YYYY/MM/DD'),'P201000019',10,210000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/10','YYYY/MM/DD'),'P201000020',33,220000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/10','YYYY/MM/DD'),'P201000021',26,230000);

CREATE TABLE  member
(  mem_id                VARCHAR2(15)   NOT NULL,   -- ȸ��ID  
   mem_pass              VARCHAR2(15)   NOT NULL,   -- ��й�ȣ
   mem_name              VARCHAR2(20)   NOT NULL,   -- ����
   mem_regno1            CHAR(6)        NOT NULL,   -- �ֹε�Ϲ�ȣ��6�ڸ�
   mem_regno2            CHAR(7)        NOT NULL,   -- �ֹε�Ϲ�ȣ��7�ڸ�
   mem_bir               DATE,                      -- ����
   mem_zip               CHAR(7)        NOT NULL,   -- �����ȣ
   mem_add1              VARCHAR2(100)  NOT NULL,   -- �ּ�1
   mem_add2              VARCHAR2(80)   NOT NULL,   -- �ּ�2
   mem_hometel           VARCHAR2(14)   NOT NULL,   -- ����ȭ��ȣ                                
   mem_comtel            VARCHAR2(14)   NOT NULL,   -- ȸ����ȭ��ȣ                              
   mem_hp                VARCHAR2(15),              -- �̵���ȭ
   mem_mail              VARCHAR2(40)   NOT NULL,   -- E-mail�ּ�
   mem_job               VARCHAR2(40),              -- ����
   mem_like              VARCHAR2(40),              -- ���
   mem_memorial          VARCHAR2(40),              -- ����ϸ�
   mem_memorialday       DATE,                      -- ����ϳ�¥
   mem_mileage           NUMBER(10),                -- ���ϸ���              
   mem_delete            VARCHAR2(1),               -- ��������
   CONSTRAINT pk_mem_id PRIMARY KEY (mem_id) 
);

Insert into MEMBER values ('a001','asdfasdf','������','000315','3406420',to_date('2000/03/15','YYYY/MM/DD'),'135-972','������ ���� ��','222-2����','042-621-4615','042-621-4615','010-6217-4615','pyoedab@lycos.co.kr','�ֺ�','����','��ȥ�����',null,1000,null);
Insert into MEMBER values ('b001','1004','�̻���','981204','2900000',to_date('1998/12/04','YYYY/MM/DD'),'700-030','����� õ�絿 ���۸���','1004-29','02-888-9999','02-888-9999','010-8886-9999','engelcd@pretty.net','ȸ���','����','�ƹ��Ի���',null,2300,null);
Insert into MEMBER values ('c001','7777','�ſ�ȯ','980324','1400716',to_date('1998/03/24','YYYY/MM/DD'),'407-817','���������� �߱� ���ﵿ','477-9','042-123-5678','042-123-5678','010-1236-5678','kyh01e@hanmail.net','����','����','�Ƴ�����',null,3500,null);
Insert into MEMBER values ('d001','123joy','������','700609','2000000',to_date('1970/06/09','YYYY/MM/DD'),'501-705','������ �߱� �ϴõ� ','�� 3����','042-222-8877','042-222-8877','010-2228-8877','dbs81f@hanmail.net','������','����','��ȥ�����',null,1700,null);
Insert into MEMBER values ('e001','00000000','������','990701','2406017',to_date('1999/07/01','YYYY/MM/DD'),'617-800','������ ����� ������','��������Ʈ','042-432-8901','042-432-8901','010-4329-8901','bosiang@hanmail.net','���','�籸','�ƹ��Ի���',null,6500,null);
Insert into MEMBER values ('f001','12345678','�ſ���','000228','3459919',to_date('2000/02/28','YYYY/MM/DD'),'140-706','���������� ���ﵿ','65-33 303ȣ','042-253-2121','042-253-2121','010-2538-2121','SUPER-KHG@HANMAIL.NET','�ֺ�','����','�Ƴ�����',null,2700,null);
Insert into MEMBER values ('g001','1456','�۰���','020111','4403414',to_date('2002/01/11','YYYY/MM/DD'),'339-841','�泲�ݻ걺 ������','�ɳ���123-1','0412-356-3578','0412-356-3578','010-3565-3578','lim052@hanmail.net','�ֺ�','��Ű','��ȥ�����',null,800,null);
Insert into MEMBER values ('h001','9999','����ȣ','980928','1455822',to_date('1998/09/28','YYYY/MM/DD'),'339-841','�泲 ���� ���̸�','����3�� 345','042-522-1679','042-522-1679','010-5229-1679','wingl7@hanmail.net','ȸ���','����','�Ƴ�����',null,1500,null);
Insert into MEMBER values ('i001','1111','������','990220','2384719',to_date('1999/02/20','YYYY/MM/DD'),'306-702','������ ���� ����1��','768-12','042-614-6914','042-614-6914','010-6145-6914','pan@orgio.net','������','���','�������',null,900,null);
Insert into MEMBER values ('j001','6262','������','991219','2448920',to_date('1999/12/19','YYYY/MM/DD'),'306-702','������ ���� ��õ��','�ѽž���Ʈ305��309ȣ','042-332-8976','042-332-8976','010-3321-8976','maxsys@hanmail.net','���','����','��ȥ�����',null,1100,null);
Insert into MEMBER values ('k001','7227','��ö��','860323','1449311',to_date('1986/03/23','YYYY/MM/DD'),'306-702','������ ����� ��ȭ��','34-567','042-157-8765','042-157-8765','010-1572-8765','equus@orgio.net','�ڿ���','����','�Ƴ�����',null,3700,null);
Insert into MEMBER values ('l001','12345678','���浿','030214','3234566',to_date('2003/02/14','YYYY/MM/DD'),'339-841','�泲�ݻ걺 �ݻ���',' �ϸ�35-322','0412-322-8865','0412-322-8865','010-3223-8865','email815@hanmail.co.kr','�ڿ���','�ٵ�','��ȥ�����',null,5300,null);
Insert into MEMBER values ('m001','pass','������','990515','2555555',to_date('1999/05/15','YYYY/MM/DD'),'306-702','���������� ���� ������','�μ�����Ʈ 234�� 907ȣ','042-252-0675','042-252-0675','010-2521-0675','happy@hanmail.net','�����','���','�ƹ��Ի���',null,1300,null);
Insert into MEMBER values ('n001','1111','Ź����','990523','1011014',to_date('1999/05/23','YYYY/MM/DD'),'306-702','������ ���� �ھ絿','32-23','042-632-2176','042-632-2176','010-6322-2176','ping75@unitel.co.kr','����','����','��ȥ�����',null,2700,null);
Insert into MEMBER values ('o001','0909','������','021130','4447619',to_date('2002/11/30','YYYY/MM/DD'),'306-702','������ ���� ������','�漺����Ʈ502��1101ȣ','042-622-5971','042-622-5971','010-6221-5971','tar-song@hanmail.net','ȸ���','���','��ӴԻ���',null,2600,null);
Insert into MEMBER values ('p001','sahra3','������','971005','2458323',to_date('1997/10/05','YYYY/MM/DD'),'306-702','�����������۰���','�Ѽ־���Ʈ 703�� 407ȣ','042-810-7658','042-810-7658','010-8103-7658','sahra235@intz.com','������','����','�������',null,2200,null);
Insert into MEMBER values ('q001','0000','����ȸ','961220','1402722',to_date('1996/12/20','YYYY/MM/DD'),'306-702','�뱸������ ����� �߸���','678-43','042-823-2359','042-823-2359','010-8232-2359','kph@hanmail.net','�ڿ���','��ȭ','��ȥ�����',null,1500,null);
Insert into MEMBER values ('r001','park1005','������','010320','4382532',to_date('2001/03/20','YYYY/MM/DD'),'306-702','������ ���� ������','321-25','042-533-8768','042-533-8768','010-5335-8768','econie@hanmail.net','�л�','���','��ӴԻ���',null,700,null);
Insert into MEMBER values ('s001','0819','������','011019','4459927',to_date('2001/10/19','YYYY/MM/DD'),'306-702','�뱸������ ���� ź�浿','��ȣ����Ʈ 107�� 802ȣ','042-222-8155','042-222-8155','010-2228-8155','songej@hanmail.net','������','�ٵ�','��ȥ�����',null,3200,null);
Insert into MEMBER values ('t001','0506','������','000706','3454731',to_date('2000/07/06','YYYY/MM/DD'),'306-702','���������� �߱� ��õ��','�ѻ������Ʈ 302�� 504ȣ','042-272-8657','042-272-8657','010-2725-8657','bob6@hanmail.net','�л�','ī���̽�','��ȥ�����',null,2200,null);
Insert into MEMBER values ('u001','1000','�輺��','971210','1460111',to_date('1997/12/10','YYYY/MM/DD'),'306-702','������ ���� ������','76-54','042-273-9056','042-273-9056','010-2734-9056','pss576@orgio.net','�ֺ�','��ȭ����','��ȥ�����',null,2700,null);
Insert into MEMBER values ('v001','00001111','������','760331','2402712',to_date('1976/03/31','YYYY/MM/DD'),'306-702','������ ���� ������','566-39����','042-240-8766','042-240-8766','010-2406-8766','gagsong@orgio.net','�ڿ���','����','�������',null,4300,null);
Insert into MEMBER values ('w001','12341234','������','880213','1111111',to_date('1988/02/13','YYYY/MM/DD'),'306-702','������ ����� ���ൿ','23-43','02-345-9877','02-345-9877','010-3452-9877','songone@hanmail.net','�л�','���','��ȥ�����',null,2700,null);
Insert into MEMBER values ('x001','0000','������','010519','4110222',to_date('2001/05/19','YYYY/MM/DD'),'306-702','���������� ���� ������','43-26','042-223-8767','042-223-8767','010-2238-8767','happysong@hanmail.net','�ֺ�','����','��ȥ�����',null,8700,null);

CREATE TABLE  cart
(
   cart_member      VARCHAR2(15)    NOT NULL,       -- ȸ��ID
   cart_no          CHAR(13)        NOT NULL,       -- �ֹ���ȣ
   cart_prod        VARCHAR2(10)    NOT NULL,       -- ��ǰ�ڵ�
   cart_qty         NUMBER(8)       NOT NULL,       -- ����
   CONSTRAINT pk_cart PRIMARY KEY (cart_no,cart_prod),
   CONSTRAINT fr_cart_member FOREIGN KEY (cart_member) REFERENCES member(mem_id),
   CONSTRAINT fr_cart_prod   FOREIGN KEY (cart_prod)   REFERENCES prod(prod_id)
);

COMMENT ON TABLE  CART             IS '��ٱ��� ���� ���̺�';
COMMENT ON COLUMN CART.CART_MEMBER IS 'ȸ��ID';
COMMENT ON COLUMN CART.CART_NO     IS '�ֹ���ȣ';
COMMENT ON COLUMN CART.CART_PROD   IS '��ǰ�ڵ�';
COMMENT ON COLUMN CART.CART_QTY    IS '����';

--DESC CART;

Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020040100001','P101000001',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020040100001','P201000018',16);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020040100001','P302000003',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('t001','2020040100002','P302000004',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('t001','2020040100002','P101000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('w001','2020040100003','P201000019',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('w001','2020040100003','P302000005',9);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('w001','2020040100003','P201000020',21);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('w001','2020040100003','P101000003',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020040500001','P302000006',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020040500001','P101000004',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020040500001','P201000021',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('q001','2020040500002','P302000011',11);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('q001','2020040500002','P202000001',12);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('q001','2020040500002','P101000005',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('p001','2020040600001','P101000006',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('p001','2020040600001','P202000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('o001','2020040600002','P302000013',9);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('o001','2020040600002','P202000003',9);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('o001','2020040600002','P102000001',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020040800001','P302000014',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020040800001','P102000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020040800001','P202000004',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020040800002','P302000015',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020040800002','P202000005',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020040800002','P102000003',9);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('l001','2020041000001','P302000016',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('l001','2020041000001','P102000004',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('l001','2020041000001','P202000006',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041000002','P202000007',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041000002','P102000005',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041000002','P302000021',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020041200001','P302000022',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020041200001','P202000008',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020041200001','P102000006',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020041200001','P202000009',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020041200002','P102000007',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020041200002','P302000023',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020041200002','P202000010',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041500001','P201000001',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041500001','P302000001',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020041500002','P202000011',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020041500002','P201000002',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020041500002','P302000002',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041600001','P302000003',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041600001','P201000003',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041600001','P202000012',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020041600002','P302000004',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020041600002','P201000004',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020041600002','P202000013',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020041800001','P302000005',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020041800001','P201000005',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020041800001','P202000014',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020041800002','P302000006',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020041800002','P201000006',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020041800002','P202000015',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042000001','P302000011',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042000001','P201000007',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042000001','P202000016',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042000001','P202000017',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042000001','P201000008',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020042000002','P202000018',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020042000002','P201000009',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020042000002','P202000019',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020042000002','P201000010',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020042000002','P202000020',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('x001','2020042400001','P201000011',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('x001','2020042400001','P202000021',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('x001','2020042400001','P201000012',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020042400002','P301000001',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020042400002','P201000013',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020042400002','P301000002',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020042400002','P201000014',13);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020042800001','P301000003',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020042800001','P201000015',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042800002','P302000001',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042800002','P201000016',15);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042800002','P302000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042800002','P201000017',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020050100001','P201000013',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020050100001','P301000002',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020050100002','P301000003',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020050100002','P201000014',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020050100002','P201000015',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020050300001','P302000001',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020050300001','P302000002',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020050300002','P201000016',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020050300002','P201000017',21);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020050500001','P302000003',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020050500001','P201000018',11);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020050500001','P302000004',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020050500002','P201000019',12);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020050700001','P302000005',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020050700001','P101000001',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020050700001','P101000002',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020050700002','P201000020',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020050700002','P302000006',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020050700002','P302000011',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020051000001','P201000021',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020051000001','P101000003',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020051000001','P101000004',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020051000002','P202000001',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020051000002','P302000012',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020051000002','P302000013',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020051000002','P101000005',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020051000002','P202000002',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020051200001','P101000006',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020051200001','P202000003',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020051200001','P302000014',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020051200001','P302000015',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020051200001','P102000001',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020051300001','P202000004',9);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020051300001','P102000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020051300001','P202000005',11);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020051300001','P302000016',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020051300001','P302000021',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('i001','2020051500001','P102000003',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('i001','2020051500001','P202000006',12);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020051600001','P102000004',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020051600001','P202000007',17);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020051600001','P302000022',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('k001','2020051600002','P302000023',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('k001','2020051600002','P102000005',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('k001','2020051600002','P202000008',21);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('k001','2020051600002','P102000006',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('k001','2020051600002','P202000009',13);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('l001','2020051800001','P302000001',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('l001','2020051800001','P302000002',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020051800002','P102000007',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020051800002','P202000010',23);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020051800002','P201000001',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020051800002','P202000011',25);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020051800002','P302000003',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020051800002','P302000004',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('o001','2020052100001','P201000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('o001','2020052100001','P202000012',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('o001','2020052100001','P201000003',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('p001','2020052100002','P202000013',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('p001','2020052100002','P302000005',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('p001','2020052100002','P302000006',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('p001','2020052100002','P201000004',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('p001','2020052100002','P202000014',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020052400001','P201000005',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020052400001','P202000015',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020052400001','P302000011',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('s001','2020052500001','P302000012',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('s001','2020052500001','P201000006',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('s001','2020052500001','P202000016',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('t001','2020052500002','P201000007',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('t001','2020052500002','P202000017',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('t001','2020052500002','P201000008',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('t001','2020052500002','P202000018',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('v001','2020052800001','P201000009',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('v001','2020052800001','P202000019',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('w001','2020052900001','P201000010',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('w001','2020052900001','P202000020',9);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('w001','2020052900001','P201000011',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('x001','2020052900002','P202000021',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('x001','2020052900002','P201000012',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('x001','2020052900002','P301000001',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020060500001','P302000013',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020060500001','P302000014',11);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020060500001','P302000015',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020060600001','P302000016',9);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020060600001','P302000021',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020060600001','P302000022',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020061200001','P302000023',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020061200001','P302000001',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020061300001','P302000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020061300001','P302000003',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020061300002','P302000004',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020061300002','P302000005',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020062100001','P302000006',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020062100001','P302000011',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020062100002','P302000012',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020062500001','P302000013',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020062500001','P302000014',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020062500001','P302000015',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020070100001','P201000013',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020070100001','P301000002',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020070100002','P301000003',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020070100002','P201000014',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020070100002','P201000015',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020070300001','P302000001',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020070300001','P302000002',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020070300002','P201000016',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020070300002','P201000017',21);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020070800001','P101000001',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020070800001','P101000002',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020070800002','P101000003',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('h001','2020071100001','P101000005',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020071100002','P101000006',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('i001','2020071900001','P102000001',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('i001','2020071900001','P102000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('i001','2020071900001','P102000003',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('u001','2020071900002','P102000004',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('u001','2020071900002','P102000005',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020072800001','P102000006',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020072800001','P102000003',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('q001','2020072800002','P102000004',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('q001','2020072800002','P102000005',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020072800003','P301000003',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020072800003','P201000015',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020072800004','P302000001',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020072800004','P201000016',15);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020072800004','P302000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020072800004','P201000017',2);