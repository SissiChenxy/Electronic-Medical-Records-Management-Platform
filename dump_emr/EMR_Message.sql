-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: EMR
-- ------------------------------------------------------
-- Server version	5.7.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Message`
--

DROP TABLE IF EXISTS `Message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Message` (
  `messageid` int(11) NOT NULL AUTO_INCREMENT,
  `attachedfile` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `receiver` int(11) DEFAULT NULL,
  `sender` int(11) DEFAULT NULL,
  PRIMARY KEY (`messageid`),
  KEY `FKhsvs6qjojg1oumrsrn4wj5ojo` (`receiver`),
  KEY `FKfegmk2y7akf5ufrfxwtgme5lc` (`sender`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Message`
--

LOCK TABLES `Message` WRITE;
/*!40000 ALTER TABLE `Message` DISABLE KEYS */;
INSERT INTO `Message` VALUES (9,NULL,'<br>','- select a subject -',NULL,NULL),(10,NULL,'999','Prescription Question',1,2),(11,NULL,'<br>','Test Results Question',1,2),(12,'build.xml','00000','Prescription Question',1,2),(13,NULL,'<br>','- select a subject -',2,1),(14,NULL,'<br>',NULL,2,1),(15,NULL,'<br>',NULL,2,1),(16,'build.xml','777777',NULL,2,1),(17,'build.xml','55555','Test Results Question',2,1),(18,NULL,'1010101','Visit Follow-up Question',2,1),(19,NULL,'Reply test','Prescription Question',2,1),(20,'web develop - northeastern university -xinyun chen.pdf','final test of reply','Prescription Question',2,1),(21,NULL,'last test of reply','Prescription Question',2,1),(22,NULL,'adfa','Test Results Question',2,1);
/*!40000 ALTER TABLE `Message` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-22  9:52:01
