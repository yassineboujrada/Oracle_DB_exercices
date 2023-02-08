-- create tables 
CREATE TABLE J (ID_J CHAR(4) NOT NULL,
        JNAME char(20),
        CITY char(10),
constraint pk_J PRIMARY KEY (ID_J));


CREATE TABLE P (ID_P CHAR(4) NOT NULL,
        PNAME char(20),
        COLOR char(8),
        WEIGHT integer,
        CITY char(10),
constraint pk_P PRIMARY KEY (ID_P));

CREATE TABLE S (ID_S CHAR(4) NOT NULL,
        SNAME char(20),
        STATUS CHAR(2),
        CITY char(10),
constraint pk_S PRIMARY KEY (ID_S));

CREATE TABLE SPJ (
        ID_S CHAR(4) NOT NULL,
        ID_P CHAR(4) NOT NULL,
        ID_J CHAR(4) NOT NULL,
        QTY integer,
        DATE_DERNIERE_LIVRAISON date,
constraint pk_SPJ PRIMARY KEY (ID_S, ID_P, ID_J),
constraint pk_SPJ_S FOREIGN KEY (ID_S) REFERENCES S(ID_S),
constraint pk_SPJ_P FOREIGN KEY (ID_P) REFERENCES P(ID_P),
constraint pk_SPJ_J FOREIGN KEY (ID_J) REFERENCES J(ID_J));

/* chargement de la table S */
insert into S values('S1','Smith','20','London');
insert into S values('S2','Jones','10','Paris');
insert into S values('S3','Blake','30','Paris');
insert into S values('S4','Clark','20','London');
insert into S values('S5','Adams','30','Athens');

/* chargement de la table P */

insert into P values('P1','Nut','Red',12,'London');
insert into P values('P2','Bolt','Green',17,'Paris');
insert into P values('P3','Screw','Blue',17,'Rome');
insert into P values('P4','Screw','Red',14,'London');
insert into P values('P5','Cam','Blue',12,'Paris');
insert into P values('P6','Cog','Red',19,'London');

/* chargement de la table J */
insert into J values('J1','Sorter','Paris');
insert into J values('J2','Display','Rome');
insert into J values('J3','OCR','Athens');
insert into J values('J4','Console','Athens');
insert into J values('J5','RAID','London');
insert into J values('J6','EDS','Oslo');
insert into J values('J7','Tape','London');
 /* chargement de la table SPJ */
insert into SPJ values('S1','P1','J1',200,to_date('05-10-2001','dd-mm-yyyy'));
insert into SPJ values('S1','P1','J4',700,to_date('10-05-2001','dd-mm-yyyy'));
insert into SPJ values('S2','P3','J1',400,to_date('20-05-2001','dd-mm-yyyy'));
insert into SPJ values('S2','P3','J2',200,to_date('30-07-2000','dd-mm-yyyy'));
insert into SPJ values('S2','P3','J3',200,to_date('10-05-2001','dd-mm-yyyy'));
insert into SPJ values('S2','P3','J4',500,to_date('03-10-2001','dd-mm-yyyy'));
insert into SPJ values('S2','P3','J5',600,to_date('20-09-2001','dd-mm-yyyy'));
insert into SPJ values('S2','P3','J6',400,to_date('12-05-2000','dd-mm-yyyy'));
insert into SPJ values('S2','P3','J7',800,to_date('23-08-2001','dd-mm-yyyy'));
insert into SPJ values('S2','P5','J2',100,to_date('23-06-2000','dd-mm-yyyy'));
insert into SPJ values('S3','P3','J1',200,to_date('07-07-2001','dd-mm-yyyy'));
insert into SPJ values('S3','P4','J2',500,to_date('18-05-2001','dd-mm-yyyy'));
insert into SPJ values('S4','P6','J3',300,to_date('10-05-2001','dd-mm-yyyy'));
insert into SPJ values('S4','P6','J7',300,to_date('16-09-2001','dd-mm-yyyy'));
insert into SPJ values('S5','P2','J2',200,to_date('10-11-2001','dd-mm-yyyy'));
insert into SPJ values('S5','P2','J4',100,to_date('17-04-2001','dd-mm-yyyy'));
insert into SPJ values('S5','P5','J5',500,to_date('08-02-2001','dd-mm-yyyy'));
insert into SPJ values('S5','P5','J7',100,to_date('25-06-2001','dd-mm-yyyy'));
insert into SPJ values('S5','P6','J2',200,to_date('09-02-2001','dd-mm-yyyy'));
insert into SPJ values('S5','P1','J4',100,to_date('18-03-2000','dd-mm-yyyy'));
insert into SPJ values('S5','P3','J4',200,to_date('19-05-2001','dd-mm-yyyy'));
insert into SPJ values('S5','P4','J4',800,to_date('10-05-2001','dd-mm-yyyy'));
insert into SPJ values('S5','P5','J4',400,to_date('16-12-2001','dd-mm-yyyy'));
insert into SPJ values('S5','P6','J4',500,to_date('10-10-2001','dd-mm-yyyy'));
commit;

--  Exercice 1:
--1
select DISTINCT PNAME from p where weight<18 and lower(city) in('rome','london');
--2
select distinct jname from j where lower(jname) like '%i%';
--3
select distinct D.id_s,D.id_p,D.id_j from s A,p B,j C,spj D 
where D.id_s = A.id_s and D.id_p = B.id_p and D.id_j = C.id_j and A.city <> B.city and B.city <> C.city and  A.city<>C.city;
--4
select distinct p1.id_p,p2.id_p,sj.id_s from spj sj,p p1,p p2,s s1 
where sj.id_s = s1.id_s and sj.id_p = p1.id_p and p1.id_p <> p2.id_p and lower(s1.city)=lower(p1.city) and lower(s1.city)=lower(p1.city);
--5
select A.jname from j A,s B,spj sp where A.id_j=sp.id_j and B.id_s = sp.id_s and B.id_s = 'S1';
--6
select A.color from p A,spj sp where A.id_p=sp.id_p and sp.id_s = 'S3';
--7
select distinct A.id_p from p A,s B,spj sp where sp.id_p=A.id_p and B.id_s=sp.id_s and lower(A.city) = 'london' and lower(B.city) = 'london';
--8
select A.id_s,A.city,B.id_p,B.city,C.id_j,C.city from s A,p B,j C
where A.city <> B.city and B.city <> C.city and  A.city<>C.city;

--  Exercice 2:
--1
select QTY,count(*) as Livairisons from spj where id_s in (select id_s from s)  group by QTY;
--2
select id_s ,count(*) from spj group by id_s;
--3
select B.jname, sum(A.qty) as piece_fournit from spj A,j B where A.id_j=B.id_j group by B.jname;
--4
select A.id_p,A.id_s,A.id_j, B.WEIGHT*A.qty from spj A,p B where A.id_p = B.id_p order by A.id_p;
--5
select A.id_j,sum(B.WEIGHT) from spj A,p B where A.id_p = B.id_p GROUP BY A.id_j;
--6
select max(B.WEIGHT*A.qty) as livraison_plus_lord from spj A,p B where A.id_p = B.id_p;
--7
select id_j,id_p,sum(qty) as total from spj group by id_j,id_p;
--8
select id_p,id_j from spj group by id_j,id_p having avg(qty)>320; 

--  Exercice 3:
--1
select A.id_p from spj A, p B where A.id_p = B.id_p group by A.id_p having sum(qty)>1250;
--2
select id_s,sum(qty) from spj where id_s>'S3' GROUP BY id_s;
--3
