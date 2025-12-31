-- 샘플 emp 테이블 조회 해보기
-- vscode에서 실행하는 방법 , 한문장 단위 실행 : ctrl + enter
-- 주의사항, 최초 실행시, vscode 측에서, 서버를 선택하는 메뉴가 나오면, 
-- 이전에 설치한 연결 설정을 선택하기. 
select * from emp; 

--현재 시간 조회 
select sysdate from dual;


-- select * 은 해당 테이블의 모든 컬럼을 조회
-- from emp 는 조회할 테이블 명
-- where은 컬럼명 = 값; : 조건을 만족하는 문구
-- 아래 예시)
SELECT * FROM EMP
WHERE JOB = 'MANAGER';
-- 예시 해석 : emp 테이블에서, job 칼럼의 값이 manager인 사원을 찾음, 출력 열은 모든 컬럼.


-- Projection은 열 중심 조회
-- 특정 **열(Column)**만 선택하여 조회
-- 보고 싶은 열, ENAME 사원 이름, SAL 급여
SELECT ENAME, SAL FROM EMP;

-- 보고 싶은 열 ? 모든 열
SELECT * FROM EMP;



-- 셀렉션 + 프로젝션 함께 사용
-- 보고 싶은 열 : ENAME 사원이름, SAL 급여
-- 조건 : SAL > 2000 , 사원만 조회.
SELECT ENAME, SAL FROM EMP
WHERE SAL > 2000;



-- ==============================실습1번-3번 완료==============================

-- 단일 열에서 중복 제거 예시
SELECT DISTINCT job FROM EMP;

SELECT job FROM EMP;

-- 다중 열에서 중복 제거 예시
SELECT DISTINCT JOB, DEPTNO FROM EMP;

SELECT JOB, DEPTNO FROM EMP;


