SELECT
    AVG(r.carbs) AS Average_Carbs
FROM
    Assignment a
INNER JOIN
    Recipies r
ON
    a.Recipies_name = r.name;
