2025-0210-02)UPDATE��

��뿹)ORDER_GOODS���̺��� �ֹ���ȣ '202502070001', ��ǰ��ȣ 'P201' �ڷ���
      �ֹ������� 1�� �����Ͻÿ�
  
  UPDATE ORDER_GOODS
     SET ORDER_QTY=1
   WHERE G_ID='P201'
     AND ORDER_NUM='202502070001';
      
  UPDATE ORDERS
     SET ORDER_AMT=28500
   WHERE ORDER_NUM='202502070001';
   
3.DELETE ��
  - �� ������ ����
  - ROLLBACK�� ���
  - �ڽ����̺��� �����ϴ� �θ����̺��� �ڷ�� ������ ������
�������)
  DELETE FROM ���̺��
  [WHERE ����];
  
��뿹)HR������ ������̺��� 90�μ��� ���� ��������� �����Ͻÿ�
  DELETE FROM C##HR.EMPLOYEES
   WHERE DEPARTMENT_ID=90;
   
��뿹)�����������̺�(JOB_HISTORY)���� ������������(START_DATE)R
      2010�� ���� �ڷḦ ��� �����Ͻÿ�
 DELETE FROM C##HR.JOB_HISTORY
  WHERE EXTRACT(YEAR FROM START_DATE) < 2010;
  
  SELECT * FROM C##HR.JOB_HISTORY;
  
  DELETE FROM C##HR.JOB_HISTORY;
  
  ROLLBACK;--��� ROLLBACK��Ű�� ������ COMMIT �������� �ǵ��ư���
  
  COMMIT;