drop database if exists DBOperaciones2016240;
create database DBOperaciones2016240;

use DBOperaciones2016240;

create table Valores(
	codigoOperacion int auto_increment,
    num1 int not null,
    num2 int not null,
    primary key PK_codigoOperacion (codigoOperacion)
);

select * from valores;

Insert into Valores(num1,num2)
	values (5,30);
    
select (Valores.num1 + Valores.num2) as Resultado from Valores;

DELIMITER $$
	create function fn_Suma(num1 int, num2 int)
		returns int 
        reads SQL DATA DETERMINISTIC
        begin
			declare resp int;
            set resp = num1 + num2;
            return resp;
		End$$
delimiter ;

Select fn_suma(Valores.num1, Valores.num2)
	as resultado From Valores;