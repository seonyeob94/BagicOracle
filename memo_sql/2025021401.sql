2025_2014_01)����ȯ �Լ�
1. TO_CHAR(������ [,�����������ڿ�])
  - '������' : ����(CHAR, CLOBŸ��), ����, ��¥ Ÿ���� �ڷḦ ���ڿ��� ��ȯ
**�����������ڿ� : ��ȯ�Ϸ��� ���ڿ� ������ �����ϴ� ����
 1) ��¥�������� ���ڿ�
-----------------------------------------------------------------------------
  ���ڿ�         ����           ��
-----------------------------------------------------------------------------
AD, BC      �����/����       SELECT TO_CHAR(SYSDATE, 'BC YYYY"��"') FROM DUAL; 
 CC            ����          SELECT TO_CHAR(SYSDATE, 'YYYY ":" CC "����"') FROM DUAL;
YYYY,YYY       �⵵          
YY,Y,YEAR                   SELECT TO_CHAR(SYSDATE, 'YYYY YYY YY Y YEAR') 
                              FROM DUAL;
MONTH, MON, MM, RM             SELECT TO_CHAR(SYSDATE, 'YYYY MM'),
                                      TO_CHAR(SYSDATE, 'YYYY RM'),
                                      TO_CHAR(SYSDATE, 'YYYY MONTH'),
                                      TO_CHAR(SYSDATE, 'YYYY MON')
                                 FROM DUAL;                 
DD,DDD,J       ��            SELECT TO_CHAR(SYSDATE, 'YYYY DD'),
                                    TO_CHAR(SYSDATE, 'YYYY DDD'),
                                    TO_CHAR(SYSDATE, 'YYYY J')
                              FROM DUAL;
AM,  PM
A.M., P.M.                    SELECT TO_CHAR(SYSDATE, 'YYYY AM A.M.'),
                                    TO_CHAR(SYSDATE, 'YYYY PM P.M.')
                                FROM DUAL;
HH,HH12,HH24   �ð�
MI             ��
SS,SSSSS       ��              SELECT TO_CHAR(SYSDATE, 'YYYY AM MM DD HH24:MI:SS SSSSS')
                                FROM DUAL;
"���ڿ�"      ���������          SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"')
                                FROM DUAL;      
                                
 2) ������������ ���ڿ�
-----------------------------------------------------------------------------
  ���ڿ�         ����           ��
-----------------------------------------------------------------------------
   9      ��ȿ���ڴ� ���,
          ��ȿ�� 0�� ����ó��    SELECT TO_CHAR(2345.7, '99999.99') AS "COL1",
                                    TO_CHAR(345.7, '99,999.99') AS "COL2"
                              FROM DUAL;
   0      ��ȣ���ڴ� ���
          ��ȿ�� 0�� 0�� ���    SELECT TO_CHAR(2345.7, '00000.00') AS "COL1",
          ��� ��쿡 "," ���          TO_CHAR(345.7, '00,000.00') AS "COL2"
                              FROM DUAL;
   $,L   ȭ���ȣ�� ���ʿ�       
         ���                  SELECT TO_CHAR(2345.7, 'L99999.99') AS "COL1",
                                    TO_CHAR(1345.7, '$99,999.99') AS "COL2"
                              FROM DUAL;
   MI    ������ ��� '-' ��ȣ�� 
         ���� �����ʿ� ���       SELECT TO_CHAR(2345.7, '99999.99MI') AS "COL1",
                                      TO_CHAR(-1345.7, '99,999.99MI') AS "COL2"  
                                     FROM DUAL;
   PR    ������ ��� ���ڸ� 
         <>�� ���� ���          SELECT TO_CHAR(2345.7, '99999.99PR') AS "COL1",
                                      TO_CHAR(-1345.7, '99,999.99PR') AS "COL2"  
                                     FROM DUAL;
                                     
2. TO_NUMBER(������ [,�����������ڿ�])
 - '������'�� ���ڿ� �ڷ��, ���ڷ� ��ȯ�� �� �ִ� �ڷ��̿��� ��
 - '�����������ڿ�'�� ���Ǵ� ���� '������'�� �ڵ����� ���ڷ� ��ȯ�� �� ���� ������ ���ڿ��� ��� 
   �� ���� ����ϱ� ���� ���� '�����������ڿ�'�� ����ؾ� �Ѵ�.
 - '�����������ڿ�'�� TO_CHAR�� ���� ���������������ڿ��� ������ 
 
��뿹)
 SELECT --TO_NUMBER('P210000'), --���� ��ȯ �Ұ����� ��������('P')
        TO_NUMBER('210000'),
        --TO_NUMBER('210,000'), --���� ��ȯ �Ұ����� ��������(',')
        TO_NUMBER('21.67'),
        TO_NUMBER('210,000','999,999'),
        TO_NUMBER('<210,000>','000,000PR')
   FROM DUAL;     --������ ���� ���ָ� �����ڷ�
   
2. TO_DATE(������ [,�����������ڿ�])
 - '������'�� ���ڿ� �Ǵ� ���� �ڷ��, ��¥�� ��ȯ�� �� �ִ� ������ ���� �ڷ��̿��� ��
   ex)�����, ����Ͻú���
 - '�����������ڿ�'�� ���Ǵ� ���� '������'�� �ڵ����� ��¥�� �ڵ� ��ȯ�� �� ���� ������ ���ڿ��� ��� 
   �� ���� ����ϱ� ���� ���� '�����������ڿ�'�� ����ؾ� �Ѵ�.
 - '�����������ڿ�'�� TO_CHAR�� ���� ��¥�����������ڿ��� ������ 
��뿹)
  SELECT TO_DATE('20250214'),
         TO_DATE('20250214 10439','YYYYMMDD HHMISS'),
         TO_DATE(20250214),
     --    TO_DATE('20250931'),
         TO_DATE('2025 02 14'),   // '/' '-' ' '��� ���ı����� Ư����ȣ
         TO_DATE('2025�� 02�� 14�� 10:43:59', 
                 'YYYY"��" MM"��" DD"��" HH24:MI:SS')
   FROM DUAL;    
   
��뿹) ������ 2020�� 7�� 28���̶�� �����ϰ� CART���̺� ���� ��ٱ��Ϲ�ȣ�� �����Ͻÿ�

  SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||
         TRIM(TO_CHAR(TO_NUMBER(SUBSTR(TO_CHAR(MAX(CART_NO)),9))+1,'00000')),
         MAX(CART_NO)+1
    FROM CART
   WHERE CART_NO LIKE TO_CHAR(SYSDATE,'YYYYMMDD')||'%' ;
   
   