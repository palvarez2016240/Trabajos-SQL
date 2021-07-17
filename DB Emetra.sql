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
    VIN varchar(17) not null, 
	placa varchar(8) not null,
	marca varchar(25) not null,
    linea varchar(25) not null,
    modelo varchar(4) not null,
    color varchar(25) not null,
    DPI bigint not null,
    primary key PK_VIN (VIN),
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
		foreign key (VIN) references Vehiculos(VIN),
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

delimiter $$
	create procedure sp_AgregarVehiculos(
        in VIN int, 	
		in placa varchar(50),
        in marca varchar(50),
        in linea varchar(50),
        in modelo int,
        in color varchar(50),
		in DPI bigint
        )
        Begin 
			Insert into Vehiculos(VIN, placa, marca, linea, modelo, color, DPI)
				values(VIN, placa, marca, linea, modelo, color, DPI);
		End$$
delimiter ; 

delimiter $$
	create procedure sp_AgregarTipoMulta(
		in id_tipoMulta int,
        in nombre varchar(50)
        )
        Begin 
			Insert into tipoMulta(id_tipoMulta, nombre)
				values(id_tipoMulta, nombre);
		End$$
delimiter ; 

delimiter $$
	create procedure sp_AgregarMunicipalidad(
		in id_municipalidad int,
        in nombre varchar(50),
		in municipio varchar(50)
        )
        Begin 
			Insert into municipalidad(id_municipalidad, nombre, municipio)
				values(id_municipalidad, nombre, municipio);
		End$$
delimiter ; 

delimiter $$
	create procedure sp_AgregarPolicia(
		in carne int,
		in municipalidad int,
		in nombres varchar(50),
        in apellidos varchar(50),
		in sueldo int,
		in rango varchar(50)
        )
        Begin 
			Insert into Policia(carne, municipalidad, nombres, apellidos, sueldo, rango)
				values(carne, municipalidad, nombres, apellidos, sueldo, rango);
		End$$
delimiter ; 

delimiter $$
	create procedure sp_AgregarMulta(
		in id_multa int,
        in id_tipoMulta int, 
		in VIN int,
		in carne int,
		in monto int,
		in fechaHora datetime,
        )
        Begin 
			Insert into Multa(id_multa, id_tipoMulta, VIN, carne, monto, fechaHora)
				values(id_multa, id_tipoMulta, VIN, carne, monto, fechaHora);
		End$$
delimiter ; 

--------------------------------------------------------------------------------------------------------------------------------------------------------

#Procedimientos almacenados 

    #Entidad Vecinos
	    #Insertar
		    delimiter $$
               create procedure DB2016240.sp_IngresarVecino(in DPI_ int, in nombres_ varchar(50), in apellidos_ varchar(50), in domicilio_ varchar(50), in sexo_ char)
	           begin
		       insert into Vecinos(DPI, nombres, apellidos, domicilio, sexo) values(DPI_, nombres_, apellidos_, domicilio_, sexo_);
               end $$
            delimiter ;
			
        #Eliminar
            delimiter $$
                create procedure DB2016240.sp_EliminarVecino(in DPI_ int)
	            begin
		        delete from vecinos where DPI = DPI_;
                end $$
            delimiter ;
		
        #BUSCAR
            delimiter $$
                create procedure DB2016240.sp_BuscarVecino(in DPI_ int)
	            begin 
		        select * from vecinos where DPI = DPI_;
                end $$
            delimiter ; 		
			
		#MODIFICAR
            delimiter $$
                create procedure DB2016240.sp_ModificarVecino(in DPI_ int,in nombres_ varchar(50), in apellidos_ varchar(50), in domicilio_ varchar(50), in sexo_ char)
	            begin
		        update Vecinos set nombre = nombres_, apellidos = apellidos_, domicilio = domicilio_, sexo = sexo_
			    where DPI = DPI_;
                end $$
            delimiter ;	
			
		#LISTAR
            delimiter $$
                create procedure DB2016240.sp_ListarVecino()
	            begin
		        select v.DPI, v.nombres, v.apellidos, v.domicilio, v.sexo
			    from Vecinos;
                end $$
            delimiter ;	
			
			
	#Entidad Vehiculos		
	    #Insertar
		    delimiter $$
               create procedure DB2016240.sp_IngresarVehiculo(in VIN_ int, in placa_ varchar(50), in linea_ varchar(50), in modelo_ int, in color_ int, in DPI int)
	           begin
		       insert into Vehiculos(VIN, placa, marca, linea, modelo, color, DPI) values(VIN_, placa_, marca_, linea_, modelo_, color_, DPI_);
               end $$
            delimiter ; 
			
		#Eliminar
            delimiter $$
                create procedure DB2016240.sp_EliminarVehiculo(in VIN_ int)
	            begin
		        delete from Vehiculos where VIN = VIN_;
                end $$
            delimiter ;	
		
		#BUSCAR
            delimiter $$
                create procedure DB2016240.sp_BuscarVehiculo(in VIN_ int)
	            begin 
		        select * from vecinos where VIN = VIN_;
                end $$
            delimiter ; 
		
		#MODIFICAR
            delimiter $$
                create procedure DB2016240.sp_ModificarVehiculo(in VIN_ int, in placa_ varchar(50), in linea_ varchar(50), in modelo_ int, in color_ int, in DPI int)
	            begin
		        update Vehiculos set VIN = VIN_, placa = placa_, marca = marca_, linea = linea_, modelo = modelo_, color = color_, DPI = DPI_
			    where VIN = VIN_;
                end $$
            delimiter ;	
			
		#LISTAR
            delimiter $$
                create procedure DB2016240.sp_ListarVehiculo()
	            begin
		        select h.VIN, h.placa, h.marca, h.linea, h.modelo, h.color, h.DPI
			    from Vehiculos;
                end $$
            delimiter ;	
	
    #Entidad tipoMulta
        #Insertar
		    delimiter $$
               create procedure DB2016240.sp_IngresarTipoMulta(in id_tipoMulta_ int, in nombres_ varchar(50))
	           begin
		       insert into tipoMulta(id_tipoMulta, nombres) values(id_tipoMulta_, nombres_);
               end $$
            delimiter ;	
			
		#Eliminar
            delimiter $$
                create procedure DB2016240.sp_EliminarTipoMulta(in id_tipoMulta_ int)
	            begin
		        delete from tipoMulta where id_tipoMulta = id_tipoMulta_;
                end $$
            delimiter ;
		
		#BUSCAR
            delimiter $$
                create procedure DB2016240.sp_BuscarTipoMulta(in id_tipoMulta_ int)
	            begin 
		        select * from tipomulta where id_tipoMulta = id_tipoMulta_;
                end $$
            delimiter ; 
			
		#MODIFICAR
            delimiter $$
                create procedure DB2016240.sp_ModificarTipoMulta(in id_tipoMulta_ int, in nombres_ varchar(50))
	            begin
		        update tipoMulta set id_tipoMulta = id_tipoMulta_, nombres = nombres_
			    where id_tipoMulta = id_tipoMulta_;
                end $$
            delimiter ;	
			
        #LISTAR
            delimiter $$
                create procedure DB2016240.sp_ListarTipoMulta()
	            begin
		        select v.id_tipoMulta, v.nombres
			    from tipoMulta;
                end $$
            delimiter ;
	

	#Entidad Municipalidad
	    #Insertar
		    delimiter $$
               create procedure DB2016240.sp_IngresarMunicipalidad(in id_municipalidad_ int, in nombre_ varchar(50), in municipio_ varchar (50))
	           begin
		       insert into municipalidad(id_municipalidad, nombre, municipio) values(id_municipalidad_, nombre_, municipio_);
               end $$
            delimiter ;	
		
		#Eliminar
            delimiter $$
                create procedure DB2016240.sp_EliminarMunicipalidad(in id_municipalidad_ int)
	            begin
		        delete from municipalidad where id_municipalidad = id_municipalidad_;
                end $$
            delimiter ;
			
		#BUSCAR
            delimiter $$
                create procedure DB2016240.sp_BuscarMunicipalidad(in id_municipalidad_ int)
	            begin 
		        select * from municipalidad where id_municipalidad = id_municipalidad_;
                end $$
            delimiter ;	
			
		#MODIFICAR
            delimiter $$
                create procedure DB2016240.sp_ModificarMunicipalidad(in id_municipalidad_ int, in nombre_ varchar(50), in municipio_ varchar (50))
	            begin
		        update municipalidad set id_municipalidad = id_municipalidad_, nombre = nombre_, municipio = municipio_
			    where id_municipalidad = id_municipalidad_;
                end $$
            delimiter ;		
			
		#LISTAR
            delimiter $$
                create procedure DB2016240.sp_ListarMunicipalidad()
	            begin
		        select m.id_municipalidad, m.nombre, m.municipio
			    from municipalidad;
                end $$
            delimiter ;
		
		
	#Entidad Policia
         #Insertar
		    delimiter $$
               create procedure DB2016240.sp_IngresarMunicipalidad(in id_municipalidad_ int, in nombre_ varchar(50), in municipio_ varchar (50))
	           begin
		       insert into municipalidad(id_municipalidad, nombre, municipio) values(id_municipalidad_, nombre_, municipio_);
               end $$
            delimiter ;		