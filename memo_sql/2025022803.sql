2025-0228-03) �б���
1. IF��
 - �� �������� ��� �б��ų �� ���
(������� 1)
 IF ����1 THEN
    ���1;
 [ELSIF ����2 THEN
    ���2;  
     :
 ELSE ���n;]
 END IF;
 
(������� 2)
  IF ����1 THEN
    [IF ����2 THEN
        ���2;  
    ELSE 
        ���3;
    END IF;]
  ELSE
    ���n;
  END IF;
  
��뿹)Ű����� �����ϳ��� �Է� �޾� �� ����
      90 ~ 94 : A-
      95 ~ 100 : A+
      80 ~ 84 : B-
      85 ~ 89 : B+
      0  ~ 79 : FAIL�� ó���ϴ� ����� �ۼ��Ͻÿ�
      
  ACCEPT P_SCORE PROMPT '���� �Է�(0 ~100) : '
  DECLARE
    L_SCORE NUMBER:=(&P_SCORE);
    L_RESULT VARCHAR2(50);
  BEGIN
    IF L_SCORE >= 95 THEN
       L_RESULT:='A+';
    ELSIF L_SCORE >= 90 THEN
       L_RESULT:='A-'; 
    ELSIF L_SCORE >= 85 THEN
       L_RESULT:='B+'; 
    ELSIF L_SCORE >= 80 THEN
       L_RESULT:='B-'; 
    ELSE
       L_RESULT:='FAIL';    
    END IF;   
    L_RESULT:=L_SCORE||'�� ������ '||L_RESULT||'�Դϴ�'; 
    
    DBMS_OUTPUT.PUT_LINE(L_RESULT);
  END;
      
      
  ACCEPT P_SCORE PROMPT '���� �Է�(0 ~100) : '
  DECLARE
    L_SCORE NUMBER:=(&P_SCORE);
    L_RESULT VARCHAR2(50);
  BEGIN
    IF TRUNC(L_SCORE/10) =10 THEN
       L_RESULT:='A+';
    ELSIF TRUNC(L_SCORE/10) = 9 THEN
          L_RESULT := 'A';
          IF MOD(L_SCORE,10) >= 5 THEN
             L_RESULT := L_RESULT||'+';
          ELSE   
             L_RESULT := L_RESULT||'-';
          END IF;   
    ELSIF TRUNC(L_SCORE/10) = 8 THEN
          L_RESULT := 'B';
          IF MOD(L_SCORE,10) >= 5 THEN
             L_RESULT := L_RESULT||'+';
          ELSE   
             L_RESULT := L_RESULT||'-';
          END IF;   
       ELSE
          L_RESULT := 'FAIL';
          END IF;
    L_RESULT:=L_SCORE||'�� ������ '||L_RESULT||'�Դϴ�'; 
    DBMS_OUTPUT.PUT_LINE(L_RESULT);
  END;
  
  
2. ���ߺб⹮ : CASE WHEN ~ THEN, DECODE  
 2-1) CASE WHEN ~ THEN
  ������� 1)
   CASE ����|�÷� WHEN ��1  THEN ���1;
                WHEN ��2  THEN ���2;
                        :
                ELSE
                    ���n;
   END CASE;                 
��뿹) ȸ�� ���̺��� ȸ������ ������ ���ϸ����� �����Ͽ� �� ����
  0    ~ 3000�� : ����ȸ��
  3001 ~ 5000�� : ����ȸ��
  5001 ~ 8000�� : VIPȸ��
  �� �̻� VVIPȸ���� ����� ����Ͻÿ�. ����� ȸ����ȣ,ȸ����,���ϸ���, ����̴�
  
  SELECT MEM_ID AS ȸ����ȣ,
         MEM_NAME AS ȸ����,
         MEM_MILEAGE AS ���ϸ���, 
         CASE SUBSTR(MEM_REGNO2,1,1) WHEN '1' THEN '����ȸ��'
                                     WHEN '2' THEN '����ȸ��'
                                     WHEN '3' THEN '����ȸ��'
                                     WHEN '4' THEN '����ȸ��'
         END AS ����,    
         
         CASE WHEN MEM_MILEAGE<=3000 THEN '����ȸ��'
              WHEN MEM_MILEAGE<=5000 THEN '����ȸ��'
              WHEN MEM_MILEAGE<=8000 THEN 'VIPȸ��'
              ELSE 'VVIPȸ��'
         END AS ���
    FROM MEMBER;
    
  
  DECLARE
    CURSOR CUR_MEMBER01 IS 
      SELECT MEM_ID,MEM_NAME,MEM_MILEAGE
        FROM MEMBER; 
    L_BIGO VARCHAR2(50);  
  BEGIN
    FOR REC IN CUR_MEMBER01 LOOP
         CASE WHEN REC.MEM_MILEAGE<=3000 THEN L_BIGO:='����ȸ��';
              WHEN REC.MEM_MILEAGE<=5000 THEN L_BIGO:='����ȸ��';
              WHEN REC.MEM_MILEAGE<=8000 THEN L_BIGO:='VIPȸ��';
              ELSE L_BIGO:='VVIPȸ��';
         END CASE;
         DBMS_OUTPUT.PUT_LINE(REC.MEM_ID||'  '||RPAD(REC.MEM_NAME,7)||
                              TO_CHAR(REC.MEM_MILEAGE,'9,999')||'  '||L_BIGO);
    END LOOP;
  END;
  
  
 2-2) DECODE
 - SQL������ ����ϰ� PL/SQL������ ����� �� ���� CASE���� ����ؾ� ��
 
 �������)
  DECODE(�÷�, ����1, ���1, [����2, ���2, ...] ���n);
  SELECT MEM_ID,
         MEM_NAME,
         MEM_MILEAGE, 
         DECODE (SUBSTR(MEM_REGNO2,1,1),'1','����ȸ��',
                                        '2','����ȸ��',
                                        '3','����ȸ��',
                                        '4','����ȸ��',
                                        '�����Ϳ���') AS ���
        FROM MEMBER;
  