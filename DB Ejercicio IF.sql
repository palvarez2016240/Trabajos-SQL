drop database if exists DBPruebas2016240;
create database DBPruebas2016240;

use DBPruebas2016240;

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_Sumar(valor1 int, valor2 int)
		returns int
        reads sql data deterministic
        Begin
			declare resp int;
            set resp = valor1 + valor2;
            return resp;
        End$$
delimiter $$

select fn_Sumar(7,5) as Resultado;

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	create function fn_mayor(x int, y int)
		returns varchar(50)
		reads sql data deterministic
        Begin 
			declare mensaje varchar(50);
            if (x > y) then
				set mensaje = 'El mayor es el primer valor';
			end if;
			if (x < y) then 
				set mensaje = 'El mayor es el segundo valor';
			end if;
		return mensaje;
	end $$
Delimiter ;

select fn_Mayor(9,5) as Mayor;

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	create function fn_mayor3(x int, y int, z int)
		returns varchar(50)
		reads sql data deterministic
        Begin 
			declare mensaje varchar(50);
				if (x > y) and (x > z) then
					set mensaje = 'El mayor es el primer valor';
				else 
					if (y > x) and (y > z) then
						set mensaje = 'El mayor es el segundo valor';
					else 
						if (z > y) and (z > x) then
							set mensaje = 'El mayor es el tercer valor';
						end if;     
					end if;
				end if;
		return mensaje;
	end $$
Delimiter ;

select fn_Mayor3(3,6,7) as 'Mayor de 3';

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	create function fn_mayorDe3(x int, y int, z int)
		returns varchar(50)
		reads sql data deterministic
        Begin 
			declare mensaje varchar(50);
				if (x > y) and (x > z) then
					set mensaje = concat(x, ' ','El mayor es el primer valor');
				else 
					if (y > x) and (y > z) then
						set  mensaje = concat(y, ' ', 'El mayor es el primer valor');
					else 
						if (z > y) and (z > x) then
							set mensaje = concat(z, ' ', 'El mayor es el primer valor');
						end if;     
					end if;
				end if;
		return mensaje;
	end $$
Delimiter ;

select fn_MayorDe3(3,6,7) as 'Mayor de 3';

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_mayorDeN(cantidad int)
    returns int
        reads sql data deterministic
        begin 
			declare valor int default 0;
            declare contador int default 0;
            declare mayor int default 0;
				repeat 
					set contador = contador + 1;
					 set valor = floor(rand()*100);
						if (valor > mayor) then
							set mayor = valor;
						else 
							if (valor < mayor) then
								set mayor = mayor;
                            end if;
						end if;
					until (cantidad = contador)
				end repeat;
		return mayor;
	end $$
delimiter ;

select fn_mayorDeN(8) as Mayor

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create  function fn_mayorDeN2(cantidad int)
    returns varchar(10000)
        reads sql data deterministic
        begin 
			declare valor int default 0;
            declare contador int default 0;
            declare mayor int default 0;
            declare completo varchar(10000);
            set completo = ' ';
				repeat 
					set contador = contador + 1;
					set valor = floor(rand()*100);
                    set completo = concat(completo, valor, ' , ' ); 
						if (valor > mayor) then
							set mayor = valor;
						end if;
					until (cantidad = contador)
				end repeat;
			set completo = concat(completo , 'El mayor es: ', mayor);
		return completo ;
	end $$
delimiter ;

select fn_mayorDeN2(8) as Mayor

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_Binario(num int)        
    returns varchar(1000)
		reads sql data deterministic 
        begin
			declare cont int default 0;
            declare bin varchar(256);
            set bin = "";
				repeat 
					set cont = num % 2;
					set bin = concat(cont, bin);
                    set num = num DIV 2;
				until (num = 0)
                end repeat;
		return bin ;
	end $$
delimiter ;

select fn_Binario(340) as Binario

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create function fn_Hexadecimal(num int)
    returns varchar(256)
		reads sql data deterministic 
        begin
			 declare hexa varchar(256) default '';
				repeat 
					case (num % 16)
						when 0 then 
							set hexa = concat('0', hexa);
						when 1 then 
							set hexa = concat('1', hexa);
						when 2 then 
							set hexa = concat('2', hexa);
						when 3 then 
							set hexa = concat('3', hexa);
						when 4 then 
							set hexa = concat('4', hexa);
						when 5 then 
							set hexa = concat('5', hexa);
						when 6 then 
							set hexa = concat('6', hexa);
						when 7 then 
							set hexa = concat('7', hexa);
						when 8 then 
							set hexa = concat('8', hexa);
						when 9 then 
							set hexa = concat('9', hexa);
						when 10 then 
							set hexa = concat('A', hexa);
						when 11 then 
							set hexa = concat('B', hexa);
						when 12 then 
							set hexa = concat('C', hexa);
						when 13 then 
							set hexa = concat('D', hexa);
						when 14 then 
							set hexa = concat('E', hexa);
						when 15 then 
							set hexa = concat('F', hexa);
					end case;
                    set num = num div 16;
				until (num = 0)
			end repeat;
        return hexa;
	end $$
delimiter ;

select fn_Hexadecimal(340) as Hexadecimal