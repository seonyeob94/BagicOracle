
-- 0. ���� ��� ���̺� ����
CREATE TABLE users (
  user_id VARCHAR2(50) PRIMARY KEY,
  name    VARCHAR2(100)
);

CREATE TABLE book_loans (
  loan_id     NUMBER PRIMARY KEY,
  book_title  VARCHAR2(100)
);

-- ���� ������
INSERT INTO users (user_id, name)
VALUES ('user01', 'ȫ�浿');

INSERT INTO book_loans (loan_id, book_title)
VALUES (2001, '�ڹ��� ����');


-- 1. loan_history ���̺�
CREATE TABLE loan_history (
  history_id     NUMBER PRIMARY KEY,
  loan_id        NUMBER NOT NULL,
  status         VARCHAR2(20) NOT NULL,
  modified_date  DATE DEFAULT SYSDATE,
  CONSTRAINT fk_loan_history_loan
    FOREIGN KEY (loan_id) REFERENCES book_loans(loan_id)
);

-- ���� ������
INSERT INTO loan_history (history_id, loan_id, status, modified_date)
VALUES (1001, 2001, '����', TO_DATE('2025-04-01', 'YYYY-MM-DD'));

INSERT INTO loan_history (history_id, loan_id, status, modified_date)
VALUES (1002, 2001, '�ݳ�', TO_DATE('2025-04-08', 'YYYY-MM-DD'));


-- 2. overdue_records ���̺�
CREATE TABLE overdue_records (
  record_id      NUMBER PRIMARY KEY,
  loan_id        NUMBER NOT NULL,
  user_id        VARCHAR2(50) NOT NULL,
  overdue_date   DATE NOT NULL,
  overdue_days   NUMBER NOT NULL,
  status         VARCHAR2(20) NOT NULL,
  release_date   DATE,
  CONSTRAINT fk_overdue_loan
    FOREIGN KEY (loan_id) REFERENCES book_loans(loan_id),
  CONSTRAINT fk_overdue_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ���� ������
INSERT INTO overdue_records (
  record_id, loan_id, user_id, overdue_date, overdue_days, status, release_date
)
VALUES (
  3001, 2001, 'user01', TO_DATE('2025-04-09', 'YYYY-MM-DD'), 3, '����', TO_DATE('2025-04-12', 'YYYY-MM-DD')
);


-- 3. notifications ���̺�
CREATE TABLE notifications (
  notification_id  NUMBER PRIMARY KEY,
  user_id          VARCHAR2(50) NOT NULL,
  type             VARCHAR2(20),
  content          VARCHAR2(500),
  sent_date        DATE DEFAULT SYSDATE,
  success          CHAR(1) CHECK (success IN ('Y', 'N')),
  CONSTRAINT fk_notification_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ���� ������
INSERT INTO notifications (
  notification_id, user_id, type, content, sent_date, success
)
VALUES (
  4001, 'user01', '�ݳ�����', '���� "�ڹ��� ����" �ݳ� �������� �ٰ��ɴϴ�.', TO_DATE('2025-04-06', 'YYYY-MM-DD'), 'Y'
);

INSERT INTO users (user_id, name)
VALUES ('user02', '��ö��');

INSERT INTO users (user_id, name)
VALUES ('user03', '�̿���');

INSERT INTO book_loans (loan_id, book_title)
VALUES (2002, 'SQL ù����');

INSERT INTO book_loans (loan_id, book_title)
VALUES (2003, 'HTML&CSS ������ ������');

INSERT INTO loan_history (history_id, loan_id, status, modified_date)
VALUES (1003, 2002, '����', TO_DATE('2025-04-10', 'YYYY-MM-DD'));

INSERT INTO loan_history (history_id, loan_id, status, modified_date)
VALUES (1004, 2003, '����', TO_DATE('2025-04-12', 'YYYY-MM-DD'));

INSERT INTO overdue_records (
  record_id, loan_id, user_id, overdue_date, overdue_days, status, release_date
)
VALUES (
  3002, 2002, 'user02', TO_DATE('2025-04-13', 'YYYY-MM-DD'), 4, '��ü', NULL
);

INSERT INTO overdue_records (
  record_id, loan_id, user_id, overdue_date, overdue_days, status, release_date
)
VALUES (
  3003, 2003, 'user03', TO_DATE('2025-04-14', 'YYYY-MM-DD'), 2, '����', TO_DATE('2025-04-16', 'YYYY-MM-DD')
);

INSERT INTO notifications (
  notification_id, user_id, type, content, sent_date, success
)
VALUES (
  4002, 'user02', '��ü���', '��ü�� ������ �ֽ��ϴ�. ���� �ݳ� �ٶ��ϴ�.', TO_DATE('2025-04-14', 'YYYY-MM-DD'), 'Y'
);

INSERT INTO notifications (
  notification_id, user_id, type, content, sent_date, success
)
VALUES (
  4003, 'user03', '�ݳ�����', '���� "HTML&CSS ������ ������" �ݳ����� �ٰ��ɴϴ�.', TO_DATE('2025-04-13', 'YYYY-MM-DD'), 'Y'
);

