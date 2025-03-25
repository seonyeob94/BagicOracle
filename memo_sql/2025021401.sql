2025_2014_01)형변환 함수
1. TO_CHAR(데이터 [,형식지정문자열])
  - '데이터' : 문자(CHAR, CLOB타입), 숫자, 날짜 타입의 자료를 문자열로 변환
**형식지정문자열 : 변환하려는 문자열 형식을 지정하는 문자
 1) 날짜형식지정 문자열
-----------------------------------------------------------------------------
  문자열         설명           예
-----------------------------------------------------------------------------
AD, BC      기원전/서기       SELECT TO_CHAR(SYSDATE, 'BC YYYY"년"') FROM DUAL; 
 CC            세기          SELECT TO_CHAR(SYSDATE, 'YYYY ":" CC "세기"') FROM DUAL;
YYYY,YYY       년도          
YY,Y,YEAR                   SELECT TO_CHAR(SYSDATE, 'YYYY YYY YY Y YEAR') 
                              FROM DUAL;
MONTH, MON, MM, RM             SELECT TO_CHAR(SYSDATE, 'YYYY MM'),
                                      TO_CHAR(SYSDATE, 'YYYY RM'),
                                      TO_CHAR(SYSDATE, 'YYYY MONTH'),
                                      TO_CHAR(SYSDATE, 'YYYY MON')
                                 FROM DUAL;                 
DD,DDD,J       월            SELECT TO_CHAR(SYSDATE, 'YYYY DD'),
                                    TO_CHAR(SYSDATE, 'YYYY DDD'),
                                    TO_CHAR(SYSDATE, 'YYYY J')
                              FROM DUAL;
AM,  PM
A.M., P.M.                    SELECT TO_CHAR(SYSDATE, 'YYYY AM A.M.'),
                                    TO_CHAR(SYSDATE, 'YYYY PM P.M.')
                                FROM DUAL;
HH,HH12,HH24   시간
MI             분
SS,SSSSS       초              SELECT TO_CHAR(SYSDATE, 'YYYY AM MM DD HH24:MI:SS SSSSS')
                                FROM DUAL;
"문자열"      사용자정의          SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"')
                                FROM DUAL;      
                                
 2) 숫자형식지정 문자열
-----------------------------------------------------------------------------
  문자열         설명           예
-----------------------------------------------------------------------------
   9      유효숫자는 출력,
          무효의 0은 공백처리    SELECT TO_CHAR(2345.7, '99999.99') AS "COL1",
                                    TO_CHAR(345.7, '99,999.99') AS "COL2"
                              FROM DUAL;
   0      유호숫자는 출력
          무효의 0도 0을 출력    SELECT TO_CHAR(2345.7, '00000.00') AS "COL1",
          모든 경우에 "," 출력          TO_CHAR(345.7, '00,000.00') AS "COL2"
                              FROM DUAL;
   $,L   화폐기호를 왼쪽에       
         출력                  SELECT TO_CHAR(2345.7, 'L99999.99') AS "COL1",
                                    TO_CHAR(1345.7, '$99,999.99') AS "COL2"
                              FROM DUAL;
   MI    음수인 경우 '-' 부호를 
         숫자 오른쪽에 출력       SELECT TO_CHAR(2345.7, '99999.99MI') AS "COL1",
                                      TO_CHAR(-1345.7, '99,999.99MI') AS "COL2"  
                                     FROM DUAL;
   PR    음수인 경우 숫자를 
         <>로 묶어 출력          SELECT TO_CHAR(2345.7, '99999.99PR') AS "COL1",
                                      TO_CHAR(-1345.7, '99,999.99PR') AS "COL2"  
                                     FROM DUAL;
                                     
2. TO_NUMBER(데이터 [,형식지정문자열])
 - '데이터'는 문자열 자료로, 숫자로 변환될 수 있는 자료이여야 함
 - '형식지정문자열'이 사용되는 경우는 '데이터'가 자동으로 숫자로 변환될 수 없는 편집된 문자열인 경우 
   그 값을 출력하기 위해 사용된 '형식지정문자열'을 기술해야 한다.
 - '형식지정문자열'은 TO_CHAR에 사용된 숫자형식지정문자열과 동일함 
 
사용예)
 SELECT --TO_NUMBER('P210000'), --에러 변환 불가능한 문자포함('P')
        TO_NUMBER('210000'),
        --TO_NUMBER('210,000'), --에러 변환 불가능한 문자포함(',')
        TO_NUMBER('21.67'),
        TO_NUMBER('210,000','999,999'),
        TO_NUMBER('<210,000>','000,000PR')
   FROM DUAL;     --오른쪽 끝을 맞주면 숫자자료
   
2. TO_DATE(데이터 [,형식지정문자열])
 - '데이터'는 문자열 또는 숫자 자료로, 날짜로 변환될 수 있는 형식을 갖춘 자료이여야 함
   ex)년월일, 년월일시분초
 - '형식지정문자열'이 사용되는 경우는 '데이터'가 자동으로 날짜로 자동 변환될 수 없는 편집된 문자열인 경우 
   그 값을 출력하기 위해 사용된 '형식지정문자열'을 기술해야 한다.
 - '형식지정문자열'은 TO_CHAR에 사용된 날짜형식지정문자열과 동일함 
사용예)
  SELECT TO_DATE('20250214'),
         TO_DATE('20250214 10439','YYYYMMDD HHMISS'),
         TO_DATE(20250214),
     --    TO_DATE('20250931'),
         TO_DATE('2025 02 14'),   // '/' '-' ' '모두 공식구별자 특수기호
         TO_DATE('2025년 02월 14일 10:43:59', 
                 'YYYY"년" MM"월" DD"일" HH24:MI:SS')
   FROM DUAL;    
   
사용예) 오늘이 2020년 7월 28일이라고 가정하고 CART테이블에 사용될 장바구니번호를 생성하시오

  SELECT TO_CHAR(SYSDATE,'YYYYMMDD')||
         TRIM(TO_CHAR(TO_NUMBER(SUBSTR(TO_CHAR(MAX(CART_NO)),9))+1,'00000')),
         MAX(CART_NO)+1
    FROM CART
   WHERE CART_NO LIKE TO_CHAR(SYSDATE,'YYYYMMDD')||'%' ;
   
   