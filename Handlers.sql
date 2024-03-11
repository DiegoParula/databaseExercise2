CREATE DEFINER=`root`@`localhost` PROCEDURE `handler_eliminar_actor`(IN p_id INT)
BEGIN
	DECLARE error_message VARCHAR(255);
    
    DECLARE exit handler for sqlexception
    BEGIN
        -- Manejo de errores de excepción SQL
		GET DIAGNOSTICS CONDITION 1 error_message = MESSAGE_TEXT;
        SELECT CONCAT('Error Message: ', error_message) AS ErrorMessage;
        
    END;

    -- Eliminar el usuario de la tabla
    DELETE FROM actors WHERE id = p_id;
    
    SELECT "Registro borrado correctamente";
END