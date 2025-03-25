2025-0228-02) PL/SQL

 1. �͸���(Anonymous Block)
  - PL/SQL�� �⺻���� ����
  - �̸��� ���� ������ �� ������ ������ �ʿ��� ��� �ݺ�������
    �������Ͽ� ���� �ؾ���
 (�⺻����)
   DECLARE
    ���𿵿�: ����, ���, Ŀ�� ����
   BEGIN
    ���࿵��: �����Ͻ� ������ SQL������� ó��
     :
    [EXCEPTION
         WHEN OTHERS THEN
              ����ó�����;]
   END;
   
��뿹)
  ACCEPT P_DEPT_ID PROMPT '�μ���ȣ(10~110) : '
  --Ű����κ��� �Է¹��� ���� P_EDPT_ID�� �ִ´�
  DECLARE   --������ ������ ��� ��µ� �÷��� ������ �����Ѵ�
    L_EID C##HR.EMPLOYEES.EMPLOYEE_ID%TYPE; --FOR���� ���� ���� ����
    L_NAME VARCHAR2(100);
    L_HDATE DATE;
    L_SAL  NUMBER:=0; --�ѹ��� �ݵ�� �ʱ�ȭ
     CURSOR cur_emp(DID C##HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
    IS
      SELECT EMPLOYEE_ID,EMP_NAME,HIRE_DATE,SALARY
        FROM C##HR.EMPLOYEES
       WHERE DEPARTMENT_ID=DID;
  BEGIN
    OPEN cur_emp(&P_DEPT_ID);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('�����ȣ   �����                �Ի���      �޿� ');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    LOOP --�ڹ��� DO��
      FETCH cur_emp INTO L_EID,L_NAME,L_HDATE,L_SAL;
      --CURSOR�� �ִ°��� ���ٴ����� �д´�
       EXIT WHEN cur_emp%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('  '||L_EID||'    '||RPAD(L_NAME,20)||L_HDATE||TO_CHAR(L_SAL,'999,999'));                   
     DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    END LOOP;  
    DBMS_OUTPUT.PUT_LINE('�հ� : '||cur_emp%ROWCOUNT);
    CLOSE cur_emp;
    
    EXCEPTION 
       WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('�����߻� : '||SQLERRM);
  END;
   
   
   
   
   