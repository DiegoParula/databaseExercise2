use movies_db;

SELECT title, INSERT(title, 1, 2, "Ejemplo") from movies;

SELECT LCASE(title) from movies;

Select title, Mod(length, 4), length mod 4, length % 4 from moviies;

Select length, SQRT (length) from movies;

Select title, datediff (now(), release_date) from movies;

SELECT DAYNAME(release_date) from movies;

select CASE
	WHEN rating < 5 THEN 'Mala'
	WHEN rating < 7 THEN 'Buena'
    WHEN rating < 9 THEN 'Muy buena'
	ELSE 'Excelente'
END 
from movies;

Select DATABASE();