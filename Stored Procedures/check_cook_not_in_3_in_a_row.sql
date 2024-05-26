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
END