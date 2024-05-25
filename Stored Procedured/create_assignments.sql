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
END