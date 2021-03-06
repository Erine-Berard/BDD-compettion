USE master
GO

-- Suppression / création de la base de donnée
DROP DATABASE IF EXISTS TD1;
GO
CREATE DATABASE TD1;
GO

use TD1
Go


--Suppression dans une premier temps des tables de liaison
DROP TABLE IF EXISTS PRATIQUE
DROP TABLE IF EXISTS PARTICIPE
DROP TABLE IF EXISTS SPORT_COMPETITION

-- Suppression des table contenent les informations 
DROP TABLE IF EXISTS SPORT
DROP TABLE IF EXISTS SPORTIF
DROP TABLE IF EXISTS COMPETITION



-- table des compétitions 

--creation de la table
CREATE TABLE COMPETITION (
   ID_COMPETITION int not null IDENTITY,
   NOM VARCHAR(20) not null,
   ADRESSE VARCHAR(100) not null,
   VILLE VARCHAR(50) not null,
   CP VARCHAR(5) not null,
   PAYS VARCHAR(30) not null,
   DATE_DEBUT datetime not null,
   DATE_FIN datetime not null,
   CONSTRAINT COMPETITION_PK PRIMARY KEY (ID_COMPETITION),
   CONSTRAINT COMPETITION_DATE CHECK (DATE_DEBUT < DATE_FIN),
   CONSTRAINT COMPETITION_CP_1 CHECK (Len(CP)=5),
)
GO

--insérer des lignes 
INSERT INTO Competition(NOM,ADRESSE, VILLE,CP, PAYS, DATE_DEBUT, DATE_FIN)
VALUES ('Jeux Olympiques','Corso Sebastopoli,123','Turin','10100','Italie','10/02/2006 00:00:00','26/02/2006 00:00:00'),
       ('Jeux Olympiques','777 Pacific Boulevard','Vancouver','10100','Canada','12/02/2010 00:00:00','28/02/2010 00:00:00'),
	   ('Meeting d''Athlétisme','Badenerstrasse 500 ','Zurich','12344','Suisse','02/07/2022 00:00:00','17/07/2022 00:00:00')




-- table des sportifs 

--creation de la table
CREATE TABLE SPORTIF (
   ID_SPORTIF int not null IDENTITY,
   NOM VARCHAR(30) not null,
   PRENOM VARCHAR(30) not null,
   PAYS_ORIGINE VARCHAR(30) not null,
   DATE_NAISSANCE date not null,
   CONSTRAINT SPORTIF_PK PRIMARY KEY (ID_SPORTIF),
)
GO

--insérer des lignes 
INSERT INTO SPORTIF (NOM,PRENOM, PAYS_ORIGINE, DATE_NAISSANCE)
VALUES ('Dénériaz','Antoine','France','06/03/19'),
       ('Raich','Benjamin','Autriche','28/02/1978'),
	   ('Cheek','Joey','Etats-Unis','22/06/1979'),
	   ('Hanyu','Yuzuru','Japon','07/12/1994'),
	   ('Arakawa','Shizuka','Japon','29/12/1981'),
	   ('Lambiel','Stéphane','Suisse','02/05/1985'),
	   ('Cohen','Sasha','Etats-Unis','26/10/1984'),
	   ('Brodeur','Martin','Canada','06/05/1972'),
	   ('Gleason','Tim','Etats-Unis','29/01/1983'),
	   ('Pitkänen','Joni','Finlande','19/09/1983'),
	   ('Weber','Shea','Canada','14/06/1985')
       



--table des Sports

--creation de la table
CREATE TABLE SPORT (
   ID_SPORT int not null IDENTITY,
   NOM varchar(30) not null,
   CONSTRAINT SPORT_PK PRIMARY KEY (ID_SPORT),
)
GO
ALTER TABLE SPORT ADD CONSTRAINT SPORT_NOM UNIQUE (NOM);

--insérer des lignes 
INSERT INTO SPORT (NOM)
VALUES ('Rugby'),
       ('Football'),
	   ('Ski alpin'),
	   ('Patinage de vitesse'),
	   ('Patinage artistique'),
	   ('Hockey')





--table de liaison entre le sport et les compétitions

--creation de la table
CREATE TABLE SPORT_COMPETITION (
   ID_SPORT int not null,
   ID_COMPETITION int not null,
   CONSTRAINT SPORT_COMPETITION_FK1 FOREIGN KEY (ID_SPORT) REFERENCES SPORT (ID_SPORT),
   CONSTRAINT SPORT_COMPETITION_FK2 FOREIGN KEY (ID_COMPETITION) REFERENCES COMPETITION (ID_COMPETITION)
)
GO
ALTER TABLE SPORT_COMPETITION ADD CONSTRAINT SPORT_COMPETITION_PK PRIMARY KEY (ID_SPORT,ID_COMPETITION);


--insérer des lignes (Sport,Competition)
INSERT INTO SPORT_COMPETITION
VALUES (1,1),
       (1,2),
	   (2,2),
	   (2,1),
	   (3,1),
	   (3,2),
	   (4,1),
	   (4,2),
	   (5,1),
	   (5,2),
	   (6,1),
	   (6,2)




--table de participation

--creation de la table
CREATE TABLE PARTICIPE (
   ID_SPORTIF int not null,
   ID_COMPETITION int not null,
   CONSTRAINT PARTICIPE_PK PRIMARY KEY (ID_SPORTIF,ID_COMPETITION)
)
GO
ALTER TABLE PARTICIPE ADD CONSTRAINT PARTICIPE_FK1 FOREIGN KEY (ID_SPORTIF) REFERENCES SPORTIF (ID_SPORTIF);
ALTER TABLE PARTICIPE ADD CONSTRAINT PARTICIPE_FK2 FOREIGN KEY (ID_COMPETITION) REFERENCES COMPETITION (ID_COMPETITION);

--insérer des lignes (Sportif, Competition)
INSERT INTO PARTICIPE
VALUES (1,1),
       (2,1),
	   (3,1),
	   (3,2),
	   (5,1),
	   (6,1),
	   (6,2),
	   (7,1),
	   (8,2),
	   (9,2),
	   (10,2),
	   (11,2),
	   (8,1),
	   (9,1),
	   (11,1)


        



--Table Pratique 

--creation de la table
CREATE TABLE PRATIQUE(
   ID_SPORTIF int not null,
   ID_SPORT int not null,
   CONSTRAINT PRATIQUE_PK PRIMARY KEY (ID_SPORTIF,ID_SPORT)
)
GO
ALTER TABLE PRATIQUE ADD CONSTRAINT PRATIQUE_FK1 FOREIGN KEY (ID_SPORTIF) REFERENCES SPORTIF (ID_SPORTIF);
ALTER TABLE PRATIQUE ADD CONSTRAINT PRATIQUE_FK2 FOREIGN KEY (ID_SPORT) REFERENCES SPORT (ID_SPORT);

--insérer des lignes (Sportif, Sport)
INSERT INTO PRATIQUE
VALUES (1,3),
       (2,3),
	   (3,4),
	   (4,5),
	   (5,5),
	   (6,5),
	   (7,5),
	   (8,6),
	   (9,6),
	   (10,6),
	   (11,6)



