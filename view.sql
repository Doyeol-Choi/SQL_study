-- 뷰
-- 실습용 테이블 생성
CREATE TABLE emp_sec AS SELECT * FROM employee;
CREATE TABLE dept_sec AS SELECT * FROM department;

-- 뷰 생성
CREATE VIEW v_emp_job(사번, 사원이름, 부서번호, 담당업무) AS SELECT eno, ename, dno, job FROM emp_sec WHERE job='SALESMAN';
SELECT * FROM v_emp_job;

CREATE VIEW v_emp_job2 AS SELECT eno, ename, dno, job FROM emp_sec WHERE job='SALESMAN';
SELECT * FROM v_emp_job2;

-- 뷰에 사용된 서브쿼리 내용 확인
SELECT view_name, text FROM user_views;

SELECT * FROM v_emp_job;

-- 뷰를 통한 데이터 입력
INSERT INTO v_emp_job VALUES(9000, 'BILL', 30, 'SALESMAN');
-- 기본테이블의 데이터가 입력됨을 알 수 있다.
SELECT * FROM emp_sec;

INSERT INTO v_emp_job VALUES (9005, 'KIM', 30, 'SALESMAN');
-- 뷰를 통한 데이터 수정
UPDATE v_emp_job SET 사원이름='PARK' WHERE 사원이름='KIM';
-- 뷰를 통한 데이터 삭제
DELETE FROM v_emp_job WHERE 사번=9005;
-- 뷰 삭제
DROP VIEW v_emp_job2;

CREATE OR REPLACE VIEW v_emp_job2 AS SELECT eno, ename, job, salary FROM emp_sec WHERE job='MANAGER';
SELECT * FROM v_emp_job2;

-- FORCE - 기본테이블이 없을때 강제로 뷰 생성 (후에 추가 예정인 테이블의 뷰를 미리 만드는 느낌)
CREATE OR REPLACE FORCE VIEW v_emp_notable AS SELECT eno, ename, job, salary FROM emp_notable WHERE job='MANAGER';

DROP TABLE member;
-- 테이블에 제약이 있을때 뷰
CREATE TABLE member (
    m_id varchar2(20) PRIMARY KEY,
    m_passward varchar2(100) NOT NULL,
    m_name varchar2(50) NOT NULL,
    m_contract varchar2(50) NOT NULL);
-- 더미데이터 생성
INSERT INTO member VALUES('asdf','1234','KO','010-1234-5678');
INSERT INTO member VALUES('qwer','1234','NA','010-9876-5432');
INSERT INTO member VALUES('zxcv','1234','KANG','010-9514-7536');
commit;

SELECT * FROM member;
-- 뷰생성
CREATE OR REPLACE VIEW v_member AS SELECT m_id, m_name FROM member;
SELECT * FROM v_member;

--INSERT INTO v_member VALUES('poiu','CHOI'); -- NOT NULL제약이 걸린 비밀번호와 전화번호를 입력하지 않아서 에러가 난다.

-- 일반적인 뷰 생성
CREATE OR REPLACE VIEW v_emp_job_nochk AS SELECT eno, ename, dno, job FROM emp_sec WHERE job='MANAGER';
SELECT * FROM v_emp_job_nochk;

INSERT INTO v_emp_job_nochk VALUES(9500,'chun',20,'SALESMAN'); -- 데이터 입력은 문제 없지만 manager가 아니기 때문에 뷰에서 조회는 안된다.

-- check option
CREATE OR REPLACE VIEW v_emp_job_chk AS SELECT eno, ename, dno, job FROM emp_sec WHERE job='MANAGER' WITH CHECK OPTION;
SELECT * FROM v_emp_job_chk;

--INSERT INTO v_emp_job_chk VALUES(9505,'NA',20,'SALESMAN'); -- manager가 아니기 때문에 입력 불가
INSERT INTO v_emp_job_chk VALUES(9510,'WANG',20,'MANAGER'); -- 뷰에서 조회 가능한 manager라서 입력 가능

---------------------------------------------------------------------------------
-- 사용자 권한
--CREATE USER 유저명 IDENTIFIED BY 1234;
--ALTER USER 유저명 QUOTA 100m on USERS;
--ALTER USER 유저명 DEFAULT TABLESPACE TEMP;
--GRANT CONNECT, RESOURCE TO 유저명;

--SHOW USER; -- 현재 접속 계정
--CONN 유저명 -- 접속