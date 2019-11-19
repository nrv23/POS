-- FUNCIONES Y TRIGGERS

CREATE FUNCTION new_order_detail() RETURNS trigger
    AS 
    $BODY$

DECLARE

   reg RECORD;

   cur_ordenes CURSOR FOR SELECT idorden FROM orden WHERE iddetalle=0;

BEGIN

	OPEN cur_ordenes;

	LOOP

	FETCH cur_ordenes INTO reg;

	EXIT WHEN NOT FOUND; 

	UPDATE orden SET iddetalle = NEW.iddetalle WHERE idorden= reg.idorden;

	END LOOP;

  RETURN NEW;
  END 
  $BODY$

  LANGUAGE plpgsql;
	--------------------------

	CREATE FUNCTION reload_inventory(ordencancelada integer, cantidad integer) RETURNS text
   
    AS $BODY$

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

END                                                            
$BODY$

LANGUAGE plpgsql;
------------------------------
CREATE FUNCTION update_insert_inventarioproducto(producto integer, inventario integer, cantidad integer) RETURNS text
 
    AS $BODY$

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

END                                                            

$BODY$
LANGUAGE plpgsql;
---------------------------



CREATE FUNCTION update_inventory(ordencancelada integer, cantidad integer) RETURNS text
    
    AS $BODY$
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

END                                                            
$BODY$
LANGUAGE plpgsql;
-------------------------------
CREATE FUNCTION update_order_cost(ordenactualizar integer) RETURNS text
    AS $BODY$

DECLARE

	resultado_txt TEXT DEFAULT 'Resultado OK';

    total decimal(10,2);

BEGIN
    total = (select sum(ip.cantidadnecesaria * i.costoinventario) as total from inventarioproducto ip inner join inventario i on ip.idinventario = i.idinventario WHERE ip.idproducto = (SELECT idproducto FROM orden WHERE idorden = ordenActualizar));

    UPDATE ORDEN SET costounitarioproducto = total WHERE idorden = ordenActualizar; 

    RETURN resultado_txt;

END                                                          

$BODY$
LANGUAGE plpgsql;
-----------------------------

CREATE FUNCTION update_order_table(pidorden integer, pidfactura integer, pcostounitario numeric, pdescuentoorden numeric, pnumerolineadetalle integer, pcodigoservicio character varying, ptiposervicio character varying, punidadmedida character varying, punidadmedidacomercial character varying, pdetalle text, pmontototal numeric, pmontodescuento numeric, pnaturalezadescuento character varying, psubtotal numeric, pcodigoimpuesto character varying, ptarifa numeric, pmonto numeric, pexoneracion_tipodocumento character varying, pnumerodocumento character varying, pnombreinstitucion character varying, pmontoimpuesto numeric, pporcentajecompra integer, pmontoitotallinea numeric) RETURNS character varying
    AS 
    $BODY$


BEGIN

    UPDATE orden SET idfactura= pidfactura, costounitarioproducto= pcostounitario, descuentoorden=  pdescuentoorden, numerolineadetalle= pnumerolineadetalle,
    codigoservicio= pcodigoservicio, tiposervicio= ptiposervicio, unidadmedida = punidadmedida, unidadmedidacomercial= punidadmedidacomercial, detalle= pdetalle,
    montototal= pmontototal, montodescuento= pmontodescuento, naturalezadescuento= pnaturalezadescuento, subtotal= psubtotal, codigoimpuesto= pcodigoimpuesto,
    tarifa=ptarifa, monto= pmonto, exoneracion_tipodocumento=pexoneracion_tipodocumento, numerodocumento= pnumerodocumento, nombreinstitucion= pnombreinstitucion,
    montoimpuesto= pmontoimpuesto, procentajecompra= pporcentajecompra, montoitotallinea=pmontoitotallinea
      WHERE idorden= pidorden;

     RETURN 'RESULTADO DEVUELTO';

END
$BODY$
LANGUAGE plpgsql;
------------------------------------
CREATE FUNCTION update_period_bill() RETURNS trigger
    AS 
    $BODY$

DECLARE 

    id_periodo_venta_activo integer;

BEGIN

	id_periodo_venta_activo = (SELECT idperiodoventa FROM periodoventa WHERE estadoperiodoventa = 'Activo');

    NEW.idperiodoventa = id_periodo_venta_activo;

  	RETURN NEW;

END

$BODY$
LANGUAGE plpgsql;
--------------------------------------
CREATE FUNCTION update_period_status(nombreperiodo character, idempleadoactualizo integer) RETURNS text
    AS $BODY$
DECLARE

	resultado_txt TEXT DEFAULT 'Resultado OK';

BEGIN

	UPDATE PERIODOVENTA SET estadoperiodoventa = 'Finalizado', fechafinperiodoventa = (SELECT NOW()), idEmpleado = idEmpleadoActualizo WHERE estadoperiodoventa = 'Activo';

    INSERT INTO public.PERIODOVENTA (nombreperiodoventa) VALUES (nombreperiodo);

    RETURN resultado_txt;

END
$BODY$
LANGUAGE plpgsql;
------------------------------------------------------------

CREATE TRIGGER update_period_bill BEFORE INSERT ON factura FOR EACH ROW EXECUTE PROCEDURE update_period_bill();




CREATE OR REPLACE FUNCTION public.update_order_fields(
    pidorden integer,
    pcostounitario numeric,
    pnumerolineadetalle integer,
    pcodigoservicio character varying,
    ptiposervicio character varying,
    punidadmedida character varying,
    punidadmedidacomercial character varying,
    pdetalle character varying,
    pmontototal numeric,
    psubtotal numeric,
    pcodigoimpuesto character varying,
    ptarifa numeric,
    pmonto numeric,
    pmontoimpuesto numeric,
    pmontoitotallinea numeric,
    pbaseImponible decimal)
  RETURNS character varying AS
$BODY$

    DECLARE
      _factura INTEGER; -- actualizar el foreign key de la factura con este id
    BEGIN
      SELECT idfactura INTO _factura FROM factura ORDER BY idfactura DESC LIMIT 1; 
      UPDATE orden SET idfactura=_factura, costounitarioproducto=pcostounitario, numerolineadetalle=pnumerolineadetalle,      codigoservicio= pcodigoservicio,
              tiposervicio=ptiposervicio, unidadmedida=punidadmedida, unidadmedidacomercial=punidadmedidacomercial,
             detalle=pdetalle, montototal=pmontototal, subtotal=psubtotal, codigoimpuesto=pcodigoimpuesto, tarifa=ptarifa, monto=pmonto, numerodocumento=_factura,fechaemision=now(), montoimpuesto=pmontoimpuesto, montoitotallinea=pmontoitotallinea, baseimponible= pbaseImponible
      WHERE idorden= pidorden;
             
      
      RETURN 'OK';
    END
    
$BODY$
  LANGUAGE plpgsql; 


CREATE OR REPLACE FUNCTION public.actualizar_campos_factura(
    ptotalservgravados numeric,
    ptotalservexentos numeric,
    ptotalservexonerado numeric,
    ptotalmercanciasgravadas numeric,
    ptotalmercanciasexentas numeric,
    ptotalmercanciasexoneradas numeric,
    ptotalgravado numeric,
    ptotalexento numeric,
    ptotalexonerado numeric,
    ptotalventa numeric,
    ptotaldescuentos numeric,
    ptotalventaneta numeric,
    ptotalimpuesto numeric,
    ptotalcomprobante numeric,
    pidreceptor integer,
    preceptor_numero VARCHAR(12),
    ptipocambio numeric,
    ptipo VARCHAR(2))
  RETURNS character varying AS
$BODY$
DECLARE
 _idfactura INTEGER;
 _idemisor INTEGER;

BEGIN 
     SELECT idfactura INTO _idfactura FROM factura ORDER BY idfactura DESC LIMIT 1;
     SELECT idemisor INTO _idemisor FROM emisor;

     
      
   UPDATE factura SET codigomoneda='CRC', tipocambio=ptipocambio, totalservgravados=ptotalservgravados,
                       totalservexentos=ptotalservexentos, totalservexonerado = ptotalservexonerado,
                       totalmercanciasgravadas=ptotalmercanciasgravadas,  totalmercanciasexentas= ptotalmercanciasexentas, 
                       totalmercanciaexonerada = ptotalmercanciasexoneradas,
                       totalgravado=ptotalgravado, totalexento= ptotalexento, totalexonerado=ptotalexonerado, 
                       totalventa= ptotalventa,totaldescuentos= ptotaldescuentos,totalventaneta=ptotalventaneta,
                       totalimpuesto=ptotalimpuesto, totalcomprobante=ptotalcomprobante,
                       idreceptor= pidreceptor, receptor_numero= preceptor_numero, idemisor= _idemisor, 
                       num_documento= idfactura, tipo=ptipo
                       
                       WHERE idfactura=_idfactura;
  
                       RETURN 'OK';
END
$BODY$
  LANGUAGE plpgsql;


CREATE FUNCTION iddetalle_factura() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
_iddetalle integer;
BEGIN
SELECT iddetalle into _iddetalle FROM detalles_orden ORDER BY iddetalle DESC LIMIT 1; 
UPDATE factura set iddetalle= _iddetalle WHERE iddetalle=0;

RETURN NEW;
END
$$;


CREATE TRIGGER details AFTER INSERT ON detalles_orden FOR EACH ROW EXECUTE PROCEDURE new_order_detail();
CREATE TRIGGER detalles_factura AFTER INSERT ON detalles_orden FOR EACH ROW EXECUTE PROCEDURE iddetalle_factura();

-- cambios


CREATE OR REPLACE FUNCTION update_receiver(
    pnombre character varying,
    preceptor_tipo_identificacion character varying,
    pnombrecomercial character varying,
    pprovincia integer,
    pcanton integer,
    pdistrito integer,
    potras_senas text,
    preceptor_telefono_codigopais numeric,
    preceptor_telefono_numtelefono numeric,
    preceptor_fax_codigopais numeric,
    preceptor_fax_numtelefono numeric,
    pcorreoelectronico character varying,
    preceptor_numero character varying)
  RETURNS character varying AS
$BODY$
BEGIN

  UPDATE receptor SET nombre=pnombre, receptor_tipo_identificacion=preceptor_tipo_identificacion , 
                                               nombrecomercial=pnombrecomercial, 
                                              provincia=pprovincia, canton= pcanton, distrito= pdistrito, otras_senas=potras_senas,
                                              receptor_telefono_codigopais= preceptor_telefono_codigopais, 
                                              receptor_telefono_numtelefono= preceptor_telefono_numtelefono,
                                              receptor_fax_codigopais=preceptor_fax_codigopais, 
                                              receptor_fax_numtelefono=preceptor_fax_numtelefono,
                                              correoelectronico=pcorreoelectronico
  WHERE receptor_numero=preceptor_numero;
            
  RETURN 'OK';
END
$BODY$
  LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION public.update_emisor(
    p_e_nombre character varying,
    p_emisor_tipo_identificacion character varying,
    p_emisor_numero character varying,
    p_e_nombrecomercial character varying,
    p_e_provincia integer,
    p_e_canton integer,
    p_e_distrito integer,
    p_e_otras_senas text,
    p_emisor_telefono_codigopais numeric,
    p_emisor_telefono_numtelefono numeric,
    p_emisor_fax_codigopais numeric,
    p_emisor_fax_numtelefono numeric,
    p_e_correoelectronico character varying,
    p_casamatriz character varying,
    p_puntoventa character varying,
    p_tipo_producto character varying,
    p_codigo_producto character varying,
    p_password_email VARCHAR(50),
    p_codigo_actividad character varying)
  RETURNS character varying AS
$BODY$
  DECLARE
  _id INTEGER;
  BEGIN
   SELECT idemisor INTO _id FROM emisor;
    IF _id IS NOT NULL THEN 
    
      UPDATE emisor SET e_nombre= p_e_nombre, emisor_tipo_identificacion = p_emisor_tipo_identificacion, emisor_numero= p_emisor_numero, 
      e_nombrecomercial= p_e_nombrecomercial, e_provincia= p_e_provincia, e_canton= p_e_canton, e_distrito= p_e_distrito, 
      e_otras_senas= p_e_otras_senas , emisor_telefono_codigopais= p_emisor_telefono_codigopais,  
      emisor_telefono_numtelefono= p_emisor_telefono_numtelefono, emisor_fax_codigopais= p_emisor_fax_codigopais,  
      emisor_fax_numtelefono= p_emisor_fax_numtelefono, e_correoelectronico= p_e_correoelectronico, 
      casamatriz=p_casamatriz, puntoventa=p_puntoventa,  tipo_producto=p_tipo_producto, codigo_producto=p_codigo_producto, 
      password_email= p_password_email, codigo_actividad= p_codigo_actividad
      WHERE idemisor=_id;
      
      RETURN '1';
  
    ELSE

      INSERT INTO EMISOR(e_nombre, emisor_tipo_identificacion, emisor_numero, e_nombrecomercial, e_provincia, e_canton, e_distrito, 
                         e_otras_senas, emisor_telefono_codigopais, emisor_telefono_numtelefono, emisor_fax_codigopais, 
                         emisor_fax_numtelefono, e_correoelectronico, casamatriz, puntoventa, tipo_producto, codigo_producto, password_email, codigo_actividad)
                         
       VALUES(p_e_nombre, p_emisor_tipo_identificacion, p_emisor_numero,
    p_e_nombrecomercial, p_e_provincia , p_e_canton , p_e_distrito, p_e_otras_senas ,
    p_emisor_telefono_codigopais, p_emisor_telefono_numtelefono, p_emisor_fax_codigopais,
    p_emisor_fax_numtelefono, p_e_correoelectronico, p_casamatriz, p_puntoventa, p_tipo_producto, p_codigo_producto, p_password_email, p_codigo_actividad);
      RETURN '0';
    END IF;
    
  END

$BODY$
  LANGUAGE plpgsql; 

CREATE OR REPLACE FUNCTION public.update_data_users(
    _user_api character varying,
    _pwd_api character varying)
  RETURNS character varying AS
$BODY$
   DECLARE
    _id INTEGER;
    _iduser INTEGER;
    BEGIN

  SELECT idemisor INTO _id FROM emisor;
  SELECT iduser INTO _iduser FROM users;

  IF _iduser IS NULL THEN
  INSERT INTO USERS(idemisor, user_api, pwd_api) 
              VALUES(_id, _user_api, _pwd_api);
  RETURN 'OK';
  ELSE
  
  UPDATE users SET idemisor= _id, user_api=_user_api, 
         pwd_api=_pwd_api
  WHERE idemisor=_iduser;
  RETURN 'OK';
  
  END IF;
    END

  $BODY$
  LANGUAGE plpgsql; 

  CREATE OR REPLACE FUNCTION public.insertar_nota(

    IN pidcuenta integer,
    IN pidempleado integer,
    IN pidperiodoventa integer,
    IN pidreceptor integer,
    IN pidemisor integer,
    IN pformapago character varying,
    IN psubtotal numeric,
    IN pporcentajedescuento numeric,
    IN pcantidadpersonas integer,
    IN pestadofactura integer,
    IN pcodigomoneda character varying,
    IN ptipocambio numeric,
    IN ptotalservgravados numeric,
    IN ptotalservexentos numeric,
    IN ptotalmercanciasgravadas numeric,
    IN ptotalmercanciasexentas numeric,
    IN ptotalgravado numeric,
    IN ptotalexento numeric,
    IN ptotalventa numeric,
    IN ptotaldescuentos numeric,
    IN ptotalventaneta numeric,
    IN ptotalimpuesto numeric,
    IN ptotalcomprobante numeric,
    IN preceptor_numero character varying,
    IN pclavenumerica character varying,
    IN pconsecutivo character varying,
    IN pplazo_credito integer,
    IN pcondicion_venta character varying,
    IN pmedio_pago character varying,
    IN ptipo character varying,
    IN pnum_documento integer,
    IN piddetalle integer,
    IN preferencia character varying,
    IN prazon_nota character varying,
    IN ptipo_comprobante character varying)
  RETURNS TABLE(j json) AS
$BODY$
BEGIN
INSERT INTO FACTURA (idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, formaPago, subtotal, porcentajedescuento,cantidadpersonas, 
estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado,
 totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, receptor_numero, clavenumerica,
 consecutivo, plazo_credito, condicion_venta, medio_pago, tipo, num_documento, iddetalle, referencia, razon_nota,tipo_comprobante) 
 
 VALUES(pidcuenta, pidempleado, pidperiodoventa, pidreceptor, pidemisor, pformaPago, psubtotal, pporcentajedescuento,pcantidadpersonas, pestadofactura, 
 pcodigomoneda, ptipocambio, ptotalservgravados, ptotalservexentos, ptotalmercanciasgravadas, ptotalmercanciasexentas, ptotalgravado, ptotalexento, ptotalventa,
  ptotaldescuentos, ptotalventaneta, ptotalimpuesto, ptotalcomprobante, preceptor_numero, pclavenumerica, pconsecutivo, pplazo_credito, pcondicion_venta,
  pmedio_pago,ptipo, pnum_documento, piddetalle, preferencia, prazon_nota,ptipo_comprobante);

  RETURN QUERY SELECT row_to_json(datos) FROM (SELECT idfactura,iddetalle FROM factura ORDER BY idfactura DESC LIMIT 1) datos;

  END
  $BODY$
  LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION public.get_orders_per_factura(IN id integer)
  RETURNS TABLE(j json) AS
$BODY$
BEGIN

  RETURN QUERY SELECT row_to_json(datos) FROM (SELECT o.idfactura ,o.idOrden,o.idcuenta , o.estadoorden, o.preciounitarioproducto, o.costounitarioproducto,
   o.cantidadproducto ,o.codigoservicio, o.tiposervicio, o.unidadmedida, o.unidadmedidacomercial,
   o.naturalezadescuento, o.codigoimpuesto, o.exoneracion_tipodocumento, o.nombreinstitucion, o.montoimpuesto, 
  o.procentajecompra, p.descripcionProducto, f.porcentajedescuento, o.total_orden, o.montodescuento, o.descuentoorden, 
  (o.precioUnitarioProducto * o.cantidadProducto) AS subtotal, p.porcentajeimpuesto,
   o.idproducto, f.condicion_venta, f.plazo_credito, e.tipo_producto, e.codigo_producto 
  FROM ORDEN o, factura f, producto p, emisor e 
   WHERE f.idFactura = id 
  AND o.idFactura = f.idFactura 
  AND o.idProducto = p.idProducto 
  AND e.idemisor=1
  ORDER BY o.idOrden DESC) datos;
  
END
$BODY$
  LANGUAGE plpgsql;




    CREATE OR REPLACE FUNCTION public.data_to_xml(IN _idfactura integer)
  RETURNS TABLE(clavenumerica character varying, consecutivo character varying, fecharegistrofactura timestamp without time zone, e_nombre character varying, emisor_tipo_identificacion character varying, emisor_numero character varying, e_nombrecomercial character varying, e_provincia integer, e_canton integer, e_distrito integer, e_otras_senas text, emisor_telefono_codigopais numeric, emisor_telefono_numtelefono numeric, emisor_fax_codigopais numeric, emisor_fax_numtelefono numeric, e_correoelectronico character varying, nombre character varying, receptor_tipo_identificacion character varying, receptor_numero character varying, nombrecomercial character varying, provincia integer, canton integer, distrito integer, otras_senas text, receptor_telefono_codigopais numeric, receptor_telefono_numtelefono numeric, receptor_fax_codigopais numeric, receptor_fax_numtelefono numeric, correoelectronico character varying, condicion_venta character varying, plazo_credito integer, medio_pago character varying, codigomoneda character varying, tipocambio numeric, totalservgravados numeric, totalservexentos numeric, totalmercanciasgravadas numeric, totalmercanciasexentas numeric, totalgravado numeric, totalexento numeric, totalventa numeric, totaldescuentos numeric, totalventaneta numeric, totalimpuesto numeric, totalcomprobante numeric, descripcion_detalle text) AS
$BODY$
        BEGIN

      RETURN QUERY SELECT f.clavenumerica, f.consecutivo, f.fecharegistrofactura , e.e_nombre, e.emisor_tipo_identificacion, e.emisor_numero,
        e.e_nombrecomercial, e.e_provincia, e.e_canton, e.e_distrito, e.e_otras_senas, e.emisor_telefono_codigopais,
        e.emisor_telefono_numtelefono, e.emisor_fax_codigopais, e.emisor_fax_numtelefono, e.e_correoelectronico,
        r.nombre, r.receptor_tipo_identificacion, r.receptor_numero, r.nombrecomercial, r.provincia, r.canton,
        r.distrito, r.otras_senas, r.receptor_telefono_codigopais, r.receptor_telefono_numtelefono,
        r.receptor_fax_codigopais, r.receptor_fax_numtelefono, r.correoelectronico, 
        (SELECT condicion_venta FROM orden ORDER BY idorden DESC LIMIT 1), 
        (SELECT plazo_credito FROM orden ORDER BY idorden DESC LIMIT 1), 
         (SELECT medio_pago FROM orden ORDER BY idorden DESC LIMIT 1),
          f.codigomoneda, f.tipocambio,
        f.totalservgravados, f.totalservexentos, f.totalmercanciasgravadas, f.totalmercanciasexentas, f.totalgravado,
        f.totalexento, f.totalventa, f.totaldescuentos,f.totalventaneta, f.totalimpuesto, f.totalcomprobante,
        d.descripcion_detalle
        FROM factura f, emisor e, receptor r, orden o, detalles_orden d
        WHERE f.idfactura=_idfactura GROUP BY f.clavenumerica, f.consecutivo
        AND f.idemisor= e.idemisor
        AND f.idreceptor= r.idreceptor 
        AND f.iddetalle= d.iddetalle;
        END
                   $BODY$
  LANGUAGE plpgsql;
