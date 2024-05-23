SELECT name AS Food_Categories_name
FROM Food_Category fc
WHERE fc.name NOT IN (
    SELECT DISTINCT
        i.Food_Category_name
    FROM
        Assignment a
    JOIN
        Recipies_has_Ingredients rhi ON a.Recipies_name = rhi.Recipies_name
    JOIN
        Ingredients i ON rhi.Ingredients_name = i.name
);
