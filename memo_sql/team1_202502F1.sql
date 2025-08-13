select sex
from(
select '害切' sex from dual
union
select '食切' sex from dual
union all
select '食切' sex from dual);

select lpad(level, 2, '0')
from dual
connect by level <=12;


select b.yyyyMM, a.sex
from (
select sex
from(
select '害切' sex from dual
union
select '食切' sex from dual)) a
,
(select '2025-'||lpad(level, 2, '0') yyyyMM
from dual
connect by level <=12) b
order by b.yyyyMM, a.sex;


select * from CHAT_ROOM;

select * from CHAT_MEMBER;

select 
    a.*
  , b.cnt
  , b.JOINED_AT
from 
    chat_room a
    left JOIN (
        select 
              cr_id 
            , count(*) cnt
            , max(JOINED_AT) JOINED_AT
        from 
            CHAT_MEMBER 
        group by 
            cr_id
    )        b on a.cr_id = b.cr_id
--on b.cr_id = a.cr_id