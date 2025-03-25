2025-0228-02) PL/SQL

 1. 익명블록(Anonymous Block)
  - PL/SQL의 기본구조 제공
  - 이름이 없어 저장할 수 없으며 실행이 필요한 경우 반복적으로
    컴파일하여 실행 해야함
 (기본구조)
   DECLARE
    선언영역: 변수, 상수, 커서 선언
   BEGIN
    실행영역: 비지니스 로직을 SQL명령으로 처리
     :
    [EXCEPTION
         WHEN OTHERS THEN
              예외처리명령;]
   END;
   
사용예)
  ACCEPT P_DEPT_ID PROMPT '부서번호(10~110) : '
  --키보드로부터 입력받은 값을 P_EDPT_ID에 넣는다
  DECLARE   --변수의 갯수는 적어도 출력될 컬럼의 갯수는 포함한다
    L_EID C##HR.EMPLOYEES.EMPLOYEE_ID%TYPE; --FOR문을 쓰면 생략 가능
    L_NAME VARCHAR2(100);
    L_HDATE DATE;
    L_SAL  NUMBER:=0; --넘버는 반드시 초기화
     CURSOR cur_emp(DID C##HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
    IS
      SELECT EMPLOYEE_ID,EMP_NAME,HIRE_DATE,SALARY
        FROM C##HR.EMPLOYEES
       WHERE DEPARTMENT_ID=DID;
  BEGIN
    OPEN cur_emp(&P_DEPT_ID);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('사원번호   사원명                입사일      급여 ');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    LOOP --자바의 DO문
      FETCH cur_emp INTO L_EID,L_NAME,L_HDATE,L_SAL;
      --CURSOR에 있는것을 한줄단위로 읽는다
       EXIT WHEN cur_emp%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('  '||L_EID||'    '||RPAD(L_NAME,20)||L_HDATE||TO_CHAR(L_SAL,'999,999'));                   
     DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    END LOOP;  
    DBMS_OUTPUT.PUT_LINE('합계 : '||cur_emp%ROWCOUNT);
    CLOSE cur_emp;
    
    EXCEPTION 
       WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('에러발생 : '||SQLERRM);
  END;
   
   
   
   
   