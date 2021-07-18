drop database if exists DBEjemploMaven;
create database DBEjemploMaven;
use DBEjemploMaven;

create table persona(
	codigoEmpresa int not null,
    nombreEmpresa varchar(150) not null,
    apellidoEmpresa varchar(150) not null,
    primary key PK_codigoEmpresa (codigoEmpresa)
);

select * from persona;

insert into persona (codigoEmpresa, nombreEmpresa, apellidoEmpresa)
	values (1, 'Pedro', 'Alvarez');
insert into persona (codigoEmpresa, nombreEmpresa, apellidoEmpresa)
	values (2, 'Luis', 'Gonzalez');
insert into persona (codigoEmpresa, nombreEmpresa, apellidoEmpresa)
	values (3, 'Sofia', 'Caladara');