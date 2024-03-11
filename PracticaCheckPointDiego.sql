/* 1 - Necesitamos crear una función que dada la cantidad de unidades pedidas y el nombre de un producto, 
validemos que tengamos la cantidad de unidades en stock necesaria para cubrir el pedido.*/
DELIMITER $$
CREATE FUNCTION validarStockDisponible(unidadesPedidas SMALLINT, productoNombre VARCHAR(40)) 
RETURNS bit 
DETERMINISTIC

BEGIN
    DECLARE stock_disponible SMALLINT; 
    
    
    -- Obtengo el stock disponible 
    SELECT p.UnidadesStock INTO stock_disponible
    FROM Productos as p 
    WHERE p.ProductoNombre = productoNombre;
    
    -- Validamos si hay stock suficiente
    IF stock_disponible < unidadesPedidas THEN
        RETURN 0;
    ELSE 
        RETURN 1;
    END IF;
END;

$$

Select validarStockDisponible(28, 'Chai');

/*Otra opcion con mensaje personalizado*/

DELIMITER $$
CREATE FUNCTION validarStockDisponibleConMensaje(unidadesPedidas SMALLINT, productoNombre VARCHAR(40)) 
 
RETURNS Varchar(50)
DETERMINISTIC

BEGIN
    DECLARE stock_disponible SMALLINT; 
    DECLARE mensaje varchar(50);
    
    
    -- Obtengo el stock disponible 
    SELECT p.UnidadesStock INTO stock_disponible
    FROM Productos as p 
    WHERE p.ProductoNombre = productoNombre;
    
    -- Validamos si hay stock suficiente
    IF stock_disponible < unidadesPedidas THEN
        set mensaje = 'SIN STOCK DISPONIBLE';
    ELSE 
        SET mensaje = 'STOCK DISPONIBLE';
    END IF;
    RETURN mensaje; 
END;

$$

Select validarStockDisponibleConMensaje(50, 'Chai');

/***********************************************************************************************/

/* 2- Necesitamos crear una tabla de auditoría para la tabla de facturas.Crear algunos triggers para 
cada vez que insertamos registros en la tabla, para cada vez que modificamos registros y también para cuando eliminamos. 
La tabla tiene que tener un id propio, el id de la factura, la acción que se realizó, el responsable de la misma y la fecha y hora. 
La tabla se genera una sola vez y queda registrada en nuestra base de datos (no hace falta que esté en los triggers).*/

Create table FacturasAuditoria(
id INT AUTO_INCREMENT PRIMARY KEY,
id_factura INT,
accion VARCHAR(50),
responsable VARCHAR(50),
fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
-- TRIGGER para insertar en tabla facturas
CREATE TRIGGER agregarFacturas
AFTER INSERT on Facturas for each row
BEGIN 
	INSERT into FacturasAuditoria (id_factura, accion, responsable) value (NEW.FacturaID, 'INSERTAR', CURRENT_USER());
END;

-- TRIGGER para actualizar en tabla facturas
CREATE TRIGGER ActualizarFacturas
AFTER UPDATE on Facturas for each row 
BEGIN 
	INSERT into FacturasAuditoria (id_factura, accion, responsable) value (NEW.FacturaID, 'ACTUALIZA', CURRENT_USER());  
END;

-- TRIGGER para eliminar en tabla facturas
CREATE TRIGGER EliminarFacturas
AFTER DELETE on Facturas for each row
BEGIN
	INSERT INTO FacturasAuditoria (id_factura, accion, responsable) value (old.FacturaID, 'ELIMINADO', CURRENT_USER());
END;

$$


insert into Facturas(ClienteID, EmpleadoID, FechaFactura, FechaRegistro, FechaEnvio, EnvioVia, Transporte, NombreEnvio, DireccionEnvio,
CiudadEnvio, RegionEnvio, CodigoPostalEnvio, PaisEnvio) values ('RATTC', '1', '2024-03-10 00:00:00', '2024-03-10 00:00:00', 
'2024-03-12 00:00:00', '2', '8.53', 'Rattlesnake Canyon Grocery', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', 'USA');

update Facturas
set DireccionEnvio = 'cambio para TRIGGER'
where FacturaID = 11080

delete from Facturas
where FacturaID = 11080
-- Para actualizar los triggers los elimino 
/*DROP TRIGGER agregarFacturas;
DROP TRIGGER ActualizarFacturas;
DROP TRIGGER EliminarFacturas;*/


/*************************************************************************************************************************************************/

/* 3- Crear un storedprocedure SP_Genera_Factura que, dado un nombre de un producto, la cantidad del mismo, el nombre del cliente(compañía), el nombre del empleado,
 apellido del mismo y el nombre de la compañía de correo, genere el detalle de la factura y el encabezado de la misma. Nuestras facturas, solo van a tener 1 
 detalle y 1 registro de factura.
Tener en cuenta:
- No validar lógicamente si no encontramos un empleado o un producto, etc. por su nombre.
- No se puede generar una factura que supere la cantidad de unidades en stock (usar la función del punto 1).
- Para las facturas, para todas las fechas usar el día y hora actual. El envío vía es el id de nuestro correo, el valor del transporte es gratis y 
el nombre es FULL. La dirección de la factura y de envío es la misma que la del cliente.
- Para los detalles de facturas, no tenemos descuentos nunca y el precio unitario lo obtenemos del producto.*/

DELIMITER $$
create procedure SP_Genera_Factura(
p_nombre_producto varchar(40),
p_cantidad_producto smallint,
p_nombre_cliente varchar(40),
p_nombre_empleado varchar(10),
p_apellido_empleado varchar(20),
p_nombre_compania_correo varchar(40)

) 

Begin
	Declare v_nombre_producto varchar(40),
	Declare v_nombre_cliente varchar(40),
	Declare v_nombre_empleado varchar(10),
	Declare v_apellido_empleado varchar(20),
	Declare v_nombre_compania_correo varchar(40),
    Declare v_ClienteID char(5), 
    Declare v_EmpleadoID int, 
    declare v_FechaFactura datetime, 
    declare v_FechaRegistro datetime, 
    declare v_FechaEnvio datetime, 
    declare v_EnvioVia int, 
    declare v_Transporte double, 
    declare v_NombreEnvio varchar(40), 
    declare v_DireccionEnvio varchar(60),
    declare v_CiudadEnvio varchar(15), 
    declare v_RegionEnvio varchar(15), 
    declare v_CodigoPostalEnvio varchar(10), 
    declare v_PaisEnvio varchar(15),
    DECLARE error_message VARCHAR(255),
    declare v_facturaID int,
    declare v_ProductoID int,
    declare v_PrecioUnitario double,
    declare v_descuento double,
   
   
    DECLARE exit handler for sqlexception
    BEGIN
        -- Manejo de errores de excepción SQL
		GET DIAGNOSTICS CONDITION 1 error_message = MESSAGE_TEXT;
        SELECT CONCAT('Error Message: ', error_message) AS ErrorMessage;
        
    END;
    
    -- Obtengo el nombre del producto  
    SELECT p.ProductoNombre INTO v_nombre_producto
    FROM Productos as p 
    WHERE p.ProductoNombre = v_productoNombre;
    
    --
    
    
end;



DELIMITER ;

Select database();