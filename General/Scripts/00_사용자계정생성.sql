-- 한줄 주석
/* 범위 주석 */

-- SQL 한 줄 실행 : ctrl + Enter

/* SYS 관리자 계정으로 수행하는 SQL */
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- 유저 생성
CREATE USER KH_JIJ IDENTIFIED BY KH1234; 

-- 권한 부여
GRANT RESOURCE, CONNECT TO KH_JIJ;

-- USERS 라는 공간에 20M 부여
ALTER USER KH_JIJ DEFAULT TABLESPACE USERS QUOTA 20M ON USERS;


