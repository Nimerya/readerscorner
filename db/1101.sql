-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 11, 2017 at 03:57 PM
-- Server version: 5.6.33
-- PHP Version: 7.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `readerscorner`
--

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
  `biography` text COLLATE utf8_unicode_ci,
  `photo` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`id`, `name`, `biography`, `photo`) VALUES
(74, 'J.K. Rowling', 'Joanne "Jo" Rowling, OBE, FRSL (/ˈroʊlɪŋ/; born 31 July 1965), pen names J. K. Rowling and Robert Galbraith, is a British novelist, screenwriter and film producer best known as the author of the Harry Potter fantasy series. The books have gained worldwide attention, won multiple awards, and sold more than 400 million copies.[1] They have become the best-selling book series in history[2] and been the basis for a series of films over which Rowling had overall approval on the scripts[3] and maintained creative control by serving as a producer on the final instalment.[4]\r\n\r\nBorn in Yate, Gloucestershire, England, Rowling was working as a researcher and bilingual secretary for Amnesty International when she conceived the idea for the Harry Potter series while on a delayed train from Manchester to London in 1990.[5] The seven-year period that followed saw the death of her mother, birth of her first child, divorce from her first husband and relative poverty until she finished the first novel in the series, Harry Potter and the Philosopher\'s Stone, in 1997. There were six sequels, the last, Harry Potter and the Deathly Hallows, in 2007. Since then, Rowling has written four books for adult readers, The Casual Vacancy (2012) and—under the pseudonym Robert Galbraith—the crime fiction novels The Cuckoo\'s Calling (2013), The Silkworm (2014) and Career of Evil (2015).[6].\'\r\n\r\nRowling has lived a "rags to riches" life story, in which she progressed from living on state benefits to multi-millionaire status within five years. She is the United Kingdom\'s best-selling living author, with sales in excess of £238M.[7] The 2016 Sunday Times Rich List estimated Rowling\'s fortune at £600 million, ranking her as the joint 197th richest person in the UK.[8] Time magazine named her as a runner-up for its 2007 Person of the Year, noting the social, moral, and political inspiration she has given her fans.[9] In October 2010, Rowling was named the "Most Influential Woman in Britain" by leading magazine editors.[10] She has supported charities including Comic Relief, One Parent Families, Multiple Sclerosis Society of Great Britain and Lumos (formerly the Children\'s High Level Group).', '440px-J._K._Rowling_2010.jpg'),
(75, 'Primo Autore', NULL, NULL),
(78, 'Secondo Autore', NULL, NULL),
(80, 'Quarto Autore', NULL, NULL),
(81, 'Gino', '', ''),
(82, 'Peppino', NULL, NULL),
(83, 'Franco2', '', ''),
(90, 'Pino Pini', NULL, NULL),
(92, 'Tina', NULL, NULL),
(93, 'Pino', NULL, NULL),
(94, ' Cacio', NULL, NULL),
(96, 'Pippo Calippo', 'aaaaaaa\r\naaaa\r\naaaaaaa\r\nsssssss\r\naaaa\r\naaaaa\r\na\r\na\r\na\r\na\r\na\r\na\r\na\r\na\r\na\r\na\r\na\r\n', ''),
(97, 'Paul Kalanithi', NULL, NULL),
(98, 'Ciccio', NULL, NULL),
(99, 'Rupi Kaur', '', 'RupiKaur_crBaljit-.jpg'),
(100, 'Ciccietto', NULL, NULL),
(104, 'Ian MacEwan', '', 'photo.jpg'),
(105, 'Patrick Ness', NULL, NULL),
(106, 'Siobhan Dowd', '', ''),
(107, 'Zadie Smith', NULL, NULL),
(108, 'pippo', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_promotion` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(5,2) NOT NULL,
  `publication_date` date NOT NULL,
  `availability` mediumint(8) UNSIGNED NOT NULL,
  `pages` mediumint(8) UNSIGNED NOT NULL,
  `dimension` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `isbn13` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `language` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `cover` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `publisher` varchar(128) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`id`, `id_promotion`, `title`, `price`, `publication_date`, `availability`, `pages`, `dimension`, `isbn13`, `language`, `description`, `cover`, `publisher`) VALUES
(14, NULL, 'Nuov0', '90.00', '2018-02-14', 766, 12, 'un botto grosso', '9789999999999', 'English', 'lalalalalalaalallaaa', '9781472152756.jpg', 'non lo so dyrtbefvwdc'),
(16, NULL, 'aaaa2', '333.00', '2017-01-10', 111, 11, '111 x 222 x 333 | 200g', '9781111111111', 'English', '1111111111111111', '9780571277018.jpg', '1111111111111111'),
(18, NULL, 'NutShell', '21.00', '2014-06-12', 24, 208, '144*222*23 ', '9781911214335', 'English', 'blablabla', '9781911214335.jpg', 'pippo'),
(19, NULL, 'A Monster Calls', '10.10', '2016-04-12', 30, 500, '129 x 198 x 17mm | 195g', '9781406361803', 'English', 'The bestselling novel about love, loss and hope from the twice Carnegie Medal-winning Patrick Ness, soon to be a major motion picture. The bestselling novel about love, loss and hope from the twice Carnegie Medal-winning Patrick Ness, soon to be a major motion picture. Conor has the same dream every night, ever since his mother first fell ill, ever since she started the treatments that don\'t quite seem to be working. But tonight is different. Tonight, when he wakes, there\'s a visitor at his window. It\'s ancient, elemental, a force of nature. And it wants the most dangerous thing of all from Conor. It wants the truth. Patrick Ness takes the final idea of the late, award-winning writer Siobhan Dowd and weaves an extraordinary and heartbreaking tale of mischief, healing and above all, the courage it takes to survive.', '9781406361803.jpg', 'Walker Books Ltd'),
(20, NULL, 'Swing Time', '19.99', '2015-12-29', 400, 1000, '162 x 240 x 40mm | 746g', '9780241144152', 'English', 'Book of the Year 2016: \'Brilliant\' Guardian \'Superb\' Financial Times \'Virtuosic and breathtaking\' Times Literary Supplement \'There is still no better chronicler of the modern British family than Zadie Smith\' Telegraph An ambitious, exuberant new novel moving from north west London to West Africa, from the multi-award-winning author of White Teeth and On Beauty Two brown girls dream of being dancers - but only one, Tracey, has talent. The other has ideas: about rhythm and time, about black bodies and black music, what constitutes a tribe, or makes a person truly free. It\'s a close but complicated childhood friendship that ends abruptly in their early twenties, never to be revisited, but never quite forgotten, either...Dazzlingly energetic and deeply human, Swing Time is a story about friendship and music and stubborn roots, about how we are shaped by these things and how we can survive them. Moving from north-west London to West Africa, it is an exuberant dance to the music of time. Praise for Zadie Smith: \'Smith is the most naturally gifted young novelist around - with a fastidious ear for dialogue and a lethally quiet comic touch. Above all, she can move us\' Times Literary Supplement \'[Smith] packs more intelligence, humour and sheer energy into any given scene than anyone else of her generation\' Sunday Telegraph \'Her dialogue sings and soars; terse, packed and sassy. Smith is simply wonderful: Dickens\'s legitimate daughter\' Independent on NW \'Captivating. Funny, sexy, weird, full of acute social comedy. [Zadie Smith] is up there with the best around\' Evening Standard on NW \'Intensely funny, richly varied, always unexpected. A joyous, optimistic, angry masterpiece. No better English novel will be published this year\' Daily Telegraph on NW \'Exceptionally accomplished...Smith displays a remarkable talent for embracing all the possibilities of language, and time and again she produces images that shout out in their brilliance...An outstanding novelist\' Observer on On Beauty \'Like Forster, Smith possesses a captivating authorial voice - at once authoritative and nonchalant, and capacious enough to accommodate high moral seriousness, laid-back humour and virtually everything in-between\' New York Times on On Beauty', '9780241144152.jpg', 'Penguin Books Ltd');

-- --------------------------------------------------------

--
-- Table structure for table `bookcategory`
--

CREATE TABLE `bookcategory` (
  `id_category` int(10) UNSIGNED NOT NULL,
  `id_book` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookpurchase`
--

CREATE TABLE `bookpurchase` (
  `id_book` int(10) UNSIGNED NOT NULL,
  `id_purchase` int(10) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `price` decimal(5,2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `description`) VALUES
(1, 'Fantascienza', NULL),
(3, 'Giallo', NULL),
(4, 'Arth e Fothography', NULL),
(5, 'Child\'s book', NULL),
(6, 'Health', ''),
(7, 'Computing', NULL),
(8, 'Food e Drink', NULL),
(9, 'Adventure', '');

-- --------------------------------------------------------

--
-- Table structure for table `field_data`
--

CREATE TABLE `field_data` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(128) NOT NULL,
  `placeholder` varchar(1024) DEFAULT NULL,
  `pattern` varchar(1024) DEFAULT NULL,
  `style` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `field_data`
--

INSERT INTO `field_data` (`id`, `name`, `placeholder`, `pattern`, `style`) VALUES
(1, 'active', 'placeholder="1 or 0"', 'min="0" max="1" step="1"', 'width: 15%;'),
(9, 'availability', '', '', 'width:15%;'),
(12, 'cover', '', '', 'width:50%;'),
(2, 'dimension', 'placeholder="www x hhh x dddmm | yyyg"', '', 'width: 30%;'),
(3, 'email', 'placeholder="Your email here"', '', 'width: 50%;'),
(22, 'icon', '', '', 'width: 30%;'),
(21, 'image', '', '', 'width:50%;'),
(4, 'isbn13', 'placeholder="978123456789"', 'pattern="^(?:ISBN(?:-13)?:? )?(?=[0-9]{13}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)97[89][- ]?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9]$" placeholder="978-3-16-148410-0"', 'width: 30%;'),
(11, 'language', 'value="English";', '', 'width: 20%;'),
(15, 'name', '', '', 'width: 50%;'),
(10, 'pages', '', '', 'width:15%;'),
(19, 'pattern', 'placeholder="regex or min/max/step for numbers"', '', 'width:75%;'),
(16, 'photo', '', '', 'width:50%;'),
(18, 'placeholder', '', '', 'width:50%;'),
(17, 'position', '', '', 'width:15%;'),
(5, 'price', 'placeholder="123.45"', 'min="0.01" step="0.01"', 'width: 15%;'),
(6, 'publication_date', '', '', 'width: 20%;'),
(13, 'publisher', '', '', 'width:30%;'),
(7, 'section', 'placeholder="Indicates the belonging category"', '', 'width: 50%;'),
(8, 'title', '', '', 'width: 50%;');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`) VALUES
(1, 'Administrators', ''),
(2, 'Warehousemen', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `groupservice`
--

CREATE TABLE `groupservice` (
  `id_group` int(11) UNSIGNED NOT NULL,
  `id_service` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `groupservice`
--

INSERT INTO `groupservice` (`id_group`, `id_service`) VALUES
(1, 1),
(1, 3),
(1, 4),
(1, 6),
(2, 1),
(2, 3),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11);

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
  `tot` decimal(5,2) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `shipping_cost` decimal(5,2) UNSIGNED NOT NULL,
  `status` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'waiting for payment, in preparation, shipped, delivered'
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
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 NOT NULL,
  `description` text CHARACTER SET latin1,
  `icon` varchar(256) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`id`, `name`, `description`, `icon`) VALUES
(1, 'index.php', 'Admin dashboard', ''),
(3, 'book.php', 'Insert/View/Edit/Delete books', 'fa-book'),
(4, 'textpage.php', NULL, 'fa-file-text-o'),
(6, 'author.php', NULL, 'fa-group'),
(7, 'category.php', '', 'fa-list-alt'),
(8, 'field_data.php', NULL, 'fa-code'),
(9, 'slider.php', NULL, 'fa-picture-o'),
(10, 'service.php', NULL, 'fa-th'),
(11, 'groups.php', '', 'fa-shield');

-- --------------------------------------------------------

--
-- Table structure for table `slider`
--

CREATE TABLE `slider` (
  `id` int(11) NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `image` varchar(512) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `slider`
--

INSERT INTO `slider` (`id`, `title`, `body`, `image`) VALUES
(7, 'Welcome to The Reader\'s Corner!', 'wowowowowowowowowowowow', 'BooksSlider.png'),
(8, 'Fantastic Beasts and Where to Find Them', 'wooooooooooo', 'Fantastic-Beasts-and-Where-to-Find-Them-final-poster-banner.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `textpage`
--

CREATE TABLE `textpage` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `subtitle` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `position` int(11) DEFAULT NULL,
  `active` int(11) NOT NULL,
  `section` varchar(32) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `textpage`
--

INSERT INTO `textpage` (`id`, `title`, `subtitle`, `body`, `position`, `active`, `section`) VALUES
(2, 'Quote', '', '"Reading is going toward something that is about to be, and no one yet knows what it will be." - Italo Calvino.', 0, 1, 'quote'),
(4, 'Here\'s what you can do', 'We swear that this do not happen often, if you start visiting this page too many times you can try some of the following tips:', '<ul class="unorder-list">\r\n<li>Go back and try again</li>\r\n<li>Clean your cookies/cache</li>\r\n<li>Try to restart your browser or switch to another one</li>\r\n<li>There may be a maintenance ongoing on our server, so please be patient and wait some minutes</li>					\r\n</ul>', 0, 1, 'error_hints'),
(5, 'Error: Login', '', 'You are here because the Email/Password you inserted is wrong, please go back and try again.', 0, 1, 'error_login'),
(7, 'Error: Access Denied', '', 'This happens when you try to access an area that is not available for you or your user group.\r\n', 0, 1, 'error_permission'),
(8, 'Error: System', '', 'This is usually our fault, there is nothing you can do.\r\nTry to wait a couple of minutes and try again.', 0, 1, 'error_system'),
(9, 'Error: Database Connection', '', 'This is usually our fault.\r\nThere may be a maintenence ongoing on our servers, please try again later. ', 0, 1, 'error_db_connection'),
(10, 'Error: Report', '', 'There are problems querying the database to get the report you requested.<br>\r\nThis happens when an error occurs running a SELECT query, please check the database and be sure it is online.', 0, 1, 'error_report'),
(11, 'Error: Getting Data from DB', '', 'There are problems getting the item\'s info you requested.<br>\r\nThis happens when an error occurs running a SELECT query, please check the database and be sure it is online.', 0, 1, 'error_get'),
(12, 'Error: Update', '', 'There are problems updating the data you are trying to edit.<br>\r\nThis happens when an error occurs running an UPDATE query, please check the database and be sure it is online.', 0, 1, 'error_update'),
(13, 'Error: Referential Constraint', '', 'There are problems with the item\'s referential constraint you are trying to manipulate.<br>\r\nThis happens when an error occurs running a SELECT, UPDATE, INSERT, query that would break a referential contraint.', 0, 1, 'error_referential_constraint'),
(14, 'Error: Delete', '', 'There are problems deleting the item.<br>\r\nThis happens when an error occurs running a DELETE query, usually when trying to delete an item that can\'t be deleted..', 0, 1, 'error_delete'),
(15, 'Error: 400', '', 'The server cannot or will not process the request due to an apparent client error (e.g., malformed request syntax, too large size, invalid request message framing, or deceptive request routing).', 0, 1, 'error_400'),
(16, 'Error: 404', '', 'The page you are trying to access doesn\'t exists.', 0, 1, 'error_404'),
(17, 'Error: 500', '', 'Sorry, something went wrong.<br>\r\nA team of highly trained monkeys has been dispatched to deal with this situation.', 0, 1, 'error_500'),
(19, 'Error: Empty Page', '', 'This happens when the query you tried to execute returns 0 items.', 0, 1, 'error_no_results');

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
  `telephone` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birth_day` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `surname`, `email`, `password`, `telephone`, `birth_day`) VALUES
(1, 'Admin', '', 'admin@trc.it', '0c88028bf3aa6a6a143ed846f2be1ea4', NULL, NULL),
(2, 'Stefano', 'Valentini', 'stefano@valentini.it', '0c88028bf3aa6a6a143ed846f2be1ea4', NULL, NULL),
(4, 'Valentina', 'Cecchini', 'valentina@cecchini.it', '0c88028bf3aa6a6a143ed846f2be1ea4', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `usergroup`
--

CREATE TABLE `usergroup` (
  `id_user` int(10) UNSIGNED NOT NULL,
  `id_group` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `usergroup`
--

INSERT INTO `usergroup` (`id_user`, `id_group`) VALUES
(1, 1),
(2, 2);

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
-- Dumping data for table `writes`
--

INSERT INTO `writes` (`id_author`, `id_book`) VALUES
(104, 18),
(99, 14),
(100, 14),
(105, 19),
(106, 19),
(107, 20),
(97, 16),
(74, 16);

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
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `title` (`title`),
  ADD KEY `id_promotion` (`id_promotion`);

--
-- Indexes for table `bookcategory`
--
ALTER TABLE `bookcategory`
  ADD KEY `id_category` (`id_category`),
  ADD KEY `id_book` (`id_book`);

--
-- Indexes for table `bookpurchase`
--
ALTER TABLE `bookpurchase`
  ADD KEY `id_book` (`id_book`),
  ADD KEY `id_order` (`id_purchase`);

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
-- Indexes for table `field_data`
--
ALTER TABLE `field_data`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `id` (`id`);

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `author`
--
ALTER TABLE `author`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;
--
-- AUTO_INCREMENT for table `book`
--
ALTER TABLE `book`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `card`
--
ALTER TABLE `card`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `field_data`
--
ALTER TABLE `field_data`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
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
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `slider`
--
ALTER TABLE `slider`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `textpage`
--
ALTER TABLE `textpage`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `book`
--
ALTER TABLE `book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`id_promotion`) REFERENCES `promotion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `bookcategory`
--
ALTER TABLE `bookcategory`
  ADD CONSTRAINT `bookcategory_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bookcategory_ibfk_2` FOREIGN KEY (`id_book`) REFERENCES `book` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `bookpurchase`
--
ALTER TABLE `bookpurchase`
  ADD CONSTRAINT `bookpurchase_ibfk_1` FOREIGN KEY (`id_book`) REFERENCES `book` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `bookpurchase_ibfk_2` FOREIGN KEY (`id_purchase`) REFERENCES `purchase` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
