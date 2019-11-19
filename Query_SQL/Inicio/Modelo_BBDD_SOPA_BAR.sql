CREATE TABLE CLIENTE
(
	idCliente SERIAL,
	identificacionCliente char(100),
    estadoCliente smallint default 1,
    primary key (idCliente)
);

-- CREAR LA TABLA PUESTO
CREATE TABLE PUESTO 
(
	idPuesto SERIAL,
    descripcionPuesto char(50),
    departamentoPuesto char(50),
    primary key(idPuesto)
);

-- CREAR LA TABLA EMPLEADO
CREATE TABLE EMPLEADO
(
	idEmpleado SERIAL,
    nombreEmpleado char(50),
    apellidoEmpleado char(50),
    passwordEmpleado char(50),
    idPuesto int not null,
    estadoEmpleado smallint default 1,
    primary key (idEmpleado)
); 
-- AL EMPLEADO LE GENERAMOS UNA FK PARA EL PUESTO
ALTER TABLE EMPLEADO ADD foreign key (idPuesto) references PUESTO(idPuesto);

-- CREAR LA TABLA CUENTA
CREATE TABLE CUENTA
(
	idCuenta SERIAL,
    idCliente int,
    fechaAperturaCuenta timestamp default current_timestamp,
    estadoCuenta char(30),
    primary key (idCuenta)    
);
-- A LA CUENTA LE GENERAMOS UNA FK PARA EL CLIENTE
ALTER TABLE CUENTA ADD FOREIGN KEY (idCliente) references CLIENTE(idCliente);

-- CREAR LA TABLA CATEGORIA
CREATE TABLE CATEGORIA
(
	idCategoria SERIAL,
    descripcionCategoria char(30),
    primary key (idCategoria)
);

-- CREAR LA TABLA PRODUCTO
CREATE TABLE PRODUCTO
(
	idProducto SERIAL,
    descripcionProducto char(50),
    idCategoria int,
	precioProducto int,
    codigoBarraProducto char(50),
    estadoProducto smallint default 1,
    primary key (idProducto)
);
-- AL PRODUCTO LE GENERAMOS UNA FK PARA LA CATEGORIA
ALTER TABLE PRODUCTO ADD FOREIGN KEY (idCategoria) references CATEGORIA(idCategoria);

-- CREAR LA TABLA CATEGORIA DE INVENTARIO
CREATE TABLE CATEGORIAINVENTARIO
(
	idCategoriaInventario SERIAL,
    descripcionCategoriaInventario char(30),
    primary key (idCategoriaInventario)
);

CREATE TABLE INVENTARIO
(
	idInventario SERIAL,
    idCategoriaInventario int,
    descripcionInventario char(50),
    costoInventario decimal(10,2),
    cantidadDisponibleInventario decimal(10,2),
    cantidadMinimaInventario decimal(10,2),
    unidad char(10),
    codigoBarraInventario char(50),
    estadoInventario smallint default 1,
    primary key (idInventario)
);
-- AL INVENTARIO LE GENERAMOS UNA FK PARA LA CATEGRIA
ALTER TABLE INVENTARIO ADD FOREIGN KEY (idCategoriaInventario) REFERENCES CATEGORIAINVENTARIO(idCategoriaInventario);

CREATE TABLE INVENTARIOPRODUCTO
(
	idInventario int,
    idProducto int,
    cantidadNecesaria decimal (8,2)
);
-- A LA INVENTARIOPRODUCTO LE GENERAMOS UNA FK PARA EL INVENTARIO
ALTER TABLE INVENTARIOPRODUCTO ADD FOREIGN KEY (idInventario) REFERENCES INVENTARIO(idInventario);
-- A LA INVENTARIOPRODUCTO LE GENERAMOS UNA FK PARA EL PRODUCTO
ALTER TABLE INVENTARIOPRODUCTO ADD FOREIGN KEY (idProducto) REFERENCES PRODUCTO(idProducto);

-- CREAR LA TABLA PERIODOVENTA
CREATE TABLE PERIODOVENTA
(
    idPeriodoVenta SERIAL,
    nombrePeriodoVenta char(50),
    estadoPeriodoVenta char(10) default 'Activo',
    fechaInicioPeriodoVenta timestamp default current_timestamp,
    fechaFinPeriodoVenta timestamp,
    idEmpleado int,
    primary key(idPeriodoVenta)
);
ALTER TABLE PERIODOVENTA ADD FOREIGN KEY (idEmpleado) REFERENCES EMPLEADO (idEmpleado);

-- CREAR LA TABLA DE FACTURA
CREATE TABLE FACTURA
(
    idFactura SERIAL,
    idCuenta int,
    idEmpleado int,
    idPeriodoVenta int,
    fechaRegistroFactura timestamp default current_timestamp,
    formaPago char(10),
    subTotal decimal(10,2),
    porcentajeDescuento decimal(5,2),
    cantidadPersonas int,
    estadoFactura smallint default 1,
    primary key (idFactura)
);
-- A LA FACTURA LE GENERAMOS UNA FK PARA LA CUENTA
ALTER TABLE FACTURA ADD FOREIGN KEY (idCuenta) REFERENCES CUENTA(idCuenta);
-- A LA FACTURA LE GENERAMOS UNA FK PARA EL EMPLEADO
ALTER TABLE FACTURA ADD FOREIGN KEY (idEmpleado) REFERENCES EMPLEADO(idEmpleado);
-- A LA FACTURA LE GENERAMOS UNA FK PARA EL PERIDO DE VENTA
ALTER TABLE FACTURA ADD FOREIGN KEY (idPeriodoVenta) REFERENCES PERIODOVENTA(idPeriodoVenta);

-- CREAR LA TABLA ORDEN
CREATE TABLE ORDEN
(
	idOrden SERIAL,
    idCuenta int,
    idProducto int,
    idFactura int,
    cantidadProducto int not null,
    estadoOrden char(10),
    fechaRegistroOrden timestamp default current_timestamp,
    precioUnitarioProducto decimal(10,2) default 0,
    costoUnitarioProducto decimal(10,2) default 0,
    descuentoOrden decimal(4,2) default 0,
    primary key (idOrden)
);
-- A LA ORDEN LE GENERAMOS UNA FK PARA LA CUENTA
ALTER TABLE ORDEN ADD FOREIGN KEY (idCuenta) REFERENCES CUENTA(idCuenta);
-- A LA ORDEN LE GENERAMOS UNA FK PARA EL PRODUCTO
ALTER TABLE ORDEN ADD FOREIGN KEY (idProducto) REFERENCES PRODUCTO(idProducto);
-- A LA ORDEN LE GENERAMOS UNA FK PARA LA FACTURA
ALTER TABLE ORDEN ADD FOREIGN KEY (idFactura) REFERENCES FACTURA(idFactura);

-- CREAR LA TABLA PROVEEDOR
CREATE TABLE PROVEEDOR
(
	idProveedor SERIAL,
    empresa char(50),
    nombreContacto char(100),
	contactoProveedor1 char(20),
	contactoProveedor2 char(20),
	correoProveedor char(20),
	observacionProveedor char(100),
    estadoProveedor smallint default 1,
    primary key (idProveedor)
);

CREATE TABLE PROVEEDORINVENTARIO (
	idProveedor int,
    idInventario int,
    cantidadProducto decimal(10,2),
    fechaRegistro timestamp default current_timestamp,
    costoUnitario decimal(10,2)
);
-- A LA TABLA PROVEEDORPRODUCTO LE GENERAMOS UNA FK PARA EL PROVEEDOR
ALTER TABLE PROVEEDORINVENTARIO ADD FOREIGN KEY (idProveedor) REFERENCES PROVEEDOR (idProveedor);
-- A LA TABLA PROVEEDORPRODUCTO LE GENERAMOS UNA FK PARA EL PRODCUTO
ALTER TABLE PROVEEDORINVENTARIO ADD FOREIGN KEY (idInventario) REFERENCES INVENTARIO (idInventario);

CREATE TABLE TIPOGASTO
(
	idTipoGasto SERIAL,
    descripcionTipoGasto char(50)
);

CREATE TABLE GASTO
(
	idGasto SERIAL,
    idTipoGasto int,
    descripcionGasto char(50),
    estadoGasto char(20),
    montoGasto decimal(10,2),
    fechaGasto timestamp default current_timestamp,
    observacionGasto char(100)
);

-- CREAR EL TRIGGER PARA ASIGNARLE EL PERIODO DE VENTA ACTIVO A LA ORDEN
CREATE OR REPLACE FUNCTION update_period_bill() RETURNS TRIGGER AS $$
DECLARE 
    id_periodo_venta_activo integer;
BEGIN
	id_periodo_venta_activo = (SELECT idperiodoventa FROM periodoventa WHERE estadoperiodoventa = 'Activo');
    NEW.idperiodoventa = id_periodo_venta_activo;
  	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_period_bill 
BEFORE INSERT ON FACTURA 
FOR EACH ROW EXECUTE PROCEDURE update_period_bill();

-- CREAR PROCEDIMIENTO ALMACENADO PARA INSERTAR UN NUEVO PERIODO DE VENTA CADA VEZ QUE SE FINALIZA UNO
CREATE OR REPLACE FUNCTION update_period_status (nombrePeriodo char(50), idEmpleadoActualizo int) RETURNS text AS $$
DECLARE
	resultado_txt TEXT DEFAULT 'Resultado OK';
BEGIN
	UPDATE PERIODOVENTA SET estadoperiodoventa = 'Finalizado', fechafinperiodoventa = (SELECT NOW()), idEmpleado = idEmpleadoActualizo WHERE estadoperiodoventa = 'Activo';
    INSERT INTO public.PERIODOVENTA (nombreperiodoventa) VALUES (nombreperiodo);
    
    RETURN resultado_txt;
END;
$$ LANGUAGE plpgsql;
-- Para ejecutar el Procedimiento Almacenado
SELECT update_period_status ('Periodo4', 1);

-- CREAR PROCEDIMIENTO ALMACENADO PARA INSERTAR O ACTUALIZAR EL INVENTARIOPRODUCTO
CREATE OR REPLACE FUNCTION update_insert_inventarioproducto(producto integer, 
inventario integer, cantidad integer) 
RETURNS text AS $$
DECLARE
	resultado_txt TEXT DEFAULT 'Resultado OK';
BEGIN
	UPDATE public.INVENTARIOPRODUCTO SET cantidadnecesaria = cantidad 
	WHERE idproducto = producto AND idinventario = inventario;
    IF NOT FOUND THEN
    	INSERT INTO public.INVENTARIOPRODUCTO (idproducto, idinventario, cantidadnecesaria) 
        VALUES (producto, inventario, cantidad);
  	END IF;
    RETURN resultado_txt;
END;                                                            
$$ LANGUAGE plpgsql;
-- Para ejecutar el Procedimiento Almacenado
SELECT update_insert_inventarioproducto (producto,inventario,cantidad);

-- CREAR PROCEDIMIENTO ALMACENADO PARA DISMINUIR LA CANTIDAD DE INVENTARIO UNA VEZ CONCRETADA UNA VENTA
CREATE OR REPLACE FUNCTION update_inventory(ordenCancelada integer, cantidad integer) 
RETURNS text AS $$
DECLARE
	resultado_txt TEXT DEFAULT 'Resultado OK';
    product_update INTEGER;
    inventarioid RECORD;
BEGIN
    product_update = (SELECT idproducto FROM ORDEN WHERE idorden = ordenCancelada);  
    FOR inventarioid IN SELECT * FROM INVENTARIOPRODUCTO WHERE idproducto = product_update LOOP
        UPDATE INVENTARIO SET cantidadDisponibleInventario = cantidadDisponibleInventario - inventarioid.cantidadnecesaria * cantidad
        WHERE idinventario = inventarioid.idinventario;
    END LOOP;
    RETURN resultado_txt;
END;                                                            
$$ LANGUAGE plpgsql;
-- Para ejecutar el Procedimiento Almacenado
SELECT update_inventory (orden, cantidad);

-- CREAR PROCEDIMIENTO ALMACENADO PARA AUMENTAR LA CANTIDAD DE INVENTARIO UNA VEZ CONCRETADA UNA VENTA
CREATE OR REPLACE FUNCTION reload_inventory(ordenCancelada integer, cantidad integer) 
RETURNS text AS $$
DECLARE
	resultado_txt TEXT DEFAULT 'Resultado OK';
    product_update INTEGER;
    inventarioid RECORD;
BEGIN
    product_update = (SELECT idproducto FROM ORDEN WHERE idorden = ordenCancelada);  
    FOR inventarioid IN SELECT * FROM INVENTARIOPRODUCTO WHERE idproducto = product_update LOOP
        UPDATE INVENTARIO SET cantidadDisponibleInventario = cantidadDisponibleInventario + inventarioid.cantidadnecesaria * cantidad
        WHERE idinventario = inventarioid.idinventario;
    END LOOP;
    RETURN resultado_txt;
END;                                                            
$$ LANGUAGE plpgsql;
-- Para ejecutar el Procedimiento Almacenado
SELECT reload_inventory (orden, cantidad);

-- CREAR PROCEDIMIENTO ALMACENADO PARA REGISTRAR EL COSTO DE UNA ORDEN SEGÚN EL INVENTARIO DEL PRODUCTO
CREATE OR REPLACE FUNCTION update_order_cost(ordenActualizar integer) 
RETURNS text AS $$
DECLARE
	resultado_txt TEXT DEFAULT 'Resultado OK';
    total decimal(10,2);
BEGIN
    total = (select sum(ip.cantidadnecesaria * i.costoinventario) as total from inventarioproducto ip inner join inventario i on ip.idinventario = i.idinventario WHERE ip.idproducto = (SELECT idproducto FROM orden WHERE idorden = ordenActualizar));
    UPDATE ORDEN SET costounitarioproducto = total WHERE idorden = ordenActualizar; 
    RETURN resultado_txt;
END;                                                          
$$ LANGUAGE plpgsql;
-- Para ejecutar el Procedimiento Almacenado
SELECT update_order_cost(orden);