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
-- 연습문제 6 데이터 조작
--1. Employee테이블의구조만복사하여EMP_INSERT란빈테이블을만드세요.
CREATE TABLE EMP_INSERT AS SELECT * FROM employee WHERE 0=1;

--2. 본인을EMP_INSERT테이블에추가하되SYSDATE를이용해서입사일을오늘로입력하세요
SELECT * FROM emp_insert;
INSERT INTO emp_insert VALUES (1, 'YEOL', 'PRESIDENT', NULL, sysdate, 5000, 1000, 10);

--3. EMP_INSERT 테이블에옆사람을추가하되TO_DATE함수를사용해서입사일을어제로입력하세요
INSERT INTO emp_insert VALUES (2, 'HONG', 'SALESMAN', 1, sysdate-1, 1250, 200, 10);

--4. Employee테이블의구조와내용을복사하여EMP_COPY란이름의테이블을만드세요.
CREATE TABLE emp_copy AS SELECT * FROM employee;

--5. 사원번호가7788인사원의부서번호를10으로수정하세요.
UPDATE emp_copy SET dno = 10 WHERE eno = 7788;
SELECT * FROM emp_copy;

--6. 사원번호가7788의담당업무및급여를사원번호7499의담당업무및급여와일치하도록갱신하세요.
UPDATE emp_copy SET job = (SELECT job FROM emp_copy WHERE eno = 7499), salary = (SELECT salary FROM emp_copy WHERE eno = 7499) WHERE eno = 7788;

--7. 사원번호7369와업무가동일한모든사원의부서번호를사원7369의현재부서번호로갱신하세요.
UPDATE emp_copy SET dno = (SELECT dno FROM emp_copy WHERE eno = 7369) WHERE job = (SELECT job FROM emp_copy WHERE eno = 7369);

--8. Department테이블의구조와내용을복사하여DEPT_COPY란이름의테이블을만드세요
CREATE TABLE dept_copy AS SELECT * FROM department;

--9. DEPT_COPY테이블에서부서명이RESEARCH인부서를제거하세요.
DELETE FROM dept_copy WHERE dname = 'RESEARCH';
SELECT * FROM dept_copy;

--10. DEPT_COPY테이블에서부서번호가10이거나40인부서를제거하세요
DELETE FROM dept_copy WHERE dno IN (10, 40);

---------------------------------------------------------------------------------
-- 연습문제 7. 테이블 제어
--1. 다음표에명시된대로DEPT 테이블을생성하세요.
CREATE TABLE dept (dno NUMBER(2), dname VARCHAR2(14), loc VARCHAR2(13));

--2. 다음표에명시된대로EMP 테이블을생성하세요.
CREATE TABLE emp (eno NUMBER(4), ename VARCHAR2(10), dno NUMBER(2));

--3. 긴이름을저장할수있도록EMP테이블을수정하세요.(ENAME칼럼)
ALTER TABLE emp MODIFY ename VARCHAR2(25);

--4. EMPLOYEE테이블을복사해서EMPLOYEE2란이름의테이블을생성하되사원번호, 이름, 급여, 부서번호칼럼만복사하고새로생성된칼럼명을각각EMP_ID, NAME, SAL, DEPT_ID로지정하세요.
CREATE TABLE employee2 AS SELECT eno AS "EMP_ID", ename AS "NAME", salary AS "SAL", dno AS "DEPT_ID" FROM employee;

--5. EMP 테이블을삭제하세요
DROP TABLE emp;

--6. EMPLOYEE2테이블의이름을EMP로변경하세요
RENAME employee2 TO emp;

--7. DEPT 테이블에서DNAME 칼럼을제거하세요
ALTER TABLE dept DROP COLUMN dname;

--8. DEPT 테이블에서LOC칼럼을UNUSED로표시하세요.
ALTER TABLE dept SET UNUSED (loc);

--9. UNUSED 칼럼을모두제거하세요.
ALTER TABLE dept DROP UNUSED COLUMNS;

---------------------------------------------------------------------------------
-- 연습문제 8. 데이터 무결성, 제약조건
--1. Employee테이블의구조를복사하여EMP_SAMPLE란이름의테이블을만드세요. 사원테이블의사원번호칼럼에테이블레벨로primarykey제약조건을지정하되제약조건이름은my_emp_pk로지정하세요.
SELECT * FROM employee;
SELECT * FROM emp_sample;
CREATE TABLE emp_sample AS SELECT * FROM employee WHERE 0=1;
ALTER TABLE emp_sample MODIFY eno CONSTRAINT my_emp_pk PRIMARY KEY;

--2. department테이블의구조를복사하여dept_sample이란테이블을만드세요. dept_sample의부서번호칼럼에테이블레벨로primarykey제약조건을지정하되제약조건이름은my_dept_pk로지정하세요.
CREATE TABLE dept_sample AS SELECT * FROM department WHERE 0=1;
ALTER TABLE dept_sample ADD CONSTRAINT my_dept_pk PRIMARY KEY(dno);

--3.사원테이블의부서번호칼럼에존재하지않는부서의사원이배정되지않도록외래키제약조건을지정하되제약조건이름은my_emp_dept_fk로지정하세요.
ALTER TABLE emp_sample ADD CONSTRAINT my_emp_dept_fk FOREIGN KEY(dno) REFERENCES dept_sample(dno);

--4. 사원테이블의커미션컬럼에0보다큰값만을입력할수있도록제약조건을지정하세요
ALTER TABLE emp_sample MODIFY commission CHECK(0 < commission);

---------------------------------------------------------------------------------
-- 연습문제 10. 시퀀스
--1. 사원 테이블의 사원번호가 자동으로 생성되도록 시퀀스를 생성하시오. (시작값 : 1, 증가값 :1 최대값:100000)
CREATE SEQUENCE ex_seq START WITH 1 INCREMENT BY 1 MAXVALUE 100000;

--2. 사원번호를 시퀀스로부터 발급받아서 오른쪽 테이블에 데이터를 입력하세요.
--1)사원 이름: Julia, 입사일: sysdate)
--2)사원 이름: Alice 입사입: 2020/12/31
CREATE TABLE emp01(empno number(4), ename varchar2(10), hiredate date);
SELECT * FROM emp01;
INSERT INTO emp01 VALUES(ex_seq.nextval, 'Julia', sysdate);
INSERT INTO emp01 VALUES(ex_seq.nextval, 'ALICE', '2022/12/31');

--3. EMP01테이블의 이름 칼럼을 인덱스로 설정하되 인덱스 이름을 IDX_EMP01_EName로 지정하세요.
CREATE INDEX IDX_EMP01_EName ON emp01(ename);
