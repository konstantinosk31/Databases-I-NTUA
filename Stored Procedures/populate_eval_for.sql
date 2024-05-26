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
END