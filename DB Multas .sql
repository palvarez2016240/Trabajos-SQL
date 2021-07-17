create database DBEmetra2016240;

use DBEmetra2016240;

create table Vecinos(
	DPI bigint not null,
    nombres varchar(50) not null,
    apellidos varchar(50) not null,
    domicilio varchar(50) not null,
    sexo char not null,
    primary key PK_DPI (DPI)
);

create table Vehiculos(
	placa varchar(8) not null,
	marca varchar(25) not null,
    linea varchar(25) not null,
    modelo varchar(4) not null,
    color varchar(25) not null,
    VIN varchar(17) not null,
    DPI bigint not null,
    primary key PK_placa (placa),
    constraint FK_Vehiculos_Vecinos
		foreign key (DPI) references vecinos(DPI)
);

create table tipoMulta(
	id_tipoMulta int not null,
    nombre varchar(25) not null,
    primary key PK_id_tipoMulta (id_tipoMulta)
);

create table Municipalidad(
	id_municipalidad int not null,
    nombre varchar(25) not null,
    Municipio varchar(25) not null,
    primary key PK_id_municipalidad (id_municipalidad)
);

create table Policia(
	carne int not null,
    id_municipalidad int not null,
    nombres varchar(50) not null,
    apellidos varchar(50) not null,
    sueldo int not null,
    rango varchar(50) not null,
    primary key PK_carne (carne),
    constraint FK_Municipalidad_Policia
		foreign key (id_municipalidad) references municipalidad(id_municipalidad)
);

create table Multas(
	id_multa int not null,
    id_TipoMulta int not null,
    placa bigint not null,
    carne int not null,
    monto int not null,
    FechaHora datetime not null,
    primary key PK_id_multa (id_multa),
    constraint FK_tipomulta_Multas
		foreign key (id_TipoMulta) references tipomulta(id_TipoMulta),
	constraint FK_Vehiculos_Multas
		foreign key (placa) references Vehiculos(placa),
	constraint FK_Policia_Multas
		foreign key (carne) references Policia(carne)
);

--------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create procedure sp_AgregarVecino(
		in DPI bigint,
        in nombres varchar(50),
        in apellidos varchar(50),
        in domicilio varchar(50),
        in sexo char
        )
        Begin 
			Insert into Vecinos(DPI, nombres, apellidos, domicilio, sexo)
				values(DPI, nombres, apellidos, domicilio, sexo);
		End$$
delimiter ; 