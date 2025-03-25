2025-0227-01) VIEW
 - 가상의 테이블
 - 특정 자료에 대한 접급을 제한
 - 여러 테이블에 분산 저장된 자료를 자주 조회할 때
 - 한 테이블에서 부분적으로 자료를 조회할 때
 
사용형식)
  CREATE [OR REPLACE] VIEW 뷰이름[(컬럼list)]
  AS
    SELECT 문
    [WITH CHECK OPTION]
    [WITH READ ONLY]
    
 - 뷰를 생성하는 원본테이블은 뷰에 관계없이 CRUD 가능하며, 그 결과는 즉시
   뷰에 적용됨
 - WITH CHECK OPTION 이나 WITH READ ONLY 옵션을 사용하지 않고 생성된
   뷰의 갱신은 원본테이블을 변경시킴
 
사용예) 회원테이블에서 마일리지가 3000이상인 회원들의 회원번호, 회원명,마일리지로
       뷰를 생성하시오
  
  CREATE OR REPLACE VIEW V_MEM_MILEAGE
  AS       
  SELECT MEM_ID, 
         MEM_NAME,
         MEM_MILEAGE
    FROM MEMBER
   WHERE MEM_MILEAGE>=3000; 
   
  SELECT * FROM V_MEM_MILEAGE; 
  
사용예)뷰 V_MEM_MILEAGE에서 회원번호 'e001'회원의 마일지리를 8000으로 변경
  UPDATE V_MEM_MILEAGE
     SET MEM_MILEAGE=8000
   WHERE MEM_ID='e001';  
   
사용예)MEMBER테이블에서 회원번호 'e001'회원의 마일지리를 2000으로 변경
  UPDATE MEMBER
     SET MEM_MILEAGE=2000
   WHERE MEM_ID='e001'; --뷰 생성조건이 마일리지 2000이상이었으므로 조건이 달성하지 못해 탈락

   
  CREATE OR REPLACE VIEW V_MEM_MILEAGE
  AS       
  SELECT MEM_ID, 
         MEM_NAME,
         MEM_MILEAGE
    FROM MEMBER
   WHERE MEM_MILEAGE>=3000
    WITH CHECK OPTION;
   
  SELECT * FROM V_MEM_MILEAGE;
   
사용예)MEMBER테이블에서 회원번호 'e001'회원의 마일지리를 2000으로 변경
  UPDATE MEMBER
     SET MEM_MILEAGE=2000
   WHERE MEM_ID='e001';
   
   
사용예)V_MEM_MILEAGE 뷰에서 회원번호 'k001'회원의 마일지리를 2000으로 변경
  UPDATE V_MEM_MILEAGE
     SET MEM_MILEAGE=2000
   WHERE MEM_ID='k001';
   --WITH CHECK OPTION 조건에 위배되면 실행 안됨
   
사용예)V_MEM_MILEAGE 뷰에서 회원번호 'k001'회원의 마일지리를 6700으로 변경
  UPDATE V_MEM_MILEAGE
     SET MEM_MILEAGE=6700
   WHERE MEM_ID='k001';
   
  SELECT MEM_ID,MEM_MILEAGE
    FROM MEMBER
   WHERE MEM_ID='k001'; 
   
   