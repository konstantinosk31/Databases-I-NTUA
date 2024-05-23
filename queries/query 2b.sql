SELECT DISTINCT
	Assignment_Cook_name AS Cook_name,
    Assignment_Cook_surname AS Cook_surname
FROM
	Eval_for
WHERE 
  (Assignment_Cook_name, Assignment_Cook_surname) 
IN (SELECT
		Cook_name,
		Cook_surname
	FROM
		Has_specialisation
	WHERE
		National_Cuisine_name = "Greek");


