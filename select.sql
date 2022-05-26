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

SELECT ename, salary, salary*12+NVL(commission,0) AS "연 봉" FROM employee;

SELECT DNO FROM employee;

SELECT DISTINCT DNO FROM employee;
   
   SELECT ename,salary FROM employee WHERE ename='SMITH';
-- 알고싶다, 이름과 급여를    사원테이블에 있는  이름이 스미스인 사람

SELECT * FROM employee WHERE salary <= 1500;

SELECT * 
FROM employee 
WHERE ename!='SMITH';

SELECT * FROM employee WHERE  NOT hiredate <= '1981/05/31' OR salary >= 1200;

-- 급여가 1000에서 1500 사이인 사원을 조회  (BETWEEN A AND B : A와 B사이의 값)
SELECT * FROM employee WHERE salary>=1000 AND salary<=1500;

SELECT * FROM employee WHERE salary BETWEEN 1000 AND 1500;

-- 급여가 1000 미만이거나 1500초과인 사원을 조회
SELECT * FROM employee WHERE salary<1000 OR salary>1500;
SELECT * FROM employee WHERE NOT(salary>=1000 AND salary<=1500);

SELECT * FROM employee WHERE  salary NOT BETWEEN 1000 AND 1500;

-- 1981년도에 입사한 사원의 정보를 조회  => SQL
SELECT * FROM employee WHERE hiredate BETWEEN '1981/01/01' AND '1981/12/31';

-- 커미션이 300이거나 500이거나 1400인 사원을 조회  (IN 조건중에 일치하는 것)
SELECT * FROM employee WHERE commission=300 OR commission=500 OR commission=1400;
SELECT * FROM employee WHERE commission IN (300,500,1400);

--  (IS NULL  값이 null인 것)
SELECT * FROM employee WHERE commission IS NULL;

SELECT * FROM employee WHERE commission IS NOT NULL;

-- 문자열 일부 일치  LIKE
SELECT * FROM employee WHERE ename LIKE '%A%';
 -- %는 글자 개수도 모를때
 --  _는 글자 개수는 알때
SELECT * FROM employee WHERE ename LIKE '__A%';
 
SELECT * FROM employee 
WHERE salary>=1200
ORDER BY job DESC, salary ASC;

------------------------------------------------------------------------------------------------------
SELECT ename, hiredate, to_char(hiredate,'YY-MM'), to_char(hiredate, 'YYYY/MM/DD Day') FROM employee;

SELECT ename, hiredate FROM employee WHERE hiredate = to_date(19811117, 'YYYYMMDD');

SELECT ASCII('t'), ASCIISTR('밝'), CHR(84), UNISTR('\BC1D') FROM dual;

-- 글자수 출력 LENGTHC()
SELECT LENGTHC('오라클') FROM dual;

-- 문자열 결합 CONCAT() / 'A' || 'B'
SELECT CONCAT('기초기술','활용'), '기초'||'기술'||'활용' FROM dual;

SELECT ename|| ':' ||job FROM employee;

-- INSTR() 주어진 문장에서 내가 찾는 단어가 몇번째 있는지 찾는 함수, 아래는 10번째 이후에 있는 문자를 찾아 출력
SELECT INSTR('자바에서 문자는 string이고 자바스크립트에서 문자는 let이다.', '문자', 10) FROM dual;

-- 소문자로 변경 LOWER()
SELECT LOWER('StuDentName') FROM dual;

-- 대문자로 변경 UPPER()
SELECT UPPER('stuDentName') FROM dual;

-- 첫글자만 대문자 나머지 소문자 INITCAP()
SELECT INITCAP('stuDentName') FROM dual;

-- 문장에 있는 문자열 치환 REPLACE('문장','원래문자열','바꿀문자열')
SELECT REPLACE('자바에서 문자는 string이고 자바스크립트에서 문자는 let이다.', '자바', 'JAVA') FROM dual;

-- 한글에선 쓰기 적합하지 않은 TRANSLATE() 아래에선 이 => A, 것 => B로 치환 된듯하다
SELECT TRANSLATE('자바에서 문자는 string이고 자바스크립트에서 문자는 let이다.', '자바', 'JV') FROM dual;
SELECT TRANSLATE('이것이 Oracle이다.', '이것', 'AB') FROM dual;

-- 조건절에서 활용 하기
SELECT * FROM employee WHERE ename = UPPER('scott');
SELECT * FROM employee WHERE INITCAP(ename) = 'Scott';

-- 문장 자르기 SUBSTR('문장', n, m) n번째 문자부터 m개 문자 자르기
SELECT SUBSTR('응용sw기초기술활용', 5, 4) FROM dual;

-- 바이트 단위 거꾸로 뒤집기
SELECT REVERSE('Python') FROM dual;

-- SELECT FROM dual; 복사용 더미
-- 글자수 채우기 LPAD('문자열', 채울글자수, '채울문자') - 문자 왼쪽에 채우기
SELECT LPAD('java', 9, '-') FROM dual;

-- 글자수 채우기 RPAD('문자열', 채울글자수, '채울문자') - 문자 오른쪽에 채우기
SELECT RPAD('자바', 9, '-') FROM dual;

-- LTRIM() 왼쪽 공백 or 왼쪽 특정 문자 제거
SELECT LTRIM('        자바        ') FROM dual;
SELECT LTRIM('ㅋㅋㅋㅋㅋㅋ  재밌다', 'ㅋ') FROM dual;

-- RTRIM() 오른쪽 공백 or 오른쪽 특정 문자 제거
SELECT RTRIM('        자바        ') FROM dual;
SELECT LTRIM('ㅋㅋㅋㅋㅋㅋ  재밌다 ㅋㅋㅋㅋㅋㅋ', 'ㅋ') FROM dual;

-- TRIM() 안에 명령어에 따라 문자열 제거 LEADING=앞쪽 TRAILING=뒷쪽 BOTH=양쪽
SELECT TRIM(LEADING '*' FROM '***** 그린 아카데미 *****') FROM dual;
SELECT TRIM(TRAILING '*' FROM '***** 그린 아카데미 *****') FROM dual;
SELECT TRIM(BOTH '*' FROM '***** 그린 아카데미 *****') FROM dual;


SELECT * FROM employee WHERE SUBSTR(ename, -1, 1) = 'N';
SELECT * FROM employee WHERE SUBSTR(ename, -2, 2) = 'EN';

-- 소수점 CEIL()올림 FLOOR()내림 ROUND()반올림
SELECT CEIL(3.14), FLOOR(3.14), ROUND(3.14) FROM dual;

-- TRUNC(소수점숫자, n) 소수점 n번째까지 이후 버림
SELECT TRUNC(12345.12345, 2) FROM dual;
SELECT TRUNC(12345.12345, -2) FROM dual;

-- 날짜 계산
SELECT ADD_MONTHS('2022/05/24', 5) FROM dual;
SELECT ADD_MONTHS('2022/05/24', -7) FROM dual;

SELECT to_DATE('2022/05/24') + 5 FROM dual;

SELECT LAST_DAY('2022/05/24') FROM dual;

-- 24일 이후 목요일을 출력
SELECT NEXT_DAY('2022/05/24', '목요일') FROM dual;

SELECT ROUND(TO_DATE('2022/05/24'), 'CC') FROM dual;
SELECT ROUND(TO_DATE('2022/05/24'), 'YEAR') FROM dual;
-- Q는 분기
SELECT ROUND(TO_DATE('2022/05/24'), 'Q') FROM dual;
-- DY 요일은 시작인 일요일 수요일 기준 목요일부터 올림
SELECT ROUND(TO_DATE('2022/05/24'), 'DY') FROM dual;

-- NVL(컬럼, 값) 컬럼이 null이라면 값으로 대체
SELECT ename, salary, commission, NVL(commission, '0') FROM employee;

-- NVL2(컬럼, 값1, 값2)컬럼이 null이 아니면 값1 null이면 값2 출력
SELECT NVL2(commission, salary*12+commission, salary*12) FROM employee;

-- DECODE switch~case문과 비슷 DECODE(컬럼, 조건1, 값1, 조건2, 값2, ...)
SELECT ename, dno, DECODE(dno, 10, '교육부', 20, '총무부', 30, '재정부') FROM employee;
-- 줄바꿈 활용 앞에 조건이 없으면 default값으로 보면 될듯 하다
SELECT ename, dno, DECODE(dno, 10, '교육부',
                               20, '총무부',
                               30, '재정부',
                               40, '복지부',
                               '노동부') AS "부서명" FROM employee;

-- CASE WHEN~THEN END if~else 조건문과 비슷 CASE WHEN 조건 THEN 값 END
SELECT ename, dno, CASE WHEN dno=10 THEN '교육부' WHEN dno=20 THEN '총무부' WHEN dno=30 THEN '재정부' WHEN dno=40 THEN '복지부' ELSE '노동부' END FROM employee;
-- 줄바꿈 활용해 보기 편하게
SELECT ename, dno, CASE WHEN dno=10 THEN '교육부'
                        WHEN dno=20 THEN '총무부'
                        WHEN dno=30 THEN '재정부'
                        WHEN dno=40 THEN '복지부'
                        ELSE '노동부' END FROM employee;                            
                               
------------------------------------------------------------------------------------------
-- 합, 평균, 최대, 최소
SELECT SUM(salary) AS "급여 총합",
       TRUNC(AVG(salary)) AS "평균 급여",
       MAX(salary) AS "최대 급여",
       MIN(salary) AS "최소 급여" FROM employee;
       
-- 행 갯수를 구하는 COUNT()       
SELECT COUNT(ename) FROM employee;

SELECT COUNT(*) FROM employee;

SELECT COUNT(commission) AS "커미션 받는 사원" FROM employee;

SELECT SUM(commission) FROM employee;

-- 행 갯수가 다른 컬럼을 같이 조회하면 오류
--SELECT ename, MIN(salary) FROM employee;

--SELECT ename, salary FROM employee HAVING salary=MIN(salary);

-- 데이터 그룹
SELECT dno, ROUND(AVG(salary)) AS "평균급여" FROM employee GROUP BY dno;
SELECT dno, job, ROUND(AVG(salary)) AS "평균급여" FROM employee GROUP BY dno, job ORDER BY dno ASC, job DESC;

-- 업무별 그룹화된 평균급여가 2000이상인 그룸의 급여 총액
--SELECT job, SUM(salary) FROM employee WHERE AVG(salary) >= 2000 GROUP BY job; 에러

SELECT job, TRUNC(AVG(salary)), SUM(salary) FROM employee GROUP BY job HAVING AVG(salary) >= 2000;

-- 부서별 최고 급여가 3000이상인 부서의 번호와 해당 부서의 최고 급여를 구하세요.
SELECT dno, MAX(salary) FROM employee GROUP BY dno HAVING MAX(salary)>=3000;

-- 매니저를 제외하고 급여 총액이 5000이상인 담당 업무별 급여 총액
SELECT job, COUNT(job), SUM(salary) FROM employee WHERE job != 'MANAGER' GROUP BY job HAVING SUM(salary)>=5000;

--ROLLUP() 그룹합계에 전체합계 추가
SELECT dno, SUM(salary) FROM employee GROUP BY ROLLUP(dno);
SELECT job, dno, SUM(salary) FROM employee GROUP BY ROLLUP(job, dno);

-- 서브쿼리 (단일행)
SELECT ename, salary FROM employee WHERE salary > (SELECT salary FROM employee WHERE ename = 'SCOTT');

SELECT ename, job, salary FROM employee WHERE salary = (SELECT MIN(salary)FROM employee);
-- HAVING에도 서브쿼리 사용가능
SELECT dno, MIN(salary) FROM employee GROUP BY dno;
SELECT dno, MIN(salary) FROM employee GROUP BY dno HAVING MIN(salary) > (SELECT MIN(salary) FROM employee WHERE dno=30);

-- 서브쿼리 (다중행-결과값이 범위 or 여러개) ANY는 결과값 포함 - OR에 가깝다, ALL은 결과값 미포함 - AND에 가깝다
SELECT * FROM employee WHERE job != 'SALESMAN' AND salary < ANY (SELECT salary FROM employee WHERE job = 'SALESMAN');
SELECT * FROM employee WHERE job != 'SALESMAN' AND salary > ANY (SELECT salary FROM employee WHERE job = 'SALESMAN');
-- not -> != 과 <>이 같다.
SELECT * FROM employee WHERE job != 'SALESMAN' AND salary < ALL (SELECT salary FROM employee WHERE job = 'SALESMAN');
SELECT * FROM employee WHERE job <> 'SALESMAN' AND salary > ALL (SELECT salary FROM employee WHERE job = 'SALESMAN');
-- ANY = 는 IN과 같다 결과값중 하나라도 같은게 있으면 조회

-----------------------------------------------------------------------------------------------------------------------



-- 조인 : 두개 이상의 테이블로 부터 동시에 테이터를 읽어오는 방법
-- 7788 사원의 부서명을 알고 싶다. > 서브쿼리
SELECT dno, dname FROM department WHERE dno=(SELECT dno FROM employee WHERE eno=7788);

-- 카테시안 곱
SELECT * FROM department, employee;

-- EQUI 조인
SELECT * FROM department, employee WHERE department.dno = employee.dno;

-- 7788 사원의 이름과 급여 그리고 부서명을 알고 싶다. => 조인
SELECT employee.ename, employee.salary, department.dname FROM department, employee WHERE department.dno = employee.dno AND employee.eno=7788;
-- dno와 같이 겹치는 컬럼만 확실하게 테이블을 명시해주어도 된다. 테이블의 별칭을 써서 간략하게 사용할 수 있다.
SELECT ename, salary, dname, e.dno FROM department d, employee e WHERE d.dno = e.dno AND e.eno=7788;

-- NATURAL 조인 과거에 사용했지만 요즘은 거의 사용하지 않는다.
SELECT * FROM department NATURAL JOIN employee;

--SELECT ename, salary, dname, e.dno FROM department d NATURAL JOIN employee e WHERE e.eno=7788; 겹치는 dno의 테이블을 명시해줘서 오류
-- 자연스럽게 합쳐져야 하기때문에 겹치는 컬럼도 테이블을 명시해주지 않는다.
SELECT ename, salary, dname, dno FROM department d NATURAL JOIN employee e WHERE e.eno=7788;

-- JOIN USING 방식
SELECT * FROM department JOIN employee USING(dno);
SELECT * FROM department JOIN employee USING(dno) WHERE eno=7788;

-- JOIN ON => INNER JOIN [표준]
SELECT * FROM department d JOIN employee e ON d.dno = e.dno;
SELECT * FROM department d JOIN employee e ON d.dno = e.dno WHERE eno=7788;
SELECT * FROM department d INNER JOIN employee e ON d.dno = e.dno WHERE eno=7788;



--------------------------------------------------------------------------------------------------
-- NON-EQUI 조인
SELECT * FROM salgrade;

SELECT ename, salary, grade FROM employee e, salgrade s WHERE e.salary BETWEEN s.losal AND s.hisal;

-- 3개의 테이블을 합친 조인
-- 사원의 이름, 소속 부서 이름, 급여와 급여 등급
SELECT * FROM employee e, department d, salgrade s WHERE e.dno = d.dno AND e.salary >= s.losal AND e.salary <= s.hisal;

---------------------------------------------------------------------------------------------------
--SELF 조인 => 
SELECT * FROM employee;

-- 사원 이름과 담당 직장상사의 이름을 같이 출력해 봅시다.
SELECT emp.eno, emp.ename, manag.eno AS "상사사원번호", manag.ename AS "상사이름" FROM employee emp, employee manag WHERE emp.manager = manag.eno;

-- join on
SELECT emp.ename ||'의 직속상관은 '|| manag.ename AS "상사이름" FROM employee emp JOIN employee manag ON emp.manager = manag.eno;

----------------------------------------------------------------------------------------------------
-- OUTER JOIN (표준)
SELECT * FROM department d LEFT OUTER JOIN employee e ON d.dno = e.dno;

-- 오라클에서 OUTER 조인 => null을 표시하고자 하는 테이블 조건에 +표시, +가 표시 안된 테이블이 기준
SELECT * FROM department d, employee e WHERE d.dno = e.dno(+);

-- 사원이름과 담당 직장상사의 이름을 같이 출력해 봅시다.
-- 다만 상관 번호가 없는 경우 그냥 (NULL) 출력한다.
SELECT emp.eno, emp.ename, manag.eno AS "상사사원번호", manag.ename AS "상사이름"
FROM employee emp, employee manag WHERE emp.manager = manag.eno(+);
-- LEFT OUTER JOIN 방법
SELECT emp.eno, emp.ename, manag.eno AS "상사사원번호", manag.ename AS "상사이름"
FROM employee emp LEFT OUTER JOIN employee manag ON emp.manager = manag.eno;

-- 사원이름과 담당 직장상사의 이름을 같이 출력해 봅시다.
-- 다만 상관 번호가 없는 경우 그냥 (NULL) 출력한다.
-- 부하 직원이 없는 경우도 NULL로 출력한다.
SELECT emp.eno, emp.ename, manag.eno AS "상사사원번호", manag.ename AS "상사이름"
FROM employee emp FULL OUTER JOIN employee manag ON emp.manager = manag.eno;