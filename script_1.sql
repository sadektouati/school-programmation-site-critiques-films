drop database critiques_de_film_saddek_touati;

create database critiques_de_film_saddek_touati;

use critiques_de_film_saddek_touati;

set names utf8;

CREATE TABLE genre (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE realisateur (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE producteur (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE film (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  titre VARCHAR(100) NOT NULL,
  annee_de_production INT NOT NULL,
  synopsis_court VARCHAR(200) NOT NULL,
  duree INT NOT NULL,
  genre_id INT UNSIGNED NOT NULL,
  realisateur_id INT UNSIGNED NOT NULL,
  producteur_id INT UNSIGNED NOT NULL,
  couleur boolean not null default false,
  PRIMARY KEY (id)
);


CREATE TABLE acteur (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE usager (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  nom_usager VARCHAR(50) NOT NULL UNIQUE,
  couriel VARCHAR(100) NOT NULL UNIQUE,
  mot_de_passe VARCHAR(100) NOT NULL,
  film_favorit_id INT UNSIGNED NULL,
  PRIMARY KEY (id)
);


CREATE TABLE platforme (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE jouer (
  role VARCHAR(100) NOT NULL,
  film_id INT UNSIGNED NOT NULL,
  acteur_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (film_id, acteur_id, role) ##role n'est pas sensible a la casse
);


CREATE TABLE critiquer (
  texte VARCHAR(500) NOT NULL,
  date DATETIME NOT NULL,
  note tinyint NOT NULL,
  platforme_id INT UNSIGNED NULL,
  film_id INT UNSIGNED NOT NULL,
  usager_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (film_id, usager_id)
);


ALTER TABLE film ADD CONSTRAINT FOREIGN KEY (genre_id) REFERENCES GENRE (id);
ALTER TABLE film ADD CONSTRAINT FOREIGN KEY (realisateur_id) REFERENCES realisateur (id);
ALTER TABLE film ADD CONSTRAINT FOREIGN KEY (producteur_id) REFERENCES producteur (id);

ALTER TABLE usager ADD CONSTRAINT FOREIGN KEY (film_favorit_id) REFERENCES film (id);

ALTER TABLE jouer ADD CONSTRAINT FOREIGN KEY (film_id) REFERENCES film (id);
ALTER TABLE jouer ADD CONSTRAINT FOREIGN KEY (acteur_id) REFERENCES acteur (id);

ALTER TABLE critiquer ADD CONSTRAINT FOREIGN KEY (platforme_id) REFERENCES platforme (id);
ALTER TABLE critiquer ADD CONSTRAINT FOREIGN KEY (film_id) REFERENCES film (id);
ALTER TABLE critiquer ADD CONSTRAINT FOREIGN KEY (usager_id) REFERENCES usager (id);


INSERT INTO genre (nom) values ('Science-Fiction'), ('Drame'), ('Horreur');
INSERT INTO platforme(nom) values ('Blu-Ray'), ('DVD'), ('Netflix'), ('Crave');
INSERT INTO producteur(nom, prenom) values ('Ibn Afane', 'Othmane'), ('Ben Abi Taleb', 'Ali'), ('Azahraa', 'Fatima');
INSERT INTO realisateur(nom, prenom) values ('Touati', 'Saddek'), ('Ben Abdo Allah', 'Mohammed'), ('El Habachi', 'Bilal');
INSERT INTO acteur(nom, prenom) values ('Abou Zakaria', 'Abd Allah'), ('Assidik', 'Abu Bakre'), ('El Khatab', 'Omar');


INSERT INTO film(titre, annee_de_production, synopsis_court, duree, genre_id, realisateur_id, producteur_id, couleur)
select CONCAT('titre: ', ' ', realisateur.nom, ' - ', producteur.nom, ' ', genre.nom) as titre, ceil(rand()*42)+1980 as annee_de_production, CONCAT('synopsis: ', ' ', realisateur.nom, ' - ', producteur.nom ) as synopsis_court, ceil(rand()*60)+30 as duree, genre.id, realisateur.id, producteur.id, (round(rand()) = 1) as couleur from producteur cross join realisateur cross join genre;

INSERT INTO jouer(role, film_id, acteur_id)
select CONCAT('role: ', ' ', acteur.nom, ' - ', film.titre) role, film.id, acteur.id from acteur cross join film;

INSERT INTO usager(nom, prenom, nom_usager, couriel, mot_de_passe, film_favorit_id)
select 'Binto Khowailid', 'Khadidja', 'Khadidja', 'khadidja@email.com', 'mot_de_passe', null as film_favorit_id;

INSERT INTO usager(nom, prenom, nom_usager, couriel, mot_de_passe, film_favorit_id)
select 'Binto Abubakr', 'Aicha', 'Aicha', 'aicha@email.com', 'mot_de_passe', id from film order by rand() limit 1;
INSERT INTO usager(nom, prenom, nom_usager, couriel, mot_de_passe, film_favorit_id)
select 'Ben Ali', 'El Hassen', 'El Hassen', 'el_hassen@email.com', 'mot_de_passe', id from film order by rand() limit 1;

INSERT INTO critiquer(texte, date, note, film_id, usager_id, platforme_id)
select CONCAT('text: ', ' ', usager.nom_usager, ' - ', film.titre ) as text, now() - INTERVAL FLOOR( RAND( ) * 366) DAY annee_de_production, floor(rand()*6) note, film.id, usager.id, (select id from platforme order by rand() limit 1) from usager cross join film;


