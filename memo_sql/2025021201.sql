2025_0212-01)���ڿ� �Լ�
 - CONCAT, LPAD,RPAD,LTRIM,RTRIM,TRIM, LENGTH,
   SUBRT,REPLACE, INSTR
   
��뿹)
  SELECT MEM_ID, MEM_NAME, CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2),
         MEM_REGNO1||'-'||MEM_REGNO2
    FROM MEMBER;
--LOWER,UPPER,INITCAP    
��뿹)ȸ�����̺��� 'C001'ȸ���� ȸ����,��ȭ��ȣ(�ڵ���)������ ����Ͻÿ�
  SELECT MEM_NAME AS ȸ����,
         MEM_HP AS "��ȭ��ȣ(�ڵ���)" --����Ŭ�� �ν��� �� ���� ()�� ��������� ""�� �ν��Ҽ� �ְ� ���ش�
    FROM MEMBER
   WHERE UPPER(MEM_ID)='C001';
   
  SELECT EMPLOYEE_ID AS �����ȣ, 
         EMP_NAME AS "�����(��)", 
         LOWER(EMP_NAME) AS "�����2", 
         INITCAP(LOWER(EMP_NAME)) AS "�����3"
    FROM C##HR.EMPLOYEES
   WHERE HIRE_DATE >='20180101'; 
   
--LPAD,RPAD
  SELECT PROD_NAME, PROD_SIZE, LPAD(PROD_SIZE, 10, '*'),
         LPAD(PROD_SIZE, 12)
    FROM PROD
--LTRIM,RTRIM,TRIM
  SELECT LTRIM('ABBAACPPLEABBA','AB'),RTRIM('ABBAACPPLEABBA','AB')
    FROM DUAL;
    COMMIT;
 --PROD�� ������ �� PROD_NAME�� VARCHAR2(40)���� CHAR(40)�� �ٲ۵� ������ų���� �ݵ�� ������ ����
  UPDATE PROD
     SET PROD_NAME=TRIM(PROD_NAME);
  
  SELECT PROD_ID,PROD_NAME,PROD_PRICE
    FROM PROD;
    
--SUBSTR -- CASE WHEN�� �ڹ��� IF��� ����
��뿹)ȸ�����̺��� �ֹι�ȣ�� �̿��Ͽ� ���̸� ���ϰ� ���ɴ븦 ����Ͻÿ�
     Alias�� ȸ����ȣ,ȸ����,�ֹι�ȣ,����,���ɴ�
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
         CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','2') THEN
            EXTRACT(YEAR FROM SYSDATE)- 
              TO_NUMBER(CONCAT('19',SUBSTR(MEM_REGNO1,1,2)))
      ELSE  EXTRACT(YEAR FROM SYSDATE)- 
              TO_NUMBER(CONCAT('20',SUBSTR(MEM_REGNO1,1,2)))
         END AS ����,
         CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','2') THEN
              TRUNC((EXTRACT(YEAR FROM SYSDATE)- 
              TO_NUMBER(CONCAT('19',SUBSTR(MEM_REGNO1,1,2))))/10)*10
         ELSE TRUNC((EXTRACT(YEAR FROM SYSDATE)- 
              TO_NUMBER(CONCAT('20',SUBSTR(MEM_REGNO1,1,2))))/10)*10
         END AS ���ɴ�
    FROM MEMBER;
    
��뿹)��ٱ������̺���2020�� 6�� ~7�� �Ǹ������� ��ȸ�Ͻÿ�
      Alias�� ��¥,��ǰ�ڵ�,�Ǹż���
  SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS ��¥,
         PROD_ID AS ��ǰ�ڵ�,
         CART_QTY AS �Ǹż���
    FROM CART
--   WHERE SUBSTR(CART_NO,1,6)>='202006' 
--     AND SUBSTR(CART_NO,1,6)<='202007' 
   WHERE SUBSTR(CART_NO,1,6) BETWEEN '202006' AND '202007'
   ORDER BY 1;
   
--REPLACE(data, 'char1', [, 'char2'])
  - ���ڿ� ��ġ
  - data���� 'char1'�� ã�� 'char2'�� �ٲ�
  - 'char2'�� �����Ǹ� ã�� 'char1'�� ����
��뿹)��ǰ���̺��� PROD_OULINEĮ���� �� �� '....'�� ã�� �����Ͻÿ�
  SELECT PROD_NAME,
         PROD_OUTLINE,
         REPLACE(PROD_OUTLINE,'.')
    FROM PROD; 
    
  SELECT PROD_NAME,
         REPLACE(PROD_NAME,'���','APPLE'),
         REPLACE(PROD_NAME,' ')
    FROM PROD;