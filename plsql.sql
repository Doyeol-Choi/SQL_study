-- PL/SQL
SET serveroutput ON;

BEGIN
    dbms_output.put_line('Hello WORLD!!');     -- 기본 출력문
END;

-- 변수 타입
DECLARE
    -- (Java) 타입 이름 = 데이터;
    -- (PL/sql) 이름 타입 := 데이터;
    -- 타입 -2종류
    -- 1) 스칼라   : 기존의 SQL에서 사용하던 데이터 타입, number, varchar2, ...
    -- 2) 레퍼런스 : 이미 테이블의 컬럼에서 사용하는 타입, (A테이블의 b컬럼의 타입을 사용)
    --name1 varchar2(10);  -- 스칼라 타입의 데이터 지정
    name2 employee.ename%type;  -- 레퍼런스 타입의 데이터 지정
    eno employee.eno%type;
    emp employee%rowtype;  -- employee에 있는 모든 데이터 타입 가져오기
BEGIN
    eno := 7788;
    name2 := 'SCOTT';
    
    dbms_output.put_line('사원번호      사원이름');
    dbms_output.put_line('------------------------');
    dbms_output.put_line(eno||'         '||name2);
END;

DECLARE
    v_eno employee.eno%type;
    v_ename employee.ename%type;
BEGIN
    dbms_output.put_line('사원번호      사원이름');
    dbms_output.put_line('------------------------');
    
    SELECT eno, ename INTO v_eno, v_ename FROM employee WHERE eno=7788;
    
    dbms_output.put_line(v_eno||'         '||v_ename);
END;

-- SCOTT 사원의 연봉을 계산하세요. 급여*12에 커미션이 있다면 합산하세요.
DECLARE
    v_salary employee.salary%type;
    v_commission employee.commission%type;
    v_ann_sal number := 0;
BEGIN
    SELECT salary, commission INTO v_salary, v_commission FROM employee WHERE ename='SCOTT';
    IF v_commission is null THEN v_ann_sal := v_salary*12;
    ELSE v_ann_sal := v_salary*12+v_commission;
    END IF;
    dbms_output.put_line('SCOTT의 연봉 : '||v_ann_sal);
END;

---------------------------------------------------------------------------------
-- basic loop 구구단 5단
DECLARE
    dan number(1) := 5;
    i number := 1;
BEGIN
    dbms_output.put_line('***구구단 5단***');
    LOOP
        dbms_output.put_line(dan||' X '||i||' = '||(dan*i));
        i := i+1;
        IF i>9 THEN
            EXIT;
        END IF;
    END LOOP;
END;
-- FOR loop 구구단 3단
DECLARE
    dan number(1) := 3;
    i number := 1;
BEGIN
    dbms_output.put_line('***구구단 3단***');
    FOR i IN 1..9 LOOP
    dbms_output.put_line(dan||' X '||i||' = '||(dan*i));
    END LOOP;
END;
-- WHILE LOOP 구구단 9단
DECLARE
    dan number(1) := 9;
    i number := 1;
BEGIN
    dbms_output.put_line('***구구단 9단***');
    WHILE i < 10 LOOP
    dbms_output.put_line(dan||' X '||i||' = '||(dan*i));
    i := i + 1;
    END LOOP;
END;

---------------------------------------------------------------------------------
-- 커서
-- 사원번호, 사원이름, 급여, 부서번호
DECLARE
--    v_eno employee.eno%type;
--    v_ename employee.ename%type;
--    v_salary employee.salary%type;
--    v_dno employee.dno%type;
    v_emp employee%rowtype;
    CURSOR c_emp IS SELECT eno, ename, salary, dno FROM employee;
BEGIN
    dbms_output.put_line('사원번호  이름  급여  부서번호');
    dbms_output.put_line('------------------------------------------');
    
    OPEN c_emp;
        LOOP
--            FETCH c_emp INTO v_eno, v_ename, v_salary, v_dno;
            FETCH c_emp INTO v_emp.eno, v_emp.ename, v_emp.salary, v_emp.dno;
            IF c_emp%NOTFOUND THEN  -- 더이상 꺼낼게 없다면
                EXIT;
            END IF;
            dbms_output.put_line(v_eno||'   '||v_ename||'   '||v_salary||'   '||v_dno);
        END LOOP;
    CLOSE c_emp;
END;

-- FOR 반복을 이용한 커서 처리
DECLARE
    v_emp employee%rowtype;
    CURSOR c_emp IS SELECT * FROM employee;
BEGIN
    dbms_output.put_line('사원번호  이름  급여  부서번호');
    dbms_output.put_line('------------------------------------------');
    
    FOR v_emp IN c_emp LOOP
        dbms_output.put_line(v_emp.eno||'   '||v_emp.ename||'   '||v_emp.salary||'   '||v_emp.dno);
    END LOOP;
END;

---------------------------------------------------------------------------------
-- 프로시저
CREATE OR REPLACE PROCEDURE emp_info
IS
    v_emp employee%rowtype;
    CURSOR c_emp IS SELECT * FROM employee;
BEGIN
    dbms_output.put_line('사원번호  이름  급여  부서번호');
    dbms_output.put_line('------------------------------------------');
    
    FOR v_emp IN c_emp LOOP
        dbms_output.put_line(v_emp.eno||'   '||v_emp.ename||'   '||v_emp.salary||'   '||v_emp.dno);
    END LOOP;
END;

-- 프로시저 실행
EXECUTE emp_info;

-- 프로시저내 데이터 입출력
-- 특정 사원의 이름으로 급여 조회
CREATE OR REPLACE PROCEDURE emp_salary(v_ename IN employee.ename%type)
IS
    v_emp employee%rowtype;
BEGIN
    dbms_output.put_line('사원번호  이름  급여  부서번호');
    dbms_output.put_line('------------------------------------------');
    
    SELECT eno, ename, salary, dno INTO v_emp.eno, v_emp.ename, v_emp.salary, v_emp.dno FROM employee WHERE ename=v_ename;
    dbms_output.put_line(v_emp.eno||'   '||v_emp.ename||'   '||v_emp.salary||'   '||v_emp.dno);
END;

EXECUTE emp_salary('SCOTT');
EXECUTE emp_salary('SMITH');

-- 출력 사원 이름을 받아서 급여 정보를 출력해봅시다.
CREATE OR REPLACE PROCEDURE emp_sal_name(v_ename IN employee.ename%type, v_salary OUT employee.salary%type)
IS
BEGIN
    SELECT salary INTO v_salary FROM employee WHERE ename=v_ename;
END;

VARIABLE v_sal varchar2(20);
EXECUTE emp_sal_name('SCOTT', :v_sal);
PRINT v_sal;

---------------------------------------------------------------------------------
-- 함수 => 반환값이 하나 존재
CREATE OR REPLACE FUNCTION emp_sal_name_func(v_ename IN employee.ename%type)
    RETURN number
IS
    v_salary employee.salary%type;
BEGIN
    SELECT salary INTO v_salary FROM employee WHERE ename=v_ename;
    
    RETURN v_salary;
END;

VARIABLE v_sal2 number;
EXECUTE :v_sal2 := emp_sal_name_func('SMITH');
PRINT v_sal2;

SELECT emp_sal_name_func('SMITH') AS "급여" FROM dual;

SELECT ename, emp_sal_name_func(ename) AS "급여" FROM employee;

---------------------------------------------------------------------------------
-- 트리거 : 어떤 조건에 의해 자동으로 실행되는 프로시저이다.
-- DML(INSERT, UPDATE, DELETE)
CREATE TABLE emp_origin AS SELECT * FROM employee WHERE 0=1;
CREATE TABLE emp_copy AS SELECT * FROM employee WHERE 0=1;
SELECT * FROM emp_origin;
SELECT * FROM emp_copy;

-- origin 테이블에 데이터 삽입시 자동으로 copy 테이블에도 데이터 삽입 되도록 트리거 구성
CREATE OR REPLACE TRIGGER tri_emp_insert
    AFTER INSERT
    ON emp_origin
    for each row    -- 각 행마다 적용
BEGIN
    IF inserting THEN   -- INSERT가 동작 되었다면
        dbms_output.put_line('INSERT TRIGGER 발생');
        INSERT INTO emp_copy VALUES(:new.eno, :new.ename, :new.job, :new.manager, :new.hiredate, :new.salary, :new.commission, :new.dno);
    END IF;
END;

-- 트리거 작성 후 insert 실행
INSERT INTO emp_origin VALUES(3000,'kim','MANAGER',null,sysdate,1500,300,10);

-- update와 delete 예시
ALTER TABLE emp_copy ADD modetype NCHAR(2);

CREATE OR REPLACE TRIGGER tri_emp_sample
    AFTER UPDATE or DELETE
    ON emp_origin
    for each row
DECLARE
    v_modType NCHAR(2);
BEGIN
    IF updating THEN
        dbms_output.put_line('UPDATE TRIGGER 발생');
        v_modType := '수정';
    ELSIF deleting THEN
        dbms_output.put_line('DELETE TRIGGER 발생');
        v_modType := '삭제';
    END IF;
    INSERT INTO emp_copy VALUES(:old.eno, :old.ename, :old.job, :old.manager, :old.hiredate, :old.salary, :old.commission, :old.dno, v_modType);
END;

-- update trigger 발생
UPDATE emp_origin SET ename='HONG', job='SALESMAN', salary=2000, dno=30 WHERE eno=3000;

SELECT * FROM emp_origin;
SELECT * FROM emp_copy;

-- delete trigger 발생
DELETE FROM emp_origin WHERE eno=3000;