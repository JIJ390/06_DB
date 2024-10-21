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


-------------------------------------------
-- 가게 정보 --

INSERT INTO "RESTAURANT"
VALUES(
	SEQ_RESTAURANT_NO,
	"가게 이름",
	"가게 주소",
	"가게 전화 번호",
	"이미지 1",
	"이미지 2",
	DEFAULT,
	"지역 코드",
	"카테고리 코드"
)


---

-- SEQ_MENU_NO 시퀀스의 다음 값을 반환하는 함수 생성
CREATE OR REPLACE FUNCTION NEXT_MENU_NO

-- 반환형
RETURN NUMBER

-- 사용할 변수
IS MENU_NO NUMBER;

BEGIN 
	SELECT SEQ_MENU_NO.NEXTVAL 
	INTO MENU_NO
	FROM DUAL;

	RETURN MENU_NO;
END;


UPDATE "MEMBER"
SET 
	MEMBER_DEL_FL = 'Y'
WHERE
	MEMBER_NO = 2;

UPDATE "MEMBER"
SET 
	MEMBER_AUTH = 1
WHERE
	MEMBER_NO = 3;




----------------------------------------------------------
----------------------------------------------------------
SELECT
	(SELECT COUNT(*)
	 FROM "MEMBER"
	 WHERE MEMBER_DEL_FL = 'N'
	 AND   MEMBER_AUTH IN (0, 2)) AS "ACTIVE_MEMBER",
	(SELECT COUNT(*)
	 FROM "MEMBER") AS "TOTAL_MEMBER",	
	(SELECT COUNT(*)
	 FROM "MEMBER"
	 WHERE MEMBER_AUTH = 1) AS "BLOCK_MEMBER",
	(SELECT COUNT(*)
	 FROM "MEMBER"
	 WHERE MEMBER_DEL_FL = 'N') AS "SECESSION_MEMBER"
FROM
	DUAL;


SELECT *
FROM CATEGORY;

SELECT *
FROM LOCATION;

SELECT *
FROM "MEMBER";

SELECT *
FROM "BOARD";

SELECT *
FROM "RESTAURANT";

SELECT *
FROM REVIEW;

SELECT 
	SEQ_RESTAURANT_NO.NEXTVAL
FROM 
	DUAL;

SELECT *
FROM "MENU";

SELECT 
		CATEGORY_NO "categoryNo" ,
		CATEGORY_NAME "categoryName"
FROM CATEGORY;

COMMIT;

ROLLBACK;


SELECT 
	RESTAURANT_NO, 
	RESTAURANT_NAME,
	LOCATION_NAME,
	CATEGORY_NAME,
	RESTAURANT_IMG1,
	
	(SELECT COUNT(*)	-- 가게당 리뷰 수
	 FROM REVIEW
	 WHERE RESTAURANT_NO = R.RESTAURANT_NO) AS REVIEW_COUNT, 
	 
	(SELECT COUNT(*)	-- 가게당 좋아요 수
	 FROM REVIEW
	 WHERE LIKE_FL = 'Y'
	 AND RESTAURANT_NO = R.RESTAURANT_NO) AS LIKE_COUNT,
	 
	 NVL(		-- 분모(전체 리뷰 개수) 가 0 일때 발생하는 오류 처리
	 		(SELECT COUNT(*)
			 FROM REVIEW
			 WHERE LIKE_FL = 'Y'
			 AND RESTAURANT_NO = R.RESTAURANT_NO) /	
			 
			 NULLIF(		-- 분모가 0이면 NULL 로 처리 -> NULL 이면 전체 값을 0으로
			 			 (SELECT COUNT(*)
						 FROM REVIEW
			 			 WHERE RESTAURANT_NO = R.RESTAURANT_NO), 0), 0
	 ) * 100 AS "LIKE_PERCENT"	-- 리뷰당 좋아요 백분율 지수

FROM RESTAURANT R
JOIN LOCATION USING (LOCATION_NO)
JOIN CATEGORY USING (CATEGORY_NO)
WHERE RESTAURANT_DEL_FL = 'N'		-- 필요에 따라 조건 추가!!
GROUP BY R.RESTAURANT_NO, R.RESTAURANT_NAME, LOCATION_NAME,	CATEGORY_NAME, RESTAURANT_IMG1
ORDER BY REVIEW_COUNT ASC; -- 원하는 대로 정렬 조건 넣기




	 
	 