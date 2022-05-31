-- �������� 12. plsql
SET serveroutput ON;
--1. IF��������Ͽ�KING����Ǻμ���ȣ�����ͼ��μ���ȣ�����ͼ��μ���ȣ�������μ���������ϼ���.
DECLARE
    ex_dno employee.dno%type;
    ex_dname department.dname%type; 
BEGIN
    SELECT dno INTO ex_dno FROM employee WHERE ename='KING';
    IF ex_dno is not null THEN
        SELECT dname INTO ex_dname FROM department WHERE dno=ex_dno;
    END IF;
    dbms_output.put_line('�μ���ȣ : '||ex_dno||' �μ��� : '||ex_dname);
END;

--2. BASICLOOP������1����10�������ڿ������������Ͽ�����ϼ���.
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
    dbms_output.put_line('1~10 ������ �� : '||isum);
END;

--3. FORLOOP������1����10�������ڿ������������Ͽ�����ϼ���.
DECLARE
    isum number := 0;
    i number := 1;
BEGIN
    FOR i IN 1..10 LOOP
        isum := isum + i;
    END LOOP;
    dbms_output.put_line('1~10 ������ �� : '||isum);
END;

--4. WHILELOOP������1����10�������ڿ������������Ͽ�����ϼ���.
DECLARE
    isum number := 0;
    i number := 1;
BEGIN
    WHILE i < 11 LOOP
        isum := isum + i;
        i := i + 1;
    END LOOP;
    dbms_output.put_line('1~10 ������ �� : '||isum);
END;

--5. ������̺���Ŀ�̼���NULL�ƴѻ����ǻ����ȣ, �̸�, �޿����̸��������ο����������������Ѱ��������ϼ���.
DECLARE
    e_emp employee%rowtype;
    CURSOR ex_emp IS SELECT eno, ename, salary FROM employee WHERE commission is not null ORDER BY ename ASC;
BEGIN
    dbms_output.put_line('�����ȣ  �̸�  �޿�');
    dbms_output.put_line('------------------------');
    
    OPEN ex_emp;
        LOOP
            FETCH ex_emp INTO e_emp.eno, e_emp.ename, e_emp.salary;
            IF ex_emp%NOTFOUND THEN  -- ���̻� ������ ���ٸ�
                EXIT;
            END IF;
            dbms_output.put_line(e_emp.eno||'   '||e_emp.ename||'   '||e_emp.salary);
        END LOOP;
    CLOSE ex_emp;
END;

--6. �������������̺�(Student)����������͸��Է��Ѵ�.
CREATE TABLE student(
                sid number PRIMARY KEY,
                sname nvarchar2(5) not null,
                kscore number(3) check(0 <= kscore and kscore <= 100),
                escore number(3) check(0 <= escore and escore <= 100),
                mscore number(3) check(0 <= mscore and mscore <= 100));
CREATE SEQUENCE seq_stu_id;
INSERT INTO student VALUES(seq_stu_id.nextval, '��浿', 78, 64, 82);
INSERT INTO student VALUES(seq_stu_id.nextval, '��浿', 85, 71, 64);
INSERT INTO student VALUES(seq_stu_id.nextval, '�̱浿', 74, 69, 57);
INSERT INTO student VALUES(seq_stu_id.nextval, '�ڱ浿', 74, 77, 95);
INSERT INTO student VALUES(seq_stu_id.nextval, 'ȫ�浿', 68, 95, 84);

SELECT * FROM student;

-- �л�����������������ϼ���.
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
            dbms_output.put_line(stu.sname||'�� ���� : '||stu_sum||' ��� : '||stu_avg);
        END LOOP;
    CLOSE c_stu;
END;

-- ������������������ϼ���.
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
--        dbms_output.put_line('���� ������ ���� : '||k_sum||' ��� : '||k_avg);
--        dbms_output.put_line('���� ������ ���� : '||e_sum||' ��� : '||e_avg);
--        dbms_output.put_line('���� ������ ���� : '||m_sum||' ��� : '||m_avg);
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
    dbms_output.put_line('���� ������ ���� : '||k_sum||' ��� : '||k_avg);
    dbms_output.put_line('���� ������ ���� : '||e_sum||' ��� : '||e_avg);
    dbms_output.put_line('���� ������ ���� : '||m_sum||' ��� : '||m_avg);
END;
---------------------------------------------------------------------------------
-- �������� 13. ���ν���
--1. ������̺���Ŀ�̼���NULL�̾ƴѻ����ǻ����ȣ���̸�, �޿����������ο������������Ѱ������Ÿ�����������ν����������ϼ���.
CREATE OR REPLACE PROCEDURE pro_emp
IS
    ex_emp employee%rowtype;
    CURSOR c_emp IS SELECT eno, ename, salary FROM employee WHERE commission is not null ORDER BY salary ASC;
BEGIN
    dbms_output.put_line('�����ȣ  �̸�  �޿�');
    dbms_output.put_line('-------------------------');
    FOR ex_emp IN c_emp LOOP
        dbms_output.put_line(ex_emp.eno||'   '||ex_emp.ename||'   '||ex_emp.salary);
    END LOOP;
END;

EXECUTE pro_emp;

--2. �������ν����������Ͽ�Ŀ�̼��÷����ϳ�������ϰ��̸������طγ����������������ϼ���.
CREATE OR REPLACE PROCEDURE pro_emp
IS
    ex_emp employee%rowtype;
    CURSOR c_emp IS SELECT eno, ename, salary, commission FROM employee WHERE commission is not null ORDER BY ename DESC;
BEGIN
    dbms_output.put_line('�����ȣ  �̸�  �޿�  Ŀ�̼�');
    dbms_output.put_line('--------------------------------');
    FOR ex_emp IN c_emp LOOP
        dbms_output.put_line(ex_emp.eno||'   '||ex_emp.ename||'   '||ex_emp.salary||'   '||ex_emp.commission);
    END LOOP;
END;

--3. �������������ν����������ϼ���.
DROP PROCEDURE pro_emp;
