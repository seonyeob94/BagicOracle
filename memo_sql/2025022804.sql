2025-0228-04)�ݺ���
  LOOP, WHILE, FOR���� ����
 - �ַ� Ŀ��ó���� ��� 
1) LOOP
 - �ݺ����� �⺻ ���� ����
 - ���� �ݺ� ����
 �������)
  LOOP
     �ݺ���;
    [EXIT WHEN ����;]
  END LOOP;
  . 'EXIT WHEN ����'�� ������ ���̸� ��� END LOOP���� �������� �̵�
  
��뿹) �������� 7���� ����Ͻÿ�
  DECLARE 
    L_CNT NUMBER:=1;
  BEGIN
    LOOP
      DBMS_OUTPUT.PUT_LINE('7*'||L_CNT||' = '||7*L_CNT);
      EXIT WHEN L_CNT>=9;
      L_CNT:=L_CNT+1;
    END LOOP;
  END; 

** CURSOR
 - ���� �ǹ̷� SQL��ɿ� ������ ���� ����� ����
 - ���� �ǹ��� Ŀ���� SELECT���� ��� ����
 - ������ Ŀ��
   . �̸��� �ο����� ���� Ŀ��
   . SELECT���� ����� ��µ� �� OPEN�ǰ� ����� ����Ǹ� CLOSE ��
   . Ŀ�� ���� ������ �Ұ���(�׻� CLOSE����)
   . Ŀ���Ӽ�
   ------------------------------------------------
    Ŀ���Ӽ�         ����
   ------------------------------------------------
   SQL%ISOPEN     Ŀ���� OPEN �����̸� ���� ��ȯ
   SQL%FOUND      Ŀ������ �ڷᰡ �ϳ��� ������ ��
   SQL%NOTFOUND   Ŀ������ �ڷᰡ �ϳ��� ������ ��
   SQL%ROWCOUNT   Ŀ������ �ڷ��� ����(���� ��)
   
 - ����� Ŀ��
   . �̸��� �ο��� Ŀ��
   . Ŀ������(���𿵿�) -> OPEN (���࿵��) -> FETCH(�ݺ��� �ȿ��� ó��)--FETCH��  READ�� ���� �ȴ�
     -> CLOSE(�ݺ��� �ۿ��� ó��)
   . Ŀ���Ӽ�
   ------------------------------------------------
    Ŀ���Ӽ�          ����
   ------------------------------------------------
   Ŀ����%ISOPEN     Ŀ���� OPEN �����̸� ���� ��ȯ
   Ŀ����%FOUND      Ŀ������ �ڷᰡ �ϳ��� ������ ��
   Ŀ����%NOTFOUND   Ŀ������ �ڷᰡ �ϳ��� ������ ��
   Ŀ����%ROWCOUNT   Ŀ������ �ڷ��� ����(���� ��)
   
  (1) Ŀ�� ����
    - ���𿵿����� ���
  (��������)
    CURSOR Ŀ����[(���� Ÿ��,...)] 
    IS
      SELECT ��;
    . '���� Ÿ��' : Ÿ���� ũ�⸦ �����ؼ��� �ȵ�
    . '���� Ÿ��' : ������ ���� �Ҵ��ϴ� ���� OPEN������ ����
    
  (2) OPEN
    - ���࿵������ ����
  (��������)
    OPEN Ŀ����[(��,...)];
    . '(��,...)' : Ŀ�� �������� ���޵� �� 
    
  (3) FETCH
    - ���࿵���� �ݺ��� ���ο��� �ַ� ���
    - Ŀ�� ������ �����͸� ������� �о��
  (��������)
    FETCH Ŀ���� INTO ������,...;
    . Ŀ�� ������ �����͸� ������� �о ������ ���ʴ�� ����
    . Ŀ���� ���� ���� ������ ���� ��ġ�ϰ� ������ ���ƾ� �Ѵ� 
    
��뿹)�泲�� �����ϴ� ȸ������ 2020�� 5�� ������Ȳ�� ��ȸ�Ͻÿ�.
     Alias�� ȸ����ȣ,ȸ����,���űݾ��հ�
     
  DECLARE
   L_MID MEMBER.MEM_ID%TYPE;
   L_NAME VARCHAR2(100);
   L_SUM NUMBER:=0;
   
   CURSOR CUR_MEMBER02 IS 
     SELECT MEM_ID, MEM_NAME 
       FROM MEMBER
      WHERE MEM_ADD1 LIKE '�泲%'; 
  BEGIN
    OPEN CUR_NUMBER02;
    LOOP
      FETCH CUR_NUMBER02 INTO L_MID,L_NAME;
      EXIT WHEN CUR_NUMBER02%NOTFOUND;
      SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO L_SUM
        FROM CART A, PROD B
       WHERE A.PROD_ID=B.PROD_ID
         AND A.CART_NO LIKE '202005%'
         AND A.MEM_ID=L_MID;
      DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||L_MID); 
      DBMS_OUTPUT.PUT_LINE('ȸ���� : '||L_NAME); 
      DBMS_OUTPUT.PUT_LINE('���űݾ� : '||L_SUM);
    END LOOP;
    CLOSE CUR_NUMBER02;
  END;










