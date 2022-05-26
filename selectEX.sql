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
-- 연습문제
SELECT * FROM employee;
--SELECT FROM employee;
--1
SELECT ename, salary, salary+300 AS "인상된 급여" FROM employee;

--2
SELECT ename, salary, salary*12+100 AS "연간 총수입" FROM employee ORDER BY "연간 총수입" DESC;

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

--11 급여 및 커미션 기준 내림차순 = 급여기준 내림차순, 급여가 같으면 커미션 기준 내림차순
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
-- 연습문제 2 (함수)
--1
SELECT ename, SUBSTR(hiredate, 1, 7) FROM employee;
SELECT ename, SUBSTR(hiredate, 1, 4) AS "년도", SUBSTR(hiredate, 6, 2) AS "월" FROM employee;

--2
SELECT ename, hiredate FROM employee WHERE SUBSTR(hiredate, 6, 2) = '04';
SELECT ename, hiredate FROM employee WHERE SUBSTR(hiredate, 7, 1) = '4';

--3 MOD(m,n) m을 n으로 나눌 때 나머지를 구하는 함수
SELECT * FROM employee WHERE MOD(eno,2) = 0;
SELECT * FROM employee WHERE MOD(eno,2) != 1;

--4
SELECT ename, to_CHAR(hiredate, 'YY MON DY') FROM employee;
SELECT ename, to_CHAR(hiredate, 'YY/MM/DD DY') FROM employee;

--5
SELECT (to_date('2022/05/24') - to_date('2022/01/01')) AS "올해 며칠이 지났나" FROM dual;
SELECT TRUNC(sysdate - to_date('2022/01/01', 'YYYY/MM/DD')) AS "올해 며칠이 지났나" FROM dual;

SELECT TRUNC(to_date('2022/11/17', 'YYYY/MM/DD') - sysdate) AS "수능 D-DAY" FROM dual;

--6
SELECT ename, NVL(manager, '0') FROM employee;
SELECT ename, NVL2(manager, manager, '0') AS "상관 사번" FROM employee;

--7
SELECT ename, job, DECODE(job, 'ANAIYST', salary+200,
                               'SALESMAN', salary+180,
                               'MANAGER', salary+150,
                               'CLERK', salary+100,
                               salary) AS "인상된 급여" FROM employee;
                               
                               

-----------------------------------------------------------------------------------------------------------------------
--연습문제3
--1. 모든사원의급여최고액, 최저액, 총액및평균급여를출력하세요. 사원의급여최고액, 최저액, 총액및평균급여를출력하세요. 칼럼의명칭은최고액(Maximun) 최저액(Minimun), 총액(Sum), 평균급여(Average)로지정하고평균에대해서는정수로반올림하세요.
SELECT MAX(salary) AS "최고액", MIN(salary) AS "최저액", SUM(salary) AS "총액", ROUND(AVG(salary)) AS "평균급여" FROM employee;

--2. 각담당업무유형별로급여최고액, 최저액, 총액및평균액을출력하세요. 칼럼의명칭은최고액(Maximun) 최저액(Minimun), 총액(Sum), 평균급여(Average)로지정하고평균에대해서는정수로반올림하세요.
SELECT job, MAX(salary) AS "최고액", MIN(salary) AS "최저액", SUM(salary) AS "총액", ROUND(AVG(salary)) AS "평균급여" FROM employee GROUP BY job;

--3. Count(*)함수를이용해서담당업무가동일한사원의수를출력하세요.
SELECT job, count(*) FROM employee GROUP BY job;

--4. 관리자의수를나열하세요. 칼럼의별칭은COUNT(MANAGER)로출력하세요.
SELECT COUNT('MANAGER') AS "COUNT(MANAGER)" FROM employee GROUP BY job HAVING job = 'MANAGER';
SELECT COUNT(DISTINCT(manager)) FROM employee;

--5. 급여최고액, 급여최저액의차액을출력하세요. 칼럼의별칭DIFFERENCE로지정하세요
SELECT MAX(salary) - MIN(salary) AS "DIFFERENCE" FROM employee;

--6. 직급별사원의최저급여를출력하세요. 관리자를알수없는사원및최저급여가2000미만인그룹은제외시키고급여에대한내림차순으로정렬하여출력하세요.
SELECT job, MIN(salary) AS "최저급여" FROM employee WHERE manager is not null GROUP BY job HAVING MIN(salary) >= 2000 ORDER BY "최저급여" DESC;

--7. 각부서에대해부서번호, 사원수, 부서내의모든사원의평균급여를출력하시오, 칼럼의별칭은부서번호(DNO), 사원수(Numberof PeoPle), 평균급여(Salary)로지정하고평균급여는소수점2째자리에서반올림하세요.
SELECT dno AS "부서번호(DNO)", COUNT(dno) AS "사원수(Numberof PeoPle)", ROUND(AVG(salary), 1) AS "평균급여(Salary)" FROM employee GROUP BY dno;

--8. 각부서에대해부서번호이름, 지역명, 사원수, 부서내의모든사원의평균급여를출력하시오. 칼럼의별칭은부서번호이름(DName), 지역명(Location), 사원수(Numberof PeoPle), 평균급여(Salary)로지정하고평균급여는정수로반올림하세요.
SELECT * FROM DEPARTMENT;
SELECT DECODE(dno, 10, 'ACCOUNTING',
                   20, 'RESEARCH',
                   30, 'SALES',
                   40, 'OPERATIONS') AS "Dname",
       DECODE(dno, 10, 'NEW YORK',
                   20, 'DALLAS',
                   30, 'CHICAGO',
                   40, 'BOSTON') AS "Location", COUNT(dno) AS "사원수", ROUND(AVG(salary)) AS "평균급여" FROM employee GROUP BY dno;

--9. 업무를표시한다음해당업무에대해부서번호별급여및부서10,20,30의급여총액을각각출력하시오. 각칼럼의별칭은각각job, 부서10,부서20, 부서30, 총액으로지정하세요.
SELECT job, dno AS "부서", SUM(salary) AS "총액" FROM employee GROUP BY job, dno ORDER BY job ASC;

SELECT job, NVL(SUM(DECODE(dno, 10, salary)), 0) AS "부서10", NVL(SUM(DECODE(dno, 20, salary)), 0) AS "부서20", NVL(SUM(DECODE(dno, 30, salary)), 0) AS "부서30", SUM(salary) AS "총액"FROM employee GROUP BY job;

SELECT job, DECODE(dno, 10, SUM(salary)) AS "부서10",
            DECODE(dno, 20, SUM(salary)) AS "부서20",
            DECODE(dno, 30, SUM(salary)) AS "부서30",
            SUM(salary) AS "총액" FROM employee GROUP BY dno, ROLLUP(job);


-----------------------------------------------------------------------------------------------------------------------------------------------
--연습문제4
--1. 사원번호가7788인사원과담당업무가같은사원을표시(사원이름과담당업무)하세요.
SELECT ename, job FROM employee WHERE job = (SELECT job FROM employee WHERE eno=7788);

--2. 사원번호가7499인사원보다급여가많은사원을표시(사원이름과담당업무)하세요
SELECT ename, job FROM employee WHERE salary > (SELECT salary FROM employee WHERE eno=7499);

--3. 최소급여를받는사원의이름, 담당업무및급여를표시하세요(그룹함수)
SELECT ename, job, salary FROM employee WHERE salary = (SELECT MIN(salary) FROM employee);

--4. 평균급여가가장적은업무를찾아직급과평균급여를표시하세요
SELECT job, ROUND(AVG(salary)) AS "평균급여" FROM employee GROUP BY job HAVING AVG(salary) = (SELECT MIN(AVG(salary)) FROM employee GROUP BY job);

--5. 각부서의최소급여를받는사원이름,급여, 부서번호를표시하세요.
SELECT dno, MIN(salary) FROM employee GROUP BY dno;
SELECT ename, salary, dno FROM employee WHERE salary = ANY((SELECT MIN(salary) FROM employee GROUP BY dno));

--6. 담당업무가분석가(ANALYST)인사원보다급여가적으면서업무가분석가(ANALYST)아닌사원(사원번호, 이름, 담당업무,급여)들을표시하세요.
SELECT eno, ename, job, salary FROM employee WHERE job != 'ANALYST' AND salary < ALL (SELECT salary FROM employee WHERE job = 'ANALYST');

--7. 매니저없는사원의이름을표시하세요.
SELECT ename FROM employee WHERE manager IS NULL;

--8. 매니저있는사원의이름을표시하세요.
SELECT ename FROM employee WHERE manager IS NOT NULL;

--9. BLAKE와동일한부서에속한사원의이름과입사일을표시하는질의를작성하세요.(단BLAKE는제외)
SELECT ename, dno, hiredate FROM employee WHERE ename != 'BLAKE' AND dno = (SELECT dno FROM employee WHERE ename = 'BLAKE');

--10. 급여가평균보다많은사원들의사원번호와이름을표시하되결과를급여에대한오름차순으로정렬하세요.
SELECT eno, ename, salary FROM employee WHERE salary >= (SELECT AVG(salary) FROM employee) ORDER BY salary ASC;

--11. 이름에K가포함된사원과같은부서에서일하는사원의사원번호와이름을표시하는질의를작성하세요.
SELECT dno, ename FROM employee WHERE ename LIKE '%K%';
SELECT eno, ename FROM employee WHERE dno IN (SELECT dno FROM employee WHERE ename LIKE '%K%');

--12. 부서위치가DALLAS인사원의이름과부서번호및담당업무를표시하세요
SELECT * FROM DEPARTMENT;
SELECT ename, dno, job FROM employee WHERE dno=(SELECT dno FROM department WHERE loc = 'DALLAS');

--13. KING에게보고하는사원의이름과급여를표시하세요
SELECT * FROM employee;
SELECT ename, salary FROM employee WHERE manager = (SELECT eno FROM employee WHERE ename = 'KING');

--14. RESEARCH 부서의사원에대한부서번호, 사원번호및담당업무를출력하세요
SELECT * FROM DEPARTMENT;
SELECT ename, dno, eno, job FROM employee WHERE dno=(SELECT dno FROM department WHERE dname = 'RESEARCH');

--15. 평균급여보다많은급여를받고이름에서M이포함된사원과같은부서에서근무하는사원의사원번호, 이름, 급여를출력하세요.
SELECT ename, dno FROM employee WHERE salary >= (SELECT AVG(salary) FROM employee);
SELECT ename, dno FROM employee WHERE ename LIKE '%M%';
SELECT eno, ename, salary FROM employee WHERE salary >= (SELECT AVG(salary) FROM employee) AND dno IN (SELECT dno FROM employee WHERE ename LIKE '%M%');

--16. 평균급여가가능적은업무를찾으세요
SELECT job, AVG(salary) FROM employee GROUP BY job HAVING AVG(salary) = (SELECT MIN(AVG(salary)) FROM employee GROUP BY job);

--17. 부하직원을가진사원의사원번호와이름을출력하세요
SELECT manager FROM employee WHERE manager IS NOT NULL;
SELECT eno, ename, job FROM employee WHERE eno IN (SELECT manager FROM employee WHERE manager IS NOT NULL);

--------------------------------------------------------------------------------------------------------------
-- 연습문제 5. join
--1. Equi조인을 사용하여 SCOTT 사원의 부서번호와 부서이름을 출력하세요.
SELECT ename, e.dno, dname FROM employee e, department d WHERE e.dno = d.dno AND e.ename = 'SCOTT';
SELECT ename, employee.dno, dname FROM employee JOIN department ON employee.dno = department.dno WHERE employee.ename = 'SCOTT';

--2. Inner 조인과 on연산자를 사용하여 사원이름과 함께 그 사원이 소속된 부서이름과 지역명을 출력하세요.
SELECT ename, dname, loc FROM employee e JOIN department d ON e.dno = d.dno;

--3. INNER 조인 Using 연산자를 사용하여 10번 부서에 속하는 모든 담당업무의 고유 목록을 부서의 지역명을 포함하여 출력하세요.
SELECT dno, job, loc FROM employee JOIN department USING(dno) WHERE dno = 10;

--4. Natural조인을 사용하여 커미션을 받는 모든 사원의 이름, 부서이름, 지역명을 출력하세요
SELECT ename, dname, loc FROM employee NATURAL JOIN department WHERE commission IS NOT NULL;

--5. Equal 조인과 Wild카드를 사용해서 이름에 A가 포함된 모든 사원의 이름과 부서명을 출력하세요,
SELECT ename, dname FROM employee e, department d WHERE e.dno = d.dno AND e.ename LIKE '%A%';

--6. Natural 조인을 사용하여 NEW York에 근무하는 모든 사원의 이름, 업무 부서번호 및 부서명을 출력하세요.
SELECT ename, dno, dname FROM employee NATURAL JOIN department WHERE loc = 'NEW YORK';

--7. Self Join을 사용하여 사원의 이름및 사원 번호를 관리자 이름 및 관리자 번호와 함께 출력하세요. 각 열의 별칭은 사원이름(Employee) 사원번호(emp#) 관리자이름(Manager) 관리자번호(Mgr#)
SELECT emp.ename AS "사원이름", emp.eno AS "사원번호", ma.ename AS "관리자이름", ma.eno AS "관리자번호" FROM employee emp, employee ma WHERE emp.manager = ma.eno;  

--8. Outter 조인 self 조인을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 클릭하세요 각 열의 별칭은 사원이름(Employee) 사원번호(emp#) 관리자이름(Manager) 관리자번호(Mgr#)
SELECT emp.ename AS "사원이름", emp.eno AS "사원번호", ma.ename AS "관리자이름", ma.eno AS "관리자번호" FROM employee emp, employee ma WHERE emp.manager = ma.eno(+) ORDER BY emp.eno DESC;

--9. Self조인을 사용하여 지정한 사원(SCOTT)의 이름, 부서번호, 지정한 사원과 동일한 부서에서 근무하는 사원을 출력하세요 각 열의 별칭은 이름, 부서번호, 동료로 지정하세요
SELECT em.ename AS "이름", em.dno AS "부서번호", ma.ename AS "동료" FROM employee em, employee ma 
WHERE em.ename = 'SCOTT' AND ma.dno = em.dno AND ma.ename != 'SCOTT';

--10. Self 조인을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하세요.
SELECT hiredate FROM employee WHERE ename = 'WARD';
SELECT ename, hiredate FROM employee WHERE hiredate > (SELECT hiredate FROM employee WHERE ename = 'WARD');
SELECT e2.ename, e2.hiredate FROM employee e1, employee e2 WHERE e1.ename = 'WARD' AND e1.hiredate < e2.hiredate;

--11. Self조인을 사용하여 관리자보다 먼저 입사한모든 사원의 이름 및 입사일을 관리자의 이름 및 입사입과 함께 출력하세요. 각 열의 별칭은 사원이름(Ename) 사원입사일(HIERDATE) 관리자 이름(Ename) 관리자 입사입(HIERDATE)로 출력하세요.
SELECT e.ename AS "사원이름", e.hiredate AS "사원입사일", ee.ename AS "관리자이름", ee.hiredate AS "관리자입사일" FROM employee e, employee ee WHERE e.manager = ee.eno AND e.hiredate < ee.hiredate;
