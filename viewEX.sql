-- 연습문제 9.뷰
CREATE TABLE ex_employee AS SELECT * FROM employee;
SELECT * FROM ex_employee;
--1. 20번 부서에 소속된 사원의 사원번호와 이름, 부서 번화를 출력하는 SELECT문을 하나의 뷰(v_em_dno) 로 정의하세요.
CREATE OR REPLACE VIEW v_em_dno AS SELECT eno, ename, dno FROM ex_employee WHERE dno = 20;

--2. 이미 생성된 뷰(v_em_dno)에 대해서 급여와 담당업무 역시 출력할 수 있도록 수정하세요.
CREATE OR REPLACE VIEW v_em_dno AS SELECT eno, ename, dno, salary, job FROM ex_employee WHERE dno = 20;

--3. 담당업무 별로 최대급여, 최소급여, 급여 총액을 보여주는 뷰(EMP_group_job)를 생성한 다음 조회 해본다.
CREATE OR REPLACE VIEW EMP_group_job(최대급여, 최소급여, 급여총액) AS SELECT MAX(salary), MIN(salary), SUM(salary) FROM ex_employee GROUP BY job;

--4. 이미 생성된 뷰(v_em_dno)를 통해서 접근가능한 데이터만 입력가능하도록 제약을 걸어 본다
CREATE OR REPLACE VIEW v_em_dno AS SELECT eno, ename, dno, salary, job FROM ex_employee WHERE dno = 20 WITH CHECK OPTION;

--5. 다음 데이터를 뷰 (v_em_dno) 를 통해서 입력을 한 뒤 뷰(EMP_group_job)를 통해서 조회 해본다.
INSERT INTO v_em_dno VALUES(5100, 'BELITA', 10, 1500, 'CLERK'); -- 20번이 아니라서 오류
INSERT INTO v_em_dno VALUES(5200, 'ERICA', 20, 2300, 'ANALYST');
INSERT INTO v_em_dno VALUES(5300, 'KALI', 30, 1750, 'SALESMAN'); -- 20번이 아니라서 오류
INSERT INTO v_em_dno VALUES(5400, 'MIA', 20, 950, 'ANALYST');
INSERT INTO v_em_dno VALUES(5500, 'ZINNA', 10, 1050, 'CLERK'); -- 20번이 아니라서 오류
SELECT * FROM EMP_group_job;

--6. 이미 생성된 뷰(v_em_dno)에 대해서 읽기 전용 속성을 부여해보자
CREATE OR REPLACE VIEW v_em_dno AS SELECT eno, ename, dno, salary, job FROM ex_employee WITH READ ONLY;

--7. 사번, 사원이름, 부서번호와 부서 이름을 보여주는 뷰를 (emp_dept) 생성하세요
CREATE TABLE ex_department AS SELECT * FROM department;
CREATE OR REPLACE VIEW emp_dept AS SELECT eno, ename, e.dno, dname FROM ex_employee e join ex_department d on e.dno = d.dno;

--8. 생성된 모든 뷰를 조회하세요.
SELECT view_name, text FROM user_views;
SELECT * FROM v_em_dno;
SELECT * FROM emp_group_job;
SELECT * FROM emp_dept;

--9. 생성된 뷰(v_em_dno,emp_group_job,emp_dept)를 제거하세요.
DROP VIEW v_em_dno;
DROP VIEW emp_group_job;
DROP VIEW emp_dept;

---------------------------------------------------------------------------------
-- 연습문제 11. 사용자 권한
--1. 관리자로 로그인한 후 kbs라는 사용자를 생성(암호: pass)하세요.
--CREATE USER kbs IDENTIFIED BY pass;

--2. 기본적인 권한 부여를 하지 않으면 데이터베이스에 로그인이 불가능하므로 connect와 resouce권한을 kbs사용자에 부여하세요,
--GRANT connect, resouce TO kbs;