--3
create table EMP as select * from SCOTT.emp;

--4
SAVEPOINT A;
commit ;
INSERT INTO EMP VALUES(7369,'Bidon',NULL,NULL,NULL,NULL,NULL,NULL);

--5
ROLLBACK A;

--6 
create table dept(
    deptno NUMBER CONSTRAINT deptn_pk primary key,
    dname VARCHAR2(12) CONSTRAINT dname_check CHECK (Upper(dname) in('ACCOUNTING','RESEARCH','SALES','OPERATIONS')), 
    loc VARCHAR2(25)
);

insert into dept values(10,'ACCOUNTING','NEW_YORK');
insert into dept values(20,'RESEARCH','DALLAS');
insert into dept values(30,'SALES','CHICAGO');
insert into dept values(40,'OPERATIONS','BOSTON');


alter table EMP Add CONSTRAINT emp_pk_sys primary key(EMPNO);
alter table EMP Add CONSTRAINT emp_fk_sys foreign key(deptno) references dept(deptno) on delete cascade;
--7
SAVEPOINT b;
commit;
INSERT INTO EMP VALUES(7369,'WILSON','MANAGER',7839,to_date('17-11-1991','dd-mm-yyyy'),3500,600,10);
INSERT INTO EMP VALUES(7657,'WILSON','MANAGER',7839,to_date('17-11-1991','dd-mm-yyyy'),3500,600,50);
INSERT INTO EMP VALUES(7657,'WILSON','MANAGER',7000,to_date('17-11-1991','dd-mm-yyyy'),3500,600,10);
INSERT INTO EMP VALUES(7657,'WILSON','MANAGER',7839,to_date('17-11-1991','dd-mm-yyyy'),3500,600,10);

--8
commit ;

--  partie B:
--1
UPDATE dept set loc='PITSBURGH' where UPPER(loc)='CHICAGO';

savepoint C;
commit ;

update emp set sal=sal*1.1 where (comm>sal/2 and job like 'SALES%');

update emp set comm=(select AVG(comm) from emp)where (comm is not null and hiredate<to_date('01/01/82','dd-mm-yyyy'));

rollback C;



select * from user_cons_columns where  table_name = 'EMP';
alter table emp drop constraint EMP_FK_SYS;
delete dept where deptno=20;

