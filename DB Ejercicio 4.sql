drop database if exists DBParcialII2016240;
create database DBParcialII2016240;

use DBParcialII2016240; 
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Create table Laboratorio(
	codigoLaboratorio int auto_increment not null,
    valor1 int not null,
    valor2 int not null,
    valor3 int not null,
    valor4 int not null,
    valor5 int not null,
    r1 int,
    r2 int,
    r3 decimal(10,2),
    r4 decimal(10,2),
    r5 decimal(10,2),
    r6 varchar (1000),
    primary key PK_codigoLaboratorio (codigoLaboratorio)
);
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	Create procedure sp_AgregarDatos(in valor1 int, in valor2 int, in valor3 int, in valor4 int, in valor5 int)
		Begin
			Insert into Laboratorio
				(valor1, valor2, valor3, valor4, valor5)
                values (valor1, valor2, valor3, valor4, valor5);
        End$$
Delimiter ;

call sp_AgregarDatos(3,5,2,4,8);
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
Create procedure sp_ListarDatos()
	Begin
		Select
			Laboratorio.valor1,
            Laboratorio.valor2,
            Laboratorio.valor3,
            Laboratorio.valor4,
            Laboratorio.valor5,
            Laboratorio.r1,
            Laboratorio.r2,
            Laboratorio.r3,
            Laboratorio.r4,
            Laboratorio.r5,            
            Laboratorio.r6
            from
				Laboratorio;
    End$$
Delimiter ;

Call sp_ListarDatos();
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_abs(num int) #drop function fn_abs
    returns int
    reads sql data deterministic 
		begin
			declare result int;
				if (num > 0) then
					set result = num;
				elseif (num < 0) then
					set result = num * -1;
				end if;
			return result;
        end$$
delimiter ;

select fn_abs(4) as ABS;
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_DIV(num1 int, num2 int) #drop function fn_div
    returns int 
    reads sql data deterministic 
		begin
			declare result int;
            declare cont int default 0;
				repeat
					set cont = cont + 1;
                    set result = num1 * cont;
				until(result = num2)
                end repeat;
			return cont;
        end$$
delimiter ;

select fn_DIV(4,8) as Division;
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_X1(a int, b int, c int) #drop function fn_X1   #sqrt
    returns float
    reads sql data deterministic 
		Begin
			declare result float;
            declare raiz float;
            declare result1 int;
            declare result2  float;
				set result1 = (b*b) - (4*(a*c));
				set raiz = sqrt(result1);
				set result2 = -b + raiz;
				set result = result2 / (2*a);
			return result;
        end $$
delimiter ;

select fn_X1(3,5,2) as X1;
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_X2(a int, b int, c int) #drop function fn_X2   #sqrt
    returns float
    reads sql data deterministic 
		Begin
			declare result float;
            declare raiz float;
            declare result1 int;
            declare result2  float;
				set result1 = (b*b) - (4*(a*c));
				set raiz = sqrt(result1);
				set result2 = -b - raiz;
				set result = result2 / (2*a);
			return result;
        end $$
delimiter ;

select fn_X2(3,5,2) as X2;
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_promedio(valor1 int, valor2 int, valor3 int, valor4 int, valor5 int) #drop function fn_promedio
    returns varchar(1000)
    reads sql data deterministic 
		begin
			declare promedio decimal(10,2);
            declare mensaje varchar(1000) default '';
            declare cont int default 0;
            set promedio = (valor1 + valor2 + valor3 + valor4 + valor5) / 5; 
				if valor1 > promedio then
					set cont = cont +1;
					set mensaje = concat(mensaje, valor1);
				end if;
                if valor2 > promedio then
					set cont = cont +1;
					set mensaje = concat(mensaje, valor2);
				end if;
                if valor3 > promedio then
					set cont = cont +1;
					set mensaje = concat(mensaje, valor3);
				end if;
                if valor4 > promedio then
					set cont = cont +1;
					set mensaje = concat(mensaje, valor4);
				end if;
                if valor5 > promedio then
					set cont = cont +1;
					set mensaje = concat(mensaje, ' , ', valor5, '  ,y son = ', cont);
				end if;
            return mensaje;
        end $$ 
delimiter ;

select fn_promedio(3,5,2,4,8) as Promedio;
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
create Procedure SP_AlmacenarDatos(cod int) #drop procedure SP_AlmacenarDatos
	begin
	update laboratorio
		set r1 = fn_abs(laboratorio.valor4),
		r2 = fn_DIV(laboratorio.valor4, laboratorio.valor5),
		r3 = fn_X1(laboratorio.valor1, laboratorio.valor2, laboratorio.valor3),
		r4 = fn_X2(laboratorio.valor1, laboratorio.valor2, laboratorio.valor3),
		#r5 = fn_factorial(laboratorio.valor4),
		r6 = fn_promedio(laboratorio.valor1, laboratorio.valor2, laboratorio.valor3, laboratorio.valor4, laboratorio.valor5)
        where(codigolaboratorio = cod);
	end $$
delimiter ;

call sp_almacenarDatos(1);