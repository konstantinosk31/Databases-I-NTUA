WITH C AS
(SELECT
    Cook_name AS Judge_name,
    Cook_surname AS Judge_surname,
    year AS Year,
    COUNT(Episode_episode_number) AS Appereances_Count
FROM
    Judges INNER JOIN Episode ON Episode_episode_number = episode_number
GROUP BY
    Cook_name,
    Cook_surname,
    year
HAVING
    Appereances_Count > 3
)

SELECT C1.Judge_name AS Judge_name_1, C1.Judge_surname AS Judge_surname_1, C2.Judge_name AS Judge_name_2, C2.Judge_surname AS Judge_surname_2, C1.Year AS Year, C1.Appereances_Count AS Appearances_Count
FROM C as C1 INNER JOIN C AS C2
ON C1.Appereances_Count = C2.Appereances_Count
WHERE C1.Judge_name <= C2.Judge_name;