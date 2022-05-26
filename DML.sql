DROP TABLE EMPLOYEE;
DROP TABLE DEPARTMENT;
DROP TABLE SALGRADE;

CREATE TABLE DEPARTMENT
        (DNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
         DNAME VARCHAR2(14),
	 LOC   VARCHAR2(13) ) ;
CREATE TABLE EMPLOYEE 
        (ENO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	 ENAME VARCHAR2(10),
 	 JOB   VARCHAR2(9),
	 MANAGER  NUMBER(4),
	 HIREDATE DATE,
	 SALARY NUMBER(7,2),
	 COMMISSION NUMBER(7,2),
	 DNO NUMBER(2) CONSTRAINT FK_DNO REFERENCES DEPARTMENT);
CREATE TABLE SALGRADE
        (GRADE NUMBER,
	 LOSAL NUMBER,
	 HISAL NUMBER );

INSERT INTO DEPARTMENT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPARTMENT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPARTMENT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPARTMENT VALUES (40,'OPERATIONS','BOSTON');

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','CLERK',    7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7499,'ALLEN','SALESMAN', 7698,to_date('20-2-1981', 'dd-mm-yyyy'),1600,300,30);
INSERT INTO EMPLOYEE VALUES
(7521,'WARD','SALESMAN',  7698,to_date('22-2-1981', 'dd-mm-yyyy'),1250,500,30);
INSERT INTO EMPLOYEE VALUES
(7566,'JONES','MANAGER',  7839,to_date('2-4-1981',  'dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981', 'dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMPLOYEE VALUES
(7698,'BLAKE','MANAGER',  7839,to_date('1-5-1981',  'dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7782,'CLARK','MANAGER',  7839,to_date('9-6-1981',  'dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7788,'SCOTT','ANALYST',  7566,to_date('13-07-1987', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7839,'KING','PRESIDENT', NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981',  'dd-mm-yyyy'),1500,0,30);
INSERT INTO EMPLOYEE VALUES
(7876,'ADAMS','CLERK',    7788,to_date('13-07-1987', 'dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7900,'JAMES','CLERK',    7698,to_date('3-12-1981', 'dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7902,'FORD','ANALYST',   7566,to_date('3-12-1981', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7934,'MILLER','CLERK',   7782,to_date('23-1-1982', 'dd-mm-yyyy'),1300,NULL,10);

INSERT INTO SALGRADE VALUES (1, 700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

COMMIT;


-------------------------------------------------------------------------------------------
-- DML 데어터 조작어 => 실질적으로 튜플의 내용을 변경 => 트랜잭션의 적용
SELECT * FROM employee;

--INSERT 데이터 삽입
INSERT INTO employee(eno, ename, job, manager, hiredate, salary, commission, dno)
                VALUES(8121, 'ALICE', 'CLERK', 7788, sysdate, 1200, 100, 10);
-- 전체 입력시 컬럼을 생략할 수 있다. but value 입력 순서는 그대로
INSERT INTO employee VALUES(8231, 'KATHERINE', 'SALESMAN', 7698, sysdate, 1750, 800, 30);

-- 트랜잭션 정상적 종료
COMMIT;

SELECT * FROM employee;

INSERT INTO employee(eno) VALUES (8500);
INSERT INTO employee(eno, ename) VALUES (8600, NULL);

-- 데이터 복사해서 테이블 만들기 - 실제로 사용할 일이 없다.
CREATE TABLE emp2 AS SELECT * FROM employee;

SELECT * FROM emp2;

-- 0=1 값이 false이기 때문에 조회 되는 데이터가 없다.
CREATE TABLE emp3 AS SELECT * FROM employee WHERE 0=1;
-- 컬럼만 복사되는 것을 볼 수 있다.
SELECT * FROM emp3;
-- 컬럼만 있는 빈 테이블에 employee 테이블 복사
INSERT INTO emp3 SELECT * FROM employee;
-- 특정 컬럼만 입력
INSERT INTO emp3 (eno, ename, job) SELECT eno, ename, job FROM employee;

---------------------------------------------------------------------------------
-- UPDATE 데이터 수정
-- UPDATE 테이블명 SET WHERE
CREATE TABLE emp4 AS SELECT * FROM employee;

SELECT * FROM emp4;

-- eno8500의 사원 이름을 MARS로 바꾸고, 담당업무를 manager로 변경
UPDATE emp4 SET ename = 'MARS', job = 'MANAGER' WHERE eno = 8500;

-- 조건을 안적으면 모든 사람이 바뀐다.
UPDATE emp4 SET commission = 500;

UPDATE emp4 SET salary = (SELECT losal FROM salgrade WHERE grade = 1) WHERE dno IS NULL;

---------------------------------------------------------------------------------
-- DELETE 데이터 삭제
-- DELETE FROM 테이블명 WHERE 조건

CREATE TABLE emp5 AS SELECT * FROM employee;
-- 이름이 alice인 사원 삭제
DELETE FROM emp5 WHERE ename = 'ALICE';
-- 전체 데이터 삭제 / 조건이 없으면 전체 삭제이기 때문에 매우 위험
DELETE FROM emp5;
-- DELETE는 조건이 필수라고 생각하면 된다.
-- 데이터 다시 입력
INSERT INTO emp5 SELECT * FROM employee;

-- 부서명이 RESEARCH소속의 사원을 전원 삭제하세요
DELETE FROM emp5 WHERE dno = (SELECT dno FROM department WHERE dname = 'RESEARCH');
SELECT * FROM emp5;

---------------------------------------------------------------------------------
-- 트랜잭션 -> commit, rollback
CREATE TABLE emp6 AS SELECT * FROM employee;
-- null값을 지워야 하는데 잘못 지울경우 ROLLBACK으로 복구하기
DELETE FROM emp6 WHERE dno IS NOT NULL;
-- commit 하기전엔 rollback으로 복구 가능
ROLLBACK;

DELETE FROM emp6 WHERE dno IS NULL;
-- commit 후엔 데이터를 복구하기 매우 힘들다.
COMMIT;

SELECT * FROM emp6;
