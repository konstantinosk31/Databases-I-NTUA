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
END