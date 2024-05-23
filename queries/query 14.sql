SELECT
    rhtu.Thematic_Unit_name,
    COUNT(DISTINCT a.Episode_episode_number) AS Episode_Count
FROM
    Assignment a
JOIN
    Recipies_has_Thematic_Unit rhtu ON a.Recipies_name = rhtu.Recipies_name
GROUP BY
    rhtu.Thematic_Unit_name
ORDER BY
    Episode_Count DESC
LIMIT 1;
