-- MySQL dump 10.13  Distrib 8.0.35, for macos13 (arm64)
--
-- Host: localhost    Database: local
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `body`
--

DROP TABLE IF EXISTS `body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `body` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `measurement_type` varchar(64) NOT NULL,
  `instruction` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `body`
--

LOCK TABLES `body` WRITE;
/*!40000 ALTER TABLE `body` DISABLE KEYS */;
INSERT INTO `body` VALUES (1,'Chest','Circumference','Measure around the widest part of your chest, or bust for women, usually just above the nipples.');
INSERT INTO `body` VALUES (2,'Waist','Circumference','Find the narrowest part of your torso, often around the belly button.');
INSERT INTO `body` VALUES (3,'Hips','Circumference','Measure the widest point of your hips or glutes.');
INSERT INTO `body` VALUES (4,'Glutes','Circumference','Measure at the widest part of your thigh, often the midpoint between the lower glute and the back of the knee.');
INSERT INTO `body` VALUES (5,'Calves','Circumference','Measure the widest part of your calf, located at the halfway point between your knee and ankle.');
INSERT INTO `body` VALUES (6,'Biceps','Circumference','Measure the bicep at the halfway point between the shoulder and the elbow, with your arm relaxed at your side.');
INSERT INTO `body` VALUES (7,'Forearms','Circumference','');
INSERT INTO `body` VALUES (8,'Body Mass','Weight','');
INSERT INTO `body` VALUES (9,'Body Fat Mass','Weight','');
INSERT INTO `body` VALUES (10,'Body Fat %','Percentage','');
INSERT INTO `body` VALUES (11,'FFM','Weight','');
INSERT INTO `body` VALUES (12,'Muscle Mass','Weight','');
INSERT INTO `body` VALUES (13,'TBW Mass','Weight','');
INSERT INTO `body` VALUES (14,'TBW %','Percentage','');
INSERT INTO `body` VALUES (15,'Bone Mass','Weight','');
INSERT INTO `body` VALUES (16,'Height','Height','');
/*!40000 ALTER TABLE `body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diary`
--

DROP TABLE IF EXISTS `diary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `diary` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diary`
--

LOCK TABLES `diary` WRITE;
/*!40000 ALTER TABLE `diary` DISABLE KEYS */;
/*!40000 ALTER TABLE `diary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `effort`
--

DROP TABLE IF EXISTS `effort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `effort` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `description` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `effort`
--

LOCK TABLES `effort` WRITE;
/*!40000 ALTER TABLE `effort` DISABLE KEYS */;
INSERT INTO `effort` VALUES (1,'Easy - 1','');
INSERT INTO `effort` VALUES (2,'Easy - 2','');
INSERT INTO `effort` VALUES (3,'Easy - 3','');
INSERT INTO `effort` VALUES (4,'Moderate - 1','');
INSERT INTO `effort` VALUES (5,'Moderate - 2','');
INSERT INTO `effort` VALUES (6,'Moderate - 3','');
INSERT INTO `effort` VALUES (7,'Hard - 1','');
INSERT INTO `effort` VALUES (8,'Hard - 2','');
INSERT INTO `effort` VALUES (9,'All Out - 1','');
INSERT INTO `effort` VALUES (10,'All Out - 2','');
/*!40000 ALTER TABLE `effort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise`
--

DROP TABLE IF EXISTS `exercise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise` (
  `id` int NOT NULL AUTO_INCREMENT,
  `muscle_group` int NOT NULL,
  `exercise` varchar(128) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `video` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `muscle_group` (`muscle_group`),
  CONSTRAINT `exercise_ibfk_1` FOREIGN KEY (`muscle_group`) REFERENCES `muscle_groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise`
--

LOCK TABLES `exercise` WRITE;
/*!40000 ALTER TABLE `exercise` DISABLE KEYS */;
INSERT INTO `exercise` VALUES (1,1,'Smith machine hip thrust',NULL,NULL);
INSERT INTO `exercise` VALUES (2,1,'Smith machine hip thrust',NULL,NULL);
INSERT INTO `exercise` VALUES (3,1,'Barbell hip thrust',NULL,NULL);
INSERT INTO `exercise` VALUES (4,1,'Dumbbell romanian deadlift',NULL,NULL);
INSERT INTO `exercise` VALUES (5,1,'Barbell romanian deadlift',NULL,NULL);
INSERT INTO `exercise` VALUES (6,1,'Dumbbell goblet squat',NULL,NULL);
INSERT INTO `exercise` VALUES (7,1,'Kettlebell goblet squat',NULL,NULL);
INSERT INTO `exercise` VALUES (8,2,'Cable seated row (High)',NULL,NULL);
INSERT INTO `exercise` VALUES (9,2,'Cable seated row (Mid)',NULL,NULL);
INSERT INTO `exercise` VALUES (10,2,'Cable seated row (Low)',NULL,NULL);
INSERT INTO `exercise` VALUES (11,2,'Bent-over barbell row',NULL,NULL);
INSERT INTO `exercise` VALUES (12,2,'Pull-ups',NULL,NULL);
INSERT INTO `exercise` VALUES (13,2,'Muscle-ups',NULL,NULL);
INSERT INTO `exercise` VALUES (14,2,'Cable pull-down',NULL,NULL);
INSERT INTO `exercise` VALUES (15,2,'Cable pull-up',NULL,NULL);
INSERT INTO `exercise` VALUES (16,2,'Partial deadlift',NULL,NULL);
INSERT INTO `exercise` VALUES (17,3,'Push-ups',NULL,NULL);
INSERT INTO `exercise` VALUES (18,3,'Dips',NULL,NULL);
INSERT INTO `exercise` VALUES (19,3,'Barbell bench press (Flat)',NULL,NULL);
INSERT INTO `exercise` VALUES (20,3,'Barbell bench press (Incline)',NULL,NULL);
INSERT INTO `exercise` VALUES (21,3,'Smith machine bench press (Flat)',NULL,NULL);
INSERT INTO `exercise` VALUES (22,3,'Smith machine bench press (Incline)',NULL,NULL);
INSERT INTO `exercise` VALUES (23,3,'Dumbbell bench press (Flat)',NULL,NULL);
INSERT INTO `exercise` VALUES (24,3,'Dumbbell bench press (Incline)',NULL,NULL);
INSERT INTO `exercise` VALUES (25,3,'Cable fly (Chest)',NULL,NULL);
INSERT INTO `exercise` VALUES (26,3,'Cable fly (Front deltoid)',NULL,NULL);
INSERT INTO `exercise` VALUES (27,3,'Cable fly (Rear deltoid)',NULL,NULL);
INSERT INTO `exercise` VALUES (28,3,'Dumbbell fly (Flat)',NULL,NULL);
INSERT INTO `exercise` VALUES (29,4,'Dumbbell shoulder press',NULL,NULL);
INSERT INTO `exercise` VALUES (30,4,'Dumbbell lateral raise',NULL,NULL);
INSERT INTO `exercise` VALUES (31,4,'Dumbbell lateral raise (full rom)',NULL,NULL);
INSERT INTO `exercise` VALUES (32,5,'Box squat',NULL,NULL);
INSERT INTO `exercise` VALUES (33,5,'Barbell back squat',NULL,NULL);
INSERT INTO `exercise` VALUES (34,5,'Smith machine back squat',NULL,NULL);
INSERT INTO `exercise` VALUES (35,5,'Barbell front squat',NULL,NULL);
INSERT INTO `exercise` VALUES (36,5,'Smith machine front squat',NULL,NULL);
INSERT INTO `exercise` VALUES (37,5,'Hack squat',NULL,NULL);
INSERT INTO `exercise` VALUES (38,5,'Bulgarian squat',NULL,NULL);
INSERT INTO `exercise` VALUES (39,5,'Leg press',NULL,NULL);
INSERT INTO `exercise` VALUES (40,6,'Deadlift',NULL,NULL);
INSERT INTO `exercise` VALUES (41,6,'Ham-raise',NULL,NULL);
INSERT INTO `exercise` VALUES (42,6,'Leg curl',NULL,NULL);
INSERT INTO `exercise` VALUES (43,7,'Calf raise',NULL,NULL);
INSERT INTO `exercise` VALUES (44,8,'Reverse-grip barbell bench press',NULL,NULL);
INSERT INTO `exercise` VALUES (45,8,'Dumbbell overhead tricep extension',NULL,NULL);
INSERT INTO `exercise` VALUES (46,8,'Cable overhead tricep extension',NULL,NULL);
INSERT INTO `exercise` VALUES (47,8,'Skull crusher',NULL,NULL);
INSERT INTO `exercise` VALUES (48,9,'Barbell curl',NULL,NULL);
INSERT INTO `exercise` VALUES (49,9,'EZ bar curl',NULL,NULL);
INSERT INTO `exercise` VALUES (50,9,'Dumbbell curl (easy)',NULL,NULL);
INSERT INTO `exercise` VALUES (51,9,'Dumbbell curl (strict)',NULL,NULL);
INSERT INTO `exercise` VALUES (52,9,'Dumbbell curl (hammer)',NULL,NULL);
INSERT INTO `exercise` VALUES (53,9,'Preacher curl',NULL,NULL);
INSERT INTO `exercise` VALUES (54,10,'Plank',NULL,NULL);
INSERT INTO `exercise` VALUES (55,10,'Russian twist',NULL,NULL);
INSERT INTO `exercise` VALUES (56,10,'Pallof press',NULL,NULL);
INSERT INTO `exercise` VALUES (57,10,'Cable crunch',NULL,NULL);
INSERT INTO `exercise` VALUES (58,11,'Wrist curl',NULL,NULL);
INSERT INTO `exercise` VALUES (59,11,'Farmers walk',NULL,NULL);
INSERT INTO `exercise` VALUES (60,2,'Dumbell 3 point row',NULL,NULL);
INSERT INTO `exercise` VALUES (61,2,'Cable Lateral Raise',NULL,NULL);
/*!40000 ALTER TABLE `exercise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `location` point DEFAULT NULL,
  `exercise` int NOT NULL,
  `weight` float DEFAULT NULL,
  `tension_level` int DEFAULT NULL,
  `reps` int DEFAULT NULL,
  `sets` int DEFAULT NULL,
  `time` time DEFAULT NULL,
  `distance` float DEFAULT NULL,
  `effort` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exercise` (`exercise`),
  CONSTRAINT `log_ibfk_1` FOREIGN KEY (`exercise`) REFERENCES `exercise` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (9,'2025-10-04 17:56:58',NULL,14,20,NULL,12,4,NULL,NULL,3);
INSERT INTO `log` VALUES (10,'2025-10-04 17:57:16',NULL,14,35,NULL,12,1,NULL,NULL,5);
INSERT INTO `log` VALUES (11,'2025-10-04 17:58:03',NULL,29,10,NULL,10,1,NULL,NULL,2);
INSERT INTO `log` VALUES (12,'2025-10-04 17:58:15',NULL,14,10,NULL,10,1,NULL,NULL,2);
INSERT INTO `log` VALUES (13,'2025-10-04 17:58:39',NULL,14,5,NULL,10,2,NULL,NULL,5);
INSERT INTO `log` VALUES (14,'2025-10-04 18:01:35',NULL,61,2.5,NULL,10,1,NULL,NULL,5);
INSERT INTO `log` VALUES (15,'2025-10-04 18:02:39',NULL,61,5,NULL,5,1,NULL,NULL,5);
INSERT INTO `log` VALUES (16,'2025-10-04 18:02:58',NULL,61,7.5,NULL,5,1,NULL,NULL,5);
INSERT INTO `log` VALUES (17,'2025-10-04 18:04:27',NULL,24,15,NULL,8,1,NULL,NULL,5);
INSERT INTO `log` VALUES (18,'2025-10-04 18:06:30',NULL,61,15,NULL,6,2,NULL,NULL,7);
INSERT INTO `log` VALUES (19,'2025-10-04 18:13:19',NULL,9,20,NULL,15,1,NULL,NULL,2);
INSERT INTO `log` VALUES (20,'2025-10-04 18:13:46',NULL,9,27.5,NULL,15,1,NULL,NULL,3);
INSERT INTO `log` VALUES (21,'2025-10-05 18:15:45',NULL,9,35,NULL,15,1,NULL,NULL,5);
INSERT INTO `log` VALUES (22,'2025-10-06 18:16:14',NULL,9,42.5,NULL,7,1,NULL,NULL,7);
INSERT INTO `log` VALUES (23,'2025-10-07 18:16:34',NULL,9,42.5,NULL,4,1,NULL,NULL,8);
INSERT INTO `log` VALUES (24,'2025-10-08 18:18:53',NULL,30,5,NULL,10,1,NULL,NULL,5);
INSERT INTO `log` VALUES (25,'2025-10-09 18:19:20',NULL,30,7,NULL,10,1,NULL,NULL,7);
INSERT INTO `log` VALUES (26,'2025-10-10 18:19:33',NULL,30,7,NULL,5,1,NULL,NULL,8);
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `measurements`
--

DROP TABLE IF EXISTS `measurements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `measurements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `body_part` int NOT NULL,
  `measurement` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `body_part` (`body_part`),
  CONSTRAINT `measurements_ibfk_1` FOREIGN KEY (`body_part`) REFERENCES `body` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurements`
--

LOCK TABLES `measurements` WRITE;
/*!40000 ALTER TABLE `measurements` DISABLE KEYS */;
INSERT INTO `measurements` VALUES (1,'2025-10-05 20:48:52',16,177);
INSERT INTO `measurements` VALUES (2,'2025-10-05 20:48:56',1,177);
INSERT INTO `measurements` VALUES (3,'2025-10-05 20:49:01',1,177);
/*!40000 ALTER TABLE `measurements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `muscle_groups`
--

DROP TABLE IF EXISTS `muscle_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muscle_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `order` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `muscle_groups`
--

LOCK TABLES `muscle_groups` WRITE;
/*!40000 ALTER TABLE `muscle_groups` DISABLE KEYS */;
INSERT INTO `muscle_groups` VALUES (1,'Glutes',8);
INSERT INTO `muscle_groups` VALUES (2,'Back',1);
INSERT INTO `muscle_groups` VALUES (3,'Chest',2);
INSERT INTO `muscle_groups` VALUES (4,'Shoulders',3);
INSERT INTO `muscle_groups` VALUES (5,'Quadriceps',9);
INSERT INTO `muscle_groups` VALUES (6,'Hamstrings',10);
INSERT INTO `muscle_groups` VALUES (7,'Calves',11);
INSERT INTO `muscle_groups` VALUES (8,'Triceps',5);
INSERT INTO `muscle_groups` VALUES (9,'Biceps',4);
INSERT INTO `muscle_groups` VALUES (10,'Abs',7);
INSERT INTO `muscle_groups` VALUES (11,'Grip and Forearms',6);
/*!40000 ALTER TABLE `muscle_groups` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-18 17:41:58
