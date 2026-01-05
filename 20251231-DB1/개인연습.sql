-- [기본 비교] EMP 테이블에서 급여(SAL)가 3000 이상인 사원의 이름(ENAME)과 직급(JOB)을 출력하세요.
SELECT ENAME, JOB FROM EMP
WHERE SAL >= 3000;

-- [일치] 부서 번호(DEPTNO)가 10번인 사원의 모든 정보를 조회하세요.
SELECT * FROM EMP
WHERE DEPTNO = 10;

-- [불일치] 직급(JOB)이 'SALESMAN'이 아닌 사원들의 명단을 출력하세요.
SELECT * FROM EMP
MINUS
SELECT * FROM EMP
WHERE JOB = 'SALESMAN';

SELECT * FROM EMP
WHERE JOB != 'SALESMAN';

-- 중급 문제
-- [BETWEEN] 급여(SAL)가 2000에서 3000 사이인 사원의 이름과 급여를 출력하세요.
SELECT ENAME, SAL FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;

-- [IN] 사원 번호(EMPNO)가 7369, 7566, 7788 중 하나에 해당되는 사원을 조회하세요.
SELECT * FROM EMP
WHERE EMPNO IN(7369, 7566, 7788);

-- [LIKE] 이름(ENAME)이 'S'로 시작하는 사원의 모든 정보를 출력하세요.
SELECT * FROM EMP
WHERE ENAME LIKE 'S%';

-- [LIKE 응용] 이름의 두 번째 글자가 'A'인 사원을 조회하세요.
SELECT * FROM EMP
WHERE ENAME LIKE '_A%';

-- 고급/복합 문제
-- [IS NULL] 보너스(COMM)가 NULL인 사원들의 이름과 급여를 출력하세요.
SELECT ENAME, SAL FROM EMP
WHERE COMM IS NULL;

-- [AND/OR] 부서 번호가 20번이면서 직급이 'CLERK'인 사원을 조회하세요.
SELECT * FROM EMP
WHERE DEPTNO = 20 AND JOB = 'CLERK';

-- [복합 조건] 급여가 1500 이상이거나, 직급이 'MANAGER'인 사원 중 이름에 'A'가 포함된 사원을 출력하세요.
SELECT * FROM EMP
WHERE (SAL >= 1500 OR JOB = 'MANAGER')
AND ENAME LIKE '%A%';

-- ==============================================================

-- 1. UNION vs UNION ALL (중복 처리)
-- 문제: 10번 부서 사원의 직급(JOB) 목록과 20번 부서 사원의 직급 목록을 각각 UNION과 UNION ALL로 합쳐보세요.
-- 관전 포인트: 'CLERK'이나 'MANAGER' 같은 공통 직급이 어떻게 출력되는지 확인하세요.
SELECT JOB FROM EMP
WHERE DEPTNO = 10
UNION
SELECT JOB FROM EMP
WHERE DEPTNO = 20;

SELECT JOB FROM EMP
WHERE DEPTNO = 10
UNION ALL
SELECT JOB FROM EMP
WHERE DEPTNO = 20;

-- 2. INTERSECT (공통 항목 찾기)
-- 문제: 급여(SAL)가 1500~3000 사이인 사원의 이름과, 2000~5000 사이인 사원의 이름을 합쳐 공통으로 포함된 사원만 출력하세요.
SELECT ENAME, SAL FROM EMP
WHERE SAL BETWEEN 1500 AND 3000
INTERSECT
SELECT ENAME, SAL FROM EMP
WHERE SAL BETWEEN 2000 AND 5000;

-- 3. MINUS (데이터 차이 찾기)
-- 문제: 전체 사원의 직급(JOB) 목록에서 30번 부서 사원들이 가진 직급을 제외하고 출력하세요.
SELECT JOB FROM EMP
MINUS
SELECT JOB FROM EMP
WHERE DEPTNO = 30;

-- 4. 종합 응용 (컬럼 맞추기)
-- 문제: 사원 이름(ENAME)과 '사원'이라는 문구를 붙여 출력하고, 부서명(DNAME)과 '부서'라는 문구를 붙여서 하나의 리스트로 만드세요.
-- 힌트: SELECT ENAME, '사원' FROM EMP ...
SELECT ENAME AS "명칭", '사원' AS "구분" 
FROM EMP
UNION
SELECT DNAME, '부서' 
FROM DEPT;




-- [문제 1] EMP 테이블에서 이름(ENAME)이 'K'로 시작하거나, 
-- 부서 번호(DEPTNO)가 30번인 사원의 사원번호, 이름, 부서번호를 조회하세요.
SELECT EMPNO, ENAME, DEPTNO
FROM EMP
WHERE ENAME LIKE 'K%'
OR
DEPTNO = 30;


-- [문제 2] 급여(SAL)가 2000 이상인 사원들 중에서 
-- 이름에 'L'이 두 번 포함된 사원의 모든 정보를 조회하세요.
-- 힌트: LIKE와 와일드카드 %를 적절히 조합해보세요.
SELECT * 
FROM EMP
WHERE SAL >= 2000
AND
ENAME LIKE '%L%L%';



-- [문제 3] 사원 번호(EMPNO)가 짝수이면서, 
-- 커미션(COMM)이 NULL이 아닌 사원의 이름과 커미션을 출력하세요.
SELECT ENAME, COMM
FROM EMP
WHERE MOD(EMPNO,2)=0
AND COMM IS NOT NULL;


-- [문제 4] 집합 연산자 사용하기
-- 'SALESMAN' 직급을 가진 사원들의 이름과 
-- 'ANALYST' 직급을 가진 사원들의 이름을 '직급별사원'이라는 컬럼명으로 합쳐서 출력하세요.
-- (단, UNION을 사용하고 이름순으로 정렬하세요.)
SELECT ENAME AS "직급별사원" FROM EMP
WHERE JOB = 'SALESMAN'
UNION
SELECT ENAME AS "직급별사원" FROM EMP
WHERE JOB = 'ANALYST'
ORDER BY "직급별사원";


-- [문제 5] 함수 응용
-- 이름(ENAME)의 세 번째 글자가 'A'인 사원을 찾고, 
-- 그 사원의 이름을 출력할 때 'A'를 '★'로 바꿔서 출력하세요.
-- (컬럼명은 "수정이름"으로 표시하세요.)
SELECT REPLACE(ENAME,'A','★') AS "수정이름" FROM EMP
WHERE ENAME LIKE '__A%';
