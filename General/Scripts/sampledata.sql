--- 샘플 카테고리 ---

INSERT INTO CATEGORY
VALUES (1, '한식');

INSERT INTO CATEGORY
VALUES (2, '중식');

INSERT INTO CATEGORY
VALUES (3, '일식');

INSERT INTO CATEGORY
VALUES (4, '양식');


-- 샘플 지역 코드

INSERT INTO LOCATION
VALUES (1, '혜화');

INSERT INTO LOCATION
VALUES (2, '명동');

INSERT INTO LOCATION
VALUES (3, '회현');

INSERT INTO LOCATION
VALUES (4, '충무로');

-- 샘플 회원 --

INSERT INTO "MEMBER"
VALUES (SEQ_MEMBER_NO.NEXTVAL,
				'MEMBER01', 'member01@jmt.co.kr',
				'pass01!', NULL, DEFAULT, 0, DEFAULT);
			
INSERT INTO "MEMBER"
VALUES (SEQ_MEMBER_NO.NEXTVAL,
				'MEMBER02', 'member02@jmt.co.kr',
				'pass02!', NULL, DEFAULT, 0, DEFAULT);
			
INSERT INTO "MEMBER"
VALUES (SEQ_MEMBER_NO.NEXTVAL,
				'MEMBER03', 'member03@jmt.co.kr',
				'pass03!', NULL, DEFAULT, 0, DEFAULT);
			

INSERT INTO "MEMBER"
VALUES (SEQ_MEMBER_NO.NEXTVAL,
				'MEMBER04', 'member04@jmt.co.kr',
				'pass04!', NULL, DEFAULT, 0, DEFAULT);
			
-- 어드민 계정 --
INSERT INTO "MEMBER"
VALUES (SEQ_MEMBER_NO.NEXTVAL,
				'Admin01', 'admin01@jmt.co.kr',
				'pass05!', NULL, DEFAULT, 2, DEFAULT);

			
			
			
-- 점메추 -- 게시판 샘플 -- 
			
/* 게시판 (BOARD) 샘플 추가 */

/* 게시글 번호 시퀀스 생성 */
CREATE SEQUENCE SEQ_BOARD_NO NOCACHE;

/* PL/SQL 을 이용해서 BOARD 테이블에 샘플 데이터 삽입 */
BEGIN 
	FOR I IN 1..20 LOOP
		INSERT INTO "BOARD"
		VALUES(
			SEQ_BOARD_NO.NEXTVAL,
			SEQ_BOARD_NO.CURRVAL || '번째 게시글',
			SEQ_BOARD_NO.CURRVAL || '번째 게시글 내용 입니다',
			DEFAULT, NULL, DEFAULT,
			1
		);
	END LOOP;
END;



----------------------------------------------------------
----------------------------------------------------------
SELECT *
FROM CATEGORY;

SELECT *
FROM LOCATION;

SELECT *
FROM "MEMBER";

SELECT *
FROM "BOARD";

SELECT 
		CATEGORY_NO "categoryNo" ,
		CATEGORY_NAME "categoryName"
FROM CATEGORY;

COMMIT;

ROLLBACK;