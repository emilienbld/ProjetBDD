-- Triger augmente l'XP de la guilde apres l'insertion d'une nouvelle ligne dans la table 'joueur'. 
DELIMITER //
CREATE TRIGGER XP_guilde 
AFTER INSERT ON joueur 
FOR EACH ROW 
BEGIN 
  UPDATE guilde 
  SET XP_guilde = XP_guilde + 100 
  WHERE ID_guilde = NEW.ID_guilde; 
END;
//
DELIMITER ;

-- Procédure stockée qui change le statut d'une quête comme 'Terminée' et attribue une récompense de 100 gold au joueur. 
DELIMITER //
CREATE PROCEDURE Quete_FIN(IN quete_id INT, IN joueur_id INT)
BEGIN
  UPDATE quete
  SET statut_quete = 'Terminée'
  WHERE ID_quete = quete_id;

  UPDATE joueur
  SET gold = gold + 100
  WHERE ID_joueur = joueur_id;
END;
//
DELIMITER ;

-- Vue qui affiche les informations de tous les 3 premiers joueurs ayant le plus de niveau.
CREATE VIEW Top_player 
AS SELECT * FROM joueur 
ORDER BY niveau DESC LIMIT 3;

-- Vu qui affiche le nombre de membres de chaque guilde ainsi que l'expérience totale (XP_guilde) de chaque guilde,
CREATE VIEW Nb_membres 
AS SELECT nom_guilde, COUNT(*) AS nombre_de_joueurs, XP_guilde
FROM joueur
JOIN guilde ON joueur.ID_guilde = guilde.ID_guilde
GROUP BY nom_guilde 
ORDER BY XP_guilde DESC;

-- Vue qui affiche les noms des joueurs et le nom de leur guilde correspondante
CREATE VIEW Show_guildePlayer
AS SELECT nom, nom_guilde FROM joueur
INNER JOIN guilde ON guilde.ID_guilde = joueur.ID_guilde;
