-- MEMBERS 테이블 생성
--1) MEMBER_ID 컬럼에 PRIMARY KEY 제약조건 설정.

--2) MEMBER_PWD 컬럼에 NOT NULL 제약조건 설정.

--3) MEMBER_NAME 컬럼에 가변 길이 문자열 30byte 설정.
CREATE TABLE MEMBERS(
	MEMBER_ID VARCHAR2(20),
	MEMBER_PWD VARCHAR2(20) NOT NULL,
	MEMBER_NAME VARCHAR2(30),
	MEMBER_AGE NUMBER,
	MEMBER_EMAIL VARCHAR2(50),
PRIMARY KEY(MEMBER_ID)
);

SELECT * 
FROM MEMBERS;

INSERT INTO MEMBERS
VALUES ('user01', 'pass01', '홍길동', '24', 'hong@naver.com');

INSERT INTO MEMBERS (
MEMBER_ID, MEMBER_PWD, MEMBER_NAME)
VALUES ('user02', 'pass02', '김철수');

INSERT INTO MEMBERS (		-- ID PRIMARY KEY
MEMBER_ID, MEMBER_PWD, MEMBER_NAME)
VALUES ('user02', 'pass03', '신짱구');

INSERT INTO MEMBERS (		-- PWD NUT NULL
MEMBER_ID, MEMBER_NAME)
VALUES ('user03', '맹구');




-- 1. MEMBER_NAME 에 "고정길이" 문자형 


--1) BOARD_NO 컬럼에 PRIMARY KEY 제약조건 설정.

--2) BOARD_WRITER 컬럼에 MEMERS 테이블의 MEMBER_ID를 참조하는 FOREIGN KEY 제약조건 설정.

--3) BOARD_REG_DATE(작성일) 컬럼에 현재 시간으로 기본값 설정

-- BOARDS 테이블 생성
CREATE TABLE BOARDS(
	BOARD_NO NUMBER PRIMARY KEY,
	BOARD_TITLE VARCHAR2(100),
	BOARD_CONTENT VARCHAR2(4000),
	BOARD_WRITER VARCHAR2(20) 
		REFERENCES MEMBERS (MEMBER_ID),
	BOARD_REG_DATE DATE DEFAULT CURRENT_DATE
);

INSERT INTO BOARDS
VALUES (001, 'ABC', 'CON', 'user01', DEFAULT);

INSERT INTO BOARDS
VALUES (002, 'ABC', 'CON', 'user02', DEFAULT);

DROP TABLE BOARDS;

SELECT *
FROM BOARDS;

COMMIT;

-- 2. 컬럼 레벨에서 포린키 구문
-- 3. 현재 시간 current date