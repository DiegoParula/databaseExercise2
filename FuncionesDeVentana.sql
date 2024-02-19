#Funciones de Ventana.
#FIRST_VALUE: Devuelve el primer valor del primer registro de nuestra consulta.
#LAST_VALUE: Devuelve el valor del último registro de nuestra consulta

SELECT
	e.EmployeeID AS 'EmpleadoId'
	,e.ManagerId AS 'ManagerId'
	,e.Gender AS 'Genero'
	,e.MaritalStatus AS 'Estado Civil'
	,e.Title AS 'Titulo'
	,e.NationalIdNumber AS 'NationalidNumber'
	,FIRST_VALUE(e.NationalIdNumber) OVER (W) AS 'Primer Valor'
	,LAST_VALUE(e.NationalIDNumber)OVER(w)AS'ÚltimoValor'
FROM employee e
WINDOW W AS (PARTITION BY e.ManagerId ORDER BY e. ManagerID ASC)
ORDER BY e.ManagerId ASC ;

#LAG: Devuyelve el valor anterior del regsitro actual.
#LEAD: Devuelve el valor siguinete del registro actual que estamos mostrando.

SELECT
	e.EmployeeID AS 'EmpleadoId'
	,e.ManagerId AS 'ManagerId'
	,e.Gender AS 'Genero'
	,e.MaritalStatus AS 'Estado Civil'
	,e.Title AS 'Titulo'
	,e.NationalIdNumber AS 'NationalidNumber'
	,LAG(e.NationalIdNumber) OVER (W) AS 'Valor anterior'
	,LEAD(e.NationalIDNumber) OVER (w) AS'Valor Siguiente'
FROM employee e
WINDOW W AS (PARTITION BY e.ManagerId ORDER BY e. ManagerID ASC)
ORDER BY e.ManagerId ASC ;

#NTILE: Divide la cantidad de resultados por el parametro que recibe y asigna un grupo a cada uno de los registros.
#ROW_NUMBER: Devuelve el numero de la fila actual dentro de la cantidad de resultados. Los numeros de filas van desde el 1 hasta el numero de filas de resultados

SELECT
	e.EmployeeID AS 'EmpleadoId'
	,e.ManagerId AS 'ManagerId'
	,e.Gender AS 'Genero'
	,e.MaritalStatus AS 'Estado Civil'
	,e.Title AS 'Titulo'
	,e.NationalIdNumber AS 'NationalidNumber'
	,ROW_NUMBER() OVER (W) AS 'Numero de Registro'
	,NTILE(4) OVER (w) AS 'Grupo'
FROM employee e
WINDOW W AS (PARTITION BY e.ManagerId ORDER BY e. ManagerID ASC)
ORDER BY e.ManagerId ASC ;


