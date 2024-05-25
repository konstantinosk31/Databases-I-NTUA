CREATE PROCEDURE `check_cook_not_in_3_in_a_row`(
    IN cook_name VARCHAR(50),
    IN cook_surname VARCHAR(50),
    IN upcoming_episode_number INT,
    OUT is_valid TINYINT
)
BEGIN
    DECLARE episode_count INT;

    -- Check how many of the last two episodes the participant was in
    SELECT COUNT(*) INTO episode_count
    FROM Assignment
    WHERE Cook_name = cook_name
        AND Cook_surname = cook_surname
        AND Episode_episode_number IN (upcoming_episode_number - 1, upcoming_episode_number - 2);

    -- Check the count of episodes
    IF episode_count >= 2 THEN
       SET is_valid = 0;
    ELSE
        SET is_valid = 1;
    END IF;
END