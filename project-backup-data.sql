-- MariaDB dump 10.19  Distrib 10.4.25-MariaDB, for Linux (x86_64)
--
-- Host: classmysql.engr.oregonstate.edu    Database: cs340_zhangra
-- ------------------------------------------------------
-- Server version	10.6.8-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

--
-- Table structure for table `BundleItems`
--

DROP TABLE IF EXISTS `BundleItems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BundleItems` (
  `bundle_items_id` int(11) NOT NULL AUTO_INCREMENT,
  `bundle_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  PRIMARY KEY (`bundle_items_id`,`bundle_id`,`item_id`),
  UNIQUE KEY `bundle_items_id_UNIQUE` (`bundle_items_id`),
  KEY `fk_Bundles_has_Items_Items1_idx` (`item_id`),
  KEY `fk_Bundles_has_Items_Bundles1` (`bundle_id`),
  CONSTRAINT `fk_Bundles_has_Items_Bundles1` FOREIGN KEY (`bundle_id`) REFERENCES `Bundles` (`bundle_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Bundles_has_Items_Items1` FOREIGN KEY (`item_id`) REFERENCES `Items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BundleItems`
--

LOCK TABLES `BundleItems` WRITE;
/*!40000 ALTER TABLE `BundleItems` DISABLE KEYS */;
INSERT INTO `BundleItems` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4);
/*!40000 ALTER TABLE `BundleItems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bundles`
--

DROP TABLE IF EXISTS `Bundles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bundles` (
  `bundle_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`bundle_id`),
  UNIQUE KEY `bundle_id_UNIQUE` (`bundle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bundles`
--

LOCK TABLES `Bundles` WRITE;
/*!40000 ALTER TABLE `Bundles` DISABLE KEYS */;
INSERT INTO `Bundles` VALUES (1,'Spring Foraging Bundle','One of six bundles in the Craft Room. '),(2,'Summer Foraging Bundle','One of six bundles in the Craft Room. '),(3,'Fall Foraging Bundle','One of six bundles in the Craft Room. '),(4,'Winter Foraging Bundle','One of six bundles in the Craft Room. ');
/*!40000 ALTER TABLE `Bundles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CharacterItems`
--

DROP TABLE IF EXISTS `CharacterItems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CharacterItems` (
  `character_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `character_items_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`character_items_id`,`character_id`,`item_id`),
  UNIQUE KEY `character_items_id_UNIQUE` (`character_items_id`),
  KEY `fk_Characters_has_Items_Characters1_idx` (`character_id`),
  KEY `fk_Characters_has_Items_Items1_idx` (`item_id`),
  CONSTRAINT `fk_Characters_has_Items_Characters1` FOREIGN KEY (`character_id`) REFERENCES `NonPlayableCharacters` (`character_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Characters_has_Items_Items1` FOREIGN KEY (`item_id`) REFERENCES `Items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CharacterItems`
--

LOCK TABLES `CharacterItems` WRITE;
/*!40000 ALTER TABLE `CharacterItems` DISABLE KEYS */;
INSERT INTO `CharacterItems` VALUES (1,1,1),(2,2,2),(3,3,3);
/*!40000 ALTER TABLE `CharacterItems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Items`
--

DROP TABLE IF EXISTS `Items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `seasons` varchar(45) DEFAULT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Items`
--

LOCK TABLES `Items` WRITE;
/*!40000 ALTER TABLE `Items` DISABLE KEYS */;
INSERT INTO `Items` VALUES (1,'Wild Horseradish','Spring','A spicy root found in the spring. '),(2,'Grape','Summer, Fall','A sweet cluster of fruit. '),(3,'Common Mushroom','Fall','Slightly nutty, with a good texture. '),(4,'Crystal Fruit','Winter','A delicate fruit that pops up from the snow. '),(5,'Kale Seeds','Spring','Plant these in the spring. Take 6 days to mature. Harvest with a Scythe.'),(6,'Wheat Seeds','Summer, Fall','Plant these in the summer or fall. Take 4 days to mature. Harvest with a Scythe.'),(7,'Blueberry Seeds','Summer','Plant these in the summer. Takes 13 days to mature, and continues to produce after first harvest.');
/*!40000 ALTER TABLE `Items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NonPlayableCharacters`
--

DROP TABLE IF EXISTS `NonPlayableCharacters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NonPlayableCharacters` (
  `character_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `occupation` varchar(45) DEFAULT NULL,
  `birthday` varchar(45) NOT NULL,
  `is_romanceable` tinyint(4) NOT NULL,
  `region_id` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`character_id`,`region_id`),
  UNIQUE KEY `idtable1_UNIQUE` (`character_id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `fk_Characters_Regions_idx` (`region_id`),
  CONSTRAINT `fk_Characters_Regions` FOREIGN KEY (`region_id`) REFERENCES `Regions` (`region_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NonPlayableCharacters`
--

LOCK TABLES `NonPlayableCharacters` WRITE;
/*!40000 ALTER TABLE `NonPlayableCharacters` DISABLE KEYS */;
INSERT INTO `NonPlayableCharacters` VALUES (1,'Krobus','Krobus\' Shopkeeper','Winter 1',0,1,'Krobus is the only friendly monster that players encounter. He can become a roommate. '),(2,'Vincent',NULL,'Spring 10',0,2,'The youngest son of Jodi and Kent, brother to Sam. Is best friends with Jas. '),(3,'Pierre','General Store Shopkeeper','Spring 26',0,2,'Runs the General Store in town. Is married to Caroline, and the father of Abigail. '),(4,'Willy','Fisherman','Summer 24',0,3,'Willy runs the Fish Shop and spends most of his time fishing.');
/*!40000 ALTER TABLE `NonPlayableCharacters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Regions`
--

DROP TABLE IF EXISTS `Regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Regions` (
  `region_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`region_id`),
  UNIQUE KEY `region_id_UNIQUE` (`region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Regions`
--

LOCK TABLES `Regions` WRITE;
/*!40000 ALTER TABLE `Regions` DISABLE KEYS */;
INSERT INTO `Regions` VALUES (1,'The Sewers','A location unlocked by obtaining the Rusty Key after donating 60 items. Home to Krobus and Krobus\'s '),(2,'Pelican Town','The main playable area of the game, where the majority of the characters live, most shops are, and t'),(3,'The Beach','The beach is an area south of Pelican Town and is valuable for fishing.');
/*!40000 ALTER TABLE `Regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ShopItems`
--

DROP TABLE IF EXISTS `ShopItems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ShopItems` (
  `shop_items_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  PRIMARY KEY (`shop_items_id`,`item_id`,`shop_id`),
  UNIQUE KEY `shop_items_id_UNIQUE` (`shop_items_id`),
  KEY `fk_Items_has_Shops_Shops1_idx` (`shop_id`),
  KEY `fk_Items_has_Shops_Items1_idx` (`item_id`),
  CONSTRAINT `fk_Items_has_Shops_Items1` FOREIGN KEY (`item_id`) REFERENCES `Items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Items_has_Shops_Shops1` FOREIGN KEY (`shop_id`) REFERENCES `Shops` (`shop_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ShopItems`
--

LOCK TABLES `ShopItems` WRITE;
/*!40000 ALTER TABLE `ShopItems` DISABLE KEYS */;
INSERT INTO `ShopItems` VALUES (1,1,5),(2,1,6),(3,1,7);
/*!40000 ALTER TABLE `ShopItems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Shops`
--

DROP TABLE IF EXISTS `Shops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Shops` (
  `shop_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `operating_hours` varchar(45) NOT NULL,
  `shop_character_id` int(11) NOT NULL,
  `region_id` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`shop_id`,`shop_character_id`,`region_id`),
  UNIQUE KEY `shop_id_UNIQUE` (`shop_id`),
  KEY `fk_Shops_Characters1_idx` (`shop_character_id`),
  KEY `fk_Shops_Regions1_idx` (`region_id`),
  CONSTRAINT `fk_Shops_Characters1` FOREIGN KEY (`shop_character_id`) REFERENCES `NonPlayableCharacters` (`character_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_Shops_Regions1` FOREIGN KEY (`region_id`) REFERENCES `Regions` (`region_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Shops`
--

LOCK TABLES `Shops` WRITE;
/*!40000 ALTER TABLE `Shops` DISABLE KEYS */;
INSERT INTO `Shops` VALUES (1,'Pierre\'s General Store','9am to 5pm',3,2,'The store sells various seeds, saplings, and fertilizer. It is home to Pierre, Caroline, and Abigail'),(2,'Fish Shop','9am to 5pm',4,3,'The fish shop sells various fishing equipment. It is home to Willy.'),(3,'Krobus\' Shop','12am to 12am',1,1,'Sells various rare items as well as rotating stock.');
/*!40000 ALTER TABLE `Shops` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-09 19:00:44

SET FOREIGN_KEY_CHECKS=1;
COMMIT;