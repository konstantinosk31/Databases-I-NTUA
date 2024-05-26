SELECT 
    Assignment_Cook_name AS Cook_Name, 
    Assignment_Cook_surname AS Cook_Surname, 
    ROUND(AVG(evaluation), 2) AS Average_Evaluation
FROM 
    Eval_for
GROUP BY 
    Assignment_Cook_name, 
    Assignment_Cook_surname
ORDER BY 
    Average_Evaluation;
