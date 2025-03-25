2025-0210-02)UPDATE문

사용예)ORDER_GOODS테이블에서 주문번호 '202502070001', 상품번호 'P201' 자료의
      주문수량을 1로 변경하시오
  
  UPDATE ORDER_GOODS
     SET ORDER_QTY=1
   WHERE G_ID='P201'
     AND ORDER_NUM='202502070001';
      
  UPDATE ORDERS
     SET ORDER_AMT=28500
   WHERE ORDER_NUM='202502070001';
   
3.DELETE 문
  - 행 단위로 삭제
  - ROLLBACK의 대상
  - 자식테이블에서 참조하는 부모테이블의 자료는 삭제가 거절됨
사용형식)
  DELETE FROM 테이브명
  [WHERE 조건];
  
사용예)HR계정의 사원테이블에서 90부서에 속한 사원정보를 삭제하시오
  DELETE FROM C##HR.EMPLOYEES
   WHERE DEPARTMENT_ID=90;
   
사용예)직무변동테이블(JOB_HISTORY)에서 직무시작일자(START_DATE)R
      2010년 이전 자료를 모두 삭제하시오
 DELETE FROM C##HR.JOB_HISTORY
  WHERE EXTRACT(YEAR FROM START_DATE) < 2010;
  
  SELECT * FROM C##HR.JOB_HISTORY;
  
  DELETE FROM C##HR.JOB_HISTORY;
  
  ROLLBACK;--계속 ROLLBACK시키면 최후의 COMMIT 시점까지 되돌아간다
  
  COMMIT;