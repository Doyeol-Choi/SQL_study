-- 연습문제 12. plsql
SET serveroutput ON;
--1. IF문을사용하여KING사원의부서번호를얻어와서부서번호를얻어와서부서번호에따른부서명을출력하세요.
DECLARE
    ex_dno employee.dno%type;
    ex_dname department.dname%type; 
BEGIN
    SELECT dno INTO ex_dno FROM employee WHERE ename='KING';
    IF ex_dno is not null THEN
        SELECT dname INTO ex_dname FROM department WHERE dno=ex_dno;
    END IF;
    dbms_output.put_line('부서번호 : '||ex_dno||' 부서명 : '||ex_dname);
END;

--2. BASICLOOP문으로1부터10사이의자연수의합을구하여출력하세요.
DECLARE
    isum number := 0;
    i number := 1;
BEGIN
    LOOP
        isum := isum + i;
        i := i + 1;
        IF i > 10 THEN
            EXIT;
        END IF;
    END LOOP;
    dbms_output.put_line('1~10 까지의 합 : '||isum);
END;

--3. FORLOOP무으로1부터10사이의자연수의합을구하여출력하세요.
DECLARE
    isum number := 0;
    i number := 1;
BEGIN
    FOR i IN 1..10 LOOP
        isum := isum + i;
    END LOOP;
    dbms_output.put_line('1~10 까지의 합 : '||isum);
END;

--4. WHILELOOP문으로1부터10사이의자연수의합을구하여출력하세요.
DECLARE
    isum number := 0;
    i number := 1;
BEGIN
    WHILE i < 11 LOOP
        isum := isum + i;
        i := i + 1;
    END LOOP;
    dbms_output.put_line('1~10 까지의 합 : '||isum);
END;

--5. 사원테이블에서커미션이NULL아닌상태의사원번호, 이름, 급여를이름기준으로오름차순으로정렬한결과를출력하세요.
DECLARE
    e_emp employee%rowtype;
    CURSOR ex_emp IS SELECT eno, ename, salary FROM employee WHERE commission is not null ORDER BY ename ASC;
BEGIN
    dbms_output.put_line('사원번호  이름  급여');
    dbms_output.put_line('------------------------');
    
    OPEN ex_emp;
        LOOP
            FETCH ex_emp INTO e_emp.eno, e_emp.ename, e_emp.salary;
            IF ex_emp%NOTFOUND THEN  -- 더이상 꺼낼게 없다면
                EXIT;
            END IF;
            dbms_output.put_line(e_emp.eno||'   '||e_emp.ename||'   '||e_emp.salary);
        END LOOP;
    CLOSE ex_emp;
END;

--6. 다음과같은테이블(Student)을만들고데이터를입력한다.
CREATE TABLE student(
                sid number PRIMARY KEY,
                sname nvarchar2(5) not null,
                kscore number(3) check(0 <= kscore and kscore <= 100),
                escore number(3) check(0 <= escore and escore <= 100),
                mscore number(3) check(0 <= mscore and mscore <= 100));
CREATE SEQUENCE seq_stu_id;
INSERT INTO student VALUES(seq_stu_id.nextval, '고길동', 78, 64, 82);
INSERT INTO student VALUES(seq_stu_id.nextval, '김길동', 85, 71, 64);
INSERT INTO student VALUES(seq_stu_id.nextval, '이길동', 74, 69, 57);
INSERT INTO student VALUES(seq_stu_id.nextval, '박길동', 74, 77, 95);
INSERT INTO student VALUES(seq_stu_id.nextval, '홍길동', 68, 95, 84);

SELECT * FROM student;

-- 학생별총점과평균을구하세요.
DECLARE
    stu_sum number(4);
    stu_avg number(5, 2);
    stu student%rowtype;
    CURSOR c_stu IS SELECT sname, kscore, escore, mscore FROM student ORDER BY sid ASC;
BEGIN
    OPEN c_stu;
        LOOP
            FETCH c_stu INTO stu.sname, stu.kscore, stu.escore, stu.mscore;
            IF c_stu%NOTFOUND THEN
                EXIT;
            END IF;
            stu_sum := stu.kscore + stu.escore + stu.mscore;
            stu_avg := stu_sum / 3;
            dbms_output.put_line(stu.sname||'의 총점 : '||stu_sum||' 평균 : '||stu_avg);
        END LOOP;
    CLOSE c_stu;
END;

-- 과목별총점과평균을구하세요.
--DECLARE
--    k_sum number(3):=0;
--    e_sum number(3):=0;
--    m_sum number(3):=0;
--    k_avg number(5,2);
--    e_avg number(5,2);
--    m_avg number(5,2);
--    stu student%rowtype;
--    CURSOR c_stu IS SELECT kscore, escore, mscore FROM student;
--BEGIN
--    OPEN c_stu;
--        LOOP
--            FETCH c_stu INTO stu.kscore, stu.escore, stu.mscore;
--            IF c_stu%NOTFOUND THEN
--                EXIT;
--            END IF;
--            k_sum := k_sum + stu.kscore;
--            e_sum := e_sum + stu.escore;
--            m_sum := m_sum + stu.mscore;
--        END LOOP;
--        k_avg := k_sum / 5;
--        e_avg := e_sum / 5;
--        m_avg := m_sum / 5;
--        dbms_output.put_line('국어 과목의 총점 : '||k_sum||' 평균 : '||k_avg);
--        dbms_output.put_line('영어 과목의 총점 : '||e_sum||' 평균 : '||e_avg);
--        dbms_output.put_line('수학 과목의 총점 : '||m_sum||' 평균 : '||m_avg);
--    CLOSE c_stu;
--END;
DECLARE
    k_sum number(3);
    e_sum number(3);
    m_sum number(3);
    k_avg number(5,2);
    e_avg number(5,2);
    m_avg number(5,2);
BEGIN
    SELECT SUM(kscore), SUM(escore), SUM(mscore) INTO k_sum, e_sum, m_sum FROM student;
    k_avg := k_sum / 5; 
    e_avg := e_sum / 5;
    m_avg := m_sum / 5;
    dbms_output.put_line('국어 과목의 총점 : '||k_sum||' 평균 : '||k_avg);
    dbms_output.put_line('영어 과목의 총점 : '||e_sum||' 평균 : '||e_avg);
    dbms_output.put_line('수학 과목의 총점 : '||m_sum||' 평균 : '||m_avg);
END;
---------------------------------------------------------------------------------
-- 연습문제 13. 프로시저
--1. 사원테이블에서커미션이NULL이아닌상태의사원번호와이름, 급여를기준으로오름차순정렬한결과를나타내는저장프로시저를생성하세요.
CREATE OR REPLACE PROCEDURE pro_emp
IS
    ex_emp employee%rowtype;
    CURSOR c_emp IS SELECT eno, ename, salary FROM employee WHERE commission is not null ORDER BY salary ASC;
BEGIN
    dbms_output.put_line('사원번호  이름  급여');
    dbms_output.put_line('-------------------------');
    FOR ex_emp IN c_emp LOOP
        dbms_output.put_line(ex_emp.eno||'   '||ex_emp.ename||'   '||ex_emp.salary);
    END LOOP;
END;

EXECUTE pro_emp;

--2. 저장프로시저를수정하여커미션컬럼을하나더출력하고이름을기준로내리차순으로정렬하세요.
CREATE OR REPLACE PROCEDURE pro_emp
IS
    ex_emp employee%rowtype;
    CURSOR c_emp IS SELECT eno, ename, salary, commission FROM employee WHERE commission is not null ORDER BY ename DESC;
BEGIN
    dbms_output.put_line('사원번호  이름  급여  커미션');
    dbms_output.put_line('--------------------------------');
    FOR ex_emp IN c_emp LOOP
        dbms_output.put_line(ex_emp.eno||'   '||ex_emp.ename||'   '||ex_emp.salary||'   '||ex_emp.commission);
    END LOOP;
END;

--3. 생성된저장프로시저를제거하세요.
DROP PROCEDURE pro_emp;
