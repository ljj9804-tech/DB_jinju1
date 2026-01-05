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
DEPTNO = 30

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
SELECT ENAME, REPLACE(ENAME,'S','!') FROM EMP;

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

SELECT '010-1234-', '790126-1'
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

