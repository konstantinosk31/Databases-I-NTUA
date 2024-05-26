SELECT 
	Assignment_National_Cuisine_name AS National_Cuisine, 
	ROUND(AVG(evaluation), 2) AS Average_Evaluation
FROM 
	Eval_for
GROUP BY 
	Assignment_National_Cuisine_name;