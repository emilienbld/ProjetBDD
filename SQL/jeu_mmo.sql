-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 24 jan. 2024 à 16:41
-- Version du serveur : 10.4.25-MariaDB
-- Version de PHP : 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `jeu_mmo`
--
CREATE DATABASE IF NOT EXISTS `jeu_mmo` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `jeu_mmo`;

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `Quete_FIN`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Quete_FIN` (IN `quete_id` INT, IN `joueur_id` INT)   BEGIN
  UPDATE quete
  SET statut_quete = 'Terminée'
  WHERE ID_quete = quete_id;

  UPDATE joueur
  SET gold = gold + 100
  WHERE ID_joueur = joueur_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `appartenirequipement`
--

DROP TABLE IF EXISTS `appartenirequipement`;
CREATE TABLE `appartenirequipement` (
  `ID_inventaire` int(11) NOT NULL,
  `ID_equipement` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `appartenirequipement`
--

INSERT INTO `appartenirequipement` (`ID_inventaire`, `ID_equipement`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Structure de la table `avoirquete`
--

DROP TABLE IF EXISTS `avoirquete`;
CREATE TABLE `avoirquete` (
  `ID_quete` int(11) NOT NULL,
  `ID_joueur` int(11) NOT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `avoirquete`
--

INSERT INTO `avoirquete` (`ID_quete`, `ID_joueur`, `date_debut`, `date_fin`) VALUES
(1, 1, '2024-01-24', NULL),
(2, 2, '2024-01-23', '2024-01-25'),
(3, 3, '2024-01-22', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `combattremonstre`
--

DROP TABLE IF EXISTS `combattremonstre`;
CREATE TABLE `combattremonstre` (
  `ID_joueur` int(11) NOT NULL,
  `ID_monstre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `combattremonstre`
--

INSERT INTO `combattremonstre` (`ID_joueur`, `ID_monstre`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Structure de la table `equipement`
--

DROP TABLE IF EXISTS `equipement`;
CREATE TABLE `equipement` (
  `ID_equipement` int(11) NOT NULL,
  `type_equipement` varchar(50) DEFAULT NULL,
  `poids` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `equipement`
--

INSERT INTO `equipement` (`ID_equipement`, `type_equipement`, `poids`) VALUES
(1, 'Épée en fer', 8),
(2, 'Arc en bois', 5),
(3, 'Armure légère', 15);

-- --------------------------------------------------------

--
-- Structure de la table `guilde`
--

DROP TABLE IF EXISTS `guilde`;
CREATE TABLE `guilde` (
  `ID_guilde` int(11) NOT NULL,
  `nom_guilde` varchar(255) DEFAULT NULL,
  `XP_guilde` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `guilde`
--

INSERT INTO `guilde` (`ID_guilde`, `nom_guilde`, `XP_guilde`) VALUES
(1, 'Les Aventuriers', 1100),
(2, 'Gardiens de la Nuit', 750),
(3, 'L\'Ordre des Braves', 1200);

-- --------------------------------------------------------

--
-- Structure de la table `inventaire`
--

DROP TABLE IF EXISTS `inventaire`;
CREATE TABLE `inventaire` (
  `ID_inventaire` int(11) NOT NULL,
  `objet` varchar(255) DEFAULT NULL,
  `poids_max` int(11) DEFAULT NULL,
  `poids` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `inventaire`
--

INSERT INTO `inventaire` (`ID_inventaire`, `objet`, `poids_max`, `poids`) VALUES
(1, 'Sac à dos', 50, 10),
(2, 'Coffre magique', 100, 30),
(3, 'Pochette de gemmes', 20, 5);

-- --------------------------------------------------------

--
-- Structure de la table `joueur`
--

DROP TABLE IF EXISTS `joueur`;
CREATE TABLE `joueur` (
  `ID_joueur` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `niveau` int(11) DEFAULT NULL,
  `HP_joueur` int(11) DEFAULT NULL,
  `stamina_joueur` int(11) DEFAULT NULL,
  `XP_joueur` int(11) DEFAULT NULL,
  `gold` int(11) DEFAULT NULL,
  `ID_guilde` int(11) DEFAULT NULL,
  `ID_inventaire` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `joueur`
--

INSERT INTO `joueur` (`ID_joueur`, `nom`, `niveau`, `HP_joueur`, `stamina_joueur`, `XP_joueur`, `gold`, `ID_guilde`, `ID_inventaire`) VALUES
(0, 'John Doe', 10, 100, 80, 500, 1100, 1, 3),
(1, 'Aragorn', 10, 100, 80, 500, 1100, 1, 1),
(2, 'Legolas', 8, 80, 90, 400, 800, 1, 2),
(3, 'Gimli', 7, 90, 70, 350, 600, 2, 3);

--
-- Déclencheurs `joueur`
--
DROP TRIGGER IF EXISTS `XP_guilde`;
DELIMITER $$
CREATE TRIGGER `XP_guilde` AFTER INSERT ON `joueur` FOR EACH ROW BEGIN
    UPDATE guilde
    SET XP_guilde = XP_guilde + 100
    WHERE ID_guilde = NEW.ID_guilde;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `monstre`
--

DROP TABLE IF EXISTS `monstre`;
CREATE TABLE `monstre` (
  `ID_monstre` int(11) NOT NULL,
  `nom_monstre` varchar(255) DEFAULT NULL,
  `lvl_monstre` int(11) DEFAULT NULL,
  `HP_monstre` int(11) DEFAULT NULL,
  `pointXP` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `monstre`
--

INSERT INTO `monstre` (`ID_monstre`, `nom_monstre`, `lvl_monstre`, `HP_monstre`, `pointXP`) VALUES
(1, 'Dragon de feu', 15, 200, 500),
(2, 'Gobelin des cavernes', 5, 50, 100),
(3, 'Sorcier noir', 12, 120, 300);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `nb_membres`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `nb_membres`;
CREATE TABLE `nb_membres` (
`nom_guilde` varchar(255)
,`nombre_de_joueurs` bigint(21)
,`XP_guilde` int(11)
);

-- --------------------------------------------------------

--
-- Structure de la table `quete`
--

DROP TABLE IF EXISTS `quete`;
CREATE TABLE `quete` (
  `ID_quete` int(11) NOT NULL,
  `nom_quete` varchar(255) DEFAULT NULL,
  `statut_quete` varchar(50) DEFAULT NULL,
  `recompense` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `quete`
--

INSERT INTO `quete` (`ID_quete`, `nom_quete`, `statut_quete`, `recompense`) VALUES
(1, 'La quête du trésor perdu', 'Terminée', 'Épée légendaire'),
(2, 'Chasse aux monstres', 'Terminée', 'Sac d\'or'),
(3, 'Sauver la princesse', 'En cours', 'Armure enchantée');

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `show_guildeplayer`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `show_guildeplayer`;
CREATE TABLE `show_guildeplayer` (
`nom` varchar(255)
,`nom_guilde` varchar(255)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `top_player`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `top_player`;
CREATE TABLE `top_player` (
`ID_joueur` int(11)
,`nom` varchar(255)
,`niveau` int(11)
,`HP_joueur` int(11)
,`stamina_joueur` int(11)
,`XP_joueur` int(11)
,`gold` int(11)
,`ID_guilde` int(11)
,`ID_inventaire` int(11)
);

-- --------------------------------------------------------

--
-- Structure de la vue `nb_membres`
--
DROP TABLE IF EXISTS `nb_membres`;

DROP VIEW IF EXISTS `nb_membres`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nb_membres`  AS SELECT `guilde`.`nom_guilde` AS `nom_guilde`, count(0) AS `nombre_de_joueurs`, `guilde`.`XP_guilde` AS `XP_guilde` FROM (`joueur` join `guilde` on(`joueur`.`ID_guilde` = `guilde`.`ID_guilde`)) GROUP BY `guilde`.`nom_guilde` ORDER BY `guilde`.`XP_guilde` AS `DESCdesc` ASC  ;

-- --------------------------------------------------------

--
-- Structure de la vue `show_guildeplayer`
--
DROP TABLE IF EXISTS `show_guildeplayer`;

DROP VIEW IF EXISTS `show_guildeplayer`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `show_guildeplayer`  AS SELECT `joueur`.`nom` AS `nom`, `guilde`.`nom_guilde` AS `nom_guilde` FROM (`joueur` join `guilde` on(`guilde`.`ID_guilde` = `joueur`.`ID_guilde`))  ;

-- --------------------------------------------------------

--
-- Structure de la vue `top_player`
--
DROP TABLE IF EXISTS `top_player`;

DROP VIEW IF EXISTS `top_player`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `top_player`  AS SELECT `joueur`.`ID_joueur` AS `ID_joueur`, `joueur`.`nom` AS `nom`, `joueur`.`niveau` AS `niveau`, `joueur`.`HP_joueur` AS `HP_joueur`, `joueur`.`stamina_joueur` AS `stamina_joueur`, `joueur`.`XP_joueur` AS `XP_joueur`, `joueur`.`gold` AS `gold`, `joueur`.`ID_guilde` AS `ID_guilde`, `joueur`.`ID_inventaire` AS `ID_inventaire` FROM `joueur` ORDER BY `joueur`.`niveau` DESC LIMIT 0, 33  ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `appartenirequipement`
--
ALTER TABLE `appartenirequipement`
  ADD PRIMARY KEY (`ID_inventaire`,`ID_equipement`),
  ADD KEY `ID_equipement` (`ID_equipement`);

--
-- Index pour la table `avoirquete`
--
ALTER TABLE `avoirquete`
  ADD PRIMARY KEY (`ID_quete`,`ID_joueur`),
  ADD KEY `ID_joueur` (`ID_joueur`);

--
-- Index pour la table `combattremonstre`
--
ALTER TABLE `combattremonstre`
  ADD PRIMARY KEY (`ID_joueur`,`ID_monstre`),
  ADD KEY `ID_monstre` (`ID_monstre`);

--
-- Index pour la table `equipement`
--
ALTER TABLE `equipement`
  ADD PRIMARY KEY (`ID_equipement`);

--
-- Index pour la table `guilde`
--
ALTER TABLE `guilde`
  ADD PRIMARY KEY (`ID_guilde`);

--
-- Index pour la table `inventaire`
--
ALTER TABLE `inventaire`
  ADD PRIMARY KEY (`ID_inventaire`);

--
-- Index pour la table `joueur`
--
ALTER TABLE `joueur`
  ADD PRIMARY KEY (`ID_joueur`),
  ADD KEY `ID_guilde` (`ID_guilde`),
  ADD KEY `ID_inventaire` (`ID_inventaire`);

--
-- Index pour la table `monstre`
--
ALTER TABLE `monstre`
  ADD PRIMARY KEY (`ID_monstre`);

--
-- Index pour la table `quete`
--
ALTER TABLE `quete`
  ADD PRIMARY KEY (`ID_quete`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `appartenirequipement`
--
ALTER TABLE `appartenirequipement`
  ADD CONSTRAINT `appartenirequipement_ibfk_1` FOREIGN KEY (`ID_inventaire`) REFERENCES `inventaire` (`ID_inventaire`),
  ADD CONSTRAINT `appartenirequipement_ibfk_2` FOREIGN KEY (`ID_equipement`) REFERENCES `equipement` (`ID_equipement`);

--
-- Contraintes pour la table `avoirquete`
--
ALTER TABLE `avoirquete`
  ADD CONSTRAINT `avoirquete_ibfk_1` FOREIGN KEY (`ID_joueur`) REFERENCES `joueur` (`ID_joueur`),
  ADD CONSTRAINT `avoirquete_ibfk_2` FOREIGN KEY (`ID_quete`) REFERENCES `quete` (`ID_quete`);

--
-- Contraintes pour la table `combattremonstre`
--
ALTER TABLE `combattremonstre`
  ADD CONSTRAINT `combattremonstre_ibfk_1` FOREIGN KEY (`ID_joueur`) REFERENCES `joueur` (`ID_joueur`),
  ADD CONSTRAINT `combattremonstre_ibfk_2` FOREIGN KEY (`ID_monstre`) REFERENCES `monstre` (`ID_monstre`);

--
-- Contraintes pour la table `joueur`
--
ALTER TABLE `joueur`
  ADD CONSTRAINT `joueur_ibfk_1` FOREIGN KEY (`ID_guilde`) REFERENCES `guilde` (`ID_guilde`),
  ADD CONSTRAINT `joueur_ibfk_2` FOREIGN KEY (`ID_inventaire`) REFERENCES `inventaire` (`ID_inventaire`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;



