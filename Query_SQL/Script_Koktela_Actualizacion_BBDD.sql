DELETE FROM ORDEN;
DELETE FROM INVENTARIOPRODUCTO;
DELETE FROM PRODUCTO;
DELETE FROM CATEGORIA;
DELETE FROM CATEGORIAINVENTARIO;
DELETE FROM CUENTA;
DELETE FROM CLIENTE;
DELETE FROM EMPLEADO;
DELETE FROM PUESTO;
DELETE FROM FACTURA;
DELETE FROM TIPOGASTO;
DELETE FROM GASTO;
DELETE FROM PROVEEDORINVENTARIO;
DELETE FROM PROVEEDOR;
DELETE FROM INVENTARIO;
DELETE FROM PERIODOVENTA;

ALTER SEQUENCE public.categoria_idcategoria_seq restart 1;
ALTER SEQUENCE public.categoriainventario_idcategoriainventario_seq restart 1;
ALTER SEQUENCE public.cliente_idcliente_seq restart 1;
ALTER SEQUENCE public.cuenta_idcuenta_seq restart 1;
ALTER SEQUENCE public.empleado_idempleado_seq restart 1;
ALTER SEQUENCE public.factura_idfactura_seq restart 1;
ALTER SEQUENCE public.inventario_idinventario_seq restart 1;
ALTER SEQUENCE public.gasto_idgasto_seq restart 1;
ALTER SEQUENCE public.orden_idorden_seq restart 1;
ALTER SEQUENCE public.periodoventa_idperiodoventa_seq restart 1;
ALTER SEQUENCE public.producto_idproducto_seq restart 1;
ALTER SEQUENCE public.proveedor_idproveedor_seq restart 1;
ALTER SEQUENCE public.puesto_idpuesto_seq restart 1;
ALTER SEQUENCE public.tipogasto_idtipogasto_seq restart 1;

ALTER TABLE inventario ADD COLUMN unidad char(10);
ALTER TABLE inventarioproducto DROP COLUMN cantidadnecesaria;
ALTER TABLE inventarioproducto ADD COLUMN cantidadnecesaria decimal(8,2);

SELECT * FROM factura;
ALTER TABLE factura ADD COLUMN idCuenta int;
ALTER TABLE factura ADD COLUMN idEmpleado int;
ALTER TABLE factura ADD COLUMN idPeriodoVenta int;
ALTER TABLE factura ADD COLUMN fechaRegistroFactura timestamp default current_timestamp;
ALTER TABLE factura ADD COLUMN formaPago char(10);

-- A LA FACTURA LE GENERAMOS UNA FK PARA LA CUENTA
ALTER TABLE FACTURA ADD FOREIGN KEY (idCuenta) REFERENCES CUENTA(idCuenta);
-- A LA FACTURA LE GENERAMOS UNA FK PARA EL EMPLEADO
ALTER TABLE FACTURA ADD FOREIGN KEY (idEmpleado) REFERENCES EMPLEADO(idEmpleado);
-- A LA FACTURA LE GENERAMOS UNA FK PARA EL PERIDO DE VENTA
ALTER TABLE FACTURA ADD FOREIGN KEY (idPeriodoVenta) REFERENCES PERIODOVENTA(idPeriodoVenta);

SELECT * FROM orden;

ALTER TABLE orden DROP CONSTRAINT IF EXISTS orden_idempleado_fkey;
ALTER TABLE orden DROP CONSTRAINT IF EXISTS orden_idperiodoventa_fkey;

ALTER TABLE orden DROP COLUMN idempleado;
ALTER TABLE orden DROP COLUMN idperiodoventa;
ALTER TABLE orden DROP COLUMN formapago;
ALTER TABLE orden DROP COLUMN descuentoaplicado;

DROP TRIGGER update_period_order ON orden; 
DROP FUNCTION update_period_order();

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




