INSERT INTO kontinent (kontinent_id, naziv) VALUES (1,'Africa');
INSERT INTO kontinent (kontinent_id, naziv) VALUES (2,'Asia');
INSERT INTO kontinent (kontinent_id, naziv) VALUES (3,'Europe');
INSERT INTO kontinent (kontinent_id, naziv) VALUES (4,'North America');
INSERT INTO kontinent (kontinent_id, naziv) VALUES (5,'South America');
INSERT INTO kontinent (kontinent_id, naziv) VALUES (6,'Antarctica');
INSERT INTO kontinent (kontinent_id, naziv) VALUES (7,'Australia/Oceania');


INSERT INTO drzava (drzava_id, naziv, kontinent_id) VALUES (1,'Mexico',4);
INSERT INTO drzava (drzava_id, naziv, kontinent_id) VALUES (2,'Russia',2);
INSERT INTO drzava (drzava_id, naziv, kontinent_id) VALUES (3,'Ukraine',3);
INSERT INTO drzava (drzava_id, naziv, kontinent_id) VALUES (4,'China',2);
INSERT INTO drzava (drzava_id, naziv, kontinent_id) VALUES (5,'Portugal',3);
INSERT INTO drzava (drzava_id, naziv, kontinent_id) VALUES (6,'Brasil',5);
INSERT INTO drzava (drzava_id, naziv, kontinent_id) VALUES (7,'Nigeria',1);
INSERT INTO drzava (drzava_id, naziv, kontinent_id) VALUES (8,'Iran',2);
INSERT INTO drzava (drzava_id, naziv, kontinent_id) VALUES (9,'France',3);
INSERT INTO drzava (drzava_id, naziv, kontinent_id) VALUES (10,'Canada',4);


INSERT INTO grad (grad_id, naziv, drzava_id) VALUES (1,'Moscow',2);
INSERT INTO grad (grad_id, naziv, drzava_id) VALUES (2,'Saint Petersburg',2);
INSERT INTO grad (grad_id, naziv, drzava_id) VALUES (3,'Teheran',8);
INSERT INTO grad (grad_id, naziv, drzava_id) VALUES (4,'Paris',9);
INSERT INTO grad (grad_id, naziv, drzava_id) VALUES (5,'Marseille',9);
INSERT INTO grad (grad_id, naziv, drzava_id) VALUES (6,'Toronto',10);
INSERT INTO grad (grad_id, naziv, drzava_id) VALUES (7,'Lisbon',5);
INSERT INTO grad (grad_id, naziv, drzava_id) VALUES (8,'Shanghai',4);
INSERT INTO grad (grad_id, naziv, drzava_id) VALUES (9,'Beijing',4);
INSERT INTO grad (grad_id, naziv, drzava_id) VALUES (10,'Rio de Janeiro',6);

insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (1, 'Hintze', '4953', 4);
insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (2, 'Melrose', '1987', 7);
insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (3, 'Ilene', '61004', 1);
insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (4, 'Village Green', '70825', 10);
insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (5, 'Loftsgordon', '1793', 5);
insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (6, 'Mccormick', '82', 4);
insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (7, 'Crest Line', '702', 3);
insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (8, 'Heffernan', '8059', 4);
insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (9, 'Sunnyside', '2878', 10);
insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (10, 'Schmedeman', '7489', 9);
insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (11, 'Fisk', '08', 3);
insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (12, 'Milwaukee', '73759', 9);
insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (13, 'Gale', '80001', 5);
insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (14, 'Gale', '03', 6);
insert into lokacija (lokacija_id, naziv_ulice, broj, grad_id) values (15, 'Thackeray', '57689', 7);


insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (1, 'Demetris', 'Beyn', To_Date('11/01/1986', 'mm/dd/yyyy'), 4);
insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (2, 'Curcio', 'Bertram', To_Date('12/16/1991', 'mm/dd/yyyy'), 2);
insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (3, 'Ailina', 'Zanettini', To_Date('7/25/1995','mm/dd/yyyy'),15);
insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (4, 'Courtenay', 'Bootton', To_Date('11/8/1957','mm/dd/yyyy'), 6);
insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (5, 'Ethelbert', 'Le Quesne', To_Date('8/12/1998','mm/dd/yyyy'), 2);
insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (6, 'Lisha', 'Fer', To_Date('6/10/1949','mm/dd/yyyy'), 7);
insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (7, 'Franciskus', 'Holhouse', To_Date('1/5/1953','mm/dd/yyyy'), 12);
insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (8, 'Raimondo', 'Phripp', To_Date('5/13/1981','mm/dd/yyyy'), 2);
insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (9, 'Ginger', 'Pauncefort', To_Date('11/10/1950','mm/dd/yyyy'), 7);
insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (10, 'Myca', 'Spurman', To_Date('4/26/1958','mm/dd/yyyy'), 1);
insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (11, 'Irwinn', 'Densham', To_Date('1/2/1955','mm/dd/yyyy'), 13);
insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (12, 'Cally', 'Mannix', To_Date('3/20/1977','mm/dd/yyyy'), 9);
insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (13, 'Nissy', 'Dilger', To_Date('10/1/1993','mm/dd/yyyy'), 4);
insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (14, 'Zedekiah', 'De Mitris', To_Date('7/24/1960','mm/dd/yyyy'), 3);
insert into fizicko_lice (fizicko_lice_id, ime, prezime, datum_rodjenja, lokacija_id) values (15, 'Imelda', 'Lorinez', To_Date('1/22/1981','mm/dd/yyyy'), 13);

insert into kupac (kupac_id, broj_telefona) values (1, '638-408-1351');
insert into kupac (kupac_id, broj_telefona) values (2, '941-982-5478');
insert into kupac (kupac_id, broj_telefona) values (3, '809-262-7155');
insert into kupac (kupac_id, broj_telefona) values (4, '538-321-9473');
insert into kupac (kupac_id, broj_telefona) values (5, '566-351-9753');
insert into kupac (kupac_id, broj_telefona) values (6, '378-758-7651');
insert into kupac (kupac_id, broj_telefona) values (7, '202-664-6169');
insert into kupac (kupac_id, broj_telefona) values (8, '153-967-4410');
insert into kupac (kupac_id, broj_telefona) values (9, '632-598-5434');
insert into kupac (kupac_id, broj_telefona) values (10, '847-374-8003');

insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (1, 14, 'Linktype');
insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (2, 1, 'Topicstorm');
insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (3, 8, 'Teklist');
insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (4, 12, 'Realblab');
insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (5, 15, 'Voomm');
insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (6, 2, 'Katz');
insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (7, 13, 'Quire');
insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (8, 3, 'Shuffletag');
insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (9, 4, 'Voonder');
insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (10, 11, 'Vitz');
insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (11, 10, 'Jaloo');
insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (12, 7, 'Gigashots');
insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (13, 6, 'Yacero');
insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (14, 5, 'Snaptags');
insert into pravno_lice (pravno_lice_id, lokacija_id, naziv) values (15, 9, 'Aimbu');

insert into proizvodjac (proizvodjac_id, email) values (1, 'cdouthwaite0@google.de');
insert into proizvodjac (proizvodjac_id, email) values (2, 'ffavey1@twitter.com');
insert into proizvodjac (proizvodjac_id, email) values (3, 'egrimmolby2@desdev.cn');
insert into proizvodjac (proizvodjac_id, email) values (4, 'jcockland3@sohu.com');
insert into proizvodjac (proizvodjac_id, email) values (5, 'cmargram4@ning.com');
insert into proizvodjac (proizvodjac_id, email) values (6, 'tmcgreary5@lycos.com');
insert into proizvodjac (proizvodjac_id, email) values (7, 'hreoch6@columbia.edu');
insert into proizvodjac (proizvodjac_id, email) values (8, 'mbugg7@instagram.com');
insert into proizvodjac (proizvodjac_id, email) values (9, 'ufaustian8@cocolog-nifty.com');
insert into proizvodjac (proizvodjac_id, email) values (10, 'rmalin9@topsy.com');

insert into kurirska_sluzba (kurirska_sluzba_id, broj_telefona) values (11, '413-203-0203');
insert into kurirska_sluzba (kurirska_sluzba_id, broj_telefona) values (12, '715-357-4220');
insert into kurirska_sluzba (kurirska_sluzba_id, broj_telefona) values (13, '949-754-2289');
insert into kurirska_sluzba (kurirska_sluzba_id, broj_telefona) values (14, '836-476-7384');
insert into kurirska_sluzba (kurirska_sluzba_id, broj_telefona) values (15, '334-993-3933');

insert into ugovor_za_pravno_lice (ugovor_id, pravno_lice_id, datum_potpisivanja, datum_raskidanja) values ('86-085-7917', 3, To_Date('07/16/2014','mm/dd/yyyy'), To_Date('10/31/2016','mm/dd/yyyy'));
insert into ugovor_za_pravno_lice (ugovor_id, pravno_lice_id, datum_potpisivanja, datum_raskidanja) values ('17-106-3986', 14, To_Date('02/11/2015','mm/dd/yyyy'), To_Date('01/30/2016','mm/dd/yyyy'));
insert into ugovor_za_pravno_lice (ugovor_id, pravno_lice_id, datum_potpisivanja, datum_raskidanja) values ('15-996-6847', 5, To_Date('04/04/2001','mm/dd/yyyy'), To_Date('12/24/2010','mm/dd/yyyy'));
insert into ugovor_za_pravno_lice (ugovor_id, pravno_lice_id, datum_potpisivanja, datum_raskidanja) values ('00-247-6677', 3, To_Date('11/04/2012','mm/dd/yyyy'), null);
insert into ugovor_za_pravno_lice (ugovor_id, pravno_lice_id, datum_potpisivanja, datum_raskidanja) values ('78-587-3511', 5, To_Date('01/20/2016','mm/dd/yyyy'), To_Date('12/01/2018','mm/dd/yyyy'));
insert into ugovor_za_pravno_lice (ugovor_id, pravno_lice_id, datum_potpisivanja, datum_raskidanja) values ('08-185-9343', 5, To_Date('04/04/2001','mm/dd/yyyy'), To_Date('12/24/2010','mm/dd/yyyy'));
insert into ugovor_za_pravno_lice (ugovor_id, pravno_lice_id, datum_potpisivanja, datum_raskidanja) values ('03-721-0001', 14, To_Date('10/10/2015','mm/dd/yyyy'), null);
insert into ugovor_za_pravno_lice (ugovor_id, pravno_lice_id, datum_potpisivanja, datum_raskidanja) values ('41-943-0882', 13, To_Date('03/16/2008','mm/dd/yyyy'), To_Date('05/30/2010','mm/dd/yyyy'));
insert into ugovor_za_pravno_lice (ugovor_id, pravno_lice_id, datum_potpisivanja, datum_raskidanja) values ('77-106-0021', 5, To_Date('01/01/2012','mm/dd/yyyy'), To_Date('02/02/2013','mm/dd/yyyy'));
insert into ugovor_za_pravno_lice (ugovor_id, pravno_lice_id, datum_potpisivanja, datum_raskidanja) values ('44-281-5627', 14, To_Date('08/08/2015','mm/dd/yyyy'), null);

insert into kategorija (kategorija_id, naziv, nadkategorija_id) values (1, 'Computer equipment', null);
insert into kategorija (kategorija_id, naziv, nadkategorija_id) values (2, 'Monitor', 1);
insert into kategorija (kategorija_id, naziv, nadkategorija_id) values (3, 'Keyboard', 1);
insert into kategorija (kategorija_id, naziv, nadkategorija_id) values (4, 'Mouse', 1);
insert into kategorija (kategorija_id, naziv, nadkategorija_id) values (5, 'Card', 1);
insert into kategorija (kategorija_id, naziv, nadkategorija_id) values (6, 'CD', 1);
insert into kategorija (kategorija_id, naziv, nadkategorija_id) values (7, 'Printer', 1);
insert into kategorija (kategorija_id, naziv, nadkategorija_id) values (8, 'Headset', 1);

insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (1, 'CD-R', 10, 6, 5, NULL);
insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (2, 'CD-RW', 15, 6, 5, NULL);
insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (3, 'LED monitor', 581, 2, 6, 12);
insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (4, 'LCD', 481, 2, 8, 12);
insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (5, 'Ergonomic keyboard', 339, 3, 7, 6);
insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (6, 'Wireless keyboard', 539, 3, 8, 6);
insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (7, 'Sound card', 163, 6, 6, 10);
insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (8, 'Graphics card', 213, 6, 9, 10);
insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (9, 'Wireless mouse', 86, 4, 7, 6);
insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (10, 'Optical mouse', 123, 4, 6, 6);
insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (11, 'Laser mouse', 254, 4, 2, 6);
insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (12, 'CPU', 779, 1, 5, 24);
insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (13, 'Laser printer', 651, 7, 5, 12);
insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (14, 'Inkjet printer', 431, 7, 3, 12);
insert into proizvod (proizvod_id, naziv, cijena, kategorija_id, proizvodjac_id, broj_mjeseci_garancije) values (15, 'Network card', 293, 5, 2, 6);
COMMIT;

UPDATE proizvod SET kategorija_id = 5 WHERE proizvod_id = 8;
COMMIT;

insert into isporuka (isporuka_id, kurirska_sluzba_id) values (1, 11);
insert into isporuka (isporuka_id, kurirska_sluzba_id) values (2, 11);
insert into isporuka (isporuka_id, kurirska_sluzba_id) values (3, 13);
insert into isporuka (isporuka_id, kurirska_sluzba_id) values (4, 12);
insert into isporuka (isporuka_id, kurirska_sluzba_id) values (5, 13);
insert into isporuka (isporuka_id, kurirska_sluzba_id) values (6, 13);
insert into isporuka (isporuka_id, kurirska_sluzba_id) values (7, 15);
insert into isporuka (isporuka_id, kurirska_sluzba_id) values (8, 14);
insert into isporuka (isporuka_id, kurirska_sluzba_id) values (9, 14);
insert into isporuka (isporuka_id, kurirska_sluzba_id) values (10, 12);

insert into faktura (faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id) values (1, 2, 248, To_Date('07/07/2018','mm/dd/yyyy'), 4);
insert into faktura (faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id) values (2, 1, 955, To_Date('04/03/2015','mm/dd/yyyy'), 7);
insert into faktura (faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id) values (3, 7, 449, To_Date('01/12/2003','mm/dd/yyyy'), 5);
insert into faktura (faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id) values (4, 6, 137, To_Date('09/22/2016','mm/dd/yyyy'), 3);
insert into faktura (faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id) values (5, 10, 496, To_Date('03/29/2016','mm/dd/yyyy'), 3);
insert into faktura (faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id) values (6, 5, 597, To_Date('08/27/2012','mm/dd/yyyy'), 6);
insert into faktura (faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id) values (7, 6, 940, To_Date('12/17/2013','mm/dd/yyyy'), 1);
insert into faktura (faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id) values (8, 7, 37, To_Date('09/06/2013','mm/dd/yyyy'), 1);
insert into faktura (faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id) values (9, 1, 245, To_Date('11/24/2002','mm/dd/yyyy'), 6);
insert into faktura (faktura_id, kupac_id, iznos, datum_kupoprodaje, isporuka_id) values (10, 9, 206, To_Date('05/13/2010','mm/dd/yyyy'), 3);

insert into popust (popust_id, postotak) values (1, 10);
insert into popust (popust_id, postotak) values (2, 20);
insert into popust (popust_id, postotak) values (3, 30);
insert into popust (popust_id, postotak) values (4, 40);
insert into popust (popust_id, postotak) values (5, 50);
insert into popust (popust_id, postotak) values (6, 60);
insert into popust (popust_id, postotak) values (7, 70);

insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (1, 14, 3, 10, 4);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (2, 14, 2, 6, 5);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (3, 12, 2, 4, null);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (4, 3, 4, 4, null);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (5, 7, 5, 1, 5);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (6, 10, 3, 9, null);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (7, 3, 4, 10, 6);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (8, 6, 4, 7, null);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (9, 1, 3, 5, 6);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (10, 3, 5, 10, 6);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (11, 6, 1, 3, 4);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (12, 15, 3, 10, null);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (13, 8, 2, 10, null);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (14, 7, 1, 10, 5);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (15, 9, 4, 9, 6);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (16, 12, 1, 8, 7);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (17, 9, 3, 1, 3);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (18, 9, 4, 8, 5);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (19, 10, 1, 3, null);
insert into narudzba_proizvoda (narudzba_id, proizvod_id, kolicina_jednog_proizvoda, faktura_id, popust_id) values (20, 5, 2, 5, 1);

insert into garancija (garancija_id, narudzba_id) values (1, 12);
insert into garancija (garancija_id, narudzba_id) values (2, 19);
insert into garancija (garancija_id, narudzba_id) values (3, 6);
insert into garancija (garancija_id, narudzba_id) values (4, 7);
insert into garancija (garancija_id, narudzba_id) values (5, 3);
insert into garancija (garancija_id, narudzba_id) values (6, 8);
insert into garancija (garancija_id, narudzba_id) values (7, 4);
insert into garancija (garancija_id, narudzba_id) values (8, 11);
insert into garancija (garancija_id, narudzba_id) values (9, 2);
insert into garancija (garancija_id, narudzba_id) values (10, 18);
insert into garancija (garancija_id, narudzba_id) values (11, 10);
insert into garancija (garancija_id, narudzba_id) values (12, 15);
insert into garancija (garancija_id, narudzba_id) values (13, 13);


insert into ugovor_za_uposlenika (ugovor_id, datum_zaposlenja, plata, broj_racuna) values ('62-884-0838', To_Date('08/08/2012','mm/dd/yyyy'), 1293, '5273715644');
insert into ugovor_za_uposlenika (ugovor_id, datum_zaposlenja, plata, broj_racuna) values ('00-840-3656', To_Date('07/12/2011','mm/dd/yyyy'), 785, '9212670725');
insert into ugovor_za_uposlenika (ugovor_id, datum_zaposlenja, plata, broj_racuna) values ('45-266-2854', To_Date('10/19/2002','mm/dd/yyyy'), 1210, '5402165734');
insert into ugovor_za_uposlenika (ugovor_id, datum_zaposlenja, plata, broj_racuna) values ('56-028-2089', To_Date('08/08/2009','mm/dd/yyyy'), 1438, '3274092223');
insert into ugovor_za_uposlenika (ugovor_id, datum_zaposlenja, plata, broj_racuna) values ('87-934-9777', To_Date('07/12/2007','mm/dd/yyyy'), 927, '3237515345');
insert into ugovor_za_uposlenika (ugovor_id, datum_zaposlenja, plata, broj_racuna) values ('84-010-0154', To_Date('08/15/2012','mm/dd/yyyy'), 553, '5105944747');
insert into ugovor_za_uposlenika (ugovor_id, datum_zaposlenja, plata, broj_racuna) values ('39-678-2809', To_Date('08/03/2015','mm/dd/yyyy'), 984, '0035521201');
insert into ugovor_za_uposlenika (ugovor_id, datum_zaposlenja, plata, broj_racuna) values ('47-806-9972', To_Date('05/04/2011','mm/dd/yyyy'), 609, '5192266300');
insert into ugovor_za_uposlenika (ugovor_id, datum_zaposlenja, plata, broj_racuna) values ('07-374-9514', To_Date('09/02/2018','mm/dd/yyyy'), 535, '0926524836');
insert into ugovor_za_uposlenika (ugovor_id, datum_zaposlenja, plata, broj_racuna) values ('58-607-3136', To_Date('09/04/2006','mm/dd/yyyy'), 547, '6701785085');
COMMIT;

ALTER TABLE uposlenik
DROP COLUMN odjel_id;

insert into uposlenik (uposlenik_id, ugovor_id) values (1, '62-884-0838');
insert into uposlenik (uposlenik_id, ugovor_id) values (2, '00-840-3656');
insert into uposlenik (uposlenik_id, ugovor_id) values (3, '45-266-2854');
insert into uposlenik (uposlenik_id, ugovor_id) values (4, '56-028-2089');
insert into uposlenik (uposlenik_id, ugovor_id) values (5, '87-934-9777');
insert into uposlenik (uposlenik_id, ugovor_id) values (6, '84-010-0154');
insert into uposlenik (uposlenik_id, ugovor_id) values (7, '39-678-2809');
insert into uposlenik (uposlenik_id, ugovor_id) values (8, '47-806-9972');
insert into uposlenik (uposlenik_id, ugovor_id) values (9, '07-374-9514');
insert into uposlenik (uposlenik_id, ugovor_id) values (10, '58-607-3136');

insert into odjel (odjel_id, sef_id, naziv) values (1, 1, 'Management');
insert into odjel (odjel_id, sef_id, naziv) values (2, 6, 'Human Resources');
insert into odjel (odjel_id, sef_id, naziv) values (3, 7, 'Warehouse department');
insert into odjel (odjel_id, sef_id, naziv) values (4, 8, 'Marketing');
insert into odjel (odjel_id, sef_id, naziv) values (5, 9, 'Service');
COMMIT;

ALTER TABLE uposlenik
ADD         (odjel_id INTEGER REFERENCES odjel(odjel_id));

UPDATE uposlenik SET odjel_id = 1 WHERE uposlenik_id = 1;
UPDATE uposlenik SET odjel_id = 1 WHERE uposlenik_id = 2;
UPDATE uposlenik SET odjel_id = 2 WHERE uposlenik_id = 3;
UPDATE uposlenik SET odjel_id = 5 WHERE uposlenik_id = 4;
UPDATE uposlenik SET odjel_id = 4 WHERE uposlenik_id = 5;
UPDATE uposlenik SET odjel_id = 2 WHERE uposlenik_id = 6;
UPDATE uposlenik SET odjel_id = 3 WHERE uposlenik_id = 7;
UPDATE uposlenik SET odjel_id = 3 WHERE uposlenik_id = 8;
UPDATE uposlenik SET odjel_id = 5 WHERE uposlenik_id = 9;
UPDATE uposlenik SET odjel_id = 4 WHERE uposlenik_id = 10;
COMMIT;

ALTER TABLE uposlenik
MODIFY      (odjel_id INTEGER NOT NULL);

insert into skladiste (skladiste_id, lokacija_id, odgovorna_osoba_id, naziv) values (1, 1, 9, 'Ambev S.A.');
insert into skladiste (skladiste_id, lokacija_id, odgovorna_osoba_id, naziv) values (2, 2, 9, 'Virtus Global Multi-Sector Income Fund');
insert into skladiste (skladiste_id, lokacija_id, odgovorna_osoba_id, naziv) values (3, 3, 2, 'Medical Properties Trust, Inc.');
insert into skladiste (skladiste_id, lokacija_id, odgovorna_osoba_id, naziv) values (4, 4, 5, 'Georgia Power Company');
insert into skladiste (skladiste_id, lokacija_id, odgovorna_osoba_id, naziv) values (5, 5, 6, 'Navios Maritime Holdings Inc.');
insert into skladiste (skladiste_id, lokacija_id, odgovorna_osoba_id, naziv) values (6, 6, 4, 'Nu Skin Enterprises, Inc.');
insert into skladiste (skladiste_id, lokacija_id, odgovorna_osoba_id, naziv) values (7, 7, 7, 'UroGen Pharma Ltd.');
insert into skladiste (skladiste_id, lokacija_id, odgovorna_osoba_id, naziv) values (8, 8, 10, 'OncoGenex Pharmaceuticals Inc.');
insert into skladiste (skladiste_id, lokacija_id, odgovorna_osoba_id, naziv) values (9, 9, 1, 'AbbVie Inc.');
insert into skladiste (skladiste_id, lokacija_id, odgovorna_osoba_id, naziv) values (10, 10, 9, 'The Bon-Ton Stores, Inc.');

insert into kolicina (skladiste_id, proizvod_id, kolicina_proizvoda) values (1, 6, 17);
insert into kolicina (skladiste_id, proizvod_id, kolicina_proizvoda) values (2, 3, 26);
insert into kolicina (skladiste_id, proizvod_id, kolicina_proizvoda) values (3, 1, 56);
insert into kolicina (skladiste_id, proizvod_id, kolicina_proizvoda) values (4, 6, 71);
insert into kolicina (skladiste_id, proizvod_id, kolicina_proizvoda) values (5, 14, 54);
insert into kolicina (skladiste_id, proizvod_id, kolicina_proizvoda) values (6, 14, 7);
insert into kolicina (skladiste_id, proizvod_id, kolicina_proizvoda) values (7, 7, 59);
insert into kolicina (skladiste_id, proizvod_id, kolicina_proizvoda) values (8, 1, 46);
insert into kolicina (skladiste_id, proizvod_id, kolicina_proizvoda) values (9, 2, 78);
insert into kolicina (skladiste_id, proizvod_id, kolicina_proizvoda) values (10, 15, 5);
COMMIT;