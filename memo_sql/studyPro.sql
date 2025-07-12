CREATE TABLE HIGH_SCHOOL (
    HS_ID              NUMBER          PRIMARY KEY, -- ����б�ID
    HS_CODE            VARCHAR2(20)    NOT NULL,     -- �б��ڵ�
    HS_NAME            VARCHAR2(100)   NOT NULL,     -- �б���
    HS_REGION          VARCHAR2(100)   NOT NULL,     -- �õ���
    HS_REGION_CODE     VARCHAR2(10)    NOT NULL,     -- �õ��ڵ�
    HS_JURIS           VARCHAR2(50)    NOT NULL,     -- ���ұ���û��
    HS_JURIS_CODE     VARCHAR2(10),    NOT NULL,     -- ���ұ���û �ڵ� (��: B10, G10 ��)
    HS_TYPE            VARCHAR2(10)    NOT NULL,     -- �б����� (��/��/��)
    HS_FOUND_TYPE      VARCHAR2(20)    NOT NULL,     -- �������� (����/�縳)
    HS_ZIPCODE         VARCHAR2(10),                 -- �����ȣ
    HS_ADDR            VARCHAR2(200),                -- �⺻�ּ�
    HS_ADDR_DETAIL     VARCHAR2(200),                -- ���ּ�
    HS_TEL             VARCHAR2(20),                 -- ��ȭ��ȣ
    HS_HOMEPAGE        VARCHAR2(300),                -- Ȩ������URL
    HS_COEDU_TYPE      VARCHAR2(10),                 -- ������� (��/��/����)
    HS_TYPE_NAME       VARCHAR2(50),                 -- �б����и� (�Ϲݰ�/Ư��ȭ�� ��)
    HS_GENERAL_TYPE    VARCHAR2(50),                 -- �б��Ϲݰ迭���и� (�Ϲݰ�/������)
    HS_SPECIAL_PURPOSE VARCHAR2(100),                -- Ư�񱸺� (���а�/�����迭 ��)
    HS_FOUND_DATE      DATE,                         -- ��������
    HS_ANNIV_AT        DATE                          -- ���������
);


CREATE TABLE HIGH_SCHOOL_DEPT (
    HSD_ID           NUMBER         PRIMARY KEY,       -- �а�ID
    HS_ID            NUMBER         NOT NULL,          -- ����б�ID (FK)
    HSD_CODE         VARCHAR2(20),                     -- �а��ڵ�
    HSD_NAME         VARCHAR2(100) NOT NULL,           -- �а���
    HSD_TRACK_NAME   VARCHAR2(100),                    -- �迭��
    CONSTRAINT FK_HS_ID FOREIGN KEY (HS_ID)
        REFERENCES HIGH_SCHOOL(HS_ID)
);

