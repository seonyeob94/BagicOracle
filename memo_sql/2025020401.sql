2025-0204-01) ����� ����

2. ���Ѻο�
 - ����Ŭ���� �⺻������ �����ϴ� ������ ����(Roll) ���
 - connect, resource, dba
 �������)
  Grant ���Ѹ�|���̸�,... to ������;
  
  ��뿹)
  grant connect, resource, dba to c##sy94;
  
  1. ����� ����
 - create ��ɻ��
 �������)
  create user ����ڸ� Identified by ��ȣ;
  . ����ڸ�, ��ȣ : - ����� ���Ǿ� ���
                   - ù ���ڴ� ����, �� ���Ŀ��� ����, ����, Ư������( , $) ��밡��
                   - ���ڼ��� ���� ����
                   
��뿹)
 create user c##sy94 identified by java;
 
 
 ** HR�������� �� �����ڿ� �߰�
  create user c##HR identified by java;
  grant connect, resource, dba to c##HR;
 
 
 
 
 **practice ���� ���� �� ���
  create user c##practice identified by java;
  grant connect, resource, dba to c##practice;