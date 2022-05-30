-- ��
-- �ǽ��� ���̺� ����
CREATE TABLE emp_sec AS SELECT * FROM employee;
CREATE TABLE dept_sec AS SELECT * FROM department;

-- �� ����
CREATE VIEW v_emp_job(���, ����̸�, �μ���ȣ, ������) AS SELECT eno, ename, dno, job FROM emp_sec WHERE job='SALESMAN';
SELECT * FROM v_emp_job;

CREATE VIEW v_emp_job2 AS SELECT eno, ename, dno, job FROM emp_sec WHERE job='SALESMAN';
SELECT * FROM v_emp_job2;

-- �信 ���� �������� ���� Ȯ��
SELECT view_name, text FROM user_views;

SELECT * FROM v_emp_job;

-- �並 ���� ������ �Է�
INSERT INTO v_emp_job VALUES(9000, 'BILL', 30, 'SALESMAN');
-- �⺻���̺��� �����Ͱ� �Էµ��� �� �� �ִ�.
SELECT * FROM emp_sec;

INSERT INTO v_emp_job VALUES (9005, 'KIM', 30, 'SALESMAN');
-- �並 ���� ������ ����
UPDATE v_emp_job SET ����̸�='PARK' WHERE ����̸�='KIM';
-- �並 ���� ������ ����
DELETE FROM v_emp_job WHERE ���=9005;
-- �� ����
DROP VIEW v_emp_job2;

CREATE OR REPLACE VIEW v_emp_job2 AS SELECT eno, ename, job, salary FROM emp_sec WHERE job='MANAGER';
SELECT * FROM v_emp_job2;

-- FORCE - �⺻���̺��� ������ ������ �� ���� (�Ŀ� �߰� ������ ���̺��� �並 �̸� ����� ����)
CREATE OR REPLACE FORCE VIEW v_emp_notable AS SELECT eno, ename, job, salary FROM emp_notable WHERE job='MANAGER';

DROP TABLE member;
-- ���̺� ������ ������ ��
CREATE TABLE member (
    m_id varchar2(20) PRIMARY KEY,
    m_passward varchar2(100) NOT NULL,
    m_name varchar2(50) NOT NULL,
    m_contract varchar2(50) NOT NULL);
-- ���̵����� ����
INSERT INTO member VALUES('asdf','1234','KO','010-1234-5678');
INSERT INTO member VALUES('qwer','1234','NA','010-9876-5432');
INSERT INTO member VALUES('zxcv','1234','KANG','010-9514-7536');
commit;

SELECT * FROM member;
-- �����
CREATE OR REPLACE VIEW v_member AS SELECT m_id, m_name FROM member;
SELECT * FROM v_member;

--INSERT INTO v_member VALUES('poiu','CHOI'); -- NOT NULL������ �ɸ� ��й�ȣ�� ��ȭ��ȣ�� �Է����� �ʾƼ� ������ ����.

-- �Ϲ����� �� ����
CREATE OR REPLACE VIEW v_emp_job_nochk AS SELECT eno, ename, dno, job FROM emp_sec WHERE job='MANAGER';
SELECT * FROM v_emp_job_nochk;

INSERT INTO v_emp_job_nochk VALUES(9500,'chun',20,'SALESMAN'); -- ������ �Է��� ���� ������ manager�� �ƴϱ� ������ �信�� ��ȸ�� �ȵȴ�.

-- check option
CREATE OR REPLACE VIEW v_emp_job_chk AS SELECT eno, ename, dno, job FROM emp_sec WHERE job='MANAGER' WITH CHECK OPTION;
SELECT * FROM v_emp_job_chk;

--INSERT INTO v_emp_job_chk VALUES(9505,'NA',20,'SALESMAN'); -- manager�� �ƴϱ� ������ �Է� �Ұ�
INSERT INTO v_emp_job_chk VALUES(9510,'WANG',20,'MANAGER'); -- �信�� ��ȸ ������ manager�� �Է� ����

---------------------------------------------------------------------------------
-- ����� ����
--CREATE USER ������ IDENTIFIED BY 1234;
--ALTER USER ������ QUOTA 100m on USERS;
--ALTER USER ������ DEFAULT TABLESPACE TEMP;
--GRANT CONNECT, RESOURCE TO ������;

--SHOW USER; -- ���� ���� ����
--CONN ������ -- ����