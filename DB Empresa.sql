
create database db_Empresa
use db_Empresa

drop database db_Empresa

delimiter $$
create procedure TablaOficinas()
begin
create table Oficinas (cod_oficina int auto_increment primary key,
telefono int,
Region varchar (30));
end $$
delimiter ;

delimiter $$
create procedure TablaSalarios()
begin
create table Salarios (cod_salario int auto_increment primary key,
cantidad int);
end $$
delimiter ; 

delimiter $$
create procedure TablaCategorias()
begin
create table Categorias (cod_Categoria int auto_increment primary key,
Nombre varchar (30),
 salario int,
 foreign key (salario) references Salarios(cod_salario));
end $$
delimiter ;

delimiter $$
create procedure TablaBonificaciones()
begin
create table Bonificaciones (cod_bonificacion int auto_increment primary key,
Nombre varchar (30),
Cantidad int);
end $$
delimiter ;

delimiter $$
create procedure TablaEmpleados()
begin 
create table Empleados(id_empleado int auto_increment primary key,
nombre varchar (20),
Apellido varchar (30),
 Edad int);
end $$
delimiter ;



delimiter $$
create procedure TablaDepartamentos()
begin
create table Departamentos (cod_Departamento int auto_increment primary key,
Nombre varchar (30),
Oficina int,
foreign key (Oficina) references Oficinas(cod_oficina));
end $$
delimiter ; 


delimiter $$
create procedure TablaInforme()
begin
create table Informe (cod_informe int auto_increment primary key,
Empleado int,
fecha date,
departamento int,
categoria int,
bonificacion int,
foreign key (bonificacion) references Bonificaciones(cod_bonificacion),
foreign key (Empleado) references empleados(id_empleado),
foreign key (departamento) references Departamentos(cod_Departamento),
foreign key (categoria) references Categorias(cod_Categoria));
end $$
delimiter ;

call TablaSalarios;
Call TablaCategorias;
call TablaOficinas;
call TablaBonificaciones;
call TablaDepartamentos;
call TablaEmpleados;
call TablaInforme;

delimiter $$
create procedure  ingresoSalarios(
in cantidad int)
begin 
insert into Salarios (cantidad) values (cantidad);
end $$ 
delimiter ;

delimiter $$
create procedure  ingresoEmpleados(
in nombre varchar(20),
in Apellido varchar(30),
in Edad int)
begin 
insert into empleados (nombre, Apellido, Edad) values (nombre, Apellido, Edad);
end $$ 
delimiter ;

delimiter $$
create procedure  ingresoCategorias(
in Nombre varchar(20),
in salario int)
begin 
insert into categorias (Nombre, salario) values (Nombre, salario);
end $$ 
delimiter ;

delimiter $$
create procedure  ingresoBonificaciones(
in Nombre varchar(20),
in Cantidad int)
begin 
insert into bonificaciones (Nombre, Cantidad) values (Nombre, Cantidad);
end $$ 
delimiter ;

delimiter $$
create procedure  ingresoDepartamentos(
in Nombre varchar(20),
in Oficina int)
begin 
insert into departamentos (Nombre, Oficina) values (Nombre, Oficina);
end $$ 
delimiter ;

delimiter $$
create procedure  ingresoOficinas(
in telefono int,
in Region varchar (30))
begin 
insert into Oficinas (telefono, Region) values (telefono, Region);
end $$ 
delimiter ;


delimiter $$
create procedure  ingresoInformes(
in Empleado int,
in fecha date,
in departamento int,
in categoria int,
in bonificacion int)
begin 
insert into informe (Empleado, fecha, departamento, bonificacion) values (Empleado, fecha, departamento, bonificacion);
end $$ 
delimiter ;


call ingresoOficinas(51236487, "Centro");
call ingresoOficinas(78945632, "Occidente");
call ingresoOficinas(57325632, "Sur");


call ingresoSalarios(88000);
call ingresoSalarios(113000);
call ingresoSalarios(30000);
call ingresoSalarios(40000);
call ingresoSalarios(50000);

call ingresoDepartamentos("Financiero", 1);
call ingresoDepartamentos("Administrativo", 2);
call ingresoDepartamentos("Recursos humanos", 3);

call ingresoCategorias("Jefe", 2);
call ingresoCategorias("Empleado", 3);
call ingresoCategorias("Gerente", 1);
call ingresoCategorias("Gerente", 5);
call ingresoCategorias("Empleado", 4);

call ingresoBonificaciones("horas extra", 500);
call ingresoBonificaciones("Aguinaldo", 2000);
call ingresoBonificaciones("Bono 14", 3000);
call ingresoBonificaciones("Bono 14", 5000);
call ingresoBonificaciones("horas extra", 700);

call ingresoEmpleados("Jose", "Batres", 40);
call ingresoEmpleados("Alejandro", "Carrillo", 25);
call ingresoEmpleados("Marcos", "Bonifasi", 25);
call ingresoEmpleados("Javier", "Dubon", 27);
call ingresoEmpleados("Jairo", "Corona", 30);

call ingresoInformes(1,'2000-12-25', 2, 1, 4);
call ingresoInformes(2,'2017-05-18', 3, 2, 5);
call ingresoInformes(3,'2015-04-22', 1, 4, 1);
call ingresoInformes(4,'2013-07-08', 3, 5, 3);
call ingresoInformes(5,'2012-08-09', 2, 3, 2);


#***************************************************consultas***********************************************
select nombre, edad from empleados;

select e.nombre, i.fecha from informe i, empleados e where i.empleado=e.id_empleado;

Select edad from empleados;

select count(*) as misma_edad from empleados where edad like 25;

select avg(edad) as edad_media from empleados;

select c.nombre, s.cantidad from categorias c, salarios s where s.cantidad>35000 and c.salario=s.cod_salario;


