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
-- DML 데어터 조작어 => 실질적으로 튜플의 내용을 변경 => 트랜잭션의 적용
SELECT * FROM employee;

--INSERT 데이터 삽입
INSERT INTO employee(eno, ename, job, manager, hiredate, salary, commission, dno)
                VALUES(8121, 'ALICE', 'CLERK', 7788, sysdate, 1200, 100, 10);
-- 전체 입력시 컬럼을 생략할 수 있다. but value 입력 순서는 그대로
INSERT INTO employee VALUES(8231, 'KATHERINE', 'SALESMAN', 7698, sysdate, 1750, 800, 30);

-- 트랜잭션 정상적 종료
COMMIT;

SELECT * FROM employee;

INSERT INTO employee(eno) VALUES (8500);
INSERT INTO employee(eno, ename) VALUES (8600, NULL);

-- 데이터 복사해서 테이블 만들기 - 실제로 사용할 일이 없다.
CREATE TABLE emp2 AS SELECT * FROM employee;

SELECT * FROM emp2;

-- 0=1 값이 false이기 때문에 조회 되는 데이터가 없다.
CREATE TABLE emp3 AS SELECT * FROM employee WHERE 0=1;
-- 컬럼만 복사되는 것을 볼 수 있다.
SELECT * FROM emp3;
-- 컬럼만 있는 빈 테이블에 employee 테이블 복사
INSERT INTO emp3 SELECT * FROM employee;
-- 특정 컬럼만 입력
INSERT INTO emp3 (eno, ename, job) SELECT eno, ename, job FROM employee;

---------------------------------------------------------------------------------
-- UPDATE 데이터 수정
-- UPDATE 테이블명 SET WHERE
CREATE TABLE emp4 AS SELECT * FROM employee;

SELECT * FROM emp4;

-- eno8500의 사원 이름을 MARS로 바꾸고, 담당업무를 manager로 변경
UPDATE emp4 SET ename = 'MARS', job = 'MANAGER' WHERE eno = 8500;

-- 조건을 안적으면 모든 사람이 바뀐다.
UPDATE emp4 SET commission = 500;

UPDATE emp4 SET salary = (SELECT losal FROM salgrade WHERE grade = 1) WHERE dno IS NULL;

---------------------------------------------------------------------------------
-- DELETE 데이터 삭제
-- DELETE FROM 테이블명 WHERE 조건

CREATE TABLE emp5 AS SELECT * FROM employee;
-- 이름이 alice인 사원 삭제
DELETE FROM emp5 WHERE ename = 'ALICE';
-- 전체 데이터 삭제 / 조건이 없으면 전체 삭제이기 때문에 매우 위험
DELETE FROM emp5;
-- DELETE는 조건이 필수라고 생각하면 된다.
-- 데이터 다시 입력
INSERT INTO emp5 SELECT * FROM employee;

-- 부서명이 RESEARCH소속의 사원을 전원 삭제하세요
DELETE FROM emp5 WHERE dno = (SELECT dno FROM department WHERE dname = 'RESEARCH');
SELECT * FROM emp5;

---------------------------------------------------------------------------------
-- 트랜잭션 -> commit, rollback
CREATE TABLE emp6 AS SELECT * FROM employee;
-- null값을 지워야 하는데 잘못 지울경우 ROLLBACK으로 복구하기
DELETE FROM emp6 WHERE dno IS NOT NULL;
-- commit 하기전엔 rollback으로 복구 가능
ROLLBACK;

DELETE FROM emp6 WHERE dno IS NULL;
-- commit 후엔 데이터를 복구하기 매우 힘들다.
COMMIT;

SELECT * FROM emp6;

---------------------------------------------------------------------------------
-- 데이터 제어
-- TABLE 생성
CREATE TABLE dept2(dno NUMBER(2), dname VARCHAR2(14), loc VARCHAR2(13));

SELECT * FROM dept2;
-- Oracle에서 테이블 정보 보기
DESC dept2;

-- 컬럼이 수식으로 들어갈땐 반드시 별칭을 지어준다.
CREATE TABLE dept3 AS SELECT eno, ename, salary*12 AS "ANI_SAL" FROM employee WHERE dno = 20;
SELECT * FROM dept3;

-- ALTER - 컬럼 생성
ALTER TABLE dept3 ADD (birth date);
ALTER TABLE dept3 ADD (addr VARCHAR2(100), phone VARCHAR2(13));

DESC dept3;

-- ALTER - 컬럼 변경
ALTER TABLE dept3 MODIFY addr VARCHAR2(500);
-- 컬럼 이름 변경
ALTER TABLE dept3 RENAME COLUMN addr TO address;

-- 테이블 이름 바꾸기
RENAME dept3 TO dept30;
DESC dept30;

-- 컬럼삭제
ALTER TABLE dept30 DROP COLUMN phone;
-- 칼럼 숨기기
ALTER TABLE dept30 SET UNUSED (address);
-- 숨긴 칼럼들 삭제
ALTER TABLE dept30 DROP UNUSED COLUMNS;
-- 테이블 삭제
DROP TABLE dept30;

-- 테이블 복사해오기
CREATE TABLE dept3 AS SELECT * FROM employee;
-- 복사해온 테이블의 모든 레코드 삭제
TRUNCATE TABLE dept3;

---------------------------------------------------------------------------------
-- 제약조건
-- not null
CREATE TABLE customer(id varchar2(20) NOT NULL, pwd varchar2(20) NOT NULL, name varchar2(20) NOT NULL);

DESC customer;
-- NULL값이 있으므로 에러
-- INSERT INTO customer VALUES('asdf', '1234', NULL);
-- unique 주로 id같은데 사용 중복x
CREATE TABLE customer(id varchar2(20) UNIQUE, pwd varchar(20) NOT NULL, name varchar2(20) NOT NULL);

DESC customer;
-- 데이터 입력
INSERT INTO customer VALUES('asdf', '1234', 'kin');
-- UNIQUE로 설정해준 ID가 겹쳐서 오류
INSERT INTO customer VALUES('asdf', '5678', 'park');

DROP TABLE customer;
-- UNIQUE와 NOT NULL 동시에 = PRIMARY KEY (기본키) - 테이블에 한개만 존재해야한다. 모든 테이블에 반드시 존재해야 한다.
--CREATE TABLE customer(id varchar2(20) UNIQUE NOT NULL, pwd varchar(20) NOT NULL, name varchar2(20) NOT NULL);
CREATE TABLE customer(id varchar2(20) CONSTRAINT customer_id_pk PRIMARY KEY, pwd varchar(20) NOT NULL, name varchar2(20) NOT NULL);
-- 데이터 입력
INSERT INTO customer VALUES('asdf', '1234', 'hong');
INSERT INTO customer VALUES('asdf', '5678', 'kim');     -- 기본키인 아이디가 겹쳐서 오류
INSERT INTO customer VALUES(null, '9876', 'Lee');       -- 기본키인 아이디에 null 이 들어가서 오류

DROP TABLE customer;
-- CHECK
-- 제약조건 이름을 마지막에 써줄수도 있다. 대신 제약조건 뒤에 (컬럼명)을 입력해주어야 한다.
CREATE TABLE customer(id varchar2(20), pwd varchar(20) NOT NULL, name varchar2(20) NOT NULL,
                    jumsu number(3) CHECK(0<=jumsu AND jumsu<=100), CONSTRAINT customer_id_pk PRIMARY KEY(id));

-- 데이터 입력
INSERT INTO customer VALUES('asdf', '1234', 'kim', 65);
INSERT INTO customer VALUES('qwer', '1234', 'park', 123); -- jumsu 컬럼 부분이 check조건 범위를 벗어나서 오류

DROP TABLE customer;

-- DEFAULT
CREATE TABLE customer(id varchar2(20), pwd varchar(20) NOT NULL, name varchar2(20) DEFAULT '홍길동',
                    CONSTRAINT customer_id_pk PRIMARY KEY(id));

INSERT INTO customer VALUES('asdf', '1234', 'park');
INSERT INTO customer VALUES('qwer', '1234', null);
INSERT INTO customer(id, pwd) VALUES('zxcv', '1234');

SELECT * FROM customer;
                    
-- FOREIGN KEY
CREATE TABLE student(stuno varchar2(20) CONSTRAINT student_sno_pk PRIMARY KEY,
            name varchar2(20) CONSTRAINT student_name_nn NOT NULL,
            majar varchar2(20));

CREATE TABLE reqistration(enrollid varchar2(20) CONSTRAINT registration_id_pk PRIMARY KEY,
            stuno varchar2(20), 
            subject varchar2(20) CONSTRAINT registration_subject_nn NOT NULL,
            CONSTRAINT registration_stuno_fk FOREIGN KEY(stuno) REFERENCES student(stuno));
            
INSERT INTO student VALUES('s001', 'kim', 'math');
INSERT INTO student VALUES('s002', 'smith', 'english');
INSERT INTO student VALUES('s003', 'lee', 'korean');

SELECT * FROM student;

INSERT INTO reqistration VALUES('E001','s001','대수학');
INSERT INTO reqistration VALUES('E002','s004','미분기하학'); -- 외래키의 부모테이블에 s004라는 데이터가 없기때문에 오류

SELECT * FROM reqistration;

---------------------------------------------------------------------------------
-- 제약조건 변경
CREATE TABLE stu_copy AS SELECT * FROM student;

CREATE TABLE reg_copy AS SELECT * FROM reqistration;
-- 추가
ALTER TABLE reg_copy
ADD CONSTRAINT reg_copy_stuno_fk FOREIGN KEY(stuno) REFERENCES student(stuno);
-- 추가2
ALTER TABLE stu_copy
ADD CONSTRAINT stu_copy_stuno_pk PRIMARY KEY(stuno);
-- 추가3
ALTER TABLE reg_copy
ADD CONSTRAINT reg_copy_enrollid_pk PRIMARY KEY(enrollid);
-- 변경
ALTER TABLE stu_copy
MODIFY majar CONSTRAINT stu_copy_major_nn NOT NULL; -- 오타 major로 추가했어야 했다
-- 제거
ALTER TABLE stu_copy
DROP PRIMARY KEY;   -- PRIMARY KEY 는 하나밖에 없기때문에 이름을 지정해주지 않아도 괜찮다.
-- 제거2 제약조건 이름을 통해 삭제
ALTER TABLE stu_copy
DROP CONSTRAINT stu_copy_major_nn;

---------------------------------------------------------------------------------
-- 시퀀스
CREATE SEQUENCE seq_sample START WITH 10 INCREMENT BY 10;   -- 10부터 시작하고 10씩 증가

SELECT sequence_name, min_value, max_value, increment_by, cycle_flag FROM user_sequences;
-- 시퀀스의 현재값 알아보기
SELECT seq_sample.currval FROM dual;    -- 한번도 작동된 적이 없기때문에 에러가 난다.
-- 시퀀스의 다음값 알아보기 - 가장 많이 사용한다.
SELECT seq_sample.nextval FROM dual;

CREATE TABLE member(m_info number PRIMARY KEY, m_id varchar2(20) NOT NULL, m_pwd varchar2(100) NOT NULL);
-- 시퀀스 기본값 생성
CREATE SEQUENCE member_seq;
-- 시퀀스 적용
INSERT INTO member VALUES(member_seq.nextval,'asdf','1234');

SELECT * FROM member;
-- 시퀀스 변경
ALTER SEQUENCE member_seq CYCLE;

SELECT * FROM user_sequences;

-- CREATE SEQUENCE 테이블명_seq NOCACHE;  --기본적인 생성

---------------------------------------------------------------------------------
-- 인덱스
-- 이미 생성된 인덱스 정보
SELECT index_name, table_name, column_name FROM user_ind_columns WHERE table_name IN ('EMPLOYEE', 'DEPARTMENT');
-- 인덱스 생성
CREATE INDEX idx_employee_ename ON employee(ename);
-- 인덱스 삭제
DROP INDEX idx_employee_ename;

SELECT * FROM employee;