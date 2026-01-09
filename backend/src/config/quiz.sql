-- ============================================
-- QUIZ PLATFORM – FULL DATABASE (MySQL 8)
-- FIXED VERSION (Auto-increment ID fix)
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
-- CATEGORIES (With Images)
-- ============================================

CREATE TABLE categories (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  image_url VARCHAR(500) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO categories (id, name, description, image_url) VALUES
(1,'Filmek','Filmek, rendezők, karakterek, ikonikus jelenetek', 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?auto=format&fit=crop&w=800&q=80'),
(2,'Matematika','Algebra, geometria, számítások, logika', 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?auto=format&fit=crop&w=800&q=80'),
(3,'Kaland & Utazás','Világjárás, országok, túlélés, földrajz', 'https://images.unsplash.com/photo-1524850011238-e3d235c1d4a9?auto=format&fit=crop&w=800&q=80'),
(4,'Programozás','Kódolás, algoritmusok, hibakeresés, IT', 'https://images.unsplash.com/photo-1587620962725-abab7fe55159?auto=format&fit=crop&w=800&q=80'),
(5,'Autók','Járművek, motorsport, technológia', 'https://images.unsplash.com/photo-1503376763036-066120622c74?auto=format&fit=crop&w=800&q=80'),
(6,'Gaming','PC / konzol játékok, e-sport, karakterek', 'https://images.unsplash.com/photo-1538481199705-c710c4e965fc?auto=format&fit=crop&w=800&q=80'),
(7,'Történelem & Földrajz','Események, országok, civilizációk', 'https://images.unsplash.com/photo-1461360370896-922624d12aa1?auto=format&fit=crop&w=800&q=80'),
(8,'Logikai fejtörők','Agytorna, mintafelismerés, problémamegoldás', 'https://images.unsplash.com/photo-1587654780291-39c9404d746b?auto=format&fit=crop&w=800&q=80'),
(9, 'Zene & Kultúra', 'Hangszerek, együttesek, zenei stílusok és kultúra.', 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=800&q=80'),
(10, 'Tudomány & Természet', 'Biológia, fizika, állatvilág és az univerzum titkai.', 'https://images.unsplash.com/photo-1532094349884-543bc11b234d?auto=format&fit=crop&w=800&q=80'),
(11, 'Sport', 'Olimpia, foci, világrekordok és híres sportolók.', 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&w=800&q=80'),
(12, 'Gasztronómia', 'Nemzeti ételek, fűszerek, italok és konyhaművészet.', 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80');

-- ============================================
-- QUESTIONS (1–160)
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
INSERT INTO questions (id, category_id, question_text, difficulty, created_at) VALUES
(1,1,'Ki rendezte az Inception című filmet?','easy', NOW()),
(2,1,'Mi volt a Marvel első filmje a MCU-ban?','easy', NOW()),
(3,1,'Ki alakította Jack Sparrow-t?','easy', NOW()),
(4,1,'Melyik filmben hangzik el: \"I am your father\"?','easy', NOW()),
(5,1,'Hány Harry Potter film készült?','easy', NOW()),
(6,1,'Mi a Terminátor híres mondata?','easy', NOW()),
(7,1,'Hol játszódik a Jurassic Park első része?','medium', NOW()),
(8,1,'Melyik évben jelent meg a Mátrix első része?','easy', NOW()),
(9,1,'Melyik filmben szerepel a DeLorean időgép?','easy', NOW()),
(10,1,'Ki rendezte a Titanic filmet?','medium', NOW()),
(11,1,'Melyik film nyerte a 2020-as Oscar díjat?','medium', NOW()),
(12,1,'Melyik sorozat főgonosza Voldemort?','easy', NOW()),
(13,1,'Hol játszódik a Breaking Bad nagy része?','medium', NOW()),
(14,1,'Ki mondta: \"You shall not pass!\"?','easy', NOW()),
(15,1,'Melyik filmben szerepel Forrest Gump?','easy', NOW()),
(16,2,'Mennyi 12 × 8?','easy', NOW()),
(17,2,'Mi 7² értéke?','easy', NOW()),
(18,2,'Mi a derékszög nagysága fokban?','easy', NOW()),
(19,2,'Mi a 0 faktoriális értéke?','easy', NOW()),
(20,2,'Mennyi 1000 / 25?','easy', NOW()),
(21,2,'Mi a π értéke két tizedesre?','medium', NOW()),
(22,2,'Mi az aritmetikai átlag definíciója?','medium', NOW()),
(23,2,'Mi a Fibonacci-sor első három tagja?','medium', NOW()),
(24,2,'Mi az 5! értéke?','medium', NOW()),
(25,2,'Mit jelent a permutáció?','medium', NOW()),
(26,2,'Mennyi 3⁴?','easy', NOW()),
(27,2,'Mi az első tíz szám összege?','medium', NOW()),
(28,2,'Hány fok egy egyenes szöge?','easy', NOW()),
(29,2,'Mi a 15%-a a 200-nak?','medium', NOW()),
(30,2,'Mennyit ér 9 × 9?','easy', NOW()),
(31,3,'Hol található a Grand Canyon?','easy', NOW()),
(32,3,'Melyik kontinensen van Kenya?','easy', NOW()),
(33,3,'Mi a világ legmagasabb hegye?','easy', NOW()),
(34,3,'Hol található a Szahara-sivatag?','easy', NOW()),
(35,3,'Melyik tenger mossa Görögországot?','medium', NOW()),
(36,3,'Melyik ország fővárosa Reykjavík?','easy', NOW()),
(37,3,'Hol található az Amazonas őserdő?','easy', NOW()),
(38,3,'Mi a túlélés első szabálya erdőben?','medium', NOW()),
(39,3,'Hol van Machu Picchu?','medium', NOW()),
(40,3,'Melyik európai országban van a Loire-völgy?','medium', NOW()),
(41,3,'Melyik ország zászlaja piros-fehér-piros?','medium', NOW()),
(42,3,'Hol található a Kilimandzsáró?','medium', NOW()),
(43,3,'Melyik országban található Bali?','easy', NOW()),
(44,3,'Mi a világ leghosszabb folyója?','medium', NOW()),
(45,3,'Melyik országban található a Tajga?','medium', NOW()),
(46,4,'Mi az a változó?','easy', NOW()),
(47,4,'Mit jelent a null?','easy', NOW()),
(48,4,'Mi a while ciklus szerepe?','easy', NOW()),
(49,4,'Mi a függvény?','easy', NOW()),
(50,4,'Mit jelent a bug?','easy', NOW()),
(51,4,'Mi az API?','easy', NOW()),
(52,4,'Mit jelent a 404-es hibakód?','easy', NOW()),
(53,4,'Mi az open-source?','easy', NOW()),
(54,4,'Mi a Git?','medium', NOW()),
(55,4,'Mit jelent a refactor?','medium', NOW()),
(56,4,'Mit jelent az O(1) időbonyolultság?','hard', NOW()),
(57,4,'Mi az OOP?','medium', NOW()),
(58,4,'Mi az SQL célja?','easy', NOW()),
(59,4,'Mire való a JSON?','easy', NOW()),
(60,4,'Mit jelent az async/await?','medium', NOW()),
(61,5,'Hol gyártják a Bugatti autókat?','easy', NOW()),
(62,5,'Melyik cég gyártja a Skyline GT-R-t?','easy', NOW()),
(63,5,'Melyik autó hibrid: Prius vagy Mustang?','easy', NOW()),
(64,5,'Mi a lóerő mértékegysége?','medium', NOW()),
(65,5,'Mi a turbo szerepe?','easy', NOW()),
(66,5,'Melyik márka készíti a Golfot?','easy', NOW()),
(67,5,'Melyik gyorsabb: Tesla Plaid vagy BMW M3?','medium', NOW()),
(68,5,'Mi az ABS?','easy', NOW()),
(69,5,'Hol gyártják a Volvót?','easy', NOW()),
(70,5,'Mi az ESP autótechnológia?','medium', NOW()),
(71,5,'Mit jelent a drift?','easy', NOW()),
(72,5,'Melyik márkához tartozik az AMG?','medium', NOW()),
(73,5,'Mi a jó gyorsulás mérőszáma? (0–100?)','easy', NOW()),
(74,5,'Mi az F1 autók tipikus motorja?','medium', NOW()),
(75,5,'Mit mér a nyomaték?','medium', NOW()),
(76,6,'Melyik játékban szerepel a Creeper?','easy', NOW()),
(77,6,'Mit jelent az FPS?','easy', NOW()),
(78,6,'Mikor jelent meg a GTA V?','medium', NOW()),
(79,6,'Melyik játékban hangzik el: \"Nerf this!\"?','medium', NOW()),
(80,6,'Ki Master Chief?','easy', NOW()),
(81,6,'Hol jelent meg először a Fortnite?','medium', NOW()),
(82,6,'Mit jelent az e-sport?','easy', NOW()),
(83,6,'Melyik játékban vannak PokéBallok?','easy', NOW()),
(84,6,'Mi a Steam?','easy', NOW()),
(85,6,'Melyik játék főhőse Geralt?','easy', NOW()),
(86,6,'Melyik cég készíti a PlayStationt?','easy', NOW()),
(87,6,'Mi az RPG?','medium', NOW()),
(88,6,'Mit jelent a nerf egy játékban?','medium', NOW()),
(89,6,'Mi a Battle Royale műfaj?','medium', NOW()),
(90,6,'Melyik játék a Counter-Strike folytatása?','easy', NOW()),
(91,7,'Melyik ország fővárosa Berlin?','easy', NOW()),
(92,7,'Ki volt Julius Caesar?','easy', NOW()),
(93,7,'Melyik kontinensen található Argentína?','easy', NOW()),
(94,7,'Mikor volt a második világháború?','medium', NOW()),
(95,7,'Ki volt az első ember az űrben?','easy', NOW()),
(96,7,'Hol található a Taj Mahal?','easy', NOW()),
(97,7,'Melyik dél-amerikai ország hivatalos nyelve portugál?','medium', NOW()),
(98,7,'Melyik két ország van a Koreai-félszigeten?','medium', NOW()),
(99,7,'Mi volt az egyiptomi piramisok célja?','medium', NOW()),
(100,7,'Melyik kontinenst nevezik Fekete-kontinensnek?','easy', NOW()),
(101,7,'Melyik ország fővárosa Ottawa?','medium', NOW()),
(102,7,'Ki volt Napóleon?','easy', NOW()),
(103,7,'Melyik országban található a Machu Picchu?','easy', NOW()),
(104,7,'Hol található Angkor Wat?','medium', NOW()),
(105,7,'Melyik óceán a legnagyobb a Földön?','easy', NOW()),
(106,8,'Mennyi 3 + 3 × 3?','easy', NOW()),
(107,8,'Hány perc van egy napban?','medium', NOW()),
(108,8,'Ha egy alma 100 Ft, mennyi 5 alma?','easy', NOW()),
(109,8,'Mi következik: 2, 4, 8, 16...?','easy', NOW()),
(110,8,'5 gép 5 perc alatt 5 terméket gyárt. 100 gép 100 terméket mennyi idő alatt gyárt?','hard', NOW()),
(111,8,'Melyik nagyobb: 0.9 vagy 0.89?','easy', NOW()),
(112,8,'Hány oldalú egy hatszög?','easy', NOW()),
(113,8,'Mi a következő szám? 1, 1, 2, 3, 5...?','easy', NOW()),
(114,8,'Mennyi 100 - 37?','easy', NOW()),
(115,8,'Hány lába van egy póknak?','easy', NOW()),
(116,8,'Mennyi 2×(3+4)?','easy', NOW()),
(117,8,'Mi a következő betű a sorozatban: A, C, E, G...?','medium', NOW()),
(118,8,'Mennyi 15×15?','easy', NOW()),
(119,8,'Melyik nagyobb: 1/2 vagy 0.49?','medium', NOW()),
(120,8,'Mennyi 99 + 101?','easy', NOW()),
(121, 9, 'Hány húrja van egy klasszikus gitárnak?', 'easy', NOW()),
(122, 9, 'Ki a "Pop királya"?', 'easy', NOW()),
(123, 9, 'Melyik zenekar énekelte a "Bohemian Rhapsody"-t?', 'easy', NOW()),
(124, 9, 'Mi a hegedűvonó szőrének hagyományos anyaga?', 'medium', NOW()),
(125, 9, 'Melyik magyar zeneszerző írta a "Kékszakállú herceg várát"?', 'hard', NOW()),
(126, 9, 'Hány billentyű van egy szabványos zongorán?', 'medium', NOW()),
(127, 9, 'Kinek a nevéhez fűződik a "Négy évszak"?', 'medium', NOW()),
(128, 9, 'Melyik hangszer a jazz "lelke"?', 'easy', NOW()),
(129, 9, 'Hol rendezték meg az első Woodstock fesztivált?', 'medium', NOW()),
(130, 9, 'Melyik évben alakult a Beatles?', 'hard', NOW()),
(131, 10, 'Mi a víz kémiai képlete?', 'easy', NOW()),
(132, 10, 'Melyik bolygó a "Vörös bolygó"?', 'easy', NOW()),
(133, 10, 'Hány csont van egy felnőtt emberi testben?', 'medium', NOW()),
(134, 10, 'Mi a fénysebesség kerekített értéke (km/s)?', 'hard', NOW()),
(135, 10, 'Melyik állat a leggyorsabb szárazföldön?', 'easy', NOW()),
(136, 10, 'Mit mér a Richter-skála?', 'medium', NOW()),
(137, 10, 'Ki fedezte fel a penicillint?', 'hard', NOW()),
(138, 10, 'Melyik elem vegyjele az O?', 'easy', NOW()),
(139, 10, 'Mi a DNS teljes neve?', 'hard', NOW()),
(140, 10, 'Hány szíve van egy polipnak?', 'medium', NOW()),
(141, 11, 'Hány karika van az olimpiai zászlón?', 'easy', NOW()),
(142, 11, 'Melyik sportágban szerzett hírnevet Puskás Ferenc?', 'easy', NOW()),
(143, 11, 'Hány percig tart egy normál labdarúgó mérkőzés?', 'easy', NOW()),
(144, 11, 'Melyik ország rendezte az első modern olimpiát (1896)?', 'medium', NOW()),
(145, 11, 'Hány játékos van egyszerre a pályán egy kosárlabda csapatban?', 'medium', NOW()),
(146, 11, 'Milyen színű a legértékesebb érem az Olimpián?', 'easy', NOW()),
(147, 11, 'Ki tartja a 100 méteres síkfutás világrekordját?', 'easy', NOW()),
(148, 11, 'Melyik sportágban használják a "pakk"-ot?', 'easy', NOW()),
(149, 11, 'Hány menetből áll egy profi bokszbajnoki mérkőzés (általában)?', 'hard', NOW()),
(150, 11, 'Melyik városban van a Wimbledon teniszbajnokság?', 'medium', NOW()),
(151, 12, 'Melyik országból származik a pizza?', 'easy', NOW()),
(152, 12, 'Mi a Guacamole fő alapanyaga?', 'easy', NOW()),
(153, 12, 'Miből készül a tofu?', 'medium', NOW()),
(154, 12, 'Melyik vitaminban gazdag a Szent-Györgyi Albert által kutatott paprika?', 'medium', NOW()),
(155, 12, 'Mit mér a Scoville-skála?', 'hard', NOW()),
(156, 12, 'Melyik étel NEM olasz eredetű?', 'medium', NOW()),
(157, 12, 'Melyik gabonából készül a szaké?', 'medium', NOW()),
(158, 12, 'Mi a Gulyásleves alapja?', 'easy', NOW()),
(159, 12, 'Melyik a világ legdrágább fűszere?', 'hard', NOW()),
(160, 12, 'Milyen ízű az Umami?', 'hard', NOW());
UNLOCK TABLES;

-- ============================================
-- OPTIONS (1–640)
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

-- FONTOS VÁLTOZÁS: Kihagytam a kézi 'id' mezőt.
-- A MySQL automatikusan sorba rakja őket 1-től 640-ig.
-- Így nem lehet duplicate entry hiba.

LOCK TABLES options WRITE;
INSERT INTO options (question_id, option_text, is_correct) VALUES
(1,'Christopher Nolan',1),(1,'Steven Spielberg',0),(1,'James Cameron',0),(1,'Ridley Scott',0),
(2,'Iron Man',1),(2,'The Incredible Hulk',0),(2,'Captain America: The First Avenger',0),(2,'Thor',0),
(3,'Johnny Depp',1),(3,'Leonardo DiCaprio',0),(3,'Keanu Reeves',0),(3,'Brad Pitt',0),
(4,'Star Wars: The Empire Strikes Back',1),(4,'Star Wars: A New Hope',0),(4,'Star Wars: Return of the Jedi',0),(4,'Rogue One: A Star Wars Story',0),
(5,'8',1),(5,'7',0),(5,'6',0),(5,'9',0),
(6,'I''ll be back',1),(6,'Say hello to my little friend',0),(6,'Hasta la vista, baby',0),(6,'Why so serious?',0),
(7,'Isla Nublar',1),(7,'Hawaii',0),(7,'New Zealand',0),(7,'Costa Rica',0),
(8,'1999',1),(8,'2001',0),(8,'1995',0),(8,'2003',0),
(9,'Vissza a jövőbe',1),(9,'Star Trek',0),(9,'Robotzsaru',0),(9,'Blade Runner',0),
(10,'James Cameron',1),(10,'Ron Howard',0),(10,'Ridley Scott',0),(10,'Martin Scorsese',0),
(11,'Élősködők (Parasite)',1),(11,'Joker',0),(11,'1917',0),(11,'Once Upon a Time in Hollywood',0),
(12,'Harry Potter',1),(12,'Narnia',0),(12,'Gyűrűk Ura',0),(12,'Éhezők Viadala',0),
(13,'Albuquerque',1),(13,'Los Angeles',0),(13,'Phoenix',0),(13,'Dallas',0),
(14,'Gandalf',1),(14,'Aragorn',0),(14,'Boromir',0),(14,'Dumbledore',0),
(15,'Forrest Gump',1),(15,'Saving Private Ryan',0),(15,'Rain Man',0),(15,'The Green Mile',0),
(16,'96',1),(16,'108',0),(16,'84',0),(16,'112',0),
(17,'49',1),(17,'56',0),(17,'64',0),(17,'36',0),
(18,'90°',1),(18,'45°',0),(18,'120°',0),(18,'30°',0),
(19,'1',1),(19,'0',0),(19,'5',0),(19,'10',0),
(20,'40',1),(20,'25',0),(20,'50',0),(20,'80',0),
(21,'3.14',1),(21,'3.41',0),(21,'3.04',0),(21,'3.11',0),
(22,'Számok összege osztva a darabszámmal',1),(22,'Leggyakoribb érték',0),(22,'Középső érték a sorban',0),(22,'A legnagyobb érték',0),
(23,'1, 1, 2',1),(23,'2, 3, 5',0),(23,'0, 1, 1',0),(23,'3, 3, 6',0),
(24,'120',1),(24,'24',0),(24,'720',0),(24,'60',0),
(25,'Elemek sorrendbe rendezése',1),(25,'Elemek számlálása',0),(25,'Elemek kivonása',0),(25,'Véletlen generálás',0),
(26,'81',1),(26,'64',0),(26,'72',0),(26,'27',0),
(27,'55',1),(27,'45',0),(27,'65',0),(27,'100',0),
(28,'180°',1),(28,'90°',0),(28,'360°',0),(28,'270°',0),
(29,'30',1),(29,'25',0),(29,'35',0),(29,'40',0),
(30,'81',1),(30,'72',0),(30,'64',0),(30,'99',0),
(31,'USA',1),(31,'Kanada',0),(31,'Mexikó',0),(31,'Brazília',0),
(32,'Afrika',1),(32,'Ázsia',0),(32,'Európa',0),(32,'Dél-Amerika',0),
(33,'Mount Everest',1),(33,'K2',0),(33,'Mont Blanc',0),(33,'Fuji',0),
(34,'Afrika',1),(34,'Dél-Amerika',0),(34,'Ausztrália',0),(34,'Ázsia',0),
(35,'Földközi-tenger',1),(35,'Fekete-tenger',0),(35,'Vörös-tenger',0),(35,'Adriai-tenger',0),
(36,'Izland',1),(36,'Norvégia',0),(36,'Finnország',0),(36,'Svédország',0),
(37,'Dél-Amerika',1),(37,'Afrika',0),(37,'Ausztrália',0),(37,'Ázsia',0),
(38,'Víz keresése',1),(38,'Tűz rakása',0),(38,'Táborhely építése',0),(38,'Ételgyűjtés',0),
(39,'Peru',1),(39,'Chile',0),(39,'Mexikó',0),(39,'Argentína',0),
(40,'Franciaország',1),(40,'Olaszország',0),(40,'Németország',0),(40,'Spanyolország',0),
(41,'Ausztria',1),(41,'Svédország',0),(41,'Lengyelország',0),(41,'Dánia',0),
(42,'Tanzánia',1),(42,'Zimbabwe',0),(42,'Nepál',0),(42,'Egyiptom',0),
(43,'Indonézia',1),(43,'Malajzia',0),(43,'Thaiföld',0),(43,'Fülöp-szigetek',0),
(44,'Nílus',1),(44,'Amazonas',0),(44,'Jangce',0),(44,'Mississippi',0),
(45,'Oroszország',1),(45,'Kanada',0),(45,'Mongólia',0),(45,'Norvégia',0),
(46,'Egy adat tárolására szolgáló névvel ellátott hely',1),(46,'Egy grafikus elem',0),(46,'Egy komplett program',0),(46,'Egy hálózati protokoll',0),
(47,'Nincs érték',1),(47,'Szöveges érték',0),(47,'Típushiba',0),(47,'A 0 szám',0),
(48,'Addig ismétel, amíg a feltétel igaz',1),(48,'Egyszer fut le mindig',0),(48,'Csak objektumokon működik',0),(48,'Csak számokat kezel',0),
(49,'Egy újra felhasználható kódrészlet',1),(49,'Egy fájltípus',0),(49,'Egy adatbázis tábla',0),(49,'Egy hardvereszköz',0),
(50,'Programhiba',1),(50,'Gyorsítási technika',0),(50,'Grafikus menü',0),(50,'Fizikai hálózati hiba',0),
(51,'Más programok számára elérhető funkciók összessége',1),(51,'Fájlrendszer megjelenítése',0),(51,'Grafika gyorsítása',0),(51,'Router konfigurálása',0),
(52,'Az oldal nem található',1),(52,'Szerverhibát jelent',0),(52,'Sikeres kérés',0),(52,'Átirányítás történt',0),
(53,'Bárki által megtekinthető és módosítható kód',1),(53,'Csak fizetős program',0),(53,'Zárt fejlesztői dokumentum',0),(53,'Képfeldolgozó algoritmus',0),
(54,'Verziókezelő rendszer',1),(54,'Mesterséges intelligencia',0),(54,'Hardver vezérlő',0),(54,'Operációs rendszer modul',0),
(55,'A kód javítása anélkül, hogy a működés változna',1),(55,'Új funkció hozzáadása',0),(55,'A program törlése',0),(55,'Adatbázis újratelepítése',0),
(56,'Azonnali végrehajtás, konstans idő',1),(56,'Lineáris sebesség',0),(56,'Négyzetes sebesség',0),(56,'Logaritmikus sebesség',0),
(57,'Objektumorientált programozás',1),(57,'Online optimalizációs protokoll',0),(57,'Operációs peremfeltétel',0),(57,'Opciós processzor',0),
(58,'Adatbázis lekérdező nyelv',1),(58,'Grafikai motor',0),(58,'Hangfeldolgozó modul',0),(58,'Hálózati titkosítás',0),
(59,'Egy egyszerű adatcsere-formátum',1),(59,'Programozási nyelv',0),(59,'Hardver driver',0),(59,'Képfájl tömörítő algoritmus',0),
(60,'Aszinkron műveletek kezelése egyszerűbben',1),(60,'Fizikai memóriakezelés',0),(60,'Adatbázis indexelés',0),(60,'Képfeldolgozás gyorsítása',0),
(61,'Franciaország',1),(61,'Németország',0),(61,'Olaszország',0),(61,'Svédország',0),
(62,'Nissan',1),(62,'Toyota',0),(62,'Subaru',0),(62,'Honda',0),
(63,'Toyota Prius',1),(63,'Ford Mustang',0),(63,'BMW M4',0),(63,'Audi RS7',0),
(64,'HP (Horsepower)',1),(64,'KMH',0),(64,'RPM',0),(64,'PSI',0),
(65,'A motor levegőellátásának növelése',1),(65,'A fékek hűtése',0),(65,'A gumiabroncs melegítése',0),(65,'A kipufogó zajának csökkentése',0),
(66,'Volkswagen',1),(66,'Mercedes',0),(66,'BMW',0),(66,'Skoda',0),
(67,'Tesla Model S Plaid',1),(67,'BMW M3',0),(67,'Audi RS5',0),(67,'Mercedes C63',0),
(68,'Blokkolásgátló fékrendszer',1),(68,'Automata sebességváltó',0),(68,'Motorvezérlő egység',0),(68,'Stabilizátor rúd',0),
(69,'Svédország',1),(69,'Németország',0),(69,'USA',0),(69,'Japán',0),
(70,'Elektronikus Stabilitás Program',1),(70,'Extra Speed Performance',0),(70,'Engine Safety Protocol',0),(70,'Energy Saving Program',0),
(71,'Hátul hajtással kanyar csúsztatása',1),(71,'Egyenes vonalú gyorsulás',0),(71,'Off-road ugrás',0),(71,'Motorleállítás',0),
(72,'Mercedes-Benz',1),(72,'BMW',0),(72,'Toyota',0),(72,'Kia',0),
(73,'0–100 km/h idő',1),(73,'Turbónyomás',0),(73,'Gumiabroncs szélesség',0),(73,'Futómű magasság',0),
(74,'Hibrid V6 turbó',1),(74,'V8 szívómotor',0),(74,'Soros 4-es',0),(74,'Hidrogénmotor',0),
(75,'Forgatóerőt',1),(75,'Féknyomást',0),(75,'Üzemanyag mennyiséget',0),(75,'A légellenállást',0),
(76,'Minecraft',1),(76,'Roblox',0),(76,'Fortnite',0),(76,'Terraria',0),
(77,'Frames Per Second',1),(77,'Fast Play Sequence',0),(77,'Full Performance System',0),(77,'First Person Setup',0),
(78,'2013',1),(78,'2010',0),(78,'2015',0),(78,'2018',0),
(79,'Overwatch',1),(79,'Valorant',0),(79,'League of Legends',0),(79,'Apex Legends',0),
(80,'Halo főhőse',1),(80,'Fortnite karakter',0),(80,'Minecraft főboss',0),(80,'GTA NPC',0),
(81,'PC és konzol együtt',1),(81,'Csak PlayStation',0),(81,'Csak Nintendo',0),(81,'Csak Xbox',0),
(82,'Versenyszerű videojáték',1),(82,'Egyjátékos story mód',0),(82,'Retro játék gyűjtemény',0),(82,'Játékfelvétel funkció',0),
(83,'Pokémon',1),(83,'Zelda',0),(83,'Mario Kart',0),(83,'Witcher 3',0),
(84,'Játékplatform és áruház',1),(84,'Grafikai motor',0),(84,'Konzol gyártó',0),(84,'E-sport csapat',0),
(85,'The Witcher',1),(85,'Dark Souls',0),(85,'Skyrim',0),(85,'God of War',0),
(86,'Sony',1),(86,'Microsoft',0),(86,'Nintendo',0),(86,'Sega',0),
(87,'Szerepjáték',1),(87,'Versenyjáték',0),(87,'Lövöldözős játék',0),(87,'Puzzle játék',0),
(88,'Gyengítést egy játékban',1),(88,'Fegyver erősítést',0),(88,'Grafika javítását',0),(88,'Játékmentés gyorsítását',0),
(89,'Túlélő lövöldözős játékmód',1),(89,'Csak kártyajáték',0),(89,'Kaland puzzle játék',0),(89,'Stratégiai társasjáték',0),
(90,'Counter-Strike 2',1),(90,'CS: Source Reloaded',0),(90,'Counter-Strike Revolution',0),(90,'Counter-Strike ZeroX',0),
(91,'Németország',1),(91,'Ausztria',0),(91,'Svájc',0),(91,'Belgium',0),
(92,'Római hadvezér és diktátor',1),(92,'Görög filozófus',0),(92,'Középkori király',0),(92,'Egyiptomi fáraó',0),
(93,'Dél-Amerika',1),(93,'Afrika',0),(93,'Európa',0),(93,'Ázsia',0),
(94,'1939–1945',1),(94,'1914–1918',0),(94,'1950–1953',0),(94,'1800–1810',0),
(95,'Yuri Gagarin',1),(95,'Neil Armstrong',0),(95,'Buzz Aldrin',0),(95,'Alan Shepard',0),
(96,'India',1),(96,'Pakisztán',0),(96,'Nepál',0),(96,'Banglades',0),
(97,'Brazília',1),(97,'Argentína',0),(97,'Peru',0),(97,'Chile',0),
(98,'Észak- és Dél-Korea',1),(98,'Japán és Korea',0),(98,'Kína és Korea',0),(98,'Mongólia és Korea',0),
(99,'Uralkodók sírhelye',1),(99,'Raktár',0),(99,'Hadsereg kiképzőhelye',0),(99,'Csillagvizsgáló',0),
(100,'Afrika',1),(100,'Dél-Amerika',0),(100,'Ázsia',0),(100,'Ausztrália',0),
(101,'Kanada',1),(101,'Egyesült Államok',0),(101,'Norvégia',0),(101,'Írország',0),
(102,'Francia katona és császár',1),(102,'Angol király',0),(102,'Olasz feltaláló',0),(102,'Spanyol admirális',0),
(103,'Peru',1),(103,'Mexikó',0),(103,'Kolumbia',0),(103,'Argentína',0),
(104,'Kambodzsa',1),(104,'Thaiföld',0),(104,'Laosz',0),(104,'Vietnám',0),
(105,'Csendes-óceán',1),(105,'Atlanti-óceán',0),(105,'Indiai-óceán',0),(105,'Jeges-tenger',0),
(106,'12',1),(106,'18',0),(106,'9',0),(106,'6',0),
(107,'1440',1),(107,'1240',0),(107,'1000',0),(107,'1560',0),
(108,'500 Ft',1),(108,'400 Ft',0),(108,'550 Ft',0),(108,'450 Ft',0),
(109,'32',1),(109,'20',0),(109,'24',0),(109,'64',0),
(110,'5 perc',1),(110,'100 perc',0),(110,'50 perc',0),(110,'10 perc',0),
(111,'0.9',1),(111,'0.89',0),(111,'0.5',0),(111,'1',0),
(112,'6',1),(112,'5',0),(112,'7',0),(112,'8',0),
(113,'8',1),(113,'6',0),(113,'5',0),(113,'9',0),
(114,'63',1),(114,'57',0),(114,'73',0),(114,'80',0),
(115,'8',1),(115,'6',0),(115,'10',0),(115,'12',0),
(116,'14',1),(116,'12',0),(116,'10',0),(116,'18',0),
(117,'I',1),(117,'H',0),(117,'J',0),(117,'K',0),
(118,'225',1),(118,'215',0),(118,'200',0),(118,'250',0),
(119,'1/2',1),(119,'0.49',0),(119,'0.4',0),(119,'0.3',0),
(120,'200',1),(120,'150',0),(120,'99',0),(120,'250',0),
(121, '6', 1), (121, '4', 0), (121, '5', 0), (121, '12', 0),
(122, 'Michael Jackson', 1), (122, 'Elvis Presley', 0), (122, 'Prince', 0), (122, 'Freddie Mercury', 0),
(123, 'Queen', 1), (123, 'The Beatles', 0), (123, 'Led Zeppelin', 0), (123, 'Pink Floyd', 0),
(124, 'Lószőr', 1), (124, 'Műanyag', 0), (124, 'Macskaszőr', 0), (124, 'Selyem', 0),
(125, 'Bartók Béla', 1), (125, 'Kodály Zoltán', 0), (125, 'Liszt Ferenc', 0), (125, 'Erkel Ferenc', 0),
(126, '88', 1), (126, '64', 0), (126, '72', 0), (126, '96', 0),
(127, 'Antonio Vivaldi', 1), (127, 'Mozart', 0), (127, 'Bach', 0), (127, 'Beethoven', 0),
(128, 'Szaxofon', 1), (128, 'Dob', 0), (128, 'Hegedű', 0), (128, 'Furulya', 0),
(129, 'USA', 1), (129, 'Anglia', 0), (129, 'Németország', 0), (129, 'Kanada', 0),
(130, '1960', 1), (130, '1955', 0), (130, '1964', 0), (130, '1970', 0),
(131, 'H2O', 1), (131, 'CO2', 0), (131, 'O2', 0), (131, 'H2SO4', 0),
(132, 'Mars', 1), (132, 'Jupiter', 0), (132, 'Vénusz', 0), (132, 'Szaturnusz', 0),
(133, '206', 1), (133, '150', 0), (133, '300', 0), (133, '256', 0),
(134, '300 000', 1), (134, '150 000', 0), (134, '1 000 000', 0), (134, '30 000', 0),
(135, 'Gepárd', 1), (135, 'Oroszlán', 0), (135, 'Strucc', 0), (135, 'Antilop', 0),
(136, 'Földrengés erőssége', 1), (136, 'Szélsebesség', 0), (136, 'Hőmérséklet', 0), (136, 'Sugárzás', 0),
(137, 'Alexander Fleming', 1), (137, 'Louis Pasteur', 0), (137, 'Marie Curie', 0), (137, 'Albert Einstein', 0),
(138, 'Oxigén', 1), (138, 'Arany', 0), (138, 'Ólom', 0), (138, 'Ozmium', 0),
(139, 'Dezoxiribonukleinsav', 1), (139, 'Ribonukleinsav', 0), (139, 'Dioxin-nitrát-sav', 0), (139, 'Dinamikus-neurális-szekvencia', 0),
(140, '3', 1), (140, '1', 0), (140, '2', 0), (140, '4', 0),
(141, '5', 1), (141, '4', 0), (141, '6', 0), (141, '7', 0),
(142, 'Labdarúgás', 1), (142, 'Vízilabda', 0), (142, 'Kézilabda', 0), (142, 'Tenisz', 0),
(143, '90 perc', 1), (143, '60 perc', 0), (143, '100 perc', 0), (143, '80 perc', 0),
(144, 'Görögország', 1), (144, 'Franciaország', 0), (144, 'Anglia', 0), (144, 'Olaszország', 0),
(145, '5', 1), (145, '6', 0), (145, '7', 0), (145, '11', 0),
(146, 'Arany', 1), (146, 'Ezüst', 0), (146, 'Bronz', 0), (146, 'Platina', 0),
(147, 'Usain Bolt', 1), (147, 'Carl Lewis', 0), (147, 'Tyson Gay', 0), (147, 'Asafa Powell', 0),
(148, 'Jégkorong', 1), (148, 'Golf', 0), (148, 'Tenisz', 0), (148, 'Baseball', 0),
(149, '12', 1), (149, '10', 0), (149, '15', 0), (149, '9', 0),
(150, 'London', 1), (150, 'Párizs', 0), (150, 'New York', 0), (150, 'Melbourne', 0),
(151, 'Olaszország', 1), (151, 'Spanyolország', 0), (151, 'Görögország', 0), (151, 'Törökország', 0),
(152, 'Avokádó', 1), (152, 'Paradicsom', 0), (152, 'Uborka', 0), (152, 'Cukkini', 0),
(153, 'Szójabab', 1), (153, 'Tej', 0), (153, 'Mandula', 0), (153, 'Rizs', 0),
(154, 'C-vitamin', 1), (154, 'D-vitamin', 0), (154, 'B12-vitamin', 0), (154, 'Kalcium', 0),
(155, 'A paprika erősségét', 1), (155, 'A cukortartalmat', 0), (155, 'Az alkohol fokát', 0), (155, 'A savasságot', 0),
(156, 'Sushi', 1), (156, 'Lasagne', 0), (156, 'Ravioli', 0), (156, 'Risotto', 0),
(157, 'Rizs', 1), (157, 'Búza', 0), (157, 'Árpa', 0), (157, 'Kukorica', 0),
(158, 'Marhahús és hagyma', 1), (158, 'Csirke és tejszín', 0), (158, 'Hal és citrom', 0), (158, 'Gomba és sajt', 0),
(159, 'Sáfrány', 1), (159, 'Vanília', 0), (159, 'Fahéj', 0), (159, 'Kardamom', 0),
(160, 'Ízletes / Húsos íz', 1), (160, 'Édes', 0), (160, 'Savanyú', 0), (160, 'Keserű', 0);
UNLOCK TABLES;

-- ============================================
-- QUIZZES (Covering All 12 Categories)
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
(3, 'Gaming – Haladó Quiz', '10 kérdés népszerű játékokról', 6, 'medium', 1, 2),
(4, 'Világjáró Kvíz', 'Utazz körbe a Földön 10 kérdéssel!', 3, 'medium', 1, 1),
(5, 'Kódolás Alapjai', 'Változók, ciklusok és IT fogalmak.', 4, 'easy', 1, 2),
(6, 'Benzingőz', 'Mindent az autókról és motorokról.', 5, 'medium', 1, 3),
(7, 'Történelemóra', 'Nagy csaták, évszámok és uralkodók.', 7, 'hard', 1, 1),
(8, 'Agytorna', 'Logikai feladványok a reggeli mellé.', 8, 'easy', 1, 4),
(9, 'Zenei Műveltség', 'Felismered a slágereket és hangszereket?', 9, 'medium', 1, 5),
(10, 'Tudományos Érdekességek', 'Kémcsövek, bolygók és az emberi test.', 10, 'medium', 1, 2),
(11, 'Sportvilág', 'Rekordok, szabályok és legendák a sport világából.', 11, 'easy', 1, 3),
(12, 'Ízek és Zamatok', 'Kulináris utazás a konyhában.', 12, 'medium', 1, 4);

-- ============================================
-- RESULTS
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
-- Film (Quiz 1) -> 1-10
(1, 1, 1), (1, 2, 2), (1, 3, 3), (1, 4, 4), (1, 5, 5),
(1, 6, 6), (1, 7, 7), (1, 8, 8), (1, 9, 9), (1, 10, 10),

-- Matek (Quiz 2) -> 16-25
(2, 16, 1), (2, 17, 2), (2, 18, 3), (2, 19, 4), (2, 20, 5),
(2, 21, 6), (2, 22, 7), (2, 23, 8), (2, 24, 9), (2, 25, 10),

-- Gaming (Quiz 3) -> 76-85
(3, 76, 1), (3, 77, 2), (3, 78, 3), (3, 79, 4), (3, 80, 5),
(3, 81, 6), (3, 82, 7), (3, 83, 8), (3, 84, 9), (3, 85, 10),

-- Kaland/Világjáró (Quiz 4) -> 31-40
(4, 31, 1), (4, 32, 2), (4, 33, 3), (4, 34, 4), (4, 35, 5),
(4, 36, 6), (4, 37, 7), (4, 38, 8), (4, 39, 9), (4, 40, 10),

-- Programozás (Quiz 5) -> 46-55
(5, 46, 1), (5, 47, 2), (5, 48, 3), (5, 49, 4), (5, 50, 5),
(5, 51, 6), (5, 52, 7), (5, 53, 8), (5, 54, 9), (5, 55, 10),

-- Autók (Quiz 6) -> 61-70
(6, 61, 1), (6, 62, 2), (6, 63, 3), (6, 64, 4), (6, 65, 5),
(6, 66, 6), (6, 67, 7), (6, 68, 8), (6, 69, 9), (6, 70, 10),

-- Történelem (Quiz 7) -> 91-100
(7, 91, 1), (7, 92, 2), (7, 93, 3), (7, 94, 4), (7, 95, 5),
(7, 96, 6), (7, 97, 7), (7, 98, 8), (7, 99, 9), (7, 100, 10),

-- Logika (Quiz 8) -> 106-115
(8, 106, 1), (8, 107, 2), (8, 108, 3), (8, 109, 4), (8, 110, 5),
(8, 111, 6), (8, 112, 7), (8, 113, 8), (8, 114, 9), (8, 115, 10),

-- Zene (Quiz 9) -> 121-130
(9, 121, 1), (9, 122, 2), (9, 123, 3), (9, 124, 4), (9, 125, 5),
(9, 126, 6), (9, 127, 7), (9, 128, 8), (9, 129, 9), (9, 130, 10),

-- Tudomány (Quiz 10) -> 131-140
(10, 131, 1), (10, 132, 2), (10, 133, 3), (10, 134, 4), (10, 135, 5),
(10, 136, 6), (10, 137, 7), (10, 138, 8), (10, 139, 9), (10, 140, 10),

-- Sport (Quiz 11) -> 141-150
(11, 141, 1), (11, 142, 2), (11, 143, 3), (11, 144, 4), (11, 145, 5),
(11, 146, 6), (11, 147, 7), (11, 148, 8), (11, 149, 9), (11, 150, 10),

-- Gasztronómia (Quiz 12) -> 151-160
(12, 151, 1), (12, 152, 2), (12, 153, 3), (12, 154, 4), (12, 155, 5),
(12, 156, 6), (12, 157, 7), (12, 158, 8), (12, 159, 9), (12, 160, 10);

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