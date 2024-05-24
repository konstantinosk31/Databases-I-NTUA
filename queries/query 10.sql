SELECT
    National_Cuisine_name,
    COUNT(*) AS Appearances_Count
FROM
    assignment
GROUP BY
    National_Cuisine_name
HAVING
    COUNT(*) >= 3
ORDER BY
    Appearances_Count DESC;
