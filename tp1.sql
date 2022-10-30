-- 1 : table countries

create table countries(
    country_id char(2) not null, --pk
    country_name varchar2(40),
    region_id NUMBER --fk
);

desc countries;

-- 2 : table departement

create table departement(
    departement_id number(4) not null,  --pk
    departement_name varchar2(30) not null,
    manager_id NUMBER(6),
    location_id number(4)  --fk
);

desc departement;

-- 3 : table employees

create table employees(
    employee_id number(6) not null, --pk
    first_name varchar2(20),
    last_name varchar2(25) not null,
    email varchar2(25) not null,
    phone_number varchar2(20),
    hire_date date not null,
    job_id varchar2(10) not null, --fk
    salary NUMBER(8,2),
    commission_pct NUMBER(2,2),
    manager_id NUMBER(6),
    departement_id number(4)  --fk
);

desc employees;

-- 4 : table jobs

create table jobs(
    job_id varchar2(10) not null, --pk
    job_title varchar2(35) not null,
    min_salary NUMBER(6),
    max_salary number(6)
);

desc jobs;

-- 5 : table job_grades

create table job_grades(
    grade_level varchar2(3), --pk
    lowest_sal NUMBER ,
    highest_sal NUMBER
);

desc job_grades;

-- 6 : table job_history

create table job_history(
    employee_id number(6) not null,  --pkf
    start_date Date not null,
    end_date Date not null,
    job_id varchar2(10) not null, --pkf
    departement_id number(4) --pkf
);

desc job_history;

-- 7 : table location

create table location(
    location_id number(4) not null, --pk
    street_address varchar2(40),
    postal_code varchar2(12),
    city varchar2(30) not null,
    state_province varchar2(25),
    country_id char(2) --fk
);

desc location;

-- 8 : table region

create table region(
    region_id number not null, --pk
    region_name varchar2(25)
);

desc region;


/*   primary keys  */

ALTER TABLE countries add constraint count_prim primary key(country_id);
ALTER TABLE departement add constraint depa_prim primary key(departement_id);
ALTER TABLE employees add constraint emp_prim primary key(employee_id);
ALTER TABLE jobs add constraint job_prim primary key(job_id);
ALTER TABLE job_grades add constraint grade_job_prim primary key(grade_level);
ALTER TABLE job_history add constraint history_job_prim primary key(employee_id,job_id,departement_id);
ALTER TABLE location add constraint location_prim primary key(location_id);
ALTER TABLE region add constraint region_prim primary key(region_id);

savepoint  a;
commit ;

/*    REFERENCE KEY   */

alter table countries add constraint count_ref FOREIGN key(region_id) references region(region_id);
alter table departement add constraint depa_ref FOREIGN key(location_id) references location(location_id);
alter table departement add constraint depa2_ref FOREIGN key(manager_id) references employees(employee_id);
alter table employees add constraint emp1_ref foreign key(job_id) references jobs(job_id);
alter table employees add constraint emp2_ref foreign key(departement_id) references departement(departement_id);
alter table job_history add constraint jobh1_ref foreign key(employee_id) references employees(employee_id);
alter table job_history add constraint jobh2_ref foreign key(job_id) references jobs(job_id);
alter table job_history add constraint jobh3_ref foreign key(departement_id) references departement(departement_id);
alter table location add constraint loc_ref foreign key(country_id) references countries(country_id);

savepoint  b;
commit ;

/*  other constraint   */

alter table employees add constraint sala_ch check(salary>0);
alter table employees add constraint emp_unique unique(email);
alter table jobs add constraint job_ch check(max_salary>min_salary);
alter table job_grades add constraint job_grad_ch check(highest_sal>lowest_sal);

savepoint c;
commit ;

/*  insert les elements  */
INSERT INTO region VALUES ( 1, 'Europe');
INSERT INTO region VALUES ( 2, 'Americas' );
INSERT INTO region VALUES ( 3, 'Asia');
INSERT INTO region VALUES ( 4, 'Middle East and Africa' );
select * from region;

INSERT INTO countries VALUES ( 'CA', 'Canada', 2 );
INSERT INTO countries VALUES ( 'DE', 'Germany', 1 );
INSERT INTO countries VALUES ( 'UK', 'United Kingdom', 1);
INSERT INTO countries VALUES ( 'US', 'United States of America', 2);
select * from countries;

INSERT INTO location VALUES ( 1400 , '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
INSERT INTO location VALUES ( 1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');
INSERT INTO location VALUES ( 1700 , '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');
INSERT INTO location VALUES( 1800 , '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');
INSERT INTO location VALUES ( 2500 , 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK');
select * from location;

ALTER TABLE departement DISABLE CONSTRAINT depa2_ref;
INSERT INTO departement VALUES ( 10, 'Administration', 200, 1700);
INSERT INTO departement VALUES ( 20, 'Marketing', 201, 1800);
INSERT INTO departement VALUES ( 50, 'Shipping', 121, 1500);
INSERT INTO departement VALUES ( 60 , 'IT', 103, 1400);
INSERT INTO departement VALUES ( 80 , 'Sales', 145, 2500);
INSERT INTO departement VALUES ( 90 , 'Executive', 100, 1700);
INSERT INTO departement VALUES ( 110 , 'Accounting', 205, 1700);
INSERT INTO departement VALUES ( 190 , 'Contracting', NULL, 1700);
select * from departement;

INSERT INTO jobs VALUES ( 'AD_PRES', 'President', 20000, 40000);
INSERT INTO jobs VALUES ( 'AD_VP', 'Administration Vice President', 15000, 30000);
INSERT INTO jobs VALUES ( 'AD_ASST', 'Administration Assistant', 3000, 6000);
INSERT INTO jobs VALUES ( 'AC_MGR', 'Accounting Manager', 8200, 16000);
INSERT INTO jobs VALUES ( 'AC_ACCOUNT', 'Public Accountant', 4200, 9000);
INSERT INTO jobs VALUES ( 'SA_MAN', 'Sales Manager', 10000, 20000);
INSERT INTO jobs VALUES ( 'SA_REP', 'Sales Representative', 6000, 12000);
INSERT INTO jobs VALUES ( 'ST_MAN', 'Stock Manager', 5500, 8500);
INSERT INTO jobs VALUES ( 'ST_CLERK', 'Stock Clerk', 2000, 5000);
INSERT INTO jobs VALUES  ( 'IT_PROG' , 'Programmer' , 4000 , 10000);
INSERT INTO jobs VALUES ( 'MK_MAN', 'Marketing Manager', 9000, 15000);
INSERT INTO jobs VALUES ( 'MK_REP', 'Marketing Representative', 4000, 9000);
select * from jobs;

INSERT INTO employees VALUES    ( 100   , 'Steven'   , 'King'   , 'SKING'   , '515.123.4567'   ,to_date('17-7-1987','DD-MM-YYYY') , 'AD_PRES'   , 24000   , NULL   , NULL   , 90   );
INSERT INTO employees VALUES    ( 101   , 'Neena'   , 'Kochhar'   , 'NKOCHHAR'   , '515.123.4568'   ,to_date('21-9-1989','DD-MM-YYYY') , 'AD_VP'   , 17000   , NULL   , 100   , 90   );
INSERT INTO employees VALUES    ( 102   , 'Lex'   , 'De Haan'   , 'LDEHAAN'   , '515.123.4569'   , to_date('13-1-1993','DD-MM-YYYY') , 'AD_VP'   , 17000   , NULL   , 100   , 90   );
INSERT INTO employees VALUES    ( 103   , 'Alexander'   , 'Hunold'   , 'AHUNOLD'   , '590.423.4567'   , to_date('03-1-1990','DD-MM-YYYY') , 'IT_PROG'   , 9000   , NULL   , 102   , 60   );
INSERT INTO employees VALUES    ( 104   , 'Bruce'   , 'Ernst'   , 'BERNST'   , '590.423.4568'   , to_date('21-5-1991','DD-MM-YYYY')   , 'IT_PROG'   , 6000   , NULL   , 103   , 60   );
INSERT INTO employees VALUES    ( 107   , 'Diana'   , 'Lorentz'   , 'DLORENTZ'   , '590.423.5567'   , to_date('07-2-1999','DD-MM-YYYY')    , 'IT_PROG'   , 4200   , NULL   , 103   , 60   );
INSERT INTO employees VALUES    ( 124   , 'Kevin'   , 'Mourgos'   , 'KMOURGOS'   , '650.123.5234'   , to_date('16-11-1999','DD-MM-YYYY')   , 'ST_MAN'   , 5800   , NULL   , 100   , 50   );
INSERT INTO employees VALUES    ( 141   , 'Trenna'   , 'Rajs'   , 'TRAJS'   , '650.121.8009'   , to_date('17-10-1995','DD-MM-YYYY')   , 'ST_CLERK'   , 3500   , NULL   , 124   , 50   );
INSERT INTO employees VALUES    ( 142   , 'Curtis'   , 'Davies'   , 'CDAVIES'   , '650.121.2994'   , to_date('29-1-1997','DD-MM-YYYY') ,  'ST_CLERK'   , 3100   , NULL   , 124   , 50   );
INSERT INTO employees VALUES    ( 143   , 'Randall'   , 'Matos'   , 'RMATOS'   , '650.121.2874'   , to_date('15-3-1998','DD-MM-YYYY')  , 'ST_CLERK'   , 2600   , NULL   , 124   , 50   );
INSERT INTO employees VALUES    ( 144   , 'Peter'   , 'Vargas'   , 'PVARGAS'   , '650.121.2004'   , to_date('09-7-1998','DD-MM-YYYY')  , 'ST_CLERK'   , 2500   , NULL   , 124   , 50   );
INSERT INTO employees VALUES    ( 149   , 'Eleni'   , 'Zlotkey'   , 'EZLOTKEY'   , '011.44.1344.429018'   ,to_date('29-1-2000','DD-MM-YYYY')  , 'SA_MAN'   , 10500   , .2   , 100   , 80   );
INSERT INTO employees VALUES    ( 174   , 'Ellen'   , 'Abel'   , 'EABEL'   , '011.44.1644.429267'   , to_date('11-5-1996','DD-MM-YYYY')   , 'SA_REP'   , 11000   , .30   , 149   , 80   );
INSERT INTO employees VALUES    ( 176   , 'Jonathon'   , 'Taylor'   , 'JTAYLOR'   , '011.44.1644.429265'   , to_date('24-3-1998','DD-MM-YYYY')  , 'SA_REP'   , 8600   , .20   , 149   , 80   );
INSERT INTO employees VALUES    ( 178   , 'Kimberely'   , 'Grant'   , 'KGRANT'   , '011.44.1644.429263'   , to_date('24-5-1999','DD-MM-YYYY')  , 'SA_REP'   , 7000   , .15   , 149   , NULL   );
INSERT INTO employees VALUES    ( 200   , 'Jennifer'   , 'Whalen'   , 'JWHALEN'   , '515.123.4444'   , to_date('17-9-1987','DD-MM-YYYY') , 'AD_ASST'   , 4400   , NULL   , 101   , 10   );
INSERT INTO employees VALUES    ( 201   , 'Michael'   , 'Hartstein'   , 'MHARTSTE'   , '515.123.5555'   ,to_date('17-2-1996','DD-MM-YYYY')  , 'MK_MAN'   , 13000   , NULL   , 100   , 20   );
INSERT INTO employees VALUES    ( 202   , 'Pat'   , 'Fay'   , 'PFAY'   , '603.123.6666'   , to_date('17-8-1997','DD-MM-YYYY')  , 'MK_REP'   , 6000   , NULL   , 201   , 20   );
INSERT INTO employees VALUES    ( 205   , 'Shelley'   , 'Higgins'   , 'SHIGGINS'   , '515.123.8080'   , to_date('07-06-1994','DD-MM-YYYY')  , 'AC_MGR'   , 12000   , NULL   , 101   , 110   );
INSERT INTO employees VALUES    ( 206   , 'William'   , 'Gietz'   , 'WGIETZ'   , '515.123.8181'   , to_date('07-6-1994','DD-MM-YYYY')  , 'AC_ACCOUNT'   , 8300   , NULL   , 205   , 110   );
select * from employees;

INSERT INTO job_history VALUES (102   ,to_date('13-1-1993','DD-MM-YYYY'), to_date('24-7-1998','DD-MM-YYYY'), 'IT_PROG'   , 60);
INSERT INTO job_history VALUES (101   ,to_date('21-9-1989','DD-MM-YYYY'),to_date('27-10-1993','DD-MM-YYYY') , 'AC_ACCOUNT'   , 110);
INSERT INTO job_history VALUES (101   , to_date('28-10-1993','DD-MM-YYYY'),  to_date('15-3-1997','DD-MM-YYYY') , 'AC_MGR'   , 110);
INSERT INTO job_history VALUES (201   , to_date('17-2-1996','DD-MM-YYYY')   , to_date('19-12-1999','DD-MM-YYYY')  , 'MK_REP'   , 20);
INSERT INTO job_history VALUES (114   ,to_date('24-3-1998','DD-MM-YYYY')  , to_date('31-12-1999','DD-MM-YYYY') , 'ST_CLERK'   , 50   );
INSERT INTO job_history VALUES (122   , to_date('01-1-1999','DD-MM-YYYY')   , to_date('31-12-1999','DD-MM-YYYY')  , 'ST_CLERK'   , 50   );
INSERT INTO job_history VALUES (200   , to_date('17-12-1987','DD-MM-YYYY') ,to_date('17-6-1993','DD-MM-YYYY') , 'AD_ASST'   , 90   );
INSERT INTO job_history VALUES (176   , to_date('24-3-1998','DD-MM-YYYY')  , to_date('31-12-1998','DD-MM-YYYY') , 'SA_REP'   , 80   );
INSERT INTO job_history VALUES (176   , to_date('01-1-1999','DD-MM-YYYY')  , to_date('31-12-1999','DD-MM-YYYY') , 'SA_MAN'   , 80   );
INSERT INTO job_history VALUES (200   , to_date('01-7-1994','DD-MM-YYYY') , to_date('31-12-1998','DD-MM-YYYY')  , 'AC_ACCOUNT'   , 90   );
select * from job_history;

insert into job_grades values('A',1000,2999);
insert into job_grades values('B',3000,5999);
insert into job_grades values('C',6000,9999);
insert into job_grades values('D',10000,14999);
insert into job_grades values('E',15000,24999);
insert into job_grades values('F',25000,40000);
select * from job_grades;
drop table job_grades;

savepoint d;

/*affiche constraint d'un table*/
select constraint_name,constraint_type,search_condition from user_constraints Where lower(table_name) = 'employees';