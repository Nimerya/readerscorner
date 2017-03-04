-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Dec 21, 2016 at 03:08 PM
-- Server version: 5.5.34
-- PHP Version: 5.5.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tdw1617_2`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `position` int(10) unsigned DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=27 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `position`, `name`, `description`) VALUES
(1, 0, 'ssss', '1'),
(2, 22, 'Cinema SPORT2', 'Prrr2'),
(3, 2, 'Cinema', 'Prrr'),
(4, 2, 'Cinema', 'Prrr'),
(5, 2, 'Cinema', 'Prrr'),
(6, 2, 'Cinema', 'Prrr'),
(7, 1, 'Pesca', 'La caccia Ã¨ la pratica di catturare o abbattere animali, solitamente selvatici, in principio per l\\''approvvigionamento di cibo, pelli o altre materie, successivamente principalmente per altri fini: a scopo ricreativo, commerciale e per contenimento e gestione di una specie.\r\n\r\nIn passato la caccia ha rappresentato una fonte primaria di sostentamento per l\\''uomo durante la condizione di cacciatore-raccoglitore, attivitÃ  per la quale venivano realizzati i primi utensili, dai chopper alle punte di lancia. Nel corso della storia la caccia ha rivestito un ruolo di importanza differente per ciascuna popolazione umana. Per societÃ  in cui si svilupparono sempre piÃ¹ redditizie tecniche di agricoltura e allevamento, la caccia rivestiva un ruolo marginale o accessorio, legato a cultura, tradizione o a gestione delle specie selvatiche.\r\n\r\nLa caccia Ã¨ comunque indispensabile per molte popolazioni che basano su essa tutto o parte del loro sostentamento, ad esempio in ambienti dove il clima comporti condizioni estreme di vita e non favorisca attivitÃ  quali agricoltura e allevamento come per gli Inuit, o per cultura legata alla stessa come per popolazioni native di zone forestali e non urbanizzate, come i KarajÃ¡ del Mato Grosso. Per tali popoli caccia e pesca rivestono ancora una funzione fondamentale alla loro sopravvivenza.\r\n\r\nNei paesi industrializzati ove il reperimento di cibo Ã¨ attivitÃ  indiretta (acquisto) e legata all\\''allevamento intensivo, la caccia riveste un ruolo principalmente ricreativo, oppure condotto a scopo commerciale. In questo contesto, il termine \\"caccia\\" si riferisce generalmente a un\\''attivitÃ  approvata dalla legge, mentre il bracconaggio indica la caccia praticata in modi o in contesti che la rendono illegale.\r\n\r\nLa pesca commerciale non viene solitamente considerata un tipo di caccia, mentre nella sua espressione subacquea (caccia subacquea o pesca subacquea) e nella sua espressione con la canna (pesca di superficie) viene considerata da molti una forma di caccia non avendo natura commerciale. Anche la soppressione con trappole di animali \\"infestanti\\" quali topi o ratti viene considerata un\\''attivitÃ  diversa dalla caccia.'),
(8, 0, 'tennis', 'L''Aquila'),
(9, 0, '', ''),
(10, 2, 'Caciocavallo', 'prova'),
(11, 12, 'aaaaaa', 'aaaa'),
(12, 0, '', ''),
(13, 0, '', ''),
(14, 0, '', ''),
(15, 0, '', ''),
(16, 0, '', ''),
(17, 0, '', ''),
(18, 0, '', ''),
(19, 0, 'ddd', ''),
(20, 0, 'ssssss', ''),
(21, 0, 'ssssss', ''),
(22, 0, 'ssssss', ''),
(23, 0, 'ssss', ''),
(24, 0, 'dddddd', ''),
(25, 0, 'ssss', ''),
(26, 0, 'ddd', '');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`) VALUES
(1, 'Administrator', NULL),
(2, 'Editor', NULL),
(3, 'Product Manager', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `groupservices`
--

CREATE TABLE `groupservices` (
  `id_group` int(10) unsigned NOT NULL DEFAULT '0',
  `id_service` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_group`,`id_service`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groupservices`
--

INSERT INTO `groupservices` (`id_group`, `id_service`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 1),
(2, 2),
(3, 1),
(3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `script` varchar(50) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `script`, `description`) VALUES
(1, 'login.php', NULL),
(2, 'logout.php', NULL),
(3, 'category_add.php', NULL),
(4, 'category_edit.php', NULL),
(5, 'user_add.php', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `usergroups`
--

CREATE TABLE `usergroups` (
  `username` varchar(50) DEFAULT NULL,
  `id_group` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_group`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usergroups`
--

INSERT INTO `usergroups` (`username`, `id_group`) VALUES
('admin', 1),
('pippo.baudo', 2),
('admin', 3);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `password`, `name`, `surname`, `email`) VALUES
('admin', '0c88028bf3aa6a6a143ed846f2be1ea4', 'Alfonso', 'Pierantonio', 'alfonso.pierantonio@univaq.it'),
('pippo.baudo', '0c88028bf3aa6a6a143ed846f2be1ea4', 'Pippo', 'Baudo', 'pippo@baudo.com');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
