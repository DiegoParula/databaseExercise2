/*1. Crear un procedimiento almacenado que inserta de a un registro en la tabla items_de_factura. Parámetros de entrada: mismos campos que la tabla
items_de_facturas.
Parámetros de salida: no tiene.*/

DELIMITER $$
CREATE PROCEDURE sp_insert_item_factura(IN id SMALLINT, IN id_factura SMALLINT, IN id_cancion SMALLINT, IN precio_unitario DECIMAL(3,2), IN cantidad TINYINT) 
begin
	insert into items_de_factura (id, id_factura, id_cancion, precio_unitario, cantidad) values (id, id_factura, id_cancion, precio_unitario, cantidad);
END $$

#CALL sp_insert_item_factura(2, 2, 4, 12.75, 1);

/*2. Crear un procedimiento almacenado que inserta ítems de facturas utilizando el procedimiento del punto 1.
Los ítems que vamos a insertar son los que estarán en la siguiente tabla temporal:
CREATE TEMPORARY TABLE temp_items_de_factura SELECT id, id_factura,
id_cancion, precio_unitario, 15 as cantidad FROM items_de_facturas;
Utilizar un cursor que recorra los registros de la tabla temporal y llame al
procedimiento del punto 1 para insertar los valores de la misma.*/

DELIMITER $$
create procedure sp_insert_temp()
begin
DECLARE id SMALLINT; 
DECLARE id_factura SMALLINT; 
DECLARE id_cancion SMALLINT; 
DECLARE precio_unitario DECIMAL(3,2); 
DECLARE cantidad TINYINT;

#para luego validar el final del cursor 
DECLARE c_final TINYINT DEFAULT 0;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_final = 1;

#Definicion de cursor
DECLARE Cur1 CURSOR FOR SELECT * FROM temp_items_de_factura;

CREATE TEMPORARY TABLE temp_items_de_factura 
SELECT id, id_factura, id_cancion, precio_unitario, 15 as cantidad 
FROM items_de_facturas;

#abrimos el cursor 
open Cur1;

#comenzamos a iterar 
agregarItems: LOOP





end; $$



