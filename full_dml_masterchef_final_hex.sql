-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assignment`
--

DROP TABLE IF EXISTS `assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignment` (
  `Episode_episode_number` int NOT NULL,
  `National_Cuisine_name` varchar(50) NOT NULL,
  `Recipies_name` varchar(50) NOT NULL,
  `Cook_name` varchar(50) NOT NULL,
  `Cook_surname` varchar(50) NOT NULL,
  PRIMARY KEY (`Episode_episode_number`,`National_Cuisine_name`,`Recipies_name`,`Cook_name`,`Cook_surname`),
  KEY `fk_Assignment_National_Cuisine1_idx` (`National_Cuisine_name`),
  KEY `fk_Assignment_Recipies1_idx` (`Recipies_name`),
  KEY `fk_Assignment_Cook1_idx` (`Cook_name`,`Cook_surname`),
  CONSTRAINT `fk_Assignment_Cook1` FOREIGN KEY (`Cook_name`, `Cook_surname`) REFERENCES `cook` (`name`, `surname`),
  CONSTRAINT `fk_Assignment_Episode1` FOREIGN KEY (`Episode_episode_number`) REFERENCES `episode` (`episode_number`),
  CONSTRAINT `fk_Assignment_National_Cuisine1` FOREIGN KEY (`National_Cuisine_name`) REFERENCES `national_cuisine` (`name`),
  CONSTRAINT `fk_Assignment_Recipies1` FOREIGN KEY (`Recipies_name`) REFERENCES `recipies` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cook`
--

DROP TABLE IF EXISTS `cook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cook` (
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `Date_of_birth` date NOT NULL,
  `years_of_experience` int NOT NULL,
  `Professional_Expertise_type` varchar(50) NOT NULL,
  `age` int DEFAULT NULL,
  `Cook_Images` blob,
  PRIMARY KEY (`name`,`surname`),
  KEY `fk_Cook_Professional_Expertise1_idx` (`Professional_Expertise_type`),
  CONSTRAINT `fk_Cook_Professional_Expertise1` FOREIGN KEY (`Professional_Expertise_type`) REFERENCES `professional_expertise` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cook_has_recipies`
--

DROP TABLE IF EXISTS `cook_has_recipies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cook_has_recipies` (
  `Cook_name` varchar(50) NOT NULL,
  `Cook_surname` varchar(50) NOT NULL,
  `Recipies_name` varchar(100) NOT NULL,
  PRIMARY KEY (`Cook_name`,`Cook_surname`,`Recipies_name`),
  KEY `fk_Cook_has_Recipies_Recipies1_idx` (`Recipies_name`),
  KEY `fk_Cook_has_Recipies_Cook1_idx` (`Cook_name`,`Cook_surname`),
  CONSTRAINT `fk_Cook_has_Recipies_Cook1` FOREIGN KEY (`Cook_name`, `Cook_surname`) REFERENCES `cook` (`name`, `surname`),
  CONSTRAINT `fk_Cook_has_Recipies_Recipies1` FOREIGN KEY (`Recipies_name`) REFERENCES `recipies` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `episode`
--

DROP TABLE IF EXISTS `episode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `episode` (
  `episode_number` int NOT NULL,
  `year` int DEFAULT NULL,
  `episode_name` int DEFAULT NULL,
  PRIMARY KEY (`episode_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `name` varchar(50) NOT NULL,
  `manual` varchar(1000) NOT NULL,
  `Equipment_Images` blob,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etiquette`
--

DROP TABLE IF EXISTS `etiquette`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etiquette` (
  `Meal_Type` varchar(50) NOT NULL,
  PRIMARY KEY (`Meal_Type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eval_for`
--

DROP TABLE IF EXISTS `eval_for`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eval_for` (
  `Assignment_National_Cuisine_name` varchar(50) NOT NULL,
  `Assignment_Recipies_name` varchar(50) NOT NULL,
  `Assignment_Cook_name` varchar(50) NOT NULL,
  `Assignment_Cook_surname` varchar(50) NOT NULL,
  `Judges_Cook_name` varchar(50) NOT NULL,
  `Judges_Cook_surname` varchar(50) NOT NULL,
  `Evaluation` varchar(45) NOT NULL,
  `Episode_episode_number` int NOT NULL,
  PRIMARY KEY (`Assignment_National_Cuisine_name`,`Assignment_Recipies_name`,`Assignment_Cook_name`,`Assignment_Cook_surname`,`Judges_Cook_name`,`Judges_Cook_surname`,`Episode_episode_number`),
  KEY `fk_Assignment_has_Judges_Judges1_idx` (`Episode_episode_number`,`Judges_Cook_name`,`Judges_Cook_surname`) /*!80000 INVISIBLE */,
  KEY `fk_Assignment_has_Judges_Assignment1_idx` (`Episode_episode_number`,`Assignment_National_Cuisine_name`,`Assignment_Recipies_name`,`Assignment_Cook_name`,`Assignment_Cook_surname`),
  CONSTRAINT `fk_Assignment_has_Judges_Assignment1` FOREIGN KEY (`Episode_episode_number`, `Assignment_National_Cuisine_name`, `Assignment_Recipies_name`, `Assignment_Cook_name`, `Assignment_Cook_surname`) REFERENCES `assignment` (`Episode_episode_number`, `National_Cuisine_name`, `Recipies_name`, `Cook_name`, `Cook_surname`),
  CONSTRAINT `fk_Assignment_has_Judges_Judges1` FOREIGN KEY (`Episode_episode_number`, `Judges_Cook_name`, `Judges_Cook_surname`) REFERENCES `judges` (`Episode_episode_number`, `Cook_name`, `Cook_surname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `food_category`
--

DROP TABLE IF EXISTS `food_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_category` (
  `name` varchar(50) NOT NULL,
  `description` varchar(200) NOT NULL,
  `Food_Category_Images` blob,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `has_specialisation`
--

DROP TABLE IF EXISTS `has_specialisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `has_specialisation` (
  `National_Cuisine_name` varchar(50) NOT NULL,
  `Cook_name` varchar(50) NOT NULL,
  `Cook_surname` varchar(50) NOT NULL,
  PRIMARY KEY (`National_Cuisine_name`,`Cook_name`,`Cook_surname`),
  KEY `fk_National_Cuisine_has_Cook_Cook1_idx` (`Cook_name`,`Cook_surname`),
  KEY `fk_National_Cuisine_has_Cook_National_Cuisine1_idx` (`National_Cuisine_name`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_National_Cuisine_has_Cook_Cook1` FOREIGN KEY (`Cook_name`, `Cook_surname`) REFERENCES `cook` (`name`, `surname`),
  CONSTRAINT `fk_National_Cuisine_has_Cook_National_Cuisine1` FOREIGN KEY (`National_Cuisine_name`) REFERENCES `national_cuisine` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredients` (
  `name` varchar(50) NOT NULL,
  `caloriesper100grams` int NOT NULL,
  `Food_Category_name` varchar(50) NOT NULL,
  `Ingredients_Images` blob,
  PRIMARY KEY (`name`),
  KEY `fk_Ingredients_Food_Category1_idx` (`Food_Category_name`),
  CONSTRAINT `fk_Ingredients_Food_Category1` FOREIGN KEY (`Food_Category_name`) REFERENCES `food_category` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `judges`
--

DROP TABLE IF EXISTS `judges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `judges` (
  `Cook_name` varchar(50) NOT NULL,
  `Cook_surname` varchar(50) NOT NULL,
  `Episode_episode_number` int NOT NULL,
  PRIMARY KEY (`Cook_name`,`Cook_surname`,`Episode_episode_number`),
  KEY `fk_Cook_has_Episode_Episode1_idx` (`Episode_episode_number`),
  KEY `fk_Cook_has_Episode_Cook1_idx` (`Cook_name`,`Cook_surname`),
  CONSTRAINT `fk_Cook_has_Episode_Cook1` FOREIGN KEY (`Cook_name`, `Cook_surname`) REFERENCES `cook` (`name`, `surname`),
  CONSTRAINT `fk_Cook_has_Episode_Episode1` FOREIGN KEY (`Episode_episode_number`) REFERENCES `episode` (`episode_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meal`
--

DROP TABLE IF EXISTS `meal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meal` (
  `Meal_Form` varchar(50) NOT NULL,
  PRIMARY KEY (`Meal_Form`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meal_has_recipies`
--

DROP TABLE IF EXISTS `meal_has_recipies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meal_has_recipies` (
  `Meal_Meal_Form` varchar(50) NOT NULL,
  `Recipies_name` varchar(50) NOT NULL,
  PRIMARY KEY (`Meal_Meal_Form`,`Recipies_name`),
  KEY `fk_Meal_has_Recipies_Recipies1_idx` (`Recipies_name`),
  KEY `fk_Meal_has_Recipies_Meal1_idx` (`Meal_Meal_Form`),
  CONSTRAINT `fk_Meal_has_Recipies_Meal1` FOREIGN KEY (`Meal_Meal_Form`) REFERENCES `meal` (`Meal_Form`),
  CONSTRAINT `fk_Meal_has_Recipies_Recipies1` FOREIGN KEY (`Recipies_name`) REFERENCES `recipies` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `national_cuisine`
--

DROP TABLE IF EXISTS `national_cuisine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `national_cuisine` (
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `professional_expertise`
--

DROP TABLE IF EXISTS `professional_expertise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professional_expertise` (
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipies`
--

DROP TABLE IF EXISTS `recipies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipies` (
  `difficulty` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `preparation_time` int NOT NULL,
  `cooking_time` int NOT NULL,
  `fat` int DEFAULT NULL,
  `protein` int DEFAULT NULL,
  `carbs` int DEFAULT NULL,
  `cooking_or_pastry` tinyint DEFAULT NULL COMMENT 'Cooking->0\nPastry->1',
  `basic_ingredient_name` varchar(50) NOT NULL,
  `National_Cuisine_name` varchar(50) NOT NULL,
  `calories` int DEFAULT NULL,
  `Recipies_Image` blob,
  PRIMARY KEY (`name`),
  KEY `fk_Recipies_Ingredients1_idx` (`basic_ingredient_name`),
  KEY `fk_Recipies_National_Cuisine1_idx` (`National_Cuisine_name`),
  CONSTRAINT `fk_Recipies_Ingredients1` FOREIGN KEY (`basic_ingredient_name`) REFERENCES `ingredients` (`name`),
  CONSTRAINT `fk_Recipies_National_Cuisine1` FOREIGN KEY (`National_Cuisine_name`) REFERENCES `national_cuisine` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipies_has_equipment`
--

DROP TABLE IF EXISTS `recipies_has_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipies_has_equipment` (
  `Recipies_name` varchar(50) NOT NULL,
  `Equipment_name` varchar(50) NOT NULL,
  PRIMARY KEY (`Recipies_name`,`Equipment_name`),
  KEY `fk_Recipies_has_Equipment_Equipment1_idx` (`Equipment_name`),
  KEY `fk_Recipies_has_Equipment_Recipies_idx` (`Recipies_name`),
  CONSTRAINT `fk_Recipies_has_Equipment_Equipment1` FOREIGN KEY (`Equipment_name`) REFERENCES `equipment` (`name`),
  CONSTRAINT `fk_Recipies_has_Equipment_Recipies` FOREIGN KEY (`Recipies_name`) REFERENCES `recipies` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipies_has_etiquette`
--

DROP TABLE IF EXISTS `recipies_has_etiquette`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipies_has_etiquette` (
  `Recipies_name` varchar(50) NOT NULL,
  `Etiquette_Meal_Type` varchar(50) NOT NULL,
  PRIMARY KEY (`Recipies_name`,`Etiquette_Meal_Type`),
  KEY `fk_Recipies_has_Etiquette_Etiquette1_idx` (`Etiquette_Meal_Type`),
  KEY `fk_Recipies_has_Etiquette_Recipies1_idx` (`Recipies_name`),
  CONSTRAINT `fk_Recipies_has_Etiquette_Etiquette1` FOREIGN KEY (`Etiquette_Meal_Type`) REFERENCES `etiquette` (`Meal_Type`),
  CONSTRAINT `fk_Recipies_has_Etiquette_Recipies1` FOREIGN KEY (`Recipies_name`) REFERENCES `recipies` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipies_has_ingredients`
--

DROP TABLE IF EXISTS `recipies_has_ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipies_has_ingredients` (
  `Recipies_name` varchar(50) NOT NULL,
  `Ingredients_name` varchar(50) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`Recipies_name`,`Ingredients_name`),
  KEY `fk_Recipies_has_Ingredients_Ingredients1_idx` (`Ingredients_name`),
  KEY `fk_Recipies_has_Ingredients_Recipies1_idx` (`Recipies_name`),
  CONSTRAINT `fk_Recipies_has_Ingredients_Ingredients1` FOREIGN KEY (`Ingredients_name`) REFERENCES `ingredients` (`name`),
  CONSTRAINT `fk_Recipies_has_Ingredients_Recipies1` FOREIGN KEY (`Recipies_name`) REFERENCES `recipies` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipies_has_steps`
--

DROP TABLE IF EXISTS `recipies_has_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipies_has_steps` (
  `Recipies_name` varchar(50) NOT NULL,
  `step_number` int NOT NULL,
  `Steps_Step_Description` varchar(500) NOT NULL,
  PRIMARY KEY (`Recipies_name`,`step_number`),
  KEY `fk_Recipies_has_Steps_Steps1_idx` (`Steps_Step_Description`) /*!80000 INVISIBLE */,
  KEY `fk_Recipies_has_Steps_Recipies1_idx` (`Recipies_name`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_Recipies_has_Steps_Recipies1` FOREIGN KEY (`Recipies_name`) REFERENCES `recipies` (`name`),
  CONSTRAINT `fk_Recipies_has_Steps_Steps1` FOREIGN KEY (`Steps_Step_Description`) REFERENCES `steps` (`Step_Description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipies_has_thematic_unit`
--

DROP TABLE IF EXISTS `recipies_has_thematic_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipies_has_thematic_unit` (
  `Recipies_name` varchar(50) NOT NULL,
  `Thematic_Unit_name` varchar(50) NOT NULL,
  PRIMARY KEY (`Recipies_name`,`Thematic_Unit_name`),
  KEY `fk_Recipies_has_Thematic Unit_Thematic Unit1_idx` (`Thematic_Unit_name`),
  KEY `fk_Recipies_has_Thematic Unit_Recipies1_idx` (`Recipies_name`),
  CONSTRAINT `fk_Recipies_has_Thematic Unit_Recipies1` FOREIGN KEY (`Recipies_name`) REFERENCES `recipies` (`name`),
  CONSTRAINT `fk_Recipies_has_Thematic Unit_Thematic Unit1` FOREIGN KEY (`Thematic_Unit_name`) REFERENCES `thematic_unit` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `steps`
--

DROP TABLE IF EXISTS `steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `steps` (
  `Step_Description` varchar(500) NOT NULL,
  PRIMARY KEY (`Step_Description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `thematic_unit`
--

DROP TABLE IF EXISTS `thematic_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thematic_unit` (
  `name` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `Thematic_Unit_Images` blob,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tips`
--

DROP TABLE IF EXISTS `tips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tips` (
  `description` varchar(200) NOT NULL,
  `Recipies_name` varchar(50) NOT NULL,
  PRIMARY KEY (`description`,`Recipies_name`),
  KEY `fk_Tips_Recipies1_idx` (`Recipies_name`),
  CONSTRAINT `fk_Tips_Recipies1` FOREIGN KEY (`Recipies_name`) REFERENCES `recipies` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-25  0:36:02
