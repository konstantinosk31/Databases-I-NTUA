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
    DECLARE is_valid_recipies TINYINT;
    DECLARE is_valid_national_cuisine TINYINT;
   
    SET p_Episode_episode_number = 1;
    SET Episode_Assignment_number = 1;

    WHILE p_Episode_episode_number <= 100 DO
		
        SET Episode_Assignment_number = 1;
        WHILE Episode_Assignment_number <= 10 DO
        
            SELECT name INTO p_National_Cuisine_name
            FROM National_Cuisine
            WHERE name NOT IN (
				SELECT National_Cuisine_name FROM Assignment
                WHERE Episode_episode_number = p_Episode_episode_number
            )
            ORDER BY RAND()
            LIMIT 1;

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
			
			#SELECT p_Cook_name, p_Cook_surname, p_Episode_episode_number, p_National_Cuisine_name, p_Recipies_name;
            
            CALL check_valid_assignment_insert(p_Cook_name, p_Cook_surname, p_Episode_episode_number, p_National_Cuisine_name, p_Recipies_name, is_valid);

            CALL check_cook_not_in_3_in_a_row(p_Cook_name, p_Cook_surname, p_Episode_episode_number, is_valid_3_in_a_row);
            
            CALL check_recipe_not_in_3_in_a_row(p_Recipies_name, p_Episode_episode_number, is_valid_recipies);
            
            CALL check_national_cuisine_not_in_3_in_a_row(p_National_Cuisine_name, p_Episode_episode_number, is_valid_national_cuisine);

			#SELECT is_valid, is_valid_3_in_a_row AS DEBUG;

            IF is_valid = 1 AND is_valid_3_in_a_row = 1 AND is_valid_national_cuisine = 1 AND is_valid_recipies = 1 THEN
                INSERT INTO Assignment (Episode_episode_number, National_Cuisine_name, Recipies_name, Cook_name, Cook_surname)
                VALUES (p_Episode_episode_number, p_National_Cuisine_name, p_Recipies_name, p_Cook_name, p_Cook_surname);

                SET Episode_Assignment_number = Episode_Assignment_number + 1;
            END IF;
            /*IF is_valid = 0 THEN
				SELECT concat("invalid assignment:"), p_Episode_episode_number, p_National_Cuisine_name, p_Recipies_name, p_Cook_name, p_Cook_surname;
			END IF;
            IF is_valid_3_in_a_row = 0 THEN
				SELECT concat("3 cooks in a row:"), p_Episode_episode_number, p_National_Cuisine_name, p_Recipies_name, p_Cook_name, p_Cook_surname;
			END IF;
            IF is_valid_national_cuisine = 0 THEN
				SELECT concat("3 cuisines in a row:"), p_Episode_episode_number, p_National_Cuisine_name, p_Recipies_name, p_Cook_name, p_Cook_surname;
            END IF;
            IF is_valid_recipies = 0 THEN
				SELECT concat("3 recipies in a row:"), p_Episode_episode_number, p_National_Cuisine_name, p_Recipies_name, p_Cook_name, p_Cook_surname;
			END IF;*/
        END WHILE;
        SET p_Episode_episode_number = p_Episode_episode_number + 1;
    END WHILE;
END