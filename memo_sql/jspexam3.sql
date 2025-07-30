SELECT count(*)
from CONTEST; -- CONTEST 테이블 421

SELECT count(*)
from FILE_DETAIL; --588

SELECT count(*)
from CONTEST
where CONTEST_GUBUN = 'G32001'; -- 공모전 248

SELECT count(*)
from CONTEST
where CONTEST_TYPE IS NULL; -- 대외활동 173

SELECT count(*)
from CONTEST
where CONTEST_GUBUN = 'G32002'; --서포터즈 63

SELECT count(*)
from CONTEST
where CONTEST_GUBUN = 'G32003'; --봉사활동 63

SELECT count(*)
from CONTEST
where CONTEST_GUBUN = 'G32004'; --인턴십 47

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '건축'; --건축 20

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '게임/소프트웨어'; --게임/소프트웨어 22

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '과학'; --과학 18

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '광고/마케팅'; --광고/마케팅 22

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '기획/아이디어'; --기획/아이디어 27

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '네이밍/슬로건'; --네이밍/슬로건 13

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '논문'; --논문 13

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '대회'; --대회 15

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '디자인'; --디자인 15

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '만화/캐릭터'; --만화/캐릭터 8

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '문학/수기'; --문학/수기 23

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '미술'; --미술 6

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '사진'; --사진 14

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '영상/UCC'; --영상/UCC 12

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '음악'; --음악 12

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '이벤트'; --이벤트 3

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '취업/창업'; --취업/창업 2

SELECT count(*)
from CONTEST
where CONTEST_TYPE = '해외'; --해외 2

SELECT count(*)
from CONTEST
WHERE CONTEST_END_DATE > SYSDATE