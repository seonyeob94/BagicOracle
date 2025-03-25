2025-0204-01) 사용자 생성

2. 권한부여
 - 오라클에서 기본적으로 제공하는 권한의 묶음(Roll) 사용
 - connect, resource, dba
 사용형식)
  Grant 권한명|롤이름,... to 계정명;
  
  사용예)
  grant connect, resource, dba to c##sy94;
  
  1. 사용자 생성
 - create 명령사용
 사용형식)
  create user 사용자명 Identified by 암호;
  . 사용자명, 암호 : - 사용자 정의어 사용
                   - 첫 글자는 영어, 그 이후에는 영어, 숫자, 특수문자( , $) 사용가능
                   - 글자수에 제한 없음
                   
사용예)
 create user c##sy94 identified by java;
 
 
 ** HR계정생성 후 접속자에 추가
  create user c##HR identified by java;
  grant connect, resource, dba to c##HR;
 
 
 
 
 **practice 계정 생성 후 등록
  create user c##practice identified by java;
  grant connect, resource, dba to c##practice;