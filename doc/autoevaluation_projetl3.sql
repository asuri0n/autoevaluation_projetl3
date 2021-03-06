-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Client :  mysql.info.unicaen.fr:3306
-- Généré le :  Jeu 15 Mars 2018 à 18:08
-- Version du serveur :  5.5.59-0+deb8u1-log
-- Version de PHP :  5.6.30-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `21404260_dev`
--

-- --------------------------------------------------------

--
-- Structure de la table `admins`
--

CREATE TABLE `admins` (
  `id_admin` int(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `admins`
--

INSERT INTO `admins` (`id_admin`, `email`, `password`, `salt`) VALUES
(2, 'asurion61@gmail.com', 'bdd4f2a2ab707f538331670b0c2c1a2b556dee4896052530383090e8a13282c43600a61739959048d6167f060cd42fd0e654ace64bdf777dfd141b50fcef02af', 'ac8cc10364ee8a7893ae62aeb4bd529be50f91a5f52a5c95751684842ed5f1040acf15a2ec60010da2c27b38d86369b8e4fc2bd35cc385636611a44ed73d4404');

-- --------------------------------------------------------

--
-- Structure de la table `annees`
--

CREATE TABLE `annees` (
  `code_annee` varchar(10) NOT NULL,
  `num_annee` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `annees`
--

INSERT INTO `annees` (`code_annee`, `num_annee`) VALUES
('1LINFO', 1),
('1LMATH', 1),
('2LINFO', 2),
('2LMATH', 2),
('3LINFO', 3),
('3LMATH', 3);

-- --------------------------------------------------------

--
-- Structure de la table `choix`
--

CREATE TABLE `choix` (
  `id_choix` int(10) NOT NULL,
  `id_question` int(10) DEFAULT NULL,
  `choix` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `choix`
--

INSERT INTO `choix` (`id_choix`, `id_question`, `choix`) VALUES
(415, 243, 'm'),
(416, 244, '23'),
(417, 245, ' '),
(418, 247, 'premier'),
(419, 248, 'mier cours de python'),
(420, 249, 'y=x[:5]+\\\"au\\\"+x[6:]'),
(421, 250, 'y=x[:7]+\\\"*\\\"+x[8:12]+\\\"*\\\"+x[13:15]+\\\"*\\\"+x[16:]+\\\"*\\\"'),
(422, 251, 'y=x[1:-1]'),
(423, 252, 'y=x[:(len(x))//2]+x[(len(x))//2:]');

-- --------------------------------------------------------

--
-- Structure de la table `commentaires`
--

CREATE TABLE `commentaires` (
  `id_commentaire` int(11) NOT NULL,
  `id_exercice` int(11) NOT NULL,
  `id_etudiant` int(8) NOT NULL,
  `commentaire` longtext NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `diplomes`
--

CREATE TABLE `diplomes` (
  `code_diplome` varchar(10) NOT NULL,
  `libelle` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `diplomes`
--

INSERT INTO `diplomes` (`code_diplome`, `libelle`) VALUES
('INFO', 'informatique'),
('MATH', 'mathématique');

-- --------------------------------------------------------

--
-- Structure de la table `etudiants`
--

CREATE TABLE `etudiants` (
  `id_etudiant` int(8) NOT NULL,
  `date_prem_conn` date NOT NULL,
  `fin_inscription` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `etudiants`
--

INSERT INTO `etudiants` (`id_etudiant`, `date_prem_conn`, `fin_inscription`) VALUES
(21404260, '2018-01-12', NULL),
(21999997, '2018-03-02', '2018-11-30');

-- --------------------------------------------------------

--
-- Structure de la table `exercice`
--

CREATE TABLE `exercice` (
  `id_exercice` int(11) NOT NULL,
  `id_matiere` int(10) NOT NULL,
  `enonce` varchar(100) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `exercice`
--

INSERT INTO `exercice` (`id_exercice`, `id_matiere`, `enonce`, `date`) VALUES
(82, 4, 'Chaine de caractères', '2018-03-13');

-- --------------------------------------------------------

--
-- Structure de la table `matieres`
--

CREATE TABLE `matieres` (
  `id_matiere` int(11) NOT NULL,
  `code_diplome` varchar(10) NOT NULL,
  `code_annee` varchar(10) NOT NULL,
  `code_semestre` varchar(10) NOT NULL,
  `code_ue` varchar(10) NOT NULL,
  `code_ec` varchar(10) DEFAULT NULL,
  `libelle` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `matieres`
--

INSERT INTO `matieres` (`id_matiere`, `code_diplome`, `code_annee`, `code_semestre`, `code_ue`, `code_ec`, `libelle`) VALUES
(1, 'INFO', '3LINFO', 'INF5', 'A', NULL, 'Génie logiciel'),
(2, 'INFO', '1LINFO', 'INF5', 'A', '1', 'Méthodes de conception'),
(3, 'INFO', '3LINFO', 'INF5', 'A', '2', 'Conduite de projet'),
(4, 'INFO', '3LINFO', 'INF5', 'B', NULL, 'Système et Réseaux 2'),
(5, 'INFO', '3LINFO', 'INF5', 'B', '1', 'Système'),
(6, 'INFO', '3LINFO', 'INF5', 'B', '2', 'Réseaux'),
(7, 'INFO', '3LINFO', 'INF5', 'C', NULL, 'Bases de données 2'),
(8, 'INFO', '3LINFO', 'INF5', 'D', NULL, 'Découverte d\'un domaine de l\'informatique'),
(9, 'INFO', '3LINFO', 'INF5', 'D', '1', 'Sécurité Informatique et Protection des données'),
(10, 'INFO', '3LINFO', 'INF5', 'D', '2', 'Option2'),
(11, 'INFO', '3LINFO', 'INF5', 'D', '3', 'Option3'),
(12, 'INFO', '3LINFO', 'INF5', 'E', NULL, 'Informatique Industrielle'),
(13, 'INFO', '3LINFO', 'INF5', 'E', '1', 'Machines numériques'),
(14, 'INFO', '3LINFO', 'INF5', 'E', '2', 'Parallélisme'),
(15, 'INFO', '3LINFO', 'INF6', 'A', NULL, 'Théorie des Langages et Compilation'),
(16, 'INFO', '3LINFO', 'INF6', 'B', NULL, 'Structures discrètes pour l\'Informatique'),
(17, 'INFO', '3LINFO', 'INF6', 'C', NULL, 'Technologies Web'),
(18, 'INFO', '3LINFO', 'INF6', 'D', NULL, 'Conception d\'applications'),
(19, 'INFO', '3LINFO', 'INF6', 'D', '1', 'Programmation Androïd'),
(20, 'INFO', '3LINFO', 'INF6', 'D', '2', 'Créativité logicielle'),
(21, 'INFO', '3LINFO', 'INF6', 'D', '3', 'Projet'),
(22, 'INFO', '3LINFO', 'INF6', 'C', NULL, 'Stage et Communication S6'),
(23, 'INFO', '3LINFO', 'INF6', 'C', '1', 'Stage'),
(24, 'INFO', '3LINFO', 'INF6', 'C', '2', 'Anglais S6'),
(25, 'INFO', '3LINFO', 'INF6', 'C', '3', 'Communication');

-- --------------------------------------------------------

--
-- Structure de la table `questions`
--

CREATE TABLE `questions` (
  `id_question` int(11) NOT NULL,
  `id_exercice` int(11) NOT NULL,
  `question` longtext NOT NULL,
  `id_type` int(11) NOT NULL,
  `justification` longtext,
  `commentaire` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `questions`
--

INSERT INTO `questions` (`id_question`, `id_exercice`, `question`, `id_type`, `justification`, `commentaire`) VALUES
(243, 82, 'Soit x=\\\"premier cours de python\\\" quel est le résultat de x[3]', 3, NULL, NULL),
(244, 82, 'Soit x=\\\"premier cours de python\\\" quel est le résultat de n=len(x)', 3, NULL, NULL),
(245, 82, 'Soit x=\\\"premier cours de python\\\" quel est le résultat de x[7]', 3, NULL, NULL),
(246, 82, 'Soit x=\\\"premier cours de python\\\" quel est le résultat de x[0]', 3, NULL, NULL),
(247, 82, 'Soit x=\\\"premier cours de python\\\" quel est le résultat des extractions de sous-chaînes suivantes : x[:7]', 3, NULL, NULL),
(248, 82, 'Soit x=\\\"premier cours de python\\\" quel est le résultat des extractions de sous-chaînes suivantes : x[3:]', 3, NULL, NULL),
(249, 82, 'Ecrire x=“les fotes” en prenant des morceaux de la chaîne y et en remplaçant le “o” par “au”', 3, NULL, NULL),
(250, 82, 'On a x= “bonjour tout le monde” . Avec le moins d\\\'opérations possible et en utilisant x, afficher: bonjour * tout * le * monde *', 3, NULL, NULL),
(251, 82, 'A partir d\\\'une chaîne contenue dans la variable x, comment obtenir cette chaîne : privée de ses premier et dernier caractères,', 3, NULL, NULL),
(252, 82, 'A partir d\\\'une chaîne contenue dans la variable x, comment obtenir cette chaîne : privée du caractère central dans le cas où il y a un nombre impair de caractères', 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `reponses`
--

CREATE TABLE `reponses` (
  `id_reponse` int(10) NOT NULL,
  `id_question` int(10) DEFAULT NULL,
  `id_choix_bonn_rep` varchar(50) DEFAULT NULL,
  `reponse_fixe` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `reponses`
--

INSERT INTO `reponses` (`id_reponse`, `id_question`, `id_choix_bonn_rep`, `reponse_fixe`) VALUES
(201, 243, NULL, 'm'),
(202, 244, NULL, '23'),
(203, 245, NULL, ' '),
(204, 246, NULL, ''),
(205, 247, NULL, 'premier'),
(206, 248, NULL, 'mier cours de python'),
(207, 249, NULL, 'y=x[:5]+\"au\"+x[6:]'),
(208, 250, NULL, 'y=x[:7]+\"*\"+x[8:12]+\"*\"+x[13:15]+\"*\"+x[16:]+\"*\"'),
(209, 251, NULL, 'y=x[1:-1]'),
(210, 252, NULL, 'y=x[:(len(x))//2]+x[(len(x))//2:]');

-- --------------------------------------------------------

--
-- Structure de la table `scores`
--

CREATE TABLE `scores` (
  `id_etudiant` int(11) NOT NULL,
  `id_exercice` int(11) NOT NULL,
  `resultat` int(11) NOT NULL,
  `resultat_ancien` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `semestres`
--

CREATE TABLE `semestres` (
  `code_semestre` varchar(10) NOT NULL,
  `num_semestre` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `semestres`
--

INSERT INTO `semestres` (`code_semestre`, `num_semestre`) VALUES
('INF1', 1),
('INF2', 2),
('INF3', 3),
('INF4', 4),
('INF5', 5),
('INF6', 6),
('MATH1', 1),
('MATH2', 2),
('MATH3', 3),
('MATH4', 4),
('MATH5', 5),
('MATH6', 6);

-- --------------------------------------------------------

--
-- Structure de la table `type_question`
--

CREATE TABLE `type_question` (
  `id_type` int(11) NOT NULL,
  `libelle` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `type_question`
--

INSERT INTO `type_question` (`id_type`, `libelle`) VALUES
(1, 'Choix multiple'),
(2, 'Choix unique'),
(3, 'Normal');

--
-- Index pour les tables exportées
--

--
-- Index pour la table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id_admin`);

--
-- Index pour la table `annees`
--
ALTER TABLE `annees`
  ADD PRIMARY KEY (`code_annee`);

--
-- Index pour la table `choix`
--
ALTER TABLE `choix`
  ADD PRIMARY KEY (`id_choix`),
  ADD KEY `choix_questions_id_question_fk` (`id_question`);

--
-- Index pour la table `commentaires`
--
ALTER TABLE `commentaires`
  ADD PRIMARY KEY (`id_commentaire`),
  ADD KEY `id_etudiant` (`id_etudiant`),
  ADD KEY `id_exercice` (`id_exercice`);

--
-- Index pour la table `diplomes`
--
ALTER TABLE `diplomes`
  ADD PRIMARY KEY (`code_diplome`);

--
-- Index pour la table `etudiants`
--
ALTER TABLE `etudiants`
  ADD PRIMARY KEY (`id_etudiant`);

--
-- Index pour la table `exercice`
--
ALTER TABLE `exercice`
  ADD PRIMARY KEY (`id_exercice`),
  ADD KEY `id_matiere` (`id_matiere`);

--
-- Index pour la table `matieres`
--
ALTER TABLE `matieres`
  ADD PRIMARY KEY (`id_matiere`),
  ADD KEY `matieres_semestres_id_semestre_id_diplome_fk` (`code_semestre`,`code_diplome`),
  ADD KEY `matieres_annees_code_annee_fk` (`code_annee`),
  ADD KEY `matieres_diplomes_code_diplome_fk` (`code_diplome`);

--
-- Index pour la table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id_question`),
  ADD KEY `id_exercice` (`id_exercice`),
  ADD KEY `id_type` (`id_type`);

--
-- Index pour la table `reponses`
--
ALTER TABLE `reponses`
  ADD PRIMARY KEY (`id_reponse`),
  ADD KEY `reponses_questions_id_question_fk` (`id_question`);

--
-- Index pour la table `scores`
--
ALTER TABLE `scores`
  ADD PRIMARY KEY (`id_etudiant`,`id_exercice`),
  ADD UNIQUE KEY `scores_id_etudiant_id_exercice_pk` (`id_etudiant`,`id_exercice`),
  ADD KEY `etupass` (`id_etudiant`),
  ADD KEY `ex_id` (`id_exercice`);

--
-- Index pour la table `semestres`
--
ALTER TABLE `semestres`
  ADD PRIMARY KEY (`code_semestre`);

--
-- Index pour la table `type_question`
--
ALTER TABLE `type_question`
  ADD PRIMARY KEY (`id_type`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `admins`
--
ALTER TABLE `admins`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `choix`
--
ALTER TABLE `choix`
  MODIFY `id_choix` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=424;
--
-- AUTO_INCREMENT pour la table `commentaires`
--
ALTER TABLE `commentaires`
  MODIFY `id_commentaire` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT pour la table `exercice`
--
ALTER TABLE `exercice`
  MODIFY `id_exercice` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;
--
-- AUTO_INCREMENT pour la table `matieres`
--
ALTER TABLE `matieres`
  MODIFY `id_matiere` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT pour la table `questions`
--
ALTER TABLE `questions`
  MODIFY `id_question` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=253;
--
-- AUTO_INCREMENT pour la table `reponses`
--
ALTER TABLE `reponses`
  MODIFY `id_reponse` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;
--
-- AUTO_INCREMENT pour la table `type_question`
--
ALTER TABLE `type_question`
  MODIFY `id_type` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `choix`
--
ALTER TABLE `choix`
  ADD CONSTRAINT `choix_questions_id_question_fk` FOREIGN KEY (`id_question`) REFERENCES `questions` (`id_question`) ON DELETE CASCADE;

--
-- Contraintes pour la table `commentaires`
--
ALTER TABLE `commentaires`
  ADD CONSTRAINT `commentaires_ibfk_2` FOREIGN KEY (`id_exercice`) REFERENCES `exercice` (`id_exercice`) ON DELETE CASCADE,
  ADD CONSTRAINT `commentaires_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiants` (`id_etudiant`);

--
-- Contraintes pour la table `exercice`
--
ALTER TABLE `exercice`
  ADD CONSTRAINT `exercice_matieres_id_matiere_fk` FOREIGN KEY (`id_matiere`) REFERENCES `matieres` (`id_matiere`);

--
-- Contraintes pour la table `matieres`
--
ALTER TABLE `matieres`
  ADD CONSTRAINT `matieres_annees_code_annee_fk` FOREIGN KEY (`code_annee`) REFERENCES `annees` (`code_annee`),
  ADD CONSTRAINT `matieres_diplomes_code_diplome_fk` FOREIGN KEY (`code_diplome`) REFERENCES `diplomes` (`code_diplome`),
  ADD CONSTRAINT `matieres_semestres_code_semestre_fk` FOREIGN KEY (`code_semestre`) REFERENCES `semestres` (`code_semestre`);

--
-- Contraintes pour la table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`id_exercice`) REFERENCES `exercice` (`id_exercice`) ON DELETE CASCADE,
  ADD CONSTRAINT `questions_ibfk_2` FOREIGN KEY (`id_type`) REFERENCES `type_question` (`id_type`);

--
-- Contraintes pour la table `reponses`
--
ALTER TABLE `reponses`
  ADD CONSTRAINT `reponses_questions_id_question_fk` FOREIGN KEY (`id_question`) REFERENCES `questions` (`id_question`) ON DELETE CASCADE;

--
-- Contraintes pour la table `scores`
--
ALTER TABLE `scores`
  ADD CONSTRAINT `scores_etudiants_id_etudiant_fk` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiants` (`id_etudiant`),
  ADD CONSTRAINT `scores_exercice_id_exercice_fk` FOREIGN KEY (`id_exercice`) REFERENCES `exercice` (`id_exercice`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
