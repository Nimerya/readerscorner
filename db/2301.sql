-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Jan 23, 2017 at 10:30 AM
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `id_user`, `country`, `region`, `city`, `zip_code`, `address`) VALUES
(15, 2, 'Italy', 'L''Aquila', 'L''Aquila', '67100', 'Via Francesco Paolo Tosti'),
(16, 2, 'Italy', 'L''Aquila', 'L''Aquila', '67100', 'Via Francesco Paolo Tosti'),
(17, 4, 'ttt', 'tt', 'ed', '444', '555');

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE IF NOT EXISTS `author` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `biography` text COLLATE utf8_unicode_ci,
  `photo` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`id`, `name`, `biography`, `photo`) VALUES
(74, 'J.K. Rowling', 'Joanne "Jo" Rowling, (born 31 July 1965), pen names J. K. Rowling and Robert Galbraith, is a British novelist, screenwriter and film producer best known as the author of the Harry Potter fantasy series. The books have gained worldwide attention, won multiple awards, and sold more than 400 million copies.[1] They have become the best-selling book series in history[2] and been the basis for a series of films over which Rowling had overall approval on the scripts[3] and maintained creative control by serving as a producer on the final instalment.[4]\r\n\r\nBorn in Yate, Gloucestershire, England, Rowling was working as a researcher and bilingual secretary for Amnesty International when she conceived the idea for the Harry Potter series while on a delayed train from Manchester to London in 1990.[5] The seven-year period that followed saw the death of her mother, birth of her first child, divorce from her first husband and relative poverty until she finished the first novel in the series, Harry Potter and the Philosopher''s Stone, in 1997. There were six sequels, the last, Harry Potter and the Deathly Hallows, in 2007. Since then, Rowling has written four books for adult readers, The Casual Vacancy (2012) and under the pseudonym Robert Galbraith the crime fiction novels The Cuckoo''s Calling (2013), The Silkworm (2014) and Career of Evil (2015).[6].''\r\n\r\nRowling has lived a "rags to riches" life story, in which she progressed from living on state benefits to multi-millionaire status within five years. She is the United Kingdom''s best-selling living author, with sales in excess of 238M.[7] The 2016 Sunday Times Rich List estimated Rowling''s fortune at  600 million, ranking her as the joint 197th richest person in the UK.[8] Time magazine named her as a runner-up for its 2007 Person of the Year, noting the social, moral, and political inspiration she has given her fans.[9] In October 2010, Rowling was named the "Most Influential Woman in Britain" by leading magazine editors.[10] She has supported charities including Comic Relief, One Parent Families, Multiple Sclerosis Society of Great Britain and Lumos (formerly the Children''s High Level Group).', '440px-J._K._Rowling_2010.jpg'),
(97, 'Paul Kalanithi', NULL, NULL),
(99, 'Rupi Kaur', '', 'RupiKaur_crBaljit-.jpg'),
(105, 'Patrick Ness', NULL, NULL),
(106, 'Siobhan Dowd', '', ''),
(107, 'Zadie Smith', NULL, NULL),
(126, 'Ian McEwan', NULL, NULL),
(127, ' Scott Pape', NULL, NULL),
(128, 'Meik Wiking', NULL, NULL),
(129, 'Marie Tourell SÃ¶derberg', NULL, NULL),
(130, ' J. K. Rowling', NULL, NULL),
(131, 'Paul Auster', NULL, NULL),
(132, ' Kayla Itsines', NULL, NULL),
(133, 'Ottessa Moshfegh', NULL, NULL),
(134, 'Veronica Roth', NULL, NULL),
(135, 'Patrick Modiano', NULL, NULL),
(137, 'Lemony Snicket', NULL, NULL),
(138, 'Dav Pilkey', NULL, NULL),
(139, 'George R. R. MartinThe first volume of A Song of Ice and Fire, t', NULL, NULL),
(140, 'George R. R. Martin', NULL, NULL),
(141, 'Carrie Fisher', NULL, NULL),
(142, 'Daniel Kahneman', NULL, NULL),
(143, 'Sebastian Barry', NULL, NULL),
(144, 'Anonymus', NULL, NULL),
(145, 'Timothy Ferriss', NULL, NULL);

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
  `dimension` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `isbn13` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `language` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `cover` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `publisher` varchar(128) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`id`, `id_promotion`, `title`, `price`, `publication_date`, `availability`, `pages`, `dimension`, `isbn13`, `language`, `description`, `cover`, `publisher`) VALUES
(18, NULL, 'NutShell', 21.00, '2016-09-01', 24, 208, '144*222*23 ', '9781911214335', 'English', 'This book is the number one Sunday Times best-seller. A Daily Telegraph / Spectator / Sunday Times / The Times Book of the Year. Trudy has betrayed her husband, John. She''s still in the marital home - a dilapidated, priceless London townhouse - but not with John. Instead, she''s with his brother, the profoundly banal Claude, and the two of them have a plan. But there is a witness to their plot: the inquisitive, nine-month-old resident of Trudy''s womb. Told from a perspective unlike any other, Nutshell is a classic tale of murder and deceit from one of the world''s master storytellers.', '9781911214335.jpg', 'Vintage Publishing'),
(19, 1, 'A Monster Calls', 10.19, '2015-05-17', 30, 240, '129 x 198 x 17mm | 195g', '9781406361803', 'English', 'The bestselling novel about love, loss and hope from the twice Carnegie Medal-winning Patrick Ness, soon to be a major motion picture. The bestselling novel about love, loss and hope from the twice Carnegie Medal-winning Patrick Ness, soon to be a major motion picture. Conor has the same dream every night, ever since his mother first fell ill, ever since she started the treatments that don''t quite seem to be working. But tonight is different. Tonight, when he wakes, there''s a visitor at his window. It''s ancient, elemental, a force of nature. And it wants the most dangerous thing of all from Conor. It wants the truth. Patrick Ness takes the final idea of the late, award-winning writer Siobhan Dowd and weaves an extraordinary and heartbreaking tale of mischief, healing and above all, the courage it takes to survive.', '9781406361803.jpg', 'Walker Books Ltd'),
(20, NULL, 'Swing Time', 19.99, '2016-11-15', 400, 464, '162 x 240 x 40mm | 746g', '9780241144152', 'English', 'Book of the Year 2016: ''Brilliant'' Guardian ''Superb'' Financial Times ''Virtuosic and breathtaking'' Times Literary Supplement ''There is still no better chronicler of the modern British family than Zadie Smith'' Telegraph An ambitious, exuberant new novel moving from north west London to West Africa, from the multi-award-winning author of White Teeth and On Beauty Two brown girls dream of being dancers - but only one, Tracey, has talent. The other has ideas: about rhythm and time, about black bodies and black music, what constitutes a tribe, or makes a person truly free. It''s a close but complicated childhood friendship that ends abruptly in their early twenties, never to be revisited, but never quite forgotten, either...Dazzlingly energetic and deeply human, Swing Time is a story about friendship and music and stubborn roots, about how we are shaped by these things and how we can survive them. Moving from north-west London to West Africa, it is an exuberant dance to the music of time. Praise for Zadie Smith: ''Smith is the most naturally gifted young novelist around - with a fastidious ear for dialogue and a lethally quiet comic touch. Above all, she can move us'' Times Literary Supplement ''[Smith] packs more intelligence, humour and sheer energy into any given scene than anyone else of her generation'' Sunday Telegraph ''Her dialogue sings and soars; terse, packed and sassy. Smith is simply wonderful: Dickens''s legitimate daughter'' Independent on NW ''Captivating. Funny, sexy, weird, full of acute social comedy. [Zadie Smith] is up there with the best around'' Evening Standard on NW ''Intensely funny, richly varied, always unexpected. A joyous, optimistic, angry masterpiece. No better English novel will be published this year'' Daily Telegraph on NW ''Exceptionally accomplished...Smith displays a remarkable talent for embracing all the possibilities of language, and time and again she produces images that shout out in their brilliance...An outstanding novelist'' Observer on On Beauty ''Like Forster, Smith possesses a captivating authorial voice - at once authoritative and nonchalant, and capacious enough to accommodate high moral seriousness, laid-back humour and virtually everything in-between'' New York Times on On Beauty', '9780241144152.jpg', 'Penguin Books Ltd'),
(23, NULL, 'Fantastic Beasts and Where to Find Them', 19.99, '2016-08-18', 100, 500, '146 x 224 x 30mm | 440g', '9781408708989', 'English', 'J.K. Rowling''s screenwriting debut is captured in this exciting hardcover edition of the Fantastic Beasts and Where to Find Them screenplay. When Magizoologist Newt Scamander arrives in New York, he intends his stay to be just a brief stopover. However, when his magical case is misplaced and some of Newt''s fantastic beasts escape, it spells trouble for everyone...Fantastic Beasts and Where to Find Them marks the screenwriting debut of J.K. Rowling, author of the beloved and internationally bestselling Harry Potter books. Featuring a cast of remarkable characters, this is epic, adventure-packed storytelling at its very best. Whether an existing fan or new to the wizarding world, this is a perfect addition to any reader''s bookshelf.', '97814087089dddddd89.jpg', 'Little, Brown Book Group'),
(24, 1, 'The Barefoot Investor : The Only Money Guide You''ll Ever Need', 18.55, '2016-12-09', 233, 248, '180 x 235 x 15mm', '9780730324218', 'English', 'This is the only money guide you''ll ever need That''s a bold claim, given there are already thousands of finance books on the shelves. So what makes this one different? Well, you won''t be overwhelmed with a bunch of ''tips'' ? or a strict budget (that you won''t follow). You''ll get a step-by-step formula: open this account, then do this; call this person, and say this; invest money here, and not there. All with a glass of wine in your hand. This book will show you how to create an entire financial plan that is so simple you can sketch it on the back of a serviette ? and you''ll be able to manage your money in 10 minutes a week. You''ll also get the skinny on: * Saving up a six-figure house deposit in 20 months * Doubling your income using the ''Trapeze Strategy'' * Saving $78,173 on your mortgage and wiping out 7 years of payments * Finding a financial advisor who won''t rip you off * Handing your kids (or grandkids) a $140,000 cheque on their 21st birthday * Why you don''t need $1 million to retire ? with the ''Donald Bradman Retirement Strategy'' Sound too good to be true? It''s not. This book is full of stories from everyday Aussies ? single people, young families, empty nesters, retirees ? who have applied the simple steps in this book and achieved amazing, life-changing results. And you''re next.', '9780730324218.jpg', 'John Wiley & Sons Australia Ltd'),
(25, 3, 'The Little Book of Hygge : The Danish Way to Live Well', 10.25, '2016-12-01', 244, 288, '138 x 289 x 27mm | 486g', '9780241283912', 'English', 'Denmark is often said to be the happiest country in the world. That''s down to one thing: hygge. ''Hygge has been translated as everything from the art of creating intimacy to cosiness of the soul to taking pleasure from the presence of soothing things. My personal favourite is cocoa by candlelight...'' You know hygge when you feel it. It is when you are cuddled up on a sofa with a loved one, or sharing comfort food with your closest friends. It is those crisp blue mornings when the light through your window is just right. Who better than Meik Wiking to be your guide to all things hygge? Meik is CEO of the Happiness Research Institute in Copenhagen and has spent years studying the magic of Danish life. In this beautiful, inspiring book he will help you be more hygge: from picking the right lighting and planning a dinner party through to creating an emergency hygge kit and even how to dress. Meik Wiking is the CEO of the Happiness Research Institute in Copenhagen. He is committed to finding out what makes people happy and has concluded that hygge is the magic ingredient that makes Danes the happiest nation in the world.', '9780241283912.jpg', 'Penguin Books Ltd'),
(26, NULL, 'Hygge : The Danish Art of Happiness', 13.34, '2016-10-20', 111, 224, '179 x 216 x 28mm | 748g', '9780718185336', 'English', 'Other books will tell you how to be hygge. This is the only book that will show you. Though we all know the feeling of hygge instinctively few of us ever manage to capture it for more than a moment. Now Danish actress and hygge aficionado Marie Tourell Soderberg - star of BBC 4''s 1864 - has travelled the length and breadth of her home country to create the perfect guide to cooking, decorating, entertaining and being inspired the hygge way. Full of beautiful photographs and simple, practical steps and ideas to make your home and life both comfortable and cheering all year round, this book is the easy way to introduce hygge into your life. ''Pretty, homey and intimate, scattered with reflections from ordinary Danes'' Guardian', '9780718185336.jpg', 'Penguin Books Ltd'),
(27, 4, 'The Tales of Beedle the Bard', 15.54, '2017-01-12', 1111, 144, '129 x 198 x 18mm | 1,007g', '9781408880722', 'English', 'The Tales of Beedle the Bard have been favourite bedtime reading in wizarding households for centuries. Full of magic and trickery, these classic tales both entertain and instruct, and remain as captivating to young wizards today as they were when Beedle first put quill to parchment in the fifteenth century. There are five tales in all: ''The Tale of the Three Brothers'' Harry Potter fans will know from Harry Potter and the Deathly Hallows; ''The Fountain of Fair Fortune'', ''The Warlock''s Hairy Heart'', ''The Wizard and the Hopping Pot'' and ''Babbitty Rabbitty and her Cackling Stump'' complete the collection. These narrative gems are accompanied by explanatory notes by Professor Albus Dumbledore (included by kind permission of the Hogwarts Headmaster''s archive). His illuminating thoughts reveal the stories to be much more than just simple moral tales, and are sure to make Babbitty Rabbitty and the slug-belching Hopping Pot as familiar to Muggles as Snow White and Cinderella. This brand new edition of these much loved fairy tales from the wizarding world pairs J.K. Rowling''s original text with gorgeous jacket art by Jonny Duddle and line illustrations throughout by Tomislav Tomic. The Tales of Beedle the Bard is published in aid of the Lumos (link to wearelumos.org), an international children''s charity (registered charity number 1112575) founded in 2005 by J.K Rowling. Lumos is dedicated ending the institutionalisation of children, a harmful practice that affects the lives of up to eight million disadvantaged children around the world who live in institutions and orphanages, many placed there as a result of poverty, disability, disease, discrimination and conflict; very few are orphans. Lumos works to reunite children with their families, promote family-based care alternatives and help authorities to reform their systems and close down institutions and orphanages.', '9781408880722.jpg', 'Bloomsbury Publishing PLC'),
(28, NULL, '4321', 21.72, '2017-01-31', 342, 880, '153 x 234 x 49mm | 1,264g', '9780571324620', 'English', 'On March 3, 1947, in the maternity ward of Beth Israel Hospital in Newark, New Jersey, Archibald Isaac Ferguson, the one and only child of Rose and Stanley Ferguson, is born. From that single beginning, Ferguson''s life will take four simultaneous and independent fictional paths. Four Fergusons made of the same genetic material, four boys who are the same boy, will go on to lead four parallel and entirely different lives. Family fortunes diverge. Loves and friendships and intellectual passions contrast. Chapter by chapter, the rotating narratives evolve into an elaborate dance of inner worlds enfolded within the outer forces of history as, one by one, the intimate plot of each Ferguson''s story rushes on across the tumultuous and fractured terrain of mid twentieth-century America. A boy grows up-again and again and again. As inventive and dexterously constructed as anything Paul Auster has ever written 4 3 2 1 is an unforgettable tour de force, the crowning work of this masterful writer''s extraordinary career.\r\nProduct details', '9780571324620.jpg', 'FABER & FABER'),
(29, 3, 'The Bikini Body 28-Day Healthy Eating & Lifestyle Guide : 200 Recipes, Weekly Menus, 4-Week Workout Plan', 19.49, '2017-01-01', 222, 400, '216 x 265 x 25mm | 1,519g', '9781509842094', 'English', 'The body transformation phenomenon and #1 Instagram sensation''s first healthy eating and lifestyle book! Millions of women follow Kayla Itsines and her Bikini Body Guide 28-minute workouts: energetic, kinetic, high-intensity interval training sessions that help women achieve healthy, strong bodies. Fans not only follow Kayla on Instagram, they pack stadiums for workout sessions with her, they''ve made her Sweat with Kayla app hit the top of the Apple App Store''s health and fitness charts, and they post amazing before and after progress shots. Kayla''s audience is avid and growing, with over 10 million followers worldwide. The Bikini Body 28-Day Healthy Eating & Lifestyle Guide features: - 200 recipes such as fresh fruit breakfast platters, smoothie bowls, and salads - A 4-week workout plan which includes Kayla''s signature 28-minute workouts - Full-colour food shots and photos featuring Kayla throughout Kayla''s international 2016 Sweat Tour sold out in only 4 hours!', '9781509842094.jpg', 'Pan MacMillan'),
(30, NULL, 'Homesick for Another World', 19.91, '2017-01-12', 123, 304, '144 x 222 x 29mm | 444g', '9780224101349', 'English', 'The debut short story collection by the author of Eileen, shortlisted for the Man Booker Prize 2016. There''s something eerily unsettling about Ottessa Moshfegh''s stories, something almost dangerous while also being delightful - and often even weirdly hilarious. Her characters are all unsteady on their feet; all yearning for connection and betterment, in very different ways, but each of them seems destined to be tripped up by their own baser impulses. What makes these stories so moving is the emotional balance that Moshfegh achieves - the way she exposes the limitless range of self-deception that human beings can employ while, at the same time, infusing the grotesque and outrageous with tenderness and compassion. The flesh is weak; the timber is crooked; people are cruel to each other, and stupid, and hurtful, but beauty comes from strange sources, and the dark energy surging through these stories is oddly and powerfully invigorating. Moshfegh has been compared to Flannery O''Connor, Jim Thompson, Shirley Jackson and Patricia Highsmith but her voice and her mastery of language and tone are unique. One of the most gifted and exciting young writers in America, she shows us uncomfortable things, and makes us look at them forensically - until we find, suddenly, that we are really looking at ourselves', '9780224101349.jpg', 'Random House Children''s Publishers UK'),
(31, NULL, 'Carve the Mark', 15.38, '2017-01-17', 234, 528, '159 x 240 x 45mm | 620g', '9780008157821', 'English', 'Fans of Star Wars and Divergent will revel in internationally bestselling author Veronica Roth''s stunning new science-fiction fantasy series. On a planet where violence and vengeance rule, in a galaxy where some are favoured by fate, everyone develops a currentgift, a unique power meant to shape the future. While most benefit from their currentgifts, Akos and Cyra do not - their gifts make them vulnerable to others'' control. Can they reclaim their gifts, their fates, and their lives, and reset the balance of power in this world? Cyra is the sister of the brutal tyrant who rules the Shotet people. Cyra''s currentgift gives her pain and power - something her brother exploits, using her to torture his enemies. But Cyra is much more than just a blade in her brother''s hand: she is resilient, quick on her feet, and smarter than he knows. Akos is from the peace-loving nation of Thuvhe, and his loyalty to his family is limitless. Though protected by his unusual currentgift, once Akos and his brother are captured by enemy Shotet soldiers, Akos is desperate to get his brother out alive - no matter what the cost. When Akos is thrust into Cyra''s world, the enmity between their countries and families seems insurmountable. They must decide to help each other to survive - or to destroy one another.', '9780008157821.jpg', 'HarperCollins Publishers'),
(32, 1, 'The Black Notebook', 10.67, '2017-01-12', 223, 160, '131 x 199 x 12mm | 118g', '9780857054883', 'English', 'A writer discovers a set of notes in his notebook and sets off on a journey through the Paris of his past, in search of the woman he loved forty years previously. Set in the Montparnasse district of Paris, the author, Jean, retraces his nocturnal footsteps around the left bank during France''s period of decolonisation during the 1960''s. He tries to remember what brought him into contact with a gang that frequented the hotel Unic in the area. His quest through seedy cafes and cheap hotels becomes an enquiry into a woman, Dannie, whom Jean loved and who once tried to admit to a terrible crime. Over the course of several voyages between past and present, we meet various shady characters, and discover that Dannie may have killed "someone". As his memories overlap with the discovery of an old vice squad dossier, Jean reinvestigates the closed case of a crime where he could well be the last remaining witness.', '9780857054883.jpg', 'Quercus Publishing'),
(33, 2, 'The Bad Beginning', 12.47, '2011-07-08', 1234, 192, '166.9 x 231.9 x 28.2mm | 716.67g', '9780064407663', 'English', 'Violet, Klaus, and Sunny Baudelaire are intelligent children. They are charming, and resourceful, and have pleasant facial features. Unfortunately, they are exceptionally unlucky. In the first two books alone, the three youngsters encounter a greedy and repulsive villain, itchy clothing, a disastrous fire, a plot to steal their fortune, a lumpy bed, a deadly serpent, a large brass reading lamp, a long knife, and a terrible odour. In the tradition of great storytellers, from Dickens to Dahl, comes an exquisitely dark comedy that is both literary and irreverent, hilarious and deftly crafted. Never before has a tale of three likeable and unfortunate children been quite so enchanting, or quite so uproariously unhappy. Ages 10+', '9780064407663.jpg', 'HarperCollins Publishers Inc'),
(34, 2, 'The Adventures of Captain Underpants', 5.81, '1997-09-30', 234, 117, '133 x 190 x 13mm | 113g', '9780590846288', 'English', 'Young readers will laugh out loud at this action-packed, easy-to-read chapter book by award-winning author and Caldecott Honor illustrator Dav Pilkey. Introducing FLIP-O-RAMA, a wonderfully silly and fun-filled illustration technique that allows readers to animate the action.', '9780590846288.jpg', 'Scholastic US'),
(35, NULL, 'A Game of Thrones : Book 1 of A Song of Ice and Fire', 8.78, '2009-03-01', 456, 864, '111 x 178 x 56mm | 440g', '9780006479888', 'English', 'The first volume of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, starring Sean Bean. Summers span decades. Winter can last a lifetime. And the struggle for the Iron Throne has begun. As Warden of the north, Lord Eddard Stark counts it a curse when King Robert bestows on him the office of the Hand. His honour weighs him down at court where a true man does what he will, not what he must ...and a dead enemy is a thing of beauty. The old gods have no power in the south, Stark''s family is split and there is treachery at court. Worse, the vengeance-mad heir of the deposed Dragon King has grown to maturity in exile in the Free Cities. He claims the Iron Throne.', '9780006479888.jpg', ' HarperCollins Publishers'),
(36, NULL, 'A Clash of Kings (A Song of Ice and Fire, Book 2)', 8.78, '1999-10-04', 256, 752, '112 x 176 x 60mm | 498.95g', '9780006479895', 'English', 'The second volume of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, featuring a stellar cast. Throughout Westeros, the cold winds are rising. From the ancient citadel of Dragonstone to the forbidding lands of Winterfell, chaos reigns as pretenders to the Iron Throne of the Seven Kingdoms stake their claims through tempest, turmoil and war. As a prophecy of doom cuts across the sky - a comet the colour of blood and flame - five factions struggle for control of a divided land. Brother plots against brother and the dead rise to walk in the night. Against a backdrop of incest, fratricide, alchemy and murder, the price of glory is measured in blood.', '9780006479895.jpg', 'HarperCollins Publishers'),
(37, NULL, 'A Storm of Swords: Part 1 Steel and Snow (A Song of Ice and Fire, Book 3): Steel and Snow Pt. 1', 8.02, '2011-08-22', 367, 688, '118 x 178 x 60mm | 379.99g', '9780006479901', 'English', 'The third volume, part one of A Song of Ice and Fire, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, featuring a stellar cast. Winter approaches Westeros like an angry beast. The Seven Kingdoms are divided by revolt and blood feud. In the northern wastes, a horde of hungry, savage people steeped in the dark magic of the wilderness is poised to invade the Kingdom of the North where Robb Stark wears his new-forged crown. And Robb''s defences are ranged against the South, the land of the cunning and cruel Lannisters, who have his younger sisters in their power. Throughout Westeros, the war for the Iron Throne rages more fiercely than ever, but if the Wall is breached, no king will live to claim it.', '9780006479901.jpg', 'HarperCollins Publishers'),
(38, NULL, 'A Storm of Swords: Part 2 Blood and Gold (A Song of Ice and Fire, Book 3)', 8.71, '2011-08-06', 235, 656, '110 x 176 x 44mm | 358.34g', '9780007119554', 'English', 'The third volume, part two of A SONG OF ICE AND FIRE, the greatest fantasy epic of the modern age. GAME OF THRONES is now a major TV series from HBO, featuring a stellar cast. The Starks are scattered. Robb Stark may be King in the North, but he must bend to the will of the old tyrant Walder Frey if he is to hold his crown. And while his youngest sister, Arya, has escaped the clutches of the depraved Cersei Lannister and her son, the capricious boy-king Joffrey, Sansa Stark remains their captive. Meanwhile, across the ocean, Daenerys Stormborn, the last heir of the Dragon King, delivers death to the slave-trading cities of Astapor and Yunkai as she approaches Westeros with vengeance in her heart.', '9780007119554.jpg', 'arperCollins Publishers'),
(39, NULL, 'A Feast for Crows (A Song of Ice and Fire, Book 4)', 9.74, '2011-08-22', 245, 864, '114 x 180 x 56mm | 479.99g', '9780006486121', 'English', 'HBO''s hit series A GAME OF THRONES is based on George R. R. Martin''s internationally bestselling series A SONG OF ICE AND FIRE, the greatest fantasy epic of the modern age. A FEAST FOR CROWS is the fourth volume in the series. The Lannisters are in power on the Iron Throne. The war in the Seven Kingdoms has burned itself out, but in its bitter aftermath new conflicts spark to life. The Martells of Dorne and the Starks of Winterfell seek vengeance for their dead. Euron Crow''s Eye, as black a pirate as ever raised a sail, returns from the smoking ruins of Valyria to claim the Iron Isles. From the icy north, where Others threaten the Wall, apprentice Maester Samwell Tarly brings a mysterious babe in arms to the Citadel. As plots, intrigue and battle threaten to engulf Westeros, victory will go to the men and women possessed of the coldest steel and the coldest hearts.', '9780006486121.jpg', 'HarperCollins Publishers'),
(40, 3, 'Postcards from the Edge', 13.99, '2010-05-04', 456, 226, '139.7 x 210.82 x 17.78mm | 204.12g', '9781439194003', 'English', 'This bestselling Hollywood novel by the witty author of "Wishful Drinking" and "Shockaholic" that was made into a movie starring Meryl Streep and Shirley MacLaine. When we first meet the extraordinary young actress Suzanne Vale, she s feeling like something on the bottom of someone s shoe, and not even someone interesting. Suzanne is in the harrowing and hilarious throes of drug rehabilitation, trying to understand what happened to her life and how she managed to land in a drug hospital. Just as Fisher s first film role the precocious teenager in "Shampoo" echoed her own Beverly Hills upbringing, her first book is set within the world she knows better than anyone else: Hollywood. This stunning literary debut chronicles Suzanne s vivid, excruciatingly funny experiences inside the clinic and as she comes to terms with life in the outside world. "Postcards from the Edge" is more than a book about stardom and drugs. It is a revealing look at the dangers and delights of all our addictions, from money and success to sex and insecurity."', '9781849833646.jpg', 'SIMON & SCHUSTER'),
(41, 3, 'Thinking, Fast and Slow', 10.87, '2012-10-05', 245, 512, ' 128 x 194 x 26mm | 399.99g', '9780141033570', 'English', 'The phenomenal New York Times Bestseller by Nobel Prize-winner Daniel Kahneman, Thinking Fast and Slow offers a whole new look at the way our minds work, and how we make decisions. Why is there more chance we''ll believe something if it''s in a bold type face? Why are judges more likely to deny parole before lunch? Why do we assume a good-looking person will be more competent? The answer lies in the two ways we make choices: fast, intuitive thinking, and slow, rational thinking. This book reveals how our minds are tripped up by error and prejudice (even when we think we are being logical), and gives you practical techniques for slower, smarter thinking. It will enable to you make better decisions at work, at home, and in everything you do.', '9780141033570.jpg', 'Penguin Books Ltd'),
(42, 3, 'Days Without End', 16.02, '2017-01-12', 342, 272, '153 x 234 x 19mm | 373g', '9780571277018', 'English', '"A violent, superbly lyrical western offering a sweeping vision of America in the making [and] the most fascinating line-by-line first person narration I''ve come across in years." (KAZUO ISHIGURO). "A beautiful, savage, tender, searing work of art. Sentence after perfect sentence it grips and does not let go." (DONAL RYAN). ''I am thinking of the days without end of my life...''. After signing up for the US army in the 1850s, aged barely seventeen, Thomas McNulty and his brother-in-arms, John Cole, go on to fight in the Indian wars and, ultimately, the Civil War. Having fled terrible hardships they find these days to be vivid and filled with wonder, despite the horrors they both see and are complicit in. Their lives are further enriched and imperilled when a young Indian girl crosses their path, and the possibility of lasting happiness emerges, if only they can survive. Moving from the plains of the West to Tennessee, Sebastian Barry''s latest work is a masterpiece of atmosphere and language. Both an intensely poignant story of two men and the lives they are dealt, and a fresh look at some of the most fateful years in America''s past, Days Without End is a novel never to be forgotten.', '9780571277018.jpg', 'FABER & FABER'),
(43, NULL, 'The Princess Diarist', 17.44, '2017-01-16', 500, 272, '144 x 222 x 27mm | 412g', '9780593077566', 'English', 'The Princess Diarist is Carrie Fisher''s intimate, hilarious and revealing recollection of what happened behind the scenes on one of the most famous film sets of all time, the first Star Wars movie. When Carrie Fisher recently discovered the journals she kept during the filming of the first Star Wars movie, she was astonished to see what they had preserved-plaintive love poems, unbridled musings with youthful naivete, and a vulnerability that she barely recognized. Today, her fame as an author, actress, and pop-culture icon is indisputable, but in 1977, Carrie Fisher was just a (sort-of) regular teenager. With these excerpts from her handwritten notebooks, The Princess Diarist is Fisher''s intimate and revealing recollection of what happened on one of the most famous film sets of all time-and what developed behind the scenes. And today, as she reprises her most iconic role for the latest Star Wars trilogy, Fisher also ponders the joys and insanity of celebrity, and the absurdity of a life spawned by Hollywood royalty, only to be surpassed by her own outer-space royalty. Laugh-out-loud hilarious and endlessly quotable, The Princess Diarist brims with the candour and introspection of a diary while offering shrewd insight into the type of stardom that few will ever experience.', '9780593077566.jpg', 'Transworld Publishers Ltd'),
(44, NULL, 'Diary of an Oxygen Thief', 6.83, '2016-08-25', 122, 160, '131 x 198 x 21mm | 155g', '9781472152756', 'English', 'Hurt people hurt people. Say there was a novel in which Holden Caulfield was an alcoholic and Lolita was a photographer''s assistant and, somehow, they met in Bright Lights, Big City. He''s blinded by love. She by ambition. Diary of an Oxygen Thief is an honest, hilarious, and heartrending novel, but above all, a very realistic account of what we do to each other and what we allow to have done to us.', '9781472152756.jpg', 'Little, Brown Book Group'),
(45, 3, 'Tools of Titans : The Tactics, Routines, and Habits of Billionaires, Icons, and World-Class Performers', 17.47, '2016-12-14', 456, 288, '153 x 234 x 43mm | 775g', '9781785041273', 'English', 'New York Times Bestseller. The latest groundbreaking tome from Tim Ferriss, the best-selling author of The 4-Hour Workweek. From the author: "For the last two years, I''ve interviewed nearly two hundred world-class performers for my podcast," The Tim Ferriss Show. The guests range from super celebs (Jamie Foxx, Arnold Schwarzenegger, etc.) and athletes (icons of powerlifting, gymnastics, surfing, etc.) to legendary Special Operations commanders and black-market biochemists. For most of my guests, it''s the first time they''ve agreed to a two-to-three-hour interview, and the show is on the cusp of passing 100 million downloads. "This book contains the distilled tools, tactics, and ''inside baseball'' you won''t find anywhere else. It also includes new tips from past guests, and life lessons from new ''guests'' you haven''t met." What makes the show different is a relentless focus on actionable details. This is reflected in the questions. For example: What do these people do in the first sixty minutes of each morning? What do their workout routines look like, and why? What books have they gifted most to other people? What are the biggest wastes of time for novices in their field? What supplements do they take on a daily basis? "I don''t view myself as an interviewer. I view myself as an experimenter. If i can''t test something and replicate results in the messy reality of everyday life, I''m not interested." Everything within these pages has been vetted, explored, and applied to my own life in some fashion. I''ve used dozens of the tactics and philosophies in high-stakes negotiations, high-risk environments, or large business dealings. The lessons have made me millions of dollars and saved me years of wasted effort and frustration. "I created this book, my ultimate notebook of high-leverage tools, for myself. It''s changed my life, and I hope the same for you."', '9781785041273.jpg', 'Ebury Publishing'),
(46, 4, 'When Breath Becomes Air', 15.87, '2016-02-04', 243, 256, '138 x 204 x 26mm | 376g', '9781847923677', 'English', 'This was selected as a New York Times Non-Fiction Book of the Year. It was short-listed for Waterstones Book of the Year; The New York Times Number one Bestseller; and the Sunday Times Bestseller. "Finishing this book and then forgetting about it is simply not an option...Unmissable." (New York Times). At the age of thirty-six, on the verge of completing a decade''s training as a neurosurgeon, Paul Kalanithi was diagnosed with inoperable lung cancer. One day he was a doctor treating the dying, the next he was a patient struggling to live. When Breath Becomes Air chronicles Kalanithi''s transformation from a medical student asking what makes a virtuous and meaningful life into a neurosurgeon working in the core of human identity - the brain - and finally into a patient and a new father. What makes life worth living in the face of death? What do you do when when life is catastrophically interrupted? What does it mean to have a child as your own life fades away? Paul Kalanithi died while working on this profoundly moving book, yet his words live on as a guide to us all. When Breath Becomes Air is a life-affirming reflection on facing our mortality and on the relationship between doctor and patient, from a gifted writer who became both', '9781847923677.jpg', 'Vintage Publishing');

-- --------------------------------------------------------

--
-- Table structure for table `bookcategory`
--

CREATE TABLE IF NOT EXISTS `bookcategory` (
  `id_category` int(10) unsigned NOT NULL,
  `id_book` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `bookcategory`
--

INSERT INTO `bookcategory` (`id_category`, `id_book`) VALUES
(1, 23),
(1, 34),
(3, 20),
(5, 19),
(6, 25),
(6, 29),
(9, 18),
(9, 19),
(9, 20),
(9, 23),
(9, 34),
(9, 35),
(9, 36),
(9, 37),
(9, 38),
(9, 39),
(10, 18),
(10, 20),
(10, 28),
(10, 30),
(10, 32),
(10, 40),
(10, 42),
(10, 44),
(12, 46),
(14, 24),
(15, 45),
(18, 27),
(18, 31),
(19, 25),
(19, 26),
(19, 41),
(23, 43);

-- --------------------------------------------------------

--
-- Table structure for table `bookpurchase`
--

CREATE TABLE IF NOT EXISTS `bookpurchase` (
  `id_book` int(10) unsigned NOT NULL,
  `id_purchase` int(10) unsigned NOT NULL,
  `amount` smallint(5) unsigned NOT NULL,
  `price` decimal(5,2) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `description`) VALUES
(1, 'Dictionaries&Languages', ''),
(3, 'Crime & Thriller', ''),
(4, 'Art e Fothography', ''),
(5, 'Children''s book', ''),
(6, 'Health', ''),
(7, 'History & Archaeology', ''),
(8, 'Entertainement', ''),
(9, 'Adventure', ''),
(10, 'Fiction', ''),
(11, 'Grapfic Novels, Anime & Manga', ''),
(12, 'Medical', ''),
(13, 'Natural History', ''),
(14, 'Poetry & Drama', ''),
(15, 'Reference', ''),
(16, 'Romance', ''),
(17, 'Science & Geography', ''),
(18, 'Science Fiction, Fantasy & Horror', ''),
(19, 'Society & Social Science', ''),
(20, 'Sport', ''),
(21, 'Stationery', ''),
(22, 'Teaching Resources & Education', ''),
(23, 'Autobiography', '');

-- --------------------------------------------------------

--
-- Table structure for table `field_data`
--

CREATE TABLE IF NOT EXISTS `field_data` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  `placeholder` varchar(1024) DEFAULT NULL,
  `pattern` varchar(1024) DEFAULT NULL,
  `style` text
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `field_data`
--

INSERT INTO `field_data` (`id`, `name`, `placeholder`, `pattern`, `style`) VALUES
(1, 'active', 'placeholder="1 or 0"', 'min="0" max="1" step="1"', 'width: 15%;'),
(38, 'address', '', '', 'width:50%;'),
(9, 'availability', '', '', 'width:15%;'),
(25, 'birth_day', '', '', 'width: 15%;'),
(36, 'city', '', '', 'width:20%;'),
(34, 'country', '', '', 'width:20%;'),
(12, 'cover', '', '', 'width:50%;'),
(31, 'date', '', '', 'width:15%;'),
(33, 'date_order', '', 'disabled', 'width:15%;'),
(2, 'dimension', 'placeholder="www x hhh x dddmm | yyyg"', '', 'width: 30%;'),
(28, 'discount', 'placeholder="in %"', 'min=1 max=99 step=1', 'width: 15%;'),
(3, 'email', 'placeholder="Your email here"', '', 'width: 50%;'),
(27, 'end', '', '', 'width:15%;'),
(22, 'icon', '', '', 'width: 30%;'),
(21, 'image', '', '', 'width:50%;'),
(4, 'isbn13', 'placeholder="978123456789"', 'pattern="^(?:ISBN(?:-13)?:? )?(?=[0-9]{13}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)97[89][- ]?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9]$" placeholder="978-3-16-148410-0"', 'width: 30%;'),
(11, 'language', 'value="English";', '', 'width: 20%;'),
(15, 'name', '', '', 'width: 30%;'),
(10, 'pages', '', '', 'width:15%;'),
(26, 'password', '', '', 'width: 50%;'),
(19, 'pattern', 'placeholder="regex or min/max/step for numbers"', '', 'width:50%;'),
(16, 'photo', '', '', 'width:50%;'),
(18, 'placeholder', '', '', 'width:50%;'),
(17, 'position', '', '', 'width:15%;'),
(5, 'price', 'placeholder="123.45"', 'min="0.01" step="0.01"', 'width: 15%;'),
(6, 'publication_date', '', '', 'width: 20%;'),
(13, 'publisher', '', '', 'width:30%;'),
(35, 'region', '', '', 'width:20%;'),
(7, 'section', 'placeholder="Indicates the belonging category"', '', 'width: 50%;'),
(30, 'shipping_cost', '', 'disabled', 'width:15%;'),
(32, 'status', 'placeholder="waiting for payment/in preparation/shipped/delivered"', '', 'width:33%;'),
(23, 'surname', '', '', 'width: 30%;'),
(24, 'telephone', '', '', 'width: 15%;'),
(8, 'title', '', '', 'width: 50%;'),
(29, 'total', '', 'disabled', 'width:15%;'),
(37, 'zip_code', '', '', 'width: 15%;');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`) VALUES
(1, 'Administrators', ''),
(2, 'Warehousemen', NULL),
(5, 'Salesmen', 'Add/Edit Books/Promotions/Orders');

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
(1, 3),
(1, 4),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15),
(2, 1),
(2, 3),
(5, 1),
(5, 3),
(5, 13),
(5, 14);

-- --------------------------------------------------------

--
-- Table structure for table `promotion`
--

CREATE TABLE IF NOT EXISTS `promotion` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `end` date NOT NULL,
  `discount` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `promotion`
--

INSERT INTO `promotion` (`id`, `name`, `end`, `discount`) VALUES
(1, 'Promozione1', '2017-02-28', 70),
(2, 'Promozione2', '2017-07-13', 50),
(3, 'Promozione3', '2017-06-01', 30),
(4, 'Promozione4', '2017-01-31', 20);

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE IF NOT EXISTS `purchase` (
  `id` int(10) unsigned NOT NULL,
  `id_user` int(10) unsigned NOT NULL,
  `id_card` int(10) unsigned NOT NULL,
  `id_address` int(10) unsigned NOT NULL,
  `total` decimal(5,2) unsigned NOT NULL,
  `date_order` date NOT NULL,
  `shipping_cost` decimal(5,2) unsigned NOT NULL,
  `status` varchar(256) COLLATE utf8_unicode_ci NOT NULL COMMENT 'waiting for payment, in preparation, shipped, delivered'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE IF NOT EXISTS `review` (
  `id` int(10) unsigned NOT NULL,
  `id_user` int(10) unsigned NOT NULL,
  `id_book` int(10) unsigned NOT NULL,
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
  `name` varchar(128) CHARACTER SET latin1 NOT NULL,
  `description` text CHARACTER SET latin1,
  `icon` varchar(256) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(11, 'groups.php', '', 'fa-shield'),
(12, 'user.php', '', 'fa-user'),
(13, 'promotion.php', '', 'fa-star-half-o'),
(14, 'purchase.php', '', 'fa-money'),
(15, 'address.php', '', 'fa-road');

-- --------------------------------------------------------

--
-- Table structure for table `slider`
--

CREATE TABLE IF NOT EXISTS `slider` (
  `id` int(11) NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `image` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `link` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` int(11) NOT NULL,
  `position` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `slider`
--

INSERT INTO `slider` (`id`, `title`, `body`, `image`, `link`, `active`, `position`) VALUES
(9, 'Welcome!', 'We have more than 17 million titles and free delivery worldwide to over 100 countries. We also really, really love books.', 'BooksSlider.png', '', 1, 1),
(10, 'Go get this now!', 'When Magizoologist Newt Scamander arrives in New York, he intends his stay to be just a brief stopover. However, when his magical case is misplaced and some of Newt''s fantastic beasts escape, it spells trouble for everyone...', 'fantasticcompetition-website-slider.jpg', 'search.php?sq=fantastic beasts', 1, 3),
(11, 'Just Arrived!', 'A Song of Ice and Fire is a series of epic fantasy novels by the American novelist and screenwriter George R. R. Martin. He began the first volume of the series, A Game of Thrones, in 1991 and had it published in 1996. Martin, who initially envisioned the series as a trilogy, has published five out of a planned seven volumes. The fifth and most recent volume of the series published in 2011, A Dance with Dragons, took Martin five years to write. He is still writing the sixth novel, The Winds of Winter.', 'GoT-1024x512.jpg', 'search.php?sq=thrones', 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `textpage`
--

CREATE TABLE IF NOT EXISTS `textpage` (
  `id` int(10) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `subtitle` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `position` int(11) DEFAULT NULL,
  `active` int(11) NOT NULL,
  `section` varchar(32) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `textpage`
--

INSERT INTO `textpage` (`id`, `title`, `subtitle`, `body`, `position`, `active`, `section`) VALUES
(2, 'Quote', '', '"Reading is going toward something that is about to be, and no one yet knows what it will be." - Italo Calvino.', 0, 1, 'quote'),
(4, 'Here''s what you can do', 'We swear that this do not happen often, if you start visiting this page too many times you can try some of the following tips:', '<ul class="unorder-list">\r\n<li>Go back and try again</li>\r\n<li>Clean your cookies/cache</li>\r\n<li>Try to restart your browser or switch to another one</li>\r\n<li>There may be a maintenance ongoing on our server, so please be patient and wait some minutes</li>					\r\n</ul>', 0, 1, 'error_hints'),
(5, 'Error: Login', '', 'You are here because the Email/Password you inserted is wrong, please go back and try again.', 0, 1, 'error_login'),
(7, 'Error: Access Denied', '', 'This happens when you try to access an area that is not available for you or your user group.\r\n', 0, 1, 'error_permission'),
(8, 'Error: System', '', 'This is usually our fault, there is nothing you can do.\r\nTry to wait a couple of minutes and try again.', 0, 1, 'error_system'),
(9, 'Error: Database Connection', '', 'This is usually our fault.\r\nThere may be a maintenence ongoing on our servers, please try again later. ', 0, 1, 'error_db_connection'),
(10, 'Error: Report', '', 'There are problems querying the database to get the report you requested.<br>\r\nThis happens when an error occurs running a SELECT query, please check the database and be sure it is online.', 0, 1, 'error_report'),
(11, 'Error: Getting Data from DB', '', 'There are problems getting the item''s info you requested.<br>\r\nThis happens when an error occurs running a SELECT query, please check the database and be sure it is online.', 0, 1, 'error_get'),
(12, 'Error: Update', '', 'There are problems updating the data you are trying to edit.<br>\r\nThis happens when an error occurs running an UPDATE query, please check the database and be sure it is online.', 0, 1, 'error_update'),
(13, 'Error: Referential Constraint', '', 'There are problems with the item''s referential constraint you are trying to manipulate.<br>\r\nThis happens when an error occurs running a SELECT, UPDATE, INSERT, query that would break a referential contraint.', 0, 1, 'error_referential_constraint'),
(14, 'Error: Delete', '', 'There are problems deleting the item.<br>\r\nThis happens when an error occurs running a DELETE query, usually when trying to delete an item that can''t be deleted..', 0, 1, 'error_delete'),
(15, 'Error: 400', '', 'The server cannot or will not process the request due to an apparent client error (e.g., malformed request syntax, too large size, invalid request message framing, or deceptive request routing).', 0, 1, 'error_400'),
(16, 'Error: 404', '', 'The page you are trying to access doesn''t exists.', 0, 1, 'error_404'),
(17, 'Error: 500', '', 'Sorry, something went wrong.<br>\r\nA team of highly trained monkeys has been dispatched to deal with this situation.', 0, 1, 'error_500'),
(19, 'Error: Empty Page', '', 'This happens when the query you tried to execute returns 0 items.', 0, 1, 'error_no_results'),
(20, 'Error: Insert', '', 'This happens when there is an error runnng an INSERT INTO query.', 0, 1, 'error_insert');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `surname`, `email`, `password`, `telephone`, `birth_day`) VALUES
(1, 'Admin', '', 'admin@trc.it', '0c88028bf3aa6a6a143ed846f2be1ea4', NULL, NULL),
(2, 'Stefano', 'Valentini', 'stefano@valentini.it', '0c88028bf3aa6a6a143ed846f2be1ea4', NULL, NULL),
(4, 'Valentina', 'Cecchini', 'valentina@cecchini.it', '0c88028bf3aa6a6a143ed846f2be1ea4', NULL, NULL),
(5, 'Franco', 'Pappalardo', 'franco@pappalardo.it', '0c88028bf3aa6a6a143ed846f2be1ea4', '333666999123', '2017-01-19'),
(6, 'Mario', 'Rossi', 'mario@rossi.it', '0c88028bf3aa6a6a143ed846f2be1ea4', '3331234567', '2017-01-20');

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
(1, 1),
(2, 2),
(5, 2),
(6, 5);

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
(74, 23),
(97, 46),
(105, 19),
(106, 19),
(107, 20),
(126, 18),
(127, 24),
(128, 25),
(129, 26),
(130, 27),
(131, 28),
(132, 29),
(133, 30),
(134, 31),
(135, 32),
(137, 33),
(138, 34),
(139, 35),
(140, 36),
(140, 37),
(140, 38),
(140, 39),
(141, 40),
(141, 43),
(142, 41),
(143, 42),
(144, 44),
(145, 45);

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
  ADD PRIMARY KEY (`id_book`,`id_category`),
  ADD KEY `id_category` (`id_category`),
  ADD KEY `id_book` (`id_book`);

--
-- Indexes for table `bookpurchase`
--
ALTER TABLE `bookpurchase`
  ADD PRIMARY KEY (`id_book`,`id_purchase`),
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
  ADD PRIMARY KEY (`id_group`,`id_service`),
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
  ADD UNIQUE KEY `id_user_2` (`id_user`,`id_book`),
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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `usergroup`
--
ALTER TABLE `usergroup`
  ADD PRIMARY KEY (`id_group`,`id_user`),
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
  ADD PRIMARY KEY (`id_author`,`id_book`),
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
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `author`
--
ALTER TABLE `author`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=146;
--
-- AUTO_INCREMENT for table `book`
--
ALTER TABLE `book`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT for table `card`
--
ALTER TABLE `card`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `field_data`
--
ALTER TABLE `field_data`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=39;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `promotion`
--
ALTER TABLE `promotion`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
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
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `slider`
--
ALTER TABLE `slider`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `textpage`
--
ALTER TABLE `textpage`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

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
