SELECT
    a.Episode_episode_number AS Episode_number,
    SUM(r.difficulty) AS Total_Difficulty
FROM
    Assignment a
JOIN
    Recipies r ON a.Recipies_name = r.name
GROUP BY
    a.Episode_episode_number
ORDER BY
	Total_Difficulty DESC
LIMIT 1;