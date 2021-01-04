EXPLAIN ANALYSE
SELECT MatrNr
FROM univerwaltung.hoeren
INNER JOIN univerwaltung.vorlesungen 
ON univerwaltung.hoeren.VorlNr = univerwaltung.vorlesungen.VorlNr
WHERE univerwaltung.vorlesungen.titel = 'Ethik';
/*
"Hash Join  (cost=1.14..2.44 rows=1 width=4) (actual time=0.033..0.037 rows=3 loops=1)"
"  Hash Cond: (hoeren.vorlnr = vorlesungen.vorlnr)"
"  ->  Seq Scan on hoeren  (cost=0.00..1.23 rows=23 width=8) (actual time=0.014..0.015 rows=23 loops=1)"
"  ->  Hash  (cost=1.13..1.13 rows=1 width=4) (actual time=0.013..0.013 rows=1 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"        ->  Seq Scan on vorlesungen  (cost=0.00..1.13 rows=1 width=4) (actual time=0.009..0.010 rows=1 loops=1)"
"              Filter: ((titel)::text = 'Ethik'::text)"
"              Rows Removed by Filter: 9"
"Planning Time: 1.474 ms"
"Execution Time: 0.056 ms"
*/
CREATE INDEX id_hoeren
ON univerwaltung.hoeren (MatrNr, VorlNr)

CREATE INDEX h_vorlnr
ON univerwaltung.hoeren (VorlNr)

CREATE INDEX v_vorlnr
ON univerwaltung.vorlesungen (VorlNr)

CREATE INDEX v_titel
ON univerwaltung.vorlesungen (titel)

EXPLAIN ANALYSE
SELECT MatrNr
FROM univerwaltung.hoeren
INNER JOIN univerwaltung.vorlesungen 
ON univerwaltung.hoeren.VorlNr = univerwaltung.vorlesungen.VorlNr
WHERE univerwaltung.vorlesungen.titel = 'Ethik';

/*
"Hash Join  (cost=1.14..2.44 rows=1 width=4) (actual time=0.034..0.038 rows=3 loops=1)"
"  Hash Cond: (hoeren.vorlnr = vorlesungen.vorlnr)"
"  ->  Seq Scan on hoeren  (cost=0.00..1.23 rows=23 width=8) (actual time=0.015..0.016 rows=23 loops=1)"
"  ->  Hash  (cost=1.13..1.13 rows=1 width=4) (actual time=0.013..0.013 rows=1 loops=1)"
"        Buckets: 1024  Batches: 1  Memory Usage: 9kB"
"        ->  Seq Scan on vorlesungen  (cost=0.00..1.13 rows=1 width=4) (actual time=0.009..0.010 rows=1 loops=1)"
"              Filter: ((titel)::text = 'Ethik'::text)"
"              Rows Removed by Filter: 9"
"Planning Time: 0.187 ms"
"Execution Time: 0.056 ms"
*/

/*
Aufgrund der geringen Größe der Datenbank ist die Nutzung von Indices nicht besonders zielführend, um eine schnellere Laufzeit zu garantieren. 
*/