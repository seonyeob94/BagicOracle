2025-0228-04)반복문
  LOOP, WHILE, FOR문이 제공
 - 주로 커서처리에 사용 
1) LOOP
 - 반복문의 기본 구조 제공
 - 무한 반복 제공
 사용형식)
  LOOP
     반복문;
    [EXIT WHEN 조건;]
  END LOOP;
  . 'EXIT WHEN 조건'의 조건이 참이면 제어가 END LOOP다음 문장으로 이동
  
사용예) 구구단의 7단을 출력하시오
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
 - 넓은 의미로 SQL명령에 영향을 받은 행들의 집합
 - 좁은 의미의 커서는 SELECT문의 결과 집합
 - 묵시적 커서
   . 이름이 부여되지 않은 커서
   . SELECT문의 결과가 출력될 때 OPEN되고 출력이 종료되면 CLOSE 됨
   . 커서 내부 접근이 불가능(항상 CLOSE상태)
   . 커서속성
   ------------------------------------------------
    커서속성         내용
   ------------------------------------------------
   SQL%ISOPEN     커서가 OPEN 상태이면 참을 반환
   SQL%FOUND      커서내에 자료가 하나라도 있으면 참
   SQL%NOTFOUND   커서내에 자료가 하나도 없으면 참
   SQL%ROWCOUNT   커서내의 자료의 갯수(행의 수)
   
 - 명시적 커서
   . 이름이 부여된 커서
   . 커서생성(선언영역) -> OPEN (실행영역) -> FETCH(반복문 안에서 처리)--FETCH는  READ로 보면 된다
     -> CLOSE(반복문 밖에서 처리)
   . 커서속성
   ------------------------------------------------
    커서속성          내용
   ------------------------------------------------
   커서명%ISOPEN     커서가 OPEN 상태이면 참을 반환
   커서명%FOUND      커서내에 자료가 하나라도 있으면 참
   커서명%NOTFOUND   커서내에 자료가 하나도 없으면 참
   커서명%ROWCOUNT   커서내의 자료의 갯수(행의 수)
   
  (1) 커서 생성
    - 선언영역에서 기술
  (선언형식)
    CURSOR 커서명[(변수 타입,...)] 
    IS
      SELECT 문;
    . '변수 타입' : 타입의 크기를 선언해서는 안됨
    . '변수 타입' : 변수에 값을 할당하는 곳은 OPEN문에서 제공
    
  (2) OPEN
    - 실행영역에서 수행
  (선언형식)
    OPEN 커서명[(값,...)];
    . '(값,...)' : 커서 생성문에 전달될 값 
    
  (3) FETCH
    - 실행영역의 반복문 내부에서 주로 사용
    - 커서 내부의 데이터를 행단위로 읽어옴
  (선언형식)
    FETCH 커서명 INTO 변수명,...;
    . 커서 내부의 데이터를 행단위로 읽어서 변수에 차례대로 저장
    . 커서의 열의 수와 변수의 수는 일치하고 순서도 같아야 한다 
    
사용예)충남에 거주하는 회원들의 2020년 5월 구매현황을 조회하시오.
     Alias는 회원번호,회원명,구매금액합계
     
  DECLARE
   L_MID MEMBER.MEM_ID%TYPE;
   L_NAME VARCHAR2(100);
   L_SUM NUMBER:=0;
   
   CURSOR CUR_MEMBER02 IS 
     SELECT MEM_ID, MEM_NAME 
       FROM MEMBER
      WHERE MEM_ADD1 LIKE '충남%'; 
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
      DBMS_OUTPUT.PUT_LINE('회원번호 : '||L_MID); 
      DBMS_OUTPUT.PUT_LINE('회원명 : '||L_NAME); 
      DBMS_OUTPUT.PUT_LINE('구매금액 : '||L_SUM);
    END LOOP;
    CLOSE CUR_NUMBER02;
  END;










