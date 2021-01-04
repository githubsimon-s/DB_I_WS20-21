SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: windsor; Type: SCHEMA; Schema: -; Owner: postgres
--
DROP SCHEMA univerwaltung CASCADE;

CREATE SCHEMA univerwaltung;


ALTER SCHEMA univerwaltung OWNER TO postgres;

--
-- Name: SCHEMA windsor; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA univerwaltung IS 'Verwaltung';


SET search_path = univerwaltung, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: parents; Type: TABLE; Schema: windsor; Owner: postgres; Tablespace: 
--

--Erstellung der Tabellen


CREATE TABLE Studenten (
    MatrNr INT,
    Name VARCHAR(255),
    Semester INT,
    PRIMARY KEY (MatrNr)
);

/*
Neuer Eintrag in Professorentabelle mit den von ihm gehaltenen Vorlesungen.
Das Attribut VorlNr in der Tabelle Vorlesungen wird als Fremdschlüssel haelt gesetzt.
Der nötige Constraint wird erst am Ende gesetzt, da Professoren und Vorlesungen ansonsten nicht erstellt werden können.
*/
CREATE TABLE Professoren (
    PersNr INT NOT NULL,
    Name VARCHAR(255),
    Rang VARCHAR(255),
    Raum INT,
	haelt INT NOT NULL,
    PRIMARY KEY (PersNr)
);

CREATE TABLE Vorlesungen (
    VorlNr INT,
    Titel VARCHAR(255),
    SWS INT,
    gelesenVon INT NOT NULL,
    PRIMARY KEY (VorlNr),
    CONSTRAINT fk_PersNr 
		FOREIGN KEY (gelesenVon) 
		REFERENCES Professoren (PersNr)
);

CREATE TABLE Assistenten (
    PersNr INT NOT NULL,
    Name VARCHAR(255),
    Fachgebiet VARCHAR(255),
    Boss INT NOT NULL,
    PRIMARY KEY (PersNr)
);

CREATE TABLE pruefen (
    MatrNr INT NOT NULL,
    VorlNr INT NOT NULL,
    PersNr INT,
    Note REAL NOT NULL,
    PRIMARY KEY (MatrNr,VorlNr)
);

CREATE TABLE hoeren (
    MatrNr INT NOT NULL,
    VorlNr INT NOT NULL,
    PRIMARY KEY (MatrNr,VorlNr)
);

CREATE TABLE voraussetzen (
    Vorgaenger INT NOT NULL,
    Nachfolger INT NOT NULL,
    PRIMARY KEY (Vorgaenger,Nachfolger)
);

--Füllen der Tabellen
BEGIN;

INSERT INTO univerwaltung.Studenten(MatrNr, Name, Semester) 
VALUES (24002, 'Xenokrates', 18); 
 
INSERT INTO univerwaltung.Studenten(MatrNr, Name, Semester) 
VALUES (25403, 'Jonas', 12); 
 
INSERT INTO univerwaltung.Studenten(MatrNr, Name, Semester) 
VALUES (26120, 'Fichte', 10); 

INSERT INTO univerwaltung.Studenten(MatrNr, Name, Semester) 
VALUES (26830, 'Aristoxenos', 8); 
 
INSERT INTO univerwaltung.Studenten(MatrNr, Name, Semester) 
VALUES (27550, 'Schopenhauer', 6); 

INSERT INTO univerwaltung.Studenten(MatrNr, Name, Semester) 
VALUES (28106, 'Carnap', 3); 
 
INSERT INTO univerwaltung.Studenten(MatrNr, Name, Semester) 
VALUES (29120, 'Theophrastos', 2); 
 
INSERT INTO univerwaltung.Studenten(MatrNr, Name, Semester) 
VALUES (29555, 'Feuerbach', 2); 

INSERT INTO univerwaltung.Studenten(MatrNr, Name, Semester) 
VALUES (30000, 'Tester', 2);



INSERT INTO univerwaltung.Professoren(PersNr, Name, Rang, Raum, haelt) 
VALUES (2125, 'Sokrates', 'W3', 226, 5041); 

INSERT INTO univerwaltung.Professoren(PersNr, Name, Rang, Raum, haelt) 
VALUES (2126, 'Russel', 'W3', 232, 5043);  
 
INSERT INTO univerwaltung.Professoren(PersNr, Name, Rang, Raum, haelt) 
VALUES (2127, 'Kopernikus', 'W2', 310, 5002); 
 
INSERT INTO univerwaltung.Professoren(PersNr, Name, Rang, Raum, haelt) 
VALUES (2133, 'Popper', 'W2', 052, 5259); 
 
INSERT INTO univerwaltung.Professoren(PersNr, Name, Rang, Raum, haelt) 
VALUES (2134, 'Augustinus', 'W2', 309, 5022); 
 
INSERT INTO univerwaltung.Professoren(PersNr, Name, Rang, Raum, haelt) 
VALUES (2136, 'Curie', 'W3', 036, 5003); 
 
INSERT INTO univerwaltung.Professoren(PersNr, Name, Rang, Raum, haelt) 
VALUES (2137, 'Kant', 'W3', 007, 5001); 

 
 
INSERT INTO univerwaltung.Assistenten(PersNr, Name, Fachgebiet, Boss) 
VALUES (3002, 'Platon', 'Ideenlehre', 2125); 
 
INSERT INTO univerwaltung.Assistenten(PersNr, Name, Fachgebiet, Boss) 
VALUES (3003, 'Aristoteles', 'Syllogistik', 2125); 
 
INSERT INTO univerwaltung.Assistenten(PersNr, Name, Fachgebiet, Boss) 
VALUES (3004, 'Wittgenstein', 'Sprachtheorie', 2126); 
 
INSERT INTO univerwaltung.Assistenten(PersNr, Name, Fachgebiet, Boss) 
VALUES (3005, 'Rhetikus', 'Planetenbewegung', 2127); 
 
INSERT INTO univerwaltung.Assistenten(PersNr, Name, Fachgebiet, Boss) 
VALUES (3006, 'Newton', 'Keplersche Gesetze', 2127); 
 
INSERT INTO univerwaltung.Assistenten(PersNr, Name, Fachgebiet, Boss) 
VALUES (3007, 'Spinoza', 'Gott und Natur', 2134);
INSERT INTO univerwaltung.Assistenten(PersNr, Name, Fachgebiet, Boss) 
VALUES (3008, 'Sokrates', 'Ethik', 2125);


 
INSERT INTO univerwaltung.Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5001, 'Grundzuege', 4, 2137);

INSERT INTO univerwaltung.Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5041, 'Ethik', 4, 2125);
 
INSERT INTO univerwaltung.Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5043, 'Erkenntnistheorie', 3, 2126);
 
INSERT INTO univerwaltung.Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5049, 'Maeeutik', 2, 2125);
 
INSERT INTO univerwaltung.Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (4052, 'Logik', 4, 2125);
 
INSERT INTO univerwaltung.Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5052, 'Wissenschaftstheorie', 3, 2126); 
 
INSERT INTO univerwaltung.Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5216, 'Bioethik', 2, 2126); 
 
INSERT INTO univerwaltung.Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5259, 'Der Wiener Kreis', 2, 2133); 
 
INSERT INTO univerwaltung.Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5022, 'Glaube und Wissen', 2, 2134); 
 
INSERT INTO univerwaltung.Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (4630, 'Die 3 Kritiken', 4, 2137); 

INSERT INTO univerwaltung.Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5002, 'Graphentheorie', 3, 2127);

INSERT INTO univerwaltung.Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5003, 'Atombombenbau', 2, 2136);  


 
 
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (26120, 5001); 
 
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (27550, 5001); 
 
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (27550, 4052); 
 
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (28106, 5041); 
 
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (28106, 5052); 
 
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (28106, 5216); 
 
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (28106, 5259); 
 
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (29120, 5001); 

INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (29120, 5041); 

INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (29120, 5049); 

INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (29555, 5022); 

INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (25403, 5022);  
 
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (29555, 5001); 

INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (30000, 5001); 
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (30000, 5041);
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (30000, 5043);
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (30000, 5049);
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (30000, 4052);
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (30000, 5052);
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (30000, 5216);
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (30000, 5259);
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (30000, 5022);
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (30000, 4630);
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (30000, 5002);
INSERT INTO univerwaltung.hoeren(MatrNr, VorlNr) 
VALUES (30000, 5003);

 
 
 
INSERT INTO univerwaltung.voraussetzen(Vorgaenger, Nachfolger) 
VALUES (5001, 5041); 
 
INSERT INTO univerwaltung.voraussetzen(Vorgaenger, Nachfolger) 
VALUES (5001, 5043); 
 
INSERT INTO univerwaltung.voraussetzen(Vorgaenger, Nachfolger) 
VALUES (5001, 5049); 
 
INSERT INTO univerwaltung.voraussetzen(Vorgaenger, Nachfolger) 
VALUES (5041, 5216);  

INSERT INTO univerwaltung.voraussetzen(Vorgaenger, Nachfolger) 
VALUES (5043, 5052);  

INSERT INTO univerwaltung.voraussetzen(Vorgaenger, Nachfolger) 
VALUES (5041, 5052); 
 
INSERT INTO univerwaltung.voraussetzen(Vorgaenger, Nachfolger) 
VALUES (5052, 5259); 
 


INSERT INTO univerwaltung.pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (28106, 5001, 2126, 1.0);

INSERT INTO univerwaltung.pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (25403, 5041, 2125, 2.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (27550, 4630, 2137, 2.0);

INSERT INTO univerwaltung.pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (30000, 5041, 2137, 1.0);
INSERT INTO univerwaltung.pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (30000, 5043, 2137, 2.0);
INSERT INTO univerwaltung.pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (30000, 5049, 2137, 3.0);
INSERT INTO univerwaltung.pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (30000, 4052, 2137, 4.0);
INSERT INTO univerwaltung.pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (30000, 5052, 2137, 5.0);
INSERT INTO univerwaltung.pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (30000, 5259, 2137, 6.0);
INSERT INTO univerwaltung.pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (30000, 5022, 2137, 1.0);
INSERT INTO univerwaltung.pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (30000, 4630, 2137, 1.0);

COMMIT;

--Fremdschluessel für die Professoren-braucht-Vorlesung-Bedingung
ALTER TABLE univerwaltung.Professoren 
ADD CONSTRAINT fk_vorlnr 
FOREIGN KEY(haelt) REFERENCES univerwaltung.Vorlesungen(VorlNr)
ON DELETE CASCADE;