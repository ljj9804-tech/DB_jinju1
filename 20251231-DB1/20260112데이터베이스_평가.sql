/*0. 다음의 작업을 system사용자로 접속하여 그림과 같이
emp(사원), dept(부서) 테이블과 데이터를 참고하여 작성한다.
(단 이미 테이블이 생성되어있을 때는 drop 명령어로 테이블을 삭제후 시작. )*/

CREATE TABLE DEPT(
      DEPTNO    VARCHAR2(6) CONSTRAINT DEPTNO_PK PRIMARY KEY
    , DNAME     VARCHAR2(10) UNIQUE
    , AREA      VARCHAR2(6)
);

ALTER TABLE DEPT
MODIFY (DNAME NOT NULL);

DESC DEPT;

INSERT INTO DEPT (DEPTNO, DNAME)
    VALUES (101, '영업부');

INSERT INTO DEPT (DEPTNO, DNAME)
    VALUES (102, '총무부');

INSERT INTO DEPT (DEPTNO, DNAME)
    VALUES (103, '기획부');

INSERT INTO DEPT (DEPTNO, DNAME)
    VALUES (104, '홍보부');

SELECT * FROM DEPT;


CREATE TABLE EMP(
      EMPNO     NUMBER(10) CONSTRAINT EMP_PK PRIMARY KEY
    , NAME      VARCHAR2(10) UNIQUE
    , DEPTNO    VARCHAR2(6) CONSTRAINT EMP_FK REFERENCES DEPT (DEPTNO)
    , POSITION  VARCHAR2(10) CONSTRAINT EMP_CK CHECK(LENGTH(position) >= 2)
    , PAY       NUMBER(10) NOT NULL
    , PEMPNO    NUMBER(10)
);

ALTER TABLE EMP
MODIFY (NAME NOT NULL);

DESC EMP;

INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO)
    VALUES (1001, '홍길동', 101, '부장', 450, NULL);

INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO)
    VALUES (1002, '김연아', 102, '부장', 400, NULL);

INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO)
    VALUES (1003, '박지성', 101, '과장', 350, 1001);

INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO)
    VALUES (1004, '김태근', 103, '과장', 410, NULL);

INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO)
    VALUES (1005, '서찬수', 101, '대리', 300, 1003);

INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO)
    VALUES (1006, '김수현', 103, '대리', 400, 1004);

INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO)
    VALUES (1007, '정동민', 102, '대리', 320, 1002);

INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO)
    VALUES (1008, '이성규', 102, '사원', 400, NULL);

INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO)
    VALUES (1009, '임진영', 103, '사원', 250, 1006);

INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO)
    VALUES (1010, '서진수', 101, '사원',200, 1005);

SELECT * FROM EMP;

-- 1. 아래의 값에 맞게 emp테이블에 데이터를 추가하라.
--  - 사원번호:1011, 이름:이순신, 부서번호:104, 직책:부장, 급여:500, 직속상사:NULL
INSERT INTO EMP (EMPNO, NAME, DEPTNO, POSITION, PAY, PEMPNO)
    VALUES (1011, '이순신', 104, '부장',500, NULL);

SELECT * FROM EMP;

-- 2. dept 테이블에 area 필드의 값을
-- 영업부는 서울, 나머지는 부산으로 값을 업데이트하라.
UPDATE DEPT
    SET AREA = '부산';

UPDATE DEPT
 SET AREA = '서울'
WHERE DNAME ='영업부';

SELECT * FROM DEPT;


-- 3. emp 테이블에서 부서 이름이 홍보부인 데이터를 삭제하라. 

DELETE FROM EMP
    WHERE DEPTNO IN (SELECT DEPTNO
                        FROM DEPT
                        WHERE DNAME ='홍보부');

SELECT * FROM EMP;


-- 4. emp 테이블을 사용하여 이름, 급여, 세금을 출력하라.
-- 단 세금은 급여가 0-200이면 급여의 5%,
-- 201-300이면 급여의 10%,
-- 301-400 이면 급여의 15%,
-- 나머지는 급여의 20%로 지정한다.(case문, decode문 각각 2가지로 작성.)
SELECT NAME, PAY,
CASE PAY
    WHEN 0-200 THEN PAY*0.05
    WHEN 201-300 THEN PAY*0.1
    WHEN 301-400 THEN PAY*0.15
    ELSE PAY*0.2
    END AS TAX
FROM EMP;


SELECT NAME, PAY,
DECODE (PAY
    ,0-200, PAY*0.05
    ,201-300, PAY*0.1
    ,301-400, PAY*0.15
    ,PAY*0.2) AS TAX
FROM EMP;



-- 4번 오답노트
SELECT NAME, PAY,
CASE 
    WHEN PAY BETWEEN 0 AND 200 THEN PAY*0.05
    WHEN PAY BETWEEN 201 AND 300 THEN PAY*0.1
    WHEN PAY BETWEEN 301 AND 400 THEN PAY*0.15
    ELSE PAY*0.2
    END AS TAX
FROM EMP;

SELECT NAME, PAY,
DECODE (PAY
    ,200, PAY*0.05
    ,250, PAY*0.1
    ,300, PAY*0.1
    ,320, PAY*0.15
    ,350, PAY*0.15
    ,400, PAY*0.15
    ,PAY*0.2) AS TAX
FROM EMP;

SELECT PAY FROM EMP
ORDER BY PAY;





-- 5. 영업부 직원과 총무부 직원의 이름, 부서명, 직급을
-- 이름순으로 오름차순으로 출력하라.
SELECT
      E.NAME
    , D.DNAME
    , E.POSITION
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY NAME;



-- 6. emp 테이블을 이용하여 사원의 이름과 직속상관의 이름을 출력하라.
-- 단 직속상관이 없는 경우 null이 표시되도록 하라.
SELECT E1.NAME, E2.NAME AS PEMP_NAME
FROM EMP E1, EMP E2
WHERE E1.PEMPNO = E2.EMPNO(+);


-- 7. 부서별 급여의 평균이 350 이상인 부서의 부서명, 급여의 평균을 구하라.
SELECT D.DNAME
, ROUND(AVG(TO_NUMBER(E.PAY))) AS PAY_AVG
FROM EMP E ,DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY D.DNAME
HAVING ROUND(AVG(TO_NUMBER(E.PAY))) >= 350
ORDER BY D.DNAME;



-- 8. emp 테이블에서 각 부서별 급여가 가장 높은 사람의
-- 이름, 부서명, 급여를 출력하라(sub query).

SELECT E.NAME, D.DNAME, E.PAY
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND (D.DNAME, E.PAY) IN (SELECT D.DNAME, MAX(TO_NUMBER(E.PAY))
                FROM EMP E, DEPT D
                WHERE E.DEPTNO = D.DEPTNO
                GROUP BY D.DNAME)
ORDER BY D.DNAME;



-- 9. emp 테이블에서 이성규와 같은 부서의 직원의
-- 이름과 부서명을 출력하라.(sub query)
SELECT 
    E.NAME
    , D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND D.DNAME IN (SELECT D.DNAME
                FROM EMP E, DEPT D
                WHERE E.DEPTNO = D.DEPTNO
                AND E.NAME = '이성규');


-- 10. 과장의 최소급여보다 높은 급여를 받는 사람의
-- 이름, 직급, 급여를 출력하라.(sub query)

SELECT 
  NAME
, POSITION
, PAY
FROM EMP
WHERE PAY > (SELECT MIN(PAY)
            FROM EMP
            WHERE POSITION = '과장');



-- 11. mongoDB의 특징을 간략히 기술하고 RDBMS와 차이점을 논리적구조에 대해서 표로 비교하시오.



-- 12. 아래의 json Documnet들을 “pots” Collection에 Insert 한다고 가정하고
--     한번에 함수로 데이터를 넣으시오. (db명: test, collection명 pots)
--     (오류를 만들어 놓았습니다. 수정하여 사용하세요)
--  {
--     title: "Post Title 2",
--     body: "Body of post.",
--     category: "Event",
--     likes: 2,
--     tags: ["news", "events"],
--     date: Date()
--   }
--   {
--     title: "Post Title 3",
--     body: "Body of post.",
--     category: "Technology",
--     likes: 3,
--     tags: {"news", "events"},
--     date: Date()
--   }