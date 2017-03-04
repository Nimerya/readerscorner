-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 02, 2016 at 02:29 PM
-- Server version: 5.7.11
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `readerscorner`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_test_data_author` (IN `n` INT)  BEGIN
  DECLARE i INT DEFAULT 1;
  

  WHILE i < n DO
    INSERT INTO author (  name,
						surname,
						biography
				
                       )
   
VALUES (
		CONCAT('name_',i),
		CONCAT('surname_',i),
		CONCAT('biography_',i)
		);
         
    SET i=i+1;
  END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_test_data_book_di` ()  BEGIN
  DECLARE i INT DEFAULT 1;
  

  WHILE i < 50 DO
    INSERT INTO book (  title,
						price,
						pubblication_date,
						type,
						availability,
						pages,
						size,
						isbn10,
						isbn13,
						language,
						description,
						publisher)
   
VALUES (
		CONCAT('title_',i),
		94*RAND()+5,
		CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND()*10000) DAY ,
		'digital',
		ROUND(5*RAND()+10),
		ROUND(50*RAND()+50),
		CONCAT('size_',i),
		CONCAT('isbn10_',i),
		CONCAT('isbn13_',i),
		'english',
		CONCAT('description_',i),
		CONCAT('publisher_',i)
		);
         
    SET i=i+1;
  END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_test_data_book_ph` ()  BEGIN
  DECLARE i INT DEFAULT 1;
  

  WHILE i < 50 DO
    INSERT INTO book (  title,
						price,
						pubblication_date,
						type,
						availability,
						pages,
						dimension,
						isbn10,
						isbn13,
						language,
						description,
						publisher)
   
VALUES (
		CONCAT('title_',i),
		94*RAND()+5,
		CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND()*10000) DAY ,
		'physical',
		ROUND(5*RAND()+10),
		ROUND(50*RAND()+50),
		CONCAT('dimension_',i),
		CONCAT('isbn10_',i),
		CONCAT('isbn13_',i),
		'english',
		CONCAT('description_',i),
		CONCAT('publisher_',i)
		);
         
    SET i=i+1;
  END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_user` int(10) UNSIGNED NOT NULL,
  `country` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `region` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `zip_code` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(128) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE `author` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `biography` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`id`, `name`, `surname`, `biography`) VALUES
(1, 'name_1', 'surname_1', 'biography_1'),
(2, 'name_2', 'surname_2', 'biography_2'),
(3, 'name_3', 'surname_3', 'biography_3'),
(4, 'name_4', 'surname_4', 'biography_4'),
(5, 'name_5', 'surname_5', 'biography_5'),
(6, 'name_6', 'surname_6', 'biography_6'),
(7, 'name_7', 'surname_7', 'biography_7'),
(8, 'name_8', 'surname_8', 'biography_8'),
(9, 'name_9', 'surname_9', 'biography_9'),
(10, 'name_10', 'surname_10', 'biography_10'),
(11, 'name_11', 'surname_11', 'biography_11'),
(12, 'name_12', 'surname_12', 'biography_12'),
(13, 'name_13', 'surname_13', 'biography_13'),
(14, 'name_14', 'surname_14', 'biography_14'),
(15, 'name_15', 'surname_15', 'biography_15'),
(16, 'name_16', 'surname_16', 'biography_16'),
(17, 'name_17', 'surname_17', 'biography_17'),
(18, 'name_18', 'surname_18', 'biography_18'),
(19, 'name_19', 'surname_19', 'biography_19'),
(20, 'name_20', 'surname_20', 'biography_20'),
(21, 'name_21', 'surname_21', 'biography_21'),
(22, 'name_22', 'surname_22', 'biography_22'),
(23, 'name_23', 'surname_23', 'biography_23'),
(24, 'name_24', 'surname_24', 'biography_24'),
(25, 'name_25', 'surname_25', 'biography_25'),
(26, 'name_26', 'surname_26', 'biography_26'),
(27, 'name_27', 'surname_27', 'biography_27'),
(28, 'name_28', 'surname_28', 'biography_28'),
(29, 'name_29', 'surname_29', 'biography_29'),
(30, 'name_30', 'surname_30', 'biography_30'),
(31, 'name_31', 'surname_31', 'biography_31'),
(32, 'name_32', 'surname_32', 'biography_32'),
(33, 'name_33', 'surname_33', 'biography_33'),
(34, 'name_34', 'surname_34', 'biography_34'),
(35, 'name_35', 'surname_35', 'biography_35'),
(36, 'name_36', 'surname_36', 'biography_36'),
(37, 'name_37', 'surname_37', 'biography_37'),
(38, 'name_38', 'surname_38', 'biography_38'),
(39, 'name_39', 'surname_39', 'biography_39'),
(40, 'name_40', 'surname_40', 'biography_40'),
(41, 'name_41', 'surname_41', 'biography_41'),
(42, 'name_42', 'surname_42', 'biography_42'),
(43, 'name_43', 'surname_43', 'biography_43'),
(44, 'name_44', 'surname_44', 'biography_44'),
(45, 'name_45', 'surname_45', 'biography_45'),
(46, 'name_46', 'surname_46', 'biography_46'),
(47, 'name_47', 'surname_47', 'biography_47'),
(48, 'name_48', 'surname_48', 'biography_48'),
(49, 'name_49', 'surname_49', 'biography_49'),
(50, 'name_1', 'surname_1', 'biography_1'),
(51, 'name_2', 'surname_2', 'biography_2'),
(52, 'name_3', 'surname_3', 'biography_3'),
(53, 'name_4', 'surname_4', 'biography_4'),
(54, 'name_5', 'surname_5', 'biography_5'),
(55, 'name_6', 'surname_6', 'biography_6'),
(56, 'name_7', 'surname_7', 'biography_7'),
(57, 'name_8', 'surname_8', 'biography_8'),
(58, 'name_9', 'surname_9', 'biography_9'),
(59, 'name_10', 'surname_10', 'biography_10'),
(60, 'name_11', 'surname_11', 'biography_11'),
(61, 'name_12', 'surname_12', 'biography_12'),
(62, 'name_13', 'surname_13', 'biography_13'),
(63, 'name_14', 'surname_14', 'biography_14'),
(64, 'name_15', 'surname_15', 'biography_15'),
(65, 'name_16', 'surname_16', 'biography_16'),
(66, 'name_17', 'surname_17', 'biography_17'),
(67, 'name_18', 'surname_18', 'biography_18'),
(68, 'name_19', 'surname_19', 'biography_19'),
(69, 'name_20', 'surname_20', 'biography_20'),
(70, 'name_21', 'surname_21', 'biography_21'),
(71, 'name_22', 'surname_22', 'biography_22'),
(72, 'name_23', 'surname_23', 'biography_23'),
(73, 'name_24', 'surname_24', 'biography_24');

-- --------------------------------------------------------

--
-- Table structure for table `be`
--

CREATE TABLE `be` (
  `id_user` int(10) UNSIGNED NOT NULL,
  `id_groups` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `belongs`
--

CREATE TABLE `belongs` (
  `id_category` int(10) UNSIGNED NOT NULL,
  `id_book` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_promotion` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(5,2) NOT NULL,
  `pubblication_date` date NOT NULL,
  `type` varchar(16) COLLATE utf8_unicode_ci NOT NULL COMMENT '"physical", "digital"',
  `availability` mediumint(8) UNSIGNED NOT NULL,
  `pages` mediumint(8) UNSIGNED NOT NULL,
  `dimension` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isbn10` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isbn13` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `cover` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `publisher` varchar(128) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`id`, `id_promotion`, `title`, `price`, `pubblication_date`, `type`, `availability`, `pages`, `dimension`, `size`, `isbn10`, `isbn13`, `language`, `description`, `cover`, `publisher`) VALUES
(210, NULL, 'title_1', '58.42', '1995-07-12', 'physical', 11, 82, 'dimension_1', NULL, 'isbn10_1', 'isbn13_1', 'english', 'description_1', NULL, 'publisher_1'),
(211, NULL, 'title_2', '59.14', '1989-12-02', 'physical', 11, 51, 'dimension_2', NULL, 'isbn10_2', 'isbn13_2', 'english', 'description_2', NULL, 'publisher_2'),
(212, NULL, 'title_3', '53.64', '2002-06-21', 'physical', 10, 91, 'dimension_3', NULL, 'isbn10_3', 'isbn13_3', 'english', 'description_3', NULL, 'publisher_3'),
(213, NULL, 'title_4', '83.24', '1997-02-17', 'physical', 11, 69, 'dimension_4', NULL, 'isbn10_4', 'isbn13_4', 'english', 'description_4', NULL, 'publisher_4'),
(214, NULL, 'title_5', '59.10', '1996-09-14', 'physical', 15, 79, 'dimension_5', NULL, 'isbn10_5', 'isbn13_5', 'english', 'description_5', NULL, 'publisher_5'),
(215, NULL, 'title_6', '5.67', '2008-06-09', 'physical', 13, 84, 'dimension_6', NULL, 'isbn10_6', 'isbn13_6', 'english', 'description_6', NULL, 'publisher_6'),
(216, NULL, 'title_7', '80.99', '2016-04-14', 'physical', 13, 67, 'dimension_7', NULL, 'isbn10_7', 'isbn13_7', 'english', 'description_7', NULL, 'publisher_7'),
(217, NULL, 'title_8', '70.33', '2005-02-14', 'physical', 10, 51, 'dimension_8', NULL, 'isbn10_8', 'isbn13_8', 'english', 'description_8', NULL, 'publisher_8'),
(218, NULL, 'title_9', '90.30', '2003-08-29', 'physical', 13, 50, 'dimension_9', NULL, 'isbn10_9', 'isbn13_9', 'english', 'description_9', NULL, 'publisher_9'),
(219, NULL, 'title_10', '95.64', '1995-01-03', 'physical', 11, 55, 'dimension_10', NULL, 'isbn10_10', 'isbn13_10', 'english', 'description_10', NULL, 'publisher_10'),
(220, NULL, 'title_11', '27.18', '1993-06-03', 'physical', 13, 65, 'dimension_11', NULL, 'isbn10_11', 'isbn13_11', 'english', 'description_11', NULL, 'publisher_11'),
(221, NULL, 'title_12', '81.48', '2012-12-10', 'physical', 11, 98, 'dimension_12', NULL, 'isbn10_12', 'isbn13_12', 'english', 'description_12', NULL, 'publisher_12'),
(222, NULL, 'title_13', '94.65', '1992-05-01', 'physical', 13, 71, 'dimension_13', NULL, 'isbn10_13', 'isbn13_13', 'english', 'description_13', NULL, 'publisher_13'),
(223, NULL, 'title_14', '25.45', '1993-11-23', 'physical', 13, 60, 'dimension_14', NULL, 'isbn10_14', 'isbn13_14', 'english', 'description_14', NULL, 'publisher_14'),
(224, NULL, 'title_15', '40.21', '2009-07-02', 'physical', 11, 65, 'dimension_15', NULL, 'isbn10_15', 'isbn13_15', 'english', 'description_15', NULL, 'publisher_15'),
(225, NULL, 'title_16', '86.11', '2006-01-15', 'physical', 12, 88, 'dimension_16', NULL, 'isbn10_16', 'isbn13_16', 'english', 'description_16', NULL, 'publisher_16'),
(226, NULL, 'title_17', '65.23', '1991-10-02', 'physical', 13, 79, 'dimension_17', NULL, 'isbn10_17', 'isbn13_17', 'english', 'description_17', NULL, 'publisher_17'),
(227, NULL, 'title_18', '87.98', '1998-02-04', 'physical', 14, 92, 'dimension_18', NULL, 'isbn10_18', 'isbn13_18', 'english', 'description_18', NULL, 'publisher_18'),
(228, NULL, 'title_19', '89.56', '1990-10-28', 'physical', 10, 72, 'dimension_19', NULL, 'isbn10_19', 'isbn13_19', 'english', 'description_19', NULL, 'publisher_19'),
(229, NULL, 'title_20', '7.77', '1994-05-03', 'physical', 10, 83, 'dimension_20', NULL, 'isbn10_20', 'isbn13_20', 'english', 'description_20', NULL, 'publisher_20'),
(230, NULL, 'title_21', '29.57', '2008-08-28', 'physical', 14, 84, 'dimension_21', NULL, 'isbn10_21', 'isbn13_21', 'english', 'description_21', NULL, 'publisher_21'),
(231, NULL, 'title_22', '29.97', '2009-03-30', 'physical', 13, 57, 'dimension_22', NULL, 'isbn10_22', 'isbn13_22', 'english', 'description_22', NULL, 'publisher_22'),
(232, NULL, 'title_23', '94.34', '2008-06-16', 'physical', 13, 75, 'dimension_23', NULL, 'isbn10_23', 'isbn13_23', 'english', 'description_23', NULL, 'publisher_23'),
(233, NULL, 'title_24', '49.92', '1993-02-07', 'physical', 15, 97, 'dimension_24', NULL, 'isbn10_24', 'isbn13_24', 'english', 'description_24', NULL, 'publisher_24'),
(234, NULL, 'title_25', '93.67', '1991-10-09', 'physical', 14, 51, 'dimension_25', NULL, 'isbn10_25', 'isbn13_25', 'english', 'description_25', NULL, 'publisher_25'),
(235, NULL, 'title_26', '84.96', '2011-11-01', 'physical', 12, 65, 'dimension_26', NULL, 'isbn10_26', 'isbn13_26', 'english', 'description_26', NULL, 'publisher_26'),
(236, NULL, 'title_27', '38.05', '1992-09-10', 'physical', 12, 58, 'dimension_27', NULL, 'isbn10_27', 'isbn13_27', 'english', 'description_27', NULL, 'publisher_27'),
(237, NULL, 'title_28', '71.11', '2015-09-04', 'physical', 11, 71, 'dimension_28', NULL, 'isbn10_28', 'isbn13_28', 'english', 'description_28', NULL, 'publisher_28'),
(238, NULL, 'title_29', '75.06', '2003-08-28', 'physical', 11, 72, 'dimension_29', NULL, 'isbn10_29', 'isbn13_29', 'english', 'description_29', NULL, 'publisher_29'),
(239, NULL, 'title_30', '68.67', '2015-03-30', 'physical', 11, 58, 'dimension_30', NULL, 'isbn10_30', 'isbn13_30', 'english', 'description_30', NULL, 'publisher_30'),
(240, NULL, 'title_31', '95.27', '2007-05-23', 'physical', 14, 61, 'dimension_31', NULL, 'isbn10_31', 'isbn13_31', 'english', 'description_31', NULL, 'publisher_31'),
(241, NULL, 'title_32', '55.09', '2016-07-18', 'physical', 12, 64, 'dimension_32', NULL, 'isbn10_32', 'isbn13_32', 'english', 'description_32', NULL, 'publisher_32'),
(242, NULL, 'title_33', '96.84', '2015-01-06', 'physical', 12, 92, 'dimension_33', NULL, 'isbn10_33', 'isbn13_33', 'english', 'description_33', NULL, 'publisher_33'),
(243, NULL, 'title_34', '96.16', '2007-10-18', 'physical', 14, 87, 'dimension_34', NULL, 'isbn10_34', 'isbn13_34', 'english', 'description_34', NULL, 'publisher_34'),
(244, NULL, 'title_35', '52.07', '2009-11-22', 'physical', 14, 55, 'dimension_35', NULL, 'isbn10_35', 'isbn13_35', 'english', 'description_35', NULL, 'publisher_35'),
(245, NULL, 'title_36', '22.42', '1999-10-20', 'physical', 13, 97, 'dimension_36', NULL, 'isbn10_36', 'isbn13_36', 'english', 'description_36', NULL, 'publisher_36'),
(246, NULL, 'title_37', '6.22', '2010-03-01', 'physical', 11, 60, 'dimension_37', NULL, 'isbn10_37', 'isbn13_37', 'english', 'description_37', NULL, 'publisher_37'),
(247, NULL, 'title_38', '45.48', '2001-07-31', 'physical', 13, 92, 'dimension_38', NULL, 'isbn10_38', 'isbn13_38', 'english', 'description_38', NULL, 'publisher_38'),
(248, NULL, 'title_39', '65.95', '1996-04-28', 'physical', 14, 89, 'dimension_39', NULL, 'isbn10_39', 'isbn13_39', 'english', 'description_39', NULL, 'publisher_39'),
(249, NULL, 'title_40', '53.63', '2010-10-18', 'physical', 13, 56, 'dimension_40', NULL, 'isbn10_40', 'isbn13_40', 'english', 'description_40', NULL, 'publisher_40'),
(250, NULL, 'title_41', '93.65', '2007-06-03', 'physical', 14, 73, 'dimension_41', NULL, 'isbn10_41', 'isbn13_41', 'english', 'description_41', NULL, 'publisher_41'),
(251, NULL, 'title_42', '57.91', '2004-03-28', 'physical', 13, 85, 'dimension_42', NULL, 'isbn10_42', 'isbn13_42', 'english', 'description_42', NULL, 'publisher_42'),
(252, NULL, 'title_43', '69.97', '2007-11-30', 'physical', 13, 92, 'dimension_43', NULL, 'isbn10_43', 'isbn13_43', 'english', 'description_43', NULL, 'publisher_43'),
(253, NULL, 'title_44', '50.27', '1992-02-05', 'physical', 10, 84, 'dimension_44', NULL, 'isbn10_44', 'isbn13_44', 'english', 'description_44', NULL, 'publisher_44'),
(254, NULL, 'title_45', '23.62', '1991-07-05', 'physical', 10, 71, 'dimension_45', NULL, 'isbn10_45', 'isbn13_45', 'english', 'description_45', NULL, 'publisher_45'),
(255, NULL, 'title_46', '93.78', '2003-07-22', 'physical', 13, 77, 'dimension_46', NULL, 'isbn10_46', 'isbn13_46', 'english', 'description_46', NULL, 'publisher_46'),
(256, NULL, 'title_47', '88.82', '1993-10-03', 'physical', 13, 60, 'dimension_47', NULL, 'isbn10_47', 'isbn13_47', 'english', 'description_47', NULL, 'publisher_47'),
(257, NULL, 'title_48', '39.37', '2010-09-24', 'physical', 10, 73, 'dimension_48', NULL, 'isbn10_48', 'isbn13_48', 'english', 'description_48', NULL, 'publisher_48'),
(258, NULL, 'title_49', '23.02', '2000-07-04', 'physical', 12, 64, 'dimension_49', NULL, 'isbn10_49', 'isbn13_49', 'english', 'description_49', NULL, 'publisher_49'),
(259, NULL, 'title_1', '85.01', '1996-10-30', 'digital', 11, 67, NULL, 'size_1', 'isbn10_1', 'isbn13_1', 'english', 'description_1', NULL, 'publisher_1'),
(260, NULL, 'title_2', '40.25', '1993-05-28', 'digital', 11, 62, NULL, 'size_2', 'isbn10_2', 'isbn13_2', 'english', 'description_2', NULL, 'publisher_2'),
(261, NULL, 'title_3', '69.95', '1996-05-05', 'digital', 13, 57, NULL, 'size_3', 'isbn10_3', 'isbn13_3', 'english', 'description_3', NULL, 'publisher_3'),
(262, NULL, 'title_4', '64.73', '1995-07-31', 'digital', 15, 79, NULL, 'size_4', 'isbn10_4', 'isbn13_4', 'english', 'description_4', NULL, 'publisher_4'),
(263, NULL, 'title_5', '95.61', '2014-12-02', 'digital', 12, 56, NULL, 'size_5', 'isbn10_5', 'isbn13_5', 'english', 'description_5', NULL, 'publisher_5'),
(264, NULL, 'title_6', '21.05', '2002-10-28', 'digital', 10, 87, NULL, 'size_6', 'isbn10_6', 'isbn13_6', 'english', 'description_6', NULL, 'publisher_6'),
(265, NULL, 'title_7', '50.99', '2009-11-16', 'digital', 14, 64, NULL, 'size_7', 'isbn10_7', 'isbn13_7', 'english', 'description_7', NULL, 'publisher_7'),
(266, NULL, 'title_8', '98.65', '2013-06-17', 'digital', 13, 90, NULL, 'size_8', 'isbn10_8', 'isbn13_8', 'english', 'description_8', NULL, 'publisher_8'),
(267, NULL, 'title_9', '13.99', '2014-09-28', 'digital', 11, 64, NULL, 'size_9', 'isbn10_9', 'isbn13_9', 'english', 'description_9', NULL, 'publisher_9'),
(268, NULL, 'title_10', '14.18', '1999-03-30', 'digital', 15, 85, NULL, 'size_10', 'isbn10_10', 'isbn13_10', 'english', 'description_10', NULL, 'publisher_10'),
(269, NULL, 'title_11', '74.92', '2000-05-08', 'digital', 14, 56, NULL, 'size_11', 'isbn10_11', 'isbn13_11', 'english', 'description_11', NULL, 'publisher_11'),
(270, NULL, 'title_12', '27.45', '1993-12-27', 'digital', 12, 90, NULL, 'size_12', 'isbn10_12', 'isbn13_12', 'english', 'description_12', NULL, 'publisher_12'),
(271, NULL, 'title_13', '66.46', '1993-10-20', 'digital', 11, 87, NULL, 'size_13', 'isbn10_13', 'isbn13_13', 'english', 'description_13', NULL, 'publisher_13'),
(272, NULL, 'title_14', '90.88', '2006-11-13', 'digital', 10, 67, NULL, 'size_14', 'isbn10_14', 'isbn13_14', 'english', 'description_14', NULL, 'publisher_14'),
(273, NULL, 'title_15', '45.13', '2013-07-14', 'digital', 12, 64, NULL, 'size_15', 'isbn10_15', 'isbn13_15', 'english', 'description_15', NULL, 'publisher_15'),
(274, NULL, 'title_16', '44.66', '2009-09-06', 'digital', 10, 73, NULL, 'size_16', 'isbn10_16', 'isbn13_16', 'english', 'description_16', NULL, 'publisher_16'),
(275, NULL, 'title_17', '16.25', '2010-04-24', 'digital', 14, 74, NULL, 'size_17', 'isbn10_17', 'isbn13_17', 'english', 'description_17', NULL, 'publisher_17'),
(276, NULL, 'title_18', '87.64', '1990-09-06', 'digital', 11, 93, NULL, 'size_18', 'isbn10_18', 'isbn13_18', 'english', 'description_18', NULL, 'publisher_18'),
(277, NULL, 'title_19', '86.49', '1996-04-25', 'digital', 11, 76, NULL, 'size_19', 'isbn10_19', 'isbn13_19', 'english', 'description_19', NULL, 'publisher_19'),
(278, NULL, 'title_20', '17.05', '2014-07-06', 'digital', 10, 99, NULL, 'size_20', 'isbn10_20', 'isbn13_20', 'english', 'description_20', NULL, 'publisher_20'),
(279, NULL, 'title_21', '74.64', '1995-08-28', 'digital', 13, 97, NULL, 'size_21', 'isbn10_21', 'isbn13_21', 'english', 'description_21', NULL, 'publisher_21'),
(280, NULL, 'title_22', '74.21', '1993-03-17', 'digital', 11, 99, NULL, 'size_22', 'isbn10_22', 'isbn13_22', 'english', 'description_22', NULL, 'publisher_22'),
(281, NULL, 'title_23', '54.66', '1997-02-23', 'digital', 10, 96, NULL, 'size_23', 'isbn10_23', 'isbn13_23', 'english', 'description_23', NULL, 'publisher_23'),
(282, NULL, 'title_24', '59.93', '2013-01-26', 'digital', 15, 65, NULL, 'size_24', 'isbn10_24', 'isbn13_24', 'english', 'description_24', NULL, 'publisher_24'),
(283, NULL, 'title_25', '64.58', '2008-11-02', 'digital', 13, 98, NULL, 'size_25', 'isbn10_25', 'isbn13_25', 'english', 'description_25', NULL, 'publisher_25'),
(284, NULL, 'title_26', '10.67', '2004-09-04', 'digital', 10, 95, NULL, 'size_26', 'isbn10_26', 'isbn13_26', 'english', 'description_26', NULL, 'publisher_26'),
(285, NULL, 'title_27', '37.48', '2015-11-22', 'digital', 11, 80, NULL, 'size_27', 'isbn10_27', 'isbn13_27', 'english', 'description_27', NULL, 'publisher_27'),
(286, NULL, 'title_28', '62.81', '2010-02-01', 'digital', 12, 62, NULL, 'size_28', 'isbn10_28', 'isbn13_28', 'english', 'description_28', NULL, 'publisher_28'),
(287, NULL, 'title_29', '96.03', '2012-10-05', 'digital', 14, 89, NULL, 'size_29', 'isbn10_29', 'isbn13_29', 'english', 'description_29', NULL, 'publisher_29'),
(288, NULL, 'title_30', '38.65', '2004-06-26', 'digital', 11, 79, NULL, 'size_30', 'isbn10_30', 'isbn13_30', 'english', 'description_30', NULL, 'publisher_30'),
(289, NULL, 'title_31', '38.87', '2015-08-14', 'digital', 11, 80, NULL, 'size_31', 'isbn10_31', 'isbn13_31', 'english', 'description_31', NULL, 'publisher_31'),
(290, NULL, 'title_32', '59.91', '2014-01-26', 'digital', 14, 75, NULL, 'size_32', 'isbn10_32', 'isbn13_32', 'english', 'description_32', NULL, 'publisher_32'),
(291, NULL, 'title_33', '21.81', '2005-05-24', 'digital', 13, 77, NULL, 'size_33', 'isbn10_33', 'isbn13_33', 'english', 'description_33', NULL, 'publisher_33'),
(292, NULL, 'title_34', '7.78', '2002-07-30', 'digital', 13, 52, NULL, 'size_34', 'isbn10_34', 'isbn13_34', 'english', 'description_34', NULL, 'publisher_34'),
(293, NULL, 'title_35', '66.94', '2012-07-07', 'digital', 14, 81, NULL, 'size_35', 'isbn10_35', 'isbn13_35', 'english', 'description_35', NULL, 'publisher_35'),
(294, NULL, 'title_36', '64.84', '2007-12-12', 'digital', 14, 81, NULL, 'size_36', 'isbn10_36', 'isbn13_36', 'english', 'description_36', NULL, 'publisher_36'),
(295, NULL, 'title_37', '96.41', '1990-01-10', 'digital', 15, 99, NULL, 'size_37', 'isbn10_37', 'isbn13_37', 'english', 'description_37', NULL, 'publisher_37'),
(296, NULL, 'title_38', '97.08', '1991-04-04', 'digital', 14, 95, NULL, 'size_38', 'isbn10_38', 'isbn13_38', 'english', 'description_38', NULL, 'publisher_38'),
(297, NULL, 'title_39', '28.01', '2001-12-15', 'digital', 15, 66, NULL, 'size_39', 'isbn10_39', 'isbn13_39', 'english', 'description_39', NULL, 'publisher_39'),
(298, NULL, 'title_40', '62.63', '2013-09-24', 'digital', 14, 67, NULL, 'size_40', 'isbn10_40', 'isbn13_40', 'english', 'description_40', NULL, 'publisher_40'),
(299, NULL, 'title_41', '47.16', '2010-01-08', 'digital', 15, 89, NULL, 'size_41', 'isbn10_41', 'isbn13_41', 'english', 'description_41', NULL, 'publisher_41'),
(300, NULL, 'title_42', '21.73', '2001-10-05', 'digital', 11, 74, NULL, 'size_42', 'isbn10_42', 'isbn13_42', 'english', 'description_42', NULL, 'publisher_42'),
(301, NULL, 'title_43', '70.90', '2014-10-08', 'digital', 11, 59, NULL, 'size_43', 'isbn10_43', 'isbn13_43', 'english', 'description_43', NULL, 'publisher_43'),
(302, NULL, 'title_44', '8.90', '1998-05-17', 'digital', 11, 62, NULL, 'size_44', 'isbn10_44', 'isbn13_44', 'english', 'description_44', NULL, 'publisher_44'),
(303, NULL, 'title_45', '47.94', '2001-10-04', 'digital', 12, 65, NULL, 'size_45', 'isbn10_45', 'isbn13_45', 'english', 'description_45', NULL, 'publisher_45'),
(304, NULL, 'title_46', '34.22', '1998-09-04', 'digital', 12, 98, NULL, 'size_46', 'isbn10_46', 'isbn13_46', 'english', 'description_46', NULL, 'publisher_46'),
(305, NULL, 'title_47', '64.47', '2009-03-20', 'digital', 13, 83, NULL, 'size_47', 'isbn10_47', 'isbn13_47', 'english', 'description_47', NULL, 'publisher_47'),
(306, NULL, 'title_48', '82.04', '2014-01-04', 'digital', 10, 50, NULL, 'size_48', 'isbn10_48', 'isbn13_48', 'english', 'description_48', NULL, 'publisher_48'),
(307, NULL, 'title_49', '84.99', '2010-08-22', 'digital', 13, 62, NULL, 'size_49', 'isbn10_49', 'isbn13_49', 'english', 'description_49', NULL, 'publisher_49');

-- --------------------------------------------------------

--
-- Table structure for table `card`
--

CREATE TABLE `card` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_user` int(10) UNSIGNED NOT NULL,
  `number` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `ccv` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `expire` date NOT NULL,
  `owner` varchar(128) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id_user` int(10) UNSIGNED NOT NULL,
  `id_book` int(10) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promotion`
--

CREATE TABLE `promotion` (
  `id` int(10) UNSIGNED NOT NULL,
  `end` date NOT NULL,
  `discount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_user` int(10) UNSIGNED NOT NULL,
  `id_card` int(10) UNSIGNED NOT NULL,
  `id_address` int(10) UNSIGNED NOT NULL,
  `id_shipping` int(10) UNSIGNED DEFAULT NULL,
  `tot` decimal(5,2) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `shipping_cost` decimal(5,2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `id_user` int(10) UNSIGNED NOT NULL,
  `id_book` int(10) UNSIGNED NOT NULL,
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `vote` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shipping`
--

CREATE TABLE `shipping` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(5,2) NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sold`
--

CREATE TABLE `sold` (
  `id_book` int(10) UNSIGNED NOT NULL,
  `id_purchase` int(10) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `price` decimal(5,2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `textpage`
--

CREATE TABLE `textpage` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `telephone` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `birth_day` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id_user` int(10) UNSIGNED NOT NULL,
  `id_book` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `writes`
--

CREATE TABLE `writes` (
  `id_author` int(11) UNSIGNED NOT NULL,
  `id_book` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `be`
--
ALTER TABLE `be`
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_groups` (`id_groups`);

--
-- Indexes for table `belongs`
--
ALTER TABLE `belongs`
  ADD KEY `id_category` (`id_category`),
  ADD KEY `id_book` (`id_book`);

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_promotion` (`id_promotion`);

--
-- Indexes for table `card`
--
ALTER TABLE `card`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_book` (`id_book`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `promotion`
--
ALTER TABLE `promotion`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_shipping` (`id_shipping`),
  ADD KEY `id_card` (`id_card`),
  ADD KEY `id_address` (`id_address`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_book` (`id_book`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `shipping`
--
ALTER TABLE `shipping`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sold`
--
ALTER TABLE `sold`
  ADD KEY `id_book` (`id_book`),
  ADD KEY `id_order` (`id_purchase`);

--
-- Indexes for table `textpage`
--
ALTER TABLE `textpage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_book` (`id_book`);

--
-- Indexes for table `writes`
--
ALTER TABLE `writes`
  ADD KEY `id_author` (`id_author`),
  ADD KEY `id_book` (`id_book`),
  ADD KEY `id_author_2` (`id_author`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `author`
--
ALTER TABLE `author`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;
--
-- AUTO_INCREMENT for table `book`
--
ALTER TABLE `book`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=308;
--
-- AUTO_INCREMENT for table `card`
--
ALTER TABLE `card`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `promotion`
--
ALTER TABLE `promotion`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `shipping`
--
ALTER TABLE `shipping`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `textpage`
--
ALTER TABLE `textpage`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `be`
--
ALTER TABLE `be`
  ADD CONSTRAINT `be_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `be_ibfk_2` FOREIGN KEY (`id_groups`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `belongs`
--
ALTER TABLE `belongs`
  ADD CONSTRAINT `belongs_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `belongs_ibfk_2` FOREIGN KEY (`id_book`) REFERENCES `book` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `book`
--
ALTER TABLE `book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`id_promotion`) REFERENCES `promotion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `card`
--
ALTER TABLE `card`
  ADD CONSTRAINT `card_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`id_book`) REFERENCES `book` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `purchase_ibfk_2` FOREIGN KEY (`id_shipping`) REFERENCES `shipping` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `purchase_ibfk_3` FOREIGN KEY (`id_card`) REFERENCES `card` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `purchase_ibfk_4` FOREIGN KEY (`id_address`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`id_book`) REFERENCES `book` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sold`
--
ALTER TABLE `sold`
  ADD CONSTRAINT `sold_ibfk_1` FOREIGN KEY (`id_book`) REFERENCES `book` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `sold_ibfk_2` FOREIGN KEY (`id_purchase`) REFERENCES `purchase` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`id_book`) REFERENCES `book` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `writes`
--
ALTER TABLE `writes`
  ADD CONSTRAINT `writes_ibfk_1` FOREIGN KEY (`id_author`) REFERENCES `author` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `writes_ibfk_2` FOREIGN KEY (`id_book`) REFERENCES `book` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
