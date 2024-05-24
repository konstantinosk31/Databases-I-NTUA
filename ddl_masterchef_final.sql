-- MySQL Script generated by MySQL Workbench
-- Fri May 24 16:58:14 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Food_Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Food_Category` (
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `Food_Category_Images` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ingredients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ingredients` (
  `name` VARCHAR(50) NOT NULL,
  `caloriesper100grams` INT NOT NULL,
  `Food_Category_name` VARCHAR(50) NOT NULL,
  `Ingredients_Images` MEDIUMBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`name`),
  INDEX `fk_Ingredients_Food_Category1_idx` (`Food_Category_name` ASC) VISIBLE,
  CONSTRAINT `fk_Ingredients_Food_Category1`
    FOREIGN KEY (`Food_Category_name`)
    REFERENCES `mydb`.`Food_Category` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`National_Cuisine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`National_Cuisine` (
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recipies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Recipies` (
  `difficulty` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `preparation_time` INT NOT NULL,
  `cooking_time` INT NOT NULL,
  `fat` INT NULL,
  `protein` INT NULL,
  `carbs` INT NULL,
  `cooking_or_pastry` TINYINT NULL COMMENT 'Cooking->0\nPastry->1',
  `basic_ingredient_name` VARCHAR(50) NOT NULL,
  `National_Cuisine_name` VARCHAR(50) NOT NULL,
  `calories` INT NULL,
  `Recipies_Image` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`name`),
  INDEX `fk_Recipies_Ingredients1_idx` (`basic_ingredient_name` ASC) VISIBLE,
  INDEX `fk_Recipies_National_Cuisine1_idx` (`National_Cuisine_name` ASC) VISIBLE,
  CONSTRAINT `fk_Recipies_Ingredients1`
    FOREIGN KEY (`basic_ingredient_name`)
    REFERENCES `mydb`.`Ingredients` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recipies_National_Cuisine1`
    FOREIGN KEY (`National_Cuisine_name`)
    REFERENCES `mydb`.`National_Cuisine` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Equipment` (
  `name` VARCHAR(50) NOT NULL,
  `manual` VARCHAR(1000) NOT NULL,
  `Equipment_Images` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recipies_has_Equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Recipies_has_Equipment` (
  `Recipies_name` VARCHAR(50) NOT NULL,
  `Equipment_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Recipies_name`, `Equipment_name`),
  INDEX `fk_Recipies_has_Equipment_Equipment1_idx` (`Equipment_name` ASC) VISIBLE,
  INDEX `fk_Recipies_has_Equipment_Recipies_idx` (`Recipies_name` ASC) VISIBLE,
  CONSTRAINT `fk_Recipies_has_Equipment_Recipies`
    FOREIGN KEY (`Recipies_name`)
    REFERENCES `mydb`.`Recipies` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recipies_has_Equipment_Equipment1`
    FOREIGN KEY (`Equipment_name`)
    REFERENCES `mydb`.`Equipment` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recipies_has_Ingredients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Recipies_has_Ingredients` (
  `Recipies_name` VARCHAR(50) NOT NULL,
  `Ingredients_name` VARCHAR(50) NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`Recipies_name`, `Ingredients_name`),
  INDEX `fk_Recipies_has_Ingredients_Ingredients1_idx` (`Ingredients_name` ASC) VISIBLE,
  INDEX `fk_Recipies_has_Ingredients_Recipies1_idx` (`Recipies_name` ASC) VISIBLE,
  CONSTRAINT `fk_Recipies_has_Ingredients_Recipies1`
    FOREIGN KEY (`Recipies_name`)
    REFERENCES `mydb`.`Recipies` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recipies_has_Ingredients_Ingredients1`
    FOREIGN KEY (`Ingredients_name`)
    REFERENCES `mydb`.`Ingredients` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Steps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Steps` (
  `Step_Description` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`Step_Description`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recipies_has_Steps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Recipies_has_Steps` (
  `Recipies_name` VARCHAR(50) NOT NULL,
  `step_number` INT NOT NULL,
  `Steps_Step_Description` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`Recipies_name`, `step_number`),
  INDEX `fk_Recipies_has_Steps_Steps1_idx` (`Steps_Step_Description` ASC) INVISIBLE,
  INDEX `fk_Recipies_has_Steps_Recipies1_idx` (`Recipies_name` ASC) INVISIBLE,
  CONSTRAINT `fk_Recipies_has_Steps_Recipies1`
    FOREIGN KEY (`Recipies_name`)
    REFERENCES `mydb`.`Recipies` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recipies_has_Steps_Steps1`
    FOREIGN KEY (`Steps_Step_Description`)
    REFERENCES `mydb`.`Steps` (`Step_Description`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Meal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Meal` (
  `Meal_Form` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Meal_Form`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Meal_has_Recipies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Meal_has_Recipies` (
  `Meal_Meal_Form` VARCHAR(50) NOT NULL,
  `Recipies_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Meal_Meal_Form`, `Recipies_name`),
  INDEX `fk_Meal_has_Recipies_Recipies1_idx` (`Recipies_name` ASC) VISIBLE,
  INDEX `fk_Meal_has_Recipies_Meal1_idx` (`Meal_Meal_Form` ASC) VISIBLE,
  CONSTRAINT `fk_Meal_has_Recipies_Meal1`
    FOREIGN KEY (`Meal_Meal_Form`)
    REFERENCES `mydb`.`Meal` (`Meal_Form`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Meal_has_Recipies_Recipies1`
    FOREIGN KEY (`Recipies_name`)
    REFERENCES `mydb`.`Recipies` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Etiquette`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Etiquette` (
  `Meal_Type` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Meal_Type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recipies_has_Etiquette`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Recipies_has_Etiquette` (
  `Recipies_name` VARCHAR(50) NOT NULL,
  `Etiquette_Meal_Type` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Recipies_name`, `Etiquette_Meal_Type`),
  INDEX `fk_Recipies_has_Etiquette_Etiquette1_idx` (`Etiquette_Meal_Type` ASC) VISIBLE,
  INDEX `fk_Recipies_has_Etiquette_Recipies1_idx` (`Recipies_name` ASC) VISIBLE,
  CONSTRAINT `fk_Recipies_has_Etiquette_Recipies1`
    FOREIGN KEY (`Recipies_name`)
    REFERENCES `mydb`.`Recipies` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recipies_has_Etiquette_Etiquette1`
    FOREIGN KEY (`Etiquette_Meal_Type`)
    REFERENCES `mydb`.`Etiquette` (`Meal_Type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Thematic_Unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Thematic_Unit` (
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(200) NULL,
  `Thematic_Unit_Images` BLOB NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recipies_has_Thematic_Unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Recipies_has_Thematic_Unit` (
  `Recipies_name` VARCHAR(50) NOT NULL,
  `Thematic_Unit_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Recipies_name`, `Thematic_Unit_name`),
  INDEX `fk_Recipies_has_Thematic Unit_Thematic Unit1_idx` (`Thematic_Unit_name` ASC) VISIBLE,
  INDEX `fk_Recipies_has_Thematic Unit_Recipies1_idx` (`Recipies_name` ASC) VISIBLE,
  CONSTRAINT `fk_Recipies_has_Thematic Unit_Recipies1`
    FOREIGN KEY (`Recipies_name`)
    REFERENCES `mydb`.`Recipies` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recipies_has_Thematic Unit_Thematic Unit1`
    FOREIGN KEY (`Thematic_Unit_name`)
    REFERENCES `mydb`.`Thematic_Unit` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Professional_Expertise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Professional_Expertise` (
  `type` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cook`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cook` (
  `name` VARCHAR(50) NOT NULL,
  `surname` VARCHAR(50) NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `Date_of_birth` DATE NOT NULL,
  `years_of_experience` INT NOT NULL,
  `Professional_Expertise_type` VARCHAR(50) NOT NULL,
  `age` INT NULL,
  `Cook_Images` BLOB NULL,
  PRIMARY KEY (`name`, `surname`),
  INDEX `fk_Cook_Professional_Expertise1_idx` (`Professional_Expertise_type` ASC) VISIBLE,
  CONSTRAINT `fk_Cook_Professional_Expertise1`
    FOREIGN KEY (`Professional_Expertise_type`)
    REFERENCES `mydb`.`Professional_Expertise` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Has_specialisation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Has_specialisation` (
  `National_Cuisine_name` VARCHAR(50) NOT NULL,
  `Cook_name` VARCHAR(50) NOT NULL,
  `Cook_surname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`National_Cuisine_name`, `Cook_name`, `Cook_surname`),
  INDEX `fk_National_Cuisine_has_Cook_Cook1_idx` (`Cook_name` ASC, `Cook_surname` ASC) VISIBLE,
  INDEX `fk_National_Cuisine_has_Cook_National_Cuisine1_idx` (`National_Cuisine_name` ASC) INVISIBLE,
  CONSTRAINT `fk_National_Cuisine_has_Cook_National_Cuisine1`
    FOREIGN KEY (`National_Cuisine_name`)
    REFERENCES `mydb`.`National_Cuisine` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_National_Cuisine_has_Cook_Cook1`
    FOREIGN KEY (`Cook_name` , `Cook_surname`)
    REFERENCES `mydb`.`Cook` (`name` , `surname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Episode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Episode` (
  `episode_number` INT NOT NULL,
  `year` INT NULL,
  `episode_name` INT NULL,
  PRIMARY KEY (`episode_number`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Judges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Judges` (
  `Cook_name` VARCHAR(50) NOT NULL,
  `Cook_surname` VARCHAR(50) NOT NULL,
  `Episode_episode_number` INT NOT NULL,
  PRIMARY KEY (`Cook_name`, `Cook_surname`, `Episode_episode_number`),
  INDEX `fk_Cook_has_Episode_Episode1_idx` (`Episode_episode_number` ASC) VISIBLE,
  INDEX `fk_Cook_has_Episode_Cook1_idx` (`Cook_name` ASC, `Cook_surname` ASC) VISIBLE,
  CONSTRAINT `fk_Cook_has_Episode_Cook1`
    FOREIGN KEY (`Cook_name` , `Cook_surname`)
    REFERENCES `mydb`.`Cook` (`name` , `surname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cook_has_Episode_Episode1`
    FOREIGN KEY (`Episode_episode_number`)
    REFERENCES `mydb`.`Episode` (`episode_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Assignment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Assignment` (
  `Episode_episode_number` INT NOT NULL,
  `National_Cuisine_name` VARCHAR(50) NOT NULL,
  `Recipies_name` VARCHAR(50) NOT NULL,
  `Cook_name` VARCHAR(50) NOT NULL,
  `Cook_surname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Episode_episode_number`, `National_Cuisine_name`, `Recipies_name`, `Cook_name`, `Cook_surname`),
  INDEX `fk_Assignment_National_Cuisine1_idx` (`National_Cuisine_name` ASC) VISIBLE,
  INDEX `fk_Assignment_Recipies1_idx` (`Recipies_name` ASC) VISIBLE,
  INDEX `fk_Assignment_Cook1_idx` (`Cook_name` ASC, `Cook_surname` ASC) VISIBLE,
  CONSTRAINT `fk_Assignment_Episode1`
    FOREIGN KEY (`Episode_episode_number`)
    REFERENCES `mydb`.`Episode` (`episode_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Assignment_National_Cuisine1`
    FOREIGN KEY (`National_Cuisine_name`)
    REFERENCES `mydb`.`National_Cuisine` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Assignment_Recipies1`
    FOREIGN KEY (`Recipies_name`)
    REFERENCES `mydb`.`Recipies` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Assignment_Cook1`
    FOREIGN KEY (`Cook_name` , `Cook_surname`)
    REFERENCES `mydb`.`Cook` (`name` , `surname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Eval_for`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Eval_for` (
  `Assignment_National_Cuisine_name` VARCHAR(50) NOT NULL,
  `Assignment_Recipies_name` VARCHAR(50) NOT NULL,
  `Assignment_Cook_name` VARCHAR(50) NOT NULL,
  `Assignment_Cook_surname` VARCHAR(50) NOT NULL,
  `Judges_Cook_name` VARCHAR(50) NOT NULL,
  `Judges_Cook_surname` VARCHAR(50) NOT NULL,
  `Evaluation` VARCHAR(45) NOT NULL,
  `Episode_episode_number` INT NOT NULL,
  PRIMARY KEY (`Assignment_National_Cuisine_name`, `Assignment_Recipies_name`, `Assignment_Cook_name`, `Assignment_Cook_surname`, `Judges_Cook_name`, `Judges_Cook_surname`, `Episode_episode_number`),
  INDEX `fk_Assignment_has_Judges_Judges1_idx` (`Episode_episode_number` ASC, `Judges_Cook_name` ASC, `Judges_Cook_surname` ASC) INVISIBLE,
  INDEX `fk_Assignment_has_Judges_Assignment1_idx` (`Episode_episode_number` ASC, `Assignment_National_Cuisine_name` ASC, `Assignment_Recipies_name` ASC, `Assignment_Cook_name` ASC, `Assignment_Cook_surname` ASC) VISIBLE,
  CONSTRAINT `fk_Assignment_has_Judges_Assignment1`
    FOREIGN KEY (`Episode_episode_number` , `Assignment_National_Cuisine_name` , `Assignment_Recipies_name` , `Assignment_Cook_name` , `Assignment_Cook_surname`)
    REFERENCES `mydb`.`Assignment` (`Episode_episode_number` , `National_Cuisine_name` , `Recipies_name` , `Cook_name` , `Cook_surname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Assignment_has_Judges_Judges1`
    FOREIGN KEY (`Episode_episode_number` , `Judges_Cook_name` , `Judges_Cook_surname`)
    REFERENCES `mydb`.`Judges` (`Episode_episode_number` , `Cook_name` , `Cook_surname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tips`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tips` (
  `description` VARCHAR(200) NOT NULL,
  `Recipies_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`description`, `Recipies_name`),
  INDEX `fk_Tips_Recipies1_idx` (`Recipies_name` ASC) VISIBLE,
  CONSTRAINT `fk_Tips_Recipies1`
    FOREIGN KEY (`Recipies_name`)
    REFERENCES `mydb`.`Recipies` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cook_has_Recipies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cook_has_Recipies` (
  `Cook_name` VARCHAR(50) NOT NULL,
  `Cook_surname` VARCHAR(50) NOT NULL,
  `Recipies_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Cook_name`, `Cook_surname`, `Recipies_name`),
  INDEX `fk_Cook_has_Recipies_Recipies1_idx` (`Recipies_name` ASC) VISIBLE,
  INDEX `fk_Cook_has_Recipies_Cook1_idx` (`Cook_name` ASC, `Cook_surname` ASC) VISIBLE,
  CONSTRAINT `fk_Cook_has_Recipies_Cook1`
    FOREIGN KEY (`Cook_name` , `Cook_surname`)
    REFERENCES `mydb`.`Cook` (`name` , `surname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cook_has_Recipies_Recipies1`
    FOREIGN KEY (`Recipies_name`)
    REFERENCES `mydb`.`Recipies` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- procedure check_valid_assignment_insert
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_valid_assignment_insert`(
    IN p_Cook_name VARCHAR(50),
    IN p_Cook_surname VARCHAR(50),
    IN p_Episode_episode_number INT,
    IN p_National_Cuisine_name VARCHAR(50),
    IN p_Recipies_name VARCHAR(50),
    OUT is_valid TINYINT
)
    READS SQL DATA
    COMMENT 'Checks if new assignment tuple is valid'
BEGIN
    DECLARE same_episode_cook INT;
    DECLARE same_episode_cuisine INT;
    DECLARE same_episode_recipe INT;
    DECLARE recipe_belongs_to_cuisine INT;
    DECLARE cook_belongs_to_cuisine INT;
    
    SET is_valid = TRUE;
    
SELECT 
    COUNT(*)
INTO same_episode_cook FROM
    assignment
WHERE
    Episode_episode_number = p_Episode_episode_number
        AND Cook_name = p_Cook_name
        AND Cook_surname = p_Cook_surname;
    
SELECT 
    COUNT(*)
INTO same_episode_cuisine FROM
    assignment
WHERE
    Episode_episode_number = p_Episode_episode_number
        AND National_Cuisine_name = p_National_Cuisine_name;
    
SELECT 
    COUNT(*)
INTO same_episode_recipe FROM
    assignment
WHERE
    Episode_episode_number = p_Episode_episode_number
        AND Recipies_name = p_Recipies_name;
    
SELECT 
    COUNT(*)
INTO recipe_belongs_to_cuisine FROM
    Recipies
WHERE
    name = p_Recipies_name
        AND National_Cuisine_name = p_National_Cuisine_name;
    
SELECT 
    COUNT(*)
INTO cook_belongs_to_cuisine FROM
    Has_specialisation
WHERE
    Cook_name = p_Cook_name
        AND Cook_surname = p_Cook_surname
        AND National_Cuisine_name = p_National_Cuisine_name;
    
    IF same_episode_cook > 0 OR same_episode_cuisine > 0  OR same_episode_recipe > 0 OR recipe_belongs_to_cuisine = 0 OR cook_belongs_to_cuisine = 0 THEN
        SET is_valid = FALSE;
    END IF;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure check_judge_not_in_3_in_a_row
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_judge_not_in_3_in_a_row`(
    IN p_Cook_name VARCHAR(50),
    IN p_Cook_surname VARCHAR(50),
    IN upcoming_episode_number INT,
    OUT is_valid TINYINT
)
BEGIN
    DECLARE episode_count INT;

    -- Initialize is_valid to 1 by default
    SET is_valid = 1;

    -- Check how many of the last two episodes the participant was in
    IF upcoming_episode_number > 2 THEN
        SELECT COUNT(*) INTO episode_count
        FROM Judges
        WHERE Cook_name = p_Cook_name
            AND Cook_surname = p_Cook_surname
            AND Episode_episode_number IN (upcoming_episode_number - 1, upcoming_episode_number - 2);

        -- Check the count of episodes
        IF episode_count >= 2 THEN
			#SELECT episode_count AS CHECK_NOT_IN_A_ROW;
            SET is_valid = 0;
        END IF;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure create_assignments
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_assignments`(
)
    MODIFIES SQL DATA
    COMMENT 'Creates new assignments'
BEGIN
    DECLARE p_Cook_name VARCHAR(50);
    DECLARE p_Cook_surname VARCHAR(50);
    DECLARE p_Episode_episode_number INT;
    DECLARE p_National_Cuisine_name VARCHAR(50);
    DECLARE p_Recipies_name VARCHAR(50);
    DECLARE Episode_Assignment_number INT;
    DECLARE is_valid TINYINT;
    DECLARE is_valid_3_in_a_row TINYINT;
    DECLARE p_offset INT;
   
    SET p_Episode_episode_number = 1;
    SET Episode_Assignment_number = 1;

    WHILE p_Episode_episode_number <= 10 DO
        -- Create a temporary table to store national cuisines
        CREATE TEMPORARY TABLE IF NOT EXISTS Temp_National_Cuisine (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(50)
        );

        TRUNCATE TABLE Temp_National_Cuisine;

        -- Insert the randomly selected national cuisines into the temporary table
        INSERT INTO Temp_National_Cuisine (name)
        SELECT name
        FROM National_Cuisine
        ORDER BY RAND()
        LIMIT 10;

        WHILE Episode_Assignment_number <= 10 DO
            -- Select from the temporary table using an offset
            SET p_offset = Episode_Assignment_number - 1;

            SELECT name INTO p_National_Cuisine_name
            FROM Temp_National_Cuisine
            LIMIT 1 OFFSET p_offset;

            SELECT Cook_name, Cook_surname INTO p_Cook_name, p_Cook_surname
            FROM Has_specialisation
            WHERE National_Cuisine_name = p_National_Cuisine_name
            ORDER BY RAND()
            LIMIT 1;

            SELECT name INTO p_Recipies_name
            FROM Recipies
            WHERE National_Cuisine_name = p_National_Cuisine_name
            ORDER BY RAND()
            LIMIT 1;

            CALL check_valid_assignment_insert(p_Cook_name, p_Cook_surname, p_Episode_episode_number, p_National_Cuisine_name, p_Recipies_name, is_valid);

            CALL check_cook_not_in_3_in_a_row(p_Cook_name, p_Cook_surname, p_Episode_episode_number, is_valid_3_in_a_row);

            IF is_valid = 1 AND is_valid_3_in_a_row = 1 THEN
                INSERT INTO Assignment (Episode_episode_number, National_Cuisine_name, Recipies_name, Cook_name, Cook_surname)
                VALUES (p_Episode_episode_number, p_National_Cuisine_name, p_Recipies_name, p_Cook_name, p_Cook_surname);

                SET Episode_Assignment_number = Episode_Assignment_number + 1;
            END IF;
        END WHILE;
        SET Episode_Assignment_number = 1;
        SET p_Episode_episode_number = p_Episode_episode_number + 1;
    END WHILE;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure create_judges
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_judges`(IN p_Episode_episode_number INT)
    MODIFIES SQL DATA
    COMMENT 'Creates new judges for a specific episode'
BEGIN
    DECLARE p_Judge_name VARCHAR(50);
    DECLARE p_Judge_surname VARCHAR(50);
    DECLARE is_valid TINYINT;
    DECLARE p_Judge_number INT;
    DECLARE done INT DEFAULT 0;
    DECLARE cur CURSOR FOR SELECT name, surname FROM judges_temp;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET p_Judge_number = 1;

    -- Create a temporary table for selected judges
    DROP TEMPORARY TABLE IF EXISTS judges_temp;
    CREATE TEMPORARY TABLE judges_temp AS
        SELECT name, surname
        FROM Cook
        ORDER BY RAND();

    -- Iterate through selected judges
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO p_Judge_name, p_Judge_surname;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Check if cook can be a judge
        CALL check_judge_not_in_3_in_a_row(p_Judge_name, p_Judge_surname, p_Episode_episode_number, is_valid);
        #SELECT concat(concat("check_cook_not_in_3_in_a_row for p_Judge_name = ", p_Judge_name), concat(", p_Judge_surname", p_Judge_surname)) AS CHECK_JUDGES;
        IF is_valid = 1 THEN
            INSERT INTO Judges(Cook_name, Cook_surname, Episode_episode_number)
            VALUES(p_Judge_name, p_Judge_surname, p_Episode_episode_number);

            SET p_Judge_number = p_Judge_number + 1;
            IF p_Judge_number > 3 THEN
                LEAVE read_loop;
            END IF;
        END IF;
    END LOOP;
    CLOSE cur;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure for_loop_judges
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `for_loop_judges`()
BEGIN
	DECLARE p_Episode_episode_number INT;
	SET p_Episode_episode_number = 1;
	WHILE p_Episode_episode_number <= 10 DO
		CALL create_judges(p_Episode_episode_number);
		SET p_Episode_episode_number = p_Episode_episode_number + 1;
	END WHILE;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure check_cook_not_in_3_in_a_row
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_cook_not_in_3_in_a_row`(
    IN p_Cook_name VARCHAR(50),
    IN p_Cook_surname VARCHAR(50),
    IN upcoming_episode_number INT,
    OUT is_valid TINYINT
)
BEGIN
    DECLARE episode_count INT;

    -- Initialize is_valid to 1 by default
    SET is_valid = 1;

    -- Check how many of the last two episodes the participant was in
    IF upcoming_episode_number > 2 THEN
        SELECT COUNT(*) INTO episode_count
        FROM Assignment
        WHERE Cook_name = p_Cook_name
            AND Cook_surname = p_Cook_surname
            AND Episode_episode_number IN (upcoming_episode_number - 1, upcoming_episode_number - 2);

        -- Check the count of episodes
        IF episode_count >= 2 THEN
			#SELECT episode_count AS CHECK_NOT_IN_A_ROW;
            SET is_valid = 0;
        END IF;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure populate_eval_for
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_eval_for`()
BEGIN
    -- Inserting data into Eval_for from Assignment joined with Judges
    INSERT INTO Eval_for (
        Assignment_National_Cuisine_name, 
        Assignment_Recipies_name, 
        Assignment_Cook_name, 
        Assignment_Cook_surname, 
        Judges_Cook_name, 
        Judges_Cook_surname, 
        evaluation,
        Episode_episode_number
    )
    SELECT 
        A.National_Cuisine_name, 
        A.Recipies_name, 
        A.Cook_name, 
        A.Cook_surname,
        J.Cook_name, 
        J.Cook_surname,
        FLOOR(1 + RAND() * 5),
        J.Episode_episode_number
    FROM 
        Assignment A
    INNER JOIN Judges J 
    ON A.Episode_episode_number = J.Episode_episode_number;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure populate_all
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `populate_all` ()
BEGIN
	call mydb.for_loop_judges();
    call mydb.create_assignments();
    call mydb.populate_eval_for();
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure check_national_cuisine_not_in_3_in_a_row
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_national_cuisine_not_in_3_in_a_row`(
    IN p_National_Cuisine_name VARCHAR(50),
    IN upcoming_episode_number INT,
    OUT is_valid TINYINT
)
BEGIN
    DECLARE episode_count INT;

    -- Initialize is_valid to 1 by default
    SET is_valid = 1;

    -- Check how many of the last two episodes the cuisine was in
    IF upcoming_episode_number > 2 THEN
        SELECT COUNT(*) INTO episode_count
        FROM Assignment
        WHERE National_Cuisine_name = p_National_Cuisine_name
            AND Episode_episode_number IN (upcoming_episode_number - 1, upcoming_episode_number - 2);

        -- Check the count of episodes
        IF episode_count >= 2 THEN
            SET is_valid = 0;
        END IF;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure check_recipe_not_in_3_in_a_row
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_recipe_not_in_3_in_a_row`(
    IN p_Recipies_name VARCHAR(50),
    IN upcoming_episode_number INT,
    OUT is_valid TINYINT
)
BEGIN
    DECLARE episode_count INT;

    -- Initialize is_valid to 1 by default
    SET is_valid = 1;

    -- Check how many of the last two episodes the recipe was in
    IF upcoming_episode_number > 2 THEN
        SELECT COUNT(*) INTO episode_count
        FROM Assignment
        WHERE Recipies_name = p_Recipies_name
            AND Episode_episode_number IN (upcoming_episode_number - 1, upcoming_episode_number - 2);

        -- Check the count of episodes
        IF episode_count >= 2 THEN
            SET is_valid = 0;
        END IF;
    END IF;
END$$

DELIMITER ;
USE `mydb`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Recipies_has_Ingredients_AFTER_INSERT` AFTER INSERT ON `Recipies_has_Ingredients` FOR EACH ROW
BEGIN
    -- Temporary variable to hold calculated calories from the new ingredient
    DECLARE newCalories INT;

    -- Calculate the calories contributed by the new ingredient
    SELECT ROUND((NEW.quantity * I.caloriesper100grams / 100)) INTO newCalories
    FROM Ingredients I
    WHERE I.name = NEW.Ingredients_name;

    -- Update the total calories in the recipes table
    UPDATE Recipies
    SET calories = COALESCE(calories, 0) + newCalories
    WHERE name = NEW.Recipies_name;
END;$$

USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Cook_BEFORE_INSERT` BEFORE INSERT ON `Cook` FOR EACH ROW
BEGIN
    SET NEW.age = TIMESTAMPDIFF(YEAR, NEW.Date_of_birth, CURDATE());
END$$

USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Episode_BEFORE_INSERT` BEFORE INSERT ON `Episode` FOR EACH ROW
BEGIN
	SET NEW.year = (NEW.episode_number - 1) DIV 10;
    SET NEW.episode_name = (NEW.episode_number - 1) MOD 10;
END$$

USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Judges_BEFORE_INSERT` BEFORE INSERT ON `Judges` FOR EACH ROW
BEGIN
	DECLARE episode_count INT;
    
    -- Count occurrences of "Episode_episode_number"
    SELECT COUNT(*) INTO episode_count 
    FROM Judges 
    WHERE Episode_episode_number = NEW.Episode_episode_number;
    
    -- Check if the count exceeds 3
    IF episode_count > 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Constraint violation: There can only be three judges per episode.';
    END IF;
END$$

USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Judges_BEFORE_DELETE` BEFORE DELETE ON `Judges` FOR EACH ROW
BEGIN
	DECLARE episode_count INT;
    
    -- Count occurrences of "Episode_episode_number"
    SELECT COUNT(*) INTO episode_count 
    FROM Judges
    WHERE Episode_episode_number = OLD.Episode_episode_number;
    
    -- Check if the count is not greater than 10
    IF episode_count <= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Constraint violation: There cannot be less than 10 assignments per episode.';
    END IF;
END$$

USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Assignment_BEFORE_INSERT` BEFORE INSERT ON `Assignment` FOR EACH ROW
BEGIN
	 DECLARE episode_count INT;
    
    -- Count occurrences of "Episode_episode_number"
    SELECT COUNT(*) INTO episode_count 
    FROM assignment
    WHERE Episode_episode_number = NEW.Episode_episode_number;
    
    -- Check if the count exceeds 3
    IF episode_count > 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Episodes are at most 10';
    END IF;
END$$

USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Assignment_BEFORE_DELETE` BEFORE DELETE ON `Assignment` FOR EACH ROW
BEGIN
	DECLARE episode_count INT;
    
    -- Count occurrences of "Episode_episode_number"
    SELECT COUNT(*) INTO episode_count 
    FROM assignment
    WHERE Episode_episode_number = OLD.Episode_episode_number;
    
    -- Check if the count is not greater than 10
    IF episode_count <= 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Constraint violation: There cannot be less than 10 assignments per episode.';
    END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
