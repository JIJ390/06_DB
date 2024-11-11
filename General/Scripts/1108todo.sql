CREATE TABLE TB_TODO_MEMBER(
	TODO_MEMBER_NO NUMBER PRIMARY KEY,
	TODO_MEMBER_ID VARCHAR2(30) NOT NULL,
	TODO_MEMBER_PW VARCHAR2(100) NOT NULL,
	TODO_MEMBER_NAME VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN "TB_TODO_MEMBER"."TODO_MEMBER_NO"  IS '회원 번호(PK)';
COMMENT ON COLUMN "TB_TODO_MEMBER"."TODO_MEMBER_ID"  IS '회원 아이디';
COMMENT ON COLUMN "TB_TODO_MEMBER"."TODO_MEMBER_PW"  IS '회원 비밀번호';
COMMENT ON COLUMN "TB_TODO_MEMBER"."TODO_MEMBER_NAME"  IS '회원 이름';

CREATE TABLE TB_TODO(
	TODO_NO NUMBER PRIMARY KEY,
	TODO_TITLE VARCHAR2(300) NOT NULL,
	TODO_COMPLETED CHAR(1) DEFAULT 'N' CHECK(TODO_COMPLETED IN ('Y', 'N')),
	TODO_MEMBER_NO NUMBER REFERENCES TB_TODO_MEMBER(TODO_MEMBER_NO) NOT NULL
);

COMMENT ON COLUMN "TB_TODO"."TODO_NO"  IS '할 일 번호';
COMMENT ON COLUMN "TB_TODO"."TODO_TITLE"  IS '할 일 제목';
COMMENT ON COLUMN "TB_TODO"."TODO_COMPLETED"  IS '할 일 완료 여부';
COMMENT ON COLUMN "TB_TODO"."TODO_MEMBER_NO"  IS '회원 번호(FK)';

CREATE SEQUENCE SEQ_TODO_MEMBER_NO NOCACHE;
CREATE SEQUENCE SEQ_TODO_NO NOCACHE;
