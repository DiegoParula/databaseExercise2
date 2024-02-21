use movies_ad;

-- Creamos el procedimiento almacenado
DELIMITER $$
CREATE PROCEDURE mostrar_actores_de_rating_minimo(IN rating_minimo decimal(3,1))
BEGIN
-- Declaración de variables
DECLARE done INT DEFAULT FALSE;
DECLARE nombre_actor VARCHAR (255);
DECLARE rating_actor decimal (3,1);

-- Declaramos el cursor
DECLARE cur CURSOR FOR SELECT first_name, rating FROM actors WHERE rating > rating_minimo;

-- Manjeamos excepciones
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

-- Abrimos el cursor
OPEN cur;

-- Iniciamos el bucle para recorrer los resultados del cursor 
read_loop: LOOP

-- Obtenemos los datos de la fila actual del cursor
FETCH cur INTO nombre_actor, rating_actor;

-- Verificamos si hemos llegado al final de los resultados
IF done THEN
	LEAVE read_loop;
END IF;

-- Mostramos el nombre del empleado y su salario
	SELECT CONCAT (nombre_actor, ' tiene ', rating_actor, ' de rating');
END LOOP;
-- Cerramos el cursor
CLOSE cur;
END$$
DELIMITER ;

CALL mostrar_actores_de_rating_minimo(5.0);