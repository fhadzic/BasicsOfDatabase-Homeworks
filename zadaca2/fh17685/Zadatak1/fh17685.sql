--1
CREATE TABLE fh17685upit1 AS
       SELECT p.naziv
       FROM pravno_lice p
       WHERE p.lokacija_id IN ( SELECT f.lokacija_id
                                FROM fizicko_lice f );
--2
CREATE TABLE fh17685upit2 AS
       SELECT To_Char (u.datum_potpisivanja ,'dd.MM.yyyy') "DATUM POTPISIVANJA",
              p.naziv
       FROM ugovor_za_pravno_lice u, pravno_lice p
       WHERE u.pravno_lice_id = p.pravno_lice_id
         AND u.datum_potpisivanja > ( SELECT Min(f.datum_kupoprodaje)
                                      FROM faktura f, narudzba_proizvoda n, proizvod p
                                      WHERE f.faktura_id = n.faktura_id
                                        AND n.proizvod_id = p.proizvod_id
                                        AND p.broj_mjeseci_garancije IS NOT NULL );

--3
CREATE TABLE fh17685upit3 AS
       SELECT p.naziv
       FROM proizvod p
       WHERE p.kategorija_id =ANY (SELECT t.kategorija_id
                                   FROM proizvod t
                                   WHERE t.proizvod_id = ( SELECT k.proizvod_id
                                                           FROM kolicina k
                                                           GROUP BY k.proizvod_id
                                                           HAVING Sum(k.kolicina_proizvoda) = (SELECT Max(Sum(t2.kolicina_proizvoda))
                                                                                               FROM kolicina t2
                                                                                               GROUP BY t2.proizvod_id  ))             );




--4
CREATE TABLE fh17685upit4 AS
       SELECT p.naziv "Proizvod",
              l.naziv "Proizvodjac"
       FROM proizvod p, proizvodjac s, pravno_lice l
       WHERE p.proizvodjac_id = s.proizvodjac_id
         AND s.proizvodjac_id = l.pravno_lice_id
         AND s.proizvodjac_id IN ( SELECT t.proizvodjac_id
                                   FROM proizvodjac t, proizvod a
                                   WHERE a.proizvodjac_id = t.proizvodjac_id
                                     AND a.cijena >  ( SELECT Avg(p1.cijena)
                                                       FROM proizvod p1     ) );

--5
CREATE TABLE fh17685upit5 AS
       SELECT l.ime || ' ' || l.prezime "Ime i prezime",
              Sum(f.iznos) "Potroseni iznos"
       FROM kupac k, uposlenik u, fizicko_lice l, faktura f
       WHERE k.kupac_id = l.fizicko_lice_id
         AND l.fizicko_lice_id = u.uposlenik_id
         AND k.kupac_id = f.kupac_id
       GROUP BY l.ime, l.prezime
       HAVING Sum(f.iznos) > ( SELECT Round(Avg(Sum(fa.iznos)), 2)
                               FROM faktura fa, kupac ku, fizicko_lice fl, uposlenik up
                               WHERE fa.kupac_id = ku.kupac_id
                                 AND ku.kupac_id = fl.fizicko_lice_id
                                 AND fl.fizicko_lice_id = up.uposlenik_id
                               GROUP BY fl.ime, fl.prezime   ) ;
--6
CREATE TABLE fh17685upit6 AS
       SELECT l.naziv
       FROM narudzba_proizvoda n, faktura f, isporuka i, pravno_lice l
       WHERE n.faktura_id = f.faktura_id
         AND f.isporuka_id = i.isporuka_id
         AND i.kurirska_sluzba_id = l.pravno_lice_id
         AND n.popust_id IS NOT NULL
       GROUP BY l.naziv
       HAVING Sum (n.kolicina_jednog_proizvoda) = ( SELECT Max(Sum (n.kolicina_jednog_proizvoda))
                                                    FROM narudzba_proizvoda n, faktura f, isporuka i, pravno_lice l
                                                    WHERE n.faktura_id = f.faktura_id
                                                      AND f.isporuka_id = i.isporuka_id
                                                      AND i.kurirska_sluzba_id = l.pravno_lice_id
                                                      AND n.popust_id IS NOT NULL
                                                    GROUP BY i.kurirska_sluzba_id );
--7
CREATE TABLE fh17685upit7 AS
       SELECT l.ime || ' ' || l.prezime "Kupac",
              Sum( n.kolicina_jednog_proizvoda*a.cijena* (p.postotak/100) ) "Usteda"
       FROM fizicko_lice l, kupac k, faktura f, narudzba_proizvoda n, popust p, proizvod a
       WHERE l.fizicko_lice_id = k.kupac_id
         AND k.kupac_id = f.kupac_id
         AND f.faktura_id = n.faktura_id
         AND n.proizvod_id = a.proizvod_id
         AND p.popust_id = n.popust_id
       GROUP BY l.ime || ' ' || l.prezime;
--8
CREATE TABLE fh17685upit8 AS
       SELECT DISTINCT i.*
       FROM isporuka i, faktura f, narudzba_proizvoda n, proizvod p
       WHERE i.isporuka_id = f.isporuka_id
         AND f.faktura_id = n.faktura_id
         AND n.proizvod_id = p.proizvod_id
         AND p.broj_mjeseci_garancije IS NOT NULL
         AND n.popust_id IS NOT NULL;
--9
CREATE TABLE fh17685upit9 AS
       SELECT p.naziv,
              p.cijena
       FROM proizvod p
       WHERE p.cijena > ( SELECT Round(Avg(Max(t.cijena)), 2)
                          FROM proizvod t
                          GROUP BY t.kategorija_id );
--10
CREATE TABLE fh17685upit10 AS
       SELECT p.naziv,
              p.cijena
       FROM proizvod p, kategorija k
       WHERE p.kategorija_id = k.kategorija_id
         AND p.cijena <ALL ( SELECT Avg(t.cijena)
                             FROM proizvod t
                             WHERE t.kategorija_id != k.nadkategorija_id
                             GROUP BY t.kategorija_id );

/*
SELECT * FROM fh17685upit1;
SELECT * FROM fh17685upit2;
SELECT * FROM fh17685upit3;
SELECT * FROM fh17685upit4;
SELECT * FROM fh17685upit5;
SELECT * FROM fh17685upit6;
SELECT * FROM fh17685upit7;
SELECT * FROM fh17685upit8;
SELECT * FROM fh17685upit9;
SELECT * FROM fh17685upit10;

DROP TABLE fh17685upit1;
DROP TABLE fh17685upit2;
DROP TABLE fh17685upit3;
DROP TABLE fh17685upit4;
DROP TABLE fh17685upit5;
DROP TABLE fh17685upit6;
DROP TABLE fh17685upit7;
DROP TABLE fh17685upit8;
DROP TABLE fh17685upit9;
DROP TABLE fh17685upit10;
*/
