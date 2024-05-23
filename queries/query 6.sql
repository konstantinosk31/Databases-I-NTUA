SELECT
    re1.Etiquette_Meal_Type AS Etiquette_1,
    re2.Etiquette_Meal_Type AS Etiquette_2,
    COUNT(*) AS Count
FROM
    Eval_for e
JOIN
    Recipies_has_Etiquette re1 ON e.Assignment_Recipies_name = re1.Recipies_name
JOIN
    Recipies_has_Etiquette re2 ON e.Assignment_Recipies_name = re2.Recipies_name
WHERE
    re1.Etiquette_Meal_Type < re2.Etiquette_Meal_Type
GROUP BY
    re1.Etiquette_Meal_Type, re2.Etiquette_Meal_Type
ORDER BY
    Count DESC
LIMIT 3;
