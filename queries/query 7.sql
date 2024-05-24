WITH C AS (
SELECT
	Cook_name,
    Cook_surname,
	COUNT(Episode_episode_number) AS Episode_Count
FROM
	Assignment
GROUP BY
	Cook_name,
	Cook_surname
)

SELECT
    Cook_name,
    Cook_surname,
    Episode_Count
FROM
    C
WHERE
	Episode_Count <= (
		SELECT max(Episode_Count) - 5
		FROM C
	)
ORDER BY
	Episode_Count
