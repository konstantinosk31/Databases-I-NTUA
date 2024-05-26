EXPLAIN SELECT
	year as Year,
    episode_name AS Episode_name,
    COUNT(re.Equipment_name) AS Equipment_Count
FROM
    Assignment a FORCE INDEX (`fk_Assignment_Recipies1_idx`)
INNER JOIN
	Episode e FORCE INDEX (PRIMARY)
ON
	a.Episode_episode_number = e.episode_number
INNER JOIN
    Recipies_has_Equipment re  FORCE INDEX (`fk_Recipies_has_Equipment_Recipies_idx`)
ON
	a.Recipies_name = re.Recipies_name
GROUP BY
    a.Episode_episode_number
ORDER BY
    Equipment_Count DESC
LIMIT 1;
