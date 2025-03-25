2025-0228-03) 분기명령
1. IF문
 - 두 방향으로 제어를 분기시킬 때 사용
(사용형식 1)
 IF 조건1 THEN
    명령1;
 [ELSIF 조건2 THEN
    명령2;  
     :
 ELSE 명령n;]
 END IF;
 
(사용형식 2)
  IF 조건1 THEN
    [IF 조건2 THEN
        명령2;  
    ELSE 
        명령3;
    END IF;]
  ELSE
    명령n;
  END IF;
  
사용예)키보드로 점수하나를 입력 받아 그 값이
      90 ~ 94 : A-
      95 ~ 100 : A+
      80 ~ 84 : B-
      85 ~ 89 : B+
      0  ~ 79 : FAIL을 처리하는 블록을 작성하시오
      
  ACCEPT P_SCORE PROMPT '점수 입력(0 ~100) : '
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
    L_RESULT:=L_SCORE||'의 평점은 '||L_RESULT||'입니다'; 
    
    DBMS_OUTPUT.PUT_LINE(L_RESULT);
  END;
      
      
  ACCEPT P_SCORE PROMPT '점수 입력(0 ~100) : '
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
    L_RESULT:=L_SCORE||'의 평점은 '||L_RESULT||'입니다'; 
    DBMS_OUTPUT.PUT_LINE(L_RESULT);
  END;
  
  
2. 다중분기문 : CASE WHEN ~ THEN, DECODE  
 2-1) CASE WHEN ~ THEN
  사용형식 1)
   CASE 수식|컬럼 WHEN 값1  THEN 명령1;
                WHEN 값2  THEN 명령2;
                        :
                ELSE
                    명령n;
   END CASE;                 
사용예) 회원 테이블에서 회원들이 보유한 마일리지를 참조하여 그 값이
  0    ~ 3000점 : 새싹회원
  3001 ~ 5000점 : 보통회원
  5001 ~ 8000점 : VIP회원
  그 이상 VVIP회원을 비고난에 출력하시오. 출력은 회원번호,회원명,마일리지, 비고이다
  
  SELECT MEM_ID AS 회원번호,
         MEM_NAME AS 회원명,
         MEM_MILEAGE AS 마일리지, 
         CASE SUBSTR(MEM_REGNO2,1,1) WHEN '1' THEN '남성회원'
                                     WHEN '2' THEN '여성회원'
                                     WHEN '3' THEN '남성회원'
                                     WHEN '4' THEN '여성회원'
         END AS 성별,    
         
         CASE WHEN MEM_MILEAGE<=3000 THEN '새싹회원'
              WHEN MEM_MILEAGE<=5000 THEN '보통회원'
              WHEN MEM_MILEAGE<=8000 THEN 'VIP회원'
              ELSE 'VVIP회원'
         END AS 비고
    FROM MEMBER;
    
  
  DECLARE
    CURSOR CUR_MEMBER01 IS 
      SELECT MEM_ID,MEM_NAME,MEM_MILEAGE
        FROM MEMBER; 
    L_BIGO VARCHAR2(50);  
  BEGIN
    FOR REC IN CUR_MEMBER01 LOOP
         CASE WHEN REC.MEM_MILEAGE<=3000 THEN L_BIGO:='새싹회원';
              WHEN REC.MEM_MILEAGE<=5000 THEN L_BIGO:='보통회원';
              WHEN REC.MEM_MILEAGE<=8000 THEN L_BIGO:='VIP회원';
              ELSE L_BIGO:='VVIP회원';
         END CASE;
         DBMS_OUTPUT.PUT_LINE(REC.MEM_ID||'  '||RPAD(REC.MEM_NAME,7)||
                              TO_CHAR(REC.MEM_MILEAGE,'9,999')||'  '||L_BIGO);
    END LOOP;
  END;
  
  
 2-2) DECODE
 - SQL에서만 사용하고 PL/SQL에서는 사용할 수 없어 CASE문을 사용해야 함
 
 사용형식)
  DECODE(컬럼, 조건1, 결과1, [조건2, 결과2, ...] 결과n);
  SELECT MEM_ID,
         MEM_NAME,
         MEM_MILEAGE, 
         DECODE (SUBSTR(MEM_REGNO2,1,1),'1','남성회원',
                                        '2','여성회원',
                                        '3','남성회원',
                                        '4','여성회원',
                                        '데이터오류') AS 비고
        FROM MEMBER;
  