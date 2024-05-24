SELECT
    year AS Year, ROUND(AVG(r.carbs), 2) AS Average_Carbs
FROM
    Assignment a
INNER JOIN
	Episode e ON a.Episode_episode_number = e.episode_number
INNER JOIN
    Recipies r ON a.Recipies_name = r.name
GROUP BY year
ORDER BY year