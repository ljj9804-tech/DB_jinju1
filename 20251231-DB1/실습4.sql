-- 정렬하기 실습

-- 1)급여 기준 오름차순 정렬
SELECT * FROM EMP
ORDER BY SAL;

-- 2)급여 기준 내림차순 정렬
SELECT * FROM EMP
ORDER BY SAL DESC;

-- 3)부서번호 오름차순 + 급여 내림차순 정렬
SELECT * FROM EMP
ORDER BY DEPTNO, SAL DESC;

-- 4)EMP 테이블에서 사원 이름과 급여를 급여 기준으로 오름차순 정렬하시오.
SELECT ENAME, SAL FROM EMP
ORDER BY SAL;

-- 5)EMP 테이블에서 모든 사원을 입사일(HIREDATE) 기준으로 최신순으로 정렬하시오.
SELECT * FROM EMP
ORDER BY HIREDATE DESC;

-- 6)EMP 테이블에서 부서번호(오름차순), 이름(내림차순) 기준으로 정렬하시오.
SELECT * FROM EMP
ORDER BY DEPTNO, ENAME DESC;

-- 7)커미션이 높은 순으로, 급여가 낮은 순으로 정렬하여 출력하시오.
SELECT * FROM EMP
ORDER BY COMM DESC, SAL;

-- 8)EMP 테이블에서 이름, 부서번호, 급여를 출력하되, 급여가 높은 순으로 정렬하시오.
SELECT ENAME, DEPTNO, SAL FROM EMP
ORDER BY SAL DESC;

-- 9)SALGRADE 테이블에서 급여 등급(GRADE)을 오름차순, 최고급여(HISAL)는 내림차순으로 정렬하시오.
SELECT * FROM SALGRADE
ORDER BY GRADE, HISAL DESC;
