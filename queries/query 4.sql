SELECT 
    c.name AS Cook_name, 
    c.surname AS Cook_surname
FROM 
    Cook c LEFT JOIN Eval_for e 
	ON c.name = e.Assignment_Cook_name 
    AND c.surname = e.Assignment_Cook_surname
WHERE 
    e.Assignment_Cook_name IS NULL 
    AND e.Assignment_Cook_surname IS NULL;
