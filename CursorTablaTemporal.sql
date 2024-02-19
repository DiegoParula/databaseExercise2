DELIMITER $$
CREATE PROCEDURE usp_Facturas_cursor_insertar ()
BEGIN
#Definicioón de variables
DECLARE id_cliente tinyint ;
DECLARE fecha_factura date ;
DECLARE direccion_de_facturacion varchar(40);
DECLARE ciudad_de_facturacion varchar(19);
DECLARE estado_o_província_de_facturacion varchar(6);
DECLARE país_de_facturacion varchar(14);
DECLARE codigo_postal_de_facturacion varchar(10);
DECLARE total decimal(4,2);
DECLARE FacturaID smallint;

DECLARE c_final TINYINT DEFAULT 0;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_final = 1;

#Definicion de cursor
DECLARE Cur1 CURSOR FOR SELECT * FROM temp_factura;

#Definicion de Tabla temporal
CREATE TEMPORARY TABLE IF NOT EXISTS temp_factura
SELECT id_cliente , fecha_factura, direccion_de_facturacion, ciudad_de_facturacion, estado_o_província_de_facturacion , país_de_facturacion, codigo_postal_de_facturacion, total
FROM facturas;

#Abrimos Cursor
OPEN cur1;

#CXomenzamos a iterar
agregarFacturas: LOOP

FETCH cur1 INTO id_cliente , fecha_factura, direccion_de_facturacion, ciudad_de_facturacion, estado_o_província_de_facturacion , país_de_facturacion, codigo_postal_de_facturacion, total;

#Validamos final del cursor 
IF c_final = 1 THEN 
	LEAVE agregarFacturas;
END IF;

SET FacturaID = (SELECT MAX(d.if) FROM facturas f);
SET FacturaID = FacturaID +1;

CALL usp_Facturas_cursor_insertar(FacturaID, id_cliente , fecha_factura, direccion_de_facturacion, ciudad_de_facturacion, estado_o_província_de_facturacion , país_de_facturacion, codigo_postal_de_facturacion, total);

END LOOP;

#Cerrramos cursor 
CLOSE cur1;

END; $$
