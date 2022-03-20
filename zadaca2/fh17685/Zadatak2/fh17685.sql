CREATE TABLE FAKTURA17685(faktura_id INTEGER PRIMARY KEY,
                          kupac_id INTEGER NOT NULL REFERENCES kupac(kupac_id),
                          iznos INTEGER NOT NULL,
                          datum_kupoprodaje DATE NOT NULL,
                          isporuka_id INTEGER NOT NULL REFERENCES isporuka(isporuka_id),
                          ukp_prodanih_proizvoda INTEGER NOT NULL );

CREATE TABLE NARUDZBA_PROIZVODA17685( narudzba_id INTEGER PRIMARY KEY,
                                      proizvod_id INTEGER NOT NULL REFERENCES proizvod(proizvod_id),
                                      kolicina_jednog_proizvoda INTEGER NOT NULL,
                                      faktura_id INTEGER NOT NULL REFERENCES faktura17685(faktura_id),
                                      iznos_popusta INTEGER );

CREATE TABLE PROIZVOD17685( proizvod_id INTEGER PRIMARY KEY,
                            naziv VARCHAR(102) NOT NULL,
                            cijena INTEGER NOT NULL,
                            broj_mjeseci_garancije INTEGER );

CREATE TABLE PROIZVODJAC17685( proizvodjac_id INTEGER PRIMARY KEY REFERENCES pravno_lice(pravno_lice_id),
                               email VARCHAR(50),
                               naziv VARCHAR(50) NOT NULL,
                               lokacija_id INTEGER NOT NULL UNIQUE REFERENCES lokacija(lokacija_id) );

ALTER TABLE PROIZVOD17685 ADD ( proizvodjac_id INTEGER NOT NULL REFERENCES proizvodjac17685(proizvodjac_id) );

INSERT INTO Faktura17685 (faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id, ukp_prodanih_proizvoda)
            SELECT f.faktura_id, f.kupac_id, f.iznos, f.datum_kupoprodaje,f.isporuka_id, Nvl(n.ukp_prodanih_proizvoda,0)
            FROM faktura f, ( SELECT t.faktura_id fakt_id,
                                     Sum(t.kolicina_jednog_proizvoda) ukp_prodanih_proizvoda
                              FROM narudzba_proizvoda t
                              GROUP BY t.faktura_id ) n
            WHERE f.faktura_id = n.fakt_id(+);

INSERT INTO Narudzba_proizvoda17685 (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, iznos_popusta)
            SELECT n.narudzba_id, n.proizvod_id, n.kolicina_jednog_proizvoda, n.faktura_id,
                   a.cijena*n.kolicina_jednog_proizvoda*( Nvl(p.postotak, 0) /100) iznos_popusta
            FROM narudzba_proizvoda n, popust p, proizvod a
            WHERE n.popust_id = p.popust_id(+)
              AND n.proizvod_id = a.proizvod_id;

INSERT INTO Proizvodjac17685( proizvodjac_id, email, naziv, lokacija_id )
            SELECT p.proizvodjac_id, p.email, l.naziv, l.lokacija_id
            FROM proizvodjac p, pravno_lice l
            WHERE p.proizvodjac_id = l.pravno_lice_id;

INSERT INTO Proizvod17685( proizvod_id, naziv, cijena, broj_mjeseci_garancije, proizvodjac_id )
            SELECT p.proizvod_id, p.naziv || '(' || k.naziv || ')', p.cijena, p.broj_mjeseci_garancije, p.proizvodjac_id
            FROM proizvod p, kategorija k
            WHERE k.kategorija_id = p.kategorija_id;

CREATE SEQUENCE trigger_seq
INCREMENT BY 1
START WITH 0
MINVALUE 0
NOCYCLE
NOCACHE;

CREATE OR REPLACE FUNCTION faktura_not_exists (p_faktura_id Faktura17685.faktura_id%type) RETURN BOOLEAN
IS
  lv_count INTEGER;
BEGIN
  SELECT Count(*)
  INTO   lv_count
  FROM   Faktura17685
  WHERE  faktura_id = p_faktura_id;

  RETURN (lv_count = 0);
END;
/
CREATE OR REPLACE FUNCTION proizvodjac_not_exists (p_proizvodjac_id Proizvodjac17685.proizvodjac_id%type) RETURN BOOLEAN
IS
  lv_count INTEGER;
BEGIN
  SELECT Count(*)
  INTO   lv_count
  FROM   Proizvodjac17685
  WHERE  proizvodjac_id = p_proizvodjac_id;

  RETURN (lv_count = 0);
END;
/
CREATE OR REPLACE FUNCTION proizvod_not_exists (p_proizvod_id Proizvod17685.proizvod_id%type) RETURN BOOLEAN
IS
  lv_count INTEGER;
BEGIN
  SELECT Count(*)
  INTO   lv_count
  FROM   Proizvod17685
  WHERE  proizvod_id = p_proizvod_id;

  RETURN (lv_count = 0);
END;
/

CREATE OR REPLACE TRIGGER Trigger_bekap_n_p
AFTER INSERT ON Narudzba_proizvoda
FOR EACH ROW
DECLARE
    lv_proizvodjac_id Proizvodjac17685.proizvodjac_id%TYPE;
    lv_broj_izvrsenja_triggera NUMBER;
BEGIN
    lv_broj_izvrsenja_triggera := trigger_seq.NEXTVAL;

    IF(faktura_not_exists(:new.faktura_id)) THEN
        INSERT INTO Faktura17685 (faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id, ukp_prodanih_proizvoda)
              SELECT f.faktura_id, f.kupac_id, f.iznos, f.datum_kupoprodaje,f.isporuka_id, Nvl(:new.kolicina_jednog_proizvoda, 0)
              FROM faktura f
              WHERE f.faktura_id = :new.faktura_id;
    END IF;

    IF(proizvod_not_exists(:new.proizvod_id)) THEN
       INSERT INTO Proizvod17685( proizvod_id, naziv, cijena, broj_mjeseci_garancije, proizvodjac_id )
            SELECT p.proizvod_id, p.naziv || '(' || k.naziv || ')', p.cijena, p.broj_mjeseci_garancije, p.proizvodjac_id
            FROM proizvod p, kategorija k
            WHERE p.proizvod_id = :new.proizvod_id
              AND k.kategorija_id = p.kategorija_id;
    END IF;

    SELECT p.proizvodjac_id INTO lv_proizvodjac_id
    FROM proizvod p
    WHERE p.proizvod_id = :new.proizvod_id;

    IF(proizvodjac_not_exists(lv_proizvodjac_id)) THEN
        INSERT INTO Proizvodjac17685( proizvodjac_id, email, naziv, lokacija_id )
             SELECT p.proizvodjac_id, p.email, l.naziv, l.lokacija_id
             FROM proizvodjac p, pravno_lice l
             WHERE p.proizvodjac_id = lv_proizvodjac_id
               AND p.proizvodjac_id = l.pravno_lice_id;
    END IF;

    INSERT INTO Narudzba_proizvoda17685 (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, iznos_popusta)
    VALUES(:new.narudzba_id, :new.proizvod_id, :new.kolicina_jednog_proizvoda, :new.faktura_id, (SELECT a.cijena*:new.kolicina_jednog_proizvoda*( Nvl(p.postotak, 0) /100)
                                                                                                 FROM popust p, proizvod a
                                                                                                 WHERE :new.popust_id = p.popust_id(+)
                                                                                                  AND :new.proizvod_id = a.proizvod_id) );

    EXCEPTION
       WHEN Dup_Val_On_Index THEN
         NULL;

END;
/

CREATE OR REPLACE PROCEDURE Bekap_procedurom ( p_narudzba_id Narudzba_proizvoda.narudzba_id%TYPE )
IS
   lv_faktura_id Faktura.faktura_id%TYPE;
   lv_proizvod_id Proizvod.proizvod_id%TYPE;
   lv_proizvodjac_id Proizvodjac.proizvodjac_id%TYPE;
BEGIN

    IF(faktura_not_exists(lv_faktura_id)) THEN
      INSERT INTO Faktura17685 (faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id, ukp_prodanih_proizvoda)
            SELECT f.faktura_id, f.kupac_id, f.iznos, f.datum_kupoprodaje,f.isporuka_id, Nvl(n.ukp_prodanih_proizvoda,0)
            FROM faktura f, ( SELECT t.faktura_id fakt_id,
                                     Sum(t.kolicina_jednog_proizvoda) ukp_prodanih_proizvoda
                              FROM narudzba_proizvoda t
                              GROUP BY t.faktura_id ) n
            WHERE f.faktura_id = lv_faktura_id
              AND f.faktura_id = n.fakt_id(+);
    END IF;

    IF(proizvod_not_exists(lv_proizvod_id)) THEN
       INSERT INTO Proizvod17685( proizvod_id, naziv, cijena, broj_mjeseci_garancije, proizvodjac_id )
            SELECT p.proizvod_id, p.naziv || '(' || k.naziv || ')', p.cijena, p.broj_mjeseci_garancije, p.proizvodjac_id
            FROM proizvod p, kategorija k
            WHERE p.proizvod_id = lv_proizvod_id
              AND k.kategorija_id = p.kategorija_id;
    END IF;

    IF(proizvodjac_not_exists(lv_proizvodjac_id)) THEN
        INSERT INTO Proizvodjac17685( proizvodjac_id, email, naziv, lokacija_id )
            SELECT p.proizvodjac_id, p.email, l.naziv, l.lokacija_id
            FROM proizvodjac p, pravno_lice l
            WHERE p.proizvodjac_id = lv_proizvodjac_id
              AND p.proizvodjac_id = l.pravno_lice_id;
    END IF;

    SELECT n.faktura_id, a.proizvod_id, p.proizvodjac_id INTO lv_faktura_id, lv_proizvod_id, lv_proizvodjac_id
    FROM narudzba_proizvoda n, proizvod a, proizvodjac p
    WHERE n.narudzba_id = p_narudzba_id
      AND n.proizvod_id = a.proizvod_id
      AND a.proizvodjac_id = p.proizvodjac_id;

    INSERT INTO Narudzba_proizvoda17685 (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, iznos_popusta)
           SELECT n.narudzba_id, n.proizvod_id, n.kolicina_jednog_proizvoda, n.faktura_id,
                   a.cijena*n.kolicina_jednog_proizvoda*( Nvl(p.postotak, 0) /100) iznos_popusta
           FROM narudzba_proizvoda n, popust p, proizvod a
           WHERE n.popust_id = p.popust_id(+)
             AND n.proizvod_id = a.proizvod_id
             AND n.narudzba_id = p_narudzba_id;

		EXCEPTION
      WHEN Dup_Val_On_Index THEN
        NULL;
END Bekap_procedurom;
/

CREATE OR REPLACE FUNCTION Bekap_ispravnost RETURN BOOLEAN
IS
    orginalno_slogova NUMBER;
    bekap_slogova NUMBER;
BEGIN
	  SELECT Count(*) INTO orginalno_slogova
	  FROM Narudzba_proizvoda;

   	SELECT Count(*) INTO bekap_slogova
  	FROM Narudzba_proizvoda np, Narudzba_proizvoda17685 npb
    WHERE np.narudzba_id = npb.narudzba_id
      AND np.proizvod_id = npb.proizvod_id
      AND np.kolicina_jednog_proizvoda = npb.kolicina_jednog_proizvoda
      AND np.faktura_id = npb.faktura_id;

	  IF( orginalno_slogova != bekap_slogova ) THEN
	        RETURN(FALSE);
	  END IF;

	  SELECT Count(*) INTO orginalno_slogova
	  FROM   Faktura;

	  SELECT Count(*) INTO bekap_slogova
   	FROM Faktura f, Faktura17685 fb
  	WHERE f.faktura_id = fb.faktura_id
      AND f.kupac_id = fb.kupac_id
      AND f.iznos = fb.iznos
      AND f.datum_kupoprodaje = fb.datum_kupoprodaje
      AND f.isporuka_id = fb.isporuka_id;

	  IF( orginalno_slogova != bekap_slogova ) THEN
	      RETURN(FALSE);
	  END IF;

	  SELECT Count(*) INTO orginalno_slogova
	  FROM Proizvod;

	  SELECT Count(*) INTO bekap_slogova
   	FROM Proizvod p, Proizvod17685 pb
	  WHERE p.proizvod_id = pb.proizvod_id
      AND p.cijena = pb.cijena
      AND p.proizvodjac_id = pb.proizvodjac_id
      AND Nvl(p.broj_mjeseci_garancije, -1) = nvl(pb.broj_mjeseci_garancije,-1);

	  IF( orginalno_slogova != bekap_slogova ) THEN
	        RETURN(FALSE);
   	END IF;

	  SELECT Count(*) INTO orginalno_slogova
   	FROM Proizvodjac;

  	SELECT Count(*) INTO bekap_slogova
    FROM Proizvodjac p, Pravno_lice l, Proizvodjac17685 pb
    WHERE p.proizvodjac_id = l.pravno_lice_id
      AND p.proizvodjac_id = pb.proizvodjac_id
      AND p.email = pb.email
      AND l.naziv = pb.naziv
      AND l.lokacija_id = pb.lokacija_id;

	  IF( orginalno_slogova != bekap_slogova ) THEN
	      RETURN (FALSE);
	  END IF;

    RETURN( True );

END Bekap_ispravnost;
/


--Provjera Triggera
INSERT INTO Narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id)
       VALUES (21, 10, 1, 11 );

SELECT * FROM Narudzba_proizvoda17685;

DELETE Narudzba_proizvoda
WHERE narudzba_id = 21;

DELETE Narudzba_proizvoda17685
WHERE narudzba_id = 21;


INSERT INTO Faktura (faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id)
VALUES (11, 5, 597, SYSDATE, 6);

SELECT * FROM faktura17685;

DELETE Faktura
WHERE faktura_id = 11;

DELETE Faktura17685
WHERE faktura_id = 11;


--Dropanje
DROP FUNCTION Bekap_ispravnost;
DROP PROCEDURE Bekap_procedurom;
DROP TRIGGER Trigger_bekap_n_p;
DROP FUNCTION proizvod_not_exists;
DROP FUNCTION proizvodjac_not_exists;
DROP FUNCTION faktura_not_exists;
DROP SEQUENCE trigger_seq;

DROP TABLE Narudzba_proizvoda17685;

DROP TABLE PROIZVOD17685;

DROP TABLE proizvodjac17685;

DROP TABLE Faktura17685;




--Provjera

SELECT * FROM Faktura17685;

SELECT * FROM narudzba_proizvoda17685;

SELECT * FROM proizvod17685;

SELECT * FROM proizvodjac17685;


SELECT * FROM Faktura;

SELECT * FROM narudzba_proizvoda;

SELECT * FROM proizvod;
SELECT * FROM popust;

SELECT * FROM proizvodjac;
SELECT * FROM pravno_lice;

CREATE TABLE ispravno (id number);

BEGIN
  IF( Bekap_ispravnost ) THEN
     INSERT INTO ispravno
     VALUES (1);
  ELSE
     INSERT INTO ispravno
     VALUES (0);
  END IF;
END;

SELECT * FROM ispravno;
