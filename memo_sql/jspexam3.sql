SELECT count(*)
from CONTEST; -- CONTEST ���̺� 421

SELECT count(*)
from FILE_DETAIL; --588

SELECT count(*)
from CONTEST
where CONTEST_GUBUN = 'G32001'; -- ������ 248

SELECT count(*)
from CONTEST
where CONTEST_TYPE IS NULL; -- ���Ȱ�� 173

SELECT count(*)
from CONTEST
where CONTEST_GUBUN = 'G32002'; --�������� 63

SELECT count(*)
from CONTEST
where CONTEST_GUBUN = 'G32003'; --����Ȱ�� 63

SELECT count(*)
from CONTEST
where CONTEST_GUBUN = 'G32004'; --���Ͻ� 47

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '����'; --���� 20

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '����/����Ʈ����'; --����/����Ʈ���� 22

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '����'; --���� 18

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '����/������'; --����/������ 22

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '��ȹ/���̵��'; --��ȹ/���̵�� 27

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '���̹�/���ΰ�'; --���̹�/���ΰ� 13

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '��'; --�� 13

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '��ȸ'; --��ȸ 15

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '������'; --������ 15

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '��ȭ/ĳ����'; --��ȭ/ĳ���� 8

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '����/����'; --����/���� 23

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '�̼�'; --�̼� 6

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '����'; --���� 14

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '����/UCC'; --����/UCC 12

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '����'; --���� 12

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '�̺�Ʈ'; --�̺�Ʈ 3

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '���/â��'; --���/â�� 2

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '�ؿ�'; --�ؿ� 2

SELECT count(*)
from CONTEST
WHERE CONTEST_END_DATE > SYSDATE