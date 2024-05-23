SELECT 
    c.name AS Cook_name, 
    c.surname AS Cook_surname,
    c.age AS Age,
    COUNT(e.Recipies_name) AS Recipe_Count
FROM 
    Cook c INNER JOIN Assignment e 
    ON c.name = e.Cook_name AND c.surname = e.Cook_surname
WHERE 
    c.age < 30
GROUP BY 
    c.name, 
    c.surname,
    c.age
ORDER BY 
    Recipe_Count DESC;
