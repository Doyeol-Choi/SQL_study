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


-----------------------------------------------------------------------------------------
-- ��������
SELECT * FROM employee;
--SELECT FROM employee;
--1
SELECT ename, salary, salary+300 AS "�λ�� �޿�" FROM employee;

--2
SELECT ename, salary, salary*12+100 AS "���� �Ѽ���" FROM employee ORDER BY "���� �Ѽ���" DESC;

--3
SELECT ename, salary FROM employee WHERE salary >= 2000 ORDER BY salary DESC;

--4
SELECT ename, dno FROM employee WHERE eno = 7788;

--5
SELECT ename, salary FROM employee WHERE NOT(salary >=2000 AND salary <= 3000);
SELECT ename, salary FROM employee WHERE NOT(salary BETWEEN 2000 AND 3000);
SELECT ename, salary FROM employee WHERE salary < 2000 OR salary > 3000;

--6
SELECT ename, job, hiredate FROM employee WHERE hiredate >= '1981/02/20' AND hiredate <= '1981/05/01';
SELECT ename, job, hiredate FROM employee WHERE hiredate BETWEEN '1981/02/20' AND '1981/05/01';

--7
SELECT ename, dno FROM employee WHERE dno = 20 OR dno = 30 ORDER BY ename DESC;
SELECT ename, dno FROM employee WHERE dno IN (20, 30) ORDER BY ename DESC;

--8
SELECT ename, salary, dno FROM employee WHERE (salary>=2000 AND salary<=3000) AND (dno=20 OR dno=30) ORDER BY ename ASC;
SELECT ename, salary, dno FROM employee WHERE (salary BETWEEN 2000 AND 3000) AND (dno=20 OR dno=30) ORDER BY ename ASC;
SELECT ename, salary, dno FROM employee WHERE (salary BETWEEN 2000 AND 3000) AND dno IN (20, 30) ORDER BY ename ASC;

--9
SELECT ename, hiredate FROM employee WHERE hiredate LIKE '1981%';
SELECT ename, hiredate FROM employee WHERE hiredate LIKE '__81%';
SELECT ename, hiredate FROM employee WHERE hiredate LIKE '%81%';

--10
SELECT ename, job FROM employee WHERE manager IS NULL;

--11 �޿� �� Ŀ�̼� ���� �������� = �޿����� ��������, �޿��� ������ Ŀ�̼� ���� ��������
SELECT ename, salary, commission FROM employee WHERE commission IS NOT NULL ORDER BY salary DESC, commission DESC;

--12
SELECT * FROM employee WHERE SUBSTR(ename, 3, 1) = 'R';
SELECT * FROM employee WHERE ename Like '__R%';

--13
SELECT ename FROM employee WHERE ename LIKE '%A%' AND ename LIKE '%E%';

--14
SELECT ename, job, salary FROM employee WHERE (job = 'CLERK' OR job = 'SALESMAN') AND NOT(salary=1600 OR salary=950 OR salary=1300);
SELECT ename, job, salary FROM employee WHERE job IN ('CLERK', 'SALESMAN') AND salary NOT IN(1600,950,1300);
SELECT ename, job, salary FROM employee WHERE UPPER(job) IN ('CLERK', 'SALESMAN') AND salary NOT IN(1600,950,1300);

--15
SELECT ename, salary, commission FROM employee WHERE commission>=500;

-----------------------------------------------------------------------------------
-- �������� 2 (�Լ�)
--1
SELECT ename, SUBSTR(hiredate, 1, 7) FROM employee;
SELECT ename, SUBSTR(hiredate, 1, 4) AS "�⵵", SUBSTR(hiredate, 6, 2) AS "��" FROM employee;

--2
SELECT ename, hiredate FROM employee WHERE SUBSTR(hiredate, 6, 2) = '04';
SELECT ename, hiredate FROM employee WHERE SUBSTR(hiredate, 7, 1) = '4';

--3 MOD(m,n) m�� n���� ���� �� �������� ���ϴ� �Լ�
SELECT * FROM employee WHERE MOD(eno,2) = 0;
SELECT * FROM employee WHERE MOD(eno,2) != 1;

--4
SELECT ename, to_CHAR(hiredate, 'YY MON DY') FROM employee;
SELECT ename, to_CHAR(hiredate, 'YY/MM/DD DY') FROM employee;

--5
SELECT (to_date('2022/05/24') - to_date('2022/01/01')) AS "���� ��ĥ�� ������" FROM dual;
SELECT TRUNC(sysdate - to_date('2022/01/01', 'YYYY/MM/DD')) AS "���� ��ĥ�� ������" FROM dual;

SELECT TRUNC(to_date('2022/11/17', 'YYYY/MM/DD') - sysdate) AS "���� D-DAY" FROM dual;

--6
SELECT ename, NVL(manager, '0') FROM employee;
SELECT ename, NVL2(manager, manager, '0') AS "��� ���" FROM employee;

--7
SELECT ename, job, DECODE(job, 'ANAIYST', salary+200,
                               'SALESMAN', salary+180,
                               'MANAGER', salary+150,
                               'CLERK', salary+100,
                               salary) AS "�λ�� �޿�" FROM employee;
                               
                               

-----------------------------------------------------------------------------------------------------------------------
--��������3
--1. ������Ǳ޿��ְ��, ������, �Ѿ׹���ձ޿�������ϼ���. ����Ǳ޿��ְ��, ������, �Ѿ׹���ձ޿�������ϼ���. Į���Ǹ�Ī���ְ��(Maximun) ������(Minimun), �Ѿ�(Sum), ��ձ޿�(Average)�������ϰ���տ����ؼ��������ιݿø��ϼ���.
SELECT MAX(salary) AS "�ְ��", MIN(salary) AS "������", SUM(salary) AS "�Ѿ�", ROUND(AVG(salary)) AS "��ձ޿�" FROM employee;

--2. ���������������α޿��ְ��, ������, �Ѿ׹���վ�������ϼ���. Į���Ǹ�Ī���ְ��(Maximun) ������(Minimun), �Ѿ�(Sum), ��ձ޿�(Average)�������ϰ���տ����ؼ��������ιݿø��ϼ���.
SELECT job, MAX(salary) AS "�ְ��", MIN(salary) AS "������", SUM(salary) AS "�Ѿ�", ROUND(AVG(salary)) AS "��ձ޿�" FROM employee GROUP BY job;

--3. Count(*)�Լ����̿��ؼ��������������ѻ���Ǽ�������ϼ���.
SELECT job, count(*) FROM employee GROUP BY job;

--4. �������Ǽ��������ϼ���. Į���Ǻ�Ī��COUNT(MANAGER)������ϼ���.
SELECT COUNT('MANAGER') AS "COUNT(MANAGER)" FROM employee GROUP BY job HAVING job = 'MANAGER';
SELECT COUNT(DISTINCT(manager)) FROM employee;

--5. �޿��ְ��, �޿�������������������ϼ���. Į���Ǻ�ĪDIFFERENCE�������ϼ���
SELECT MAX(salary) - MIN(salary) AS "DIFFERENCE" FROM employee;

--6. ���޺�����������޿�������ϼ���. �����ڸ��˼����»���������޿���2000�̸��α׷������ܽ�Ű��޿������ѳ����������������Ͽ�����ϼ���.
SELECT job, MIN(salary) AS "�����޿�" FROM employee WHERE manager is not null GROUP BY job HAVING MIN(salary) >= 2000 ORDER BY "�����޿�" DESC;

--7. ���μ������غμ���ȣ, �����, �μ����Ǹ��������ձ޿�������Ͻÿ�, Į���Ǻ�Ī���μ���ȣ(DNO), �����(Numberof PeoPle), ��ձ޿�(Salary)�������ϰ���ձ޿��¼Ҽ���2°�ڸ������ݿø��ϼ���.
SELECT dno AS "�μ���ȣ(DNO)", COUNT(dno) AS "�����(Numberof PeoPle)", ROUND(AVG(salary), 1) AS "��ձ޿�(Salary)" FROM employee GROUP BY dno;

--8. ���μ������غμ���ȣ�̸�, ������, �����, �μ����Ǹ��������ձ޿�������Ͻÿ�. Į���Ǻ�Ī���μ���ȣ�̸�(DName), ������(Location), �����(Numberof PeoPle), ��ձ޿�(Salary)�������ϰ���ձ޿��������ιݿø��ϼ���.
SELECT * FROM DEPARTMENT;
SELECT DECODE(dno, 10, 'ACCOUNTING',
                   20, 'RESEARCH',
                   30, 'SALES',
                   40, 'OPERATIONS') AS "Dname",
       DECODE(dno, 10, 'NEW YORK',
                   20, 'DALLAS',
                   30, 'CHICAGO',
                   40, 'BOSTON') AS "Location", COUNT(dno) AS "�����", ROUND(AVG(salary)) AS "��ձ޿�" FROM employee GROUP BY dno;

--9. ������ǥ���Ѵ����ش���������غμ���ȣ���޿��׺μ�10,20,30�Ǳ޿��Ѿ�����������Ͻÿ�. ��Į���Ǻ�Ī������job, �μ�10,�μ�20, �μ�30, �Ѿ����������ϼ���.
SELECT job, dno AS "�μ�", SUM(salary) AS "�Ѿ�" FROM employee GROUP BY job, dno ORDER BY job ASC;

SELECT job, NVL(SUM(DECODE(dno, 10, salary)), 0) AS "�μ�10", NVL(SUM(DECODE(dno, 20, salary)), 0) AS "�μ�20", NVL(SUM(DECODE(dno, 30, salary)), 0) AS "�μ�30", SUM(salary) AS "�Ѿ�"FROM employee GROUP BY job;

SELECT job, DECODE(dno, 10, SUM(salary)) AS "�μ�10",
            DECODE(dno, 20, SUM(salary)) AS "�μ�20",
            DECODE(dno, 30, SUM(salary)) AS "�μ�30",
            SUM(salary) AS "�Ѿ�" FROM employee GROUP BY dno, ROLLUP(job);


-----------------------------------------------------------------------------------------------------------------------------------------------
--��������4
--1. �����ȣ��7788�λ���������������������ǥ��(����̸���������)�ϼ���.
SELECT ename, job FROM employee WHERE job = (SELECT job FROM employee WHERE eno=7788);

--2. �����ȣ��7499�λ�����ٱ޿������������ǥ��(����̸���������)�ϼ���
SELECT ename, job FROM employee WHERE salary > (SELECT salary FROM employee WHERE eno=7499);

--3. �ּұ޿����޴»�����̸�, �������ױ޿���ǥ���ϼ���(�׷��Լ�)
SELECT ename, job, salary FROM employee WHERE salary = (SELECT MIN(salary) FROM employee);

--4. ��ձ޿�����������������ã�����ް���ձ޿���ǥ���ϼ���
SELECT job, ROUND(AVG(salary)) AS "��ձ޿�" FROM employee GROUP BY job HAVING AVG(salary) = (SELECT MIN(AVG(salary)) FROM employee GROUP BY job);

--5. ���μ����ּұ޿����޴»���̸�,�޿�, �μ���ȣ��ǥ���ϼ���.
SELECT dno, MIN(salary) FROM employee GROUP BY dno;
SELECT ename, salary, dno FROM employee WHERE salary = ANY((SELECT MIN(salary) FROM employee GROUP BY dno));

--6. ���������м���(ANALYST)�λ�����ٱ޿��������鼭�������м���(ANALYST)�ƴѻ��(�����ȣ, �̸�, ������,�޿�)����ǥ���ϼ���.
SELECT eno, ename, job, salary FROM employee WHERE job != 'ANALYST' AND salary < ALL (SELECT salary FROM employee WHERE job = 'ANALYST');

--7. �Ŵ������»�����̸���ǥ���ϼ���.
SELECT ename FROM employee WHERE manager IS NULL;

--8. �Ŵ����ִ»�����̸���ǥ���ϼ���.
SELECT ename FROM employee WHERE manager IS NOT NULL;

--9. BLAKE�͵����Ѻμ������ѻ�����̸����Ի�����ǥ���ϴ����Ǹ��ۼ��ϼ���.(��BLAKE������)
SELECT ename, dno, hiredate FROM employee WHERE ename != 'BLAKE' AND dno = (SELECT dno FROM employee WHERE ename = 'BLAKE');

--10. �޿�����պ��ٸ���������ǻ����ȣ���̸���ǥ���ϵǰ�����޿������ѿ����������������ϼ���.
SELECT eno, ename, salary FROM employee WHERE salary >= (SELECT AVG(salary) FROM employee) ORDER BY salary ASC;

--11. �̸���K�����ԵȻ���������μ��������ϴ»���ǻ����ȣ���̸���ǥ���ϴ����Ǹ��ۼ��ϼ���.
SELECT dno, ename FROM employee WHERE ename LIKE '%K%';
SELECT eno, ename FROM employee WHERE dno IN (SELECT dno FROM employee WHERE ename LIKE '%K%');

--12. �μ���ġ��DALLAS�λ�����̸����μ���ȣ�״�������ǥ���ϼ���
SELECT * FROM DEPARTMENT;
SELECT ename, dno, job FROM employee WHERE dno=(SELECT dno FROM department WHERE loc = 'DALLAS');

--13. KING���Ժ����ϴ»�����̸����޿���ǥ���ϼ���
SELECT * FROM employee;
SELECT ename, salary FROM employee WHERE manager = (SELECT eno FROM employee WHERE ename = 'KING');

--14. RESEARCH �μ��ǻ�������Ѻμ���ȣ, �����ȣ�״�����������ϼ���
SELECT * FROM DEPARTMENT;
SELECT ename, dno, eno, job FROM employee WHERE dno=(SELECT dno FROM department WHERE dname = 'RESEARCH');

--15. ��ձ޿����ٸ����޿����ް��̸�����M�����ԵȻ���������μ������ٹ��ϴ»���ǻ����ȣ, �̸�, �޿�������ϼ���.
SELECT ename, dno FROM employee WHERE salary >= (SELECT AVG(salary) FROM employee);
SELECT ename, dno FROM employee WHERE ename LIKE '%M%';
SELECT eno, ename, salary FROM employee WHERE salary >= (SELECT AVG(salary) FROM employee) AND dno IN (SELECT dno FROM employee WHERE ename LIKE '%M%');

--16. ��ձ޿�����������������ã������
SELECT job, AVG(salary) FROM employee GROUP BY job HAVING AVG(salary) = (SELECT MIN(AVG(salary)) FROM employee GROUP BY job);

--17. ������������������ǻ����ȣ���̸�������ϼ���
SELECT manager FROM employee WHERE manager IS NOT NULL;
SELECT eno, ename, job FROM employee WHERE eno IN (SELECT manager FROM employee WHERE manager IS NOT NULL);

--------------------------------------------------------------------------------------------------------------
-- �������� 5. join
--1. Equi������ ����Ͽ� SCOTT ����� �μ���ȣ�� �μ��̸��� ����ϼ���.
SELECT ename, e.dno, dname FROM employee e, department d WHERE e.dno = d.dno AND e.ename = 'SCOTT';
SELECT ename, employee.dno, dname FROM employee JOIN department ON employee.dno = department.dno WHERE employee.ename = 'SCOTT';

--2. Inner ���ΰ� on�����ڸ� ����Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �μ��̸��� �������� ����ϼ���.
SELECT ename, dname, loc FROM employee e JOIN department d ON e.dno = d.dno;

--3. INNER ���� Using �����ڸ� ����Ͽ� 10�� �μ��� ���ϴ� ��� �������� ���� ����� �μ��� �������� �����Ͽ� ����ϼ���.
SELECT dno, job, loc FROM employee JOIN department USING(dno) WHERE dno = 10;

--4. Natural������ ����Ͽ� Ŀ�̼��� �޴� ��� ����� �̸�, �μ��̸�, �������� ����ϼ���
SELECT ename, dname, loc FROM employee NATURAL JOIN department WHERE commission IS NOT NULL;

--5. Equal ���ΰ� Wildī�带 ����ؼ� �̸��� A�� ���Ե� ��� ����� �̸��� �μ����� ����ϼ���,
SELECT ename, dname FROM employee e, department d WHERE e.dno = d.dno AND e.ename LIKE '%A%';

--6. Natural ������ ����Ͽ� NEW York�� �ٹ��ϴ� ��� ����� �̸�, ���� �μ���ȣ �� �μ����� ����ϼ���.
SELECT ename, dno, dname FROM employee NATURAL JOIN department WHERE loc = 'NEW YORK';

--7. Self Join�� ����Ͽ� ����� �̸��� ��� ��ȣ�� ������ �̸� �� ������ ��ȣ�� �Բ� ����ϼ���. �� ���� ��Ī�� ����̸�(Employee) �����ȣ(emp#) �������̸�(Manager) �����ڹ�ȣ(Mgr#)
SELECT emp.ename AS "����̸�", emp.eno AS "�����ȣ", ma.ename AS "�������̸�", ma.eno AS "�����ڹ�ȣ" FROM employee emp, employee ma WHERE emp.manager = ma.eno;  

--8. Outter ���� self ������ ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� Ŭ���ϼ��� �� ���� ��Ī�� ����̸�(Employee) �����ȣ(emp#) �������̸�(Manager) �����ڹ�ȣ(Mgr#)
SELECT emp.ename AS "����̸�", emp.eno AS "�����ȣ", ma.ename AS "�������̸�", ma.eno AS "�����ڹ�ȣ" FROM employee emp, employee ma WHERE emp.manager = ma.eno(+) ORDER BY emp.eno DESC;

--9. Self������ ����Ͽ� ������ ���(SCOTT)�� �̸�, �μ���ȣ, ������ ����� ������ �μ����� �ٹ��ϴ� ����� ����ϼ��� �� ���� ��Ī�� �̸�, �μ���ȣ, ����� �����ϼ���
SELECT em.ename AS "�̸�", em.dno AS "�μ���ȣ", ma.ename AS "����" FROM employee em, employee ma 
WHERE em.ename = 'SCOTT' AND ma.dno = em.dno AND ma.ename != 'SCOTT';

--10. Self ������ ����Ͽ� WARD ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����ϼ���.
SELECT hiredate FROM employee WHERE ename = 'WARD';
SELECT ename, hiredate FROM employee WHERE hiredate > (SELECT hiredate FROM employee WHERE ename = 'WARD');
SELECT e2.ename, e2.hiredate FROM employee e1, employee e2 WHERE e1.ename = 'WARD' AND e1.hiredate < e2.hiredate;

--11. Self������ ����Ͽ� �����ں��� ���� �Ի��Ѹ�� ����� �̸� �� �Ի����� �������� �̸� �� �Ի��԰� �Բ� ����ϼ���. �� ���� ��Ī�� ����̸�(Ename) ����Ի���(HIERDATE) ������ �̸�(Ename) ������ �Ի���(HIERDATE)�� ����ϼ���.
SELECT e.ename AS "����̸�", e.hiredate AS "����Ի���", ee.ename AS "�������̸�", ee.hiredate AS "�������Ի���" FROM employee e, employee ee WHERE e.manager = ee.eno AND e.hiredate < ee.hiredate;
