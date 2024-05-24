SELECT
	year AS Year,
    e.episode_name AS Episode_name,
    SUM(r.difficulty) AS Total_Difficulty
FROM
    Assignment a
JOIN
	Episode e ON a.Episode_episode_number = e.episode_number
JOIN
    Recipies r ON a.Recipies_name = r.name
GROUP BY
    a.Episode_episode_number
ORDER BY
	Total_Difficulty DESC
LIMIT 1;