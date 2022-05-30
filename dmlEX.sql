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
-- �������� 6 ������ ����
--1. Employee���̺��Ǳ����������Ͽ�EMP_INSERT�������̺������弼��.
CREATE TABLE EMP_INSERT AS SELECT * FROM employee WHERE 0=1;

--2. ������EMP_INSERT���̺��߰��ϵ�SYSDATE���̿��ؼ��Ի��������÷��Է��ϼ���
SELECT * FROM emp_insert;
INSERT INTO emp_insert VALUES (1, 'YEOL', 'PRESIDENT', NULL, sysdate, 5000, 1000, 10);

--3. EMP_INSERT ���̺���������߰��ϵ�TO_DATE�Լ�������ؼ��Ի������������Է��ϼ���
INSERT INTO emp_insert VALUES (2, 'HONG', 'SALESMAN', 1, sysdate-1, 1250, 200, 10);

--4. Employee���̺��Ǳ����ͳ����������Ͽ�EMP_COPY���̸������̺������弼��.
CREATE TABLE emp_copy AS SELECT * FROM employee;

--5. �����ȣ��7788�λ���Ǻμ���ȣ��10���μ����ϼ���.
UPDATE emp_copy SET dno = 10 WHERE eno = 7788;
SELECT * FROM emp_copy;

--6. �����ȣ��7788�Ǵ������ױ޿��������ȣ7499�Ǵ������ױ޿�����ġ�ϵ��ϰ����ϼ���.
UPDATE emp_copy SET job = (SELECT job FROM emp_copy WHERE eno = 7499), salary = (SELECT salary FROM emp_copy WHERE eno = 7499) WHERE eno = 7788;

--7. �����ȣ7369�;����������Ѹ�����Ǻμ���ȣ�����7369������μ���ȣ�ΰ����ϼ���.
UPDATE emp_copy SET dno = (SELECT dno FROM emp_copy WHERE eno = 7369) WHERE job = (SELECT job FROM emp_copy WHERE eno = 7369);

--8. Department���̺��Ǳ����ͳ����������Ͽ�DEPT_COPY���̸������̺������弼��
CREATE TABLE dept_copy AS SELECT * FROM department;

--9. DEPT_COPY���̺����μ�����RESEARCH�κμ��������ϼ���.
DELETE FROM dept_copy WHERE dname = 'RESEARCH';
SELECT * FROM dept_copy;

--10. DEPT_COPY���̺����μ���ȣ��10�̰ų�40�κμ��������ϼ���
DELETE FROM dept_copy WHERE dno IN (10, 40);

---------------------------------------------------------------------------------
-- �������� 7. ���̺� ����
--1. ����ǥ����õȴ��DEPT ���̺��������ϼ���.
CREATE TABLE dept (dno NUMBER(2), dname VARCHAR2(14), loc VARCHAR2(13));

--2. ����ǥ����õȴ��EMP ���̺��������ϼ���.
CREATE TABLE emp (eno NUMBER(4), ename VARCHAR2(10), dno NUMBER(2));

--3. ���̸��������Ҽ��ֵ���EMP���̺��������ϼ���.(ENAMEĮ��)
ALTER TABLE emp MODIFY ename VARCHAR2(25);

--4. EMPLOYEE���̺��������ؼ�EMPLOYEE2���̸������̺��������ϵǻ����ȣ, �̸�, �޿�, �μ���ȣĮ���������ϰ���λ�����Į����������EMP_ID, NAME, SAL, DEPT_ID�������ϼ���.
CREATE TABLE employee2 AS SELECT eno AS "EMP_ID", ename AS "NAME", salary AS "SAL", dno AS "DEPT_ID" FROM employee;

--5. EMP ���̺��������ϼ���
DROP TABLE emp;

--6. EMPLOYEE2���̺����̸���EMP�κ����ϼ���
RENAME employee2 TO emp;

--7. DEPT ���̺���DNAME Į���������ϼ���
ALTER TABLE dept DROP COLUMN dname;

--8. DEPT ���̺���LOCĮ����UNUSED��ǥ���ϼ���.
ALTER TABLE dept SET UNUSED (loc);

--9. UNUSED Į������������ϼ���.
ALTER TABLE dept DROP UNUSED COLUMNS;

---------------------------------------------------------------------------------
-- �������� 8. ������ ���Ἲ, ��������
--1. Employee���̺��Ǳ����������Ͽ�EMP_SAMPLE���̸������̺������弼��. ������̺��ǻ����ȣĮ�������̺�����primarykey���������������ϵ����������̸���my_emp_pk�������ϼ���.
SELECT * FROM employee;
SELECT * FROM emp_sample;
CREATE TABLE emp_sample AS SELECT * FROM employee WHERE 0=1;
ALTER TABLE emp_sample MODIFY eno CONSTRAINT my_emp_pk PRIMARY KEY;

--2. department���̺��Ǳ����������Ͽ�dept_sample�̶����̺������弼��. dept_sample�Ǻμ���ȣĮ�������̺�����primarykey���������������ϵ����������̸���my_dept_pk�������ϼ���.
CREATE TABLE dept_sample AS SELECT * FROM department WHERE 0=1;
ALTER TABLE dept_sample ADD CONSTRAINT my_dept_pk PRIMARY KEY(dno);

--3.������̺��Ǻμ���ȣĮ�������������ʴºμ��ǻ���̹��������ʵ��Ͽܷ�Ű���������������ϵ����������̸���my_emp_dept_fk�������ϼ���.
ALTER TABLE emp_sample ADD CONSTRAINT my_emp_dept_fk FOREIGN KEY(dno) REFERENCES dept_sample(dno);

--4. ������̺���Ŀ�̼��÷���0����ū�������Է��Ҽ��ֵ������������������ϼ���
ALTER TABLE emp_sample MODIFY commission CHECK(0 < commission);

---------------------------------------------------------------------------------
-- �������� 10. ������
--1. ��� ���̺��� �����ȣ�� �ڵ����� �����ǵ��� �������� �����Ͻÿ�. (���۰� : 1, ������ :1 �ִ밪:100000)
CREATE SEQUENCE ex_seq START WITH 1 INCREMENT BY 1 MAXVALUE 100000;

--2. �����ȣ�� �������κ��� �߱޹޾Ƽ� ������ ���̺� �����͸� �Է��ϼ���.
--1)��� �̸�: Julia, �Ի���: sysdate)
--2)��� �̸�: Alice �Ի���: 2020/12/31
CREATE TABLE emp01(empno number(4), ename varchar2(10), hiredate date);
SELECT * FROM emp01;
INSERT INTO emp01 VALUES(ex_seq.nextval, 'Julia', sysdate);
INSERT INTO emp01 VALUES(ex_seq.nextval, 'ALICE', '2022/12/31');

--3. EMP01���̺��� �̸� Į���� �ε����� �����ϵ� �ε��� �̸��� IDX_EMP01_EName�� �����ϼ���.
CREATE INDEX IDX_EMP01_EName ON emp01(ename);
