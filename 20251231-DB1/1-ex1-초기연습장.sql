-- 샘플 emp 테이블 조회 해보기
-- vscode에서 실행하는 방법 , 한문장 단위 실행 : ctrl + enter
-- 주의사항, 최초 실행시, vscode 측에서, 서버를 선택하는 메뉴가 나오면, 
-- 이전에 설치한 연결 설정을 선택하기. 
select * from emp; 

--현재 시간 조회 
select sysdate from dual;



-- ========================================================================




-- select * 은 해당 테이블의 모든 컬럼을 조회
-- from emp 는 조회할 테이블 명
-- where은 컬럼명 = 값; : 조건을 만족하는 문구
-- 아래 예시)
SELECT * FROM EMP
WHERE JOB = 'MANAGER';
-- 예시 해석 : emp 테이블에서, job 칼럼의 값이 manager인 사원을 찾음,
-- 출력 열은 모든 컬럼.


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

-- 실습1 완

-- ========================================================================

-- 단일 열에서 중복 제거 예시
SELECT DISTINCT job FROM EMP;

SELECT job FROM EMP;

-- 다중 열에서 중복 제거 예시
SELECT DISTINCT JOB, DEPTNO FROM EMP;

SELECT JOB, DEPTNO FROM EMP;

-- 실습2 완

-- ======================================================================

-- 별칭 설정하기_"AS"사용하기_2026.01.02

SELECT ENAME FROM EMP;
SELECT ENAME AS "사원명" FROM EMP;

-- ""(큰따옴표) 사용할 경우(AS와 같은 효과)
SELECT ENAME "사원명" FROM EMP;

-- 가독성을 위해 "AS" 사용 권장


SELECT ENAME AS "사원명",SAL AS "급여", SAL * 12 AS "연봉(상여금 미포함)" FROM EMP;

-- 실습3 완

-- ======================================================================

-- 정렬
-- ORDER BY ..;

SELECT * FROM EMP
ORDER BY SAL;
-- 급여를 오름차순(기본값)으로 정렬(1)

SELECT * FROM EMP
ORDER BY SAL DESC;
-- 급여를 내림차순으로 정렬("DESC")(2)

-- 여러 열 기준으로 정렬(각 열에 다른 정렬)(3)
SELECT ENAME, SAL, DEPTNO FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;

-- 열 인덱스를 기준으로 정렬(4)
SELECT ENAME, JOB, SAL
FROM EMP
ORDER BY 3 DESC;

-- 📌실습 팁 : 날짜의 경우 내림차순 정렬 = 최신순 이 됨


-- 실습4 완
-- ================================================================================

-- WHERE 특정 행 데이터 찾기

-- 실습5 완
-- ================================================================================

-- AND, OR 
SELECT * FROM EMP
WHERE DEPTNO = 30
AND
JOB = 'SALESMAN';


SELECT * FROM EMP
WHERE JOB = 'CLERK' OR JOB = 'MANAGER';

SELECT * FROM EMP
WHERE (DEPTNO = 10 OR DEPTNO = 20)
AND SAL > 2000;

-- 실습6 완

-- 📌팁 : Null 은 비어있는 값을 말함(0과 다름)
-- "IS NOT NULL"은 실무에서 데이터의 누락 여부를 판단할 때 매우 자주 쓰이는 연산자입니다.

-- ================================================================================

-- 연산자의 종류와 활용방법
-- 실무에서 사용되는 조건 필터링, 패턴검색, Null 비교 등의 쿼리


-- ### ✅ 산술 연산자

SELECT ENAME, SAL * 12 AS "연봉" FROM EMP;

-- ### ✅ 비교 연산자

SELECT * FROM EMP WHERE SAL >= 2000;


-- ### ✅ 문자 비교 (1글자 vs 여러 글자)

-- 한 글자
SELECT * FROM EMP WHERE ENAME > 'L';

-- 여러 글자
SELECT * FROM EMP WHERE ENAME < 'MILLER';


-- ### ✅ 등가 비교 연산자

SELECT * FROM EMP WHERE JOB != 'CLERK';
SELECT * FROM EMP WHERE JOB <> 'CLERK';
SELECT * FROM EMP WHERE JOB ^= 'CLERK'; -- 일부 DBMS에서 지원

-- ### ✅ NOT 연산자

SELECT * FROM EMP WHERE NOT JOB = 'MANAGER';

-- ### ✅ OR 연산자

SELECT * FROM EMP WHERE JOB = 'CLERK' OR SAL < 1000;


-- ### ✅ IN 연산자

SELECT * FROM EMP WHERE DEPTNO IN (10, 20, 30);

SELECT * FROM EMP WHERE DEPTNO = 10
OR
DEPTNO = 20
OR
DEPTNO = 30;

-- ### ✅ NOT IN 연산자

SELECT * FROM EMP WHERE DEPTNO NOT IN(10, 30);



-- ### ✅ BETWEEN A AND B

SELECT * FROM EMP WHERE SAL BETWEEN 1000 AND 3000;

-- ## ✅ NOT BETWEEN A AND B

SELECT * FROM EMP WHERE SAL NOT BETWEEN 1000 AND 3000;


-- 중요함.!!
-- ### ✅ LIKE 연산자

SELECT * FROM EMP WHERE ENAME LIKE 'S%'; -- S로 시작
SELECT * FROM EMP WHERE ENAME LIKE '_L%'; -- 두 번째 글자가 L
SELECT * FROM EMP WHERE ENAME LIKE '%AM%'; -- AM 포함
SELECT * FROM EMP WHERE ENAME NOT LIKE '%AM%'; -- AM 포함하지 않음


-- ### ✅ IS NULL / IS NOT NULL
SELECT * FROM EMP WHERE COMM IS NULL;
SELECT * FROM EMP WHERE COMM IS NOT NULL;


-- ### ✅ 집합 연산자

-- 1. UNION (중복 제거)
SELECT ENAME FROM EMP WHERE JOB = 'MANAGER'
UNION
SELECT ENAME FROM EMP WHERE DEPTNO = 10;


-- 2. UNION ALL (중복 포함)
SELECT ENAME FROM EMP WHERE JOB = 'MANAGER'
UNION ALL
SELECT ENAME FROM EMP WHERE DEPTNO = 10;

-- 3. MINUS (차집합)
SELECT ENAME FROM EMP WHERE DEPTNO = 10
MINUS
SELECT ENAME FROM EMP WHERE JOB = 'MANAGER';

-- 4. INTERSECT (교집합)
SELECT ENAME FROM EMP WHERE JOB = 'CLERK'
INTERSECT
SELECT ENAME FROM EMP WHERE DEPTNO = 20;



-- 실습7 완
-- ================================================================================

-- ===오라클 함수=== --
-- 오라클에서 제공하는 내장 함수 --

-- 기본 예시코드
-- 1. 이름을 모두 대문자로 출력
SELECT ENAME, UPPER(ENAME) AS "대문자 변환" FROM EMP;
-- 1. 이름을 모두 소문자로 출력
SELECT ENAME, LOWER(ENAME) AS "소문자 변환" FROM EMP;
-- 1. 이름 첫 글자만 대문자 변환
SELECT ENAME, INITCAP(ENAME) AS "첫글자만 변환" FROM EMP;


-- 2. 사원 이름의 길이 출력
SELECT ENAME, LENGTH(ENAME) AS "이름 길이" FROM EMP;
-- 2. 문자열의 바이트 수
-- 영문자는 1글자=1바이트/ 한글 1글자=약2바이트(1바이트:8자리를 의미:0000 0001)
SELECT ENAME, LENGTHB(ENAME) AS "이름 바이트수" FROM EMP;


-- 3. 직무 문자열 안에 'A'가 포함된 위치
SELECT JOB, INSTR(JOB, 'A') AS A_POS FROM EMP;



-- 실습8 완
-- ======================================================================2026.01.02

-- 2026.01.05
-- 교집합, 차집합, 합집합 예시

SELECT EMPNO, DEPTNO, SAL FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO, DEPTNO, SAL FROM EMP
WHERE DEPTNO = 20
ORDER BY SAL;

SELECT DEPTNO, SAL FROM EMP
WHERE DEPTNO = 10
UNION
SELECT DEPTNO, SAL FROM EMP
WHERE DEPTNO = 20
ORDER BY SAL;


SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;
-- 부서번호가 10번인

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;
-- 부서번호 10번을 제외한(차집합)

-- ======================================================================

-- 실습

SELECT * FROM EMP
WHERE ENAME LIKE '%S';

-- emp 테이블에서 deptno가 30인 사람 중, job이 salesman인 사람 조회
SELECT * FROM EMP
WHERE DEPTNO = 30
INTERSECT
SELECT * FROM EMP
WHERE JOB = 'SALESMAN';

SELECT * FROM EMP
WHERE DEPTNO = 30
AND JOB = 'SALESMAN';

-- emp 테이블에서 deptno가 20, 30인 사람 중, SAL가 2000 초과인 사람 조회
-- 집합연산자 사용
SELECT * FROM EMP
WHERE DEPTNO IN(20, 30)
INTERSECT
SELECT * FROM EMP
WHERE SAL > 2000;

-- 집합연산자 사용 안함
SELECT * FROM EMP
WHERE DEPTNO IN(20, 30)
AND
SAL > 2000;

-- EMP테이블에서 SAL이 2000 이상, 3000 이하 외의 데이터 조회
SELECT * FROM EMP
WHERE SAL < 2000 OR SAL > 3000;

SELECT * FROM EMP
WHERE SAL NOT BETWEEN 2000 AND 3000;

SELECT * FROM EMP
MINUS
SELECT * FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;

-- EMP테이블에서 E가 포함된 ENAME(이름) 중에 30번 부서에서, 급여가 1000 이상 2000 이하 외의 사람을 조회
SELECT * FROM EMP
WHERE ENAME LIKE '%E%' AND DEPTNO = 30
MINUS
SELECT * FROM EMP
WHERE SAL BETWEEN 1000 AND 2000;

SELECT * FROM EMP
WHERE ENAME LIKE '%E%' AND DEPTNO = 30
AND
SAL NOT BETWEEN 1000 AND 2000;

-- ENP테이블에서 COMM이 없고, JOB이 MANAGER 또는 CLERK인 사람 중에, ENAME 두번째 글자가 L이 아닌 사람 조회
SELECT * FROM EMP
WHERE COMM IS NULL
AND JOB IN('MANAGER','CLERK')
AND ENAME NOT LIKE '_L%';

SELECT * FROM EMP
WHERE COMM IS NULL
AND JOB IN('MANAGER','CLERK')
MINUS
SELECT * FROM EMP
WHERE ENAME LIKE '_L%';


SELECT ENAME, SAL FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;






-- ======================================================================

-- 오라클 함수


SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP;


-- 실습
-- EMP테이블에서 "scott"이란 문자를 변경하지 않고 조회 하시오.
SELECT ENAME FROM EMP
WHERE lower(ENAME) = 'scott';

-- 'sc'란 문자가 포함된 데이터를 조회 하시오. 단, 문자를 변경하지 않고.
SELECT ENAME FROM EMP
WHERE lower(ENAME) LIKE '%sc%';

SELECT ENAME FROM EMP
WHERE upper(ENAME) LIKE '%SC%';

-- EMP테이블에서 이름은 소문자 직책은 대문자로 조회 하시오
SELECT LOWER(ENAME) AS ENAME, UPPER(JOB) AS JOB FROM EMP;



-- EMP테이블에서 이름과 이름의 길이를 표시하기. 단, 이름의 길이가 5이하인 것만 표시하시오.
SELECT ENAME, LENGTH(ENAME) FROM EMP
WHERE LENGTH(ENAME) <= 5;

SELECT ENAME, LENGTH(ENAME) FROM EMP;



-- SELECT UPPER('%sc%') FROM DUAL;
SELECT 1 + 1 FROM DUAL;
SELECT 1 + '1' FROM DUAL;



-- ======================================================================
-- SUBSTR, INSTR, REPLACE 데이터 가공

SELECT JOB, SUBSTR(JOB,1,2) FROM EMP;
-- 해석 : 직책에서 글자의 1번째 자리부터 2개 데이터 추출

SELECT JOB, SUBSTR(JOB,3,2), SUBSTR(JOB,5,4),
LENGTH(SUBSTR(JOB,5,4)) FROM EMP;
-- 해석 : 직책에서 글자의 3번째 자리부터 2개 데이터 추출, ...

SELECT JOB, SUBSTR(JOB,3), LENGTH(SUBSTR(JOB,3)) FROM EMP;
-- 해석 : 3번째 자리에서 부터 문자 끝까지 


SELECT JOB, INSTR(JOB, 'K') FROM EMP;
-- 해석 : 'K'가 몇번째 위치에 있는지 추출

SELECT INSTR('HELLO, ORACLE!', 'L') FROM DUAL;

SELECT INSTR('HELLO, ORACLE!', 'L',5) FROM DUAL;

SELECT INSTR('HELLO, ORACLE!', 'L',2,2) FROM DUAL;



-- 실습
-- EMP테이블 사원명(ENAME) 중에 's'가 포함된 사원들을 조회 하시오.
SELECT * FROM EMP
WHERE ENAME LIKE UPPER('%s%');

SELECT * FROM EMP
WHERE INSTR(ENAME, UPPER('s')) > 0;


-- REPLACE
SELECT ENAME, REPLACE(ENAME,'K','!') FROM EMP;




SELECT ENAME, REPLACE(ENAME,'K') FROM EMP;


-- 실습
-- 010-1234-5678
SELECT '010-1234-5678'
,REPLACE('010-1234-5678','-')
,SUBSTR('010-1234-5678',-9,4)
,SUBSTR('010-1234-5678',-4,4) FROM DUAL;

SELECT '010-1234-5678'
,REPLACE('010-1234-5678','-')
,SUBSTR('010-1234-5678',5,4)
,SUBSTR('010-1234-5678',10,4) FROM DUAL;

-- ======================================================================
-- LPAD, RPAD, CONCAT

SELECT '010-1234-'
,'790126-1'
,LPAD('12345',10,'#')
,RPAD('12345',10,'*')
,LPAD('12345',3,'#')
,RPAD('12345',3,'*')
 FROM DUAL;

SELECT '010-1234-', '790126-1'
,RPAD('010-1234-',LENGTH('010-1234-')+4,'*')
,RPAD('790126-1',LENGTH('790126-1')+6,'*')
 FROM DUAL;

SELECT '010-1234-', '790126-1'
,RPAD('010-1234-', 13,'*')
,RPAD('790126-1',14,'*')
 FROM DUAL;

SELECT '010-1234-5678', '790126-1111111'
,RPAD(SUBSTR('010-1234-5678',1,9),LENGTH('010-1234-5678'),'*')
,RPAD(SUBSTR('790126-1111111',1,8),LENGTH('790126-1111111'),'*')
 FROM DUAL;






SELECT CONCAT('PHONE','JUMIN') FROM DUAL;





SELECT CONCAT(ENAME,EMPNO) FROM EMP;


SELECT CONCAT(CONCAT('사번:',EMPNO), CONCAT(' 성명:',ENAME)) FROM EMP;


SELECT '사번:'||EMPNO||' 성명:'||ENAME FROM EMP;


-- TRIM, LTRIM, RTRIM

SELECT '[ ' || ' _oracle_ ' || ' ]'
, trim('[_oracle_]')
from dual;


-- ROUND, ...

SELECT
      SAL/3
    , ROUND(SAL/3,2)
    , TRUNC(SAL/3,2)
    ,MOD(EMPNO,2)
FROM EMP;

SELECT * FROM EMP
WHERE MOD(EMPNO,2) = 0;

-- ======================================================= ~154P(6-3)
2026.01.06

-- 날짜 함수
SELECT SYSDATE FROM DUAL;

SELECT SYSDATE AS NOW
     , SYSDATE-1 AS YESTERDAY
     , SYSDATE+1 AS TOMORROW
FROM DUAL;


-- 실습
-- EMP테이블, 입사일 20주년 되는 날짜를 구하시오(표시는 사번, 이름, 입사일, 20주년일)
SELECT EMPNO, ENAME, HIREDATE, MONTHS_BETWEEN(HIREDATE, SYSDATE)
FROM EMP
WHERE ADD_MONTHS(HIREDATE, 480) < SYSDATE;


SELECT SYSDATE, ADD_MONTHS(SYSDATE, 2) FROM DUAL;


SELECT SYSDATE, NEXT_DAY(SYSDATE,'월') FROM DUAL;



SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;




-- 데이터 타입 변경
SELECT
  TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM DUAL;

SELECT
  TO_DATE('2024-08-14', 'YYYY-MM-DD') AS TODATE1
  , TO_DATE('2024/08/14', 'YYYY/MM/DD') AS TODATE2
FROM DUAL;

-- 실습
-- 최초 입사자와 각각 입사자의 근무일차를 구하시오.
-- 사번, 이름, 입사일, 차이일
-- 최초입사자, 그일자를 카피(문자), 날짜 - 날짜

SELECT EMPNO, ENAME, HIREDATE, HIREDATE - TO_DATE('1980/12/17','YYYY/MM/DD')
FROM EMP
ORDER BY HIREDATE;
-- 17/12/1980 12:00:00


-- 추가문제
-- 최초입사자와 1년 이상 차이가 나는 사원 조회
SELECT EMPNO, ENAME, HIREDATE, HIREDATE - TO_DATE('1980/12/17','YYYY/MM/DD') AS "차이일"
FROM EMP
WHERE (HIREDATE - TO_DATE('1980/12/17','YYYY/MM/DD')) >= 365
ORDER BY HIREDATE;
-- 17/12/1980 12:00:00


-- =======================================================
-- NULL

SELECT
    NVL(COMM,0) /*COMM 값이 NULL이면 0으로 반환_숫자형 값에 숫자형 반환*/
  , NVL(ENAME,'A') /*ENAME 값이 NULL이면 'A'반환_문자형 값에 문자형 반환*/
  , NVL2(COMM,1,10) /*COMM 값이 NULL이 아니면 1, 맞으면 10 반환*/
  , NVL2(COMM,COMM,10)
FROM EMP;



-- 실습(174P)
SELECT EMPNO, ENAME, COMM
  , NVL2(COMM,'O','X')
  -- , NVL2(COMM, 1, 2)
  , NVL2(COMM, SAL*12+COMM, SAL*12) AS ANNSAL
FROM EMP;

-- DECODE, CASE
/*
ex)
DECODE(1,2,3,4)
1 == 2
3

ELSE
4
*/

/*
ex)
DECODE(1,2,3,4,5,6)
1 == 2
3

ELSE
4 == 5

ELSE
6
*/

-- 실습(174P)+추가/ 값이 0 이면//
SELECT EMPNO, ENAME, COMM
  , DECODE(COMM, 0,'X', NULL,'X', 'O')
  , NVL2(COMM, SAL*12+COMM, SAL*12) AS ANNSAL
FROM EMP;


SELECT EMPNO, ENAME, JOB, SAL
    , DECODE(JOB
          , 'MANAGER', SAL * 1.1
          , 'SALESMAN', SAL * 1.05
          , 'ANALYST', SAL
          , SAL * 1.03) AS UPSAL1
FROM EMP;



SELECT JOB
    , DECODE(JOB
          , 'MANAGER', 1
          , 'SALESMAN', 2
          , 'ANALYST', 3
          , 4)
          AS UPSAL1

    , CASE JOB
          WHEN 'MANAGER' THEN 1
          WHEN 'SALESMAN' THEN 2
          WHEN 'ANALYST' THEN 3
          ELSE 4
          END AS UPSAL2
    
    , CASE 
          WHEN JOB = 'MANAGER' THEN 1
          WHEN ENAME = 'SMITH' THEN 2
          WHEN COMM IS NULL THEN 3
          ELSE 4
          END AS UPSAL3
FROM EMP;

SELECT EMPNO, ENAME, COMM
    , CASE
        WHEN COMM IS NULL THEN '해당 사항 없음'
        WHEN COMM = 0 THEN '수당 없음'
        WHEN COMM > 0 THEN '수당 : ' || COMM
      END AS COMM_TEXT
FROM EMP;



-- 실습9 완

-- GROUP BY
-- 평균급여의 소수점 세번째에서 반올림(.**)
SELECT ROUND(AVG(SAL),2), '10' AS DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION ALL
SELECT ROUND(AVG(SAL),2), '20'
FROM EMP
WHERE DEPTNO = 20
UNION ALL
SELECT ROUND(AVG(SAL),2), '30'
FROM EMP
WHERE DEPTNO = 30
GROUP BY DEPTNO;

SELECT
    DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN(10,20)
GROUP BY DEPTNO
    HAVING SUM(SAL) = 10875
;

-- 그룹함수는 WHERE절에 넣을 수 없음

CREATE TABLE DEPT_TEM
    AS SELECT * FROM DEPT;

SELECT *
FROM DEPT_TEM;

DROP TABLE DEPT_TEMP;


SELECT DEPTNO, ENAME, SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
/*SELECT절 안에 DEPTNO, ENAME이 있다면 GROUP BY절에도 넣어주기*/




-- =========================================================2026.01.06
-- 2026.01.07

-- JOIN_관계형 데이터베이스의 핵심

-- 실습 8-4(208P)
-- 등가 조인
SELECT
    E.EMPNO
  , E.ENAME
  , E.DEPTNO
  , D.DNAME
  , D.LOC
FROM EMP E, DEPT D /*테이블 AS 사용 시 'AS' 쓰지않고 바로 씀(ex:E, D)*/
WHERE E.DEPTNO = D.DEPTNO;



SELECT
    *
FROM EMP E, DEPT D /*테이블 AS 사용 시 'AS' 쓰지않고 바로 씀(ex:E, D)*/
WHERE E.DEPTNO = D.DEPTNO;
-- EMP와 DEPT테이블 정보 전체 조회


SELECT
    E.ENAME, D.*
FROM EMP E, DEPT D /*테이블 AS 사용 시 'AS' 쓰지않고 바로 씀(ex:E, D)*/
WHERE E.DEPTNO = D.DEPTNO;
-- E.ENAME와 DEPT테이블 정보 전체 조회


 /*AND 사용 예시*/
SELECT
    E.ENAME, D.*
FROM EMP E, DEPT D /*테이블 AS 사용 시 'AS' 쓰지않고 바로 씀(ex:E, D)*/
WHERE E.DEPTNO = D.DEPTNO
AND D.LOC = 'CHICAGO';


-- 비등가 조인
-- 등가가 아닌 것으로 조인
SELECT * FROM SALGRADE;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY EMPNO; /*211P 8-7*/

SELECT *
FROM EMP E, SALGRADE S
ORDER BY EMPNO;

-- 자체 조인(SELF JOIN): 똑같은 테이블을 조인 214P
SELECT
    E1.EMPNO
  , E1.ENAME
  , E1.MGR
  , E2.ENAME
  FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;

-- 외부 조인(OUTER JOIN): 조건에 맞는 데이터 확정 조회 216P
SELECT
    E1.EMPNO
  , E1.ENAME
  , E1.MGR
  , E2.ENAME
  FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+);

SELECT
    E1.EMPNO
  , E1.ENAME
  , E1.MGR
  , E2.ENAME
  FROM EMP E1, EMP E2
WHERE E1.MGR(+) = E2.EMPNO;

/*왼쪽과 오른쪽 중 기준이 되는 칼럼 파악하기
-- =====================================================
/*NATURAL JOIN 패스
/*JOIN - USING 패스

/*221P
JOIN - ON(조건 입력)*/

SELECT
    E.EMPNO
  , E.ENAME
  , E.DEPTNO
  , D.DNAME
  , D.LOC
FROM EMP E JOIN DEPT D
ON(E.DEPTNO = D.DEPTNO);


SELECT *
FROM EMP E JOIN SALGRADE S
ON(E.SAL BETWEEN S.LOSAL AND S.HISAL)
ORDER BY EMPNO;


SELECT
    E1.EMPNO
  , E1.ENAME
  , E1.MGR
  , E2.ENAME
  FROM EMP E1 JOIN EMP E2
ON(E1.MGR = E2.EMPNO);


SELECT
    E1.EMPNO
  , E1.ENAME
  , E1.MGR
  , E2.ENAME
  FROM EMP E1 LEFT OUTER JOIN EMP E2
ON(E1.MGR = E2.EMPNO);

SELECT
    E1.EMPNO
  , E1.ENAME
  , E1.MGR
  , E2.ENAME
  FROM EMP E1 RIGHT OUTER JOIN EMP E2
ON(E1.MGR = E2.EMPNO);


SELECT
  E.*
, D.DEPTNO
, D.DNAME
, D.LOC
FROM EMP E JOIN DEPT D
ON(E.DEPTNO = D.DEPTNO
AND E.MGR IS NOT NULL
AND E.SAL >= 3000)
ORDER BY D.DEPTNO, E.EMPNO;

-- 실습 10 완 + 추가문제 ing

-- ===========================================================
-- 9장 서브쿼리

-- 231p 9-3
SELECT
*
FROM EMP
WHERE SAL > (SELECT SAL
              FROM EMP
              WHERE ENAME = 'JONES');

/*
231P 서브쿼리의 특징
1. 괄호로 묶어서 사용
2. 몇몇 경우를 제외한 대부분의 서브쿼리에서는 ORDER BY 사용X
3. 
4.
... 교재 참조*/

-- 233P 9-4
SELECT *
  FROM EMP
  WHERE HIREDATE < (SELECT HIREDATE
                        FROM EMP
                        WHERE ENAME = 'SCOTT');

-- 235P 1분 복습
SELECT E.EMPNO
    , E.ENAME
    , E.JOB
    , E.SAL
    , D.DEPTNO
    , D.DNAME
    , D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
  AND E.DEPTNO = 20
  AND E.SAL <= (SELECT AVG(SAL)
                  FROM EMP);


-- 245P 9-18
SELECT * 
  FROM EMP
  WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                            FROM EMP
                            GROUP BY DEPTNO);

                            
-- 246P 9-19
SELECT E10.EMPNO
      , E10.ENAME
      , E10.DEPTNO
      , D.DNAME
      , D.LOC
          FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
              (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;

-- WITH절 사용하기 247P
-- 9-20
WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
D   AS (SELECT * FROM DEPT)
SELECT E10.EMPNO
    , E10.ENAME
    , E10.DEPTNO
    , D.DNAME
    , D.LOC
FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO;

-- 248P 9-21
SELECT EMPNO
      , ENAME
      , JOB
      , SAL
      , (SELECT GRADE
        FROM SALGRADE
        WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE
        , DEPTNO
        ,(SELECT DNAME
          FROM DEPT
          WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
FROM EMP E;

-- 실습11 완

-- ===============================================================
-- 2026.01.08
CREATE TABLE DEPT_TEMP
    AS SELECT * FROM DEPT;

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
              VALUES (50, 'DATABASE', 'SEOUL'); /*신규행 삽입*/

SELECT * FROM DEPT_TEMP;

-- 오류1
INSERT INTO DEPT_TEMP (DEPTNO, DNAME          , LOC)
              VALUES (60         , 'NETWORK');

-- 오류2
INSERT INTO DEPT_TEMP (DEPTNO, DNAME          , LOC          )
              VALUES (60         , 'NETWORK', 'BUSAN', 'WRONG');

-- 오류3
INSERT INTO DEPT_TEMP (DEPTNO, DNAME  , LOC       )
              VALUES ('WRONG' , 'NETWORK', 'BUSAN');


-- 오류4
INSERT INTO DEPT_TEMP (DEPTNO, DNAME  , LOC       )
              VALUES (600 , 'NETWORK', 'BUSAN');


INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
              VALUES (70     ,'WEB' , NULL); /*NULL 명시적 입력*/

SELECT * FROM DEPT_TEMP;

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
              VALUES (70     ,'WEB' , ''); /*NULL 명시적 입력(공백 문자열 사용)*/

SELECT * FROM DEPT_TEMP;

INSERT INTO DEPT_TEMP (DEPTNO, LOC)
              VALUES (90     ,'INCHEON'); /*NULL 암시적 입력*/

SELECT * FROM DEPT_TEMP;

/*===================================================================*/

CREATE TABLE EMP_TEMP
    AS SELECT *
        FROM EMP
        WHERE 1<>1;

SELECT * FROM EMP_TEMP;

-- 26.7.8

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (2111, '이순신', 'MANAGER', 9999
                      , TO_DATE('13/04/1998','DD/MM/YYYY')
                      ,4000, NULL, 20);

SELECT * FROM EMP_TEMP;

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (3111, '심청이', 'MANAGER', 9999
                      , SYSDATE
                      ,4000, NULL, 30);

SELECT * FROM EMP_TEMP;

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
              FROM EMP E, SALGRADE S
              WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
              AND S.GRADE = 1;

SELECT * FROM EMP_TEMP;

CREATE TABLE DEPT_TEMP2
      AS SELECT * FROM DEPT;

UPDATE DEPT_TEMP2
  SET LOC = 'SEOUL';

ROLLBACK;

SELECT * FROM DEPT_TEMP2;


UPDATE DEPT_TEMP2
  SET DNAME = 'DATABASE'
    , LOC = 'SEOUL'
WHERE DEPTNO = 40;

SELECT * FROM DEPT_TEMP2;


UPDATE EMP_TEMP
  SET COMM = 50
WHERE SAL <= 2500;

SELECT * FROM EMP_TEMP;

UPDATE DEPT_TEMP2
  SET LOC = 'SEOUL'
  WHERE DEPTNO IN (SELECT DEPTNO
                    FROM DEPT_TEMP2
                    WHERE DEPTNO IN(10,20));


SELECT * FROM DEPT_TEMP2;



CREATE TABLE EMP_TEMP2
  AS SELECT * FROM EMP;



SELECT * FROM EMP_TEMP2;

DELETE FROM EMP_TEMP2
WHERE JOB = 'MANAGER';

SELECT * FROM EMP_TEMP2
WHERE SAL >= 3000;


DELETE FROM EMP_TEMP2
WHERE SAL >= 3000;


-- 실습12 완 279p
--=====================================================================

-- 트랜잭션

SELECT * FROM DEPT_TEMP;

delete from DEPT_TEMP
where deptno = 90;

COMMIT;


-- 300P(12-1) 304P(12-6~10)
CREATE TABLE EMP_DDL(
   EMPNO     NUMBER(4)
  ,ENAME     VARCHAR2(10)
  ,JOB       VARCHAR2(9)
  ,MGR       NUMBER(4)
  ,HIREDATE  DATE
  ,SAL       NUMBER(7,2)
  ,COMM      NUMBER(7,2)
  ,DEPTNO    NUMBER(2)
);

DESC EMP_DDL;

CREATE TABLE EMP_ALTER
  AS SELECT * FROM EMP;

SELECT * FROM EMP_ALTER;

ALTER TABLE EMP_ALTER
  ADD HP VARCHAR2(20);

ALTER TABLE EMP_ALTER
  RENAME COLUMN HP TO TEL;  

ALTER TABLE EMP_ALTER
  MODIFY EMPNO NUMBER(5);

DESC EMP_ALTER;

-- 14-1, 14-2, 14-7
CREATE TABLE TABLE_NOTNULL(
  LOGIN_ID    VARCHAR2(20)  NOT NULL
  ,LOGIN_PWD  VARCHAR2(20)  NOT NULL
  ,TEL        VARCHAR2(20)
);

INSERT INTO TABLE_NOTNULL
  VALUES ('TEST_ID', 'TESTPWD', '010-1234-5678');

SELECT * FROM TABLE_NOTNULL;

-- ALTER TABLE TABLE_NOTNULL
--   MODIFY(TEL NOT NULL);

-- 14-14 14-16, 17 19 20 23
CREATE TABLE TABLE_UNIQUE(
  LOGIN_ID    VARCHAR2(20)  UNIQUE
  ,LOGIN_PWD  VARCHAR2(20)  NOT NULL
  ,TEL        VARCHAR2(20)
);

DESC TABLE_UNIQUE;

INSERT INTO TABLE_UNIQUE
  VALUES ('TEST_ID_01', 'PWD01', '010-1234-5678');

SELECT * FROM TABLE_UNIQUE;

INSERT INTO TABLE_UNIQUE
  VALUES ('TEST_ID_01', 'PWD01', '010-1234-5678');

INSERT INTO TABLE_UNIQUE
  VALUES (NULL, 'PWD01', '010-1234-5678');

-- UPDATE TABLE_UNIQUE
-- SET LOGIN_ID = 'TEST_ID_01'
-- WHERE LOGIN_ID IS NULL;

-- ALTER TABLE TABLE_UNIQUE
--   MODIFY(TEL UNIQUE);


-- 369P 14-29 30 31

CREATE TABLE TABLE_PK(
  LOGIN_ID    VARCHAR2(20)  PRIMARY KEY
  ,LOGIN_PWD  VARCHAR2(20)  NOT NULL
  ,TEL        VARCHAR2(20)
);

DESC TABLE_PK;

-- 14-39 40 - 44
CREATE TABLE TABLE_FK(
  DEPTNO    NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY
  ,DNAME    VARCHAR2(14)
  ,LOC      VARCHAR2(13)
);

DESC DEPT_FK;

CREATE TABLE EMP_FK(
    EMPNO       NUMBER(4)   CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY
  , ENAME       VARCHAR2(10)
  , JOB         VARCHAR2(9)
  , MGR         NUMBER(4)
  , HIREDATE    DATE
  , SAL         NUMBER(7,2)
  , COMM        NUMBER(7,2)
  , DEPTNO      NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK (DEPTNO) 
);

DESC EMP_FK;

INSERT INTO EMP_FK
  VALUES(9999, 'TEST_NAME', 'TEST_JOB', NULL
  , TO_DATE('2001/01/01','YYYY,MM,DD'), 3000, NULL, 10);

INSERT INTO DEPT_FK
    VALUES(10, 'TEST_DNAME', 'TEST_LOC');

SELECT * FROM DEPT_FK;

SELECT * FROM EMP_FK;

DELETE FROM DEPT_FK
  WHERE DEPTNO = 10;


  -- 14-45 46
  CREATE TABLE TABLE_CHECK(
        LOGIN_ID      VARCHAR2(20) CONSTRAINT TBLCK_LOGINID_PK PRIMARY KEY
      , LOGIN_PWD     VARCHAR2(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK(LENGTH(LOGIN_PWD) > 3)
      , TEL           VARCHAR2(20)
  );

SELECT * FROM TABLE_CHECK;

DESC TABLE_CHECK;

INSERT INTO TABLE_CHECK
    VALUES ('TEST_ID','123','010-1234-5678');

-- 실습15 완