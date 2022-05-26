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
DESC EMPLOYEE;

SELECT sysdate FROM dual;

SELECT * FROM employee;

SELECT eno, ename, job, manager, hiredate, salary, commission, dno FROM green.employee;

SELECT ename, salary, salary*12 FROM employee;

SELECT ename, salary, salary*12+commission FROM employee;

SELECT ename, salary, salary*12+NVL(commission,0) AS "�� ��" FROM employee;

SELECT DNO FROM employee;

SELECT DISTINCT DNO FROM employee;
   
   SELECT ename,salary FROM employee WHERE ename='SMITH';
-- �˰�ʹ�, �̸��� �޿���    ������̺� �ִ�  �̸��� ���̽��� ���

SELECT * FROM employee WHERE salary <= 1500;

SELECT * 
FROM employee 
WHERE ename!='SMITH';

SELECT * FROM employee WHERE  NOT hiredate <= '1981/05/31' OR salary >= 1200;

-- �޿��� 1000���� 1500 ������ ����� ��ȸ  (BETWEEN A AND B : A�� B������ ��)
SELECT * FROM employee WHERE salary>=1000 AND salary<=1500;

SELECT * FROM employee WHERE salary BETWEEN 1000 AND 1500;

-- �޿��� 1000 �̸��̰ų� 1500�ʰ��� ����� ��ȸ
SELECT * FROM employee WHERE salary<1000 OR salary>1500;
SELECT * FROM employee WHERE NOT(salary>=1000 AND salary<=1500);

SELECT * FROM employee WHERE  salary NOT BETWEEN 1000 AND 1500;

-- 1981�⵵�� �Ի��� ����� ������ ��ȸ  => SQL
SELECT * FROM employee WHERE hiredate BETWEEN '1981/01/01' AND '1981/12/31';

-- Ŀ�̼��� 300�̰ų� 500�̰ų� 1400�� ����� ��ȸ  (IN �����߿� ��ġ�ϴ� ��)
SELECT * FROM employee WHERE commission=300 OR commission=500 OR commission=1400;
SELECT * FROM employee WHERE commission IN (300,500,1400);

--  (IS NULL  ���� null�� ��)
SELECT * FROM employee WHERE commission IS NULL;

SELECT * FROM employee WHERE commission IS NOT NULL;

-- ���ڿ� �Ϻ� ��ġ  LIKE
SELECT * FROM employee WHERE ename LIKE '%A%';
 -- %�� ���� ������ �𸦶�
 --  _�� ���� ������ �˶�
SELECT * FROM employee WHERE ename LIKE '__A%';
 
SELECT * FROM employee 
WHERE salary>=1200
ORDER BY job DESC, salary ASC;

------------------------------------------------------------------------------------------------------
SELECT ename, hiredate, to_char(hiredate,'YY-MM'), to_char(hiredate, 'YYYY/MM/DD Day') FROM employee;

SELECT ename, hiredate FROM employee WHERE hiredate = to_date(19811117, 'YYYYMMDD');

SELECT ASCII('t'), ASCIISTR('��'), CHR(84), UNISTR('\BC1D') FROM dual;

-- ���ڼ� ��� LENGTHC()
SELECT LENGTHC('����Ŭ') FROM dual;

-- ���ڿ� ���� CONCAT() / 'A' || 'B'
SELECT CONCAT('���ʱ��','Ȱ��'), '����'||'���'||'Ȱ��' FROM dual;

SELECT ename|| ':' ||job FROM employee;

-- INSTR() �־��� ���忡�� ���� ã�� �ܾ ���° �ִ��� ã�� �Լ�, �Ʒ��� 10��° ���Ŀ� �ִ� ���ڸ� ã�� ���
SELECT INSTR('�ڹٿ��� ���ڴ� string�̰� �ڹٽ�ũ��Ʈ���� ���ڴ� let�̴�.', '����', 10) FROM dual;

-- �ҹ��ڷ� ���� LOWER()
SELECT LOWER('StuDentName') FROM dual;

-- �빮�ڷ� ���� UPPER()
SELECT UPPER('stuDentName') FROM dual;

-- ù���ڸ� �빮�� ������ �ҹ��� INITCAP()
SELECT INITCAP('stuDentName') FROM dual;

-- ���忡 �ִ� ���ڿ� ġȯ REPLACE('����','�������ڿ�','�ٲܹ��ڿ�')
SELECT REPLACE('�ڹٿ��� ���ڴ� string�̰� �ڹٽ�ũ��Ʈ���� ���ڴ� let�̴�.', '�ڹ�', 'JAVA') FROM dual;

-- �ѱۿ��� ���� �������� ���� TRANSLATE() �Ʒ����� �� => A, �� => B�� ġȯ �ȵ��ϴ�
SELECT TRANSLATE('�ڹٿ��� ���ڴ� string�̰� �ڹٽ�ũ��Ʈ���� ���ڴ� let�̴�.', '�ڹ�', 'JV') FROM dual;
SELECT TRANSLATE('�̰��� Oracle�̴�.', '�̰�', 'AB') FROM dual;

-- ���������� Ȱ�� �ϱ�
SELECT * FROM employee WHERE ename = UPPER('scott');
SELECT * FROM employee WHERE INITCAP(ename) = 'Scott';

-- ���� �ڸ��� SUBSTR('����', n, m) n��° ���ں��� m�� ���� �ڸ���
SELECT SUBSTR('����sw���ʱ��Ȱ��', 5, 4) FROM dual;

-- ����Ʈ ���� �Ųٷ� ������
SELECT REVERSE('Python') FROM dual;

-- SELECT FROM dual; ����� ����
-- ���ڼ� ä��� LPAD('���ڿ�', ä����ڼ�, 'ä�﹮��') - ���� ���ʿ� ä���
SELECT LPAD('java', 9, '-') FROM dual;

-- ���ڼ� ä��� RPAD('���ڿ�', ä����ڼ�, 'ä�﹮��') - ���� �����ʿ� ä���
SELECT RPAD('�ڹ�', 9, '-') FROM dual;

-- LTRIM() ���� ���� or ���� Ư�� ���� ����
SELECT LTRIM('        �ڹ�        ') FROM dual;
SELECT LTRIM('������������  ��մ�', '��') FROM dual;

-- RTRIM() ������ ���� or ������ Ư�� ���� ����
SELECT RTRIM('        �ڹ�        ') FROM dual;
SELECT LTRIM('������������  ��մ� ������������', '��') FROM dual;

-- TRIM() �ȿ� ��ɾ ���� ���ڿ� ���� LEADING=���� TRAILING=���� BOTH=����
SELECT TRIM(LEADING '*' FROM '***** �׸� ��ī���� *****') FROM dual;
SELECT TRIM(TRAILING '*' FROM '***** �׸� ��ī���� *****') FROM dual;
SELECT TRIM(BOTH '*' FROM '***** �׸� ��ī���� *****') FROM dual;


SELECT * FROM employee WHERE SUBSTR(ename, -1, 1) = 'N';
SELECT * FROM employee WHERE SUBSTR(ename, -2, 2) = 'EN';

-- �Ҽ��� CEIL()�ø� FLOOR()���� ROUND()�ݿø�
SELECT CEIL(3.14), FLOOR(3.14), ROUND(3.14) FROM dual;

-- TRUNC(�Ҽ�������, n) �Ҽ��� n��°���� ���� ����
SELECT TRUNC(12345.12345, 2) FROM dual;
SELECT TRUNC(12345.12345, -2) FROM dual;

-- ��¥ ���
SELECT ADD_MONTHS('2022/05/24', 5) FROM dual;
SELECT ADD_MONTHS('2022/05/24', -7) FROM dual;

SELECT to_DATE('2022/05/24') + 5 FROM dual;

SELECT LAST_DAY('2022/05/24') FROM dual;

-- 24�� ���� ������� ���
SELECT NEXT_DAY('2022/05/24', '�����') FROM dual;

SELECT ROUND(TO_DATE('2022/05/24'), 'CC') FROM dual;
SELECT ROUND(TO_DATE('2022/05/24'), 'YEAR') FROM dual;
-- Q�� �б�
SELECT ROUND(TO_DATE('2022/05/24'), 'Q') FROM dual;
-- DY ������ ������ �Ͽ��� ������ ���� ����Ϻ��� �ø�
SELECT ROUND(TO_DATE('2022/05/24'), 'DY') FROM dual;

-- NVL(�÷�, ��) �÷��� null�̶�� ������ ��ü
SELECT ename, salary, commission, NVL(commission, '0') FROM employee;

-- NVL2(�÷�, ��1, ��2)�÷��� null�� �ƴϸ� ��1 null�̸� ��2 ���
SELECT NVL2(commission, salary*12+commission, salary*12) FROM employee;

-- DECODE switch~case���� ��� DECODE(�÷�, ����1, ��1, ����2, ��2, ...)
SELECT ename, dno, DECODE(dno, 10, '������', 20, '�ѹ���', 30, '������') FROM employee;
-- �ٹٲ� Ȱ�� �տ� ������ ������ default������ ���� �ɵ� �ϴ�
SELECT ename, dno, DECODE(dno, 10, '������',
                               20, '�ѹ���',
                               30, '������',
                               40, '������',
                               '�뵿��') AS "�μ���" FROM employee;

-- CASE WHEN~THEN END if~else ���ǹ��� ��� CASE WHEN ���� THEN �� END
SELECT ename, dno, CASE WHEN dno=10 THEN '������' WHEN dno=20 THEN '�ѹ���' WHEN dno=30 THEN '������' WHEN dno=40 THEN '������' ELSE '�뵿��' END FROM employee;
-- �ٹٲ� Ȱ���� ���� ���ϰ�
SELECT ename, dno, CASE WHEN dno=10 THEN '������'
                        WHEN dno=20 THEN '�ѹ���'
                        WHEN dno=30 THEN '������'
                        WHEN dno=40 THEN '������'
                        ELSE '�뵿��' END FROM employee;                            
                               
------------------------------------------------------------------------------------------
-- ��, ���, �ִ�, �ּ�
SELECT SUM(salary) AS "�޿� ����",
       TRUNC(AVG(salary)) AS "��� �޿�",
       MAX(salary) AS "�ִ� �޿�",
       MIN(salary) AS "�ּ� �޿�" FROM employee;
       
-- �� ������ ���ϴ� COUNT()       
SELECT COUNT(ename) FROM employee;

SELECT COUNT(*) FROM employee;

SELECT COUNT(commission) AS "Ŀ�̼� �޴� ���" FROM employee;

SELECT SUM(commission) FROM employee;

-- �� ������ �ٸ� �÷��� ���� ��ȸ�ϸ� ����
--SELECT ename, MIN(salary) FROM employee;

--SELECT ename, salary FROM employee HAVING salary=MIN(salary);

-- ������ �׷�
SELECT dno, ROUND(AVG(salary)) AS "��ձ޿�" FROM employee GROUP BY dno;
SELECT dno, job, ROUND(AVG(salary)) AS "��ձ޿�" FROM employee GROUP BY dno, job ORDER BY dno ASC, job DESC;

-- ������ �׷�ȭ�� ��ձ޿��� 2000�̻��� �׷��� �޿� �Ѿ�
--SELECT job, SUM(salary) FROM employee WHERE AVG(salary) >= 2000 GROUP BY job; ����

SELECT job, TRUNC(AVG(salary)), SUM(salary) FROM employee GROUP BY job HAVING AVG(salary) >= 2000;

-- �μ��� �ְ� �޿��� 3000�̻��� �μ��� ��ȣ�� �ش� �μ��� �ְ� �޿��� ���ϼ���.
SELECT dno, MAX(salary) FROM employee GROUP BY dno HAVING MAX(salary)>=3000;

-- �Ŵ����� �����ϰ� �޿� �Ѿ��� 5000�̻��� ��� ������ �޿� �Ѿ�
SELECT job, COUNT(job), SUM(salary) FROM employee WHERE job != 'MANAGER' GROUP BY job HAVING SUM(salary)>=5000;

--ROLLUP() �׷��հ迡 ��ü�հ� �߰�
SELECT dno, SUM(salary) FROM employee GROUP BY ROLLUP(dno);
SELECT job, dno, SUM(salary) FROM employee GROUP BY ROLLUP(job, dno);

-- �������� (������)
SELECT ename, salary FROM employee WHERE salary > (SELECT salary FROM employee WHERE ename = 'SCOTT');

SELECT ename, job, salary FROM employee WHERE salary = (SELECT MIN(salary)FROM employee);
-- HAVING���� �������� ��밡��
SELECT dno, MIN(salary) FROM employee GROUP BY dno;
SELECT dno, MIN(salary) FROM employee GROUP BY dno HAVING MIN(salary) > (SELECT MIN(salary) FROM employee WHERE dno=30);

-- �������� (������-������� ���� or ������) ANY�� ����� ���� - OR�� ������, ALL�� ����� ������ - AND�� ������
SELECT * FROM employee WHERE job != 'SALESMAN' AND salary < ANY (SELECT salary FROM employee WHERE job = 'SALESMAN');
SELECT * FROM employee WHERE job != 'SALESMAN' AND salary > ANY (SELECT salary FROM employee WHERE job = 'SALESMAN');
-- not -> != �� <>�� ����.
SELECT * FROM employee WHERE job != 'SALESMAN' AND salary < ALL (SELECT salary FROM employee WHERE job = 'SALESMAN');
SELECT * FROM employee WHERE job <> 'SALESMAN' AND salary > ALL (SELECT salary FROM employee WHERE job = 'SALESMAN');
-- ANY = �� IN�� ���� ������� �ϳ��� ������ ������ ��ȸ

-----------------------------------------------------------------------------------------------------------------------



-- ���� : �ΰ� �̻��� ���̺�� ���� ���ÿ� �����͸� �о���� ���
-- 7788 ����� �μ����� �˰� �ʹ�. > ��������
SELECT dno, dname FROM department WHERE dno=(SELECT dno FROM employee WHERE eno=7788);

-- ī�׽þ� ��
SELECT * FROM department, employee;

-- EQUI ����
SELECT * FROM department, employee WHERE department.dno = employee.dno;

-- 7788 ����� �̸��� �޿� �׸��� �μ����� �˰� �ʹ�. => ����
SELECT employee.ename, employee.salary, department.dname FROM department, employee WHERE department.dno = employee.dno AND employee.eno=7788;
-- dno�� ���� ��ġ�� �÷��� Ȯ���ϰ� ���̺��� ������־ �ȴ�. ���̺��� ��Ī�� �Ἥ �����ϰ� ����� �� �ִ�.
SELECT ename, salary, dname, e.dno FROM department d, employee e WHERE d.dno = e.dno AND e.eno=7788;

-- NATURAL ���� ���ſ� ��������� ������ ���� ������� �ʴ´�.
SELECT * FROM department NATURAL JOIN employee;

--SELECT ename, salary, dname, e.dno FROM department d NATURAL JOIN employee e WHERE e.eno=7788; ��ġ�� dno�� ���̺��� ������༭ ����
-- �ڿ������� �������� �ϱ⶧���� ��ġ�� �÷��� ���̺��� ��������� �ʴ´�.
SELECT ename, salary, dname, dno FROM department d NATURAL JOIN employee e WHERE e.eno=7788;

-- JOIN USING ���
SELECT * FROM department JOIN employee USING(dno);
SELECT * FROM department JOIN employee USING(dno) WHERE eno=7788;

-- JOIN ON => INNER JOIN [ǥ��]
SELECT * FROM department d JOIN employee e ON d.dno = e.dno;
SELECT * FROM department d JOIN employee e ON d.dno = e.dno WHERE eno=7788;
SELECT * FROM department d INNER JOIN employee e ON d.dno = e.dno WHERE eno=7788;



--------------------------------------------------------------------------------------------------
-- NON-EQUI ����
SELECT * FROM salgrade;

SELECT ename, salary, grade FROM employee e, salgrade s WHERE e.salary BETWEEN s.losal AND s.hisal;

-- 3���� ���̺��� ��ģ ����
-- ����� �̸�, �Ҽ� �μ� �̸�, �޿��� �޿� ���
SELECT * FROM employee e, department d, salgrade s WHERE e.dno = d.dno AND e.salary >= s.losal AND e.salary <= s.hisal;

---------------------------------------------------------------------------------------------------
--SELF ���� => 
SELECT * FROM employee;

-- ��� �̸��� ��� �������� �̸��� ���� ����� ���ô�.
SELECT emp.eno, emp.ename, manag.eno AS "�������ȣ", manag.ename AS "����̸�" FROM employee emp, employee manag WHERE emp.manager = manag.eno;

-- join on
SELECT emp.ename ||'�� ���ӻ���� '|| manag.ename AS "����̸�" FROM employee emp JOIN employee manag ON emp.manager = manag.eno;

----------------------------------------------------------------------------------------------------
-- OUTER JOIN (ǥ��)
SELECT * FROM department d LEFT OUTER JOIN employee e ON d.dno = e.dno;

-- ����Ŭ���� OUTER ���� => null�� ǥ���ϰ��� �ϴ� ���̺� ���ǿ� +ǥ��, +�� ǥ�� �ȵ� ���̺��� ����
SELECT * FROM department d, employee e WHERE d.dno = e.dno(+);

-- ����̸��� ��� �������� �̸��� ���� ����� ���ô�.
-- �ٸ� ��� ��ȣ�� ���� ��� �׳� (NULL) ����Ѵ�.
SELECT emp.eno, emp.ename, manag.eno AS "�������ȣ", manag.ename AS "����̸�"
FROM employee emp, employee manag WHERE emp.manager = manag.eno(+);
-- LEFT OUTER JOIN ���
SELECT emp.eno, emp.ename, manag.eno AS "�������ȣ", manag.ename AS "����̸�"
FROM employee emp LEFT OUTER JOIN employee manag ON emp.manager = manag.eno;

-- ����̸��� ��� �������� �̸��� ���� ����� ���ô�.
-- �ٸ� ��� ��ȣ�� ���� ��� �׳� (NULL) ����Ѵ�.
-- ���� ������ ���� ��쵵 NULL�� ����Ѵ�.
SELECT emp.eno, emp.ename, manag.eno AS "�������ȣ", manag.ename AS "����̸�"
FROM employee emp FULL OUTER JOIN employee manag ON emp.manager = manag.eno;