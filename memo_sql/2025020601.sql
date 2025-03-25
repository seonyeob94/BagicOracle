2025-0206-01)숫자자료타입
 - number,float,decimal, integer 등이 제공됨
1. number
 - 기본 숫자자료 타입
사용형식)
 컬럼명 NUMBER
 컬럼명 NUMBER(P,S)
 컬럼명 NUMBER(*,S)
-----------------------------------------------------
 데이터       선언            저장되는 값
 ----------------------------------------------------
 2345.5678  NUMBER           2345.5678
 2345.5678  NUMBER(*,2)      2345.57
 2345.5678  NUMBER(5,2)      오류
 2345.5678  NUMBER(8,3)      2345.568
 2345.5678  NUMBER(6)        2346
 2345.5678  NUMBER(7,-1)     2350
 0.05678    NUMBER(4,5)      0.05678
 0.05678    NUMBER(3,5)      오류
 
 사용예)
    CREATE TABLE TEMP04(
      COL1 NUMBER,
      COL2 NUMBER(*,2), 
      COL3 NUMBER(5,2), 
      COL4 NUMBER(8,3),
      COL5 NUMBER(6),
      COL6 NUMBER(7,-1),
      COL7 NUMBER(4,5),
      COL8 NUMBER(3,5)
 );
 INSERT INTO TEMP04 VALUES(2345.5678,2345.5678,345.5678,2345.5678,2345.5678,
                           2345.5678,0.05678,0.00056);
 INSERT INTO TEMP04(COL7) VALUES(0.012345678);
 INSERT INTO TEMP04(COL8) VALUES(0.002345678);
 INSERT INTO TEMP04(COL8) VALUES(0.0002345678);
 
 DELETE FROM TEMP04;

 SELECT*FROM TEMP04;
 