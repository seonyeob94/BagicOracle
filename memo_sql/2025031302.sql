2025-0313-02)트리거
 - 한 테이블에 발생된 DML이벤트에 의하여 다른 테이블에 발생하는
   변경을 자동으로 수행하는 특수 프로시져
   
사용형식)
  CREATE [OR REPLACE] TRIGGER 트리거명
    {BEFORE|AFTER}  {INSERT|UPDATE|DELETE} ON 테이블명
    [FOR EACH ROW]
    [WHEN 조건]
  [DECLARE]
    선언영역(변수,상수,커서 선언)
  BEGIN
    트리거 본문
  END;
  . 'BEFORE|AFTER' : 트리거 타이밍 - 트리거 본문이 실행되는 시점
  . 'NSERT|UPDATE|DELETE' : 이벤트의 종류(OR연산자 사용가능)
  . 'FOR EACH ROW' : 행단위 트리거(생략하면 문장단위 트리거)
  . 'WHEN 조건' : 행단위 트리거에서만 사용 가능. 트리거 발생 조건을 좀더 
                 구체적으로 명시
----행단위 트리거에서만 사용                
1) 트리거 함수
----------------------------------------
    함수명      의미
----------------------------------------
 INSERTING    이벤트가 INSERT이면 TRUE
 UPDATING     이벤트가 UPDATE이면 TRUE
 DELETING     이벤트가 DELETE이면 TRUE

2) 의사 레코드
--------------------------------------------------
 의사레코드   의미
--------------------------------------------------
   :NEW     이벤트가 INSERT나 UPDATE인 경우 사용
            새롭게 입력되는 자료를 지칭
            DELETE에서 사용하면 모든 컬럼이 NULL임
            
   :OLD     이벤트가 DELETE나 UPDATE인 경우 사용
            저장되어있는 자료를 지칭
            INSERT에서 사용하면 모든 컬럼이 NULL임
--------------------------------------------------

사용예) HR계정의 사원테이블(EMP)에서 60번 부서에 속한 사원들을 삭제하시오.
       삭제 후 '자료 삭제 성공'이라는 메세지를 출력하는 트리거 작성

  CREATE OR REPLACE TRIGGER tg_del_emp
    AFTER DELETE ON EMP
  BEGIN
    DBMS_OUTPUT.PUT_LINE('자료 삭제 성공');
  END;
  
 
사용예)사원테이블(EMP)에서 입사일이 2020.06.30 전 사원들을 삭제하시오
      삭제되는 자료는 RETIRE 테이블에 저장하시오
   
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
   