SELECT
	year as Year,
    episode_name AS Episode_name,
    COUNT(re.Equipment_name) AS Equipment_Count
FROM
    Assignment a
INNER JOIN
	Episode e ON a.Episode_episode_number = e.episode_number
INNER JOIN
    Recipies_has_Equipment re ON a.Recipies_name = re.Recipies_name
GROUP BY
    a.Episode_episode_number
ORDER BY
    Equipment_Count DESC
LIMIT 1;
