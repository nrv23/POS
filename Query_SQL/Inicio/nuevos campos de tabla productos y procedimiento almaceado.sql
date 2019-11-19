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

--  