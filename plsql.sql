-- PL/SQL
SET serveroutput ON;

BEGIN
    dbms_output.put_line('Hello WORLD!!');     -- �⺻ ��¹�
END;

-- ���� Ÿ��
DECLARE
    -- (Java) Ÿ�� �̸� = ������;
    -- (PL/sql) �̸� Ÿ�� := ������;
    -- Ÿ�� -2����
    -- 1) ��Į��   : ������ SQL���� ����ϴ� ������ Ÿ��, number, varchar2, ...
    -- 2) ���۷��� : �̹� ���̺��� �÷����� ����ϴ� Ÿ��, (A���̺��� b�÷��� Ÿ���� ���)
    --name1 varchar2(10);  -- ��Į�� Ÿ���� ������ ����
    name2 employee.ename%type;  -- ���۷��� Ÿ���� ������ ����
    eno employee.eno%type;
    emp employee%rowtype;  -- employee�� �ִ� ��� ������ Ÿ�� ��������
BEGIN
    eno := 7788;
    name2 := 'SCOTT';
    
    dbms_output.put_line('�����ȣ      ����̸�');
    dbms_output.put_line('------------------------');
    dbms_output.put_line(eno||'         '||name2);
END;

DECLARE
    v_eno employee.eno%type;
    v_ename employee.ename%type;
BEGIN
    dbms_output.put_line('�����ȣ      ����̸�');
    dbms_output.put_line('------------------------');
    
    SELECT eno, ename INTO v_eno, v_ename FROM employee WHERE eno=7788;
    
    dbms_output.put_line(v_eno||'         '||v_ename);
END;

-- SCOTT ����� ������ ����ϼ���. �޿�*12�� Ŀ�̼��� �ִٸ� �ջ��ϼ���.
DECLARE
    v_salary employee.salary%type;
    v_commission employee.commission%type;
    v_ann_sal number := 0;
BEGIN
    SELECT salary, commission INTO v_salary, v_commission FROM employee WHERE ename='SCOTT';
    IF v_commission is null THEN v_ann_sal := v_salary*12;
    ELSE v_ann_sal := v_salary*12+v_commission;
    END IF;
    dbms_output.put_line('SCOTT�� ���� : '||v_ann_sal);
END;

---------------------------------------------------------------------------------
-- basic loop ������ 5��
DECLARE
    dan number(1) := 5;
    i number := 1;
BEGIN
    dbms_output.put_line('***������ 5��***');
    LOOP
        dbms_output.put_line(dan||' X '||i||' = '||(dan*i));
        i := i+1;
        IF i>9 THEN
            EXIT;
        END IF;
    END LOOP;
END;
-- FOR loop ������ 3��
DECLARE
    dan number(1) := 3;
    i number := 1;
BEGIN
    dbms_output.put_line('***������ 3��***');
    FOR i IN 1..9 LOOP
    dbms_output.put_line(dan||' X '||i||' = '||(dan*i));
    END LOOP;
END;
-- WHILE LOOP ������ 9��
DECLARE
    dan number(1) := 9;
    i number := 1;
BEGIN
    dbms_output.put_line('***������ 9��***');
    WHILE i < 10 LOOP
    dbms_output.put_line(dan||' X '||i||' = '||(dan*i));
    i := i + 1;
    END LOOP;
END;

---------------------------------------------------------------------------------
-- Ŀ��
-- �����ȣ, ����̸�, �޿�, �μ���ȣ
DECLARE
--    v_eno employee.eno%type;
--    v_ename employee.ename%type;
--    v_salary employee.salary%type;
--    v_dno employee.dno%type;
    v_emp employee%rowtype;
    CURSOR c_emp IS SELECT eno, ename, salary, dno FROM employee;
BEGIN
    dbms_output.put_line('�����ȣ  �̸�  �޿�  �μ���ȣ');
    dbms_output.put_line('------------------------------------------');
    
    OPEN c_emp;
        LOOP
--            FETCH c_emp INTO v_eno, v_ename, v_salary, v_dno;
            FETCH c_emp INTO v_emp.eno, v_emp.ename, v_emp.salary, v_emp.dno;
            IF c_emp%NOTFOUND THEN  -- ���̻� ������ ���ٸ�
                EXIT;
            END IF;
            dbms_output.put_line(v_eno||'   '||v_ename||'   '||v_salary||'   '||v_dno);
        END LOOP;
    CLOSE c_emp;
END;

-- FOR �ݺ��� �̿��� Ŀ�� ó��
DECLARE
    v_emp employee%rowtype;
    CURSOR c_emp IS SELECT * FROM employee;
BEGIN
    dbms_output.put_line('�����ȣ  �̸�  �޿�  �μ���ȣ');
    dbms_output.put_line('------------------------------------------');
    
    FOR v_emp IN c_emp LOOP
        dbms_output.put_line(v_emp.eno||'   '||v_emp.ename||'   '||v_emp.salary||'   '||v_emp.dno);
    END LOOP;
END;

---------------------------------------------------------------------------------
-- ���ν���
CREATE OR REPLACE PROCEDURE emp_info
IS
    v_emp employee%rowtype;
    CURSOR c_emp IS SELECT * FROM employee;
BEGIN
    dbms_output.put_line('�����ȣ  �̸�  �޿�  �μ���ȣ');
    dbms_output.put_line('------------------------------------------');
    
    FOR v_emp IN c_emp LOOP
        dbms_output.put_line(v_emp.eno||'   '||v_emp.ename||'   '||v_emp.salary||'   '||v_emp.dno);
    END LOOP;
END;

-- ���ν��� ����
EXECUTE emp_info;

-- ���ν����� ������ �����
-- Ư�� ����� �̸����� �޿� ��ȸ
CREATE OR REPLACE PROCEDURE emp_salary(v_ename IN employee.ename%type)
IS
    v_emp employee%rowtype;
BEGIN
    dbms_output.put_line('�����ȣ  �̸�  �޿�  �μ���ȣ');
    dbms_output.put_line('------------------------------------------');
    
    SELECT eno, ename, salary, dno INTO v_emp.eno, v_emp.ename, v_emp.salary, v_emp.dno FROM employee WHERE ename=v_ename;
    dbms_output.put_line(v_emp.eno||'   '||v_emp.ename||'   '||v_emp.salary||'   '||v_emp.dno);
END;

EXECUTE emp_salary('SCOTT');
EXECUTE emp_salary('SMITH');

-- ��� ��� �̸��� �޾Ƽ� �޿� ������ ����غ��ô�.
CREATE OR REPLACE PROCEDURE emp_sal_name(v_ename IN employee.ename%type, v_salary OUT employee.salary%type)
IS
BEGIN
    SELECT salary INTO v_salary FROM employee WHERE ename=v_ename;
END;

VARIABLE v_sal varchar2(20);
EXECUTE emp_sal_name('SCOTT', :v_sal);
PRINT v_sal;

---------------------------------------------------------------------------------
-- �Լ� => ��ȯ���� �ϳ� ����
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

SELECT emp_sal_name_func('SMITH') AS "�޿�" FROM dual;

SELECT ename, emp_sal_name_func(ename) AS "�޿�" FROM employee;

---------------------------------------------------------------------------------
-- Ʈ���� : � ���ǿ� ���� �ڵ����� ����Ǵ� ���ν����̴�.
-- DML(INSERT, UPDATE, DELETE)
CREATE TABLE emp_origin AS SELECT * FROM employee WHERE 0=1;
CREATE TABLE emp_copy AS SELECT * FROM employee WHERE 0=1;
SELECT * FROM emp_origin;
SELECT * FROM emp_copy;

-- origin ���̺� ������ ���Խ� �ڵ����� copy ���̺��� ������ ���� �ǵ��� Ʈ���� ����
CREATE OR REPLACE TRIGGER tri_emp_insert
    AFTER INSERT
    ON emp_origin
    for each row    -- �� �ึ�� ����
BEGIN
    IF inserting THEN   -- INSERT�� ���� �Ǿ��ٸ�
        dbms_output.put_line('INSERT TRIGGER �߻�');
        INSERT INTO emp_copy VALUES(:new.eno, :new.ename, :new.job, :new.manager, :new.hiredate, :new.salary, :new.commission, :new.dno);
    END IF;
END;

-- Ʈ���� �ۼ� �� insert ����
INSERT INTO emp_origin VALUES(3000,'kim','MANAGER',null,sysdate,1500,300,10);

-- update�� delete ����
ALTER TABLE emp_copy ADD modetype NCHAR(2);

CREATE OR REPLACE TRIGGER tri_emp_sample
    AFTER UPDATE or DELETE
    ON emp_origin
    for each row
DECLARE
    v_modType NCHAR(2);
BEGIN
    IF updating THEN
        dbms_output.put_line('UPDATE TRIGGER �߻�');
        v_modType := '����';
    ELSIF deleting THEN
        dbms_output.put_line('DELETE TRIGGER �߻�');
        v_modType := '����';
    END IF;
    INSERT INTO emp_copy VALUES(:old.eno, :old.ename, :old.job, :old.manager, :old.hiredate, :old.salary, :old.commission, :old.dno, v_modType);
END;

-- update trigger �߻�
UPDATE emp_origin SET ename='HONG', job='SALESMAN', salary=2000, dno=30 WHERE eno=3000;

SELECT * FROM emp_origin;
SELECT * FROM emp_copy;

-- delete trigger �߻�
DELETE FROM emp_origin WHERE eno=3000;