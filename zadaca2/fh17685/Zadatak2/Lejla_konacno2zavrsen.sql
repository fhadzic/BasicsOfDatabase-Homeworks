--faktura
CREATE TABLE faktura18257
(faktura_id NUMBER(10) NOT NULL,
 kupac_id NUMBER(10) NOT NULL,
 iznos NUMBER(10) NOT NULL,
 datum_kupoprodaje DATE NOT NULL,
 isporuka_id NUMBER(10) NOT NULL,
 broj_proizvoda NUMBER,
 CONSTRAINT faktura18257_faktura_id_pk PRIMARY KEY (faktura_id),
 CONSTRAINT faktura18257_kup_id_fk FOREIGN KEY (kupac_id) REFERENCES kupac(kupac_id),
 CONSTRAINT faktura18257_isp_id_fk FOREIGN KEY (isporuka_id) REFERENCES isporuka(isporuka_id)
);

INSERT INTO faktura18257 (faktura_id,kupac_id,iznos,datum_kupoprodaje,isporuka_id, broj_proizvoda)
SELECT f1.faktura_id,f1.kupac_id,f1.iznos,f1.datum_kupoprodaje,f1.isporuka_id, (SELECT Sum(np.kolicina_jednog_proizvoda)
                                                                                FROM   narudzba_proizvoda np
                                                                                WHERE  f1.faktura_id=np.faktura_id)
FROM   faktura f1;


--proizvodjac
CREATE TABLE proizvodjac18257
(proizvodjac_id NUMBER(10) NOT NULL,
 naziv VARCHAR2(50) NOT NULL,
 email VARCHAR2(50),
 lokacija_id NUMBER(10) NOT NULL,
 CONSTRAINT pr18257_pr_id_pk PRIMARY KEY(proizvodjac_id),
 CONSTRAINT pr18257_l_id_fk FOREIGN KEY (lokacija_id) REFERENCES lokacija(lokacija_id)
);

INSERT INTO proizvodjac18257
SELECT p.proizvodjac_id, pl.naziv, p.email,pl.lokacija_id
FROM   proizvodjac p, pravno_lice pl
WHERE  p.proizvodjac_id = pl.pravno_lice_id;


--proizvod
CREATE TABLE proizvod18257
(proizvod_id NUMBER(10) NOT NULL,
 naziv VARCHAR2(61) NOT NULL,
 cijena NUMBER(10) NOT NULL,
 proizvodjac_id NUMBER(10) NOT NULL,
 broj_mjeseci_garancije NUMBER(10),
 CONSTRAINT p18257_p_id_pk PRIMARY KEY (proizvod_id),
 CONSTRAINT p18257_pr_id_fk FOREIGN KEY (proizvodjac_id) REFERENCES proizvodjac18257(proizvodjac_id)
);

INSERT INTO proizvod18257 (proizvod_id, naziv,cijena,proizvodjac_id,broj_mjeseci_garancije)
SELECT p.proizvod_id, p.naziv || '(' || k.naziv|| ')',p.cijena,p.proizvodjac_id,p.broj_mjeseci_garancije
FROM proizvod p, kategorija k
WHERE p.kategorija_id=k.kategorija_id
ORDER BY proizvod_id;


--narudzba proizvoda
CREATE TABLE narudzba_proizvoda18257
(narudzba_id NUMBER(10) NOT NULL,
 proizvod_id NUMBER(10) NOT NULL,
 kolicina_jednog_proizvoda NUMBER(10) NOT NULL,
 faktura_id NUMBER(10) NOT NULL,
 iznos_sa_popustom NUMBER,
 CONSTRAINT np18257_n_id_pk PRIMARY KEY (narudzba_id),
 CONSTRAINT np18257_p_id_fk FOREIGN KEY(proizvod_id) REFERENCES proizvod18257(proizvod_id),
 CONSTRAINT np18257_f_id_fk FOREIGN KEY(faktura_id)  REFERENCES faktura18257 (faktura_id)
);

INSERT INTO narudzba_proizvoda18257 (narudzba_id,proizvod_id,kolicina_jednog_proizvoda,faktura_id,iznos_sa_popustom)
SELECT np.narudzba_id,np.proizvod_id,np.kolicina_jednog_proizvoda,np.faktura_id,(SELECT Decode(np1.popust_id,
                                                                                               NULL, np1.kolicina_jednog_proizvoda*p.cijena,
                                                                                               np1.kolicina_jednog_proizvoda*(p.cijena-np1.popust_id*p.cijena/10))
                                                                                 FROM   narudzba_proizvoda np1,proizvod p
                                                                                 WHERE  np1.proizvod_id=p.proizvod_id AND
                                                                                        np1.proizvod_id=np.proizvod_id AND
                                                                                        np.narudzba_id=np1.narudzba_id)
FROM   narudzba_proizvoda np;



--sekvenca
CREATE SEQUENCE brojac_okidanja_trigera
INCREMENT BY 1
START WITH 0
MINVALUE 0
NOCACHE
NOCYCLE;

--trigger
CREATE OR REPLACE TRIGGER narudzba_proizvoda_t
AFTER INSERT ON LM18257.narudzba_proizvoda
FOR EACH ROW
DECLARE
	broj NUMBER(10);
BEGIN
    broj := brojac_okidanja_trigera.NEXTVAL;
		INSERT INTO LM18257.narudzba_proizvoda18257
    VALUES(:NEW.narudzba_id, :NEW.proizvod_id, :NEW.kolicina_jednog_proizvoda, :NEW.faktura_id, (SELECT  Decode(np1.popust_id,
                                                                                                                        NULL, p.cijena*np1.kolicina_jednog_proizvoda,
                                                                                                                        (p.cijena-np1.popust_id*p.cijena/10)*np1.kolicina_jednog_proizvoda)
                                                                                                         FROM   narudzba_proizvoda np1,proizvod p
                                                                                                         WHERE  np1.proizvod_id=p.proizvod_id AND
                                                                                                                np1.narudzba_id=:new.narudzba_id));

    INSERT INTO LM18257.faktura18257
    SELECT faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id, (SELECT sum( n2.kolicina_jednog_proizvoda )
                                                                         FROM narudzba_proizvoda n2
                                                                         WHERE n2.faktura_id = :NEW.faktura_id )
  	FROM	 faktura f2
  	WHERE  f2.faktura_id = :NEW.faktura_id;

    INSERT INTO LM18257.proizvod18257
    SELECT proizvod_id, naziv || '(' || (SELECT naziv
                                         FROM kategorija k
                                         WHERE k.kategorija_id = pr.kategorija_id) || ')' AS naziv_kategorija,
           cijena, proizvodjac_id, broj_mjeseci_garancije
    FROM proizvod pr
    WHERE pr.proizvod_id = :NEW.proizvod_id;

EXCEPTION
WHEN Dup_Val_On_Index THEN
    NULL;
END  narudzba_proizvoda_t;
/

--procedura
CREATE OR REPLACE PROCEDURE narudzba_proizvoda_p (narudzbaid IN NUMBER) IS

BEGIN
    INSERT INTO LM18257.narudzba_proizvoda18257
    SELECT narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, COALESCE((SELECT n.kolicina_jednog_proizvoda * ( po.postotak / 100 ) * pr.cijena
                                                                                      FROM popust po, proizvod pr
                                                                                      WHERE pr.proizvod_id = n.proizvod_id AND
                                                                                            po.popust_id = n.popust_id),
                                                                                     (SELECT n.kolicina_jednog_proizvoda * pr.cijena
                                                                                     FROM proizvod pr
                                                                                     WHERE pr.proizvod_id = narudzbaid ))
    FROM narudzba_proizvoda n
    WHERE n.narudzba_id= narudzbaid;

    INSERT INTO LM18257.faktura18257
    SELECT f2.faktura_id, f2.kupac_id, f2.iznos,f2.datum_kupoprodaje, f2.isporuka_id,(SELECT sum( n2.kolicina_jednog_proizvoda )
                                                                                      FROM   narudzba_proizvoda n2
                                                                                      WHERE  n2.faktura_id = np.faktura_id )
    FROM faktura f2, narudzba_proizvoda np
    WHERE f2.faktura_id = np.faktura_id AND np.narudzba_id = narudzbaid;

		INSERT INTO LM18257.proizvod18257
    SELECT pr.proizvod_id, pr.naziv || '(' || (SELECT naziv
                                               FROM kategorija k
                                               WHERE k.kategorija_id = pr.kategorija_id) || ')' AS naziv_kategorija,
           pr.cijena, pr.proizvodjac_id, broj_mjeseci_garancije
    FROM proizvod pr, narudzba_proizvoda np
    WHERE np.narudzba_id = narudzbaid AND pr.proizvod_id = np.proizvod_id;
		EXCEPTION
          WHEN Dup_Val_On_Index THEN
            NULL;
END narudzba_proizvoda_p;
/


--funkcija
CREATE OR REPLACE FUNCTION ispravnost
RETURN VARCHAR2 IS
       res VARCHAR2(10) := 'Ispravno';
       ukupan_br NUMBER;
       nadjeno_br NUMBER;
BEGIN
	  SELECT Count(*) INTO ukupan_br
	  FROM narudzba_proizvoda;

   	SELECT Count(*) INTO nadjeno_br
  	FROM narudzba_proizvoda np, narudzba_proizvoda18257 np2
    WHERE np.narudzba_id = np2.narudzba_id AND
          np.proizvod_id = np2.proizvod_id AND
          np.kolicina_jednog_proizvoda = np2.kolicina_jednog_proizvoda AND
          np.faktura_id = np2.faktura_id;

	  IF ukupan_br != nadjeno_br THEN
	        res:='Neispravno';
	  END IF;

	  SELECT Count(*) INTO ukupan_br
	  FROM   faktura;

	  SELECT Count(*) INTO nadjeno_br
   	FROM faktura f, faktura18257 f2
  	WHERE f.faktura_id = f2.faktura_id AND
          f.kupac_id = f2.kupac_id AND
          f.iznos = f2.iznos AND
          f.datum_kupoprodaje = f2.datum_kupoprodaje AND
          f.isporuka_id = f2.isporuka_id;

	  IF ukupan_br != nadjeno_br THEN
	       res:='Neispravno';
	  END IF;

	  SELECT Count(*) INTO ukupan_br
	  FROM proizvod;

	  SELECT count(*) INTO nadjeno_br
   	FROM proizvod p, proizvod18257 p2
	  WHERE p.proizvod_id = p2.proizvod_id AND
          p.cijena = p2.cijena AND
          p.proizvodjac_id = p2.proizvodjac_id AND
          Nvl(p.broj_mjeseci_garancije, -1) = nvl(p2.broj_mjeseci_garancije,-1);

	  IF ukupan_br != nadjeno_br THEN
	        res:='Neispravno';
   	END IF;

	  SELECT Count(*) INTO ukupan_br
   	FROM proizvodjac;

  	SELECT Count(*) INTO nadjeno_br
    FROM proizvodjac p, proizvodjac18257 p2
    WHERE p.proizvodjac_id = p2.proizvodjac_id AND
          p.email = p2.email;

	  IF ukupan_br != nadjeno_br THEN
	      res:='Neispravno';
	  END IF;

    RETURN( res );

END ispravnost;
/

