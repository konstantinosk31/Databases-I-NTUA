SELECT
    Cook_name AS Judge_name,
    Cook_surname AS Judge_surname,
    COUNT(Episode_episode_number) AS Appereances_Count
FROM
    Judges
GROUP BY
    Cook_name,
    Cook_surname
HAVING
    Appereances_Count > 3
