/* 관리자 계정 (sys) 접속 후 수행*/

--ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
--
---- 계정 생성
--CREATE USER SPRING_JIJ IDENTIFIED BY SPRING1234; 
--
---- 권한 부여
--GRANT CONNECT, RESOURCE TO SPRING_JIJ;
--
---- 테이블 저장 공간 할당
--ALTER USER SPRING_JIJ
--DEFAULT TABLESPACE USERS
--QUOTA 100M ON USERS;



----------------------------------------------------------------------------

/* SPRING 계정 접속 후 테이블, 시퀀스 생성 */

/* 회원("MEMBER") (==문자 그대로 해석)*/

CREATE TABLE "MEMBER" (
	"MEMBER_NO"       NUMBER,
	"MEMBER_EMAIL"    VARCHAR2(50)  NOT NULL,
	"MEMBER_PW"       VARCHAR2(100) NOT NULL,
	"MEMBER_NICKNAME" NVARCHAR2(10) NOT NULL,			-- 한글 가능
	"MEMBER_TEL"      CHAR(11)      NOT NULL,
	"MEMBER_ADDRESS"  NVARCHAR2(150),
	"PROFILE_IMG"     VARCHAR2(300),							-- 파일 경로
	"ENROLL_DATE"     DATE DEFAULT CURRENT_DATE,
	"MEMBER_DEL_FL"   CHAR(1) DEFAULT 'N',				-- 탈퇴 여부
	"AUTHORITY"				NUMBER DEFAULT 1,						-- R권한
	
	CONSTRAINT "MEMBER_PK" PRIMARY KEY("MEMBER_NO"),
	
	CONSTRAINT "MEMBER_DEL_FL_CHK" 
	CHECK("MEMBER_DEL_FL" IN ('Y', 'N')),
	
	CONSTRAINT "AUTHORITY_CHK" 
	CHECK("AUTHORITY" IN (1, 2))
);


-- COMMENT 추가 --

COMMENT ON COLUMN "MEMBER"."MEMBER_NO"       IS '회원 번호(PK)';
COMMENT ON COLUMN "MEMBER"."MEMBER_EMAIL"    IS '회원 이메일(ID)';
COMMENT ON COLUMN "MEMBER"."MEMBER_PW"       IS '회원 비밀번호';
COMMENT ON COLUMN "MEMBER"."MEMBER_NICKNAME" IS '회원명(별명)';
COMMENT ON COLUMN "MEMBER"."MEMBER_TEL"      IS '회원 전화번호(-제외)';
COMMENT ON COLUMN "MEMBER"."MEMBER_ADDRESS"  IS '회원 주소';
COMMENT ON COLUMN "MEMBER"."PROFILE_IMG"     IS '프로필 이미지 경로';
COMMENT ON COLUMN "MEMBER"."ENROLL_DATE"     IS '가입일';
COMMENT ON COLUMN "MEMBER"."MEMBER_DEL_FL"   IS '탈퇴 여부(Y,N)';
COMMENT ON COLUMN "MEMBER"."AUTHORITY"       IS '권한(1:일반, 2:관리자)';


-- 회원 번호 시퀀스 생성
CREATE SEQUENCE SEQ_MEMBER_NO NOCACHE;


-- 샘플 회원 게이터 삽입
INSERT INTO "MEMBER"  
VALUES(SEQ_MEMBER_NO.NEXTVAL, 'member010@kh.or.kr', 'pass01!',
			 '샘플1', '01012341234', NULL, NULL, 
			 DEFAULT, DEFAULT, DEFAULT); 
			
-- 샘플 데이터 비밀번호 암호화 적용
UPDATE "MEMBER"
SET 
	"MEMBER_PW" = '$2a$10$hqBsO0zsZ/Rv3.DQ0zK2MejPJmjB90jawxec3uEcVbSVXT88nBv.W'
WHERE "MEMBER_NO" = 1;


-- 샘플 데이터 --


INSERT INTO "MEMBER"
VALUES(
	SEQ_MEMBER_NO.NEXTVAL, 
	'member02@kh.or.kr', 
	'$2a$10$KzFKEvO4C65xBTetZDV8QufZvhQnIGU0SE5ZEaZo0T9SrdYS5oFMC',
	 '샘플2', 
	 '01022222222', 
	 NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO "MEMBER"
VALUES(
	SEQ_MEMBER_NO.NEXTVAL, 
	'member03@kh.or.kr', 
	'$2a$10$KzFKEvO4C65xBTetZDV8QufZvhQnIGU0SE5ZEaZo0T9SrdYS5oFMC',
	 '샘플3', 
	 '01033333333', 
	 NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

			



UPDATE "MEMBER"
SET 
	MEMBER_NICKNAME = ?,
	MEMBER_TEL      = ?,
	MEMBER_ADDRESS  = ?,
WHERE
	MEMBER_NO = ?;


SELECT COUNT(*)
FROM "MEMBER"
WHERE MEMBER_NO > 0 
AND   MEMBER_NICKNAME = '아구몬';

-- 모든 회원 복구
UPDATE "MEMBER"
SET 
	MEMBER_DEL_FL = 'N';



SELECT *
FROM "MEMBER";

DELETE "MEMBER"
WHERE MEMBER_NO = 7;

COMMIT;


-- 파일 업로드 테스트용 테이블
CREATE TABLE TB_FILE_TEST(
	FILE_NO            NUMBER PRIMARY KEY,				
	FILE_ORIGINAL_NAME VARCHAR2(300),							-- 원본 파일명		// 필요에 따라
	FILE_RENAME        VARCHAR2(300),							-- 변경된 파일명	// 필수!!!
	FILE_PATH          VARCHAR2(300),							-- 파일이 저장된 폴더명
	UPLOAD_DATE        DATE DEFAULT CURRENT_DATE	-- 저장된 날짜
);

CREATE SEQUENCE SEQ_FILE_NO NOCACHE; -- 시퀀스 생성

SELECT * FROM TB_FILE_TEST;

DELETE TB_FILE_TEST
WHERE FILE_NO = 5;

UPDATE TB_FILE_TEST
SET FILE_PATH = '/images/test/';

DROP TABLE TB_FILE_TEST;

ROLLBACK;



----------------------------------------------------------------------------------
--ERD 생성



CREATE TABLE "BOARD" (
	"BOARD_NO"	NUMBER		NOT NULL,
	"BOARD_TITLE"	NVARCHAR2(100)		NOT NULL,
	"BOARD_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"BOARD_WRITE_DATE"	DATE	DEFAULT CURRENT_DATE	NOT NULL,
	"BOARD_UPDATE_DATE"	DATE		NULL,
	"READ_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"BOARD_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"BOARD_CODE"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD"."BOARD_NO" IS '게시글 번호(SEQ_BOARD_NO)';
COMMENT ON COLUMN "BOARD"."BOARD_TITLE" IS '게시글 제목';
COMMENT ON COLUMN "BOARD"."BOARD_CONTENT" IS '게시글 내용';
COMMENT ON COLUMN "BOARD"."BOARD_WRITE_DATE" IS '게시글 작성일';
COMMENT ON COLUMN "BOARD"."BOARD_UPDATE_DATE" IS '마지막 수정일';
COMMENT ON COLUMN "BOARD"."READ_COUNT" IS '조회수';
COMMENT ON COLUMN "BOARD"."BOARD_DEL_FL" IS '삭제 여부 (N, Y)';
COMMENT ON COLUMN "BOARD"."MEMBER_NO" IS '작성자 회원 번호';
COMMENT ON COLUMN "BOARD"."BOARD_CODE" IS '게시판 종류 코드 번호';

CREATE TABLE "BOARD_IMG" (
	"IMG_NO"	NUMBER		NOT NULL,
	"IMG_PATH"	VARCHAR2(200)		NOT NULL,
	"IMG_ORIGINAL_NAME"	NVARCHAR2(50)		NOT NULL,
	"IMG_RENAME"	NVARCHAR2(50)		NOT NULL,
	"IMAGE_ORDER"	NUMBER		NULL,
	"BOARD_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD_IMG"."IMG_NO" IS '이미지 번호(insertUploadList)';
COMMENT ON COLUMN "BOARD_IMG"."IMG_PATH" IS '이미지 요청 경로';
COMMENT ON COLUMN "BOARD_IMG"."IMG_ORIGINAL_NAME" IS '이미지 원본명';
COMMENT ON COLUMN "BOARD_IMG"."IMG_RENAME" IS '이미지 변경병';
COMMENT ON COLUMN "BOARD_IMG"."IMAGE_ORDER" IS '이미지 순서';
COMMENT ON COLUMN "BOARD_IMG"."BOARD_NO" IS '이미지가 첨부된 게시글 번호';

CREATE TABLE "BOARD_TYPE" (
	"BOARD_CODE"	NUMBER		NOT NULL,
	"BOARD_NAME"	NVARCHAR2(20)		NOT NULL
);

COMMENT ON COLUMN "BOARD_TYPE"."BOARD_CODE" IS '게시판 종류 코드 번호';
COMMENT ON COLUMN "BOARD_TYPE"."BOARD_NAME" IS '게시판 이름';

CREATE TABLE "BOARD_LIKE" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD_LIKE"."MEMBER_NO" IS '좋아요를 누른 회원 번호';
COMMENT ON COLUMN "BOARD_LIKE"."BOARD_NO" IS '좋아요가 눌러진 게시글 번호';

CREATE TABLE "COMMENT" (
	"COMMENT_NO"	NUMBER		NOT NULL,
	"COMMENT_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"COMMENT_WRITE_DATE"	DATE	DEFAULT CURRENT_DATE	NOT NULL,
	"COMMENT_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL,
	"PARENT_COMMENT_NO2"	NUMBER		NULL
);

COMMENT ON COLUMN "COMMENT"."COMMENT_NO" IS '댓글 번호(SEQ_COMMENT_NO)';
COMMENT ON COLUMN "COMMENT"."COMMENT_CONTENT" IS '댓글 내용';
COMMENT ON COLUMN "COMMENT"."COMMENT_WRITE_DATE" IS '댓글 작성일';
COMMENT ON COLUMN "COMMENT"."COMMENT_DEL_FL" IS '댓글  삭제 여부(N, Y)';
COMMENT ON COLUMN "COMMENT"."MEMBER_NO" IS '회원번호(SEQ_MEMBER_NO)';
COMMENT ON COLUMN "COMMENT"."BOARD_NO" IS '게시글 번호(SEQ_BOARD_NO)';
COMMENT ON COLUMN "COMMENT"."PARENT_COMMENT_NO2" IS '부모 댓글 번호';


ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"MEMBER_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"BOARD_NO"
);

ALTER TABLE "BOARD_IMG" ADD CONSTRAINT "PK_BOARD_IMG" PRIMARY KEY (
	"IMG_NO"
);

ALTER TABLE "BOARD_TYPE" ADD CONSTRAINT "PK_BOARD_TYPE" PRIMARY KEY (
	"BOARD_CODE"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "PK_BOARD_LIKE" PRIMARY KEY (
	"MEMBER_NO",
	"BOARD_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "PK_COMMENT" PRIMARY KEY (
	"COMMENT_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_BOARD_TYPE_TO_BOARD_1" FOREIGN KEY (
	"BOARD_CODE"
)
REFERENCES "BOARD_TYPE" (
	"BOARD_CODE"
);

ALTER TABLE "BOARD_IMG" ADD CONSTRAINT "FK_BOARD_TO_BOARD_IMG_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_LIKE_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "BOARD_LIKE" ADD CONSTRAINT "FK_BOARD_TO_BOARD_LIKE_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_MEMBER_TO_COMMENT_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_BOARD_TO_COMMENT_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "FK_COMMENT_TO_COMMENT_1" FOREIGN KEY (
	"PARENT_COMMENT_NO2"
)
REFERENCES "COMMENT" (
	"COMMENT_NO"
);


/* BOARD 테이블 BOARD_DEL_FL CHECK 제약 조건 추가 */
ALTER TABLE "BOARD"
ADD CONSTRAINT "CHK_BOARD_DEL_FL"
CHECK(BOARD_DEL_FL IN ('Y', 'N'));

/* COMMENT 테이블 COMMENT_DEL_FL CHECK 제약 조건 추가 */
ALTER TABLE "COMMENT"
ADD CONSTRAINT "CHK_COMMENT_DEL_FL"
CHECK(COMMENT_DEL_FL IN ('Y', 'N'));


----------------------------------------------------------------------------------------
/* 게시판 종류 (BOARD_TYPE) 추가 */
INSERT INTO "BOARD_TYPE" VALUES (1, '공지 사항');
INSERT INTO "BOARD_TYPE" VALUES (2, '자유 게시판');
INSERT INTO "BOARD_TYPE" VALUES (3, '정보 게시판');

SELECT * FROM "BOARD_TYPE";

COMMIT;




----------------------------------------------------------------------------------------
/* 게시판 (BOARD) 샘플 추가 */

/* 게시글 번호 시퀀스 생성 */
CREATE SEQUENCE SEQ_BOARD_NO NOCACHE;

/* PL/SQL 을 이용해서 BOARD 테이블에 샘플 데이터 삽입 */
BEGIN 
	FOR I IN 1..2000 LOOP
		INSERT INTO "BOARD"
		VALUES(
			SEQ_BOARD_NO.NEXTVAL,
			SEQ_BOARD_NO.CURRVAL || '번째 게시글',
			SEQ_BOARD_NO.CURRVAL || '번째 게시글 내용 입니다',
			DEFAULT, DEFAULT, DEFAULT, DEFAULT,
			1, 
			CEIL(DBMS_RANDOM.VALUE(0, 3))				-- 0 이상 3 미만 올림 처리
		);
	END LOOP;
END;

-- ALT X 로 실행


SELECT COUNT(*)
FROM "BOARD";

COMMIT;


SELECT BOARD_CODE, COUNT(*)
FROM "BOARD"
GROUP BY BOARD_CODE
ORDER BY BOARD_CODE ASC;


-----------------------------------------------------------
/* 댓글 번호 시퀀스 생성 */
CREATE SEQUENCE SEQ_COMMENT_NO NOCACHE;

/* PL/SQL 을 이용해서 COMMENT 테이블에 샘플 데이터 삽입 */
BEGIN 
	FOR I IN 1..3000 LOOP
		INSERT INTO "COMMENT"
		VALUES(
			SEQ_COMMENT_NO.NEXTVAL,
			SEQ_COMMENT_NO.CURRVAL || '번째 댓글',
			DEFAULT, DEFAULT,
			1,
			CEIL(DBMS_RANDOM.VALUE(0, 1999)),
			NULL
		);
	END LOOP;
END;


SELECT COUNT(*)
FROM "COMMENT";

SELECT BOARD_NO, COUNT(*)
FROM "COMMENT"
GROUP BY BOARD_NO;

COMMIT;

---------------------------------------------------

/* 특정 게시판(BOARD_CODE) 에 
 * 삭제 되지 않은 게시글 목록 조회
 * 
 * - 조회된 행 번호 : ROWNUM 또는 ROW_NUMBER() 이용
 *   게시글 번호, 제목, 조회수, 작성일 : BOARD 테이블 컬럼,
 *   작성자 닉네임 : MEMBER 테이블
 *   댓글 수 : COMMENT 테이블에서 BOARD_NO 별 댓글 개수 COUNT(*)
 *   좋아요 개수 : BOARD_LIKE 테이블에서 BOARD_NO 별 댓글 개수 COUNT(*)
 * 
 * - 작성일 : 몇 초/ 분 / 시간 전 또는 YYYY-MM-DD 형식으로 조회
 * 
 * - 가장 최근 글이 제일 처음 조회
 *   (시퀀스 번호 가장 큰 게시글(BOARD_NO))
 * */


--	ROW_NUMBER() OVER (ORDER BY BOARD_NO ASC) "RNUM",
--> BOARD_NO 오름차순으로 정렬 후 조회된 행의 번호를 지정
--  + 해당 컬럼 별칭을 "RNUM" 지정
--> 연속되지 않은 PK 대신 연속된 숫자를 만들려고 사용


--- 상관 서브쿼리 해석 순서
--  1) 메인 쿼리 1행 해석
--  2) 서브 쿼리에서 메인 쿼리 1행조회 결과를 이용-> 해석
--  3) 다시 메인 쿼리 해석

SELECT 
	ROW_NUMBER() OVER (ORDER BY BOARD_NO ASC) "RNUM",
	BOARD_NO,
	BOARD_TITLE,
	READ_COUNT,

	MEMBER_NICKNAME,
	(SELECT COUNT(*) FROM "COMMENT" C
	 WHERE C.BOARD_NO = B.BOARD_NO) AS "COMMENT_COUNT",
	 
	(SELECT COUNT(*) FROM "BOARD_LIKE" L
	 WHERE L.BOARD_NO = B.BOARD_NO) AS "LIKE_COUNT",
	 
	CASE 
		WHEN CURRENT_DATE - BOARD_WRITE_DATE < 1 / 24 / 60
		THEN FLOOR((CURRENT_DATE - BOARD_WRITE_DATE) * 24 * 60 * 60) || '초 전'
		
		WHEN CURRENT_DATE - BOARD_WRITE_DATE < 1 / 24 
		THEN FLOOR((CURRENT_DATE - BOARD_WRITE_DATE) * 24 * 60) || '분 전'
		
		WHEN CURRENT_DATE - BOARD_WRITE_DATE < 1 
		THEN FLOOR((CURRENT_DATE - BOARD_WRITE_DATE) * 24) || '시간 전'
		
		ELSE TO_CHAR(BOARD_WRITE_DATE, 'YYYY-MM-DD')
	END AS BOARD_WRITE_DATE

FROM 
	"BOARD" B
JOIN 
	"MEMBER" M ON (B.MEMBER_NO = M.MEMBER_NO)
WHERE
	BOARD_DEL_FL = 'N' -- 삭제 안된 글 
AND 
	BOARD_CODE = 2		 -- 게시판 종류
ORDER BY
	RNUM DESC;




-- DATE 타입 끼리 - 연산 시 결과 ==  몇 일 차이 (일 단위)
SELECT CURRENT_DATE 
	- TO_DATE('2024-10-01 10:39:00', 
			  'YYYY-MM-DD HH24:MI:SS')
FROM DUAL;



INSERT INTO "BOARD"
VALUES(
	SEQ_BOARD_NO.NEXTVAL,
	SEQ_BOARD_NO.CURRVAL || '번째 게시글',
	SEQ_BOARD_NO.CURRVAL || '번째 게시글 내용 입니다',
	DEFAULT, DEFAULT, DEFAULT, DEFAULT,
	1, 
	1
);

SELECT * FROM "BOARD";





-----------------------------------------------------------------
-- 이미지 번호 생성용 시퀀스 
CREATE SEQUENCE SEQ_IMG_NO NOCACHE;

/* 여러 행을 한 번에 INSERT 하는 방법 
 * 
 * 1. INSERT ALL 구문
 * 2. INSERT + SUBQUERY (사용!)
 * 
 * [문제점] 위에 두 방법 다 SEQUENCE를 직접 사용 불가!!
 * 함수를 생성 후 우회해서 사용
 * 
 * SEQ_IMG_NO 를 SUBQUERY 에 바로 사용할 수 없음
 * */

SELECT
	SEQ_IMG_NO.NEXTVAL,
	'/images/board',
	'원본명',
	'변경명',
	1,
	2000
FROM DUAL;

-- SEQ_IMG_NO 시퀀스의 다음 값을 반환하는 함수 생성
CREATE OR REPLACE FUNCTION NEXT_IMG_NO

-- 반환형
RETURN NUMBER

-- 사용할 변수
IS IMG_NO NUMBER;

BEGIN 
	SELECT SEQ_IMG_NO.NEXTVAL 
	INTO IMG_NO
	FROM DUAL;

	RETURN IMG_NO;
END;



INSERT INTO "BOARD_IMG"
(
	SELECT
		NEXT_IMG_NO(),
		'/images/board/', '원본명','변경명',1,2000
	FROM DUAL
	
	UNION ALL
	
	SELECT
		NEXT_IMG_NO(),
		'/images/board/', '원본명','변경명',1,2000
	FROM DUAL

);

ROLLBACK;


SELECT *
FROM BOARD_IMG;



SELECT *
FROM BOARD_IMG;

SELECT
	BOARD_NO, BOARD_TITLE, BOARD_CONTENT,
	BOARD_CODE, READ_COUNT, B.MEMBER_NO,
	MEMBER_NICKNAME, PROFILE_IMG,
	-- 오라클 데이터 베이스에 한글이 등록 X "" 로 작성
	TO_CHAR(BOARD_WRITE_DATE, 'YYYY"년" MM"월" DD"일" HH24:MI:SS')
		AS BOARD_WRITE_DATE,
		
	TO_CHAR(BOARD_UPDATE_DATE, 'YYYY"년" MM"월" DD"일" HH24:MI:SS')
		AS BOARD_UPDATE_DATE,
	
	(SELECT COUNT(*)
	 FROM BOARD_LIKE L
	 WHERE L.BOARD_NO = B.BOARD_NO) AS LIKE_COUNT,
	 
	(SELECT IMG_PATH || IMG_RENAME 
	 FROM BOARD_IMG I 
	 WHERE IMAGE_ORDER = 0 
	 AND I.BOARD_NO = B.BOARD_NO) AS THUMBNAIL
	 
FROM "BOARD" B
JOIN "MEMBER" M ON (B.MEMBER_NO = M.MEMBER_NO)
WHERE BOARD_NO = 2011
AND BOARD_CODE = 1;


SELECT *
FROM BOARD_IMG;

--------------------------------------------------
/* 댓글 샘플 데이터 추가*/
INSERT INTO "COMMENT"
VALUES(
	SEQ_COMMENT_NO.NEXTVAL, '부모 댓글 3',
	DEFAULT, DEFAULT, 1, 2023, NULL 
);

-- 부모 댓글 1 의 자식 댓글
INSERT INTO "COMMENT"
VALUES(
	SEQ_COMMENT_NO.NEXTVAL, '자식 댓글 1-1',
	DEFAULT, DEFAULT, 1, 2023, 3001 
);

INSERT INTO "COMMENT"
VALUES(
	SEQ_COMMENT_NO.NEXTVAL, '자식 댓글 1-2',
	DEFAULT, DEFAULT, 1, 2023, 3001 
);

INSERT INTO "COMMENT"
VALUES(
	SEQ_COMMENT_NO.NEXTVAL, '자식 댓글 2-1',
	DEFAULT, DEFAULT, 1, 2023, 3002
);

INSERT INTO "COMMENT"
VALUES(
	SEQ_COMMENT_NO.NEXTVAL, '자식 댓글 2-2',
	DEFAULT, DEFAULT, 1, 2023, 3002
);


INSERT INTO "COMMENT"
VALUES(
	SEQ_COMMENT_NO.NEXTVAL, '후손 댓글 1-1-1',
	DEFAULT, DEFAULT, 1, 2023, 3004 
);


INSERT INTO "COMMENT"
VALUES(
	SEQ_COMMENT_NO.NEXTVAL, '후손 댓글 1-1-2',
	DEFAULT, DEFAULT, 1, 2023, 3004 
);

COMMIT;

/* 특정 게시글의 댓글 목록 조회 + 계층형 쿼리 */
/* 대댓글 조회 순서를 위해!*/

--LEVEL 컬럼 : 현재 계층 레벨 출력
SELECT 
	LEVEL,
	COMMENT_NO, PARENT_COMMENT_NO2, COMMENT_CONTENT
FROM "COMMENT"
WHERE BOARD_NO = 2023

/* 계층형 쿼리 추가 */
-- PARENT_COMMENT_NO 값이 NULL 인 행이
-- 계층의 시작 부분 --
-- LEVEL == 1
START WITH PARENT_COMMENT_NO2 IS NULL

-- PARENT_COMMENT_NO 값이 COMMENT_NO 와 같은 행을
-- 자식으로 지정하여 연결
CONNECT BY PRIOR COMMENT_NO = PARENT_COMMENT_NO2

-- SIBLINGS(형제들, 같은 레벨) 간의 정렬 순서를 COMMENT_NO 오름차순
ORDER SIBLINGS BY COMMENT_NO ASC;



/* 실제 사용할 댓글 목록 조회 + 계층형 쿼리 */
SELECT LEVEL, C.* FROM
	(SELECT COMMENT_NO, COMMENT_CONTENT,
	    TO_CHAR(COMMENT_WRITE_DATE, 'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초"') COMMENT_WRITE_DATE,
	    BOARD_NO, MEMBER_NO, MEMBER_NICKNAME, PROFILE_IMG, PARENT_COMMENT_NO2, COMMENT_DEL_FL
	FROM "COMMENT"
	JOIN MEMBER USING(MEMBER_NO)
	WHERE BOARD_NO = 2023) C
WHERE COMMENT_DEL_FL = 'N'
OR 0 != (SELECT COUNT(*) FROM "COMMENT" SUB
				WHERE SUB.PARENT_COMMENT_NO2 = C.COMMENT_NO
				AND COMMENT_DEL_FL = 'N')
START WITH PARENT_COMMENT_NO2 IS NULL
CONNECT BY PRIOR COMMENT_NO = PARENT_COMMENT_NO2
ORDER SIBLINGS BY COMMENT_NO
;


COMMIT;

SELECT COUNT(*)
FROM "BOARD_LIKE";


SELECT 
	BOARD_CODE "boardCode",
	BOARD_NAME "boardName"		
FROM
	"BOARD_TYPE"
ORDER BY BOARD_CODE ASC;

	
INSERT INTO "BOARD_TYPE"
VALUES(4, '테스트');

SELECT *
FROM BOARD_TYPE;

COMMIT;
















