--  A : creation des tables

create table piece(
    nop NUMERIC ,
    designation VARCHAR2(15) ,
    couleur VARCHAR2(10),
    poids NUMERIC
);

desc piece;

create table service(
    nos NUMERIC ,
    intitule VARCHAR2(15) ,
    localisation VARCHAR2(10)
);

desc service;

create table ordre(
    nop NUMERIC ,
    nos NUMERIC ,
    quantite VARCHAR2(10)
);

desc ordre;

create table nomenclature(
    nopa NUMERIC ,
    nopc NUMERIC ,
    quantite VARCHAR2(10)
);

desc nomenclature;

--  B : contarintes d'integrite

-- 1
insert into piece VALUES (1,'MA','rouge',10);
insert into piece VALUES (2,'GE','bleu',15);
insert into piece VALUES (2,'chargeur','gray',5);

--2
INSERT INTO service VALUES (1,'marjan','casa');
INSERT INTO service VALUES (2,'carfoour','essaouira');
insert into service VALUES (2,'dircteur','rabat');

--3
INSERT INTO ordre VALUES (1,2,30);
INSERT INTO ordre VALUES (1,1,20); 
insert into ordre VALUES (1,3,15);

--4
INSERT INTO nomenclature VALUES(2,1,15);
INSERT INTO nomenclature VALUES(1,2,40);
insert into nomenclature VALUES (5,7,45);

--5 ,6 and 7
update piece set nop=3 where lower(designation)='chargeur';
alter table piece add constraint piece_pr primary key(nop);

update service set nos=3 where lower(intitule)='dircteur';
alter table service add constraint service_pr primary key(nos);

alter table ordre add constraint ordre_pr primary key(nop,nos);
alter table ordre add constraint ordre_fk foreign key(nop) references piece(nop);
alter table ordre add constraint ord2re_fk foreign key(nos) references service(nos);

alter table nomenclature add constraint nom_pr primary key(NOPA,NOPC);
update nomenclature set NOPC=2,NOPA=3 where NOPC=7;
alter table nomenclature add constraint nom_fk1 foreign key(NOPA) references piece(NOP);
alter table nomenclature add constraint nom_fk2 foreign key(NOPC) references piece(NOP);

update piece set couleur='jaune' where nop=3;
alter table piece add CONSTRAINT color_check check(couleur in ('rouge','bleu','jaune','verte'));

savepoint a;

--  C : modification de la structure de la base

--1
alter table PIECE Modify designation VARCHAR2(10);
alter table SERVICE Modify intitule VARCHAR2(10);

--2
alter table SERVICE Modify localisation VARCHAR2(10);

--3
alter table SERVICE add directeur VARCHAR2(10);
desc SERVICE;

--4
alter table PIECE drop CONSTRAINT piece_pr;

--5
alter table SERVICE drop column localisation;

--6
alter table PIECE drop CONSTRAINT color_check;

--7
DROP table NOMENCLATURE;

--8
DROP table ORDRE CASCADE CONSTRAINTS;
