
-- 조회하기(기초) 실습

SELECT * FROM EMP;

-- 실습1
SELECT * FROM EMP
WHERE SAL >= 3000;

-- 실습2
SELECT ENAME, SAL, DEPTNO FROM EMP;

-- 실습3
SELECT ENAME, SAL FROM EMP
WHERE DEPTNO = 20;

-- +부서번호 궁금하면 보고싶은 열(DEPTNO)추가하면 됨
SELECT ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 20;


-- SQL 대소문자 구분 ???
-- 예약어는 대문자 사용이 정석 but. 편의상 소문자 사용해도 인식함.

