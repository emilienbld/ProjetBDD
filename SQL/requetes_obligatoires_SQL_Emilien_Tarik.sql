-- Exercice 4 Écriture de requêtes SQL

-- Afficher le nombre de joueurs dans chaque guilde :
SELECT nom_guilde, COUNT(*) AS nombre_de_joueurs
FROM joueur
JOIN guilde ON joueur.ID_guilde = guilde.ID_guilde
GROUP BY nom_guilde;

-- Afficher les noms des joueurs et le nom de leur guilde, triés par niveau décroissant du niveau du joueur :
SELECT joueur.nom, guilde.nom_guilde, joueur.niveau
FROM joueur
JOIN guilde ON joueur.ID_guilde = guilde.ID_guilde
ORDER BY joueur.niveau DESC;

-- Mettre à jour le niveau d'un joueur spécifique :
UPDATE joueur
SET niveau = niveau + 1
WHERE ID_joueur = 1;

-- Afficher les quêtes en cours avec le nombre de joueurs associés, mais seulement pour les quêtes avec plus d'un joueur :
SELECT quete.nom_quete, COUNT(avoirquete.ID_joueur) AS nombre_de_joueurs
FROM quete
JOIN avoirquete ON quete.ID_quete = avoirquete.ID_quete
GROUP BY quete.nom_quete
HAVING COUNT(avoirquete.ID_joueur) > 1;

-- Combinaison de deux sélections distinctes sur les XP des joueurs et des monstres :
-- Sélection des XP des joueurs
(SELECT nom AS nom_joueur, XP_joueur AS XP
FROM joueur)
UNION
-- Sélection des XP des monstres
(SELECT nom_monstre AS nom, pointXP AS XP
FROM monstre);

-- Afficher les 3 premiers joueurs en fonction de leur niveau :
SELECT * FROM joueur
ORDER BY niveau DESC
LIMIT 3;

-- Afficher les guerriers (type d'équipement contient "Arc") dans l'inventaire :
SELECT DISTINCT joueur.nom, equipement.type_equipement
FROM joueur
JOIN inventaire ON joueur.ID_inventaire = inventaire.ID_inventaire
JOIN appartenirequipement ON inventaire.ID_inventaire = appartenirequipement.ID_inventaire
JOIN equipement ON appartenirequipement.ID_equipement = equipement.ID_equipement
WHERE equipement.type_equipement LIKE '%Arc%';

-- Afficher les quêtes avec un nom contenant "sauver" :
SELECT * FROM quete
WHERE nom_quete LIKE '%sauver%';

-- Afficher les joueurs qui ont combattu le monstre avec un niveau entre 10 et 15 :
SELECT DISTINCT joueur.nom, joueur.niveau, monstre.nom_monstre
FROM joueur
JOIN combattremonstre ON joueur.ID_joueur = combattremonstre.ID_joueur
JOIN monstre ON combattremonstre.ID_monstre = monstre.ID_monstre
WHERE joueur.niveau BETWEEN 10 AND 15;

-- Afficher le nombre de joueurs qui ont combattu le monstre avec un niveau entre 10 et 15 :
SELECT COUNT(DISTINCT joueur.ID_joueur) AS nombre_de_joueurs
FROM joueur
JOIN combattremonstre ON joueur.ID_joueur = combattremonstre.ID_joueur
JOIN monstre ON combattremonstre.ID_monstre = monstre.ID_monstre
WHERE joueur.niveau BETWEEN 10 AND 15;

-- Utiliser CASE pour afficher le statut de chaque quête (En cours, Terminée, et Autre statut pour le reste) pour le joueur qui à le plus grand niveau :
SELECT j.nom AS nom_joueur,
       q.nom_quete,
       CASE
           WHEN q.statut_quete = 'En cours' THEN 'En cours'
           WHEN q.statut_quete = 'Terminée' THEN 'Terminée'
           ELSE 'Autre statut'
       END AS statut
FROM quete q
JOIN avoirquete a ON q.ID_quete = a.ID_quete
JOIN joueur j ON a.ID_joueur = j.ID_joueur
WHERE j.niveau = (SELECT MAX(niveau) FROM joueur);


-- Création d'une table pour faire les tests qui peuvent engendrer des casses dans la BDD
CREATE TABLE nouvelle_table (
    id INT PRIMARY KEY,
    nom VARCHAR(255),
    age INT
);

-- Remplissage de cette table
INSERT INTO nouvelle_table (id, nom, age) VALUES
(1, 'Alice', 25),
(2, 'Bob', 30),
(3, 'Charlie', 22);

-- Utiliser DELETE pour supprimer une entrée :
DELETE FROM nouvelle_table WHERE id = 2;

-- Utiliser ALTER TABLE pour ajouter une colonne :
ALTER TABLE nouvelle_table ADD COLUMN email VARCHAR(255);

-- Utiliser UPDATE pour remplir la nouvelle colonne :
UPDATE nouvelle_table SET email = 'alice@example.com' WHERE id = 1;
UPDATE nouvelle_table SET email = 'charlie@example.com' WHERE id = 3;

-- Utiliser TRUNCATE TABLE pour supprimer toutes les entrées :
TRUNCATE TABLE nouvelle_table;

-- Utiliser DROP TABLE pour supprimer la table :
DROP TABLE nouvelle_table;

-- Afficher les joueurs dans une liste de guilde
SELECT *
FROM joueur
WHERE ID_guilde IN (1, 3);

-- Affiche les joueurs qui ont combattu un monstre avec un niveau supérieur ou égal à 10.
SELECT *
FROM joueur
WHERE ID_joueur IN (
    SELECT DISTINCT ID_joueur
    FROM combattremonstre
    WHERE ID_monstre IN (
        SELECT ID_monstre
        FROM monstre
        WHERE lvl_monstre >= 10
    )
);

-- Utilisation de EXPLAINa
EXPLAIN SELECT *
FROM joueur
WHERE ID_guilde IN (1, 3);
