CREATE DEFINER=`root`@`localhost` PROCEDURE `check_valid_assignment_insert`(
    IN p_Cook_name VARCHAR(50),
    IN p_Cook_surname VARCHAR(50),
    IN p_Episode_year INT,
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
    Episode_year = p_Episode_year
        AND Episode_episode_number = p_Episode_episode_number
        AND Cook_name = p_Cook_name
        AND Cook_surname = p_Cook_surname;
    
SELECT 
    COUNT(*)
INTO same_episode_cuisine FROM
    assignment
WHERE
    Episode_year = p_Episode_year
        AND Episode_episode_number = p_Episode_episode_number
        AND National_Cuisine_name = p_National_Cuisine_name;
    
SELECT 
    COUNT(*)
INTO same_episode_recipe FROM
    assignment
WHERE
    Episode_year = p_Episode_year
        AND Episode_episode_number = p_Episode_episode_number
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

END