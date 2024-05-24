SELECT
    e.Episode_episode_number,
    COUNT(re.Equipment_name) AS Equipment_Count
FROM
    Eval_for e
INNER JOIN
    Recipies_has_Equipment re ON e.Assignment_Recipies_name = re.Recipies_name
GROUP BY
    e.Episode_episode_number
ORDER BY
    Equipment_Count DESC
LIMIT 1;
