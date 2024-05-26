CREATE DEFINER=`root`@`localhost` PROCEDURE `for_loop_judges`()
BEGIN
	DECLARE p_Episode_episode_number INT;
	SET p_Episode_episode_number = 1;
	WHILE p_Episode_episode_number <= 100 DO
		CALL create_judges(p_Episode_episode_number);
		SET p_Episode_episode_number = p_Episode_episode_number + 1;
	END WHILE;
END