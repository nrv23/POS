-- nuevos campos a la tabla de orden y factura
ALTER TABLE FACTURA ADD COLUMN codigoMoneda VARCHAR(3) DEFAULT '500';
ALTER TABLE FACTURA ADD COLUMN tipoCambio DECIMAL(18,5) DEFAULT 1;
ALTER TABLE FACTURA ADD COLUMN TotalServGravados DECIMAL(18,5) DEFAULT 1;
ALTER TABLE FACTURA ADD COLUMN TotalServExentos DECIMAL(18,5) DEFAULT 1;
ALTER TABLE FACTURA ADD COLUMN TotalMercanciasGravadas DECIMAL(18,5) DEFAULT 1;
ALTER TABLE FACTURA ADD COLUMN TotalMercanciasExentas DECIMAL(18,5) DEFAULT 1;
ALTER TABLE FACTURA ADD COLUMN TotalGravado DECIMAL(18,5) DEFAULT 1;
ALTER TABLE FACTURA ADD COLUMN TotalExento DECIMAL(18,5) DEFAULT 1;
ALTER TABLE FACTURA ADD COLUMN TotalVenta DECIMAL(18,5) DEFAULT 1;
ALTER TABLE FACTURA ADD COLUMN TotalDescuentos DECIMAL(18,5) DEFAULT 1;
ALTER TABLE FACTURA ADD COLUMN TotalVentaNeta DECIMAL(18,5) DEFAULT 1;
ALTER TABLE FACTURA ADD COLUMN TotalImpuesto DECIMAL(18,5) DEFAULT 1;
ALTER TABLE FACTURA ADD COLUMN TotalComprobante DECIMAL(18,5) DEFAULT 1;
------------------------------------
ALTER TABLE FACTURA ALTER COLUMN codigoMoneda SET NOT NULL;
ALTER TABLE FACTURA ALTER COLUMN tipoCambio SET NOT NULL;
ALTER TABLE FACTURA ALTER COLUMN TotalServGravados SET NOT NULL;
ALTER TABLE FACTURA ALTER COLUMN TotalServExentos SET NOT NULL;
ALTER TABLE FACTURA ALTER COLUMN TotalMercanciasGravadas SET NOT NULL;
ALTER TABLE FACTURA ALTER COLUMN TotalMercanciasExentas SET NOT NULL;
ALTER TABLE FACTURA ALTER COLUMN TotalGravado  SET NOT NULL;
ALTER TABLE FACTURA ALTER COLUMN TotalExento  SET NOT NULL;
ALTER TABLE FACTURA ALTER COLUMN TotalVenta  SET NOT NULL;
ALTER TABLE FACTURA ALTER COLUMN TotalDescuentos  SET NOT NULL;
ALTER TABLE FACTURA ALTER COLUMN TotalVentaNeta  SET NOT NULL;
ALTER TABLE FACTURA ALTER COLUMN TotalImpuesto  SET NOT NULL;
ALTER TABLE FACTURA ALTER COLUMN TotalComprobante  SET NOT NULL;



ALTER TABLE orden ADD COLUMN numeroLineaDetalle INTEGER DEFAULT 1;
ALTER TABLE orden ADD COLUMN codigoServicio VARCHAR(30) DEFAULT 1;
ALTER TABLE orden ADD COLUMN tipoServicio VARCHAR(2) DEFAULT '2';
ALTER TABLE orden ADD COLUMN unidadMedida VARCHAR(20) DEFAULT '1';
ALTER TABLE orden ADD COLUMN UnidadMedidaComercial varchar(20) DEFAULT '1';
ALTER TABLE orden ADD COLUMN Detalle TEXT DEFAULT '1';
ALTER TABLE orden ADD COLUMN precioUnitario DECIMAL(18,5) DEFAULT 1;
ALTER TABLE orden ADD COLUMN MontoTotal DECIMAL(18,5) DEFAULT 1;
ALTER TABLE orden ADD COLUMN montoDescuento DECIMAL(18,5) DEFAULT 1;
ALTER TABLE orden ADD COLUMN NaturalezaDescuento varchar(80) DEFAULT '1';
ALTER TABLE orden ADD COLUMN subtotal DECIMAL(18,5) DEFAULT 1;
ALTER TABLE orden ADD COLUMN codigoImpuesto varchar(2) DEFAULT '1';
ALTER TABLE orden ADD COLUMN tarifa DECIMAL(4,2) DEFAULT 1;
ALTER TABLE orden ADD COLUMN monto DECIMAL(18,5) DEFAULT 1;
ALTER TABLE orden ADD COLUMN exoneracion_tipoDocumento VARCHAR(2) DEFAULT '1';
ALTER TABLE orden ADD COLUMN numeroDocumento VARCHAR(17) DEFAULT '1';
ALTER TABLE orden ADD COLUMN nombreInstitucion VARCHAR(100) DEFAULT '1';
ALTER TABLE orden ADD COLUMN fechaEmision timestamp DEFAULT '01-01-2001 11:01:02';
ALTER TABLE orden ADD COLUMN montoImpuesto DECIMAL(18,5) DEFAULT 1;
ALTER TABLE orden ADD COLUMN procentajeCompra INTEGER DEFAULT 1;
ALTER TABLE orden ADD COLUMN montoITotalLinea DECIMAL(18,5) DEFAULT 1;



------------------------------------------------------------


ALTER TABLE orden ALTER COLUMN numeroLineaDetalle SET NOT NULL;
ALTER TABLE orden ALTER COLUMN codigoServicio SET NOT NULL;
ALTER TABLE orden ALTER COLUMN tipoServicio SET NOT NULL;
ALTER TABLE orden ALTER COLUMN Cantidad SET NOT NULL;
ALTER TABLE orden ALTER COLUMN unidadMedida SET NOT NULL;
ALTER TABLE orden ALTER COLUMN UnidadMedidaComercial SET NOT NULL;
ALTER TABLE orden ALTER COLUMN Detalle SET NOT NULL;
ALTER TABLE orden ALTER COLUMN precioUnitario SET NOT NULL;
ALTER TABLE orden ALTER COLUMN MontoTotal SET NOT NULL;
ALTER TABLE orden ALTER COLUMN montoDescuento SET NOT NULL;
ALTER TABLE orden ALTER COLUMN NaturalezaDescuento SET NOT NULL;
ALTER TABLE orden ALTER COLUMN subtotal SET NOT NULL;
ALTER TABLE orden ALTER COLUMN codigoImpuesto SET NOT NULL;
ALTER TABLE orden ALTER COLUMN tarifa SET NOT NULL;
ALTER TABLE orden ALTER COLUMN monto SET NOT NULL;
ALTER TABLE orden ALTER COLUMN exoneracion_tipoDocumento SET NOT NULL;
ALTER TABLE orden ALTER COLUMN numeroDocumento SET NOT NULL;
ALTER TABLE orden ALTER COLUMN nombreInstitucion SET NOT NULL;
ALTER TABLE orden ALTER COLUMN fechaEmision SET NOT NULL;
ALTER TABLE orden ALTER COLUMN montoImpuesto SET NOT NULL;
ALTER TABLE orden ALTER COLUMN procentajeCompra SET NOT NULL;
ALTER TABLE orden ALTER COLUMN montoITotalLinea SET NOT NULL;








-- procedimiento almacenado de actualizar ordenes y nuevos campos de la tabla producto
CREATE OR REPLACE FUNCTION public.update_order_table(
    pidorden integer,
    pidfactura integer,
    pcostounitario numeric,
    pdescuentoorden numeric,
    pnumerolineadetalle integer,
    pcodigoservicio character varying,
    ptiposervicio character varying,
    punidadmedida character varying,
    punidadmedidacomercial character varying,
    pdetalle text,
    pmontototal numeric,
    pmontodescuento numeric,
    pnaturalezadescuento character varying,
    psubtotal numeric,
    pcodigoimpuesto character varying,
    ptarifa numeric,
    pmonto numeric,
    pexoneracion_tipodocumento character varying,
    pnumerodocumento character varying,
    pnombreinstitucion character varying,
    pmontoimpuesto numeric,
    pporcentajecompra integer,
    pmontoitotallinea numeric)
  RETURNS character varying AS
$BODY$
BEGIN

    UPDATE orden SET idfactura= pidfactura, costounitarioproducto= pcostounitario, descuentoorden=  pdescuentoorden, numerolineadetalle= pnumerolineadetalle,
    codigoservicio= pcodigoservicio, tiposervicio= ptiposervicio, unidadmedida = punidadmedida, unidadmedidacomercial= punidadmedidacomercial, detalle= pdetalle,
    montototal= pmontototal, montodescuento= pmontodescuento, naturalezadescuento= pnaturalezadescuento, subtotal= psubtotal, codigoimpuesto= pcodigoimpuesto,
    tarifa=ptarifa, monto= pmonto, exoneracion_tipodocumento=pexoneracion_tipodocumento, numerodocumento= pnumerodocumento, nombreinstitucion= pnombreinstitucion,
    montoimpuesto= pmontoimpuesto, procentajecompra= pporcentajecompra, montoitotallinea=pmontoitotallinea
      WHERE idorden= pidorden;

     RETURN 'RESULTADO DEVUELTO';

END;
$BODY$
  LANGUAGE plpgsql;
  -- probar procedimiento con el select 
          SELECT update_order_table(50,1,23,23,23,'02','02','kilogramo','kilogramo','saasdasdsdadasdasdasdas',43534,23423,'fsdfsdfdsf',345,'02',45,45,'sd','6465456464','sadasdasdada',234,9,23234234);  
-- nuevos campos para la tabla de productos

ALTER TABLE producto ADD COLUMN montoimpuesto decimal(18,5);
ALTER TABLE producto ADD COLUMN unidadmedida varchar(20);
ALTER TABLE producto ADD COLUMN unidadmedidacomercial varchar(20);
ALTER TABLE producto ADD COLUMN impuesto decimal(18,5);

-- NUEVOS CAMBIOS PARA LA BASE DE DATOS 

 ALTER TABLE producto ADD COLUMN porcentajeImpuesto DECIMAL(10,5);


CREATE TABLE DETALLES_ORDEN(  
    idDetalle SERIAL PRIMARY KEY,
    descripcion_detalle TEXT
);

ALTER TABLE ORDEN ADD COLUMN idDetalles INTEGER;


ALTER TABLE ORDEN ADD FOREIGN KEY (idDetalles) REFERENCES DETALLES_ORDEN (idDetalle);


-- NUEVA FUNCION PARA GUADAR LOS DETALLES DE ORDEN Y EL TRIGGER

CREATE FUNCTION new_order_detail()
RETURNS TRIGGER AS
$BODY$
DECLARE 
    reg RECORD;
    cur_ordenes CURSOR FOR SELECT iddetalle FROM orden;
BEGIN
   OPEN cur_ordenes;
   LOOP
   FETCH cur_ordenes INTO reg; -- RECORRER FILA POR FILA 
   EXIT WHEN NOT FOUND;-- DETIENE LA EJECUCION DEL FETCH CUANDO NO ENCUENTRA MAS DATA
   IF reg.iddetalle = 0 THEN
    RAISE NOTICE '%', reg.iddetalle;
    RAISE NOTICE '%', NEW.iddetalle;
    UPDATE orden SET iddetalle= NEW.iddetalle
    WHERE iddetalle=reg.iddetalle;
   END IF;
   END LOOP;
   RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;
#---------------
CREATE TRIGGER details AFTER INSERT 
ON detalles_orden
FOR EACH ROW EXECUTE PROCEDURE new_order_detail();
