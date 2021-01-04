--1
SELECT MatrNr
FROM univerwaltung.hoeren
INNER JOIN univerwaltung.vorlesungen 
ON univerwaltung.hoeren.VorlNr = univerwaltung.vorlesungen.VorlNr
WHERE univerwaltung.vorlesungen.titel = 'Ethik';
/*
28106
29120
30000
*/

--2
SELECT DISTINCT name
FROM univerwaltung.studenten
INNER JOIN univerwaltung.hoeren 
ON univerwaltung.studenten.MatrNr = univerwaltung.hoeren.MatrNr
WHERE univerwaltung.hoeren.VorlNr = ANY (
	SELECT vorlnr FROM univerwaltung.hoeren
	WHERE univerwaltung.hoeren.MatrNr = (
		SELECT MatrNr FROM univerwaltung.studenten
		WHERE univerwaltung.studenten.name = 'Schopenhauer'
		)
)
AND univerwaltung.studenten.name != 'Schopenhauer';
/*
"Fichte"
"Theophrastos"
"Tester"
"Feuerbach"
*/

--3
SELECT DISTINCT name
FROM univerwaltung.studenten
INNER JOIN univerwaltung.hoeren 
ON univerwaltung.studenten.MatrNr = univerwaltung.hoeren.MatrNr
WHERE univerwaltung.hoeren.VorlNr = ALL (
	SELECT vorlnr FROM univerwaltung.hoeren
	WHERE univerwaltung.hoeren.MatrNr = (
		SELECT MatrNr FROM univerwaltung.studenten
		WHERE univerwaltung.studenten.name = 'Schopenhauer'
		)
)
AND univerwaltung.studenten.name != 'Schopenhauer';
/*
""
*/

--4
SELECT nachfolger
FROM univerwaltung.voraussetzen
GROUP BY nachfolger
HAVING COUNT (univerwaltung.voraussetzen.vorgaenger) >= 2;
/*
5052
*/

--5
SELECT VorlNr, COUNT (VorlNr) AS Anzahl
FROM univerwaltung.pruefen
GROUP BY VorlNr
ORDER BY VorlNr DESC;
/*
5259	1
5052	1
5049	1
5043	1
5041	2
5022	1
5001	1
4630	2
4052	1
*/

--6
SELECT univerwaltung.professoren.name
FROM univerwaltung.professoren
INNER JOIN univerwaltung.assistenten
ON univerwaltung.professoren.PersNr = univerwaltung.assistenten.Boss
GROUP BY univerwaltung.professoren.name
HAVING COUNT (univerwaltung.assistenten.Boss) = (
    SELECT MAX (Hoechstes)
    FROM (
        SELECT COUNT (univerwaltung.assistenten.Boss) Hoechstes
        FROM univerwaltung.professoren
        INNER JOIN univerwaltung.assistenten
        ON univerwaltung.professoren.PersNr = univerwaltung.assistenten.Boss
        GROUP BY univerwaltung.professoren.name
    ) assistenten
)
/*
"Sokrates"
*/

--7
SELECT name
FROM univerwaltung.studenten AS S
WHERE NOT EXISTS (
	SELECT * 
	FROM univerwaltung.vorlesungen AS V
	WHERE NOT EXISTS (
		SELECT *
		FROM univerwaltung.hoeren AS H
		WHERE S.MatrNr = H.MatrNr
		AND H.VorlNr = V.VorlNr
	)
)
/*
"Tester"
*/

--8
SELECT COUNT (univerwaltung.pruefen.note)
FROM univerwaltung.pruefen 
WHERE univerwaltung.pruefen.note = 1
OR univerwaltung.pruefen.note = 2
/*
7
*/

--9
SELECT univerwaltung.studenten.MatrNr, univerwaltung.studenten.name, 
AVG(univerwaltung.pruefen.note), 
VARIANCE(univerwaltung.pruefen.note)
FROM univerwaltung.studenten
INNER JOIN univerwaltung.pruefen
ON univerwaltung.pruefen.MatrNr = univerwaltung.studenten.MatrNr
GROUP BY univerwaltung.studenten.MatrNr
/*
30000	"Tester"	2.875	3.8392857142857144
28106	"Carnap"	1	
25403	"Jonas"	2	
27550	"Schopenhauer"	2		
*/

--10
SELECT univerwaltung.Professoren.name
FROM univerwaltung.Professoren
INTERSECT
SELECT univerwaltung.Assistenten.name
FROM univerwaltung.Assistenten

UNION 

SELECT univerwaltung.Professoren.name
FROM univerwaltung.Professoren
INTERSECT
SELECT univerwaltung.studenten.name
FROM univerwaltung.studenten

UNION 

SELECT univerwaltung.Assistenten.name
FROM univerwaltung.Assistenten
INTERSECT
SELECT univerwaltung.studenten.name
FROM univerwaltung.studenten
/*
"Sokrates"
*/

--11
CREATE RECURSIVE VIEW Ancestor(vorgaenger, nachfolger) AS
(SELECT vorgaenger AS Vorgaenger, nachfolger AS Nachfolger
FROM univerwaltung.voraussetzen)
 
UNION

(SELECT univerwaltung.voraussetzen.vorgaenger AS Vorgaenger, Ancestor.Nachfolger AS Nachfolger
 FROM univerwaltung.voraussetzen, Ancestor
 WHERE univerwaltung.voraussetzen.nachfolger = Ancestor.Vorgaenger)
 
SELECT ANCESTOR.nachfolger, ANCESTOR.vorgaenger FROM ANCESTOR
ORDER BY ANCESTOR.nachfolger
/*
5041	5001
5043	5001
5049	5001
5052	5001
5052	5043
5052	5041
5216	5041
5216	5001
5259	5001
5259	5052
5259	5041
5259	5043
*/