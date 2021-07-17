Drop database if exists dbinmuebles2016240;
Create database DBInmuebles2016240;

Use dbinmuebles2016240;

create table Contrato(
	codigoContrato int not null auto_increment,
    folio varchar (10) not null,
    tipoContrato varchar(75) not null, 
    monto decimal (10,2) not null,
    primary key PK_codigoContrato (codigoContrato)
);

create table Direccion(
	codigoDireccion int not null auto_increment,
    departamento varchar(20) not null,
    municipio varchar(20) not null,
    domicilio varchar(10) not null,
    colonia varchar(25),
    codigoContrato int not null,
    primary key PK_codigoDireccion(codigoDireccion),
    constraint FK_Direccion_Contrato
		foreign key (codigoContrato) references Contrato(codigoContrato)
);

create table Persona(
	codigoPersona int not null auto_increment,
    nombres varchar(50) not null, 
    apellidos varchar(50) not null,
    codigoDireccion int not null,
    codigoContrato int not null,
    primary key PK_codigoPersona (codigoPersona),
    constraint FK_Persona_Direccion
		foreign key (codigoDireccion) references Direccion (codigoDireccion),
	constraint FK_Persona_Contrato
		foreign key (codigoContrato) references Contrato (codigoContrato)
);

 delimiter $$
	create procedure sp_AgregarContrato(
		folio varchar(10),
		tipoContrato varchar(75),
		monto decimal(10,2)
	)
	begin
		INSERT into Contrato(folio, tipoContrato, monto) values (folio, tipoContrato, monto);
	end$$
 delimiter ;

  call sp_AgregarContrato("az10","Arrendamiento de vivienda para residencia habitual.",5641.51);
  call sp_AgregarContrato("sd20","Arrendamiento de temporada.",8000.00);
  call sp_AgregarContrato("nk30","Arrendamiento de uso turístico.",951.99);
  call sp_AgregarContrato("pl40","Arrendamiento de vivienda para residencia habitual.",6584.00);
  call sp_AgregarContrato("uj50","Arrendamiento de temporada.",3000.70);
  call sp_AgregarContrato("az60","Arrendamiento de vivienda para residencia habitual.",5500.50);
  call sp_AgregarContrato("sd70","Arrendamiento de temporada.",10000.25);
  call sp_AgregarContrato("nk80","Arrendamiento de uso turístico.",5481.75);
  call sp_AgregarContrato("pl90","Arrendamiento de vivienda para residencia habitual.",1645.00);
  call sp_AgregarContrato("uj100","Arrendamiento de temporada.",7810.00);

 
delimiter $$
	create procedure sp_AgregarDireccion(
		departamento varchar(20) ,
		municipio varchar(20) ,
		domicilio varchar(10) ,
		colonia varchar(20),
		codigoContrato int
	)
 begin
  insert into Direccion(departamento, municipio, domicilio, colonia, codigoContrato) 
	values (departamento, municipio, domicilio, colonia, codigoContrato);
 end$$
delimiter ;
 
 call sp_AgregarDireccion("Guatemala","Villa Canales","Zona 9","El zapote",1);
 call sp_AgregarDireccion("Peten","Flores","Zona 11","El Carmen",2);
 call sp_AgregarDireccion("Escuintla","San Jose","Zona 14","hermita",3);
 call sp_AgregarDireccion("Zacapa","","apa.50 pi2","null",4);
 call sp_AgregarDireccion("Chimaltenango","Patzun","6av. 1-300","Santa Clara",5);
 call sp_AgregarDireccion("Chimaltenango","Zaragosa","1-45 zona5 ","null",6);
 call sp_AgregarDireccion("chiquimula","Ipala","6-20 5ta ","La bonita",7);
 call sp_AgregarDireccion("Peten","Flores","ap. 60","null",8);
 call sp_AgregarDireccion("Guatemala","Guatemala","0av. zona7","1ro de Julio",9);
 call sp_AgregarDireccion("Izabal","Morales","ap.200","null",10);

 delimiter $$
 create procedure sp_AgregarPersona(
 	nombre varchar(50) ,
    apellidos varchar(50) ,
    codigoDireccion int ,
    codigoContrato int 
 )
 begin
  insert into Persona(nombre, apellidos, codigoDireccion, codigoContrato) 
  values (nombre, apellidos, codigoDireccion, codigoContrato);
 end$$
 
delimiter ;
 
 call sp_AgregarPersona("Andres Sebstian","Hernandez Perez",1,10);
 call sp_AgregarPersona("Ricardo Miguel","Romero Asturias",2,9);
 call sp_AgregarPersona("Jeshua Juan Pablo","Geronimo Cajbon",3,8);
 call sp_AgregarPersona("Rudy Alexander","solloy Jeronimo",4,7);
 call sp_AgregarPersona("Carolina Anna","Larrazabal Sula",5,6);
 call sp_AgregarPersona("Adrian Alejandro","Xicaj Joj",6,5);
 call sp_AgregarPersona("Sebastian Antonio","Perez Lopez",7,4);
 call sp_AgregarPersona("Lilian Amarilis","Zapeta Asturias",8,3);
 call sp_AgregarPersona("Carmen Adriana","Lopez Castillo",9,2);
 call sp_AgregarPersona("Antonio Miguel","Perez Perez",10,1);
  
  
delimiter $$
	create  procedure sp_ListarDepartamentos()
    begin
		select Departamentos.codigoDepartamento, Departamentos.nombreDepartamento from departamentos;
    end $$
delimiter ;