-- �������� 9.��
CREATE TABLE ex_employee AS SELECT * FROM employee;
SELECT * FROM ex_employee;
--1. 20�� �μ��� �Ҽӵ� ����� �����ȣ�� �̸�, �μ� ��ȭ�� ����ϴ� SELECT���� �ϳ��� ��(v_em_dno) �� �����ϼ���.
CREATE OR REPLACE VIEW v_em_dno AS SELECT eno, ename, dno FROM ex_employee;

--2. �̹� ������ ��(v_em_dno)�� ���ؼ� �޿��� ������ ���� ����� �� �ֵ��� �����ϼ���.
CREATE OR REPLACE VIEW v_em_dno AS SELECT eno, ename, dno, salary, job FROM ex_employee;

--3. ������ ���� �ִ�޿�, �ּұ޿�, �޿� �Ѿ��� �����ִ� ��(EMP_group_job)�� ������ ���� ��ȸ �غ���.
CREATE OR REPLACE VIEW EMP_group_job(�ִ�޿�, �ּұ޿�, �޿��Ѿ�) AS SELECT MAX(salary), MIN(salary), SUM(salary) FROM ex_employee GROUP BY job;

--4. �̹� ������ ��(v_em_dno)�� ���ؼ� ���ٰ����� �����͸� �Է°����ϵ��� ������ �ɾ� ����
CREATE OR REPLACE VIEW v_em_dno AS SELECT eno, ename, dno, salary, job FROM ex_employee WITH CHECK OPTION;

--5. ���� �����͸� �� (v_em_dno) �� ���ؼ� �Է��� �� �� ��(EMP_group_job)�� ���ؼ� ��ȸ �غ���.
INSERT INTO v_em_dno VALUES(5100, 'BELITA', 10, 1500, 'CLERK');
INSERT INTO v_em_dno VALUES(5200, 'ERICA', 20, 2300, 'ANALYST');
INSERT INTO v_em_dno VALUES(5300, 'KALI', 30, 1750, 'SALESMAN');
INSERT INTO v_em_dno VALUES(5400, 'MIA', 20, 950, 'ANALYST');
INSERT INTO v_em_dno VALUES(5500, 'ZINNA', 10, 1050, 'CLERK');
SELECT * FROM EMP_group_job;

--6. �̹� ������ ��(v_em_dno)�� ���ؼ� �б� ���� �Ӽ��� �ο��غ���
CREATE OR REPLACE VIEW v_em_dno AS SELECT eno, ename, dno, salary, job FROM ex_employee WITH READ ONLY;

--7. ���, ����̸�, �μ���ȣ�� �μ� �̸��� �����ִ� �並 (emp_dept) �����ϼ���
CREATE TABLE ex_department AS SELECT * FROM department;
CREATE OR REPLACE VIEW emp_dept AS SELECT eno, ename, e.dno, dname FROM ex_employee e join ex_department d on e.dno = d.dno;

--8. ������ ��� �並 ��ȸ�ϼ���.
SELECT view_name, text FROM user_views;
SELECT * FROM v_em_dno;
SELECT * FROM emp_group_job;
SELECT * FROM emp_dept;

--9. ������ ��(v_em_dno,emp_group_job,emp_dept)�� �����ϼ���.
DROP VIEW v_em_dno;
DROP VIEW emp_group_job;
DROP VIEW emp_dept;

---------------------------------------------------------------------------------
-- �������� 11. ����� ����
--1. �����ڷ� �α����� �� kbs��� ����ڸ� ����(��ȣ: pass)�ϼ���.
--CREATE USER kbs IDENTIFIED BY pass;

--2. �⺻���� ���� �ο��� ���� ������ �����ͺ��̽��� �α����� �Ұ����ϹǷ� connect�� resouce������ kbs����ڿ� �ο��ϼ���,
--GRANT connect TO kbs;
--GRANT resouce TO kbs;