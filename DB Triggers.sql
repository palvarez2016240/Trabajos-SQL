drop database if exists DBEjemplo2Trigger2016240;
create database DBEjemplo2Trigger2016240; 

use DBEjemplo2Trigger2016240;
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create TABLE Usuarios(
	id_Usuario int auto_increment not null,
    Nombres varchar(50),
    primary key PK_id_Usuario(id_Usuario)
);

create table ControlUsuario(
	id_ControlUsuario int auto_increment not null,
    id_Registro int,
    NombreAntiguo varchar(50),
    NombreNuevo varchar(50),
    Usuario varchar (100),
    Modificacion datetime,
    primary Key PK_id_ControlUsuario(id_ControlUsuario)
);
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	create procedure sp_AgregarUsuario(in nombre varchar(50))
		Begin 
			insert into Usuarios(nombres)
				values (nombres);
		end$$
Delimiter ;

Delimiter $$
	create procedure sp_EditarUsuario(in id_Usua int, in nom varchar(50))
		Begin 
			update Usuarios set
				nombres = nom
                where id_usuario = id_Usua;
        end$$
delimiter ;
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*  
	Crear un trigger donde se usara una variable
	global con el nombre antiguo antes de
    ejecutar un update y otra con ek nombre
    nuevo que ejecutara el update
*/

Delimiter $$
	Create Trigger tr_Usuarios
		before update on Usuarios
		for each row
		begin 
			set @nombreAntiguo = OLD.nombres;
            set @nombreNuevo = NEW.nombres;
		end $$
delimiter ;

delimiter $$
	create trigger tr_Usuarios_Before_Insert 
		before insert on Usuarios
        for each row
		begin
			set @activacion = 'Trigger activado!!!';
            set New.nombres = 'HACKING YOUR NAME JOJOJOJOJ'; 
        end$$
delimiter ;

delimiter $$
	create trigger tr_ControlUsario_After_Update
		after update on Usuarios
        for each row
        Begin 
			Insert intO ControlUsuario(id_Registro, NombreAntiguo, NombreNuevo, Usuario, Modificacion)
				values (old.id_Usuario, OLD.nombres, New.nombres, current_user(), now());
        end $$
delimiter ;
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
call sp_AgregarUsuario ('Pedro Alvarez');
select * from Usuarios;

call sp_EditarUsuario(1, 'Pedro Alvarez');
select * from ControlUsuario;
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select @nombreAntiguo;
select @nombreNuevo;