CREATE TABLE KONTINENT(kontinent_id INTEGER PRIMARY KEY,
                       naziv VARCHAR(50) NOT NULL);

CREATE TABLE DRZAVA(drzava_id INTEGER PRIMARY KEY,
                    naziv VARCHAR(50) NOT NULL,
                    kontinent_id INTEGER NOT NULL REFERENCES kontinent(kontinent_id));

CREATE TABLE GRAD(grad_id INTEGER PRIMARY KEY,
                    naziv VARCHAR(50) NOT NULL,
                    drzava_id INTEGER NOT NULL REFERENCES drzava(drzava_id));

CREATE TABLE LOKACIJA(lokacija_id INTEGER PRIMARY KEY,
                      naziv_ulice VARCHAR(50) NOT NULL,
                      broj INTEGER NOT NULL,
                      grad_id INTEGER NOT NULL REFERENCES grad(grad_id));

CREATE TABLE FIZICKO_LICE(fizicko_lice_id INTEGER PRIMARY KEY,
                          ime VARCHAR(50) NOT NULL,
                          prezime VARCHAR(50) NOT NULL,
                          datum_rodjenja DATE NOT NULL,
                          lokacija_id INTEGER NOT NULL REFERENCES lokacija(lokacija_id));

CREATE TABLE PRAVNO_LICE(pravno_lice_id INTEGER PRIMARY KEY,
                         naziv VARCHAR(50) NOT NULL,
                         lokacija_id INTEGER NOT NULL UNIQUE REFERENCES lokacija(lokacija_id));

CREATE TABLE PROIZVODJAC(proizvodjac_id INTEGER PRIMARY KEY REFERENCES pravno_lice(pravno_lice_id),
                         email VARCHAR(50));

CREATE TABLE KURIRSKA_SLUZBA(kurirska_sluzba_id INTEGER PRIMARY KEY REFERENCES pravno_lice(pravno_lice_id),
                         broj_telefona VARCHAR(50));

CREATE TABLE UGOVOR_ZA_PRAVNO_LICE(ugovor_id VARCHAR(50) PRIMARY KEY,
                                   datum_potpisivanja DATE NOT NULL,
                                   datum_raskidanja DATE,
                                   pravno_lice_id INTEGER REFERENCES pravno_lice(pravno_lice_id));

CREATE TABLE KUPAC(kupac_id INTEGER PRIMARY KEY REFERENCES fizicko_lice(fizicko_lice_id),
                   broj_telefona VARCHAR(50));

CREATE TABLE UPOSLENIK(uposlenik_id INTEGER PRIMARY KEY REFERENCES fizicko_lice(fizicko_lice_id));


CREATE TABLE ODJEL(odjel_id INTEGER PRIMARY KEY,
                   sef_id INTEGER NOT NULL UNIQUE REFERENCES uposlenik(uposlenik_id),
                   naziv VARCHAR(50));

CREATE TABLE UGOVOR_ZA_UPOSLENIKA(ugovor_id VARCHAR(50) PRIMARY KEY,
                                  datum_zaposlenja DATE NOT NULL,
                                  plata INTEGER NOT NULL,
                                  broj_racuna VARCHAR(50) NOT NULL);

ALTER TABLE UPOSLENIK
ADD         (odjel_id INTEGER REFERENCES odjel(odjel_id),
             ugovor_id VARCHAR(50) NOT NULL UNIQUE REFERENCES ugovor_za_uposlenika(ugovor_id));

CREATE TABLE SKLADISTE(skladiste_id INTEGER PRIMARY KEY,
                       lokacija_id INTEGER NOT NULL UNIQUE REFERENCES lokacija(lokacija_id),
                       odgovorna_osoba_id INTEGER NOT NULL REFERENCES uposlenik(uposlenik_id),
                       naziv VARCHAR(50) NOT NULL);

CREATE TABLE KATEGORIJA(kategorija_id INTEGER PRIMARY KEY,
                        naziv VARCHAR(50) NOT NULL,
                        nadkategorija_id INTEGER REFERENCES kategorija(kategorija_id));

CREATE TABLE POPUST(popust_id INTEGER PRIMARY KEY,
                    postotak INTEGER NOT NULL);

CREATE TABLE PROIZVOD(proizvod_id INTEGER PRIMARY KEY,
                      naziv VARCHAR(50) NOT NULL,
                      cijena INTEGER NOT NULL,
                      kategorija_id INTEGER NOT NULL REFERENCES kategorija(kategorija_id),
                      popust_id INTEGER REFERENCES popust(popust_id),
                      proizvodjac_id INTEGER NOT NULL REFERENCES proizvodjac(proizvodjac_id));

CREATE TABLE KOLICINA(skladiste_id INTEGER NOT NULL REFERENCES skladiste(skladiste_id),
                      proizvod_id INTEGER NOT NULL REFERENCES proizvod(proizvod_id),
                      kolicina_proizvoda INTEGER);

CREATE TABLE GARANCIJA(garancija_id INTEGER PRIMARY KEY,
                      trajanje INTEGER NOT NULL);

ALTER TABLE PROIZVOD
ADD         (garancija_id INTEGER REFERENCES garancija(garancija_id));

CREATE TABLE NARUDZBA_PROIZVODA(narudzba_id INTEGER PRIMARY KEY,
                                proizvod_id INTEGER NOT NULL REFERENCES proizvod(proizvod_id),
                                kolicina_jednog_proizvoda INTEGER NOT NULL);

CREATE TABLE FAKTURA(faktura_id INTEGER PRIMARY KEY,
                     kupac_id INTEGER NOT NULL REFERENCES kupac(kupac_id),
                     iznos INTEGER NOT NULL,
                     datum_kupoprodaje DATE NOT NULL);

ALTER TABLE NARUDZBA_PROIZVODA
ADD         (faktura_id INTEGER NOT NULL REFERENCES faktura(faktura_id));

CREATE TABLE ISPORUKA(isporuka_id INTEGER PRIMARY KEY,
                      kurirska_sluzba_id INTEGER NOT NULL REFERENCES kurirska_sluzba(kurirska_sluzba_id));

ALTER TABLE FAKTURA
ADD         (isporuka_id INTEGER NOT NULL REFERENCES isporuka(isporuka_id));

ALTER TABLE GARANCIJA
ADD         (faktura_id INTEGER NOT NULL REFERENCES faktura(faktura_id));

ALTER TABLE GARANCIJA
DROP COLUMN faktura_id;

ALTER TABLE GARANCIJA
DROP COLUMN trajanje;

ALTER TABLE garancija
ADD         (narudzba_id INTEGER UNIQUE NOT NULL REFERENCES narudzba_proizvoda(narudzba_id));

ALTER TABLE proizvod
DROP COLUMN popust_id;

ALTER TABLE proizvod
DROP COLUMN garancija_id;

ALTER TABLE proizvod
ADD         (broj_mjeseci_garancije INTEGER);

ALTER TABLE narudzba_proizvoda
ADD         (popust_id INTEGER REFERENCES popust(popust_id));