2025-0313-03)
 ��� UPDATE-�԰�Ǿ����� 
 
  CREATE OR REPLACE TRIGGER tg_change_buyprod
    AFTER INSERT OR UPDATE OR DELETE ON BUYPROD
    FOR EACH ROW
  DECLARE
    L_QTY NUMBER:=0;
    L_PROD_ID PROD.PROD_ID%TYPE;
    L_DATE DATE;
  BEGIN
    IF INSERTING THEN
       L_QTY:=(:NEW.BUY_QTY);
       L_PROD_ID:=(:NEW.PROD_ID);
       L_DATE:=:NEW.BUY_DATE;
    ELSIF UPDATING THEN
       L_QTY:=(:NEW.BUY_QTY-:OLD.BUY_QTY);
       L_PROD_ID:=(:NEW.PROD_ID);
       L_DATE:=(:NEW.BUY_DATE);
    ELSIF DELETING THEN 
       L_QTY:=(-:OLD.BUY_QTY);
       L_PROD_ID:=(:OLD.PROD_ID);
       L_DATE:=(:OLD.BUY_DATE);
    
   END IF;
  
   UPDATE REMAIN
      SET REMAIN_I=REMAIN_I+L_QTY,
          REMAIN_J_99=REMAIN_J_99+L_QTY,
          REMAIN_DATE=L_DATE
    WHERE PROD_ID=L_PROD_ID;
  END; 
  
  [����] ������ 2020�� 6�� 13���̶�� �ϰ� �����ڷḦ �����Ͽ���
        �̸� ó���Ͻÿ�
--------------------------------------
  ��ǰ�ڵ�           ���Լ���
--------------------------------------
  P201000005         50
                   ����  ���� ���� �����  
2020	P201000005	9	88	4	93	2020/07/12  
                       138  4   143  2020/06/13
2020	P201000005	9	138	4	143	2020/06/13
                       
   INSERT INTO BUYPROD VALUES(TO_DATE('20200613'),'P201000005',50);     
   
 **���Լ����� 30���� ����
   2020	P201000005	9	138	4	143	2020/06/13
                    9   118 4   123 2020/06/13
   2020	P201000005	9	118	4	123	2020/06/13                 
   UPDATE BUYPROD
      SET BUY_QTY=30
    WHERE PROD_ID='P201000005'
      AND BUY_DATE = TO_DATE('20200613');
 
 **��� ��ǰ : �ڷ����
   DELETE FROM BUYPROD
    WHERE PROD_ID='P201000005'
      AND BUY_DATE = TO_DATE('20200613');
      
    2020	P201000005	9	88	4	93	2020/06/13
     