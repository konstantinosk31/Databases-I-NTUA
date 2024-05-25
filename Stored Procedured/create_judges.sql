CREATE DEFINER=`root`@`localhost` PROCEDURE `create_judges`(
)
    MODIFIES SQL DATA
    COMMENT 'Creates new judges'
BEGIN
    DECLARE p_Judge_name VARCHAR(50);
    DECLARE p_Judge_surname VARCHAR(50);
    DECLARE p_Episode_episode_number INT;
    DECLARE is_valid TINYINT;
    DECLARE p_offset INT;
    DECLARE p_Judge_number INT;
    
    SET p_Episode_episode_number = 1;

    WHILE p_Episode_episode_number <= 10 DO
        SET p_Judge_number = 1;

        SELECT Cook_name AS Judge_name_list, Cook_surname AS Judge_surname_list
        FROM Cook
        ORDER BY RAND()
        LIMIT 3;

        WHILE p_Judge_number <= 3 DO
            SET p_offset = p_Episode_episode_number-1;
            
            SELECT * INTO p_Judge_name 
            FROM p_Judge_name_list
            LIMIT 1
            OFFSET p_offset;

            SELECT * INTO p_Judge_surname 
            FROM p_Judge_surname_list
            LIMIT 1
            OFFSET p_offset;

            CALL check_cook_not_in_3_in_a_row(p_Judge_name, p_Judge_surname, p_Episode_episode_number, is_valid);

            IF is_valid = 1 THEN
                INSERT INTO Judge(Cook_name, Cook_surname, Episode_episode_number)
                VALUES(p_Judge_name, p_Judge_surname, p_Episode_episode_number);

                SET p_Judge_number = p_Judge_number + 1;
            END IF;
        END WHILE;
        
        SET p_Episode_episode_number = p_Episode_episode_number + 1;
    END WHILE;
END