-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: localhost    Database: aleksi
-- ------------------------------------------------------
-- Server version	5.7.14-log

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


-- database creation with name `shoeshop`
create database if not exists shoeshop;
use shoeshop;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `customerId` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `addressline1` varchar(255) NOT NULL,
  `addressline2` varchar(255) DEFAULT NULL,
  `postalcode` varchar(6) NOT NULL,
  `mobile` varchar(8) NOT NULL,
  `password` varchar(128) NOT NULL,
  PRIMARY KEY (`customerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `shoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shoes` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT,
  `itemDescription` varchar(512) NOT NULL,	/* Chuck 70 - Hi - Black */
  `brand` varchar(128) NOT NULL,			/* eg. Converse */
  `sex` varchar(128) NOT NULL,				/* unisex/women/men */
  `category` varchar(128) NOT NULL,			/* eg. lifestyle/running/sports/slides */
  `price` decimal(6,2) NOT NULL,			/* eg. 79.90 */
  `points` int(6) NOT NULL,					/* eg. 35  [5 points for every 10 dollars??]*/
  `imageFile` varchar(128) NOT NULL, 		/* eg. converseChuck70Black.jpg */
  `stock` int(6) NOT NULL,					/* eg. 10 */
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `shoes` WRITE;
/*!40000 ALTER TABLE `shoes` DISABLE KEYS */;
INSERT INTO `shoes` (`itemDescription`, `brand`, `sex`, `category`,`price`,`points`,`imageFile`,`stock`) VALUES ('Stan Smith Shoes - Original - Blue','Adidas','unisex','lifestyle',150.00,75,'stanSmithShoesOriginalBlue.jpg',25),
						   ('Stan Smith Shoes - Original - Cloud White','Adidas','unisex','lifestyle',150.00,75,'stanSmithShoesOriginalCloudWhite.jpg',5),
                           ('Stan Smith Shoes - Original - Green','Adidas','unisex','lifestyle',150.00,75,'stanSmithShoesOriginalGreen.jpg',10),
                           ('Yeezy Slides - Black','Adidas','unisex','slides',120.00,60,'yeezySlidesBlack.jpeg',7),
                           ('Yeezy Slides - Pure','Adidas','unisex','slides',120.00,60,'yeezySlidesPure.jpeg',5),
                           ('Ultraboost 22 Shoes - Black','Adidas','men','running',260.00,130,'ultraboost22ShoesBlack.jpg',15),
                           ('Ultraboost 22 Shoes - Magic Grey','Adidas','men','running',260.00,130,'ultraboost22ShoesMagicGrey.jpg',10),
                           ('Ultraboost 22 Shoes - Wonder Mauve','Adidas','women','running',260.00,130,'ultraboost22ShoesWonderMauve.jpg',15),
                           ('Ultraboost 22 Shoes - Turbo','Adidas','women','running',260.00,130,'ultraboost22ShoesTurbo.jpg',7),	
                           ('Chuck 70 - Hi - Black','Converse','unisex','lifestyle',129.90,64,'chuck70HiBlack.jpeg',20),
                           ('Chuck 70 - Hi - Parchment','Converse','unisex','lifestyle',129.90,64,'chuck70HiParchment.jpeg',12),
                           ('Chuck 70 - Hi - Embroidered Floral','Converse','female','lifestyle',95.00,47,'chuck70HiEmbroideredFloral.jpeg',5),
                           ('Chuck Taylor All Star - Ox - Charcoal','Converse','unisex','lifestyle',75.90,37,'chuckTaylorAllStarOxCharcoal.jpeg',9),
                           ('Chuck Taylor All Star - Ox - Maroon','Converse','unisex','lifestyle',75.90,37,'chuckTaylorAllStarOxMaroon.jpeg',9),
                           ('Jordan Zoom Separate PF - Black','Nike','men','sports',179.00,89,'jordanZoomSeparatePFBlack.jpg',11),
                           ('Nike Air Zoom SuperRep 3 - Black','Nike','men','sports',199.00,99,'nikeAirZoomSuperRep3Black.jpg',14),
                           ('Kyrie Infinity EP - Multi-Color','Nike','women','sports',219.00,109,'kyrieInfinityEPMultiColor.jpg',10),
                           ('Nike Free Metcon 4 - Rose','Nike','women','sports',199.00,99,'nikeFreeMetcon4Rose.jpg',12),
                           ('Mexico 66 SD - Cream','Onitsuka Tiger','unisex','lifestyle',199.00,99,'mexico66SDCream.jpeg',15),
                           ('Dentigre LS - Birch','Onitsuka Tiger','unisex','sports',229.00,114,'dentigreLSBirch.jpeg',17),
                           ('Mercedes F1 R-Cat Machina Shoes - White','Puma','unisex','sports',79.00,114,'mercedesF1R-CatMachinaShoesWhite.jpg',20),
                           ('Popcat 20 Sandals - Black','Puma','men','slides',39.00,19,'popcat20SandalsBlack.jpeg',10),
                           ('Popcat 20 Sandals - White','Puma','women','slides',39.00,19,'popcat20SandalsWhite.jpeg',10),
                           ('200 - Blue','New Balance','unisex','slides',49.00,24,'200Blue.jpg',15),
                           ('Vision Racer - Kumquat','New Balance','unisex','running',209.00,104,'visionRacerKumquat.jpg',25);
/*!40000 ALTER TABLE `shoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderdetails` (
  `orderid` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `quantity` int(3) NOT NULL,
  `size` varchar(128) NOT NULL,		/* eg. Women 8 */
  PRIMARY KEY (`orderid`,`itemid`),
  KEY `ItemId_idx` (`itemid`),
  CONSTRAINT `ItemId` FOREIGN KEY (`itemid`) REFERENCES `item` (`itemId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `OrderId` FOREIGN KEY (`orderid`) REFERENCES `orders` (`orderid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `orderid` int(11) NOT NULL AUTO_INCREMENT,
  `customerid` int(11) NOT NULL,
  `orderprice` decimal(8,2) NOT NULL,
  `orderpoints` int(6) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`orderid`),
  KEY `CustomerId_idx` (`customerid`),
  CONSTRAINT `CustomerId` FOREIGN KEY (`customerid`) REFERENCES `customer` (`customerId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-01 11:37:30
