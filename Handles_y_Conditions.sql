CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_actor`(
    IN p_id INT
)
BEGIN
    DECLARE error_code CHAR(5);
    DECLARE error_message VARCHAR(255);
    DECLARE error_code2 CHAR(5);
    DECLARE error_message2 VARCHAR(255);
    DECLARE truncation_warning VARCHAR(255);
    
	Declare texto_largo condition for 1406;

    -- Handler para manejar inserciones de claves duplicadas
    DECLARE exit HANDLER FOR 1451
    BEGIN
        GET DIAGNOSTICS CONDITION 1 error_code = RETURNED_SQLSTATE, error_message = MESSAGE_TEXT;
        SET error_message = CONCAT('Error SQL: ', error_code, ' -- ' , error_message);
        SELECT error_message AS ErrorMessage;
    END;

     -- Handler una columna de texto que se le inserta un valor mayor al que puede contener
    DECLARE exit HANDLER FOR texto_largo
    BEGIN
        GET DIAGNOSTICS CONDITION 1 error_code = RETURNED_SQLSTATE, error_message = MESSAGE_TEXT;
        SET error_message = CONCAT('Error SQL: ', error_code, ' ** ' , error_message);
        SELECT error_message AS ErrorMessage;
    END;

	-- Handler que maneja errores cuyo estado es 23000
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'
    BEGIN
        SET error_message = 'El nombre del actor no puede ser nulo.';
        SELECT error_message AS ErrorMessage;
    END;

    -- Handler una columna de texto que se le inserta un valor mayor al que puede contener
    DECLARE exit HANDLER FOR sqlexception
    BEGIN
        GET DIAGNOSTICS CONDITION 1 error_code = RETURNED_SQLSTATE, error_message = MESSAGE_TEXT;
        -- GET DIAGNOSTICS CONDITION 2 error_code2 = RETURNED_SQLSTATE, error_message2 = MESSAGE_TEXT;
        SET error_message = CONCAT('Error SQL: ', error_code, ' <-> ' , error_message);
        SELECT error_message AS ErrorMessage;
        select CONCAT('Error SQL: ', error_code2, ' -> ' , error_message2);
    END;

	-- UPDATE actors SET id=1 WHERE id = p_id;
	-- UPDATE actors SET iniciales = 'dddd' WHERE id = p_id;
    -- update actors set first_name = null where id=p_id;
    -- UPDATE actors SET rating = 7000 WHERE id = p_id;
    
    Select "Se actualizo el actor";
END