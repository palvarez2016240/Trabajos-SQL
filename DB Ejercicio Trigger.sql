-- Actualizacion de STOCK
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Drop database if exists dbcontrolventas2016240;
create database dbcontrolventas2016240;

Use dbcontrolventas2016240;
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Create table Productos(
	id_Producto int auto_increment not null,
    NombreProducto varchar (50) not null,
    Existencia int not null,
    precioUnitario decimal (10,2) default 0.00,
    precioDocena decimal (10,2) default 0.00,
    precioMayor decimal (10,2) default 0.00,
    primary key PK_id_Producto(id_Producto)
);

create table Ventas(
	id_Ventas int auto_increment not null,
    fechaVenta date not null,
    primary key  PK_id_Ventas (id_Ventas)
);

create table DetalleVenta(
	id_DetalleVenta int auto_increment not null,
    id_Ventas int not null,
    id_Producto int not null,
    CantidadVender int not null,
    totalVenta decimal (10,2) default 0.00,
    primary key PK_id_DetalleVenta (id_DetalleVenta),
    constraint FK_DetalleVenta_Ventas foreign key (id_Ventas) references Ventas(id_Ventas),
    constraint FK_DetalleVenta_Productos foreign key (id_Producto) references Productos(id_Producto)
);

create table Compra(
	id_compra int auto_increment not null,
    fechaCompra date not null,
    primary key PK_id_compra (id_Compra)
);

create table DetalleCompra(
	id_detalleCompra int auto_increment not null,
    cantidadCompra int not null,
    totalCompra decimal (10,2) not null,
    id_Producto int not null,
    id_compra int not null,
    primary key PK_id_detalleCompra (id_detalleCompra),
    constraint FK_DetalleCompra_Productos foreign key (id_producto) references Productos (id_Producto),
    constraint FK_DetalleCompra_Compra foreign key (id_producto) references compra (id_compra)
);
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $$
	create procedure sp_AgregarProductos(in nombreProducto varchar(50), in Existencia int, in PrecioUnitario decimal (10,2), in precioDocena decimal (10,2), in precioMayor decimal (10,2))
		begin
			insert into Productos(nombreProducto, Existencia, PrecioUnitario, precioDocena, precioMayor)
            values(nombreProducto, Existencia, PrecioUnitario, precioDocena, precioMayor);
		end$$
delimiter ;

delimiter $$
	create procedure sp_AgregarVentas(in fechaVenta date)
		begin
			insert into Ventas(fechaVenta)
            values(fechaVenta);
		end$$
delimiter ;

delimiter $$
	create procedure sp_AgregarDetalleVenta(in id_ventas int, in id_producto int, in cantidadVender int, in totalVenta decimal (10,2))
		begin
			insert into DetalleVenta(id_ventas, id_producto, cantidadVender, totalVenta)
            values(id_ventas, id_producto, cantidadVender, totalVenta);
		end$$
delimiter ;

delimiter $$
	create procedure sp_AgregarCompra(in fechaCompra date)
		begin
			insert into Compra(fechaCompra)
            values(fechaCompra);
		end$$
delimiter ;

delimiter $$                                                          
	create procedure sp_AgregarDetalleCompra(in cantidadCompra int, in totalCompra decimal (10,2), in id_producto int, in id_compra int)
		begin
			insert into DetalleCompra(cantidadCompra, totalCompra, id_producto, id_compra)
            values(cantidadCompra, totalCompra, id_producto, id_compra);
		end$$
delimiter ;
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
call sp_AgregarProductos ('Televisore 65 Curve LG', 10, 0.00, 0.00, 0.00);
call sp_AgregarProductos ('Laptop Alienware i9', 5, 0.00, 0.00, 0.00);
call sp_AgregarProductos ('Lavadores Mabe', 20, 0.00, 0.00, 0.00);
call sp_AgregarProductos ('Equipo de Sonido  AIWA', 10, 0.00, 0.00, 0.00);
call sp_AgregarProductos ('WALKMAN Sony AntiShok', 12, 0.00, 0.00, 0.00);

call sp_AgregarVentas (now());
call sp_AgregarVentas ('2020-01-01');
call sp_AgregarVentas ('2018-12-01');
call sp_AgregarVentas ('2010-09-11');
call sp_AgregarVentas ('2003-03-01');

call sp_AgregarCompra ('2019-01-01');
call sp_AgregarCompra ('2019-02-02');
call sp_AgregarCompra ('2017-03-03');
call sp_AgregarCompra ('2009-04-04');
call sp_AgregarCompra ('2002-05-05');

call sp_AgregarDetalleVenta (1, 1, 2, 0.00);
call sp_AgregarDetalleVenta (2, 2, 4, 0.00);
call sp_AgregarDetalleVenta (3, 3, 6, 0.00);
call sp_AgregarDetalleVenta (4, 4, 8, 0.00);
call sp_AgregarDetalleVenta (5, 5, 10, 0.00);

call sp_AgregarDetalleCompra(21, 209979, 1, 1);
call sp_AgregarDetalleCompra(18, 298062, 2, 2);
call sp_AgregarDetalleCompra(15, 51000, 3, 3);
call sp_AgregarDetalleCompra(12, 30000, 4, 4);
call sp_AgregarDetalleCompra(11, 13500, 5, 5);
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from ventas;
select * from productos;
select * from detalleVenta;
select * from compra;
select * from detalleCompra;
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	create trigger tr_DetalleVenta_After_Insert
		after insert on DetalleVenta
        for each ROW
        begin 
			#IF DetalleVenta.cantidadVender < productos.existencia then
			update Productos
				set existencia = existencia - new.cantidadVender
				where id_Producto = new.id_Producto;
			#end if;
            /* if DetalleVenta.cantidadVender > productos.existencia then
				set existencia = existencia + 0;
            */
		end $$
Delimiter ;


Delimiter $$
	create trigger tr_DetalleCompra_After_Insert
		after insert on DetalleCompra
        for each ROW
        begin 
			update Productos 
				set existencia = existencia + new.cantidadCompra
				where id_Producto = new.id_Producto;
		end $$
Delimiter ;


delimiter $$
	create trigger tr_DetalleCompra_After_Insert_Unitario
		after insert on DetalleCompra
        for each row
        begin
			set @unit = (new.totalcompra / new.cantidadcompra);
			update Productos
				set precioUnitario = (@unit * 0.35) + @unit where id_Producto = new.id_Producto;
        end $$
delimiter ;


delimiter $$
	create trigger tr_DetalleCompra_After_Insert_Docena
		after insert on DetalleCompra
        for each row
        begin
			set @doce = (new.totalcompra / new.cantidadcompra);
			update Productos
				set precioDocena = (@doce * 0.25) + @doce where id_Producto = new.id_Producto;
        end $$
delimiter ;


delimiter $$
	create trigger tr_DetalleCompra_After_Insert_Mayor
		after insert on DetalleCompra
        for each row
        begin
			set @mayr = (new.totalcompra / new.cantidadcompra);
			update Productos
				set precioMayor = (@mayr * 0.15) + @mayr where id_Producto = new.id_Producto;
        end $$
delimiter ;

/*delimiter $$
	create trigger tr_DetalleVenta_After_Insert_Cantidad
		after insert on DetalleVenta
        for each row
        begin
			if DetalleVenta.cantidadvender < 11 then
				update DetalleVenta
				set totalVenta = @unit * cantidadVender;
			end if;
            if DetalleVenta.cantidadvender > 12 and DetalleVenta.cantidadVender < 29 then
				update DetalleVenta
				set totalVenta = @doce * cantidadVender;
			end if;
            if DetalleVenta.cantidadvender > 30 then
				update DetalleVenta
				set totalVenta = @mayr * cantidadVender;
			end if;
        end $$
delimiter ;*/