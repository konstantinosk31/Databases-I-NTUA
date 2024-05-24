WITH Winner AS (
    SELECT
        e.Episode_episode_number AS Episode_number,
        e.Assignment_Cook_name AS Cook_name,
        e.Assignment_Cook_surname AS Cook_surname,
        c.Professional_Expertise_type AS Expertise,
        SUM(e.evaluation) AS Total_Evaluation,
        RANK() OVER (
            PARTITION BY e.Episode_episode_number 
            ORDER BY SUM(e.evaluation) DESC, c.Professional_Expertise_type DESC
        ) AS rk
    FROM 
        Eval_for e JOIN Cook c 
        ON e.Assignment_Cook_name = c.name AND e.Assignment_Cook_surname = c.surname
    GROUP BY
        e.Episode_episode_number,
        e.Assignment_Cook_name,
        e.Assignment_Cook_surname,
        c.Professional_Expertise_type
)

SELECT
    Episode_number,
    Cook_name,
    Cook_surname,
    Total_Evaluation,
    Expertise
FROM 
    Winner
WHERE rk = 1
ORDER BY 
    Episode_number;