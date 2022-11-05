--1
CREATE TABLE artiste(
    NOM VARCHAR2(15),
    GERNRE VARCHAR2(10),
    NATIONALITE VARCHAR2(15)
);
--2
insert into artiste values('yassine','rock','marocaine');
insert into artiste values('abdelwahab','jazz','marocaine');

select * from artiste;

--3
ALTER TABLE ARTISTE ADD CONSTRAINT ARTISTE_PK PRIMARY KEY(NOM);
CREATE TABLE ALBUM(
    TITRE VARCHAR2(20),
    ANNE NUMBER(4) NOT NULL CONSTRAINT ANN_CHECK CHECK(ANNE BETWEEN 1900 AND 2100),
    ARTISTE VARCHAR2(15) CONSTRAINT ALBUM_FK REFERENCES ARTISTE(NOM)
);
DESC ALBUM;

--4
insert into album values('candy shop','2001','yassine');
insert into album values('revolution','2020','yassine');
insert into album values('hangover','2019','abdelwahab');
insert into album values('umbrella','2000','abdelwahab');

--5
CREATE TABLE CHANSON (
    TITRE VARCHAR(15),
    ALBUM VARCHAR(20),
    NUMERO NUMBER,
    DUREE NUMBER
);
ALTER TABLE ALBUM ADD CONSTRAINT ALBUM_PK PRIMARY KEY(TITRE);
ALTER TABLE CHANSON ADD CONSTRAINT CHANSON_FK FOREIGN KEY(ALBUM) REFERENCES ALBUM(TITRE);

--6
UPDATE ARTISTE SET NATIONALITE='FR' WHERE UPPER(NATIONALITE)='FRANCAIS';

--7
ALTER TABLE CHANSON ADD ARTISTE VARCHAR2(10);

--8
ALTER TABLE CHANSON MODIFY NUMERO NUMBER NOT NULL;

--9
ALTER TABLE artiste ADD CONSTRAINT ARTISTE_CHECK CHECK(UPPER(GERNRE) IN ('ROCK','HARD ROCK','JAZZ'));

--10
insert into artiste values('TEST','JAZZ','SUISSE');
insert into album values('candy','2001','TEST');
insert into CHANSON values('TEST_CHAN','candy',2,2,'TEST');

delete from chanson where artiste in (select nom from artiste where lower(nationalite)='suisse');
delete from album where artiste in (select NOM from artiste where lower(NATIONALITE)='suisse');
delete from artiste where lower(nationalite)='suisse';

--11
ALTER TABLE CHANSON ADD CONSTRAINT CHANSON_PK PRIMARY KEY(TITRE);
ALTER TABLE CHANSON DROP CONSTRAINT CHANSON_PK;

--12
ALTER TABLE ARTISTE DROP CONSTRAINT ARTISTE_PK CASCADE;