WITH C AS (SELECT
    National_Cuisine_name,
    year AS Year,
	COUNT(*) AS Appearances_Count
FROM
    Assignment a
INNER JOIN
	Episode e
ON
	a.Episode_episode_number = e.episode_number 
GROUP BY
    National_Cuisine_name,
    year
HAVING
    COUNT(*) >= 3
)

SELECT
	National_Cuisine_name, Year AS Year1, Year+1 AS Year2, Appearances_Count
FROM
	C as C1
WHERE
	Appearances_Count = (
		SELECT Appearances_Count
		FROM C as C2
		WHERE
			C1.National_Cuisine_name = C2.National_Cuisine_name
            AND C1.year = C2.year - 1
    );