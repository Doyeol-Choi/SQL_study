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
-- DML ������ ���۾� => ���������� Ʃ���� ������ ���� => Ʈ������� ����
SELECT * FROM employee;

--INSERT ������ ����
INSERT INTO employee(eno, ename, job, manager, hiredate, salary, commission, dno)
                VALUES(8121, 'ALICE', 'CLERK', 7788, sysdate, 1200, 100, 10);
-- ��ü �Է½� �÷��� ������ �� �ִ�. but value �Է� ������ �״��
INSERT INTO employee VALUES(8231, 'KATHERINE', 'SALESMAN', 7698, sysdate, 1750, 800, 30);

-- Ʈ����� ������ ����
COMMIT;

SELECT * FROM employee;

INSERT INTO employee(eno) VALUES (8500);
INSERT INTO employee(eno, ename) VALUES (8600, NULL);

-- ������ �����ؼ� ���̺� ����� - ������ ����� ���� ����.
CREATE TABLE emp2 AS SELECT * FROM employee;

SELECT * FROM emp2;

-- 0=1 ���� false�̱� ������ ��ȸ �Ǵ� �����Ͱ� ����.
CREATE TABLE emp3 AS SELECT * FROM employee WHERE 0=1;
-- �÷��� ����Ǵ� ���� �� �� �ִ�.
SELECT * FROM emp3;
-- �÷��� �ִ� �� ���̺� employee ���̺� ����
INSERT INTO emp3 SELECT * FROM employee;
-- Ư�� �÷��� �Է�
INSERT INTO emp3 (eno, ename, job) SELECT eno, ename, job FROM employee;

---------------------------------------------------------------------------------
-- UPDATE ������ ����
-- UPDATE ���̺�� SET WHERE
CREATE TABLE emp4 AS SELECT * FROM employee;

SELECT * FROM emp4;

-- eno8500�� ��� �̸��� MARS�� �ٲٰ�, �������� manager�� ����
UPDATE emp4 SET ename = 'MARS', job = 'MANAGER' WHERE eno = 8500;

-- ������ �������� ��� ����� �ٲ��.
UPDATE emp4 SET commission = 500;

UPDATE emp4 SET salary = (SELECT losal FROM salgrade WHERE grade = 1) WHERE dno IS NULL;

---------------------------------------------------------------------------------
-- DELETE ������ ����
-- DELETE FROM ���̺�� WHERE ����

CREATE TABLE emp5 AS SELECT * FROM employee;
-- �̸��� alice�� ��� ����
DELETE FROM emp5 WHERE ename = 'ALICE';
-- ��ü ������ ���� / ������ ������ ��ü �����̱� ������ �ſ� ����
DELETE FROM emp5;
-- DELETE�� ������ �ʼ���� �����ϸ� �ȴ�.
-- ������ �ٽ� �Է�
INSERT INTO emp5 SELECT * FROM employee;

-- �μ����� RESEARCH�Ҽ��� ����� ���� �����ϼ���
DELETE FROM emp5 WHERE dno = (SELECT dno FROM department WHERE dname = 'RESEARCH');
SELECT * FROM emp5;

---------------------------------------------------------------------------------
-- Ʈ����� -> commit, rollback
CREATE TABLE emp6 AS SELECT * FROM employee;
-- null���� ������ �ϴµ� �߸� ������ ROLLBACK���� �����ϱ�
DELETE FROM emp6 WHERE dno IS NOT NULL;
-- commit �ϱ����� rollback���� ���� ����
ROLLBACK;

DELETE FROM emp6 WHERE dno IS NULL;
-- commit �Ŀ� �����͸� �����ϱ� �ſ� �����.
COMMIT;

SELECT * FROM emp6;

---------------------------------------------------------------------------------
-- ������ ����
-- TABLE ����
CREATE TABLE dept2(dno NUMBER(2), dname VARCHAR2(14), loc VARCHAR2(13));

SELECT * FROM dept2;
-- Oracle���� ���̺� ���� ����
DESC dept2;

-- �÷��� �������� ���� �ݵ�� ��Ī�� �����ش�.
CREATE TABLE dept3 AS SELECT eno, ename, salary*12 AS "ANI_SAL" FROM employee WHERE dno = 20;
SELECT * FROM dept3;

-- ALTER - �÷� ����
ALTER TABLE dept3 ADD (birth date);
ALTER TABLE dept3 ADD (addr VARCHAR2(100), phone VARCHAR2(13));

DESC dept3;

-- ALTER - �÷� ����
ALTER TABLE dept3 MODIFY addr VARCHAR2(500);
-- �÷� �̸� ����
ALTER TABLE dept3 RENAME COLUMN addr TO address;

-- ���̺� �̸� �ٲٱ�
RENAME dept3 TO dept30;
DESC dept30;

-- �÷�����
ALTER TABLE dept30 DROP COLUMN phone;
-- Į�� �����
ALTER TABLE dept30 SET UNUSED (address);
-- ���� Į���� ����
ALTER TABLE dept30 DROP UNUSED COLUMNS;
-- ���̺� ����
DROP TABLE dept30;

-- ���̺� �����ؿ���
CREATE TABLE dept3 AS SELECT * FROM employee;
-- �����ؿ� ���̺��� ��� ���ڵ� ����
TRUNCATE TABLE dept3;

---------------------------------------------------------------------------------
-- ��������
-- not null
CREATE TABLE customer(id varchar2(20) NOT NULL, pwd varchar2(20) NOT NULL, name varchar2(20) NOT NULL);

DESC customer;
-- NULL���� �����Ƿ� ����
-- INSERT INTO customer VALUES('asdf', '1234', NULL);
-- unique �ַ� id������ ��� �ߺ�x
CREATE TABLE customer(id varchar2(20) UNIQUE, pwd varchar(20) NOT NULL, name varchar2(20) NOT NULL);

DESC customer;
-- ������ �Է�
INSERT INTO customer VALUES('asdf', '1234', 'kin');
-- UNIQUE�� �������� ID�� ���ļ� ����
INSERT INTO customer VALUES('asdf', '5678', 'park');

DROP TABLE customer;
-- UNIQUE�� NOT NULL ���ÿ� = PRIMARY KEY (�⺻Ű) - ���̺� �Ѱ��� �����ؾ��Ѵ�. ��� ���̺� �ݵ�� �����ؾ� �Ѵ�.
--CREATE TABLE customer(id varchar2(20) UNIQUE NOT NULL, pwd varchar(20) NOT NULL, name varchar2(20) NOT NULL);
CREATE TABLE customer(id varchar2(20) CONSTRAINT customer_id_pk PRIMARY KEY, pwd varchar(20) NOT NULL, name varchar2(20) NOT NULL);
-- ������ �Է�
INSERT INTO customer VALUES('asdf', '1234', 'hong');
INSERT INTO customer VALUES('asdf', '5678', 'kim');     -- �⺻Ű�� ���̵� ���ļ� ����
INSERT INTO customer VALUES(null, '9876', 'Lee');       -- �⺻Ű�� ���̵� null �� ���� ����

DROP TABLE customer;
-- CHECK
-- �������� �̸��� �������� ���ټ��� �ִ�. ��� �������� �ڿ� (�÷���)�� �Է����־�� �Ѵ�.
CREATE TABLE customer(id varchar2(20), pwd varchar(20) NOT NULL, name varchar2(20) NOT NULL,
                    jumsu number(3) CHECK(0<=jumsu AND jumsu<=100), CONSTRAINT customer_id_pk PRIMARY KEY(id));

-- ������ �Է�
INSERT INTO customer VALUES('asdf', '1234', 'kim', 65);
INSERT INTO customer VALUES('qwer', '1234', 'park', 123); -- jumsu �÷� �κ��� check���� ������ ����� ����

DROP TABLE customer;

-- DEFAULT
CREATE TABLE customer(id varchar2(20), pwd varchar(20) NOT NULL, name varchar2(20) DEFAULT 'ȫ�浿',
                    CONSTRAINT customer_id_pk PRIMARY KEY(id));

INSERT INTO customer VALUES('asdf', '1234', 'park');
INSERT INTO customer VALUES('qwer', '1234', null);
INSERT INTO customer(id, pwd) VALUES('zxcv', '1234');

SELECT * FROM customer;
                    
-- FOREIGN KEY
CREATE TABLE student(stuno varchar2(20) CONSTRAINT student_sno_pk PRIMARY KEY,
            name varchar2(20) CONSTRAINT student_name_nn NOT NULL,
            majar varchar2(20));

CREATE TABLE reqistration(enrollid varchar2(20) CONSTRAINT registration_id_pk PRIMARY KEY,
            stuno varchar2(20), 
            subject varchar2(20) CONSTRAINT registration_subject_nn NOT NULL,
            CONSTRAINT registration_stuno_fk FOREIGN KEY(stuno) REFERENCES student(stuno));
            
INSERT INTO student VALUES('s001', 'kim', 'math');
INSERT INTO student VALUES('s002', 'smith', 'english');
INSERT INTO student VALUES('s003', 'lee', 'korean');

SELECT * FROM student;

INSERT INTO reqistration VALUES('E001','s001','�����');
INSERT INTO reqistration VALUES('E002','s004','�̺б�����'); -- �ܷ�Ű�� �θ����̺� s004��� �����Ͱ� ���⶧���� ����

SELECT * FROM reqistration;

---------------------------------------------------------------------------------
-- �������� ����
CREATE TABLE stu_copy AS SELECT * FROM student;

CREATE TABLE reg_copy AS SELECT * FROM reqistration;
-- �߰�
ALTER TABLE reg_copy
ADD CONSTRAINT reg_copy_stuno_fk FOREIGN KEY(stuno) REFERENCES student(stuno);
-- �߰�2
ALTER TABLE stu_copy
ADD CONSTRAINT stu_copy_stuno_pk PRIMARY KEY(stuno);
-- �߰�3
ALTER TABLE reg_copy
ADD CONSTRAINT reg_copy_enrollid_pk PRIMARY KEY(enrollid);
-- ����
ALTER TABLE stu_copy
MODIFY majar CONSTRAINT stu_copy_major_nn NOT NULL; -- ��Ÿ major�� �߰��߾�� �ߴ�
-- ����
ALTER TABLE stu_copy
DROP PRIMARY KEY;   -- PRIMARY KEY �� �ϳ��ۿ� ���⶧���� �̸��� ���������� �ʾƵ� ������.
-- ����2 �������� �̸��� ���� ����
ALTER TABLE stu_copy
DROP CONSTRAINT stu_copy_major_nn;

---------------------------------------------------------------------------------
-- ������
CREATE SEQUENCE seq_sample START WITH 10 INCREMENT BY 10;   -- 10���� �����ϰ� 10�� ����

SELECT sequence_name, min_value, max_value, increment_by, cycle_flag FROM user_sequences;
-- �������� ���簪 �˾ƺ���
SELECT seq_sample.currval FROM dual;    -- �ѹ��� �۵��� ���� ���⶧���� ������ ����.
-- �������� ������ �˾ƺ��� - ���� ���� ����Ѵ�.
SELECT seq_sample.nextval FROM dual;

CREATE TABLE member(m_info number PRIMARY KEY, m_id varchar2(20) NOT NULL, m_pwd varchar2(100) NOT NULL);
-- ������ �⺻�� ����
CREATE SEQUENCE member_seq;
-- ������ ����
INSERT INTO member VALUES(member_seq.nextval,'asdf','1234');

SELECT * FROM member;
-- ������ ����
ALTER SEQUENCE member_seq CYCLE;

SELECT * FROM user_sequences;

-- CREATE SEQUENCE ���̺��_seq NOCACHE;  --�⺻���� ����

---------------------------------------------------------------------------------
-- �ε���
-- �̹� ������ �ε��� ����
SELECT index_name, table_name, column_name FROM user_ind_columns WHERE table_name IN ('EMPLOYEE', 'DEPARTMENT');
-- �ε��� ����
CREATE INDEX idx_employee_ename ON employee(ename);
-- �ε��� ����
DROP INDEX idx_employee_ename;

SELECT * FROM employee;