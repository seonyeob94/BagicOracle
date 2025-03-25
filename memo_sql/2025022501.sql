2025_0225_01) SUBQUERY
** DML ��ɰ� SUBQUERY
 - INSERT INTO, UPDATE, DELETE ��ɰ� ���� ���

**���������̺�(REMAIN)�� �����ϰ� ���� ���ǿ� �°� �����͸� �����Ͻÿ�.
------------------------------------------------
 �÷���         ������Ÿ��     �ʱⰪ      PK/FK
------------------------------------------------
REMAIN_YEAR   CHAR(14)                PK  --���� �⵵�� �����ϱ� ���� ����
PROD_ID       VARCHAR2(10)            PK&FK
REMAIN_J_00   NUMBER(5)               ������� --�����Ҽ� ���� ��
REMAIN_I      NUMBER(5)      0        �԰�����հ�
REMAIN_O      NUMBER(5)      0        �������հ�
REMAIN_J_99   NUMBER(5)      0        �����
REMAIN_DATE   DATE         SYSDATE    ������
------------------------------------------------

����1)���� �ڷḦ ���������̺� �Է��Ͻÿ�
---------------------------------------------
 �÷���           ��      
---------------------------------------------
 REMAIN_YEAR    2020
 PROD_ID        PROD ���̺��� ��� ��ǰ
 REMAIN_J_00    PROD ���̺��� PROD_PROPERSTOCK
 REMAIN_I
 REMAIN_O
 REMAIN_J_99    PROD ���̺��� PROD_PROPERSTOCK
 REMAIN_DATE    2020�� 1�� 1��
---------------------------------------------
1. INSERT���� SUBQUERY
 - INSERT���� ���������� ����� ������ VALUES���� '()'�� ����
 - INTO���� ���� �÷��� ����, ������ ���������� SELECT���� �÷��� ����, ������ ��ġ

 INSERT INTO C##sy94.REMAIN(REMAIN_YEAR,PROD_ID,REMAIN_J_00,REMAIN_J_99,REMAIN_DATE)
   SELECT '2020',PROD_ID,PROD_PROPERSTOCK,PROD_PROPERSTOCK,TO_DATE('20200101')
     FROM PROD;
     COMMIT;
     
     
2. UPDATE���� SUBQUERY
  - ���� ���� ���Ǵ� dml���
(�������)
  UPDATE ���̺�� [��Ī]
     SET (�÷��� [,�÷���,...])=(SELECT �÷��� [,�÷���,...])
                                FROM ���̺��
                                      :
                             )
  [WHERE ����] 
  - SET���� �������� �÷��� ����� �� ������ �̰�� ���������� 
    SELECT ���� �÷��� ����, ������ ��ġ�ؾ� �Ѵ�.
  - ���������� �ݵ��'( )'�ȿ� ����ؾ� ��  
  
��뿹)2020�� 1�� ��ǰ�� ���Լ����� ��ȸ�Ͽ� ���������̺��� �����Ͻÿ�
(��������:���������̺��� ����)
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
    
(��������:2020�� 1�� ��ǰ�� ���Լ���)
  SELECT B.BSUM
    FROM (SELECT PROD_ID,
                 SUM(BUY_QTY) AS BSUM
            FROM BUYPROD
           WHERE BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
           GROUP BY PROD_ID) B
           
��뿹)2020�� 1������ 7������ ��� ��ǰ�� ����/���� ������ ��ȸ�Ͻÿ�          
     Alias�� ��ǰ�ڵ�,���Լ����հ�,��������հ�

  SELECT A.PROD_ID AS ��ǰ�ڵ�,
         SUM(B.BUY_QTY) AS ���Լ����հ�,
         SUM(C.CART_QTY) AS ��������հ�
    FROM PROD A 
    LEFT OUTER JOIN BUYPROD B ON(A.PROD_ID=B.PROD_ID)
    LEFT OUTER JOIN CART C ON(A.PROD_ID=C.PROD_ID)
   GROUP BY A.PROD_ID

 (��������1: 2020�� 2������ 7������ ��������)=>A
 (SELECT PROD_ID ,
         SUM(BUY_QTY) AS ASUM
    FROM BUYPROD
   WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200731')
   GROUP BY PROD_ID) A
    
 (��������2: 2020�� 1������ 7������ ��������)=>B
 (SELECT PROD_ID, SUM(CART_QTY) AS BSUM
    FROM CART
   WHERE SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202007'
   GROUP BY PROD_ID) B

 
 ��������:PROD���̺�� ���̺�A, ���̺�B�� �ܺ�����)

  SELECT C.PROD_ID AS ��ǰ�ڵ�,
         NVL(A.ASUM,0) AS ���Լ����հ�,
         NVL(B.BSUM,0) AS ��������հ�
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


  SELECT C.PROD_ID AS ��ǰ�ڵ�,
         NVL(SUM(A.BUY_QTY),0) AS ���Լ����հ�,
         NVL(SUM(B.CART_QTY),0) AS ��������հ�
    FROM PROD C
    LEFT OUTER JOIN BUYPROD A ON(A.PROD_ID=C.PROD_ID AND 
         BUY_DATE BETWEEN TO_DATE('20200201') AND TO_DATE('20200731'))
    LEFT OUTER JOIN CART B ON(A.PROD_ID=B.PROD_ID AND
         SUBSTR(CART_NO,1,6) BETWEEN '202001' AND '202007') 
   GROUP BY C.PROD_ID  
   ORDER BY 1;   
   
  SELECT C.PROD_ID AS ��ǰ�ڵ�,
         NVL(A.ASUM,0) AS ���Լ����հ�,
         NVL(B.BSUM,0) AS ��������հ�
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
    
    

   
��뿹) �� �������� ���� ����� ���������̺��� �����Ͻÿ�
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
      





