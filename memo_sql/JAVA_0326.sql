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

--BOARD���̺�
1	����1	����1	205-03-26	1					

--MEMBER���̺�
1	a001	java	������	2025-03-26	

SELECT M.MEM_NO, M.ID, M.PW, M.NAME, M.DELYN
             , B.BOARD_NO, B.TITLE, B.CONTENT, B.REG_DATE 
             , B.CNT, B.STATE, B.CODE_NO, B.WRITER, B.CODE_NAME
		FROM BOARD B, MEMBER M
		WHERE B.MEM_NO = M.MEM_NO
		AND BOARD_NO = 1;
        
        --ī�ắȯ �Լ�
/
create or replace FUNCTION FN_GETCAMEL(COLUMN_NAME IN VARCHAR2)
RETURN VARCHAR2
IS
RSLT VARCHAR2(30);
BEGIN
--ī��ǥ��� ��ȯ(SITE_NUM -> siteNum)
SELECT LOWER(SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),1,1))
|| SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),2) INTO RSLT
FROM DUAL;
--����
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
      

2025�� 3�� 26�� ������
[] [���� 5:12]  <!-- 
    board{boardNo=1,...}
     -->
[] [���� 5:14] <!-- selectOne("board.selectBoard",board); -->
   <!-- �Խ��� �󼼺��� 
      select �±״� ��ȸ(select) ������ �����ϱ� ���� mybatis �±�.
      parameterType(board.xml�� ����) : boardVO Ÿ��
      resultType(BoardDAO�� �����) : boardVO Ÿ��
   -->
[] [���� 5:15] SELECT BOARD_NO, TITLE, CONTENT, 
       B.REG_DATE, B.MEM_NO, CNT, NAME WRITER
FROM BOARD B, MEMBER M
WHERE B.MEM_NO = M.MEM_NO
AND BOARD_NO = 1;
[] [���� 5:24] ����
[����ȣ] [���� 5:28] 1. ���� : parameterType 
      2. ����   : 
         - resultType : ������ ���� ��
         - resultMap  : ������ ���� ��
[����ȣ] [���� 5:34] --ī�ắȯ �Լ�
/
create or replace FUNCTION FN_GETCAMEL(COLUMN_NAME IN VARCHAR2)
RETURN VARCHAR2
IS
RSLT VARCHAR2(30);
BEGIN
--ī��ǥ��� ��ȯ(SITE_NUM -> siteNum)
SELECT LOWER(SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),1,1))
|| SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),2) INTO RSLT
FROM DUAL;
--����
RETURN RSLT;
END;
/

--ī�ắȯ ����
SELECT COLUMN_NAME
, DATA_TYPE
, CASE WHEN DATA_TYPE='NUMBER' THEN 'private int ' || FN_GETCAMEL(COLUMN_NAME) || ';'
WHEN DATA_TYPE IN('VARCHAR2','CHAR') THEN 'private String ' || FN_G...
[����ȣ] [���� 5:39] SELECT M.MEM_NO, M.ID, M.PW, M.NAME, M.REG_DATE, M.DELYN
     , B.BOARD_NO, B.TITLE, B.CONTENT, B.REG_DATE, B.MEM_NO
     , B.CNT, B.STATE, B.CODE_NO, B.WRITER, B.CODE_NAME
FROM   BOARD B, MEMBER M
WHERE B.MEM_NO = M.MEM_NO
AND   B.BOARD_NO = 1;
[����ȣ] [���� 5:41] SELECT M.MEM_NO, M.ID, M.PW, M.NAME, M.DELYN
     , B.BOARD_NO, B.TITLE, B.CONTENT, B.REG_DATE
     , B.CNT, B.STATE, B.CODE_NO, B.WRITER, B.CODE_NAME
FROM   BOARD B, MEMBER M
WHERE B.MEM_NO = M.MEM_NO
AND   B.BOARD_NO = 1;
2025�� 3�� 27�� �����
[�̽�ȣ] [���� 3:28] * �ó������� �����Դϴ�.

���� �ܿ��� ���� ���� ���� �ֽ��ϴ�.
�׷��� �ó���� ������ �������� �����Դϴ�.
������ �ٰ����� �ٽ� ���� �ȳ��� �� �����̴� ����ٶ��ϴ�.
2025�� 3�� 28�� �ݿ���
[����ȣ] [���� 2:14] ����
[����ȣ] [���� 2:16] ����
[����ȣ] [���� 2:18] SELECT COLUMN_NAME
, DATA_TYPE
, CASE WHEN DATA_TYPE='NUMBER' THEN 'private int ' || FN_GETCAMEL(COLUMN_NAME) || ';'
WHEN DATA_TYPE IN('VARCHAR2','CHAR') THEN 'private String ' || FN_GETCAMEL(COLUMN_NAME) || ';'
WHEN DATA_TYPE='DATE' THEN 'private Date ' || FN_GETCAMEL(COLUMN_NAME) || ';'
ELSE 'private String ' || FN_GETCAMEL(COLUMN_NAME) || ';'
END AS CAMEL_CASE
, '<result property="'||FN_GETCAMEL(COLUMN_NAME)||'" column="'||COLUMN_NAME||'"/>' RESULTMAP
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = '...
[����ȣ] [���� 2:55] ����
[����ȣ] [���� 2:55] ����
[����ȣ] [���� 2:57] ����
[����ȣ] [���� 3:03] ����
[����ȣ] [���� 3:07] //����xml�� namespace.id�� ã�Ƽ� �� �±� ���� ������ ����
      //               �Ķ���� :    board{boardNo=1,...}
[����ȣ] [���� 3:08] <!-- 
    int boardNo = 1;
     -->
[����ȣ] [���� 3:09] <!-- �� ���� ��ȸ���� 1 ����
    int boardNo = 1;
     -->
[����ȣ] [���� 3:09] <!-- �� ���� ��ȸ���� 1 ����
    int boardNo = 1;
    insert/update/delete�±��� ��� resultType�� ����
       �翬�� int Ÿ���̹Ƿ�..
     -->
[����ȣ] [���� 3:15] ����
[����] [���� 3:20] --ī�ắȯ �Լ�
/
create or replace FUNCTION FN_GETCAMEL(COLUMN_NAME IN VARCHAR2)
RETURN VARCHAR2
IS
RSLT VARCHAR2(30);
BEGIN
--ī��ǥ��� ��ȯ(SITE_NUM -> siteNum)
SELECT LOWER(SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),1,1))
|| SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),2) INTO RSLT
FROM DUAL;
--����
RETURN RSLT;
END;
/
[����] [���� 3:41] ����: board.xml
[����ȣ] [���� 4:14] <!--  �� ���
   public List<BoardVo> listBoard(Map param) {
      return selectList("board.listBoard", param);
   }    
    -->
[����ȣ] [���� 4:18]     �ʴ�   ��..      ��...        ��!   �ʴ�
   ex) Map : HashMap, HashTable, SortedMap
[����ȣ] [���� 4:18] <!--  �� ���
   public List<BoardVo> listBoard(Map param) {
      return selectList("board.listBoard", param);
   }    
       �ʴ�   ��..      ��...        ��!   �ʴ�
   ex) Map : HashMap, HashTable, SortedMap
    -->
[����ȣ] [���� 4:20] //�� ���
      //WHERE  RN BETWEEN ��{startNo} AND ��{endNo}
      //10 ��(ī��θ�Ƽ)�� ���ڴ�(1������)
[����ȣ] [���� 4:21] //�� ���
      //WHERE  RN BETWEEN ��{startNo} AND ��{endNo}
      //10 ��(ī��θ�Ƽ)�� ���ڴ�(1������)
      Map<String,Object> param = new HashMap<String,Object>();
      param.put("startNo", 1);
      param.put("endNo", 10);
      
      boardService.listBoard(param);
[����ȣ] [���� 4:21] //param{startNo:1,endNo:10}
[����ȣ] [���� 4:24] SELECT *
      FROM  (SELECT  ROWNUM RN,  A.*
             FROM  (SELECT  
                           BOARD_NO, TITLE, CONTENT, 
                           B.REG_DATE, B.MEM_NO, CNT, NAME WRITER
                    FROM BOARD B, MEMBER M
                    WHERE B.MEM_NO = M.MEM_NO
                    ORDER BY BOARD_NO DESC) A
             ) A
      WHERE  RN BETWEEN 1 AND 10;
[����ȣ] [���� 4:30] SELECT *
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
[����ȣ] [���� 4:32] resultType : VO, String, int, hashMap..
   resultMap : <result �±��� ���̵� ������
[����ȣ] [���� 4:33] <select id="listBoard" resultType="BoardVo" parameterType="hashMap">
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
[����ȣ] [���� 4:38] mapUnderscoreToCamelCase
[����ȣ] [���� 4:38] <!-- 
   ī�� ���̽� ����� 
   BOARD ���̺��� BOARD_NO �÷��� boardNo�� ǥ����
   -->
[����ȣ] [���� 4:41] ���Ͽ�
���Ͽ� ����ȸ�ǽ�

ȸ�� ID: 210 880 1029
��й�ȣ: 660174

https://whaleon.us/o/CSsTdz/bb819e2d8652488bb5dd8a37dd1e5893
[����ȣ] [���� 4:43] https://java119.tistory.com/45
[����ȣ] [���� 5:05] /
DECLARE
    V_BOARD_NO NUMBER;
BEGIN
    SELECT NVL(MAX(BOARD_NO),0)+1 INTO V_BOARD_NO FROM BOARD;
    
    FOR I IN 0..372 LOOP
        INSERT INTO BOARD(BOARD_NO, TITLE, CONTENT, REG_DATE, MEM_NO, CNT, WRITER)
        VALUES((V_BOARD_NO+I),'����'||(V_BOARD_NO+I),'����'||(V_BOARD_NO+I),SYSDATE,1,0,'������');
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
        VALUES((V_BOARD_NO+I),'����'||(V_BOARD_NO+I),'����'||(V_BOARD_NO+I),SYSDATE,1,0,'������');
    END LOOP;
    
    COMMIT;
END;
/

SELECT * FROM BOARD;