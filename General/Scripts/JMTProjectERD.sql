CREATE TABLE "MEMBER" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"MEMBER_NAME"	NVARCHAR2(10)		NOT NULL,
	"MEMBER_EMAIL"	VARCHAR2(50)		NOT NULL,
	"MEMBER_PW"	VARCHAR2(100)		NOT NULL,
	"PROFILE_IMG"	VARCHAR2(300)		NULL,
	"MEMBER_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_AUTH"	NUMBER		NOT NULL,
	"MEMBER_DATE"	DATE	DEFAULT CURRENT_DATE	NOT NULL
);

COMMENT ON COLUMN "MEMBER"."MEMBER_NO" IS '시퀀스 회원 번호';

COMMENT ON COLUMN "MEMBER"."MEMBER_NAME" IS '회원 이름';

COMMENT ON COLUMN "MEMBER"."MEMBER_EMAIL" IS '회원 이메일';

COMMENT ON COLUMN "MEMBER"."MEMBER_PW" IS '회원 비밀번호';

COMMENT ON COLUMN "MEMBER"."PROFILE_IMG" IS '회원 프로필 NULL 가능';

COMMENT ON COLUMN "MEMBER"."MEMBER_DEL_FL" IS '회원 탈퇴여부(Y,N)';

COMMENT ON COLUMN "MEMBER"."MEMBER_AUTH" IS '회원 권한';

COMMENT ON COLUMN "MEMBER"."MEMBER_DATE" IS '회원 가입일';

CREATE TABLE "RESTAURANT" (
	"RESTAURANT_NO"	NUMBER		NOT NULL,
	"RESTAURANT_NAME"	NVARCHAR2(20)		NOT NULL,
	"RESTAURANT_ADDRESS"	NVARCHAR2(150)		NOT NULL,
	"RESTAURANT_TEL"	CHAR(11)		NOT NULL,
	"RESTAURANT_IMG1"	VARCHAR2(300)		NOT NULL,
	"RESTAURANT_IMG2"	VARCHAR2(300)		NOT NULL,
	"RESTAURANT_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"LOCATION_NO"	NUMBER		NOT NULL,
	"CATEGORY_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "RESTAURANT"."RESTAURANT_NO" IS '가게 번호';

COMMENT ON COLUMN "RESTAURANT"."RESTAURANT_NAME" IS '가게 이름';

COMMENT ON COLUMN "RESTAURANT"."RESTAURANT_ADDRESS" IS '가게 주소';

COMMENT ON COLUMN "RESTAURANT"."RESTAURANT_TEL" IS '가게 전화번호';

COMMENT ON COLUMN "RESTAURANT"."RESTAURANT_IMG1" IS '경로 + 이름';

COMMENT ON COLUMN "RESTAURANT"."RESTAURANT_IMG2" IS '가게 이미지 2';

COMMENT ON COLUMN "RESTAURANT"."RESTAURANT_DEL_FL" IS '가게 삭제 여부(Y,N)';

COMMENT ON COLUMN "RESTAURANT"."LOCATION_NO" IS '지역 코드';

COMMENT ON COLUMN "RESTAURANT"."CATEGORY_NO" IS '카테고리 코드';

CREATE TABLE "REVIEW" (
	"REVIEW_NO"	NUMBER		NOT NULL,
	"REVIEW_CONTENT"	CLOB		NOT NULL,
	"LIKE_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"REVIEW_DATE"	DATE	DEFAULT CURRENT_DATE	NOT NULL,
	"REVIEW_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"RESTAURANT_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "REVIEW"."REVIEW_NO" IS '리뷰 번호';

COMMENT ON COLUMN "REVIEW"."REVIEW_CONTENT" IS '리뷰 본문';

COMMENT ON COLUMN "REVIEW"."LIKE_FL" IS '리뷰 좋아요 여부(Y,N)';

COMMENT ON COLUMN "REVIEW"."REVIEW_DATE" IS '리뷰 작성일';

COMMENT ON COLUMN "REVIEW"."REVIEW_DEL_FL" IS '리뷰 삭제 여부(Y,N)';

COMMENT ON COLUMN "REVIEW"."RESTAURANT_NO" IS '가게 번호';

COMMENT ON COLUMN "REVIEW"."MEMBER_NO" IS '리뷰 작성자 회원 번호';

CREATE TABLE "BOARD" (
	"BOARD_NO"	NUMBER		NOT NULL,
	"BOARD_TITLE"	NVARCHAR2(100)		NOT NULL,
	"BOARD_CONTENT"	CLOB		NOT NULL,
	"BOARD_DATE"	DATE	DEFAULT CURRENT_DATE	NOT NULL,
	"BOARD_IMG"	VARCHAR2(300)		NULL,
	"BOARD_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD"."BOARD_NO" IS '게시글 번호';

COMMENT ON COLUMN "BOARD"."BOARD_TITLE" IS '게시글 제목';

COMMENT ON COLUMN "BOARD"."BOARD_CONTENT" IS '게시글 내용';

COMMENT ON COLUMN "BOARD"."BOARD_DATE" IS '게시글 작성일';

COMMENT ON COLUMN "BOARD"."BOARD_IMG" IS '게시글 이미지';

COMMENT ON COLUMN "BOARD"."BOARD_DEL_FL" IS '게시글 삭제 여부(Y,N)';

COMMENT ON COLUMN "BOARD"."MEMBER_NO" IS '게시글 작성자 회원 번호';

CREATE TABLE "COMMENT" (
	"COMMENT_NO"	NUMBER		NOT NULL,
	"COMMENT_CONTENT"	VARCHAR2(4000)	NOT NULL,
	"COMMENT_DATE"	DATE	DEFAULT CURRENT_DATE	NOT NULL,
	"COMMENT_IMG"	VARCHAR2(300)		NULL,
	"COMMENT_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL,
	"PARENT_COMMENT_NO"	NUMBER		NULL
);

COMMENT ON COLUMN "COMMENT"."COMMENT_NO" IS '댓글 번호';

COMMENT ON COLUMN "COMMENT"."COMMENT_CONTENT" IS '댓글 내용';

COMMENT ON COLUMN "COMMENT"."COMMENT_DATE" IS '댓글 작성일';

COMMENT ON COLUMN "COMMENT"."COMMENT_IMG" IS '댓글 이미지';

COMMENT ON COLUMN "COMMENT"."COMMENT_DEL_FL" IS '댓글 삭제  여부 (Y,N)';

COMMENT ON COLUMN "COMMENT"."MEMBER_NO" IS '댓글 작성자 회원 번호';

COMMENT ON COLUMN "COMMENT"."BOARD_NO" IS '게시글 번호';

COMMENT ON COLUMN "COMMENT"."PARENT_COMMENT_NO" IS '부모 댓글 번호';

CREATE TABLE "MENU" (
	"MENU_NO"	NUMBER		NOT NULL,
	"MENU_NAME"	NVARCHAR2(20)		NOT NULL,
	"MENU_PRICE"	VARCHAR2(20)		NOT NULL,
	"RESTAURANT_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "MENU"."MENU_NO" IS '메뉴 번호';

COMMENT ON COLUMN "MENU"."MENU_NAME" IS '메뉴 이름';

COMMENT ON COLUMN "MENU"."MENU_PRICE" IS '가격';

COMMENT ON COLUMN "MENU"."RESTAURANT_NO" IS '가게 번호';

CREATE TABLE "FAQ" (
	"FAQ_NO"	NUMBER		NOT NULL,
	"FAQ_TITLE"	VARCHAR2(100)		NOT NULL,
	"FAQ_CONTENT"	CLOB		NOT NULL,
	"FAQ_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL
);

COMMENT ON COLUMN "FAQ"."FAQ_NO" IS 'FAQ 번호';

COMMENT ON COLUMN "FAQ"."FAQ_TITLE" IS 'FAQ 제목';

COMMENT ON COLUMN "FAQ"."FAQ_CONTENT" IS 'FAQ 내용';

COMMENT ON COLUMN "FAQ"."FAQ_DEL_FL" IS 'FAQ 삭제여부(Y,N)';

CREATE TABLE "BOOKMARK" (
	"RESTAURANT_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOOKMARK"."RESTAURANT_NO" IS '가게 번호';

COMMENT ON COLUMN "BOOKMARK"."MEMBER_NO" IS '시퀀스 회원 번호';

CREATE TABLE "NOTICE" (
	"NOTICE_NO"	NUMBER		NOT NULL,
	"NOTICE_TITLE"	NVARCHAR2(100)		NOT NULL,
	"NOTICE_CONTENT"	CLOB		NOT NULL,
	"NOTICE_WRITE_DATE"	DATE		NOT NULL,
	"NOTICE_DEL_FL"	CHAR(1)		NOT NULL,
	"NOTICE_READ_COUNT"	NUMBER	DEFAULT 0	NOT NULL
);

COMMENT ON COLUMN "NOTICE"."NOTICE_NO" IS '공지사항 번호';

COMMENT ON COLUMN "NOTICE"."NOTICE_TITLE" IS '공지사항 제목';

COMMENT ON COLUMN "NOTICE"."NOTICE_CONTENT" IS '공지사항 내용';

COMMENT ON COLUMN "NOTICE"."NOTICE_WRITE_DATE" IS '공지사항 작성일';

COMMENT ON COLUMN "NOTICE"."NOTICE_DEL_FL" IS '공지사항 삭제여부';

COMMENT ON COLUMN "NOTICE"."NOTICE_READ_COUNT" IS '조회수';

CREATE TABLE "LOCATION" (
	"LOCATION_NO"	NUMBER		NOT NULL,
	"LOCATION_NAME"	NVARCHAR2(20)		NOT NULL
);

COMMENT ON COLUMN "LOCATION"."LOCATION_NO" IS '지역코드';

COMMENT ON COLUMN "LOCATION"."LOCATION_NAME" IS '지역명';

CREATE TABLE "CATEGORY" (
	"CATEGORY_NO"	NUMBER		NOT NULL,
	"CATEGORY_NAME"	NVARCHAR2(20)		NOT NULL
);

COMMENT ON COLUMN "CATEGORY"."CATEGORY_NO" IS '카테고리 코드';

COMMENT ON COLUMN "CATEGORY"."CATEGORY_NAME" IS '카테고리명';

CREATE TABLE "REVIEW_IMAGE" (
	"REVIEW_IMG_NO"	NUMBER		NOT NULL,
	"REVIEW_IMG_PATH"	VARCHAR2(300)		NOT NULL,
	"REVIEW_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "REVIEW_IMAGE"."REVIEW_IMG_NO" IS '리뷰 이미지';

COMMENT ON COLUMN "REVIEW_IMAGE"."REVIEW_IMG_PATH" IS '리뷰 이미지 경로+이름';

COMMENT ON COLUMN "REVIEW_IMAGE"."REVIEW_NO" IS '리뷰 번호';

CREATE TABLE "REPORT_BOARD" (
	"REPORT_BOARD_NO"	NUMBER		NOT NULL,
	"REPORT_BOARD_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"REPORT_BOARD_DATE"	DATE	DEFAULT CURRENT_DATE	NOT NULL,
	"REPORT_BOARD_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"BOARD_NO"	NUMBER		NOT NULL,
	"REPORT_TYPE_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "REPORT_BOARD"."REPORT_BOARD_NO" IS '신고 번호';

COMMENT ON COLUMN "REPORT_BOARD"."REPORT_BOARD_CONTENT" IS '신고 내용';

COMMENT ON COLUMN "REPORT_BOARD"."REPORT_BOARD_DATE" IS '신고 일자';

COMMENT ON COLUMN "REPORT_BOARD"."REPORT_BOARD_FL" IS '신고 처리 여부';

COMMENT ON COLUMN "REPORT_BOARD"."MEMBER_NO" IS '신고자  회원 번호';

COMMENT ON COLUMN "REPORT_BOARD"."BOARD_NO" IS '신고 대상 게시글 번호';

COMMENT ON COLUMN "REPORT_BOARD"."REPORT_TYPE_NO" IS '신고 코드';

CREATE TABLE "REPORT_COMMENT" (
	"REPORT_COMMENT_NO"	NUMBER		NOT NULL,
	"REPORT_COMMENT_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"REPORT_COMMENT_DATE"	DATE	DEFAULT CURRENT_DATE	NOT NULL,
	"REPORT_COMMENT_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"COMMENT_NO"	NUMBER		NOT NULL,
	"REPORT_TYPE_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "REPORT_COMMENT"."REPORT_COMMENT_NO" IS '신고 번호';

COMMENT ON COLUMN "REPORT_COMMENT"."REPORT_COMMENT_CONTENT" IS '신고 내용';

COMMENT ON COLUMN "REPORT_COMMENT"."REPORT_COMMENT_DATE" IS '신고 일자';

COMMENT ON COLUMN "REPORT_COMMENT"."REPORT_COMMENT_FL" IS '신고 처리 여부';

COMMENT ON COLUMN "REPORT_COMMENT"."MEMBER_NO" IS '신고자  회원 번호';

COMMENT ON COLUMN "REPORT_COMMENT"."COMMENT_NO" IS '신고 대상 댓글 번호';

COMMENT ON COLUMN "REPORT_COMMENT"."REPORT_TYPE_NO" IS '신고 코드';

CREATE TABLE "REPORT_REVIEW" (
	"REPORT_REVIEW_NO"	NUMBER		NOT NULL,
	"REPORT_REVIEW_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"REPORT_REVIEW_DATE"	DATE	DEFAULT CURRENT_DATE	NOT NULL,
	"REPORT_REVIEW_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"REVIEW_NO"	NUMBER		NOT NULL,
	"REPORT_TYPE_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "REPORT_REVIEW"."REPORT_REVIEW_NO" IS '신고 번호';

COMMENT ON COLUMN "REPORT_REVIEW"."REPORT_REVIEW_CONTENT" IS '신고 내용';

COMMENT ON COLUMN "REPORT_REVIEW"."REPORT_REVIEW_DATE" IS '신고 일자';

COMMENT ON COLUMN "REPORT_REVIEW"."REPORT_REVIEW_FL" IS '신고 처리 여부';

COMMENT ON COLUMN "REPORT_REVIEW"."MEMBER_NO" IS '신고자  회원 번호';

COMMENT ON COLUMN "REPORT_REVIEW"."REVIEW_NO" IS '신고 대상 리뷰 번호';

COMMENT ON COLUMN "REPORT_REVIEW"."REPORT_TYPE_NO" IS '신고 코드';

CREATE TABLE "NOTICE_IMAGE" (
	"NOTICE_IMG_NO"	NUMBER		NOT NULL,
	"NOTICE_IMG_PATH"	VARCHAR2(200)		NOT NULL,
	"NOTICE_IMG_ORIGINAL_NAME"	NVARCHAR2(50)		NOT NULL,
	"NOTICE_IMG_RENAME"	NVARCHAR2(50)		NOT NULL,
	"NOTICE_IMG_ORDER"	NUMBER		NULL,
	"NOTICE_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "NOTICE_IMAGE"."NOTICE_IMG_NO" IS '공지 이미지 번호';

COMMENT ON COLUMN "NOTICE_IMAGE"."NOTICE_IMG_PATH" IS '공지 이미지 경로';

COMMENT ON COLUMN "NOTICE_IMAGE"."NOTICE_IMG_ORIGINAL_NAME" IS '공지 이미지 원본명';

COMMENT ON COLUMN "NOTICE_IMAGE"."NOTICE_IMG_RENAME" IS '공지 이미지 변경명';

COMMENT ON COLUMN "NOTICE_IMAGE"."NOTICE_IMG_ORDER" IS '공지 이미지 순서';

COMMENT ON COLUMN "NOTICE_IMAGE"."NOTICE_NO" IS '게시글 번호';

CREATE TABLE "REPORT_TYPE" (
	"REPORT_TYPE_NO"	NUMBER		NOT NULL,
	"REPORT_TYPE_NAME"	NVARCHAR2(20)		NOT NULL
);

COMMENT ON COLUMN "REPORT_TYPE"."REPORT_TYPE_NO" IS '신고 코드';

COMMENT ON COLUMN "REPORT_TYPE"."REPORT_TYPE_NAME" IS '신고 유형';

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"MEMBER_NO"
);

ALTER TABLE "RESTAURANT" ADD CONSTRAINT "PK_RESTAURANT" PRIMARY KEY (
	"RESTAURANT_NO"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "PK_REVIEW" PRIMARY KEY (
	"REVIEW_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"BOARD_NO"
);

ALTER TABLE "COMMENT" ADD CONSTRAINT "PK_COMMENT" PRIMARY KEY (
	"COMMENT_NO"
);

ALTER TABLE "MENU" ADD CONSTRAINT "PK_MENU" PRIMARY KEY (
	"MENU_NO"
);

ALTER TABLE "FAQ" ADD CONSTRAINT "PK_FAQ" PRIMARY KEY (
	"FAQ_NO"
);

ALTER TABLE "BOOKMARK" ADD CONSTRAINT "PK_BOOKMARK" PRIMARY KEY (
	"RESTAURANT_NO",
	"MEMBER_NO"
);

ALTER TABLE "NOTICE" ADD CONSTRAINT "PK_NOTICE" PRIMARY KEY (
	"NOTICE_NO"
);

ALTER TABLE "LOCATION" ADD CONSTRAINT "PK_LOCATION" PRIMARY KEY (
	"LOCATION_NO"
);

ALTER TABLE "CATEGORY" ADD CONSTRAINT "PK_CATEGORY" PRIMARY KEY (
	"CATEGORY_NO"
);

ALTER TABLE "REVIEW_IMAGE" ADD CONSTRAINT "PK_REVIEW_IMAGE" PRIMARY KEY (
	"REVIEW_IMG_NO"
);

ALTER TABLE "REPORT_BOARD" ADD CONSTRAINT "PK_REPORT_BOARD" PRIMARY KEY (
	"REPORT_BOARD_NO"
);

ALTER TABLE "REPORT_COMMENT" ADD CONSTRAINT "PK_REPORT_COMMENT" PRIMARY KEY (
	"REPORT_COMMENT_NO"
);

ALTER TABLE "REPORT_REVIEW" ADD CONSTRAINT "PK_REPORT_REVIEW" PRIMARY KEY (
	"REPORT_REVIEW_NO"
);

ALTER TABLE "NOTICE_IMAGE" ADD CONSTRAINT "PK_NOTICE_IMAGE" PRIMARY KEY (
	"NOTICE_IMG_NO"
);

ALTER TABLE "REPORT_TYPE" ADD CONSTRAINT "PK_REPORT_TYPE" PRIMARY KEY (
	"REPORT_TYPE_NO"
);

ALTER TABLE "RESTAURANT" ADD CONSTRAINT "FK_LOCATION_TO_RESTAURANT_1" FOREIGN KEY (
	"LOCATION_NO"
)
REFERENCES "LOCATION" (
	"LOCATION_NO"
);

ALTER TABLE "RESTAURANT" ADD CONSTRAINT "FK_CATEGORY_TO_RESTAURANT_1" FOREIGN KEY (
	"CATEGORY_NO"
)
REFERENCES "CATEGORY" (
	"CATEGORY_NO"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "FK_RESTAURANT_TO_REVIEW_1" FOREIGN KEY (
	"RESTAURANT_NO"
)
REFERENCES "RESTAURANT" (
	"RESTAURANT_NO"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "FK_MEMBER_TO_REVIEW_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
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
	"PARENT_COMMENT_NO"
)
REFERENCES "COMMENT" (
	"COMMENT_NO"
);

ALTER TABLE "MENU" ADD CONSTRAINT "FK_RESTAURANT_TO_MENU_1" FOREIGN KEY (
	"RESTAURANT_NO"
)
REFERENCES "RESTAURANT" (
	"RESTAURANT_NO"
);

ALTER TABLE "BOOKMARK" ADD CONSTRAINT "FK_RESTAURANT_TO_BOOKMARK_1" FOREIGN KEY (
	"RESTAURANT_NO"
)
REFERENCES "RESTAURANT" (
	"RESTAURANT_NO"
);

ALTER TABLE "BOOKMARK" ADD CONSTRAINT "FK_MEMBER_TO_BOOKMARK_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "REVIEW_IMAGE" ADD CONSTRAINT "FK_REVIEW_TO_REVIEW_IMAGE_1" FOREIGN KEY (
	"REVIEW_NO"
)
REFERENCES "REVIEW" (
	"REVIEW_NO"
);

ALTER TABLE "REPORT_BOARD" ADD CONSTRAINT "FK_MEMBER_TO_REPORT_BOARD_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "REPORT_BOARD" ADD CONSTRAINT "FK_BOARD_TO_REPORT_BOARD_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "REPORT_BOARD" ADD CONSTRAINT "FK_REPORT_TYPE_TO_REPORT_BOARD_1" FOREIGN KEY (
	"REPORT_TYPE_NO"
)
REFERENCES "REPORT_TYPE" (
	"REPORT_TYPE_NO"
);

ALTER TABLE "REPORT_COMMENT" ADD CONSTRAINT "FK_MEMBER_TO_REPORT_COMMENT_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "REPORT_COMMENT" ADD CONSTRAINT "FK_COMMENT_TO_REPORT_COMMENT_1" FOREIGN KEY (
	"COMMENT_NO"
)
REFERENCES "COMMENT" (
	"COMMENT_NO"
);

ALTER TABLE "REPORT_COMMENT" ADD CONSTRAINT "FK_REPORT_TYPE_TO_REPORT_COMMENT_1" FOREIGN KEY (
	"REPORT_TYPE_NO"
)
REFERENCES "REPORT_TYPE" (
	"REPORT_TYPE_NO"
);

ALTER TABLE "REPORT_REVIEW" ADD CONSTRAINT "FK_MEMBER_TO_REPORT_REVIEW_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "REPORT_REVIEW" ADD CONSTRAINT "FK_REVIEW_TO_REPORT_REVIEW_1" FOREIGN KEY (
	"REVIEW_NO"
)
REFERENCES "REVIEW" (
	"REVIEW_NO"
);

ALTER TABLE "REPORT_REVIEW" ADD CONSTRAINT "FK_REPORT_TYPE_TO_REPORT_REVIEW_1" FOREIGN KEY (
	"REPORT_TYPE_NO"
)
REFERENCES "REPORT_TYPE" (
	"REPORT_TYPE_NO"
);

ALTER TABLE "NOTICE_IMAGE" ADD CONSTRAINT "FK_NOTICE_TO_NOTICE_IMAGE_1" FOREIGN KEY (
	"NOTICE_NO"
)
REFERENCES "NOTICE" (
	"NOTICE_NO"
);







-- CHECK 제약 조건 추가 ----------------------



/* MEMBER 테이블 MEMBER_DEL_FL CHECK 제약 조건 추가 */
ALTER TABLE "MEMBER"
ADD CONSTRAINT "CHK_MEMBER_DEL_FL"
CHECK(MEMBER_DEL_FL IN ('Y', 'N'));

/* BOARD 테이블 BOARD_DEL_FL CHECK 제약 조건 추가 */
ALTER TABLE "BOARD"
ADD CONSTRAINT "CHK_BOARD_DEL_FL"
CHECK(BOARD_DEL_FL IN ('Y', 'N'));

/* COMMENT 테이블 COMMENT_DEL_FL CHECK 제약 조건 추가 */
ALTER TABLE "COMMENT"
ADD CONSTRAINT "CHK_COMMENT_DEL_FL"
CHECK(COMMENT_DEL_FL IN ('Y', 'N'));

/* REPORT_REVIEW 테이블 REPORT_REVIEW_FL CHECK 제약 조건 추가 */
ALTER TABLE "REPORT_REVIEW"
ADD CONSTRAINT "CHK_REPORT_REVIEW_FL"
CHECK(REPORT_REVIEW_FL IN ('Y', 'N'));


/* REPORT_BOARD 테이블 REPORT_BOARD_FL CHECK 제약 조건 추가 */
ALTER TABLE "REPORT_BOARD"
ADD CONSTRAINT "CHK_REPORT_BOARD_FL"
CHECK(REPORT_BOARD_FL IN ('Y', 'N'));


/* REPORT_COMMENT 테이블 REPORT_COMMENT_FL CHECK 제약 조건 추가 */
ALTER TABLE "REPORT_COMMENT"
ADD CONSTRAINT "CHK_REPORT_COMMENT_FL"
CHECK(REPORT_COMMENT_FL IN ('Y', 'N'));


/* RESTAURANT 테이블 RESTAURANT_DEL_FL CHECK 제약 조건 추가 */
ALTER TABLE "RESTAURANT"
ADD CONSTRAINT "CHK_RESTAURANT_DEL_FL"
CHECK(RESTAURANT_DEL_FL IN ('Y', 'N'));


/* REVIEW 테이블 REVIEW_DEL_FL CHECK 제약 조건 추가 */
ALTER TABLE "REVIEW"
ADD CONSTRAINT "CHK_REVIEW_DEL_FL"
CHECK(REVIEW_DEL_FL IN ('Y', 'N'));


/* NOTICE 테이블 NOTICE_DEL_FL CHECK 제약 조건 추가 */
ALTER TABLE "NOTICE"
ADD CONSTRAINT "CHK_NOTICE_DEL_FL"
CHECK(NOTICE_DEL_FL IN ('Y', 'N'));


/* FAQ 테이블 FAQ_DEL_FL CHECK 제약 조건 추가 */
ALTER TABLE "FAQ"
ADD CONSTRAINT "CHK_FAQ_DEL_FL"
CHECK(FAQ_DEL_FL IN ('Y', 'N'));




-----시퀀스 생성-------

-- 회원 번호 생성용 시퀀스 
CREATE SEQUENCE SEQ_MEMBER_NO NOCACHE;

-- 가게 번호 생성용 시퀀스 
CREATE SEQUENCE SEQ_RESTAURANT_NO NOCACHE;

-- 리뷰 번호 생성용 시퀀스 
CREATE SEQUENCE SEQ_REVIEW_NO NOCACHE;

-- 점메추 게시글 번호 생성용 시퀀스 
CREATE SEQUENCE SEQ_BOARD_NO NOCACHE;

-- 댓글 번호 생성용 시퀀스 
CREATE SEQUENCE SEQ_COMMENT_NO NOCACHE;

-- 메뉴 번호 생성용 시퀀스 
CREATE SEQUENCE SEQ_MENU_NO NOCACHE;

-- FAQ 번호 생성용 시퀀스 
CREATE SEQUENCE SEQ_FAQ_NO NOCACHE;

-- 공지사항 번호 생성용 시퀀스 
CREATE SEQUENCE SEQ_NOTICE_NO NOCACHE;

-- 리뷰 이미지 번호 생성용 시퀀스 
CREATE SEQUENCE SEQ_REVIEW_IMG_NO NOCACHE;

-- 게시판 신고 번호 생성용 시퀀스 
CREATE SEQUENCE SEQ_REPORT_BOARD_NO NOCACHE;

-- 댓글 신고 번호 생성용 시퀀스 
CREATE SEQUENCE SEQ_REPORT_COMMENT_NO NOCACHE;

-- 리뷰 신고 번호 생성용 시퀀스 
CREATE SEQUENCE SEQ_REPORT_REVIEW_NO NOCACHE;

-- 공지 이미지 번호 생성용 시퀀스 
CREATE SEQUENCE SEQ_NOTICE_IMG_NO NOCACHE;


COMMIT;
