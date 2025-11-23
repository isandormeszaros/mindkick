-- ============================================
-- QUIZ PLATFORM – FULL DATABASE (MySQL 8)
-- ============================================

DROP DATABASE IF EXISTS quiz;
CREATE DATABASE quiz
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE quiz;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================================
-- DROP TABLES IF EXISTS
-- ============================================

DROP TABLE IF EXISTS invite_codes;
DROP TABLE IF EXISTS leaderboard;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS friends;
DROP TABLE IF EXISTS user_stats;
DROP TABLE IF EXISTS user_badges;
DROP TABLE IF EXISTS badges;
DROP TABLE IF EXISTS quiz_questions;
DROP TABLE IF EXISTS quizzes;
DROP TABLE IF EXISTS question_logs;
DROP TABLE IF EXISTS results;
DROP TABLE IF EXISTS options;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

-- ============================================
-- USERS
-- ============================================

CREATE TABLE users (
  id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  display_name VARCHAR(100) DEFAULT NULL,
  avatar_url VARCHAR(500) DEFAULT NULL,
  role ENUM('user','admin') NOT NULL DEFAULT 'user',
  last_login TIMESTAMP NULL DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO users (id, username, email, password, display_name, avatar_url, role)
VALUES
(1, 'sandor', 'sandor@example.com',
'$2b$12$VePYM0ZKcqD5LTWRqcfybucoJ7tPi7HFLp2zDK9pBQBoS0z8bmVCi',
'Sándor', 'https://api.dicebear.com/7.x/identicon/svg?seed=sandor', 'user'),

(2, 'anna', 'anna@example.com',
'$2b$12$VePYM0ZKcqD5LTWRqcfybucoJ7tPi7HFLp2zDK9pBQBoS0z8bmVCi',
'Anna', 'https://api.dicebear.com/7.x/identicon/svg?seed=anna', 'user'),

(3, 'mate', 'mate@example.com',
'$2b$12$VePYM0ZKcqD5LTWRqcfybucoJ7tPi7HFLp2zDK9pBQBoS0z8bmVCi',
'Máté', 'https://api.dicebear.com/7.x/identicon/svg?seed=mate', 'user'),

(4, 'peter', 'peter@example.com',
'$2b$12$VePYM0ZKcqD5LTWRqcfybucoJ7tPi7HFLp2zDK9pBQBoS0z8bmVCi',
'Péter', 'https://api.dicebear.com/7.x/identicon/svg?seed=peter', 'user'),

(5, 'laura', 'laura@example.com',
'$2b$12$VePYM0ZKcqD5LTWRqcfybucoJ7tPi7HFLp2zDK9pBQBoS0z8bmVCi',
'Laura', 'https://api.dicebear.com/7.x/identicon/svg?seed=laura', 'user');


-- ============================================
-- CATEGORIES
-- ============================================

CREATE TABLE categories (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO categories VALUES
(1,'Filmek','Filmek, rendezők, karakterek, ikonikus jelenetek'),
(2,'Matematika','Algebra, geometria, számítások, logika'),
(3,'Kaland & Utazás','Világjárás, országok, túlélés, földrajz'),
(4,'Programozás','Kódolás, algoritmusok, hibakeresés, IT'),
(5,'Autók','Járművek, motorsport, technológia'),
(6,'Gaming','PC / konzol játékok, e-sport, karakterek'),
(7,'Történelem & Földrajz','Események, országok, civilizációk'),
(8,'Logikai fejtörők','Agytorna, mintafelismerés, problémamegoldás');

-- ============================================
-- QUESTIONS (1–120)
-- ============================================

CREATE TABLE questions (
  id INT NOT NULL AUTO_INCREMENT,
  category_id INT DEFAULT NULL,
  question_text TEXT NOT NULL,
  difficulty ENUM('easy','medium','hard') DEFAULT 'easy',
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY category_id (category_id),
  CONSTRAINT questions_ibfk_1 FOREIGN KEY (category_id)
    REFERENCES categories (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES questions WRITE;
INSERT INTO questions VALUES
(1,1,'Ki rendezte az Inception című filmet?','easy','2025-11-15 20:42:26'),
(2,1,'Mi volt a Marvel első filmje a MCU-ban?','easy','2025-11-15 20:42:26'),
(3,1,'Ki alakította Jack Sparrow-t?','easy','2025-11-15 20:42:26'),
(4,1,'Melyik filmben hangzik el: \"I am your father\"?','easy','2025-11-15 20:42:26'),
(5,1,'Hány Harry Potter film készült?','easy','2025-11-15 20:42:26'),
(6,1,'Mi a Terminátor híres mondata?','easy','2025-11-15 20:42:26'),
(7,1,'Hol játszódik a Jurassic Park első része?','medium','2025-11-15 20:42:26'),
(8,1,'Melyik évben jelent meg a Mátrix első része?','easy','2025-11-15 20:42:26'),
(9,1,'Melyik filmben szerepel a DeLorean időgép?','easy','2025-11-15 20:42:26'),
(10,1,'Ki rendezte a Titanic filmet?','medium','2025-11-15 20:42:26'),
(11,1,'Melyik film nyerte a 2020-as Oscar díjat?','medium','2025-11-15 20:42:26'),
(12,1,'Melyik sorozat főgonosza Voldemort?','easy','2025-11-15 20:42:26'),
(13,1,'Hol játszódik a Breaking Bad nagy része?','medium','2025-11-15 20:42:26'),
(14,1,'Ki mondta: \"You shall not pass!\"?','easy','2025-11-15 20:42:26'),
(15,1,'Melyik filmben szerepel Forrest Gump?','easy','2025-11-15 20:42:26'),
(16,2,'Mennyi 12 × 8?','easy','2025-11-15 20:42:26'),
(17,2,'Mi 7² értéke?','easy','2025-11-15 20:42:26'),
(18,2,'Mi a derékszög nagysága fokban?','easy','2025-11-15 20:42:26'),
(19,2,'Mi a 0 faktoriális értéke?','easy','2025-11-15 20:42:26'),
(20,2,'Mennyi 1000 / 25?','easy','2025-11-15 20:42:26'),
(21,2,'Mi a π értéke két tizedesre?','medium','2025-11-15 20:42:26'),
(22,2,'Mi az aritmetikai átlag definíciója?','medium','2025-11-15 20:42:26'),
(23,2,'Mi a Fibonacci-sor első három tagja?','medium','2025-11-15 20:42:26'),
(24,2,'Mi az 5! értéke?','medium','2025-11-15 20:42:26'),
(25,2,'Mit jelent a permutáció?','medium','2025-11-15 20:42:26'),
(26,2,'Mennyi 3⁴?','easy','2025-11-15 20:42:26'),
(27,2,'Mi az első tíz szám összege?','medium','2025-11-15 20:42:26'),
(28,2,'Hány fok egy egyenes szöge?','easy','2025-11-15 20:42:26'),
(29,2,'Mi a 15%-a a 200-nak?','medium','2025-11-15 20:42:26'),
(30,2,'Mennyit ér 9 × 9?','easy','2025-11-15 20:42:26'),
(31,3,'Hol található a Grand Canyon?','easy','2025-11-15 20:42:26'),
(32,3,'Melyik kontinensen van Kenya?','easy','2025-11-15 20:42:26'),
(33,3,'Mi a világ legmagasabb hegye?','easy','2025-11-15 20:42:26'),
(34,3,'Hol található a Szahara-sivatag?','easy','2025-11-15 20:42:26'),
(35,3,'Melyik tenger mossa Görögországot?','medium','2025-11-15 20:42:26'),
(36,3,'Melyik ország fővárosa Reykjavík?','easy','2025-11-15 20:42:26'),
(37,3,'Hol található az Amazonas őserdő?','easy','2025-11-15 20:42:26'),
(38,3,'Mi a túlélés első szabálya erdőben?','medium','2025-11-15 20:42:26'),
(39,3,'Hol van Machu Picchu?','medium','2025-11-15 20:42:26'),
(40,3,'Melyik európai országban van a Loire-völgy?','medium','2025-11-15 20:42:26'),
(41,3,'Melyik ország zászlaja piros-fehér-piros?','medium','2025-11-15 20:42:26'),
(42,3,'Hol található a Kilimandzsáró?','medium','2025-11-15 20:42:26'),
(43,3,'Melyik országban található Bali?','easy','2025-11-15 20:42:26'),
(44,3,'Mi a világ leghosszabb folyója?','medium','2025-11-15 20:42:26'),
(45,3,'Melyik országban található a Tajga?','medium','2025-11-15 20:42:26'),
(46,4,'Mi az a változó?','easy','2025-11-15 20:42:26'),
(47,4,'Mit jelent a null?','easy','2025-11-15 20:42:26'),
(48,4,'Mi a while ciklus szerepe?','easy','2025-11-15 20:42:26'),
(49,4,'Mi a függvény?','easy','2025-11-15 20:42:26'),
(50,4,'Mit jelent a bug?','easy','2025-11-15 20:42:26'),
(51,4,'Mi az API?','easy','2025-11-15 20:42:26'),
(52,4,'Mit jelent a 404-es hibakód?','easy','2025-11-15 20:42:26'),
(53,4,'Mi az open-source?','easy','2025-11-15 20:42:26'),
(54,4,'Mi a Git?','medium','2025-11-15 20:42:26'),
(55,4,'Mit jelent a refactor?','medium','2025-11-15 20:42:26'),
(56,4,'Mit jelent az O(1) időbonyolultság?','hard','2025-11-15 20:42:26'),
(57,4,'Mi az OOP?','medium','2025-11-15 20:42:26'),
(58,4,'Mi az SQL célja?','easy','2025-11-15 20:42:26'),
(59,4,'Mire való a JSON?','easy','2025-11-15 20:42:26'),
(60,4,'Mit jelent az async/await?','medium','2025-11-15 20:42:26'),
(61,5,'Hol gyártják a Bugatti autókat?','easy','2025-11-15 20:42:26'),
(62,5,'Melyik cég gyártja a Skyline GT-R-t?','easy','2025-11-15 20:42:26'),
(63,5,'Melyik autó hibrid: Prius vagy Mustang?','easy','2025-11-15 20:42:26'),
(64,5,'Mi a lóerő mértékegysége?','medium','2025-11-15 20:42:26'),
(65,5,'Mi a turbo szerepe?','easy','2025-11-15 20:42:26'),
(66,5,'Melyik márka készíti a Golfot?','easy','2025-11-15 20:42:26'),
(67,5,'Melyik gyorsabb: Tesla Plaid vagy BMW M3?','medium','2025-11-15 20:42:26'),
(68,5,'Mi az ABS?','easy','2025-11-15 20:42:26'),
(69,5,'Hol gyártják a Volvót?','easy','2025-11-15 20:42:26'),
(70,5,'Mi az ESP autótechnológia?','medium','2025-11-15 20:42:26'),
(71,5,'Mit jelent a drift?','easy','2025-11-15 20:42:26'),
(72,5,'Melyik márkához tartozik az AMG?','medium','2025-11-15 20:42:26'),
(73,5,'Mi a jó gyorsulás mérőszáma? (0–100?)','easy','2025-11-15 20:42:26'),
(74,5,'Mi az F1 autók tipikus motorja?','medium','2025-11-15 20:42:26'),
(75,5,'Mit mér a nyomaték?','medium','2025-11-15 20:42:26'),
(76,6,'Melyik játékban szerepel a Creeper?','easy','2025-11-15 20:42:26'),
(77,6,'Mit jelent az FPS?','easy','2025-11-15 20:42:26'),
(78,6,'Mikor jelent meg a GTA V?','medium','2025-11-15 20:42:26'),
(79,6,'Melyik játékban hangzik el: \"Nerf this!\"?','medium','2025-11-15 20:42:26'),
(80,6,'Ki Master Chief?','easy','2025-11-15 20:42:26'),
(81,6,'Hol jelent meg először a Fortnite?','medium','2025-11-15 20:42:26'),
(82,6,'Mit jelent az e-sport?','easy','2025-11-15 20:42:26'),
(83,6,'Melyik játékban vannak PokéBallok?','easy','2025-11-15 20:42:26'),
(84,6,'Mi a Steam?','easy','2025-11-15 20:42:26'),
(85,6,'Melyik játék főhőse Geralt?','easy','2025-11-15 20:42:26'),
(86,6,'Melyik cég készíti a PlayStationt?','easy','2025-11-15 20:42:26'),
(87,6,'Mi az RPG?','medium','2025-11-15 20:42:26'),
(88,6,'Mit jelent a nerf egy játékban?','medium','2025-11-15 20:42:26'),
(89,6,'Mi a Battle Royale műfaj?','medium','2025-11-15 20:42:26'),
(90,6,'Melyik játék a Counter-Strike folytatása?','easy','2025-11-15 20:42:26'),
(91,7,'Melyik ország fővárosa Berlin?','easy','2025-11-15 20:42:26'),
(92,7,'Ki volt Julius Caesar?','easy','2025-11-15 20:42:26'),
(93,7,'Melyik kontinensen található Argentína?','easy','2025-11-15 20:42:26'),
(94,7,'Mikor volt a második világháború?','medium','2025-11-15 20:42:26'),
(95,7,'Ki volt az első ember az űrben?','easy','2025-11-15 20:42:26'),
(96,7,'Hol található a Taj Mahal?','easy','2025-11-15 20:42:26'),
(97,7,'Melyik dél-amerikai ország hivatalos nyelve portugál?','medium','2025-11-15 20:42:26'),
(98,7,'Melyik két ország van a Koreai-félszigeten?','medium','2025-11-15 20:42:26'),
(99,7,'Mi volt az egyiptomi piramisok célja?','medium','2025-11-15 20:42:26'),
(100,7,'Melyik kontinenst nevezik Fekete-kontinensnek?','easy','2025-11-15 20:42:26'),
(101,7,'Melyik ország fővárosa Ottawa?','medium','2025-11-15 20:42:26'),
(102,7,'Ki volt Napóleon?','easy','2025-11-15 20:42:26'),
(103,7,'Melyik országban található a Machu Picchu?','easy','2025-11-15 20:42:26'),
(104,7,'Hol található Angkor Wat?','medium','2025-11-15 20:42:26'),
(105,7,'Melyik óceán a legnagyobb a Földön?','easy','2025-11-15 20:42:26'),
(106,8,'Mennyi 3 + 3 × 3?','easy','2025-11-15 20:42:26'),
(107,8,'Hány perc van egy napban?','medium','2025-11-15 20:42:26'),
(108,8,'Ha egy alma 100 Ft, mennyi 5 alma?','easy','2025-11-15 20:42:26'),
(109,8,'Mi következik: 2, 4, 8, 16...?','easy','2025-11-15 20:42:26'),
(110,8,'5 gép 5 perc alatt 5 terméket gyárt. 100 gép 100 terméket mennyi idő alatt gyárt?','hard','2025-11-15 20:42:26'),
(111,8,'Melyik nagyobb: 0.9 vagy 0.89?','easy','2025-11-15 20:42:26'),
(112,8,'Hány oldalú egy hatszög?','easy','2025-11-15 20:42:26'),
(113,8,'Mi a következő szám? 1, 1, 2, 3, 5...?','easy','2025-11-15 20:42:26'),
(114,8,'Mennyi 100 - 37?','easy','2025-11-15 20:42:26'),
(115,8,'Hány lába van egy póknak?','easy','2025-11-15 20:42:26'),
(116,8,'Mennyi 2×(3+4)?','easy','2025-11-15 20:42:26'),
(117,8,'Mi a következő betű a sorozatban: A, C, E, G...?','medium','2025-11-15 20:42:26'),
(118,8,'Mennyi 15×15?','easy','2025-11-15 20:42:26'),
(119,8,'Melyik nagyobb: 1/2 vagy 0.49?','medium','2025-11-15 20:42:26'),
(120,8,'Mennyi 99 + 101?','easy','2025-11-15 20:42:26');
UNLOCK TABLES;

-- ============================================
-- OPTIONS (1–480)
-- ============================================

CREATE TABLE options (
  id INT NOT NULL AUTO_INCREMENT,
  question_id INT NOT NULL,
  option_text TEXT NOT NULL,
  is_correct TINYINT(1) DEFAULT '0',
  PRIMARY KEY (id),
  KEY question_id (question_id),
  CONSTRAINT options_ibfk_1 FOREIGN KEY (question_id)
    REFERENCES questions (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES options WRITE;
INSERT INTO options VALUES
(1,1,'Christopher Nolan',1),(2,1,'Steven Spielberg',0),(3,1,'James Cameron',0),(4,1,'Ridley Scott',0),
(5,2,'Iron Man',1),(6,2,'The Incredible Hulk',0),(7,2,'Captain America: The First Avenger',0),(8,2,'Thor',0),
(9,3,'Johnny Depp',1),(10,3,'Leonardo DiCaprio',0),(11,3,'Keanu Reeves',0),(12,3,'Brad Pitt',0),
(13,4,'Star Wars: The Empire Strikes Back',1),(14,4,'Star Wars: A New Hope',0),(15,4,'Star Wars: Return of the Jedi',0),(16,4,'Rogue One: A Star Wars Story',0),
(17,5,'8',1),(18,5,'7',0),(19,5,'6',0),(20,5,'9',0),
(21,6,'I''ll be back',1),(22,6,'Say hello to my little friend',0),(23,6,'Hasta la vista, baby',0),(24,6,'Why so serious?',0),
(25,7,'Isla Nublar',1),(26,7,'Hawaii',0),(27,7,'New Zealand',0),(28,7,'Costa Rica',0),
(29,8,'1999',1),(30,8,'2001',0),(31,8,'1995',0),(32,8,'2003',0),
(33,9,'Vissza a jövőbe',1),(34,9,'Star Trek',0),(35,9,'Robotzsaru',0),(36,9,'Blade Runner',0),
(37,10,'James Cameron',1),(38,10,'Ron Howard',0),(39,10,'Ridley Scott',0),(40,10,'Martin Scorsese',0),
(41,11,'Élősködők (Parasite)',1),(42,11,'Joker',0),(43,11,'1917',0),(44,11,'Once Upon a Time in Hollywood',0),
(45,12,'Harry Potter',1),(46,12,'Narnia',0),(47,12,'Gyűrűk Ura',0),(48,12,'Éhezők Viadala',0),
(49,13,'Albuquerque',1),(50,13,'Los Angeles',0),(51,13,'Phoenix',0),(52,13,'Dallas',0),
(53,14,'Gandalf',1),(54,14,'Aragorn',0),(55,14,'Boromir',0),(56,14,'Dumbledore',0),
(57,15,'Forrest Gump',1),(58,15,'Saving Private Ryan',0),(59,15,'Rain Man',0),(60,15,'The Green Mile',0),
(61,16,'96',1),(62,16,'108',0),(63,16,'84',0),(64,16,'112',0),
(65,17,'49',1),(66,17,'56',0),(67,17,'64',0),(68,17,'36',0),
(69,18,'90°',1),(70,18,'45°',0),(71,18,'120°',0),(72,18,'30°',0),
(73,19,'1',1),(74,19,'0',0),(75,19,'5',0),(76,19,'10',0),
(77,20,'40',1),(78,20,'25',0),(79,20,'50',0),(80,20,'80',0),
(81,21,'3.14',1),(82,21,'3.41',0),(83,21,'3.04',0),(84,21,'3.11',0),
(85,22,'Számok összege osztva a darabszámmal',1),(86,22,'Leggyakoribb érték',0),(87,22,'Középső érték a sorban',0),(88,22,'A legnagyobb érték',0),
(89,23,'1, 1, 2',1),(90,23,'2, 3, 5',0),(91,23,'0, 1, 1',0),(92,23,'3, 3, 6',0),
(93,24,'120',1),(94,24,'24',0),(95,24,'720',0),(96,24,'60',0),
(97,25,'Elemek sorrendbe rendezése',1),(98,25,'Elemek számlálása',0),(99,25,'Elemek kivonása',0),(100,25,'Véletlen generálás',0),
(101,26,'81',1),(102,26,'64',0),(103,26,'72',0),(104,26,'27',0),
(105,27,'55',1),(106,27,'45',0),(107,27,'65',0),(108,27,'100',0),
(109,28,'180°',1),(110,28,'90°',0),(111,28,'360°',0),(112,28,'270°',0),
(113,29,'30',1),(114,29,'25',0),(115,29,'35',0),(116,29,'40',0),
(117,30,'81',1),(118,30,'72',0),(119,30,'64',0),(120,30,'99',0),
(121,31,'USA',1),(122,31,'Kanada',0),(123,31,'Mexikó',0),(124,31,'Brazília',0),
(125,32,'Afrika',1),(126,32,'Ázsia',0),(127,32,'Európa',0),(128,32,'Dél-Amerika',0),
(129,33,'Mount Everest',1),(130,33,'K2',0),(131,33,'Mont Blanc',0),(132,33,'Fuji',0),
(133,34,'Afrika',1),(134,34,'Dél-Amerika',0),(135,34,'Ausztrália',0),(136,34,'Ázsia',0),
(137,35,'Földközi-tenger',1),(138,35,'Fekete-tenger',0),(139,35,'Vörös-tenger',0),(140,35,'Adriai-tenger',0),
(141,36,'Izland',1),(142,36,'Norvégia',0),(143,36,'Finnország',0),(144,36,'Svédország',0),
(145,37,'Dél-Amerika',1),(146,37,'Afrika',0),(147,37,'Ausztrália',0),(148,37,'Ázsia',0),
(149,38,'Víz keresése',1),(150,38,'Tűz rakása',0),(151,38,'Táborhely építése',0),(152,38,'Ételgyűjtés',0),
(153,39,'Peru',1),(154,39,'Chile',0),(155,39,'Mexikó',0),(156,39,'Argentína',0),
(157,40,'Franciaország',1),(158,40,'Olaszország',0),(159,40,'Németország',0),(160,40,'Spanyolország',0),
(161,41,'Ausztria',1),(162,41,'Svédország',0),(163,41,'Lengyelország',0),(164,41,'Dánia',0),
(165,42,'Tanzánia',1),(166,42,'Zimbabwe',0),(167,42,'Nepál',0),(168,42,'Egyiptom',0),
(169,43,'Indonézia',1),(170,43,'Malajzia',0),(171,43,'Thaiföld',0),(172,43,'Fülöp-szigetek',0),
(173,44,'Nílus',1),(174,44,'Amazonas',0),(175,44,'Jangce',0),(176,44,'Mississippi',0),
(177,45,'Oroszország',1),(178,45,'Kanada',0),(179,45,'Mongólia',0),(180,45,'Norvégia',0),
(181,46,'Egy adat tárolására szolgáló névvel ellátott hely',1),(182,46,'Egy grafikus elem',0),(183,46,'Egy komplett program',0),(184,46,'Egy hálózati protokoll',0),
(185,47,'Nincs érték',1),(186,47,'Szöveges érték',0),(187,47,'Típushiba',0),(188,47,'A 0 szám',0),
(189,48,'Addig ismétel, amíg a feltétel igaz',1),(190,48,'Egyszer fut le mindig',0),(191,48,'Csak objektumokon működik',0),(192,48,'Csak számokat kezel',0),
(193,49,'Egy újra felhasználható kódrészlet',1),(194,49,'Egy fájltípus',0),(195,49,'Egy adatbázis tábla',0),(196,49,'Egy hardvereszköz',0),
(197,50,'Programhiba',1),(198,50,'Gyorsítási technika',0),(199,50,'Grafikus menü',0),(200,50,'Fizikai hálózati hiba',0),
(201,51,'Más programok számára elérhető funkciók összessége',1),(202,51,'Fájlrendszer megjelenítése',0),(203,51,'Grafika gyorsítása',0),(204,51,'Router konfigurálása',0),
(205,52,'Az oldal nem található',1),(206,52,'Szerverhibát jelent',0),(207,52,'Sikeres kérés',0),(208,52,'Átirányítás történt',0),
(209,53,'Bárki által megtekinthető és módosítható kód',1),(210,53,'Csak fizetős program',0),(211,53,'Zárt fejlesztői dokumentum',0),(212,53,'Képfeldolgozó algoritmus',0),
(213,54,'Verziókezelő rendszer',1),(214,54,'Mesterséges intelligencia',0),(215,54,'Hardver vezérlő',0),(216,54,'Operációs rendszer modul',0),
(217,55,'A kód javítása anélkül, hogy a működés változna',1),(218,55,'Új funkció hozzáadása',0),(219,55,'A program törlése',0),(220,55,'Adatbázis újratelepítése',0),
(221,56,'Azonnali végrehajtás, konstans idő',1),(222,56,'Lineáris sebesség',0),(223,56,'Négyzetes sebesség',0),(224,56,'Logaritmikus sebesség',0),
(225,57,'Objektumorientált programozás',1),(226,57,'Online optimalizációs protokoll',0),(227,57,'Operációs peremfeltétel',0),(228,57,'Opciós processzor',0),
(229,58,'Adatbázis lekérdező nyelv',1),(230,58,'Grafikai motor',0),(231,58,'Hangfeldolgozó modul',0),(232,58,'Hálózati titkosítás',0),
(233,59,'Egy egyszerű adatcsere-formátum',1),(234,59,'Programozási nyelv',0),(235,59,'Hardver driver',0),(236,59,'Képfájl tömörítő algoritmus',0),
(237,60,'Aszinkron műveletek kezelése egyszerűbben',1),(238,60,'Fizikai memóriakezelés',0),(239,60,'Adatbázis indexelés',0),(240,60,'Képfeldolgozás gyorsítása',0),
(241,61,'Franciaország',1),(242,61,'Németország',0),(243,61,'Olaszország',0),(244,61,'Svédország',0),
(245,62,'Nissan',1),(246,62,'Toyota',0),(247,62,'Subaru',0),(248,62,'Honda',0),
(249,63,'Toyota Prius',1),(250,63,'Ford Mustang',0),(251,63,'BMW M4',0),(252,63,'Audi RS7',0),
(253,64,'HP (Horsepower)',1),(254,64,'KMH',0),(255,64,'RPM',0),(256,64,'PSI',0),
(257,65,'A motor levegőellátásának növelése',1),(258,65,'A fékek hűtése',0),(259,65,'A gumiabroncs melegítése',0),(260,65,'A kipufogó zajának csökkentése',0),
(261,66,'Volkswagen',1),(262,66,'Mercedes',0),(263,66,'BMW',0),(264,66,'Skoda',0),
(265,67,'Tesla Model S Plaid',1),(266,67,'BMW M3',0),(267,67,'Audi RS5',0),(268,67,'Mercedes C63',0),
(269,68,'Blokkolásgátló fékrendszer',1),(270,68,'Automata sebességváltó',0),(271,68,'Motorvezérlő egység',0),(272,68,'Stabilizátor rúd',0),
(273,69,'Svédország',1),(274,69,'Németország',0),(275,69,'USA',0),(276,69,'Japán',0),
(277,70,'Elektronikus Stabilitás Program',1),(278,70,'Extra Speed Performance',0),(279,70,'Engine Safety Protocol',0),(280,70,'Energy Saving Program',0),
(281,71,'Hátul hajtással kanyar csúsztatása',1),(282,71,'Egyenes vonalú gyorsulás',0),(283,71,'Off-road ugrás',0),(284,71,'Motorleállítás',0),
(285,72,'Mercedes-Benz',1),(286,72,'BMW',0),(287,72,'Toyota',0),(288,72,'Kia',0),
(289,73,'0–100 km/h idő',1),(290,73,'Turbónyomás',0),(291,73,'Gumiabroncs szélesség',0),(292,73,'Futómű magasság',0),
(293,74,'Hibrid V6 turbó',1),(294,74,'V8 szívómotor',0),(295,74,'Soros 4-es',0),(296,74,'Hidrogénmotor',0),
(297,75,'Forgatóerőt',1),(298,75,'Féknyomást',0),(299,75,'Üzemanyag mennyiséget',0),(300,75,'A légellenállást',0),
(301,76,'Minecraft',1),(302,76,'Roblox',0),(303,76,'Fortnite',0),(304,76,'Terraria',0),
(305,77,'Frames Per Second',1),(306,77,'Fast Play Sequence',0),(307,77,'Full Performance System',0),(308,77,'First Person Setup',0),
(309,78,'2013',1),(310,78,'2010',0),(311,78,'2015',0),(312,78,'2018',0),
(313,79,'Overwatch',1),(314,79,'Valorant',0),(315,79,'League of Legends',0),(316,79,'Apex Legends',0),
(317,80,'Halo főhőse',1),(318,80,'Fortnite karakter',0),(319,80,'Minecraft főboss',0),(320,80,'GTA NPC',0),
(321,81,'PC és konzol együtt',1),(322,81,'Csak PlayStation',0),(323,81,'Csak Nintendo',0),(324,81,'Csak Xbox',0),
(325,82,'Versenyszerű videojáték',1),(326,82,'Egyjátékos story mód',0),(327,82,'Retro játék gyűjtemény',0),(328,82,'Játékfelvétel funkció',0),
(329,83,'Pokémon',1),(330,83,'Zelda',0),(331,83,'Mario Kart',0),(332,83,'Witcher 3',0),
(333,84,'Játékplatform és áruház',1),(334,84,'Grafikai motor',0),(335,84,'Konzol gyártó',0),(336,84,'E-sport csapat',0),
(337,85,'The Witcher',1),(338,85,'Dark Souls',0),(339,85,'Skyrim',0),(340,85,'God of War',0),
(341,86,'Sony',1),(342,86,'Microsoft',0),(343,86,'Nintendo',0),(344,86,'Sega',0),
(345,87,'Szerepjáték',1),(346,87,'Versenyjáték',0),(347,87,'Lövöldözős játék',0),(348,87,'Puzzle játék',0),
(349,88,'Gyengítést egy játékban',1),(350,88,'Fegyver erősítést',0),(351,88,'Grafika javítását',0),(352,88,'Játékmentés gyorsítását',0),
(353,89,'Túlélő lövöldözős játékmód',1),(354,89,'Csak kártyajáték',0),(355,89,'Kaland puzzle játék',0),(356,89,'Stratégiai társasjáték',0),
(357,90,'Counter-Strike 2',1),(358,90,'CS: Source Reloaded',0),(359,90,'Counter-Strike Revolution',0),(360,90,'Counter-Strike ZeroX',0),
(361,91,'Németország',1),(362,91,'Ausztria',0),(363,91,'Svájc',0),(364,91,'Belgium',0),
(365,92,'Római hadvezér és diktátor',1),(366,92,'Görög filozófus',0),(367,92,'Középkori király',0),(368,92,'Egyiptomi fáraó',0),
(369,93,'Dél-Amerika',1),(370,93,'Afrika',0),(371,93,'Európa',0),(372,93,'Ázsia',0),
(373,94,'1939–1945',1),(374,94,'1914–1918',0),(375,94,'1950–1953',0),(376,94,'1800–1810',0),
(377,95,'Yuri Gagarin',1),(378,95,'Neil Armstrong',0),(379,95,'Buzz Aldrin',0),(380,95,'Alan Shepard',0),
(381,96,'India',1),(382,96,'Pakisztán',0),(383,96,'Nepál',0),(384,96,'Banglades',0),
(385,97,'Brazília',1),(386,97,'Argentína',0),(387,97,'Peru',0),(388,97,'Chile',0),
(389,98,'Észak- és Dél-Korea',1),(390,98,'Japán és Korea',0),(391,98,'Kína és Korea',0),(392,98,'Mongólia és Korea',0),
(393,99,'Uralkodók sírhelye',1),(394,99,'Raktár',0),(395,99,'Hadsereg kiképzőhelye',0),(396,99,'Csillagvizsgáló',0),
(397,100,'Afrika',1),(398,100,'Dél-Amerika',0),(399,100,'Ázsia',0),(400,100,'Ausztrália',0),
(401,101,'Kanada',1),(402,101,'Egyesült Államok',0),(403,101,'Norvégia',0),(404,101,'Írország',0),
(405,102,'Francia katona és császár',1),(406,102,'Angol király',0),(407,102,'Olasz feltaláló',0),(408,102,'Spanyol admirális',0),
(409,103,'Peru',1),(410,103,'Mexikó',0),(411,103,'Kolumbia',0),(412,103,'Argentína',0),
(413,104,'Kambodzsa',1),(414,104,'Thaiföld',0),(415,104,'Laosz',0),(416,104,'Vietnám',0),
(417,105,'Csendes-óceán',1),(418,105,'Atlanti-óceán',0),(419,105,'Indiai-óceán',0),(420,105,'Jeges-tenger',0),
(421,106,'12',1),(422,106,'18',0),(423,106,'9',0),(424,106,'6',0),
(425,107,'1440',1),(426,107,'1240',0),(427,107,'1000',0),(428,107,'1560',0),
(429,108,'500 Ft',1),(430,108,'400 Ft',0),(431,108,'550 Ft',0),(432,108,'450 Ft',0),
(433,109,'32',1),(434,109,'20',0),(435,109,'24',0),(436,109,'64',0),
(437,110,'5 perc',1),(438,110,'100 perc',0),(439,110,'50 perc',0),(440,110,'10 perc',0),
(441,111,'0.9',1),(442,111,'0.89',0),(443,111,'0.5',0),(444,111,'1',0),
(445,112,'6',1),(446,112,'5',0),(447,112,'7',0),(448,112,'8',0),
(449,113,'8',1),(450,113,'6',0),(451,113,'5',0),(452,113,'9',0),
(453,114,'63',1),(454,114,'57',0),(455,114,'73',0),(456,114,'80',0),
(457,115,'8',1),(458,115,'6',0),(459,115,'10',0),(460,115,'12',0),
(461,116,'14',1),(462,116,'12',0),(463,116,'10',0),(464,116,'18',0),
(465,117,'I',1),(466,117,'H',0),(467,117,'J',0),(468,117,'K',0),
(469,118,'225',1),(470,118,'215',0),(471,118,'200',0),(472,118,'250',0),
(473,119,'1/2',1),(474,119,'0.49',0),(475,119,'0.4',0),(476,119,'0.3',0),
(477,120,'200',1),(478,120,'150',0),(479,120,'99',0),(480,120,'250',0);
UNLOCK TABLES;

-- ============================================
-- QUIZZES (előbb, hogy FK-k jók legyenek)
-- ============================================

CREATE TABLE quizzes (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(150) NOT NULL,
  description TEXT,
  category_id INT DEFAULT NULL,
  difficulty ENUM('easy','medium','hard') NOT NULL DEFAULT 'easy',
  is_published TINYINT(1) NOT NULL DEFAULT 0,
  created_by INT DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY category_id (category_id),
  KEY created_by (created_by),
  CONSTRAINT fk_quiz_category FOREIGN KEY (category_id)
    REFERENCES categories (id) ON DELETE SET NULL,
  CONSTRAINT fk_quiz_creator FOREIGN KEY (created_by)
    REFERENCES users (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO quizzes (id, title, description, category_id, difficulty, is_published, created_by) VALUES
(1, 'Filmek – Kezdő Quiz', '10 könnyű filmes kérdés, alap szint', 1, 'easy', 1, 1),
(2, 'Matematika – Logika Quiz', '10 logikai matek feladat', 2, 'medium', 1, 1),
(3, 'Gaming – Haladó Quiz', '10 kérdés népszerű játékokról', 6, 'medium', 1, 2);

-- ============================================
-- RESULTS (quizzes után)
-- ============================================

CREATE TABLE results (
  id INT NOT NULL AUTO_INCREMENT,
  user_id INT DEFAULT NULL,
  quiz_id INT DEFAULT NULL,
  score INT NOT NULL,
  total_questions INT NOT NULL,
  time_seconds INT DEFAULT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY user_id (user_id),
  KEY quiz_id (quiz_id),
  CONSTRAINT results_ibfk_1 FOREIGN KEY (user_id)
    REFERENCES users (id) ON DELETE SET NULL,
  CONSTRAINT results_ibfk_2 FOREIGN KEY (quiz_id)
    REFERENCES quizzes (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- (demó eredményt most nem teszek, legyen tiszta)

-- ============================================
-- QUESTION_LOGS
-- ============================================

CREATE TABLE question_logs (
  id INT NOT NULL AUTO_INCREMENT,
  user_id INT DEFAULT NULL,
  quiz_id INT DEFAULT NULL,
  question_id INT DEFAULT NULL,
  selected_option_id INT DEFAULT NULL,
  is_correct TINYINT(1) DEFAULT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY user_id (user_id),
  KEY question_id (question_id),
  KEY selected_option_id (selected_option_id),
  KEY quiz_id (quiz_id),
  CONSTRAINT question_logs_ibfk_1 FOREIGN KEY (user_id)
    REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT question_logs_ibfk_2 FOREIGN KEY (question_id)
    REFERENCES questions (id) ON DELETE CASCADE,
  CONSTRAINT question_logs_ibfk_3 FOREIGN KEY (selected_option_id)
    REFERENCES options (id) ON DELETE SET NULL,
  CONSTRAINT question_logs_ibfk_4 FOREIGN KEY (quiz_id)
    REFERENCES quizzes (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- QUIZ_QUESTIONS
-- ============================================

CREATE TABLE quiz_questions (
  quiz_id INT NOT NULL,
  question_id INT NOT NULL,
  order_index INT NOT NULL,
  PRIMARY KEY (quiz_id, question_id),
  KEY question_id (question_id),
  CONSTRAINT fk_qq_quiz FOREIGN KEY (quiz_id)
    REFERENCES quizzes (id) ON DELETE CASCADE,
  CONSTRAINT fk_qq_question FOREIGN KEY (question_id)
    REFERENCES questions (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO quiz_questions (quiz_id, question_id, order_index) VALUES
-- Film quiz: 1–10
(1, 1, 1),
(1, 2, 2),
(1, 3, 3),
(1, 4, 4),
(1, 5, 5),
(1, 6, 6),
(1, 7, 7),
(1, 8, 8),
(1, 9, 9),
(1, 10, 10),

-- Matek: 16–25
(2, 16, 1),
(2, 17, 2),
(2, 18, 3),
(2, 19, 4),
(2, 20, 5),
(2, 21, 6),
(2, 22, 7),
(2, 23, 8),
(2, 24, 9),
(2, 25, 10),

-- Gaming: 76–85
(3, 76, 1),
(3, 77, 2),
(3, 78, 3),
(3, 79, 4),
(3, 80, 5),
(3, 81, 6),
(3, 82, 7),
(3, 83, 8),
(3, 84, 9),
(3, 85, 10);

-- ============================================
-- BADGES
-- ============================================

CREATE TABLE badges (
  id INT NOT NULL AUTO_INCREMENT,
  code VARCHAR(50) NOT NULL,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  icon VARCHAR(255),
  condition_type ENUM('first_quiz','perfect_score','streak','total_score','custom') NOT NULL,
  condition_value INT DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY code (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO badges (id, code, name, description, icon, condition_type, condition_value) VALUES
(1,'FIRST_QUIZ', 'Első kitöltés', 'Tölts ki egy quizt', '/icons/first.png', 'first_quiz', 1),
(2,'PERFECT', 'Perfect Score', 'Érj el 100%-ot egy quizben', '/icons/perfect.png', 'perfect_score', 100),
(3,'STREAK_3', '3-as Streak', 'Tölts ki 3 különböző nap egymás után', '/icons/streak3.png', 'streak', 3),
(4,'STREAK_7', '7 napos Streak', '7 napos egymás utáni aktivitás', '/icons/streak7.png', 'streak', 7),
(5,'GAMER', 'Gaming Guru', 'Tölts ki legalább 3 gaming quizt', '/icons/gamer.png', 'total_score', 3),
(6,'MATEMATIKUS', 'Agysebész', 'Oldj meg 20 matek kérdést', '/icons/math.png', 'custom', 20);

-- ============================================
-- USER_BADGES
-- ============================================

CREATE TABLE user_badges (
  user_id INT NOT NULL,
  badge_id INT NOT NULL,
  earned_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, badge_id),
  KEY badge_id (badge_id),
  CONSTRAINT fk_ub_user FOREIGN KEY (user_id)
    REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_ub_badge FOREIGN KEY (badge_id)
    REFERENCES badges (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO user_badges (user_id, badge_id) VALUES
(1, 1),
(1, 2),
(1, 3);

-- ============================================
-- USER_STATS
-- ============================================

CREATE TABLE user_stats (
  user_id INT NOT NULL,
  total_score INT NOT NULL DEFAULT 0,
  quizzes_completed INT NOT NULL DEFAULT 0,
  current_streak INT NOT NULL DEFAULT 0,
  longest_streak INT NOT NULL DEFAULT 0,
  last_quiz_at TIMESTAMP NULL,
  PRIMARY KEY (user_id),
  CONSTRAINT fk_ustats_user FOREIGN KEY (user_id)
    REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO user_stats (user_id, total_score, quizzes_completed, current_streak, longest_streak) VALUES
(1, 150, 5, 2, 3),
(2, 40, 1, 1, 1),
(3, 0, 0, 0, 0),
(4, 0, 0, 0, 0),
(5, 0, 0, 0, 0);

-- ============================================
-- FRIENDS
-- ============================================

CREATE TABLE friends (
  user_id INT NOT NULL,
  friend_id INT NOT NULL,
  status ENUM('pending','accepted','blocked') NOT NULL DEFAULT 'pending',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, friend_id),
  KEY friend_id (friend_id),
  CONSTRAINT fk_friends_user FOREIGN KEY (user_id)
    REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_friends_friend FOREIGN KEY (friend_id)
    REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO friends (user_id, friend_id, status) VALUES
(1, 2, 'accepted'),
(1, 3, 'pending'),
(2, 3, 'accepted');

-- ============================================
-- MATCHES
-- ============================================

CREATE TABLE matches (
  id INT NOT NULL AUTO_INCREMENT,
  quiz_id INT NOT NULL,
  player1_id INT NOT NULL,
  player2_id INT NOT NULL,
  winner_id INT DEFAULT NULL,
  score_player1 INT NOT NULL,
  score_player2 INT NOT NULL,
  played_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY quiz_id (quiz_id),
  KEY player1_id (player1_id),
  KEY player2_id (player2_id),
  KEY winner_id (winner_id),
  CONSTRAINT fk_match_quiz FOREIGN KEY (quiz_id)
    REFERENCES quizzes (id) ON DELETE CASCADE,
  CONSTRAINT fk_match_p1 FOREIGN KEY (player1_id)
    REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_match_p2 FOREIGN KEY (player2_id)
    REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_match_winner FOREIGN KEY (winner_id)
    REFERENCES users (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO matches (quiz_id, player1_id, player2_id, winner_id, score_player1, score_player2) VALUES
(3, 1, 2, 1, 8, 6);

-- ============================================
-- LEADERBOARD
-- ============================================

CREATE TABLE leaderboard (
  id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  quiz_id INT DEFAULT NULL,
  score INT NOT NULL,
  rank_position INT DEFAULT NULL,
  period_type ENUM('daily','weekly','monthly','all_time') NOT NULL DEFAULT 'all_time',
  period_start DATE DEFAULT NULL,
  period_end DATE DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY user_id (user_id),
  KEY quiz_id (quiz_id),
  CONSTRAINT fk_lb_user FOREIGN KEY (user_id)
    REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_lb_quiz FOREIGN KEY (quiz_id)
    REFERENCES quizzes (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO leaderboard (user_id, quiz_id, score, rank_position, period_type, period_start, period_end)
VALUES (1, 1, 90, 1, 'weekly', '2025-11-17', '2025-11-23');

-- ============================================
-- INVITE_CODES
-- ============================================

CREATE TABLE invite_codes (
  code VARCHAR(20) NOT NULL,
  creator_user_id INT NOT NULL,
  quiz_id INT NOT NULL,
  status ENUM('active','used','expired') NOT NULL DEFAULT 'active',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  expires_at TIMESTAMP NULL,
  used_by_user_id INT NULL,
  used_at TIMESTAMP NULL,
  PRIMARY KEY (code),
  KEY creator_user_id (creator_user_id),
  KEY quiz_id (quiz_id),
  KEY used_by_user_id (used_by_user_id),
  CONSTRAINT fk_inv_creator FOREIGN KEY (creator_user_id)
    REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_inv_quiz FOREIGN KEY (quiz_id)
    REFERENCES quizzes (id) ON DELETE CASCADE,
  CONSTRAINT fk_inv_used_by FOREIGN KEY (used_by_user_id)
    REFERENCES users (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO invite_codes (code, creator_user_id, quiz_id, status) VALUES
('ABC123', 1, 3, 'active');

-- ============================================
-- DONE
-- ============================================

SET FOREIGN_KEY_CHECKS = 1;