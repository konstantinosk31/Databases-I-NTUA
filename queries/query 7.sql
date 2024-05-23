SELECT
    Cook_name,
    Cook_surname,
    COUNT(Episode_episode_number) AS Episode_Count
FROM
    Assignment
GROUP BY
    Cook_name,
    Cook_surname
HAVING
    COUNT(Episode_episode_number) <= (
        SELECT
            MAX(Episode_Count) - 1
        FROM
            (SELECT
                Cook_name,
                Cook_surname,
                COUNT(Episode_episode_number) AS Episode_Count
             FROM
                Assignment
             GROUP BY
                Cook_name,
                Cook_surname) AS SubQuery
    )
ORDER BY
	Episode_Count
