SELECT
    a.Episode_episode_number,
    COUNT(re.Equipment_name) AS Equipment_Count
FROM
    Assignment a
INNER JOIN
    Recipies_has_Equipment re
ON
	a.Recipies_name = re.Recipies_name
GROUP BY
    a.Episode_episode_number
ORDER BY
    Equipment_Count DESC
LIMIT 1;
