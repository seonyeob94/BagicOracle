CREATE TABLE HIGH_SCHOOL (
    HS_ID              NUMBER          PRIMARY KEY, -- 고등학교ID
    HS_CODE            VARCHAR2(20)    NOT NULL,     -- 학교코드
    HS_NAME            VARCHAR2(100)   NOT NULL,     -- 학교명
    HS_REGION          VARCHAR2(100)   NOT NULL,     -- 시도명
    HS_REGION_CODE     VARCHAR2(10)    NOT NULL,     -- 시도코드
    HS_JURIS           VARCHAR2(50)    NOT NULL,     -- 관할교육청명
    HS_JURIS_CODE     VARCHAR2(10),    NOT NULL,     -- 관할교육청 코드 (예: B10, G10 등)
    HS_TYPE            VARCHAR2(10)    NOT NULL,     -- 학교구분 (초/중/고)
    HS_FOUND_TYPE      VARCHAR2(20)    NOT NULL,     -- 설립유형 (공립/사립)
    HS_ZIPCODE         VARCHAR2(10),                 -- 우편번호
    HS_ADDR            VARCHAR2(200),                -- 기본주소
    HS_ADDR_DETAIL     VARCHAR2(200),                -- 상세주소
    HS_TEL             VARCHAR2(20),                 -- 전화번호
    HS_HOMEPAGE        VARCHAR2(300),                -- 홈페이지URL
    HS_COEDU_TYPE      VARCHAR2(10),                 -- 남녀공학 (남/여/공학)
    HS_TYPE_NAME       VARCHAR2(50),                 -- 학교구분명 (일반고/특성화고 등)
    HS_GENERAL_TYPE    VARCHAR2(50),                 -- 학교일반계열구분명 (일반계/전문계)
    HS_SPECIAL_PURPOSE VARCHAR2(100),                -- 특목구분 (과학고/예술계열 등)
    HS_FOUND_DATE      DATE,                         -- 설립일자
    HS_ANNIV_AT        DATE                          -- 개교기념일
);


CREATE TABLE HIGH_SCHOOL_DEPT (
    HSD_ID           NUMBER         PRIMARY KEY,       -- 학과ID
    HS_ID            NUMBER         NOT NULL,          -- 고등학교ID (FK)
    HSD_CODE         VARCHAR2(20),                     -- 학과코드
    HSD_NAME         VARCHAR2(100) NOT NULL,           -- 학과명
    HSD_TRACK_NAME   VARCHAR2(100),                    -- 계열명
    CONSTRAINT FK_HS_ID FOREIGN KEY (HS_ID)
        REFERENCES HIGH_SCHOOL(HS_ID)
);

