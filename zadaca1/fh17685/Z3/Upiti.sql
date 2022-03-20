--1
SELECT k.kolicina_proizvoda "Kolicina proizvoda",
       p.naziv "Proizvod",
       d.naziv "Drzava"
FROM drzava d, grad g,lokacija l, skladiste s, kolicina k, proizvod p
WHERE d.drzava_id = g.drzava_id
AND g.grad_id = l.grad_id
AND l.lokacija_id = s.lokacija_id
AND s.skladiste_id = k.skladiste_id
AND k.proizvod_id = p.proizvod_id;
--2
SELECT DISTINCT p.pravno_lice_id Id,
                p.naziv "Pravno lice"
FROM pravno_lice p,ugovor_za_pravno_lice u
WHERE p.pravno_lice_id = u.pravno_lice_id
AND To_Char(u.datum_potpisivanja,'YYYY') > '2014';
--3
SELECT DISTINCT p.naziv "Naziv proizvoda"
FROM proizvod p, narudzba_proizvoda n
WHERE p.proizvod_id = n.proizvod_id
AND p.broj_mjeseci_garancije = 12
AND n.popust_id IS NOT NULL;
--4
SELECT n.narudzba_id,
       p.postotak-Mod(17685, 100) "Postotak-85"
FROM Popust p, narudzba_proizvoda n
WHERE p.popust_id = n.popust_id
AND p.postotak > 20;
--5
SELECT f.ime || ' ' || f.prezime "Naziv lica",
       o.naziv "Naziv proizvoda"
FROM kupac k, fizicko_lice f, uposlenik u, odjel o
WHERE k.kupac_id = f.fizicko_lice_id
AND f.fizicko_lice_id = u.uposlenik_id
AND u.odjel_id = o.odjel_id;
--6
SELECT n.narudzba_id "Redni broj narudzbe",
       p.naziv "Naziv proizvoda",
       p.cijena "Cijena proizvoda",
       Nvl(s.postotak, 0) || '%' "Popust"
FROM narudzba_proizvoda n, proizvod p, popust s
WHERE n.popust_id = s.popust_id(+)
AND n.proizvod_id = p.proizvod_id;
--7
SELECT k.kategorija_id "Redni broj Kategorije",
       Decode (k.kategorija_id,
               1, 'Komp oprema',
               null, 'Nema Kategorije',
               k.naziv) "Naziv kategorije",
       Decode (k.nadkategorija_id,
               null, '-',
               k.nadkategorija_id) "Redni broj Nadkategorije",
       Decode (k.nadkategorija_id,
               1, 'Komp oprema',
               null, 'Nema Kategorije',
               n.naziv)"Naziv nadkategorije"
FROM kategorija k
Left OUTER JOIN  kategorija n
ON k.nadkategorija_id = n.kategorija_id;
--8
SELECT  p.ugovor_id "Sifra ugovora",
        Trunc(Months_Between(SYSDATE,p.datum_potpisivanja)/12) || ' goodina '
        || Trunc(Mod(Months_Between(SYSDATE,p.datum_potpisivanja), 12)) || ' mjeseci '
        || Round((Months_Between(SYSDATE,p.datum_potpisivanja)- Trunc(Months_Between(SYSDATE,p.datum_potpisivanja)))*CAST(to_char(LAST_DAY(sysdate),'dd') AS INT)) || ' dana'  "Od potpisivanja do danas"
FROM ugovor_za_pravno_lice p;
--Z9
SELECT f.ime "Ime",
       f.prezime "Prezime",
       Decode (o.naziv,
               'Management', 'Menadzment',
               'Human Resources', 'Upravljanje kadrovima',
               'Warehouse department','Magacinski odjel',
               'Marketing', 'Odjel za Marketing',
               'Service', 'Servisni odjel') "Naziv odjela"
FROM fizicko_lice f, uposlenik u, odjel o
WHERE f.fizicko_lice_id = u.uposlenik_id
AND u.odjel_id = o.odjel_id
ORDER BY f.ime ASC, f.prezime DESC;
--Z10
SELECT k.naziv "Kategorija",
       Max(p.cijena) "Najskuplji proizvod",
       Min(p.cijena) "Najjeftiniji proizvod"
FROM kategorija k, proizvod p
WHERE k.kategorija_id = p.kategorija_id(+)
GROUP BY k.naziv
ORDER BY (Max(p.cijena) + Min(p.cijena));