
-- TODO_NO 컬럼 사용함!
CREATE TABLE TB_TODO2 (
	TODO_NO        NUMBER CONSTRAINT TB_TODO_PK PRIMARY KEY,
	TODO_TITLE     VARCHAR2(30) NOT NULL,
	TODO_DETAIL    VARCHAR2(1500), 
	TODO_COMPLETE  CHAR(1) DEFAULT 'X' CONSTRAINT TODO_COMPLETE_CHECK 
  CHECK (TODO_COMPLETE IN ('O', 'X')),
	REGDATE DATE DEFAULT CURRENT_DATE
);

COMMENT ON COLUMN TB_TODO2.TODO_NO IS '할 일 번호';
COMMENT ON COLUMN TB_TODO2.TODO_TITLE IS '할 일 제목';
COMMENT ON COLUMN TB_TODO2.TODO_DETAIL IS '할 일 상세';
COMMENT ON COLUMN TB_TODO2.TODO_COMPLETE IS '완료여부';
COMMENT ON COLUMN TB_TODO2.REGDATE IS '작성 시간';

CREATE SEQUENCE SEQ_TODO_NO NOCACHE;


INSERT INTO TB_TODO2 
VALUES (SEQ_TODO_NO.NEXTVAL, 'JAVA', '공부', DEFAULT, DEFAULT);

INSERT INTO TB_TODO2 
VALUES (SEQ_TODO_NO.NEXTVAL, 'HTML', '공부', DEFAULT, DEFAULT);

INSERT INTO TB_TODO2 
VALUES (SEQ_TODO_NO.NEXTVAL, 'JS', '공부', DEFAULT, DEFAULT);

INSERT INTO TB_TODO2
VALUES (SEQ_TODO_NO.NEXTVAL, 'JDBC', '공부', DEFAULT, DEFAULT);

SELECT * FROM TB_TODO2;

SELECT 
	TODO_NO,
	TODO_TITLE,
	TODO_DETAIL,
	TODO_COMPLETE,
	TO_CHAR(REGDATE, 'YYYY"년" MM"월" DD"일" AM HH24:MI:SS') REG_DATE 
FROM TB_TODO2;

SELECT COUNT(*) 
FROM TB_TODO2
WHERE TODO_NO > 0
AND TODO_COMPLETE = 'O';

UPDATE TB_TODO2
SET
	TODO_COMPLETE = 'O'
WHERE TODO_NO = 19;


COMMIT;