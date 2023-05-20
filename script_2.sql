use critiques_de_film_saddek_touati;

#1) 
select count(*) nombre_film from film where producteur_id = 1 and annee_de_production between 1990 and 2000;

#2)
select distinct nom, prenom from film join producteur on(producteur.id=producteur_id) where couleur and genre_id=(select id from genre where nom = 'Science-Fiction');

#3) 
select titre, role from film join jouer on (film.id=film_id) join acteur on (acteur.id=acteur_id) where annee_de_production not between 2000 and 2010 and nom='Assidik' and prenom='Abu Bakre'; 
## on rajoute  order by film.id pour que les roles s'affiche successif

#4)
select texte, note from critiquer where year(date) = 2021 and film_id=(select id from film where titre='titre:  El Habachi - Azahraa Drame');

#5)
select titre, texte, nom_usager, concat(realisateur.nom, ' ', realisateur.prenom) nom_realisateur from film join realisateur on(realisateur.id=realisateur_id) left join critiquer on(film.id=film_id) left join usager on (usager.id=usager_id);

#6)
select count(*) nombre_de_critique, prenom, nom, couriel from critiquer join usager on(usager.id=usager_id) group by usager.id having nombre_de_critique > 2;

#7)
select (select max(note) from critiquer where film_id=film.id) note_maximale, titre, annee_de_production, concat(producteur.nom, ' ', producteur.prenom) nom_producteur, genre.nom from film join producteur on(producteur.id=producteur_id) join genre on (genre.id=genre_id);

#8)
select titre, count(*) nombre_note from film join critiquer on (film.id = film_id) join platforme on (platforme.id = platforme_id) where platforme.nom = 'Crave' group by film.id;

#9)
select titre, note_moyenne from film join genre on (genre.id = genre_id) join (select film_id, avg(note) note_moyenne, count(case when year(date)=2020 then 1 else null end) count_critique_2020 from critiquer group by film_id) critiquer on (film.id = film_id) where genre.nom = 'Science-Fiction' and count_critique_2020 >= 2 group by film.id;

#10)
select avg(note) moyenne_notes from critiquer join film on (film_id = film.id) join realisateur on(realisateur_id=realisateur.id) join usager on (usager_id=usager.id) where usager.nom = 'Guillaume' and usager.prenom = 'Harvey' and realisateur.nom = 'Steven' and realisateur.prenom = 'Spielberg';

