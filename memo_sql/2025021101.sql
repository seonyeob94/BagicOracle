2025-0211-11)SELECT��
  - ������ ���
��뿹)��ǰ���̺��� �ǸŰ����� 100���� �̻��� ��ǰ�� ��ȸ�Ͻÿ�
      Alias�� ��ǰ��ȣ, ��ǰ��, �ǸŰ���
����: �ǸŰ����� 100���� �̻�)
 SELECT PROD_ID AS ��ǰ��ȣ, 
        PROD_NAME AS ��ǰ��, 
        PROD_PRICE AS �ǸŰ���
   FROM PROD
  WHERE PROD_PRICE>=1000000
  ORDER BY 3 DESC;
          
��뿹)ȸ�����̺��� ���ϸ����� 2000�̸��� ȸ�������� ��ȸ�Ͻÿ�
      Alias�� ȸ����ȣ, ȸ����, ���� ,���ϸ���
 SELECT MEM_ID AS ȸ����ȣ, 
        MEM_NAME AS ȸ����, 
        MEM_JOB AS ����,
        MEM_MILEAGE AS ���ϸ���
   FROM MEMBER
  WHERE MEM_MILEAGE<2000
  ORDER BY 4 ASC;
      
��뿹)���￡ �����ϴ� ȸ�������� ��ȸ�Ͻÿ�
      Alias�� ȸ����ȣ, ȸ����, �ּ�
 SELECT MEM_ID AS ȸ����ȣ,
        MEM_NAME AS ȸ����,
        MEM_ADD1||' '||MEM_ADD2 AS �ּ�
   FROM C##sy94.MEMBER
  WHERE MEM_ADD1 LIKE '����%'; 
      
��뿹)2020�� 6���� �������� ���� ȸ������ ��ȸ�Ͻÿ�
      Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���
 SELECT MEM_ID AS ȸ����ȣ,
        MEM_NAME AS ȸ����,
        CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN
                  '����ȸ��'
             ELSE '����ȸ��' END AS ����,
        MEM_MILEAGE AS ���ϸ���
   FROM MEMBER
  WHERE MEM_ID NOT IN(SELECT DISTINCT MEM_ID
                        FROM CART
                       WHERE CART_NO LIKE '202006%');
 
3. �������� : NOT, AND, OR(�켱��������)
 - �� �� �̻��� ���ǹ��� ������ ��(AND, OR)
   �Ǵ� ���ǹ��� ����� ������Ű�� ���(NOT)

��뿹)Ű����� �⵵�� �Է¹޾� ����� ����� ��ȸ�Ͻÿ�
      ����: (4�ǹ���̸� �׸��� 100�� ����� �ƴϰų�) �Ǵ� 
            (400�� ����� �Ǵ� ��)
 ACCEPT P_YEAR PROMPT '�⵵�Է�(YYYY) : '
 DECLARE
   L_YEAR NUMBER:=&P_YEAR;
   L_RESULT VARCHAR2(100);
 BEGIN
   IF(MOD(L_YEAR,4)=0 AND MOD(L_YEAR,100)!=0) OR--MOD:������
     (MOD(L_YEAR,400)=0) THEN
    L_RESULT:=L_YEAR||'���� �����Դϴ�!'; 
   ELSE
    L_RESULT:=L_YEAR||'���� ����Դϴ�!';  
   END IF;--����Ŭ���� �߰�ȣ�� ������ ��ɹ����� ����
   DBMS_OUTPUT.PUT_LINE(L_RESULT);--_LINE �ٹٲ�
  END;
��뿹) ���ϸ����� 2000�̻��̸鼭 ������ �ֺ��� ȸ�������� ��ȸ�Ͻÿ�
       Alias�� ȸ����ȣ, ȸ����, ���� ,���ϸ���
 SELECT MEM_ID AS ȸ����ȣ, 
        MEM_NAME AS ȸ����, 
        MEM_JOB AS ����,
        MEM_MILEAGE AS ���ϸ���
   FROM MEMBER
  WHERE MEM_MILEAGE>=2000 --���ϸ����� 2000�̻�
    AND MEM_JOB='�ֺ�'; --������ �ֺ�
    
��뿹) �������̺��� 2020�� 2�� ���������� ��ȸ�Ͻÿ�
       ALais�� ��¥, ��ǰ�ڵ�, ���Լ���
 SELECT BUY_DATE AS ��¥, --������ ��Ÿ���� AND���
        PROD_ID AS ��ǰ�ڵ�, 
        BUY_QTY AS ���Լ���
   FROM BUYPROD
  WHERE BUY_DATE>='20200201' AND BUY_DATE<=LAST_DAY('20200201') 
  ORDER BY 1;
  --�켱 ������ ������Ÿ���� �����(����,��¥,���ڷ� �켱����)
  
��뿹) HR������ ������̺��� �Ի����� 2015�� ���� �̰ų� �޿��� 15000�̻���
      ����� �����ȣ,�����,�Ի���,�޿�,�μ��ڵ带 ����ϵ� �μ������� ���
 SELECT EMPLOYEE_ID AS �����ȣ,
        EMP_NAME AS �����,
        HIRE_DATE AS �Ի���,
        SALARY AS �޿�,
        DEPARTMENT_ID AS �μ��ڵ�
   FROM C##HR.EMPLOYEES
  WHERE HIRE_DATE>'20151231' OR SALARY>=15000
  ORDER BY 5;

��뿹) ������ �����ϴ� ����ȸ�������� ��ȸ�Ͻÿ�
       Alias�� ȸ����ȣ, ȸ����, �ֹε�Ϲ�ȣ, �ּ�
 SELECT MEM_ID AS ȸ����ȣ, 
        MEM_NAME AS ȸ����, 
        MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹε�Ϲ�ȣ, 
        MEM_ADD1||' '||MEM_ADD2 AS �ּ�
   FROM MEMBER
  WHERE MEM_ADD1 LIKE '����%' --��������
--  AND SUBSTR(MEM_REGNO2,1,1) IN('2','4'); --����
    AND (SUBSTR(MEM_REGNO2,1,1)='2' OR SUBSTR(MEM_REGNO2,1,1)='4');
