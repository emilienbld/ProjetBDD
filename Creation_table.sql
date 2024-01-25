CREATE DATABASE IF NOT EXISTS `jeu_mmo` 
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `jeu_mmo`;

CREATE TABLE Joueur (
    ID_joueur INT PRIMARY KEY,
    nom VARCHAR(255),
    niveau INT,
    HP_joueur INT,
    stamina_joueur INT,
    XP_joueur INT,
    gold INT,
    ID_guilde INT,
    ID_inventaire INT,
    FOREIGN KEY (ID_guilde) REFERENCES Guilde(ID_guilde),
    FOREIGN KEY (ID_inventaire) REFERENCES Inventaire(ID_inventaire)
);

CREATE TABLE AvoirQuete (
    ID_quete INT,
    ID_joueur INT,
    date_debut DATE,
    date_fin DATE,
    PRIMARY KEY (ID_quete,ID_joueur),
    FOREIGN KEY (ID_joueur) REFERENCES Joueur(ID_joueur),
    FOREIGN KEY (ID_quete) REFERENCES Quete(ID_quete)
);

CREATE TABLE Quete (
    ID_quete INT PRIMARY KEY,
    nom_quete VARCHAR(255),
    statut_quete VARCHAR(50),
    recompense VARCHAR(255)
);

CREATE TABLE Guilde (
    ID_guilde INT PRIMARY KEY,
    nom_guilde VARCHAR(255),
    XP_guilde INT
);

CREATE TABLE Inventaire (
    ID_inventaire INT PRIMARY KEY,
    objet VARCHAR(255),
    poids_max INT,
    poids INT
);

CREATE TABLE AppartenirEquipement (
    ID_inventaire INT,
    ID_equipement INT,
    PRIMARY KEY (ID_inventaire, ID_equipement),
    FOREIGN KEY (ID_inventaire) REFERENCES Inventaire(ID_inventaire),
    FOREIGN KEY (ID_equipement) REFERENCES Equipement(ID_equipement)
);

CREATE TABLE Monstre (
    ID_monstre INT PRIMARY KEY,
    nom_monstre VARCHAR(255),
    lvl_monstre INT,
    HP_monstre INT,
    pointXP INT
);

CREATE TABLE CombattreMonstre (
    ID_joueur INT,
    ID_monstre INT,
    PRIMARY KEY (ID_joueur, ID_monstre),
    FOREIGN KEY (ID_joueur) REFERENCES Joueur(ID_joueur),
    FOREIGN KEY (ID_monstre) REFERENCES Monstre(ID_monstre)
);

CREATE TABLE Equipement (
    ID_equipement INT PRIMARY KEY,
    type_equipement VARCHAR(50),
    poids INT
);

ALTER TABLE joueur ADD FOREIGN KEY (ID_guilde) REFERENCES Guilde(ID_guilde);
ALTER TABLE joueur ADD FOREIGN KEY (ID_inventaire) REFERENCES Inventaire(ID_inventaire);
ALTER TABLE avoirquete ADD FOREIGN KEY (ID_joueur) REFERENCES Joueur(ID_joueur);
ALTER TABLE avoirquete ADD FOREIGN KEY (ID_quete) REFERENCES Quete(ID_quete);
ALTER TABLE appartenirequipement ADD FOREIGN KEY (ID_inventaire) REFERENCES Inventaire(ID_inventaire);
ALTER TABLE appartenirequipement ADD FOREIGN KEY (ID_equipement) REFERENCES Equipement(ID_equipement);
ALTER TABLE combattremonstre ADD FOREIGN KEY (ID_joueur) REFERENCES Joueur(ID_joueur);
ALTER TABLE combattremonstre ADD FOREIGN KEY (ID_monstre) REFERENCES Monstre(ID_monstre);

-- Insertion dans la table `guilde`
INSERT INTO guilde (ID_guilde, nom_guilde, XP_guilde)
VALUES
  (1, 'Les Aventuriers', 1000),
  (2, 'Gardiens de la Nuit', 750),
  (3, 'L''Ordre des Braves', 1200);

-- Insertion dans la table `inventaire`
INSERT INTO inventaire (ID_inventaire, objet, poids_max, poids)
VALUES
  (1, 'Sac à dos', 50, 10),
  (2, 'Coffre magique', 100, 30),
  (3, 'Pochette de gemmes', 20, 5);

-- Insertion dans la table `equipement`
INSERT INTO equipement (ID_equipement, type_equipement, poids)
VALUES
  (1, 'Épée en fer', 8),
  (2, 'Arc en bois', 5),
  (3, 'Armure légère', 15);

-- Insertion dans la table `joueur`
INSERT INTO joueur (ID_joueur, nom, niveau, HP_joueur, stamina_joueur, XP_joueur, gold, ID_guilde, ID_inventaire)
VALUES
  (1, 'Aragorn', 10, 100, 80, 500, 1000, 1, 1),
  (2, 'Legolas', 8, 80, 90, 400, 800, 1, 2),
  (3, 'Gimli', 7, 90, 70, 350, 600, 2, 3);

-- Insertion dans la table `monstre`
INSERT INTO monstre (ID_monstre, nom_monstre, lvl_monstre, HP_monstre, pointXP)
VALUES
  (1, 'Dragon de feu', 15, 200, 500),
  (2, 'Gobelin des cavernes', 5, 50, 100),
  (3, 'Sorcier noir', 12, 120, 300);

-- Insertion dans la table `quete`
INSERT INTO quete (ID_quete, nom_quete, statut_quete, recompense)
VALUES
  (1, 'La quête du trésor perdu', 'En cours', 'Épée légendaire'),
  (2, 'Chasse aux monstres', 'Terminée', 'Sac d'or'),
  (3, 'Sauver la princesse', 'En cours', 'Armure enchantée');


-- Insertion dans la table `appartenirequipement`
INSERT INTO appartenirequipement (ID_inventaire, ID_equipement)
VALUES
  (1, 1), (1, 2), (1, 3),
  (2, 1), (2, 3),
  (3, 2), (3, 3),
  (4, 1), (4, 2),
  (5, 3);

-- Insertion dans la table `avoirquete`
INSERT INTO avoirquete (ID_quete, ID_joueur, date_debut, date_fin)
VALUES
  (1, 1, '2024-01-24', NULL),
  (2, 2, '2024-01-23', '2024-01-25'),
  (3, 3, '2024-01-22', NULL),
  (1, 4, '2024-01-24', NULL),
  (2, 5, '2024-01-23', '2024-01-25'),
  (3, 6, '2024-01-22', NULL),
  (1, 7, '2024-01-24', NULL),
  (2, 8, '2024-01-23', '2024-01-25'),
  (3, 9, '2024-01-22', NULL);

-- Insertion dans la table `combattremonstre`
INSERT INTO combattremonstre (ID_joueur, ID_monstre)
VALUES
  (1, 1), (1, 2), (1, 3),
  (2, 1), (2, 2),
  (3, 2), (3, 3),
  (4, 1),
  (5, 3),
  (6, 1),
  (7, 2),
  (8, 3),
  (9, 1), (9, 2), (9, 3);

-- Insertion dans la table `equipement`
INSERT INTO equipement (ID_equipement, type_equipement, poids)
VALUES
  (4, 'Bouclier en bois', 12),
  (5, 'Bâton magique', 6),
  (6, 'Casque en fer', 9);

-- Insertion dans la table `guilde`
INSERT INTO guilde (ID_guilde, nom_guilde, XP_guilde)
VALUES
  (4, 'Les Explorateurs', 800),
  (5, 'Les Chasseurs de Trésor', 1100),
  (6, 'L'Ordre des Sages', 950);

-- Insertion dans la table `inventaire`
INSERT INTO inventaire (ID_inventaire, objet, poids_max, poids)
VALUES
  (4, 'Sac de cuir', 40, 15),
  (5, 'Coffre en fer', 120, 40),
  (6, 'Potion de soin', 5, 2);

-- Insertion dans la table `joueur`
INSERT INTO joueur (ID_joueur, nom, niveau, HP_joueur, stamina_joueur, XP_joueur, gold, ID_guilde, ID_inventaire)
VALUES
  (4, 'Frodon', 6, 70, 60, 300, 500, 4, 4),
  (5, 'Arwen', 9, 90, 80, 450, 700, 5, 5),
  (6, 'Elrond', 12, 120, 100, 700, 900, 6, 6),
  (7, 'Bilbo', 4, 50, 40, 200, 300, 4, 7),
  (8, 'Galadriel', 11, 110, 90, 600, 800, 5, 8),
  (9, 'Gandalf', 14, 150, 120, 900, 1200, 6, 9);

-- Insertion dans la table `monstre`
INSERT INTO monstre (ID_monstre, nom_monstre, lvl_monstre, HP_monstre, pointXP)
VALUES
  (4, 'Loup affamé', 6, 80, 150),
  (5, 'Ogre des montagnes', 10, 120, 250),
  (6, 'Banshee des ténèbres', 14, 180, 400);

-- Insertion dans la table `quete`
INSERT INTO quete (ID_quete, nom_quete, statut_quete, recompense)
VALUES
  (4, 'Exploration des grottes', 'En cours', 'Cristal magique'),
  (5, 'Chasse au trésor perdu', 'Terminée', 'Coffre mystérieux'),
  (6, 'Rituel des anciens', 'En cours', 'Livre des sorts');

-- Insertion dans la table `appartenirequipement`
INSERT INTO appartenirequipement (ID_inventaire, ID_equipement)
VALUES
  (1, 1), (1, 2), (1, 3),
  (2, 2), (2, 3),
  (3, 1), (3, 3),
  (4, 1), (4, 2),
  (5, 3), (5, 4),
  (6, 4);

-- Insertion dans la table `avoirquete`
INSERT INTO avoirquete (ID_quete, ID_joueur, date_debut, date_fin)
VALUES
  (1, 1, '2024-01-24', NULL),
  (2, 2, '2024-01-23', '2024-01-25'),
  (3, 3, '2024-01-22', NULL),
  (1, 4, '2024-01-24', NULL),
  (2, 5, '2024-01-23', '2024-01-25'),
  (3, 6, '2024-01-22', NULL),
  (1, 7, '2024-01-24', NULL),
  (2, 8, '2024-01-23', '2024-01-25'),
  (3, 9, '2024-01-22', NULL),
  (4, 10, '2024-01-25', NULL),
  (5, 11, '2024-01-24', '2024-01-26'),
  (6, 12, '2024-01-23', NULL);

-- Insertion dans la table `combattremonstre`
INSERT INTO combattremonstre (ID_joueur, ID_monstre)
VALUES
  (1, 1), (1, 2), (1, 3),
  (2, 1), (2, 2),
  (3, 2), (3, 3),
  (4, 1),
  (5, 3),
  (6, 1),
  (7, 2),
  (8, 3),
  (9, 1), (9, 2), (9, 3),
  (10, 4),
  (11, 5),
  (12, 6);

-- Insertion dans la table `equipement`
INSERT INTO equipement (ID_equipement, type_equipement, poids)
VALUES
  (4, 'Bouclier en bois', 12),
  (5, 'Bâton magique', 6),
  (6, 'Casque en fer', 9);

-- Insertion dans la table `guilde`
INSERT INTO guilde (ID_guilde, nom_guilde, XP_guilde)
VALUES
  (4, 'Les Explorateurs', 800),
  (5, 'Les Chasseurs de Trésor', 1100),
  (6, 'L''Ordre des Sages', 950);

-- Insertion dans la table `inventaire`
INSERT INTO inventaire (ID_inventaire, objet, poids_max, poids)
VALUES
  (4, 'Sac de cuir', 40, 15),
  (5, 'Coffre en fer', 120, 40),
  (6, 'Potion de soin', 5, 2);

-- Insertion dans la table `joueur`
INSERT INTO joueur (ID_joueur, nom, niveau, HP_joueur, stamina_joueur, XP_joueur, gold, ID_guilde, ID_inventaire)
VALUES
  (4, 'Frodon', 6, 70, 60, 300, 500, 4, 4),
  (5, 'Arwen', 9, 90, 80, 450, 700, 5, 5),
  (6, 'Elrond', 12, 120, 100, 700, 900, 6, 6),
  (7, 'Bilbo', 4, 50, 40, 200, 300, 4, 7),
  (8, 'Galadriel', 11, 110, 90, 600, 800, 5, 8),
  (9, 'Gandalf', 14, 150, 120, 900, 1200, 6, 9),
  (10, 'Aragog', 8, 80, 70, 400, 600, 4, 10),
  (11, 'Luthien', 10, 100, 90, 550, 900, 5, 11),
  (12, 'Saruman', 15, 180, 150, 1200, 1500, 6, 12);

-- Insertion dans la table `monstre`
INSERT INTO monstre (ID_monstre, nom_monstre, lvl_monstre, HP_monstre, pointXP)
VALUES
  (4, 'Loup affamé', 6, 80, 150),
  (5, 'Ogre des montagnes', 10, 120, 250),
  (6, 'Banshee des ténèbres', 14, 180, 400);



