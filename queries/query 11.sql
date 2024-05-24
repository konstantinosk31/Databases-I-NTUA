SELECT
    Judges_Cook_name AS Judge_Name,
    Judges_Cook_surname AS Judge_Surname,
    Assignment_Cook_name AS Cook_Name,
    Assignment_Cook_surname AS Cook_Surname,
    SUM(evaluation) AS Total_Evaluation
FROM 
    Eval_for
GROUP BY
    Judges_Cook_name,
    Judges_Cook_surname,
    Assignment_Cook_name,
    Assignment_Cook_surname
ORDER BY
    Total_Evaluation DESC
LIMIT 5;
