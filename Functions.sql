DELIMITER $$
CREATE FUNCTION calcularPrecioTotal(unitprice FLOAT, qty int) RETURNS DECIMAL(9,2) 
Deterministic
BEGIN
    DECLARE preciototal DECIMAL(9,2);
    SET preciototal = unitprice * qty;
    RETURN preciototal;
END;

CREATE FUNCTION obtener_valor_aleatorio() RETURNS INT
NOT DETERMINISTIC
BEGIN
    DECLARE valor_aleatorio INT;
    SET valor_aleatorio = FLOOR(RAND() * 100); -- Genera un número aleatorio entre 0 y 99
    RETURN valor_aleatorio;
END;

CREATE FUNCTION obtener_recuento_registros() RETURNS INT
CONTAINS SQL
BEGIN
    DECLARE contador INT;
    SELECT COUNT(*) INTO contador FROM nombre_de_tabla;
    RETURN contador;
END;

CREATE FUNCTION calcular_factorial(numero INT) RETURNS INT
NO SQL
BEGIN
    DECLARE resultado INT;
    DECLARE i INT;

    SET resultado = 1;
    SET i = 1;

    WHILE i <= numero DO
        SET resultado = resultado * i;
        SET i = i + 1;
    END WHILE;

    RETURN resultado;
END;

CREATE FUNCTION obtener_cantidad_registros_usuario(nombre_usuario VARCHAR(255)) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE cantidad_registros INT;
    SELECT COUNT(*) INTO cantidad_registros FROM tabla_datos WHERE usuario = nombre_usuario;
    RETURN cantidad_registros;
END;

CREATE FUNCTION insertar_nuevo_registro(valor INT) RETURNS BOOLEAN
MODIFIES SQL DATA
BEGIN
    DECLARE exito BOOLEAN DEFAULT FALSE;

    INSERT INTO tabla_ejemplo (columna_valor) VALUES (valor);

    SET exito = TRUE;

    RETURN exito;
END;

$$