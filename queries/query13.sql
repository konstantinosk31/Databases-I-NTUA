WITH D AS (
	SELECT
		year AS Year,
		e.Episode_name AS Episode_name,
		RANK() OVER (
			PARTITION BY year
			ORDER BY professional_expertise_type
		) AS rk
	FROM
		Cook c
	INNER JOIN
		Assignment a ON a.Cook_name = c.name AND  a.Cook_surname = c.surname
	INNER JOIN
		Episode e ON a.Episode_episode_number = e.episode_number
)

SELECT
	Year,
    Episode_name
FROM (
	SELECT
		Year,
		Episode_name,
		sum(rk) AS Total_Evaluation
	FROM
		D
	GROUP BY
		Year,
		Episode_name
	ORDER BY
		Total_Evaluation DESC
	LIMIT 1
) AS F;