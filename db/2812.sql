-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Dec 28, 2016 at 04:55 PM
-- Server version: 5.5.49-log
-- PHP Version: 7.0.9

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_test_data_author`(IN `n` INT)
BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_test_data_book_di`()
BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_test_data_book_ph`()
BEGIN
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

CREATE TABLE IF NOT EXISTS `address` (
  `id` int(10) unsigned NOT NULL,
  `id_user` int(10) unsigned NOT NULL,
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

CREATE TABLE IF NOT EXISTS `author` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `biography` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`id`, `name`, `biography`) VALUES
(74, 'J.K. Rowling', NULL),
(75, 'Primo Autore', NULL),
(78, 'Secondo Autore', NULL),
(79, 'Terzo Autore', NULL),
(80, 'Quarto Autore', NULL),
(81, 'Gino', NULL),
(82, 'Peppino', NULL),
(83, 'Franco', NULL),
(88, 'Ciccio Cicci', NULL),
(89, 'Cic Cioc', NULL),
(90, 'Pino Pini', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `belongs`
--

CREATE TABLE IF NOT EXISTS `belongs` (
  `id_category` int(10) unsigned NOT NULL,
  `id_book` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE IF NOT EXISTS `book` (
  `id` int(10) unsigned NOT NULL,
  `id_promotion` int(10) unsigned DEFAULT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(5,2) NOT NULL,
  `publication_date` date NOT NULL,
  `availability` mediumint(8) unsigned NOT NULL,
  `pages` mediumint(8) unsigned NOT NULL,
  `dimension` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isbn13` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `cover` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `publisher` varchar(128) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`id`, `id_promotion`, `title`, `price`, `publication_date`, `availability`, `pages`, `dimension`, `isbn13`, `language`, `description`, `cover`, `publisher`) VALUES
(9, NULL, 'Libro 2', 188.00, '1111-12-12', 333, 3333, '4*4*4', '978-1-11-234567-1', 'English', 'lalalalaalalalalalalalalala', '9781785041273.jpg', 'non lo so'),
(12, NULL, 'Pippo', 999.00, '1111-11-11', 111, 11, '5*5*5', '978-1-11-123456-1', 'English', 'kryfskrfykzryyfjzrfjrjzj', '9780593077566.jpg', 'hhhhhh'),
(13, NULL, 'pippino', 999.00, '4444-04-04', 444, 4444, '44', '978-1-11-234567-1', 'English', 'dzgjnzdjnzdgzjzg', '482037_485356208142174_762360997_n.jpg', 'hhhh');

-- --------------------------------------------------------

--
-- Table structure for table `card`
--

CREATE TABLE IF NOT EXISTS `card` (
  `id` int(10) unsigned NOT NULL,
  `id_user` int(10) unsigned NOT NULL,
  `number` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `ccv` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `expire` date NOT NULL,
  `owner` varchar(128) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE IF NOT EXISTS `cart` (
  `id_user` int(10) unsigned NOT NULL,
  `id_book` int(10) unsigned NOT NULL,
  `amount` smallint(5) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`) VALUES
(1, 'Administrators');

-- --------------------------------------------------------

--
-- Table structure for table `groupservice`
--

CREATE TABLE IF NOT EXISTS `groupservice` (
  `id_group` int(11) unsigned NOT NULL,
  `id_service` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `groupservice`
--

INSERT INTO `groupservice` (`id_group`, `id_service`) VALUES
(1, 1),
(1, 2),
(1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `promotion`
--

CREATE TABLE IF NOT EXISTS `promotion` (
  `id` int(10) unsigned NOT NULL,
  `end` date NOT NULL,
  `discount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE IF NOT EXISTS `purchase` (
  `id` int(10) unsigned NOT NULL,
  `id_user` int(10) unsigned NOT NULL,
  `id_card` int(10) unsigned NOT NULL,
  `id_address` int(10) unsigned NOT NULL,
  `tot` decimal(5,2) unsigned NOT NULL,
  `date` date NOT NULL,
  `shipping_cost` decimal(5,2) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE IF NOT EXISTS `review` (
  `id_user` int(10) unsigned NOT NULL,
  `id_book` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `vote` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE IF NOT EXISTS `service` (
  `id` int(11) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` text
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`id`, `name`, `description`) VALUES
(1, 'index.php', 'Admin dashboard'),
(2, 'book_add.php', 'Insert a new book'),
(3, 'book_edit.php', 'View/Edit/Delete books');

-- --------------------------------------------------------

--
-- Table structure for table `slider`
--

CREATE TABLE IF NOT EXISTS `slider` (
  `id` int(11) NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(512) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sold`
--

CREATE TABLE IF NOT EXISTS `sold` (
  `id_book` int(10) unsigned NOT NULL,
  `id_purchase` int(10) unsigned NOT NULL,
  `amount` smallint(5) unsigned NOT NULL,
  `price` decimal(5,2) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `textpage`
--

CREATE TABLE IF NOT EXISTS `textpage` (
  `id` int(10) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `subtitle` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `position` int(11) DEFAULT NULL,
  `active` int(11) NOT NULL,
  `section` varchar(32) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `textpage`
--

INSERT INTO `textpage` (`id`, `title`, `subtitle`, `body`, `position`, `active`, `section`) VALUES
(2, '', '', '"Reading is going toward something that is about to be, and no one yet knows what it will be." - Italo Calvino.', 1, 1, 'quote'),
(4, 'Here''s what you can do', 'We swear that this do not happen often, if you start visiting this page too many times you can try some of the following tips:', '<ul class="unorder-list">\r\n\r\n<li>Go back and try again</li>\r\n							<li>Clean your cookies/cache</li>\r\n		\r\n<li>Try to restart your browser or switch to another one</li>\r\n					<li>There may be a maintenance ongoing on our server, so please be patient and wait some minutes</li>					\r\n						</ul>\r\n\r\n\r\n\r\n', NULL, 1, 'error_hints'),
(5, 'Error: Wrong Email/Password', '', 'You are here because the Email/Password you inserted are wrong, please go back and try again.', NULL, 1, 'error_login');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `telephone` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birth_day` date DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `surname`, `email`, `password`, `telephone`, `birth_day`) VALUES
(2, 'Stefano', 'Valentini', 'stefano.valentini2@student.univaq.it', '553c4de744e222474898b2e4ff80a85b', NULL, NULL),
(3, 'pippo', 'pippi', 'pippo@pippi.it', '0c88028bf3aa6a6a143ed846f2be1ea4', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `usergroup`
--

CREATE TABLE IF NOT EXISTS `usergroup` (
  `id_user` int(10) unsigned NOT NULL,
  `id_group` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `usergroup`
--

INSERT INTO `usergroup` (`id_user`, `id_group`) VALUES
(3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE IF NOT EXISTS `wishlist` (
  `id_user` int(10) unsigned NOT NULL,
  `id_book` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `writes`
--

CREATE TABLE IF NOT EXISTS `writes` (
  `id_author` int(11) unsigned NOT NULL,
  `id_book` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `writes`
--

INSERT INTO `writes` (`id_author`, `id_book`) VALUES
(81, 9),
(82, 9),
(83, 9),
(88, 12),
(89, 12),
(74, 12),
(74, 13),
(90, 13);

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
  ADD UNIQUE KEY `title` (`title`),
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
-- Indexes for table `groupservice`
--
ALTER TABLE `groupservice`
  ADD KEY `id_group` (`id_group`),
  ADD KEY `id_service` (`id_service`);

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
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `slider`
--
ALTER TABLE `slider`
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
-- Indexes for table `usergroup`
--
ALTER TABLE `usergroup`
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_groups` (`id_group`);

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
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `author`
--
ALTER TABLE `author`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=91;
--
-- AUTO_INCREMENT for table `book`
--
ALTER TABLE `book`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `card`
--
ALTER TABLE `card`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `promotion`
--
ALTER TABLE `promotion`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `slider`
--
ALTER TABLE `slider`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `textpage`
--
ALTER TABLE `textpage`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Constraints for table `groupservice`
--
ALTER TABLE `groupservice`
  ADD CONSTRAINT `groupservice_ibfk_1` FOREIGN KEY (`id_group`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `groupservice_ibfk_2` FOREIGN KEY (`id_service`) REFERENCES `service` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
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
-- Constraints for table `usergroup`
--
ALTER TABLE `usergroup`
  ADD CONSTRAINT `usergroup_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usergroup_ibfk_2` FOREIGN KEY (`id_group`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
