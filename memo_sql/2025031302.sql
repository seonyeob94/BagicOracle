2025-0313-02)Ʈ����
 - �� ���̺� �߻��� DML�̺�Ʈ�� ���Ͽ� �ٸ� ���̺� �߻��ϴ�
   ������ �ڵ����� �����ϴ� Ư�� ���ν���
   
�������)
  CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    {BEFORE|AFTER}  {INSERT|UPDATE|DELETE} ON ���̺��
    [FOR EACH ROW]
    [WHEN ����]
  [DECLARE]
    ���𿵿�(����,���,Ŀ�� ����)
  BEGIN
    Ʈ���� ����
  END;
  . 'BEFORE|AFTER' : Ʈ���� Ÿ�̹� - Ʈ���� ������ ����Ǵ� ����
  . 'NSERT|UPDATE|DELETE' : �̺�Ʈ�� ����(OR������ ��밡��)
  . 'FOR EACH ROW' : ����� Ʈ����(�����ϸ� ������� Ʈ����)
  . 'WHEN ����' : ����� Ʈ���ſ����� ��� ����. Ʈ���� �߻� ������ ���� 
                 ��ü������ ���
----����� Ʈ���ſ����� ���                
1) Ʈ���� �Լ�
----------------------------------------
    �Լ���      �ǹ�
----------------------------------------
 INSERTING    �̺�Ʈ�� INSERT�̸� TRUE
 UPDATING     �̺�Ʈ�� UPDATE�̸� TRUE
 DELETING     �̺�Ʈ�� DELETE�̸� TRUE

2) �ǻ� ���ڵ�
--------------------------------------------------
 �ǻ緹�ڵ�   �ǹ�
--------------------------------------------------
   :NEW     �̺�Ʈ�� INSERT�� UPDATE�� ��� ���
            ���Ӱ� �ԷµǴ� �ڷḦ ��Ī
            DELETE���� ����ϸ� ��� �÷��� NULL��
            
   :OLD     �̺�Ʈ�� DELETE�� UPDATE�� ��� ���
            ����Ǿ��ִ� �ڷḦ ��Ī
            INSERT���� ����ϸ� ��� �÷��� NULL��
--------------------------------------------------

��뿹) HR������ ������̺�(EMP)���� 60�� �μ��� ���� ������� �����Ͻÿ�.
       ���� �� '�ڷ� ���� ����'�̶�� �޼����� ����ϴ� Ʈ���� �ۼ�

  CREATE OR REPLACE TRIGGER tg_del_emp
    AFTER DELETE ON EMP
  BEGIN
    DBMS_OUTPUT.PUT_LINE('�ڷ� ���� ����');
  END;
  
 
��뿹)������̺�(EMP)���� �Ի����� 2020.06.30 �� ������� �����Ͻÿ�
      �����Ǵ� �ڷ�� RETIRE ���̺� �����Ͻÿ�
   
  CREATE OR REPLACE TRIGGER tg_del_emp
    BEFORE DELETE ON EMP
    FOR EACH ROW
  DECLARE 
    --L_CNT NUMBER:=0;
  BEGIN
    INSERT INTO RETIRE 
       VALUES(:OLD.EMPLOYEE_ID,:OLD.DEPARTMENT_ID,SYSDATE);
  END;
  
  SELECT * 
    FROM EMP
   WHERE HIRE_DATE <= TO_DATE('20200630'); 
 
   DELETE FROM EMP WHERE HIRE_DATE <= TO_DATE('20200630'); 
   
   SELECT * FROM RETIRE;
   