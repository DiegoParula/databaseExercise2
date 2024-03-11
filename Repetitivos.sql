
delimiter $$

-- WHILE
CREATE FUNCTION fn_ejemplo_while() returns int 
deterministic
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 10 DO
        SET i = i + 1;
    END WHILE;
    return i;
END;

-- REPEAT
CREATE FUNCTION fn_ejemplo_repeat() returns int
deterministic
begin
	 DECLARE i INT DEFAULT 1;
    REPEAT
        SET i = i + 1;
    UNTIL i > 10
    END REPEAT;
    return i;
end

-- LOOP
CREATE FUNCTION fn_ejemplo_loop() returns int
deterministic
begin
	 DECLARE i INT DEFAULT 1;
    -- Inicia el bucle
    loop_label: LOOP
    
        -- Incrementa 'i'
        SET i = i + 1;
        -- Verifica la condición de salida
        IF i > 10 THEN
            LEAVE loop_label; -- Sale del bucle si 'i' es mayor que 5
        END IF;
    END LOOP loop_label; -- Finaliza el bucle
    return i;
end

$$
