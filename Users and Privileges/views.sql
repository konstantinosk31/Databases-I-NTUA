CREATE VIEW `view_cook_info` AS 
SELECT * 
FROM Cook 
WHERE name = 'Ariana' AND surname = 'Fields'; 

CREATE VIEW `view_cook_recipies` AS 
SELECT *
FROM Recipies
WHERE name IN (SELECT Recipies_name FROM Assignment WHERE Cook_name = 'Ariana' AND Cook_surname = 'Fields');

GRANT SELECT, UPDATE ON `view_cook_info` TO 'Cook'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `view_cook_recipies` TO 'Cook'@'localhost';
FLUSH PRIVILEGES;