Drop database if exists DBEmpresa2016240;
create database DBEmpresa2016240;

use DBEmpresa2016240;
#----------------------------------------------------Creacion de Entidades-------------------------------------------------------------------------------------------------------------------
create table Departamentos(
	codigoDepartamento int not null,
    nombreDepartamento varchar(100),
    primary key PK_codigoDepartamento (codigoDepartamento)
);

create table Empleados(
	codigoEmpleado int not null auto_increment,
    nombreEmpleado varchar (256) not null,
    codigoDepartamento int,
    primary key PK_codigoEmpleado (codigoEmpleado)
);
#---------------------------------------------------------------Entidad Departamentos-------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	create procedure sp_AgregarDepartamento(
    in codigoDepartamento int, in nombreDepartamento varchar(100)
    )
    begin
		insert into Departamentos(codigoDepartamento, nombreDepartamento) values (codigoDepartamento, nombreDepartamento);
    end$$
delimiter ;

delimiter $$
	create  procedure sp_ListarDepartamentos()
    begin
		select Departamentos.codigoDepartamento, Departamentos.nombreDepartamento from departamentos;
    end $$
delimiter ;

call sp_AgregarDepartamento (6969, 'Secretario');
call sp_AgregarDepartamento (1030, 'Informatica');
call sp_AgregarDepartamento (1040, 'Contabilidad');
call sp_AgregarDepartamento (1224, 'Servicios');
call sp_AgregarDepartamento (1020, null);

call sp_ListarDepartamentos;

#----------------------------------------------------Entidad Empleados-------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	create procedure sp_AgregarEmpleados(
		in nombreEmpleado varchar(256), in codigoDepartamento int
    )
    begin 
		insert into Empleados(nombreEmpleado, codigoDepartamento) values (nombreEmpleado, codigoDepartamento);
	end$$
delimiter ;

delimiter $$
	create procedure sp_ListarEmpleados()
    begin
		select Empleados.nombreEmpleado, Empleados.codigoDepartamento from empleados;
    end $$
delimiter ;


call sp_AgregarEmpleados ('Pedro',1030);
call sp_AgregarEmpleados ('Luis',6969);
call sp_AgregarEmpleados ('Ana',1040);
call sp_AgregarEmpleados ('Elettra', null);
call sp_AgregarEmpleados ('Juan',1224);
call sp_AgregarEmpleados ('Laura',1020);


call sp_ListarEmpleados;


#----------------------------------INNER JOIN----------------------------------------------------------------------------------------------------------------------------------------------------
Select * from Empleados E INNER JOIN Departamentos D 
	on E.codigoDepartamento = D.codigoDepartamento;
    
#--------------------------------------------------------------------------------LEFT JOIN -------------------------------------------------------------------------------------------------------------    
select* from Empleados E left join Departamentos D
	on E.codigoDepartamento = D.codigoDepartamento;
    
#--------------------------------------------------------------------------------RIGTHJOIN -------------------------------------------------------------------------------------------------------------    
select* from Empleados E right join Departamentos D
	on E.codigoDepartamento = D.codigoDepartamento;    
    
#--------------------------------------------------------------------------------Cross JOIN -------------------------------------------------------------------------------------------------------------    
select* from Empleados E cross join Departamentos D
	on E.codigoDepartamento = D.codigoDepartamento;