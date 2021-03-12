/*MLD : *Primary key(pk)* *foreign key(fk)*
utilisateur ( id(pk), nom, prenom, email, login, mdp, adresse, cp, ville)
villes ( id_ville (pk), nom_ville, code_postal )
cinemas ( id_cinema (pk), adresse, id_ville (fk), contact )
salles ( id_salle (pk), id_cinema (fk), nombre_sieges )
formats ( id_format (pk), nom_format )
salle_format ( id_salle (pk fk), id_format (pk fk) )
films ( id_film (pk), id_format (fk), titre_film, durée )
tarifs ( id_tarif (pk), nom_tarif, justificatif, prix )
seances ( id_seance (pk), id_cinema (fk), id_film (fk), id_salle (fk), date_seance, heure_debut_seance, heure_fin_seance )
reservations ( id_reservation (pk),id_user(fk), date_reservation, heure_reservation )
lignes_reservation ( id_reservation (pk fk), id_ligne (pk), id_seance (fk), id_tarif (fk), nombre_places, montant_ligne )*/


CREATE TABLE IF NOT EXISTS utilisateur(
     id varchar(5) PRIMARY KEY NOT NULL,
     nom varchar(255) DEFAULT NULL,
     prenom varchar(255) DEFAULT NULL,
     email varchar(255) DEFAULT NULL,
     login varchar(255) DEFAULT NULL,
     mdp varchar(255) DEFAULT NULL,
     adresse varchar(255) DEFAULT NULL,
     cp int(5) DEFAULT NULL,
     ville varchar(255) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS villes(
     id_ville varchar(5) PRIMARY KEY NOT NULL,
     nom_ville varchar(255) DEFAULT NULL,
     code_postal int(5) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS cinemas (
     id_cinema varchar(5) PRIMARY KEY NOT NULL,
     adresse varchar(255) DEFAULT NULL,
     id_ville varchar(5) NOT NULL,
     contact int(8) DEFAULT NULL,
     FOREIGN KEY(id_ville) REFERENCES villes(id_ville)
);

CREATE TABLE IF NOT EXISTS salles (
     id_salle varchar(5) PRIMARY KEY NOT NULL,
     id_cinema varchar(5) NOT NULL,
     nombre_sieges int(5) DEFAULT NULL,
     FOREIGN KEY(id_cinema) REFERENCES cinemas(id_cinema)
);

CREATE TABLE IF NOT EXISTS formats(
     id_format varchar(5) PRIMARY KEY NOT NULL,
     nom_format varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS salle_format (
     id_salle varchar(5)  NOT NULL,
     id_format varchar(5) NOT NULL,
     PRIMARY KEY(id_salle, id_format),
     FOREIGN KEY(id_salle) REFERENCES salles(id_salle),
     FOREIGN KEY(id_format) REFERENCES formats(id_format)
);

CREATE TABLE IF NOT EXISTS films (
     id_film varchar(5) PRIMARY KEY NOT NULL,
     id_format varchar(5) NOT NULL,
     titre_film varchar(255) DEFAULT NULL,
     duree decimal(2,2) DEFAULT NULL,
     FOREIGN KEY(id_format) REFERENCES formats(id_format)
);

CREATE TABLE IF NOT EXISTS tarifs (
     id_tarif varchar(5) PRIMARY KEY NOT NULL,
     nom_tarif varchar(255) DEFAULT NULL,
     justicatif varchar(255) DEFAULT NULL,
     prix decimal(10,2) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS seances (
     id_seance varchar(5) PRIMARY KEY NOT NULL,
     id_cinema varchar(5) NOT NULL,
     id_film varchar(5) NOT NULL,
     id_salle varchar(5) NOT NULL,
     date_seance date NOT NULL,
     heure_debut_seance time NOT NULL,
     heure_fin_seance time NOT NULL,
     FOREIGN KEY(id_cinema) REFERENCES cinemas(id_cinema),
     FOREIGN KEY(id_film) REFERENCES films(id_film),
     FOREIGN KEY(id_salle) REFERENCES salles(id_salle)
);

CREATE TABLE IF NOT EXISTS reservations (
     id_reservation int PRIMARY KEY NOT NULL AUTO_INCREMENT,
     id_user varchar(5) NOT NULL,
     date_reservation date NOT NULL,
     heure_reservation time NOT NULL,
     FOREIGN KEY(id_user) REFERENCES utilisateur(id)
);

CREATE TABLE IF NOT EXISTS ligne_reservation (
     id_ligne int NOT NULL AUTO_INCREMENT,
     id_reservation int NOT NULL,
     id_seance varchar(5) NOT NULL,
     id_tarif varchar(5) NOT NULL,
     nombre_places int DEFAULT NULL,
     montant_ligne decimal(5,2) DEFAULT NULL,
     PRIMARY KEY(id_ligne, id_reservation),
     FOREIGN KEY(id_reservation) REFERENCES reservations(id_reservation),
     FOREIGN KEY(id_seance) REFERENCES seances(id_seance),
     FOREIGN KEY(id_tarif) REFERENCES tarifs(id_tarif)
);