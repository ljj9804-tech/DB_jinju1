-- 문제1
SELECT
    E.DEPTNO
  , D.DNAME
  , E.EMPNO
  , E.ENAME
  , E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL > 2000;

-- 문제2
SELECT
    E.DEPTNO
  , D.DNAME
  , TRUNC(AVG(TO_NUMBER(E.SAL))) AS AVG_SAL
  , MAX(E.SAL) AS MAX_SAL
  , MIN(E.SAL) AS MIN_SAL
  , COUNT(E.EMPNO) AS CNT
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY E.DEPTNO, D.DNAME;

-- 문제3
SELECT
    D.DEPTNO
  , D.DNAME
  , E.EMPNO
  , E.ENAME
  , E.JOB
  , E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO
ORDER BY E.DEPTNO, E.ENAME;

-- 문제4
SELECT
      D.DEPTNO
    , D.DNAME  
    , E.EMPNO
    , E.ENAME
    , E.MGR
    , E.SAL
    , E.DEPTNO
    , S.LOSAL
    , S.HISAL
    , S.GRADE
    , E2.EMPNO AS MGR_EMPNO /*숫자*/
    , E2.ENAME AS MGR_ENAME /*문자*/
FROM DEPT D
LEFT OUTER JOIN EMP E ON(D.DEPTNO = E.DEPTNO)
LEFT OUTER JOIN EMP E2 ON(E.MGR = E2.EMPNO)
LEFT OUTER JOIN SALGRADE S ON(E.SAL BETWEEN S.LOSAL AND S.HISAL)
ORDER BY D.DEPTNO, E.EMPNO;




-- 문제 5: 부서별 급여 등급 통계 (JOIN + GROUP BY)
-- 각 부서별로 급여 등급(GRADE)이 3등급 이상인 사원이 몇 명인지 조회하세요.
-- 출력 컬럼: DNAME, GRADE, CNT (해당 등급 인원수)
-- 정렬: 부서명 순, 등급 높은 순
SELECT
DNAME, GRADE, COUNT(ENAME) AS CNT
FROM DEPT D, EMP E, SALGRADE S




-- 문제 6: 관리자보다 급여가 높은 사원 조회 (SELF JOIN + 비교)
-- 자신의 관리자(MGR)보다 더 많은 급여(SAL)를 받는 사원의 정보를 조회하세요.
-- 출력 컬럼: EMPNO, ENAME, SAL (사원 정보), MGR_ENAME, MGR_SAL (관리자 정보)
-- 힌트: EMP 테이블을 두 번 조인하여 사원의 급여와 관리자의 급여를 비교합니다.




-- 문제 7: 부서별 평균 급여 등급 (JOIN 3개 + 집계)
-- 모든 부서에 대해 부서별 평균 급여 등급을 구하세요. (사원이 없는 부서도 포함)
-- 출력 컬럼: DEPTNO, DNAME, AVG_GRADE (소수점 첫째 자리에서 반올림)
-- 조건: DEPT, EMP, SALGRADE 세 테이블을 모두 사용하세요.