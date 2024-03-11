-- Variables para ver nivel de aislamiento de transacciones.
SELECT @@GLOBAL.transaction_isolation;
SELECT @@SESSION.transaction_isolation;

-- Cambiar el nivel de aislamento de las transacciones.
SET GLOBAL TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Ejemplo de transaccion basica
-- Comenzamos la transacción

START TRANSACTION;

-- Insertamos un actor
Insert into actors (first_name, last_name, rating)
values('Diego', 'Maradona', 10);

-- Actualizamos el rating de un actor
UPDATE actors
SET rating = 6
WHERE id = 10; 

-- Actualizamos el saldo de la cuenta destino
Delete from actor_movie;

-- Confirmamos la transacción
-- COMMIT;
Rollback;

Delimiter $$
Create procedure sp_borra_actor(in p_id int) 
begin
	declare state, message varchar(255);
    declare errorNumber int;
	declare exit handler for sqlexception
    begin
		Get diagnostics condition 1
			state = returned_sqlstate,
            errorNumber = mysql_errno,
            message = message_text;
            
		rollback;
        Select 'Error al borrar un actor' , state, errorNumber, message;
	end;
    
    start transaction;
    
    insert into actors (first_name, last_name, rating)
    values('Diego', 'Maradona', 10);
    
    delete from actors where id=pid;
    
    commit;
end;
$$

call sp_borra_actor(3);