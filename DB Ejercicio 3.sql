drop database if exists DBParcial2016240;
create database DBParcial2016240;

use DBParcial2016240;
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

create table Laboratorio( #drop table Laboratorio
	codigoLaboratorio int auto_increment not null,
    valor1 int not null,
    valor2 int not null,
    valor3 int not null,
    valor4 int not null,
    valor5 int not null,
    promedio decimal (10,2),
    cuadrado int,
    cubo int,
    XalaY int,
    factorial int,
    sucesion decimal (20,2),
    perfecto varchar(150),
    primary key PK_codigoLaboratorio (codigoLaboratorio)
);

delimiter $$
	create procedure sp_AgregarDatos(in valor1 int, in valor2 int, in valor3 int, in valor4 int, in valor5 int)
		begin 
			insert into Laboratorio(valor1, valor2, valor3, valor4, valor5)
			values(valor1, valor2, valor3 , valor4, valor5);
		end$$
delimiter ;

call sp_AgregarDatos (1,2,3,5,10);

select * from Laboratorio;

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create procedure sp_LisatarDatos()
		begin
			select
				Laboratorio.valor1,
                Laboratorio.valor2,
                Laboratorio.valor3,
                Laboratorio.valor4,
                Laboratorio.valor5,
                Laboratorio.promedio,
                Laboratorio.cuadrado,
                Laboratorio.cubo,
                Laboratorio.XalaY,
                Laboratorio.factorial,
                Laboratorio.sucesion,
                Laboratorio.perfecto
                from Laboratorio;
        end $$
delimiter ;

call sp_LisatarDatos;

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

delimiter $$
	create function fn_Promedio(valor1 int, valor2 int, valor3 int, valor4 int, valor5 int) #drop function fn_Promedio
    returns decimal (10,2)
    reads sql data deterministic
		begin 
			declare resul decimal(10,2);
            declare suma decimal(10,2);
            set suma = (valor1 + valor2 + valor3 + valor4 + valor5);
            set resul = suma/5.00;
		return resul;
        end $$
delimiter ;

select fn_Promedio(1,2,3,5,10) as Promedio;

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_Cuadrado(valor int) #drop function fn_promedio
    returns int
    reads sql data deterministic
		begin
			declare resul int;
            set resul = valor * valor;
		return resul;
        end $$
delimiter ;

select fn_Cuadrado(10) as Cuadrado;

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_cubo(valor int) #drop function fn_cubo
    returns int
    reads sql data deterministic 
		begin 
			declare resul int;
            set resul = valor * valor * valor;
		return resul;
		end $$
delimiter ;

select fn_cubo(5) as Cubo;

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_XalaY(x int, y int)   #drop function fn_XalaY
    returns int
    reads sql data deterministic
		begin 
			declare result int default 1;
            declare cont int default 0;
				repeat
					set cont = cont + 1;
                    set result = result * x;
                until (cont = y)
                end repeat;
			return result;
		end $$
delimiter ;

select fn_XalaY(2,10) as Operacion;

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_factorial(valor4 int) #drop function fn_factorial
    returns int
	reads sql data deterministic 
		begin 
			declare result int default 1;
            declare contador int default 1;
				repeat 
					set result = result * valor4;
                    set valor4 = valor4 - contador; 
				until (valor4 = 0)
                end repeat;
			return result;
		end $$
delimiter ;

select fn_factorial(5) as Factorial;

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_Sucesion(num int) #drop function fn_Sucesion
    returns decimal(20,2)
    reads sql data deterministic 
		begin
			declare cont1 int default 0;
            declare cont2 int default 0;
            declare result1 decimal (20,2) default 0;
            declare result2 decimal (20,2) ;
            declare suma decimal (20,2) default 0;
				repeat 
					set cont1 = cont1 + 1;
                    set cont2 = 0;
                    set result2 = 1;
						repeat 
							set cont2 = cont2 +1;
                            set result2 = result2 * cont1;
						until(cont2 = cont1)
                        end repeat;
					set result1 = 1/result2;
                    set suma = suma + result1;
				until(cont1 = num)
                end repeat;
			return suma;
		end $$
delimiter ;

select fn_sucesion(10) as Sucesion;

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_Perfecto(num int) #drop function fn_Perfecto
    returns varchar(150)
    reads sql data deterministic 
		begin 
			declare factor int default 0;
            declare result int default 0;
            declare cont int default 1;
            declare mensaje varchar(150);
				repeat 
					set factor = num % cont;
					if factor = 0 then
						set result = result + cont;
					else
						set result = result +0;
					end if;
					set cont = cont +1;
				until (num = cont)
                end repeat;
			if result = num then
				set mensaje = 'Es perfecto';
			else 
				set mensaje = 'No es perfecto';
			end if;
		return mensaje;
	end $$
delimiter ;

select fn_Perfecto(3) as Perfecto;

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
create Procedure SP_AlmacenarDatos(cod int) #drop procedure SP_AlmacenarDatos
	begin
	update laboratorio
		set promedio = fn_promedio(laboratorio.valor1, laboratorio.valor2, laboratorio.valor3, laboratorio.valor4, laboratorio.valor5),
		cuadrado = fn_cuadrado(laboratorio.valor3),
		cubo = fn_cubo(laboratorio.valor2),
		XalaY = fn_XalaY(laboratorio.valor2, laboratorio.valor4),
		factorial = fn_factorial(laboratorio.valor4),
		sucesion = fn_sucesion(laboratorio.valor5),
	    perfecto = fn_perfecto(laboratorio.valor3)
        where(codigolaboratorio = cod);
	end $$
delimiter ;

call sp_AlmacenarDatos(1);