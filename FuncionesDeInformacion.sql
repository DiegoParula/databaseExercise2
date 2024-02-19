#Funciones de Informacion.
#CURRENT ROLE: Devuelve los roles activos actuales del usuario conectado.
#CURRENT_USER: Devuelve el nombre de usuario y el nombre de host autenticados.
#DATABASE: Devuelve el nombre de la base de datos actual.
#VERSION: Devuelve una cadena que indica la versión del servidor MysQL.

SELECT CURRENT_ROLE();
SELECT CURRENT_USER();
SELECT DATABASE();
SELECT VERSION();

#ROW COUNT: Devuelve el número de filas actualizadas.
#LAST INSERT ID: Devuelve el valor de la columna AUTOINCREMENT para el último INSERT

UPDATE address SET modifiedDate = now ();
SELECT ROW_COUNT();

INSERT INTO `adventureworks`.`address`(`AddressLinel`,`Addressline2`,`City`,`StateProvinceID`,`PostalCode`,`rouguid`,`date`);
VALUES ('direccion 1', 'direccion 2', 'Monroe',79,98272,'',NOW());
SELECT * FROM address ORDER BY addressid DESC LIMIT 1;
SELECT LAST_INSERT_ID();