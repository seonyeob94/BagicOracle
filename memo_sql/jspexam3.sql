SELECT count(*)
from CONTEST; -- CONTEST ���̺� 446 437

SELECT count(*)--17
from FILE_DETAIL; --463 464

SELECT count(*)--21
from FILE_GROUP; --463

SELECT count(*)
from CONTEST
where CONTEST_GUBUN = 'G32001'; -- ������ 268 285

SELECT count(*)
from CONTEST
where CONTEST_TYPE IS NULL; -- ���Ȱ�� 178 158

SELECT count(*)
from CONTEST
where CONTEST_GUBUN = 'G32002'; --�������� 61

SELECT count(*)
from CONTEST
where CONTEST_GUBUN = 'G32003'; --����Ȱ�� 63

SELECT count(*)
from CONTEST
where CONTEST_GUBUN = 'G32004'; --���Ͻ� 54

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35001'; --���� 13

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35002'; --����/����Ʈ���� 25

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35003'; --���� 13

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35004'; --����/������ 21

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35005'; --��ȹ/���̵�� 32

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35006'; --���̹�/���ΰ� 14

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35007'; --�� 11

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35008'; --��ȸ 18

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35009'; --������ 15

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35010'; --��ȭ/ĳ���� 11

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35011'; --����/���� 23

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35012'; --�̼� 9

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35013'; --���� 13

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35014'; --����/UCC 14

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35015'; --���� 10

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35016'; --�̺�Ʈ 12

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35017'; --���/â�� 12

SELECT count(*)
from CONTEST
where CONTEST_TYPE = 'G35018'; --�ؿ� 2

SELECT count(*)
from CONTEST
WHERE CONTEST_END_DATE > SYSDATE

-- 1. CONTEST_SEQ �ʱ�ȭ
DROP SEQUENCE CONTEST_SEQ;
CREATE SEQUENCE CONTEST_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
-- 2. FILE_DETAIL_SEQ �ʱ�ȭ
DROP SEQUENCE FILE_DETAIL_SEQ;
CREATE SEQUENCE FILE_DETAIL_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
-- 3. FILE_GROUP_SEQ �ʱ�ȭ
DROP SEQUENCE FILE_GROUP_SEQ;
CREATE SEQUENCE FILE_GROUP_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
DELETE FROM FILE_GROUP
WHERE FILE_GROUP_ID IN (
    SELECT T1.FILE_GROUP_ID
    FROM FILE_GROUP T1
    LEFT JOIN FILE_DETAIL T2 ON T1.FILE_GROUP_ID = T2.FILE_GROUP_ID
    WHERE T2.FILE_GROUP_ID IS NULL
);

commit

SELECT T1.CONTEST_ID, T1.CONTEST_TITLE
FROM CONTEST T1
JOIN (
    SELECT FILE_GROUP_ID
    FROM FILE_GROUP
    WHERE FILE_GROUP_ID NOT IN (SELECT FILE_GROUP_ID FROM FILE_DETAIL)
) T2 ON T1.FILE_GROUP_ID = T2.FILE_GROUP_ID;

select * from CONTEST
where CONTEST_TITLE LIKE '%��õ�� ��Ʃ��%';

select * from CONTEST
where CONTEST_TITLE LIKE '%�������� ����%';