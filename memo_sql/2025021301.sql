2025_0213_01) �����Լ�
  - �������Լ�(ABS,SIGN,POWER,SQRT,LOG,...)
  - ROUND,TRUNC
  - FLOOR,CEIL
  - GREATEST, LEAST
  - MOD
  
��뿹)
  SELECT ABS(90), ABS(-0.999),
         SIGN(20000), SIGN(-0.00009),
         TRUNC(SQRT(3.3),3),
         POWER(2,10)
    FROM DUAL;     
    
��뿹)������̺��� ���������� ���� ���ʽ��� ���Ͽ� ����Ͻÿ�
     ��, ���������� �ִ� ����� ����ϸ� ���ʽ��� �ݿø��Ͽ� �Ҽ�1�ڸ����� ���
     ���ʽ�=�⺻��(SALARY)*��������(COMMISSION_PCT)
     Alias�� �����ȣ,�����,�μ���ȣ,��������,���ʽ�
  SELECT EMPLOYEE_ID AS �����ȣ,
         EMP_NAME AS �����,
         DEPARTMENT_ID AS �μ���ȣ,
         COMMISSION_PCT AS ��������,
         ROUND(SALARY*COMMISSION_PCT,1) AS ���ʽ�
    FROM C##HR.EMPLOYEES
   WHERE COMMISSION_PCT IS NOT NULL; --NULL�� ��� �ݵ�� IS�� �̿��ؾ���
   
��뿹)ȸ�����̺��� �� ȸ���� ���ɴ븦 ��ȸ�Ͻÿ� ���̴� ���������
     �̿��Ͽ� ���Ͻÿ�
  SELECT MEM_NAME,
         EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS ����,
         LPAD(TRUNC((EXTRACT(YEAR FROM SYSDATE)-
                     EXTRACT(YEAR FROM MEM_BIR))/10)*10||'��',5) AS ���ɴ�
    FROM MEMBER;     
    
-- GREATEST/LEAST
  SELECT GREATEST(100,500,20),
         GREATEST('ȫ�浿','ȫ���','ȫ����'),
         LEAST('���ѹα�','KOREA','!!!@@'),
         ASCII('��'),ASCII('K'),ASCII('!')
    FROM DUAL;     
     
[����] ȸ�����̺��� ���ϸ����� 1000�̸��� ȸ���� ���ϸ����� 1000����, 1000�̻��� ȸ����
     ���ϸ����� �״�� ����Ͻÿ�
     Alisa�� ȸ����ȣ,ȸ����,�������ϸ���,���渶�ϸ���
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_MILEAGE AS �������ϸ���,
         GREATEST(MEM_MILEAGE,1000) AS ���渶�ϸ���
    FROM MEMBER;
     
