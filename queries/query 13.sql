WITH Winner AS (
    SELECT
        e.Episode_episode_number AS Episode_number,
        SUM(e.evaluation) AS Total_Evaluation,
        RANK() OVER (
            PARTITION BY e.Episode_episode_number 
            ORDER BY SUM(e.evaluation) DESC
        ) AS rk
    FROM 
        Eval_for e
    GROUP BY
        e.Episode_episode_number
)

SELECT
    Episode_number,
    Total_Evaluation
FROM 
    Winner
WHERE rk = 1
ORDER BY 
    Episode_number;

WITH COUNT_A AS( 
	SELECT COUNT(*)
	FROM Eval_for 
	WHERE Professional_Expertise_type = '1.chef');

