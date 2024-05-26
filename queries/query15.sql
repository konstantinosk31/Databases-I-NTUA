SELECT name AS Food_Categories_name
FROM Food_Category fc
WHERE fc.name NOT IN (
    SELECT DISTINCT
        i.Food_Category_name
    FROM
        Assignment a
    JOIN
        Recipies r ON a.Recipies_name = r.name
    JOIN
        Ingredients i ON r.basic_ingredient_name = i.name
);
