drop database if exists DBConsultas;
create database DBConsultas; 

use DBConsultas;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create table Regiones ( 
	id_Regiones int auto_increment,
	Nombre varchar(30),
	primary key PK_Id_Regiones (Id_Regiones)
);

 create table Departamentos (
	id_Departamentos int auto_increment,
	Nombre varchar (30) not null,
    id_Regiones int not null,
    primary key PK_Id_Departamentos (Id_Departamentos),
    constraint FK_Departamentos_Regiones
	foreign key (id_Regiones) references Regiones(id_Regiones)
);

create table Oficinas ( 
	id_oficinas int auto_increment,
    nombre varchar(30),
	id_Departamentos int not null,
	primary key PK_Id_Oficinas (Id_Oficinas),
    constraint FK_Oficinas_Departamentos
	foreign key (id_Departamentos) references Departamentos(id_Departamentos)
);

create table Telefonos ( 
	id_telefonos int auto_increment,
	Numero int not null,
    id_Oficinas int not null,
	primary key PK_Id_Telefonos (Id_Telefonos),
    constraint FK_Telefonos_Oficinas
	foreign key (id_Oficinas) references Oficinas(id_Oficinas)
);

create table Empleados(
	DPI int auto_increment,
	nombre varchar (30) not null,
	Apellido varchar (30) not null,
	FechaNacimiento date not null,
    primary key PK_DPI (DPI)
 );

create table Categorias (
	id_Categorias int auto_increment,
	Nombre varchar (30) not null,
	salario int not null,
    primary key PK_Id_Categorias (Id_Categorias)
    );
    
create table Bonificaciones (
	id_bonificaciones int auto_increment,
	Cantidad int not null,
    CantidadEstado int not null,
    primary key PK_Id_Bonificaciones (Id_Bonificaciones)
);    

create table Informe (
	id_informe int auto_increment,
	DPI int not null,
	fechaContratacion date not null,
	id_Categorias int not null,
	id_bonificaciones int not null,
    id_oficinas int not null,
    primary key PK_Id_Informe (Id_Informe),
    constraint FK_Informe_Bonificaciones
	foreign key (id_bonificaciones) references Bonificaciones(id_bonificaciones),
    constraint FK_Informe_empleados
	foreign key (DPI) references empleados(DPI),
    constraint FK_Informe_Categorias
	foreign key (id_Categorias) references Categorias(id_Categorias),
    constraint FK_Informe_oficinas
	foreign key (id_oficinas) references oficinas(id_oficinas)
);
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create procedure sp_AgregarRegiones(in Nombre varchar(30))
		begin
			insert into Regiones(Nombre)
            values(Nombre);
		end$$
delimiter ;

delimiter $$
	create procedure sp_AgregarDepartamentos(in Nombre varchar(30), in Id_Regiones int)
		begin 
			insert into Departamentos(Nombre, Id_Regiones)
			values(Nombre, Id_Regiones);
		end$$
delimiter ;

delimiter $$
	create procedure sp_AgregarOficinas(in nombre varchar(30), in id_Departamentos int)
		begin
			insert into Oficinas(nombre, id_Departamentos)
            values(nombre, id_Departamentos);
		end$$
delimiter ;

delimiter $$
	create procedure sp_AgregarTelefonos(in Numero int, in id_Oficinas int)
		begin
			insert into Telefonos(Numero, id_Oficinas)
            values(Numero, id_Oficinas);
		end$$
delimiter ;

delimiter $$
	create procedure sp_AgregarEmpleados(in nombre varchar(30), in Apellido varchar(30), in FechaNacimiento date)
		begin 
			insert into Empleados(nombre, Apellido, FechaNacimiento)
			values(nombre, Apellido, FechaNacimiento);
		end$$
delimiter ;

delimiter $$ 
	create procedure sp_AgregarCategorias(in Nombre varchar(30), in salario int)
		begin 
			insert into Categorias(Nombre, salario)
			values(Nombre, salario);
		end$$
delimiter ;

delimiter $$
	create procedure sp_AgregarBonificaciones(in Cantidad int, in CantidadEstado int)
		begin 
			insert into Bonificaciones(Cantidad, CantidadEstado)
			values(Cantidad, CantidadEstado);
		end$$
delimiter ;

delimiter $$
	create procedure sp_AgregarInforme(in DPI int, in fechaContratacion date, in id_Categorias int, in id_bonificaciones int, in id_oficinas int)
		begin 
			insert into Informe(DPI, fechaContratacion, id_Categorias, id_bonificaciones, id_oficinas)
			values(DPI, fechaContratacion, id_Categorias, id_bonificaciones, id_oficinas);
		end$$
delimiter ;
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
call sp_AgregarRegiones ('Centro');
call sp_AgregarRegiones ('Metropolitana');
call sp_AgregarRegiones ('Norte');
call sp_AgregarRegiones ('Nororiente');
call sp_AgregarRegiones ('Suroriente');
call sp_AgregarRegiones ('Suroccidente');
call sp_AgregarRegiones ('Noroccidente');
call sp_AgregarRegiones ('Petén');

call sp_AgregarDepartamentos ('Petén', 8);
call sp_AgregarDepartamentos ('Izabal', 4);
call sp_AgregarDepartamentos ('Alta Verapaz', 3);
call sp_AgregarDepartamentos ('Quiché', 7);
call sp_AgregarDepartamentos ('Huehuetenango', 7);
call sp_AgregarDepartamentos ('Escuintla', 1);
call sp_AgregarDepartamentos ('San Marcos', 6);
call sp_AgregarDepartamentos ('Jutiapa', 5);
call sp_AgregarDepartamentos ('Baja Verapaz', 3);
call sp_AgregarDepartamentos ('Santa Rosa', 5);
call sp_AgregarDepartamentos ('Zacapa', 4);
call sp_AgregarDepartamentos ('Suchitepéquez', 6);
call sp_AgregarDepartamentos ('Chiquimula', 4);
call sp_AgregarDepartamentos ('Guatemala', 2);
call sp_AgregarDepartamentos ('Jalapa', 5);
call sp_AgregarDepartamentos ('Chimaltenango', 1);
call sp_AgregarDepartamentos ('Quetzaltenango', 6);
call sp_AgregarDepartamentos ('El Progreso', 4);
call sp_AgregarDepartamentos ('Retalhuleu', 6);
call sp_AgregarDepartamentos ('Sololá', 6);
call sp_AgregarDepartamentos ('Totonicapán', 6);
call sp_AgregarDepartamentos ('Sacatepéquez', 1);

call sp_AgregarOficinas ('Comerciales', 1);
call sp_AgregarOficinas ('Ventas', 1);
call sp_AgregarOficinas ('Informartica', 2);
call sp_AgregarOficinas ('Recursos Humanos', 3); 
call sp_AgregarOficinas ('Contabilidad', 4); 
call sp_AgregarOficinas ('Administracion', 5); 
call sp_AgregarOficinas ('Comerciales', 6); 
call sp_AgregarOficinas ('Ventas', 7); 
call sp_AgregarOficinas ('Informartica', 8); 
call sp_AgregarOficinas ('Recursos Humanos', 9); 
call sp_AgregarOficinas ('Administracion', 10);
call sp_AgregarOficinas ('Comerciales', 11);
call sp_AgregarOficinas ('Ventas', 12);
call sp_AgregarOficinas ('Informartica', 13);
call sp_AgregarOficinas ('Recursos Humanos', 14);
call sp_AgregarOficinas ('Administracion', 15);
call sp_AgregarOficinas ('Comerciales', 16);
call sp_AgregarOficinas ('Ventas', 17); 
call sp_AgregarOficinas ('Informartica', 18); 
call sp_AgregarOficinas ('Recursos Humanos', 19); 
call sp_AgregarOficinas ('Comerciales', 20); 
call sp_AgregarOficinas ('Ventas', 21); 
call sp_AgregarOficinas ('Informartica', 22); 

call sp_AgregarTelefonos (52548117, 1); 
call sp_AgregarTelefonos (55498751, 2);
call sp_AgregarTelefonos (52567451, 3);
call sp_AgregarTelefonos (50564987, 4);
call sp_AgregarTelefonos (50174178, 5);
call sp_AgregarTelefonos (59870156, 6);
call sp_AgregarTelefonos (58740897, 7);
call sp_AgregarTelefonos (58574089, 8);
call sp_AgregarTelefonos (56874897, 9);
call sp_AgregarTelefonos (58780789, 10);
call sp_AgregarTelefonos (55640897, 11);
call sp_AgregarTelefonos (58705648, 12);
call sp_AgregarTelefonos (55409876, 13);
call sp_AgregarTelefonos (58507078, 14);
call sp_AgregarTelefonos (54564089, 15);
call sp_AgregarTelefonos (55407884, 16);
call sp_AgregarTelefonos (55456078, 17);
call sp_AgregarTelefonos (55648048, 18);
call sp_AgregarTelefonos (55408786, 19);
call sp_AgregarTelefonos (55408786, 20);
call sp_AgregarTelefonos (57845135, 21);
call sp_AgregarTelefonos (50457656, 22);
call sp_AgregarTelefonos (50478548, 23);

call sp_AgregarEmpleados ('Jose', 'Perez', '1975/01/01');
call sp_AgregarEmpleados ('Luis', 'Rosales', '1972/02/02');
call sp_AgregarEmpleados ('Sofia', 'Castro', '1990/03/03');
call sp_AgregarEmpleados ('Glendy', 'Ajuchan', '1968/04/04');
call sp_AgregarEmpleados ('Jose', 'Flores','1974/05/05');
call sp_AgregarEmpleados ('Marcela', 'Santana','1975/06/06');
call sp_AgregarEmpleados ('Jose', 'Castillo','1995/08/07');
call sp_AgregarEmpleados ('Jose','Morales', '1990/09/08');
call sp_AgregarEmpleados ('Rafael,','Gonzalez', '1992/10/9');
call sp_AgregarEmpleados ('Ricardo', 'Fernandez','1988/11/10');
call sp_AgregarEmpleados ('Jose','Castro', '1977/12/11');
call sp_AgregarEmpleados ('Andrea', 'Stegen', '2000/01/12');
call sp_AgregarEmpleados ('Neto', 'Bran', '1990/02/13');
call sp_AgregarEmpleados ('Maria', 'Wague', '1980/03/14');
call sp_AgregarEmpleados ('Nelson', 'Semedo', '1970/04/15');
call sp_AgregarEmpleados ('Sarah', 'Robert', '1975/05/16');
call sp_AgregarEmpleados ('Gerrad', 'Pique', '1980/06/17');
call sp_AgregarEmpleados ('Sammy', 'Umtiti', '1985/07/18');
call sp_AgregarEmpleados ('Clement', 'Lenglet', '1990/08/19');
call sp_AgregarEmpleados ('Juana', 'Todibo', '1995/09/20');
call sp_AgregarEmpleados ('Jordi', 'Alba', '2000/10/21');
call sp_AgregarEmpleados ('Julia', 'Firpo', '1995/11/22');
call sp_AgregarEmpleados ('Carla', 'Aleña', '1990/12/23');
call sp_AgregarEmpleados ('Riqui', 'Puig', '1985/01/24');
call sp_AgregarEmpleados ('Francisca', 'De Jong', '1980/02/25');
call sp_AgregarEmpleados ('Sergio', 'Busquets', '1975/03/26');
call sp_AgregarEmpleados ('Ivanna', 'Rakitic', '1970/04/27');
call sp_AgregarEmpleados ('Arturo', 'Vidal', '1999/05/28');
call sp_AgregarEmpleados ('Any', 'Melo', '1998/06/29');
call sp_AgregarEmpleados ('Ousmann', 'Demebele', '1997/07/30');
call sp_AgregarEmpleados ('Lana', 'Messi', '1996/08/31');
call sp_AgregarEmpleados ('Lulu', 'Suarez', '1995/09/01');
call sp_AgregarEmpleados ('Antuan', 'Griezmann', '1994/10/02');
call sp_AgregarEmpleados ('Alison', 'Fati', '1993/11/03');
call sp_AgregarEmpleados ('Carles', 'Perez', '1992/12/04');
call sp_AgregarEmpleados ('Jose', 'Gea', '1991/01/05');
call sp_AgregarEmpleados ('Kenia', 'Bruyne', '1990/02/06');
call sp_AgregarEmpleados ('Sandra', 'Mane', '1989/03/07');
call sp_AgregarEmpleados ('Ngolo', 'Kante', '1988/04/08');
call sp_AgregarEmpleados ('Rafaela', 'Varane', '1987/05/09');
call sp_AgregarEmpleados ('Jose', 'Maradona', '1986/06/10');
call sp_AgregarEmpleados ('Xina', 'Hernandez', '1985/07/11');
call sp_AgregarEmpleados ('Alejandro', 'Arnold', '1984/08/12');
call sp_AgregarEmpleados ('Reyna', 'Nazario', '1983/09/13');
call sp_AgregarEmpleados ('Zinedin', 'Zidane', '1982/10/14');
call sp_AgregarEmpleados ('Cristina', 'Ronaldo', '1981/11/15');

call sp_AgregarCategorias ('Administrador', 30000);
call sp_AgregarCategorias ('Jefe de Seccion', 45000);
call sp_AgregarCategorias ('Supervisor', 40000);
call sp_AgregarCategorias ('Tecnico', 25000);
call sp_AgregarCategorias ('Empleado', 50000);

call sp_AgregarBonificaciones (2000, 250);
call sp_AgregarBonificaciones (4000, 250);
call sp_AgregarBonificaciones (3000, 250);
call sp_AgregarBonificaciones (1000, 250);
call sp_AgregarBonificaciones (5000, 250);

call sp_AgregarInforme (1, '2010/01/01', 1, 1, 1);
call sp_AgregarInforme (2, '2011/02/02', 2, 2, 1);
call sp_AgregarInforme (3, '2012/03/03', 3, 3, 2);
call sp_AgregarInforme (4, '2013/04/04', 4, 4, 2);
call sp_AgregarInforme (5, '2014/05/05', 5, 5, 3);
call sp_AgregarInforme (6, '2015/06/06', 1, 1, 3);
call sp_AgregarInforme (7, '2016/07/07', 2, 2, 4);
call sp_AgregarInforme (8, '2017/08/08', 3, 3, 4);
call sp_AgregarInforme (9, '2018/09/09', 4, 4, 5);
call sp_AgregarInforme (10, '2019/10/10', 5, 5, 5);
call sp_AgregarInforme (11, '2018/11/11', 1, 1, 6);
call sp_AgregarInforme (12, '2017/12/12', 2, 2, 6);
call sp_AgregarInforme (13, '2016/01/13', 3, 3, 7);
call sp_AgregarInforme (14, '2015/02/14', 4, 4, 7);
call sp_AgregarInforme (15, '2014/03/15', 5, 5, 8);
call sp_AgregarInforme (16, '2013/04/16', 1, 1, 8);
call sp_AgregarInforme (17, '2012/05/17', 2, 2, 9);
call sp_AgregarInforme (18, '2011/06/18', 3, 3, 9);
call sp_AgregarInforme (19, '2010/07/19', 4, 4, 10);
call sp_AgregarInforme (20, '2011/08/20', 5, 5, 10);
call sp_AgregarInforme (21, '2012/09/21', 1, 1, 11);
call sp_AgregarInforme (22, '2013/10/22', 2, 2, 11);
call sp_AgregarInforme (23, '2014/11/23', 3, 3, 12);
call sp_AgregarInforme (24, '2015/12/24', 4, 4, 12);
call sp_AgregarInforme (25, '2016/01/25', 5, 5, 13);
call sp_AgregarInforme (26, '2017/02/26', 1, 1, 13);
call sp_AgregarInforme (27, '2018/03/27', 2, 2, 14);
call sp_AgregarInforme (28, '2019/04/28', 3, 3, 14);
call sp_AgregarInforme (29, '2018/05/29', 4, 4, 15);
call sp_AgregarInforme (30, '2017/06/30', 5, 5, 15);
call sp_AgregarInforme (31, '2016/07/01', 1, 1, 16);
call sp_AgregarInforme (32, '2015/08/02', 2, 2, 16);
call sp_AgregarInforme (33, '2014/09/03', 3, 3, 17);
call sp_AgregarInforme (34, '2013/10/04', 4, 4, 17);
call sp_AgregarInforme (35, '2012/11/05', 5, 5, 18);
call sp_AgregarInforme (36, '2011/12/06', 1, 1, 18);
call sp_AgregarInforme (37, '2010/01/07', 2, 2, 19);
call sp_AgregarInforme (38, '2011/02/08', 3, 3, 19);
call sp_AgregarInforme (39, '2012/03/09', 4, 4, 20);
call sp_AgregarInforme (40, '2013/04/10', 5, 5, 20);
call sp_AgregarInforme (41, '2014/05/11', 1, 1, 21);
call sp_AgregarInforme (42, '2015/06/12', 2, 2, 21);
call sp_AgregarInforme (43, '2016/07/13', 3, 3, 22);
call sp_AgregarInforme (44, '2017/08/14', 4, 4, 22);
call sp_AgregarInforme (45, '2018/09/15', 5, 5, 23);
call sp_AgregarInforme (46, '2019/05/16', 1, 1, 23);
#-------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
    create function fn_Edad(fecha date)
    returns int
    reads sql data deterministic
    begin 
        declare actual int DEFAULT 0;
        set actual=year(fecha)-year(current_date());
        SET actual=actual*-1;
        if((month(fecha))>(month(current_date))) then
        set actual=actual-1;
        end if;
        return actual;
    end$$
delimiter ;

select fn_Edad('2002/10/29');


Delimiter $$
	create function fn_Porcentaje(numero int , contrato date)
    returns decimal (50,2)
    reads sql data deterministic 
    Begin 
		declare años int default 0;
        declare multi decimal(50,2) default 0 ;
        declare resultado decimal (50,2) default 0;
        declare suma decimal (50,2) default 0;
        set años = ( fn_Edad(contrato));
        set multi = numero * 0.02;
        set resultado = multi * años;
        set suma = numero + resultado;
        return suma;
    end $$
Delimiter ;

select fn_Porcentaje(35000, '2015/02/11');


 delimiter $$
    create function fn_Bonificacion(normal int, estado int) 
    returns int
    reads sql data deterministic 
        begin 
            declare resul int;
            set resul = normal + estado;
        return resul;
        end $$
delimiter ;

select fn_bonificacion(5000,250); 
#===============================CONSULTAS=======================================================================
	select max(fn_Edad(FechaNacimiento)) as Edad from empleados;
    select max(numero) from telefonos;
    select FechaNacimiento from empleados where FechaNacimiento < now();
    select FechaContratacion from informe where FechaContratacion < now();
    select * from empleados date;
	select monthname(fechaContratacion) as 'Nombre del mes' from informe;      
	select monthname(fechaNacimiento) as 'Nombre del mes' from empleados;     
	select concat(nombre, ' ', apellido) as 'Nombre Completo' from empleados;
    select concat(nombre, ' ', apellido) as 'Bonificaciones' from ;
#1------------------------------------------------------------------------------------
	select Nombre , fn_Edad(FechaNacimiento) as Edad from empleados;

#2------------------------------------------------------------------------------------
	select e.Nombre as Nombre,e.apellido as Apellido,c.nombre as Categoria, fn_Porcentaje(c.salario, i.fechaContratacion) as Sueldo from categorias c inner join informe i inner join empleados e on 
	c.id_categorias = i.id_categorias and e.DPI=i.DPI;

#3------------------------------------------------------------------------------------
	select e.nombre as Nombre, e.apellido as Apellido,i.fechaContratacion as Contratacion from informe i inner join empleados e 
	on i.DPI = e.DPI;

#4------------------------------------------------------------------------------------
	select Nombre, fn_Edad(FechaNacimiento) as Edad from empleados;

#5------------------------------------------------------------------------------------
	select fn_Edad(FechaNacimiento)as edad, count(fn_Edad(FechaNacimiento)) as cantidad 
	from empleados e  group by fn_Edad(FechaNacimiento);

#6------------------------------------------------------------------------------------
	select  floor(avg(fn_Edad(FechaNacimiento))) as 'Edad Media' from empleados;

#7------------------------------------------------------------------------------------------------
	select nombre as Categoria, salario as Salario from categorias
	where salario > 35000;

#8------------------------------------------------------------------------------------------------------------
	select Empleados.DPI,Empleados.nombre,Empleados.Apellido,Empleados.FechaNacimiento from empleados where DPI=5;

#9-------------------------------------------------------------------------------------------------------
	select e.nombre as Nombre,e.apellido as Apellido ,d.nombre as Departamento from empleados e inner join departamentos d inner join informe i inner join oficinas o
	on e.DPI=i.DPI and d.id_Departamentos=o.id_Departamentos and o.id_oficinas=i.id_oficinas; 

#10----------------------------------------------------------------------------------------------------------
	select e.nombre , e.apellido, i.fechaContratacion  from empleados e inner join informe i 
	on e.DPI = i.DPI  and i.fechaContratacion like '%2011%';

#11-------------------------------------------------------------------------------------------------------
	select e.nombre as Nombre, e.apellido as Apellido, c.nombre as Categoria, o.nombre as Oficina from empleados e inner join oficinas o inner join 
	informe i inner join categorias c on c.id_categorias = i.id_categorias and c.id_categorias = 1
	and o.nombre != 'Comerciales' 
	and e.dpi = i.dpi
	and o.id_oficinas = i.id_oficinas;
 
#12--------------------------------------------------------------------------------------------------------
	select e.nombre as Nombre, e.Apellido as Apellido, i.fechaContratacion as Fecha  from empleados e inner join informe i on
	 e.DPI=i.DPI and  i.fechaContratacion >= '2010/01/01' and  i.fechaContratacion <= '2012/01/01';
 
#13------------------------------------------------------------------------------------------------
	select nombre as Categoria, salario as Salario from categorias
	where salario < 35000 or salario > 40000;

#14--------------------------------------------------------------------------------------------------
	select e.nombre as Nombre, e.apellido as Apellido, c.nombre as Categoria from empleados e inner join categorias c inner Join informe i on c.nombre = 'Jefe de Seccion'
	and c.id_categorias = i.id_categorias
	and e.DPI = i.DPI;
 
#15-------------------------------------------------------------------
	select e.DPI,e.Nombre as Nombre, e.Apellido as Apellido from empleados e
	where e.Nombre='Jose';

#16--------------------------------------------------------------------------------------------------
	select e.nombre as Nombre, e.apellido as Apellido, c.nombre as Categoria, fn_Edad(FechaNacimiento) as Edad from empleados e 
	inner join categorias c inner join informe i on i.DPI = e.DPI and c.id_Categorias = i.id_Categorias 
	and c.id_Categorias = 1 and  fn_Edad(FechaNacimiento) >= 35;

#17-----------------------------------------------------------------------------------------------------
	SELECT  e.DPI ,e.nombre, e.Apellido, d.nombre
	FROM  departamentos d inner join oficinas o inner join empleados e inner join informe i
	on d.id_Departamentos=o.id_Departamentos and o.id_oficinas= i.id_oficinas and e.DPI=i.DPI and d.id_Departamentos!=1;

#18---------------------------------------------------------------------
	select nombre,fn_Edad(FechaNacimiento) as edad from empleados order by FechaNacimiento asc;

#19----------------------------------------------------------------------------
	select nombre , fn_Edad(FechaNacimiento) from empleados order by nombre desc;

#20-----------------------------------------------------------------------------------
	select e.nombre as Nombre, e.apellido as Apellido, c.nombre as Categoria from empleados e inner join categorias c inner join informe i on e.DPI = i.DPI
	and c.id_categorias = i.id_categorias;

#21--------------------------------------------------------------------------------------
	select o.id_oficinas as 'Codigo', t.numero, r.nombre as region, d.nombre as Departamento from oficinas o inner join telefonos t 
	inner join regiones r inner join departamentos d on o.id_Oficinas=t.id_Oficinas and o.id_Departamentos=d.id_Departamentos 
	and r.id_Regiones=d.id_Regiones and r.nombre like '%centro%';

#22---------------------------------------------------------------------------------------------
	select e.nombre as Nombre , d.nombre as Departamento from empleados e inner join departamentos d inner join oficinas o 
	inner join informe i on i.DPI = e.DPI and o.id_Departamentos = d.id_Departamentos and i.id_oficinas = o.id_oficinas;

#23----------------------------------------------------------------------------------------------------------------------
	select e.nombre as Nombre, e.apellido as Apellido, c.salario as Sueldo, fn_Bonificacion(b.cantidad, b.cantidadEstado) as Bonificacion from empleados e inner join
	categorias c inner join bonificaciones b inner join informe i on e.DPI = i.DPI 
	and c.id_categorias = i.id_categorias
	and b.id_bonificaciones = i.id_bonificaciones;

#24----------------------------------------------------------------------------------------------------


#25----------------------------------------------------------------------------------------------------------
	select sum(c.salario) as Sueldo from categorias c inner Join empleados e inner join informe i on e.dpi = i.dpi;

#26-------------------------------------------------------------------------
	select avg(salario) as 'Promedio de salario' from categorias;

#27-------------------------------------------------------------------------------------
	select max(salario + (b.Cantidad+b.CantidadEstado)) as 'Salario maximo', min(salario + (b.Cantidad+b.CantidadEstado)) as 'Salario minimo'
	from empleados e inner join categorias c inner join bonificaciones b inner join informe i
	on e.DPI = i.DPI and c.id_Categorias = i.id_Categorias and b.id_bonificaciones = i.id_bonificaciones;

#28---------------------------------------------------------------------------------------------
	select  count(fn_Edad(FechaNacimiento)) as cantidad from Empleados where fn_Edad(FechaNacimiento)>40;

#29-------------------------------------------------------------------------------------------------------------
	select count(distinct fn_Edad(FechaNacimiento)) as 'Edad diferenres' from empleados;

#30----------------------------------------------------------------------------------------------------------------
	select o.nombre as Oficina, sum(c.salario) as Salario from oficinas o inner join categorias c group by o.nombre;

