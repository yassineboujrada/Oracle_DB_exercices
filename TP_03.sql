-- part 1:

--1
create table dept(
    deptno NUMBER CONSTRAINT deptn_pk primary key,
    dname VARCHAR2(12) CONSTRAINT dname_check CHECK (Upper(dname) in('ACCOUNTING','RESEARCH','SALES','OPERATIONS')), 
    loc VARCHAR2(25)
);

CREATE TABLE emp(
    EMPNO NUMBER(4) CONSTRAINT EMP_PK PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2) CONSTRAINT DEPTNO_fk REFERENCES DEPT
);

insert into dept values(10,'ACCOUNTING','NEW_YORK');
insert into dept values(20,'RESEARCH','DALLAS');
insert into dept values(30,'SALES','CHICAGO');
insert into dept values(40,'OPERATIONS','BOSTON');

INSERT INTO emp VALUES(7839,'KING','PRESIDENT',null,to_date('17-11-1981','dd-mm-yyyy'),5000,null,10);
INSERT INTO emp VALUES( 7698, 'BLAKE', 'MANAGER', 7839, to_date('1-5-1981','dd-mm-yyyy'),2850, null, 30);
INSERT INTO emp VALUES( 7782, 'CLARK', 'MANAGER', 7839, to_date('9-6-1981','dd-mm-yyyy'),2450, null, 10);
INSERT INTO emp VALUES( 7566, 'JONES', 'MANAGER', 7839, to_date('2-4-1981','dd-mm-yyyy'),2975, null, 20);
INSERT INTO emp VALUES( 7788, 'SCOTT', 'ANALYST', 7566, to_date('13-JUL-87','dd-mm-rr') - 85,3000, null, 20);
INSERT INTO emp VALUES( 7902, 'FORD', 'ANALYST', 7566,to_date('3-12-1981','dd-mm-yyyy'),3000, null, 20 );
INSERT INTO emp VALUES( 7369, 'SMITH', 'CLERK', 7902,to_date('17-12-1980','dd-mm-yyyy'),800, null, 20 );
INSERT INTO emp VALUES( 7499, 'ALLEN', 'SALESMAN', 7698,to_date('20-2-1981','dd-mm-yyyy'),1600, 300, 30);
INSERT INTO emp VALUES( 7521, 'WARD', 'SALESMAN', 7698, to_date('22-2-1981','dd-mm-yyyy'),1250, 500, 30 );
INSERT INTO emp VALUES( 7654, 'MARTIN', 'SALESMAN', 769,to_date('28-9-1981','dd-mm-yyyy'),1250, 1400, 30 );
INSERT INTO emp VALUES( 7844, 'TURNER', 'SALESMAN', 769,to_date('8-9-1981','dd-mm-yyyy'),1500, 0, 30);
INSERT INTO emp VALUES( 7876, 'ADAMS', 'CLERK', 7788,to_date('13-JUL-87', 'dd-mm-rr') - 51, 1100, null, 20 );
INSERT INTO emp VALUES( 7900, 'JAMES', 'CLERK', 7698,to_date('3-12-1981','dd-mm-yyyy'),950, null, 30 );
INSERT INTO emp VALUES( 7934, 'MILLER', 'CLERK', 7782,to_date('23-1-1982','dd-mm-yyyy'),1300, null, 10 );
COMMIT;
select * from emp;