CREATE USER 'admin'@'localhost' IDENTIFIED BY 'secure_password';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- cook user
CREATE USER 'Cook'@'localhost' IDENTIFIED BY 'secure_password';

CREATE VIEW `view_cook_info` AS 
SELECT * 
FROM Cook 
WHERE name = 'Ariana' AND surname = 'Fields';

CREATE VIEW `view_cook_recipes` AS 
SELECT *
FROM Recipes
WHERE name IN (SELECT Recipes_name FROM Assignment WHERE Cook_name = 'Ariana' AND Cook_surname = 'Fields');

GRANT SELECT, INSERT, UPDATE ON `view_Ariana_Fields_info` TO 'Cook'@'localhost';
GRANT SELECT, INSERT, UPDATE ON `view_Ariana_Fields_recipes` TO 'Cook'@'localhost';
FLUSH PRIVILEGES;