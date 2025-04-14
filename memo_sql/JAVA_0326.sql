CREATE TABLE BOARD(
    BOARD_NO NUMBER,
    TITLE VARCHAR2(300),
    CONTENT VARCHAR2(1000),
    REG_DATE VARCHAR2(30),
    MEM_NO NUMBER,
    CNT NUMBER,
    STATE NUMBER,
    CODE_NO NUMBER,
    WRITER VARCHAR2(150),
    CODE_NAME VARCHAR2(100),
    CONSTRAINT PK_BOARD PRIMARY KEY(BOARD_NO)
);

CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    ID VARCHAR2(30),
    PW VARCHAR2(30),
    NAME VARCHAR2(90),
    REG_DATE VARCHAR2(30),
    DELYN VARCHAR2(10),
    CONSTRAINT PK_MEMBER PRIMARY KEY(MEM_NO)
);

CREATE TABLE MENU(
    MENU_NO NUMBER,
    MENU_NAME VARCHAR2(90),
    GROUP_NO NUMBER,
    MENU_IMAGE VARCHAR2(100),
    MENU_PRICE NUMBER,
    GROUP_NAME VARCHAR2(100),
    CONSTRAINT PK_MENU PRIMARY KEY(MENU_NO)
);

CREATE TABLE BOARD_CODE(
    CODE_NO NUMBER,
    CODE_NAME VARCHAR2(100),
    CONSTRAINT PK_BOARD_CODE PRIMARY KEY(CODE_NO)
);


GRANT UNLIMITED TABLESPACE TO JAVA_;

--BOARD테이블
1	제목1	내용1	205-03-26	1					

--MEMBER테이블
1	a001	java	개똥이	2025-03-26	

SELECT M.MEM_NO, M.ID, M.PW, M.NAME, M.DELYN
             , B.BOARD_NO, B.TITLE, B.CONTENT, B.REG_DATE 
             , B.CNT, B.STATE, B.CODE_NO, B.WRITER, B.CODE_NAME
		FROM BOARD B, MEMBER M
		WHERE B.MEM_NO = M.MEM_NO
		AND BOARD_NO = 1;
        
        --카멜변환 함수
/
create or replace FUNCTION FN_GETCAMEL(COLUMN_NAME IN VARCHAR2)
RETURN VARCHAR2
IS
RSLT VARCHAR2(30);
BEGIN
--카멜표기로 변환(SITE_NUM -> siteNum)
SELECT LOWER(SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),1,1))
|| SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),2) INTO RSLT
FROM DUAL;
--리턴
RETURN RSLT;
END;
/
SELECT COLUMN_NAME
, DATA_TYPE
, CASE WHEN DATA_TYPE='NUMBER' THEN 'private int ' || FN_GETCAMEL(COLUMN_NAME) || ';'
WHEN DATA_TYPE IN('VARCHAR2','CHAR') THEN 'private String ' || FN_GETCAMEL(COLUMN_NAME) || ';'
WHEN DATA_TYPE='DATE' THEN 'private Date ' || FN_GETCAMEL(COLUMN_NAME) || ';'
ELSE 'private String ' || FN_GETCAMEL(COLUMN_NAME) || ';'
END AS CAMEL_CASE
, '<result property="'||FN_GETCAMEL(COLUMN_NAME)||'" column="'||COLUMN_NAME||'"/>' RESULTMAP
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'BOARD'
AND    OWNER = 'JAVA_';

        
SELECT *
      FROM  (SELECT  ROWNUM RN,  A.*
             FROM  (SELECT  
                           BOARD_NO, B.TITLE, B.CONTENT, 
                           B.REG_DATE, B.MEM_NO, B.CNT, M.NAME WRITER
                    FROM BOARD B, MEMBER M
                    WHERE B.MEM_NO = M.MEM_NO
                    ORDER BY BOARD_NO DESC) A
             ) A
      WHERE  RN BETWEEN 1 AND 10;
      

2025년 3월 26일 수요일
[] [오후 5:12]  <!-- 
    board{boardNo=1,...}
     -->
[] [오후 5:14] <!-- selectOne("board.selectBoard",board); -->
   <!-- 게시판 상세보기 
      select 태그는 조회(select) 쿼리를 실행하기 위한 mybatis 태그.
      parameterType(board.xml로 드루와) : boardVO 타입
      resultType(BoardDAO로 가즈아) : boardVO 타입
   -->
[] [오후 5:15] SELECT BOARD_NO, TITLE, CONTENT, 
       B.REG_DATE, B.MEM_NO, CNT, NAME WRITER
FROM BOARD B, MEMBER M
WHERE B.MEM_NO = M.MEM_NO
AND BOARD_NO = 1;
[] [오후 5:24] 사진
[송중호] [오후 5:28] 1. 들어옴 : parameterType 
      2. 나감   : 
         - resultType : 조인이 없을 때
         - resultMap  : 조인이 있을 때
[송중호] [오후 5:34] --카멜변환 함수
/
create or replace FUNCTION FN_GETCAMEL(COLUMN_NAME IN VARCHAR2)
RETURN VARCHAR2
IS
RSLT VARCHAR2(30);
BEGIN
--카멜표기로 변환(SITE_NUM -> siteNum)
SELECT LOWER(SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),1,1))
|| SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),2) INTO RSLT
FROM DUAL;
--리턴
RETURN RSLT;
END;
/

--카멜변환 쿼리
SELECT COLUMN_NAME
, DATA_TYPE
, CASE WHEN DATA_TYPE='NUMBER' THEN 'private int ' || FN_GETCAMEL(COLUMN_NAME) || ';'
WHEN DATA_TYPE IN('VARCHAR2','CHAR') THEN 'private String ' || FN_G...
[송중호] [오후 5:39] SELECT M.MEM_NO, M.ID, M.PW, M.NAME, M.REG_DATE, M.DELYN
     , B.BOARD_NO, B.TITLE, B.CONTENT, B.REG_DATE, B.MEM_NO
     , B.CNT, B.STATE, B.CODE_NO, B.WRITER, B.CODE_NAME
FROM   BOARD B, MEMBER M
WHERE B.MEM_NO = M.MEM_NO
AND   B.BOARD_NO = 1;
[송중호] [오후 5:41] SELECT M.MEM_NO, M.ID, M.PW, M.NAME, M.DELYN
     , B.BOARD_NO, B.TITLE, B.CONTENT, B.REG_DATE
     , B.CNT, B.STATE, B.CODE_NO, B.WRITER, B.CODE_NAME
FROM   BOARD B, MEMBER M
WHERE B.MEM_NO = M.MEM_NO
AND   B.BOARD_NO = 1;
2025년 3월 27일 목요일
[이승호] [오후 3:28] * 냉난방기관련 공지입니다.

현재 겨울을 지나 봄이 오고 있습니다.
그래서 냉난방기 전원을 내려놓은 상태입니다.
여름이 다가오면 다시 가동 안내를 할 예정이니 참고바랍니다.
2025년 3월 28일 금요일
[송중호] [오후 2:14] 사진
[송중호] [오후 2:16] 사진
[송중호] [오후 2:18] SELECT COLUMN_NAME
, DATA_TYPE
, CASE WHEN DATA_TYPE='NUMBER' THEN 'private int ' || FN_GETCAMEL(COLUMN_NAME) || ';'
WHEN DATA_TYPE IN('VARCHAR2','CHAR') THEN 'private String ' || FN_GETCAMEL(COLUMN_NAME) || ';'
WHEN DATA_TYPE='DATE' THEN 'private Date ' || FN_GETCAMEL(COLUMN_NAME) || ';'
ELSE 'private String ' || FN_GETCAMEL(COLUMN_NAME) || ';'
END AS CAMEL_CASE
, '<result property="'||FN_GETCAMEL(COLUMN_NAME)||'" column="'||COLUMN_NAME||'"/>' RESULTMAP
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = '...
[송중호] [오후 2:55] 사진
[송중호] [오후 2:55] 사진
[송중호] [오후 2:57] 사진
[송중호] [오후 3:03] 사진
[송중호] [오후 3:07] //매퍼xml의 namespace.id를 찾아서 그 태그 안의 쿼리를 실행
      //               파라미터 :    board{boardNo=1,...}
[송중호] [오후 3:08] <!-- 
    int boardNo = 1;
     -->
[송중호] [오후 3:09] <!-- 그 글의 조회수를 1 증가
    int boardNo = 1;
     -->
[송중호] [오후 3:09] <!-- 그 글의 조회수를 1 증가
    int boardNo = 1;
    insert/update/delete태그의 경우 resultType은 생략
       당연히 int 타입이므로..
     -->
[송중호] [오후 3:15] 사진
[석원] [오후 3:20] --카멜변환 함수
/
create or replace FUNCTION FN_GETCAMEL(COLUMN_NAME IN VARCHAR2)
RETURN VARCHAR2
IS
RSLT VARCHAR2(30);
BEGIN
--카멜표기로 변환(SITE_NUM -> siteNum)
SELECT LOWER(SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),1,1))
|| SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),2) INTO RSLT
FROM DUAL;
--리턴
RETURN RSLT;
END;
/
[세진] [오후 3:41] 파일: board.xml
[송중호] [오후 4:14] <!--  글 목록
   public List<BoardVo> listBoard(Map param) {
      return selectList("board.listBoard", param);
   }    
    -->
[송중호] [오후 4:18]     맵다   하..      하...        쏘!   맵다
   ex) Map : HashMap, HashTable, SortedMap
[송중호] [오후 4:18] <!--  글 목록
   public List<BoardVo> listBoard(Map param) {
      return selectList("board.listBoard", param);
   }    
       맵다   하..      하...        쏘!   맵다
   ex) Map : HashMap, HashTable, SortedMap
    -->
[송중호] [오후 4:20] //글 목록
      //WHERE  RN BETWEEN 샵{startNo} AND 샵{endNo}
      //10 행(카디널리티)을 보겠다(1페이지)
[송중호] [오후 4:21] //글 목록
      //WHERE  RN BETWEEN 샵{startNo} AND 샵{endNo}
      //10 행(카디널리티)을 보겠다(1페이지)
      Map<String,Object> param = new HashMap<String,Object>();
      param.put("startNo", 1);
      param.put("endNo", 10);
      
      boardService.listBoard(param);
[송중호] [오후 4:21] //param{startNo:1,endNo:10}
[송중호] [오후 4:24] SELECT *
      FROM  (SELECT  ROWNUM RN,  A.*
             FROM  (SELECT  
                           BOARD_NO, TITLE, CONTENT, 
                           B.REG_DATE, B.MEM_NO, CNT, NAME WRITER
                    FROM BOARD B, MEMBER M
                    WHERE B.MEM_NO = M.MEM_NO
                    ORDER BY BOARD_NO DESC) A
             ) A
      WHERE  RN BETWEEN 1 AND 10;
[송중호] [오후 4:30] SELECT *
FROM  (SELECT  ROWNUM RN,  A.*
       FROM (
              SELECT B.BOARD_NO, B.TITLE, B.CONTENT, 
                     B.REG_DATE, B.MEM_NO, B.CNT, M.NAME
              FROM  BOARD B, MEMBER M
              WHERE B.MEM_NO = M.MEM_NO
              ORDER BY BOARD_NO DESC
            ) A
       ) A
WHERE  RN BETWEEN 1 AND 10;
[송중호] [오후 4:32] resultType : VO, String, int, hashMap..
   resultMap : <result 태그의 아이디를 참조함
[송중호] [오후 4:33] <select id="listBoard" resultType="BoardVo" parameterType="hashMap">
       SELECT *
      FROM  (SELECT  ROWNUM RN,  A.*
             FROM  (SELECT  
                           B.BOARD_NO, B.TITLE, B.CONTENT, 
                           B.REG_DATE, B.MEM_NO, B.CNT, M.NAME WRITER
                    FROM BOARD B, MEMBER M
                    WHERE B.MEM_NO = M.MEM_NO
                    AND CODE_NO = #{codeNo}
                    ORDER BY BOARD_NO DESC) A
             ) A
      WHERE  RN BETWEEN...
[송중호] [오후 4:38] mapUnderscoreToCamelCase
[송중호] [오후 4:38] <!-- 
   카멜 케이스 사용함 
   BOARD 테이블의 BOARD_NO 컬럼을 boardNo로 표현함
   -->
[송중호] [오후 4:41] 웨일온
웨일온 전용회의실

회의 ID: 210 880 1029
비밀번호: 660174

https://whaleon.us/o/CSsTdz/bb819e2d8652488bb5dd8a37dd1e5893
[송중호] [오후 4:43] https://java119.tistory.com/45
[송중호] [오후 5:05] /
DECLARE
    V_BOARD_NO NUMBER;
BEGIN
    SELECT NVL(MAX(BOARD_NO),0)+1 INTO V_BOARD_NO FROM BOARD;
    
    FOR I IN 0..372 LOOP
        INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, REG_DATE, MEM_NO, CNT, WRITER)
        VALUES((V_BOARD_NO+I),'제목'||(V_BOARD_NO+I),'내용'||(V_BOARD_NO+I),SYSDATE,1,0,'개똥이');
    END LOOP;
    
    COMMIT;
END;
/
---------------
/
DECLARE
    V_BOARD_NO NUMBER;
BEGIN
    SELECT NVL(MAX(BOARD_NO),0)+1 INTO V_BOARD_NO FROM BOARD;
    
    FOR I IN 0..372 LOOP
        INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, REG_DATE, MEM_NO, CNT, WRITER)
        VALUES((V_BOARD_NO+I),'제목'||(V_BOARD_NO+I),'내용'||(V_BOARD_NO+I),SYSDATE,1,0,'개똥이');
    END LOOP;
    
    COMMIT;
END;
/

SELECT * FROM BOARD;