2025-0227-01) VIEW
 - ������ ���̺�
 - Ư�� �ڷῡ ���� ������ ����
 - ���� ���̺� �л� ����� �ڷḦ ���� ��ȸ�� ��
 - �� ���̺��� �κ������� �ڷḦ ��ȸ�� ��
 
�������)
  CREATE [OR REPLACE] VIEW ���̸�[(�÷�list)]
  AS
    SELECT ��
    [WITH CHECK OPTION]
    [WITH READ ONLY]
    
 - �並 �����ϴ� �������̺��� �信 ������� CRUD �����ϸ�, �� ����� ���
   �信 �����
 - WITH CHECK OPTION �̳� WITH READ ONLY �ɼ��� ������� �ʰ� ������
   ���� ������ �������̺��� �����Ŵ
 
��뿹) ȸ�����̺��� ���ϸ����� 3000�̻��� ȸ������ ȸ����ȣ, ȸ����,���ϸ�����
       �並 �����Ͻÿ�
  
  CREATE OR REPLACE VIEW V_MEM_MILEAGE
  AS       
  SELECT MEM_ID, 
         MEM_NAME,
         MEM_MILEAGE
    FROM MEMBER
   WHERE MEM_MILEAGE>=3000; 
   
  SELECT * FROM V_MEM_MILEAGE; 
  
��뿹)�� V_MEM_MILEAGE���� ȸ����ȣ 'e001'ȸ���� ���������� 8000���� ����
  UPDATE V_MEM_MILEAGE
     SET MEM_MILEAGE=8000
   WHERE MEM_ID='e001';  
   
��뿹)MEMBER���̺��� ȸ����ȣ 'e001'ȸ���� ���������� 2000���� ����
  UPDATE MEMBER
     SET MEM_MILEAGE=2000
   WHERE MEM_ID='e001'; --�� ���������� ���ϸ��� 2000�̻��̾����Ƿ� ������ �޼����� ���� Ż��

   
  CREATE OR REPLACE VIEW V_MEM_MILEAGE
  AS       
  SELECT MEM_ID, 
         MEM_NAME,
         MEM_MILEAGE
    FROM MEMBER
   WHERE MEM_MILEAGE>=3000
    WITH CHECK OPTION;
   
  SELECT * FROM V_MEM_MILEAGE;
   
��뿹)MEMBER���̺��� ȸ����ȣ 'e001'ȸ���� ���������� 2000���� ����
  UPDATE MEMBER
     SET MEM_MILEAGE=2000
   WHERE MEM_ID='e001';
   
   
��뿹)V_MEM_MILEAGE �信�� ȸ����ȣ 'k001'ȸ���� ���������� 2000���� ����
  UPDATE V_MEM_MILEAGE
     SET MEM_MILEAGE=2000
   WHERE MEM_ID='k001';
   --WITH CHECK OPTION ���ǿ� ����Ǹ� ���� �ȵ�
   
��뿹)V_MEM_MILEAGE �信�� ȸ����ȣ 'k001'ȸ���� ���������� 6700���� ����
  UPDATE V_MEM_MILEAGE
     SET MEM_MILEAGE=6700
   WHERE MEM_ID='k001';
   
  SELECT MEM_ID,MEM_MILEAGE
    FROM MEMBER
   WHERE MEM_ID='k001'; 
   
   