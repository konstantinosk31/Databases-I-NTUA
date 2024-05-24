SELECT
	Cook_name,
    Cook_surname
FROM
	Assignment INNER JOIN Episode
    ON Episode_episode_number = episode_number
WHERE 
	National_Cuisine_name = "Greek" AND year = 1;