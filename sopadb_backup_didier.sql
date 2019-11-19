--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-1.pgdg18.04+1)
-- Dumped by pg_dump version 10.10 (Ubuntu 10.10-1.pgdg18.04+1)

-- Started on 2019-08-29 22:13:10 -05

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.xml DROP CONSTRAINT IF EXISTS xml_idfactura_fkey;
ALTER TABLE IF EXISTS ONLY public.tipoimpuesto DROP CONSTRAINT IF EXISTS tipoimpuesto_idimpuesto_fkey;
ALTER TABLE IF EXISTS ONLY public.proveedorinventario DROP CONSTRAINT IF EXISTS proveedorinventario_idproveedor_fkey;
ALTER TABLE IF EXISTS ONLY public.proveedorinventario DROP CONSTRAINT IF EXISTS proveedorinventario_idinventario_fkey;
ALTER TABLE IF EXISTS ONLY public.producto DROP CONSTRAINT IF EXISTS producto_idclasificacion_fkey;
ALTER TABLE IF EXISTS ONLY public.producto DROP CONSTRAINT IF EXISTS producto_idcategoria_fkey;
ALTER TABLE IF EXISTS ONLY public.periodoventa DROP CONSTRAINT IF EXISTS periodoventa_idempleado_fkey;
ALTER TABLE IF EXISTS ONLY public.orden DROP CONSTRAINT IF EXISTS orden_idproducto_fkey;
ALTER TABLE IF EXISTS ONLY public.orden DROP CONSTRAINT IF EXISTS orden_idfactura_fkey;
ALTER TABLE IF EXISTS ONLY public.orden DROP CONSTRAINT IF EXISTS orden_idcuenta_fkey;
ALTER TABLE IF EXISTS ONLY public.inventarioproducto DROP CONSTRAINT IF EXISTS inventarioproducto_idproducto_fkey;
ALTER TABLE IF EXISTS ONLY public.inventarioproducto DROP CONSTRAINT IF EXISTS inventarioproducto_idinventario_fkey;
ALTER TABLE IF EXISTS ONLY public.inventario DROP CONSTRAINT IF EXISTS inventario_idcategoriainventario_fkey;
ALTER TABLE IF EXISTS ONLY public.factura DROP CONSTRAINT IF EXISTS factura_idperiodoventa_fkey;
ALTER TABLE IF EXISTS ONLY public.factura DROP CONSTRAINT IF EXISTS factura_idempleado_fkey;
ALTER TABLE IF EXISTS ONLY public.factura DROP CONSTRAINT IF EXISTS factura_idemisor_fkey;
ALTER TABLE IF EXISTS ONLY public.factura DROP CONSTRAINT IF EXISTS factura_idcuenta_fkey;
ALTER TABLE IF EXISTS ONLY public.empleado DROP CONSTRAINT IF EXISTS empleado_idpuesto_fkey;
ALTER TABLE IF EXISTS ONLY public.cuenta DROP CONSTRAINT IF EXISTS cuenta_idcliente_fkey;
DROP TRIGGER IF EXISTS update_period_bill ON public.factura;
DROP TRIGGER IF EXISTS detalles_factura ON public.detalles_orden;
DROP TRIGGER IF EXISTS details ON public.detalles_orden;
ALTER TABLE IF EXISTS ONLY public.xml DROP CONSTRAINT IF EXISTS xml_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.tipoimpuesto DROP CONSTRAINT IF EXISTS tipoimpuesto_pkey;
ALTER TABLE IF EXISTS ONLY public.receptor DROP CONSTRAINT IF EXISTS receptor_pkey;
ALTER TABLE IF EXISTS ONLY public.puesto DROP CONSTRAINT IF EXISTS puesto_pkey;
ALTER TABLE IF EXISTS ONLY public.provincia DROP CONSTRAINT IF EXISTS provincia_pkey;
ALTER TABLE IF EXISTS ONLY public.proveedor DROP CONSTRAINT IF EXISTS proveedor_pkey;
ALTER TABLE IF EXISTS ONLY public.producto DROP CONSTRAINT IF EXISTS producto_pkey;
ALTER TABLE IF EXISTS ONLY public.periodoventa DROP CONSTRAINT IF EXISTS periodoventa_pkey;
ALTER TABLE IF EXISTS ONLY public.orden DROP CONSTRAINT IF EXISTS orden_pkey;
ALTER TABLE IF EXISTS ONLY public.inventario DROP CONSTRAINT IF EXISTS inventario_pkey;
ALTER TABLE IF EXISTS ONLY public.impuesto DROP CONSTRAINT IF EXISTS impuesto_pkey;
ALTER TABLE IF EXISTS ONLY public.factura DROP CONSTRAINT IF EXISTS factura_pkey;
ALTER TABLE IF EXISTS ONLY public.empleado DROP CONSTRAINT IF EXISTS empleado_pkey;
ALTER TABLE IF EXISTS ONLY public.emisor DROP CONSTRAINT IF EXISTS emisor_pkey;
ALTER TABLE IF EXISTS ONLY public.distrito DROP CONSTRAINT IF EXISTS distrito_pkey;
ALTER TABLE IF EXISTS ONLY public.detalles_orden DROP CONSTRAINT IF EXISTS detalles_orden_pkey;
ALTER TABLE IF EXISTS ONLY public.descuento DROP CONSTRAINT IF EXISTS descuento_pkey;
ALTER TABLE IF EXISTS ONLY public.cuenta DROP CONSTRAINT IF EXISTS cuenta_pkey;
ALTER TABLE IF EXISTS ONLY public.cliente DROP CONSTRAINT IF EXISTS cliente_pkey;
ALTER TABLE IF EXISTS ONLY public.clasificacion DROP CONSTRAINT IF EXISTS clasificacion_pkey;
ALTER TABLE IF EXISTS ONLY public.categoriainventario DROP CONSTRAINT IF EXISTS categoriainventario_pkey;
ALTER TABLE IF EXISTS ONLY public.categoria DROP CONSTRAINT IF EXISTS categoria_pkey;
ALTER TABLE IF EXISTS ONLY public.canton DROP CONSTRAINT IF EXISTS canton_pkey;
ALTER TABLE IF EXISTS public.xml ALTER COLUMN idxml DROP DEFAULT;
ALTER TABLE IF EXISTS public.users ALTER COLUMN iduser DROP DEFAULT;
ALTER TABLE IF EXISTS public.tipoimpuesto ALTER COLUMN idtipoimpuesto DROP DEFAULT;
ALTER TABLE IF EXISTS public.tipogasto ALTER COLUMN idtipogasto DROP DEFAULT;
ALTER TABLE IF EXISTS public.receptor ALTER COLUMN idreceptor DROP DEFAULT;
ALTER TABLE IF EXISTS public.puesto ALTER COLUMN idpuesto DROP DEFAULT;
ALTER TABLE IF EXISTS public.proveedor ALTER COLUMN idproveedor DROP DEFAULT;
ALTER TABLE IF EXISTS public.producto ALTER COLUMN idproducto DROP DEFAULT;
ALTER TABLE IF EXISTS public.periodoventa ALTER COLUMN idperiodoventa DROP DEFAULT;
ALTER TABLE IF EXISTS public.orden ALTER COLUMN idorden DROP DEFAULT;
ALTER TABLE IF EXISTS public.inventario ALTER COLUMN idinventario DROP DEFAULT;
ALTER TABLE IF EXISTS public.impuesto ALTER COLUMN idimpuesto DROP DEFAULT;
ALTER TABLE IF EXISTS public.gasto ALTER COLUMN idgasto DROP DEFAULT;
ALTER TABLE IF EXISTS public.factura ALTER COLUMN idfactura DROP DEFAULT;
ALTER TABLE IF EXISTS public.empleado ALTER COLUMN idempleado DROP DEFAULT;
ALTER TABLE IF EXISTS public.emisor ALTER COLUMN idemisor DROP DEFAULT;
ALTER TABLE IF EXISTS public.detalles_orden ALTER COLUMN iddetalle DROP DEFAULT;
ALTER TABLE IF EXISTS public.descuento ALTER COLUMN iddescuento DROP DEFAULT;
ALTER TABLE IF EXISTS public.cuenta ALTER COLUMN idcuenta DROP DEFAULT;
ALTER TABLE IF EXISTS public.cliente ALTER COLUMN idcliente DROP DEFAULT;
ALTER TABLE IF EXISTS public.clasificacion ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.categoriainventario ALTER COLUMN idcategoriainventario DROP DEFAULT;
ALTER TABLE IF EXISTS public.categoria ALTER COLUMN idcategoria DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.xml_idxml_seq;
DROP TABLE IF EXISTS public.xml;
DROP SEQUENCE IF EXISTS public.users_iduser_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.tipoimpuesto_idtipoimpuesto_seq;
DROP TABLE IF EXISTS public.tipoimpuesto;
DROP SEQUENCE IF EXISTS public.tipogasto_idtipogasto_seq;
DROP TABLE IF EXISTS public.tipogasto;
DROP SEQUENCE IF EXISTS public.receptor_idreceptor_seq;
DROP TABLE IF EXISTS public.receptor;
DROP SEQUENCE IF EXISTS public.puesto_idpuesto_seq;
DROP TABLE IF EXISTS public.puesto;
DROP TABLE IF EXISTS public.provincia;
DROP TABLE IF EXISTS public.proveedorinventario;
DROP SEQUENCE IF EXISTS public.proveedor_idproveedor_seq;
DROP TABLE IF EXISTS public.proveedor;
DROP SEQUENCE IF EXISTS public.producto_idproducto_seq;
DROP TABLE IF EXISTS public.producto;
DROP SEQUENCE IF EXISTS public.periodoventa_idperiodoventa_seq;
DROP TABLE IF EXISTS public.periodoventa;
DROP SEQUENCE IF EXISTS public.orden_idorden_seq;
DROP TABLE IF EXISTS public.orden;
DROP TABLE IF EXISTS public.inventarioproducto;
DROP SEQUENCE IF EXISTS public.inventario_idinventario_seq;
DROP TABLE IF EXISTS public.inventario;
DROP SEQUENCE IF EXISTS public.impuesto_idimpuesto_seq;
DROP TABLE IF EXISTS public.impuesto;
DROP SEQUENCE IF EXISTS public.gasto_idgasto_seq;
DROP TABLE IF EXISTS public.gasto;
DROP TABLE IF EXISTS public.fila;
DROP SEQUENCE IF EXISTS public.factura_idfactura_seq;
DROP TABLE IF EXISTS public.factura;
DROP SEQUENCE IF EXISTS public.empleado_idempleado_seq;
DROP TABLE IF EXISTS public.empleado;
DROP SEQUENCE IF EXISTS public.emisor_idemisor_seq;
DROP TABLE IF EXISTS public.emisor;
DROP TABLE IF EXISTS public.distrito;
DROP SEQUENCE IF EXISTS public.detalles_orden_iddetalle_seq;
DROP TABLE IF EXISTS public.detalles_orden;
DROP SEQUENCE IF EXISTS public.descuento_iddescuento_seq;
DROP TABLE IF EXISTS public.descuento;
DROP SEQUENCE IF EXISTS public.cuenta_idcuenta_seq;
DROP TABLE IF EXISTS public.cuenta;
DROP SEQUENCE IF EXISTS public.cliente_idcliente_seq;
DROP TABLE IF EXISTS public.cliente;
DROP SEQUENCE IF EXISTS public.clasificacion_id_seq;
DROP TABLE IF EXISTS public.clasificacion;
DROP SEQUENCE IF EXISTS public.categoriainventario_idcategoriainventario_seq;
DROP TABLE IF EXISTS public.categoriainventario;
DROP SEQUENCE IF EXISTS public.categoria_idcategoria_seq;
DROP TABLE IF EXISTS public.categoria;
DROP TABLE IF EXISTS public.canton;
DROP FUNCTION IF EXISTS public.update_receiver(pnombre character varying, preceptor_tipo_identificacion character varying, pnombrecomercial character varying, pprovincia integer, pcanton integer, pdistrito integer, potras_senas text, preceptor_telefono_codigopais numeric, preceptor_telefono_numtelefono numeric, preceptor_fax_codigopais numeric, preceptor_fax_numtelefono numeric, pcorreoelectronico character varying, preceptor_numero character varying);
DROP FUNCTION IF EXISTS public.update_period_status(nombreperiodo character, idempleadoactualizo integer);
DROP FUNCTION IF EXISTS public.update_period_bill();
DROP FUNCTION IF EXISTS public.update_order_table(pidorden integer, pidfactura integer, pcostounitario numeric, pdescuentoorden numeric, pnumerolineadetalle integer, pcodigoservicio character varying, ptiposervicio character varying, punidadmedida character varying, punidadmedidacomercial character varying, pdetalle text, pmontototal numeric, pmontodescuento numeric, pnaturalezadescuento character varying, psubtotal numeric, pcodigoimpuesto character varying, ptarifa numeric, pmonto numeric, pexoneracion_tipodocumento character varying, pnumerodocumento character varying, pnombreinstitucion character varying, pmontoimpuesto numeric, pporcentajecompra integer, pmontoitotallinea numeric);
DROP FUNCTION IF EXISTS public.update_order_fields(pidorden integer, pcostounitario numeric, pnumerolineadetalle integer, pcodigoservicio character varying, ptiposervicio character varying, punidadmedida character varying, punidadmedidacomercial character varying, pdetalle character varying, pmontototal numeric, pmontodescuento numeric, pnaturalezadescuento character varying, psubtotal numeric, pcodigoimpuesto character varying, ptarifa numeric, pmonto numeric, pnombreinstitucion character varying, pmontoimpuesto numeric, pporcentajecompra integer, pmontoitotallinea numeric);
DROP FUNCTION IF EXISTS public.update_order_cost(ordenactualizar integer);
DROP FUNCTION IF EXISTS public.update_inventory(ordencancelada integer, cantidad integer);
DROP FUNCTION IF EXISTS public.update_insert_inventarioproducto(producto integer, inventario integer, cantidad integer);
DROP FUNCTION IF EXISTS public.update_emisor(p_e_nombre character varying, p_emisor_tipo_identificacion character varying, p_emisor_numero character varying, p_e_nombrecomercial character varying, p_e_provincia integer, p_e_canton integer, p_e_distrito integer, p_e_otras_senas text, p_emisor_telefono_codigopais numeric, p_emisor_telefono_numtelefono numeric, p_emisor_fax_codigopais numeric, p_emisor_fax_numtelefono numeric, p_e_correoelectronico character varying, p_casamatriz character varying, p_puntoventa character varying, p_tipo_producto character varying, p_codigo_producto character varying, p_password_email character varying, p_codigo_actividad character varying);
DROP FUNCTION IF EXISTS public.update_data_users(_user_api character varying, _pwd_api character varying);
DROP FUNCTION IF EXISTS public.reload_inventory(ordencancelada integer, cantidad integer);
DROP FUNCTION IF EXISTS public.new_order_detail();
DROP FUNCTION IF EXISTS public.insertar_nota(pidcuenta integer, pidempleado integer, pidperiodoventa integer, pidreceptor integer, pidemisor integer, pformapago character varying, psubtotal numeric, pporcentajedescuento numeric, pcantidadpersonas integer, pestadofactura integer, pcodigomoneda character varying, ptipocambio numeric, ptotalservgravados numeric, ptotalservexentos numeric, ptotalmercanciasgravadas numeric, ptotalmercanciasexentas numeric, ptotalgravado numeric, ptotalexento numeric, ptotalventa numeric, ptotaldescuentos numeric, ptotalventaneta numeric, ptotalimpuesto numeric, ptotalcomprobante numeric, preceptor_numero character varying, pclavenumerica character varying, pconsecutivo character varying, pplazo_credito integer, pcondicion_venta character varying, pmedio_pago character varying, ptipo character varying, pnum_documento integer, piddetalle integer, preferencia character varying, prazon_nota character varying, ptipo_comprobante character varying);
DROP FUNCTION IF EXISTS public.iddetalle_factura();
DROP FUNCTION IF EXISTS public.get_orders_per_factura(id integer);
DROP FUNCTION IF EXISTS public.data_to_xml(_idfactura integer);
DROP FUNCTION IF EXISTS public.actualizar_campos_factura(ptotalservgravados numeric, ptotalservexentos numeric, ptotalservexonerados numeric, ptotalmercanciasgravadas numeric, ptotalmercanciasexentas numeric, ptotalmercanciasexoneradas numeric, ptotalgravado numeric, ptotalexento numeric, ptotalexonerado numeric, ptotalventa numeric, ptotaldescuentos numeric, ptotalventaneta numeric, ptotalimpuesto numeric, ptotalcomprobante numeric, pidreceptor integer, preceptor_numero character varying, ptipocambio numeric, ptipo character varying);
DROP EXTENSION IF EXISTS plpgsql;
DROP SCHEMA IF EXISTS public;
--
-- TOC entry 3 (class 2615 OID 25046)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 3259 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 1 (class 3079 OID 25047)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3260 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 276 (class 1255 OID 32772)
-- Name: actualizar_campos_factura(numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, integer, character varying, numeric, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.actualizar_campos_factura(ptotalservgravados numeric, ptotalservexentos numeric, ptotalservexonerados numeric, ptotalmercanciasgravadas numeric, ptotalmercanciasexentas numeric, ptotalmercanciasexoneradas numeric, ptotalgravado numeric, ptotalexento numeric, ptotalexonerado numeric, ptotalventa numeric, ptotaldescuentos numeric, ptotalventaneta numeric, ptotalimpuesto numeric, ptotalcomprobante numeric, pidreceptor integer, preceptor_numero character varying, ptipocambio numeric, ptipo character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$DECLARE
 _idfactura INTEGER;
 _idemisor INTEGER;

BEGIN 
     SELECT idfactura INTO _idfactura FROM factura ORDER BY idfactura DESC LIMIT 1;
     SELECT idemisor INTO _idemisor FROM emisor;

     
      
   UPDATE factura SET codigomoneda='CRC', tipocambio=ptipocambio,
   					   totalservgravados=ptotalservgravados,
                       totalservexentos=ptotalservexentos, 
					   totalservexonerados=ptotalservexonerados, 
					   totalmercanciasgravadas=ptotalmercanciasgravadas,
					   totalmercanciasexentas= ptotalmercanciasexentas,
					   totalmercanciasexoneradas=ptotalmercanciasexoneradas, 
					   totalgravado=ptotalgravado, totalexento= ptotalexento,
					   totalexonerado=ptotalexonerado, totalventa= ptotalventa,
					   totaldescuentos= ptotaldescuentos, totalventaneta=ptotalventaneta,
					   totalimpuesto=ptotalimpuesto, totalcomprobante=ptotalcomprobante,
                       idreceptor= pidreceptor, receptor_numero= preceptor_numero,
					   idemisor= _idemisor, num_documento= idfactura, tipo=ptipo
                       
                       WHERE idfactura=_idfactura;
  
                       RETURN 'OK';
END
$$;


--
-- TOC entry 275 (class 1255 OID 25474)
-- Name: data_to_xml(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.data_to_xml(_idfactura integer) RETURNS TABLE(clavenumerica character varying, consecutivo character varying, fecharegistrofactura timestamp without time zone, e_nombre character varying, emisor_tipo_identificacion character varying, emisor_numero character varying, e_nombrecomercial character varying, e_provincia integer, e_canton integer, e_distrito integer, e_otras_senas text, emisor_telefono_codigopais numeric, emisor_telefono_numtelefono numeric, emisor_fax_codigopais numeric, emisor_fax_numtelefono numeric, e_correoelectronico character varying, nombre character varying, receptor_tipo_identificacion character varying, receptor_numero character varying, nombrecomercial character varying, provincia integer, canton integer, distrito integer, otras_senas text, receptor_telefono_codigopais numeric, receptor_telefono_numtelefono numeric, receptor_fax_codigopais numeric, receptor_fax_numtelefono numeric, correoelectronico character varying, condicion_venta character varying, plazo_credito integer, medio_pago character varying, codigomoneda character varying, tipocambio numeric, totalservgravados numeric, totalservexentos numeric, totalmercanciasgravadas numeric, totalmercanciasexentas numeric, totalgravado numeric, totalexento numeric, totalventa numeric, totaldescuentos numeric, totalventaneta numeric, totalimpuesto numeric, totalcomprobante numeric, descripcion_detalle text)
    LANGUAGE plpgsql
    AS $$
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
                   $$;


--
-- TOC entry 274 (class 1255 OID 25473)
-- Name: get_orders_per_factura(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_orders_per_factura(id integer) RETURNS TABLE(j json)
    LANGUAGE plpgsql
    AS $$
BEGIN

  RETURN QUERY SELECT row_to_json(datos) FROM (SELECT o.idfactura ,o.idOrden,o.idcuenta , o.estadoorden, o.preciounitarioproducto, o.costounitarioproducto,
   o.cantidadproducto ,o.codigoservicio, o.tiposervicio, o.unidadmedida, o.unidadmedidacomercial,
   o.naturalezadescuento, o.codigoimpuesto, o.exoneracion_tipodocumento, o.nombreinstitucion, o.montoimpuesto, 
  o.procentajecompra, p.descripcionProducto, f.porcentajedescuento, o.montodescuento, o.descuentoorden, 
  (o.precioUnitarioProducto * o.cantidadProducto) AS subtotal, p.porcentajeimpuesto,
   o.idproducto, f.condicion_venta, f.plazo_credito, e.tipo_producto, e.codigo_producto 
  FROM ORDEN o, factura f, producto p, emisor e 
   WHERE f.idFactura = id 
  AND o.idFactura = f.idFactura 
  AND o.idProducto = p.idProducto 
  AND e.idemisor=1
  ORDER BY o.idOrden DESC) datos;
  
END
$$;


--
-- TOC entry 269 (class 1255 OID 25466)
-- Name: iddetalle_factura(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.iddetalle_factura() RETURNS trigger
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


--
-- TOC entry 273 (class 1255 OID 25472)
-- Name: insertar_nota(integer, integer, integer, integer, integer, character varying, numeric, numeric, integer, integer, character varying, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, character varying, character varying, character varying, integer, character varying, character varying, character varying, integer, integer, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insertar_nota(pidcuenta integer, pidempleado integer, pidperiodoventa integer, pidreceptor integer, pidemisor integer, pformapago character varying, psubtotal numeric, pporcentajedescuento numeric, pcantidadpersonas integer, pestadofactura integer, pcodigomoneda character varying, ptipocambio numeric, ptotalservgravados numeric, ptotalservexentos numeric, ptotalmercanciasgravadas numeric, ptotalmercanciasexentas numeric, ptotalgravado numeric, ptotalexento numeric, ptotalventa numeric, ptotaldescuentos numeric, ptotalventaneta numeric, ptotalimpuesto numeric, ptotalcomprobante numeric, preceptor_numero character varying, pclavenumerica character varying, pconsecutivo character varying, pplazo_credito integer, pcondicion_venta character varying, pmedio_pago character varying, ptipo character varying, pnum_documento integer, piddetalle integer, preferencia character varying, prazon_nota character varying, ptipo_comprobante character varying) RETURNS TABLE(j json)
    LANGUAGE plpgsql
    AS $$
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
  $$;


--
-- TOC entry 249 (class 1255 OID 25455)
-- Name: new_order_detail(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.new_order_detail() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

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
  $$;


--
-- TOC entry 250 (class 1255 OID 25456)
-- Name: reload_inventory(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.reload_inventory(ordencancelada integer, cantidad integer) RETURNS text
    LANGUAGE plpgsql
    AS $$

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
$$;


--
-- TOC entry 272 (class 1255 OID 25471)
-- Name: update_data_users(character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_data_users(_user_api character varying, _pwd_api character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
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

  $$;


--
-- TOC entry 271 (class 1255 OID 25470)
-- Name: update_emisor(character varying, character varying, character varying, character varying, integer, integer, integer, text, numeric, numeric, numeric, numeric, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_emisor(p_e_nombre character varying, p_emisor_tipo_identificacion character varying, p_emisor_numero character varying, p_e_nombrecomercial character varying, p_e_provincia integer, p_e_canton integer, p_e_distrito integer, p_e_otras_senas text, p_emisor_telefono_codigopais numeric, p_emisor_telefono_numtelefono numeric, p_emisor_fax_codigopais numeric, p_emisor_fax_numtelefono numeric, p_e_correoelectronico character varying, p_casamatriz character varying, p_puntoventa character varying, p_tipo_producto character varying, p_codigo_producto character varying, p_password_email character varying, p_codigo_actividad character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
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

$$;


--
-- TOC entry 263 (class 1255 OID 25457)
-- Name: update_insert_inventarioproducto(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_insert_inventarioproducto(producto integer, inventario integer, cantidad integer) RETURNS text
    LANGUAGE plpgsql
    AS $$

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

$$;


--
-- TOC entry 264 (class 1255 OID 25458)
-- Name: update_inventory(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_inventory(ordencancelada integer, cantidad integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
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
$$;


--
-- TOC entry 248 (class 1255 OID 25459)
-- Name: update_order_cost(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_order_cost(ordenactualizar integer) RETURNS text
    LANGUAGE plpgsql
    AS $$

DECLARE

	resultado_txt TEXT DEFAULT 'Resultado OK';

    total decimal(10,2);

BEGIN
    total = (select sum(ip.cantidadnecesaria * i.costoinventario) as total from inventarioproducto ip inner join inventario i on ip.idinventario = i.idinventario WHERE ip.idproducto = (SELECT idproducto FROM orden WHERE idorden = ordenActualizar));

    UPDATE ORDEN SET costounitarioproducto = total WHERE idorden = ordenActualizar; 

    RETURN resultado_txt;

END                                                          

$$;


--
-- TOC entry 268 (class 1255 OID 25464)
-- Name: update_order_fields(integer, numeric, integer, character varying, character varying, character varying, character varying, character varying, numeric, numeric, character varying, numeric, character varying, numeric, numeric, character varying, numeric, integer, numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_order_fields(pidorden integer, pcostounitario numeric, pnumerolineadetalle integer, pcodigoservicio character varying, ptiposervicio character varying, punidadmedida character varying, punidadmedidacomercial character varying, pdetalle character varying, pmontototal numeric, pmontodescuento numeric, pnaturalezadescuento character varying, psubtotal numeric, pcodigoimpuesto character varying, ptarifa numeric, pmonto numeric, pnombreinstitucion character varying, pmontoimpuesto numeric, pporcentajecompra integer, pmontoitotallinea numeric) RETURNS character varying
    LANGUAGE plpgsql
    AS $$

    DECLARE
      _factura INTEGER; -- actualizar el foreign key de la factura con este id
    BEGIN
      SELECT idfactura INTO _factura FROM factura ORDER BY idfactura DESC LIMIT 1; 
      UPDATE orden SET idfactura=_factura, costounitarioproducto=pcostounitario, numerolineadetalle=pnumerolineadetalle, codigoservicio= pcodigoservicio,
              tiposervicio=ptiposervicio, unidadmedida=punidadmedida, unidadmedidacomercial=punidadmedidacomercial,
             detalle=pdetalle, montototal=pmontototal, montodescuento=pmontodescuento, naturalezadescuento=pnaturalezadescuento,
              subtotal=psubtotal, codigoimpuesto=pcodigoimpuesto, tarifa=ptarifa, monto=pmonto, numerodocumento=_factura,
             nombreinstitucion=pnombreinstitucion,
             fechaemision=now(), montoimpuesto=pmontoimpuesto, procentajecompra=pporcentajecompra,
             montoitotallinea=pmontoitotallinea
      WHERE idorden= pidorden;
             
      
      RETURN 'OK';
    END
    
$$;


--
-- TOC entry 265 (class 1255 OID 25460)
-- Name: update_order_table(integer, integer, numeric, numeric, integer, character varying, character varying, character varying, character varying, text, numeric, numeric, character varying, numeric, character varying, numeric, numeric, character varying, character varying, character varying, numeric, integer, numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_order_table(pidorden integer, pidfactura integer, pcostounitario numeric, pdescuentoorden numeric, pnumerolineadetalle integer, pcodigoservicio character varying, ptiposervicio character varying, punidadmedida character varying, punidadmedidacomercial character varying, pdetalle text, pmontototal numeric, pmontodescuento numeric, pnaturalezadescuento character varying, psubtotal numeric, pcodigoimpuesto character varying, ptarifa numeric, pmonto numeric, pexoneracion_tipodocumento character varying, pnumerodocumento character varying, pnombreinstitucion character varying, pmontoimpuesto numeric, pporcentajecompra integer, pmontoitotallinea numeric) RETURNS character varying
    LANGUAGE plpgsql
    AS $$


BEGIN

    UPDATE orden SET idfactura= pidfactura, costounitarioproducto= pcostounitario, descuentoorden=  pdescuentoorden, numerolineadetalle= pnumerolineadetalle,
    codigoservicio= pcodigoservicio, tiposervicio= ptiposervicio, unidadmedida = punidadmedida, unidadmedidacomercial= punidadmedidacomercial, detalle= pdetalle,
    montototal= pmontototal, montodescuento= pmontodescuento, naturalezadescuento= pnaturalezadescuento, subtotal= psubtotal, codigoimpuesto= pcodigoimpuesto,
    tarifa=ptarifa, monto= pmonto, exoneracion_tipodocumento=pexoneracion_tipodocumento, numerodocumento= pnumerodocumento, nombreinstitucion= pnombreinstitucion,
    montoimpuesto= pmontoimpuesto, procentajecompra= pporcentajecompra, montoitotallinea=pmontoitotallinea
      WHERE idorden= pidorden;

     RETURN 'RESULTADO DEVUELTO';

END
$$;


--
-- TOC entry 266 (class 1255 OID 25461)
-- Name: update_period_bill(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_period_bill() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE 

    id_periodo_venta_activo integer;

BEGIN

	id_periodo_venta_activo = (SELECT idperiodoventa FROM periodoventa WHERE estadoperiodoventa = 'Activo');

    NEW.idperiodoventa = id_periodo_venta_activo;

  	RETURN NEW;

END

$$;


--
-- TOC entry 267 (class 1255 OID 25462)
-- Name: update_period_status(character, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_period_status(nombreperiodo character, idempleadoactualizo integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE

	resultado_txt TEXT DEFAULT 'Resultado OK';

BEGIN

	UPDATE PERIODOVENTA SET estadoperiodoventa = 'Finalizado', fechafinperiodoventa = (SELECT NOW()), idEmpleado = idEmpleadoActualizo WHERE estadoperiodoventa = 'Activo';

    INSERT INTO public.PERIODOVENTA (nombreperiodoventa) VALUES (nombreperiodo);

    RETURN resultado_txt;

END
$$;


--
-- TOC entry 270 (class 1255 OID 25469)
-- Name: update_receiver(character varying, character varying, character varying, integer, integer, integer, text, numeric, numeric, numeric, numeric, character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_receiver(pnombre character varying, preceptor_tipo_identificacion character varying, pnombrecomercial character varying, pprovincia integer, pcanton integer, pdistrito integer, potras_senas text, preceptor_telefono_codigopais numeric, preceptor_telefono_numtelefono numeric, preceptor_fax_codigopais numeric, preceptor_fax_numtelefono numeric, pcorreoelectronico character varying, preceptor_numero character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
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
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 235 (class 1259 OID 25359)
-- Name: canton; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.canton (
    id integer NOT NULL,
    codigo_provincia integer NOT NULL,
    codigo_canton integer NOT NULL,
    nombre_canton character varying(45) NOT NULL
);


--
-- TOC entry 213 (class 1259 OID 25189)
-- Name: categoria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categoria (
    idcategoria integer NOT NULL,
    descripcioncategoria character(30)
);


--
-- TOC entry 212 (class 1259 OID 25187)
-- Name: categoria_idcategoria_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categoria_idcategoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3261 (class 0 OID 0)
-- Dependencies: 212
-- Name: categoria_idcategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categoria_idcategoria_seq OWNED BY public.categoria.idcategoria;


--
-- TOC entry 223 (class 1259 OID 25285)
-- Name: categoriainventario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categoriainventario (
    idcategoriainventario integer NOT NULL,
    descripcioncategoriainventario character(30)
);


--
-- TOC entry 222 (class 1259 OID 25283)
-- Name: categoriainventario_idcategoriainventario_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categoriainventario_idcategoriainventario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3262 (class 0 OID 0)
-- Dependencies: 222
-- Name: categoriainventario_idcategoriainventario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categoriainventario_idcategoriainventario_seq OWNED BY public.categoriainventario.idcategoriainventario;


--
-- TOC entry 215 (class 1259 OID 25197)
-- Name: clasificacion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clasificacion (
    id integer NOT NULL,
    nombre_clasificacion character varying(50),
    codigo_impuesto character varying(2),
    descripcion_impuesto character varying(100)
);


--
-- TOC entry 214 (class 1259 OID 25195)
-- Name: clasificacion_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clasificacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3263 (class 0 OID 0)
-- Dependencies: 214
-- Name: clasificacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.clasificacion_id_seq OWNED BY public.clasificacion.id;


--
-- TOC entry 197 (class 1259 OID 25054)
-- Name: cliente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cliente (
    idcliente integer NOT NULL,
    identificacioncliente character(100),
    estadocliente smallint DEFAULT 1
);


--
-- TOC entry 196 (class 1259 OID 25052)
-- Name: cliente_idcliente_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cliente_idcliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3264 (class 0 OID 0)
-- Dependencies: 196
-- Name: cliente_idcliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cliente_idcliente_seq OWNED BY public.cliente.idcliente;


--
-- TOC entry 199 (class 1259 OID 25063)
-- Name: cuenta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cuenta (
    idcuenta integer NOT NULL,
    idcliente integer,
    fechaaperturacuenta timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estadocuenta character(30)
);


--
-- TOC entry 198 (class 1259 OID 25061)
-- Name: cuenta_idcuenta_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cuenta_idcuenta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3265 (class 0 OID 0)
-- Dependencies: 198
-- Name: cuenta_idcuenta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cuenta_idcuenta_seq OWNED BY public.cuenta.idcuenta;


--
-- TOC entry 219 (class 1259 OID 25224)
-- Name: descuento; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.descuento (
    iddescuento integer NOT NULL,
    porcentajedescuento numeric(4,2) NOT NULL,
    descripciondescuento character varying(40) NOT NULL,
    creado_por character varying(40),
    fecha_creacion timestamp without time zone DEFAULT now(),
    estadodescuento boolean DEFAULT true
);


--
-- TOC entry 218 (class 1259 OID 25222)
-- Name: descuento_iddescuento_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.descuento_iddescuento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3266 (class 0 OID 0)
-- Dependencies: 218
-- Name: descuento_iddescuento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.descuento_iddescuento_seq OWNED BY public.descuento.iddescuento;


--
-- TOC entry 238 (class 1259 OID 25371)
-- Name: detalles_orden; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.detalles_orden (
    iddetalle integer NOT NULL,
    descripcion_detalle text
);


--
-- TOC entry 237 (class 1259 OID 25369)
-- Name: detalles_orden_iddetalle_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.detalles_orden_iddetalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3267 (class 0 OID 0)
-- Dependencies: 237
-- Name: detalles_orden_iddetalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.detalles_orden_iddetalle_seq OWNED BY public.detalles_orden.iddetalle;


--
-- TOC entry 236 (class 1259 OID 25364)
-- Name: distrito; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.distrito (
    id integer NOT NULL,
    codigo_provincia integer,
    codigo_canton integer,
    codigo_distrito integer,
    nombre_distrito character varying(70)
);


--
-- TOC entry 209 (class 1259 OID 25126)
-- Name: emisor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.emisor (
    idemisor integer NOT NULL,
    e_nombre character varying(80) NOT NULL,
    emisor_tipo_identificacion character varying(2) NOT NULL,
    emisor_numero character varying(12) NOT NULL,
    e_nombrecomercial character varying(80),
    e_provincia integer NOT NULL,
    e_canton integer NOT NULL,
    e_distrito integer NOT NULL,
    e_otras_senas text,
    emisor_telefono_codigopais numeric(3,0),
    emisor_telefono_numtelefono numeric(20,0),
    emisor_fax_codigopais numeric(3,0),
    emisor_fax_numtelefono numeric(20,0),
    e_correoelectronico character varying(60),
    file_p12 character varying(16),
    key_username character varying(52),
    key_password character varying(20),
    pin_p12 character varying(4),
    casamatriz character varying(3),
    puntoventa character varying(5),
    tipo_producto character varying(2),
    codigo_producto character varying(50),
    codigo_actividad character varying(6),
    password_email character varying(150),
    idfile integer,
    downloadcode character varying(64),
    iduserapi integer,
    acercade character varying(16),
    ubicacion character varying(16)
);


--
-- TOC entry 208 (class 1259 OID 25124)
-- Name: emisor_idemisor_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.emisor_idemisor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3268 (class 0 OID 0)
-- Dependencies: 208
-- Name: emisor_idemisor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.emisor_idemisor_seq OWNED BY public.emisor.idemisor;


--
-- TOC entry 201 (class 1259 OID 25077)
-- Name: empleado; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.empleado (
    idempleado integer NOT NULL,
    nombreempleado character(50),
    apellidoempleado character(50),
    passwordempleado character(50),
    idpuesto integer NOT NULL,
    estadoempleado smallint DEFAULT 1
);


--
-- TOC entry 200 (class 1259 OID 25075)
-- Name: empleado_idempleado_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.empleado_idempleado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3269 (class 0 OID 0)
-- Dependencies: 200
-- Name: empleado_idempleado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.empleado_idempleado_seq OWNED BY public.empleado.idempleado;


--
-- TOC entry 211 (class 1259 OID 25137)
-- Name: factura; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.factura (
    idfactura integer NOT NULL,
    idcuenta integer,
    idempleado integer,
    idperiodoventa integer,
    idreceptor integer,
    idemisor integer,
    fecharegistrofactura timestamp without time zone DEFAULT now(),
    formapago character(10),
    subtotal numeric(10,2),
    porcentajedescuento numeric(5,2),
    cantidadpersonas integer,
    estadofactura smallint DEFAULT 1,
    codigomoneda character varying(3) DEFAULT '500'::character varying NOT NULL,
    tipocambio numeric(18,5) DEFAULT 1 NOT NULL,
    totalservgravados numeric(18,5) DEFAULT 1 NOT NULL,
    totalservexentos numeric(18,5) DEFAULT 1 NOT NULL,
    totalmercanciasgravadas numeric(18,5) DEFAULT 1 NOT NULL,
    totalmercanciasexentas numeric(18,5) DEFAULT 1 NOT NULL,
    totalgravado numeric(18,5) DEFAULT 1 NOT NULL,
    totalexento numeric(18,5) DEFAULT 1 NOT NULL,
    totalventa numeric(18,5) DEFAULT 1 NOT NULL,
    totaldescuentos numeric(18,5) DEFAULT 1 NOT NULL,
    totalventaneta numeric(18,5) DEFAULT 1 NOT NULL,
    totalimpuesto numeric(18,5) DEFAULT 1 NOT NULL,
    totalcomprobante numeric(18,5) DEFAULT 1 NOT NULL,
    condicion_venta character varying(2),
    plazo_credito integer DEFAULT 0,
    medio_pago character varying(2),
    tipo character varying(2),
    status integer,
    razon character varying(300),
    referencia character varying(2),
    razon_nota character varying(500),
    tipo_comprobante character varying(2),
    iddetalle integer DEFAULT 0,
    receptor_numero character varying(12),
    clavenumerica character varying(50),
    consecutivo character varying(20),
    num_documento integer DEFAULT 0,
    totalservexonerados numeric(18,5),
    totalmercanciasexoneradas numeric(18,5),
    totalexonerado numeric(18,5)
);


--
-- TOC entry 210 (class 1259 OID 25135)
-- Name: factura_idfactura_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.factura_idfactura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3270 (class 0 OID 0)
-- Dependencies: 210
-- Name: factura_idfactura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.factura_idfactura_seq OWNED BY public.factura.idfactura;


--
-- TOC entry 239 (class 1259 OID 25380)
-- Name: fila; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fila (
    idorden integer
);


--
-- TOC entry 233 (class 1259 OID 25349)
-- Name: gasto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gasto (
    idgasto integer NOT NULL,
    idtipogasto integer,
    descripciongasto character(50),
    estadogasto character(20),
    montogasto numeric(10,2),
    fechagasto timestamp without time zone DEFAULT now(),
    observaciongasto character(100)
);


--
-- TOC entry 232 (class 1259 OID 25347)
-- Name: gasto_idgasto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gasto_idgasto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3271 (class 0 OID 0)
-- Dependencies: 232
-- Name: gasto_idgasto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gasto_idgasto_seq OWNED BY public.gasto.idgasto;


--
-- TOC entry 245 (class 1259 OID 25414)
-- Name: impuesto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.impuesto (
    idimpuesto integer NOT NULL,
    codigo_impuesto character varying(2) NOT NULL,
    nombre character varying(50) NOT NULL,
    estadoimpuesto boolean DEFAULT true
);


--
-- TOC entry 244 (class 1259 OID 25412)
-- Name: impuesto_idimpuesto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.impuesto_idimpuesto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3272 (class 0 OID 0)
-- Dependencies: 244
-- Name: impuesto_idimpuesto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.impuesto_idimpuesto_seq OWNED BY public.impuesto.idimpuesto;


--
-- TOC entry 225 (class 1259 OID 25293)
-- Name: inventario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventario (
    idinventario integer NOT NULL,
    idcategoriainventario integer,
    descripcioninventario character(50),
    costoinventario numeric(10,2),
    cantidaddisponibleinventario numeric(10,2),
    cantidadminimainventario numeric(10,2),
    unidad character(10),
    codigobarrainventario character(50),
    estadoinventario smallint DEFAULT 1
);


--
-- TOC entry 224 (class 1259 OID 25291)
-- Name: inventario_idinventario_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventario_idinventario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3273 (class 0 OID 0)
-- Dependencies: 224
-- Name: inventario_idinventario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventario_idinventario_seq OWNED BY public.inventario.idinventario;


--
-- TOC entry 226 (class 1259 OID 25305)
-- Name: inventarioproducto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventarioproducto (
    idinventario integer,
    idproducto integer,
    cantidadnecesaria numeric(8,2)
);


--
-- TOC entry 221 (class 1259 OID 25234)
-- Name: orden; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orden (
    idorden integer NOT NULL,
    idcuenta integer,
    idproducto integer,
    idfactura integer,
    cantidadproducto integer NOT NULL,
    estadoorden character(10),
    fecharegistroorden timestamp without time zone DEFAULT now(),
    preciounitarioproducto numeric(10,2) DEFAULT 0,
    costounitarioproducto numeric(10,2) DEFAULT 0,
    descuentoorden numeric(4,2) DEFAULT 0,
    numerolineadetalle integer DEFAULT 1 NOT NULL,
    codigoservicio character varying(50) DEFAULT 1 NOT NULL,
    tiposervicio character varying(2) DEFAULT '2'::character varying NOT NULL,
    unidadmedida character varying(20) DEFAULT '1'::character varying NOT NULL,
    unidadmedidacomercial character varying(20) DEFAULT '1'::character varying NOT NULL,
    detalle text DEFAULT '1'::text NOT NULL,
    montototal numeric(18,5) DEFAULT 1 NOT NULL,
    montodescuento numeric(18,5) DEFAULT 1 NOT NULL,
    naturalezadescuento character varying(80) DEFAULT '1'::character varying NOT NULL,
    subtotal numeric(18,5) DEFAULT 1 NOT NULL,
    codigoimpuesto character varying(2) DEFAULT '1'::character varying NOT NULL,
    tarifa numeric(8,2) DEFAULT 1 NOT NULL,
    monto numeric(18,5) DEFAULT 1 NOT NULL,
    exoneracion_tipodocumento character varying(2) DEFAULT '1'::character varying NOT NULL,
    numerodocumento character varying(17) DEFAULT '1'::character varying NOT NULL,
    nombreinstitucion character varying(160) DEFAULT '1'::character varying NOT NULL,
    fechaemision timestamp without time zone DEFAULT now() NOT NULL,
    montoimpuesto numeric(18,5) DEFAULT 1 NOT NULL,
    procentajecompra integer DEFAULT 1 NOT NULL,
    montoitotallinea numeric(18,5) DEFAULT 1 NOT NULL,
    iddetalle integer DEFAULT 0,
    baseimponible numeric(18,5)
);


--
-- TOC entry 220 (class 1259 OID 25232)
-- Name: orden_idorden_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orden_idorden_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3274 (class 0 OID 0)
-- Dependencies: 220
-- Name: orden_idorden_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orden_idorden_seq OWNED BY public.orden.idorden;


--
-- TOC entry 203 (class 1259 OID 25086)
-- Name: periodoventa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.periodoventa (
    idperiodoventa integer NOT NULL,
    nombreperiodoventa character(50),
    estadoperiodoventa character(10) DEFAULT 'Activo'::bpchar,
    fechainicioperiodoventa timestamp without time zone DEFAULT now(),
    fechafinperiodoventa timestamp without time zone,
    idempleado integer
);


--
-- TOC entry 202 (class 1259 OID 25084)
-- Name: periodoventa_idperiodoventa_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.periodoventa_idperiodoventa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3275 (class 0 OID 0)
-- Dependencies: 202
-- Name: periodoventa_idperiodoventa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.periodoventa_idperiodoventa_seq OWNED BY public.periodoventa.idperiodoventa;


--
-- TOC entry 217 (class 1259 OID 25205)
-- Name: producto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.producto (
    idproducto integer NOT NULL,
    descripcionproducto character(50),
    idcategoria integer,
    precioproducto integer,
    codigobarraproducto character(50),
    estadoproducto smallint DEFAULT 1,
    tipo_impuesto character varying(2),
    montoimpuesto numeric(10,5),
    unidadmedida character varying(20),
    unidadmedidacomercial character varying(20),
    costounitario integer,
    porcentajeimpuesto numeric(10,5),
    tipo_producto character varying(2),
    codigoproducto character varying(24),
    precio_ivi integer,
    idclasificacion integer,
    impuestoneto numeric(18,5)
);


--
-- TOC entry 216 (class 1259 OID 25203)
-- Name: producto_idproducto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.producto_idproducto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3276 (class 0 OID 0)
-- Dependencies: 216
-- Name: producto_idproducto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.producto_idproducto_seq OWNED BY public.producto.idproducto;


--
-- TOC entry 228 (class 1259 OID 25320)
-- Name: proveedor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.proveedor (
    idproveedor integer NOT NULL,
    empresa character(50),
    nombrecontacto character(100),
    contactoproveedor1 character(20),
    contactoproveedor2 character(20),
    correoproveedor character(20),
    observacionproveedor character(100),
    estadoproveedor smallint DEFAULT 1
);


--
-- TOC entry 227 (class 1259 OID 25318)
-- Name: proveedor_idproveedor_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.proveedor_idproveedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3277 (class 0 OID 0)
-- Dependencies: 227
-- Name: proveedor_idproveedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.proveedor_idproveedor_seq OWNED BY public.proveedor.idproveedor;


--
-- TOC entry 229 (class 1259 OID 25327)
-- Name: proveedorinventario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.proveedorinventario (
    idproveedor integer,
    idinventario integer,
    cantidadproducto numeric(10,2),
    fecharegistro timestamp without time zone DEFAULT now(),
    costounitario numeric(10,2)
);


--
-- TOC entry 234 (class 1259 OID 25354)
-- Name: provincia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.provincia (
    id integer NOT NULL,
    codigo_provincia integer NOT NULL,
    nombre_provincia character varying(20) NOT NULL
);


--
-- TOC entry 205 (class 1259 OID 25101)
-- Name: puesto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.puesto (
    idpuesto integer NOT NULL,
    descripcionpuesto character(50),
    departamentopuesto character(50)
);


--
-- TOC entry 204 (class 1259 OID 25099)
-- Name: puesto_idpuesto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.puesto_idpuesto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3278 (class 0 OID 0)
-- Dependencies: 204
-- Name: puesto_idpuesto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.puesto_idpuesto_seq OWNED BY public.puesto.idpuesto;


--
-- TOC entry 207 (class 1259 OID 25114)
-- Name: receptor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.receptor (
    idreceptor integer NOT NULL,
    nombre character varying(80) NOT NULL,
    receptor_tipo_identificacion character varying(2) NOT NULL,
    receptor_numero character varying(12) NOT NULL,
    nombrecomercial character varying(80),
    provincia integer NOT NULL,
    canton integer NOT NULL,
    distrito integer NOT NULL,
    otras_senas text,
    receptor_telefono_codigopais numeric(3,0),
    receptor_telefono_numtelefono numeric(20,0),
    receptor_fax_codigopais numeric(3,0),
    receptor_fax_numtelefono numeric(20,0),
    correoelectronico character varying(60),
    estado smallint DEFAULT 1,
    identificacion_extranjero character varying(12),
    otras_senas_extranjero text
);


--
-- TOC entry 206 (class 1259 OID 25112)
-- Name: receptor_idreceptor_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.receptor_idreceptor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3279 (class 0 OID 0)
-- Dependencies: 206
-- Name: receptor_idreceptor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.receptor_idreceptor_seq OWNED BY public.receptor.idreceptor;


--
-- TOC entry 231 (class 1259 OID 25343)
-- Name: tipogasto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tipogasto (
    idtipogasto integer NOT NULL,
    descripciontipogasto character(50)
);


--
-- TOC entry 230 (class 1259 OID 25341)
-- Name: tipogasto_idtipogasto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tipogasto_idtipogasto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3280 (class 0 OID 0)
-- Dependencies: 230
-- Name: tipogasto_idtipogasto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tipogasto_idtipogasto_seq OWNED BY public.tipogasto.idtipogasto;


--
-- TOC entry 247 (class 1259 OID 25423)
-- Name: tipoimpuesto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tipoimpuesto (
    idtipoimpuesto integer NOT NULL,
    idimpuesto integer NOT NULL,
    descripcionimpuesto character varying(50) NOT NULL,
    porcentajetipoimpuesto numeric(5,2) NOT NULL,
    estadotipoimpuesto boolean DEFAULT true
);


--
-- TOC entry 246 (class 1259 OID 25421)
-- Name: tipoimpuesto_idtipoimpuesto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tipoimpuesto_idtipoimpuesto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3281 (class 0 OID 0)
-- Dependencies: 246
-- Name: tipoimpuesto_idtipoimpuesto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tipoimpuesto_idtipoimpuesto_seq OWNED BY public.tipoimpuesto.idtipoimpuesto;


--
-- TOC entry 243 (class 1259 OID 25401)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    iduser integer NOT NULL,
    idemisor integer,
    user_api character varying(10),
    pwd_api character varying(10)
);


--
-- TOC entry 242 (class 1259 OID 25399)
-- Name: users_iduser_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_iduser_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3282 (class 0 OID 0)
-- Dependencies: 242
-- Name: users_iduser_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_iduser_seq OWNED BY public.users.iduser;


--
-- TOC entry 241 (class 1259 OID 25385)
-- Name: xml; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.xml (
    idxml integer NOT NULL,
    idfactura integer,
    xml text
);


--
-- TOC entry 240 (class 1259 OID 25383)
-- Name: xml_idxml_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.xml_idxml_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3283 (class 0 OID 0)
-- Dependencies: 240
-- Name: xml_idxml_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.xml_idxml_seq OWNED BY public.xml.idxml;


--
-- TOC entry 2961 (class 2604 OID 25192)
-- Name: categoria idcategoria; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria ALTER COLUMN idcategoria SET DEFAULT nextval('public.categoria_idcategoria_seq'::regclass);


--
-- TOC entry 2994 (class 2604 OID 25288)
-- Name: categoriainventario idcategoriainventario; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoriainventario ALTER COLUMN idcategoriainventario SET DEFAULT nextval('public.categoriainventario_idcategoriainventario_seq'::regclass);


--
-- TOC entry 2962 (class 2604 OID 25200)
-- Name: clasificacion id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clasificacion ALTER COLUMN id SET DEFAULT nextval('public.clasificacion_id_seq'::regclass);


--
-- TOC entry 2929 (class 2604 OID 25057)
-- Name: cliente idcliente; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cliente ALTER COLUMN idcliente SET DEFAULT nextval('public.cliente_idcliente_seq'::regclass);


--
-- TOC entry 2931 (class 2604 OID 25066)
-- Name: cuenta idcuenta; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cuenta ALTER COLUMN idcuenta SET DEFAULT nextval('public.cuenta_idcuenta_seq'::regclass);


--
-- TOC entry 2965 (class 2604 OID 25227)
-- Name: descuento iddescuento; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.descuento ALTER COLUMN iddescuento SET DEFAULT nextval('public.descuento_iddescuento_seq'::regclass);


--
-- TOC entry 3003 (class 2604 OID 25374)
-- Name: detalles_orden iddetalle; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalles_orden ALTER COLUMN iddetalle SET DEFAULT nextval('public.detalles_orden_iddetalle_seq'::regclass);


--
-- TOC entry 2941 (class 2604 OID 25129)
-- Name: emisor idemisor; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.emisor ALTER COLUMN idemisor SET DEFAULT nextval('public.emisor_idemisor_seq'::regclass);


--
-- TOC entry 2933 (class 2604 OID 25080)
-- Name: empleado idempleado; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empleado ALTER COLUMN idempleado SET DEFAULT nextval('public.empleado_idempleado_seq'::regclass);


--
-- TOC entry 2942 (class 2604 OID 25140)
-- Name: factura idfactura; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factura ALTER COLUMN idfactura SET DEFAULT nextval('public.factura_idfactura_seq'::regclass);


--
-- TOC entry 3002 (class 2604 OID 25352)
-- Name: gasto idgasto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gasto ALTER COLUMN idgasto SET DEFAULT nextval('public.gasto_idgasto_seq'::regclass);


--
-- TOC entry 3006 (class 2604 OID 25417)
-- Name: impuesto idimpuesto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impuesto ALTER COLUMN idimpuesto SET DEFAULT nextval('public.impuesto_idimpuesto_seq'::regclass);


--
-- TOC entry 2995 (class 2604 OID 25296)
-- Name: inventario idinventario; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventario ALTER COLUMN idinventario SET DEFAULT nextval('public.inventario_idinventario_seq'::regclass);


--
-- TOC entry 2969 (class 2604 OID 25237)
-- Name: orden idorden; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden ALTER COLUMN idorden SET DEFAULT nextval('public.orden_idorden_seq'::regclass);


--
-- TOC entry 2935 (class 2604 OID 25089)
-- Name: periodoventa idperiodoventa; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periodoventa ALTER COLUMN idperiodoventa SET DEFAULT nextval('public.periodoventa_idperiodoventa_seq'::regclass);


--
-- TOC entry 2963 (class 2604 OID 25208)
-- Name: producto idproducto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producto ALTER COLUMN idproducto SET DEFAULT nextval('public.producto_idproducto_seq'::regclass);


--
-- TOC entry 2997 (class 2604 OID 25323)
-- Name: proveedor idproveedor; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proveedor ALTER COLUMN idproveedor SET DEFAULT nextval('public.proveedor_idproveedor_seq'::regclass);


--
-- TOC entry 2938 (class 2604 OID 25104)
-- Name: puesto idpuesto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.puesto ALTER COLUMN idpuesto SET DEFAULT nextval('public.puesto_idpuesto_seq'::regclass);


--
-- TOC entry 2939 (class 2604 OID 25117)
-- Name: receptor idreceptor; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receptor ALTER COLUMN idreceptor SET DEFAULT nextval('public.receptor_idreceptor_seq'::regclass);


--
-- TOC entry 3000 (class 2604 OID 25346)
-- Name: tipogasto idtipogasto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipogasto ALTER COLUMN idtipogasto SET DEFAULT nextval('public.tipogasto_idtipogasto_seq'::regclass);


--
-- TOC entry 3008 (class 2604 OID 25426)
-- Name: tipoimpuesto idtipoimpuesto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipoimpuesto ALTER COLUMN idtipoimpuesto SET DEFAULT nextval('public.tipoimpuesto_idtipoimpuesto_seq'::regclass);


--
-- TOC entry 3005 (class 2604 OID 25404)
-- Name: users iduser; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN iduser SET DEFAULT nextval('public.users_iduser_seq'::regclass);


--
-- TOC entry 3004 (class 2604 OID 25388)
-- Name: xml idxml; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.xml ALTER COLUMN idxml SET DEFAULT nextval('public.xml_idxml_seq'::regclass);


--
-- TOC entry 3240 (class 0 OID 25359)
-- Dependencies: 235
-- Data for Name: canton; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (1, 1, 1, 'San José');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (2, 1, 2, 'Escazú');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (3, 1, 3, 'Desamparados');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (4, 1, 4, 'Puriscal');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (5, 1, 5, 'Tarrazú');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (6, 1, 6, 'Aserrí');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (7, 1, 7, 'Mora');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (8, 1, 8, 'Goicoechea');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (9, 1, 9, 'Santa Ana');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (10, 1, 10, 'Alajuelita');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (11, 1, 11, 'Vásquez de Coronado');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (12, 1, 12, 'Acosta');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (13, 1, 13, 'Tibás');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (14, 1, 14, 'Moravia');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (15, 1, 15, 'Montes de Oca');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (16, 1, 16, 'Turrubares');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (17, 1, 17, 'Dota');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (18, 1, 18, 'Curridabat');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (19, 1, 19, 'Pérez Zeledón');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (20, 1, 20, 'León Cortéz Castro');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (21, 2, 1, 'Alajuela');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (22, 2, 2, 'San Ramón');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (23, 2, 3, 'Grecia');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (24, 2, 4, 'San Mateo');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (25, 2, 5, 'Atenas');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (26, 2, 6, 'Naranjo');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (27, 2, 7, 'Palmares');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (28, 2, 8, 'Poás');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (29, 2, 9, 'Orotina');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (30, 2, 10, 'San Carlos');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (31, 2, 11, 'Zarcero');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (32, 2, 12, 'Valverde Vega');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (33, 2, 13, 'Upala');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (34, 2, 14, 'Los Chiles');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (35, 2, 15, 'Guatuso');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (36, 3, 1, 'Cartago');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (37, 3, 2, 'Paraíso');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (38, 3, 3, 'La Unión');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (39, 3, 4, 'Jiménez');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (40, 3, 5, 'Turrialba');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (41, 3, 6, 'Alvarado');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (42, 3, 7, 'Oreamuno');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (43, 3, 8, 'El Guarco');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (44, 4, 1, 'Heredia');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (45, 4, 2, 'Barva');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (46, 4, 3, 'Santo Domingo');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (47, 4, 4, 'Santa Bárbara');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (48, 4, 5, 'San Rafaél');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (49, 4, 6, 'San Isidro');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (50, 4, 7, 'Belén');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (51, 4, 8, 'Flores');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (52, 4, 9, 'San Pablo');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (53, 4, 10, 'Sarapiquí');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (54, 5, 1, 'Liberia');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (55, 5, 2, 'Nicoya');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (56, 5, 3, 'Santa Cruz');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (57, 5, 4, 'Bagaces');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (58, 5, 5, 'Carrillo');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (59, 5, 6, 'Cañas');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (60, 5, 7, 'Abangáres');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (61, 5, 8, 'Tilarán');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (62, 5, 9, 'Nandayure');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (63, 5, 10, 'La Cruz');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (64, 5, 11, 'Hojancha');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (65, 6, 1, 'Puntarenas');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (66, 6, 2, 'Esparza');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (67, 6, 3, 'Buenos Aires');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (68, 6, 4, 'Montes de Oro');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (69, 6, 5, 'Osa');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (70, 6, 6, 'Aguirre');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (71, 6, 7, 'Golfito');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (72, 6, 8, 'Coto Brus');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (73, 6, 9, 'Parrita');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (74, 6, 10, 'Corredores');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (75, 6, 11, 'Garabito');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (76, 7, 1, 'Limón');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (77, 7, 2, 'Pococí');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (78, 7, 3, 'Siquirres');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (79, 7, 4, 'Talamanca');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (80, 7, 5, 'Matina');
INSERT INTO public.canton (id, codigo_provincia, codigo_canton, nombre_canton) VALUES (81, 7, 6, 'Guácimo');


--
-- TOC entry 3218 (class 0 OID 25189)
-- Dependencies: 213
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categoria (idcategoria, descripcioncategoria) VALUES (1, 'Ron                           ');
INSERT INTO public.categoria (idcategoria, descripcioncategoria) VALUES (2, 'Whisky                        ');
INSERT INTO public.categoria (idcategoria, descripcioncategoria) VALUES (3, 'Vodka                         ');
INSERT INTO public.categoria (idcategoria, descripcioncategoria) VALUES (4, 'Cacique                       ');
INSERT INTO public.categoria (idcategoria, descripcioncategoria) VALUES (5, 'Tequila                       ');
INSERT INTO public.categoria (idcategoria, descripcioncategoria) VALUES (6, 'Jager                         ');
INSERT INTO public.categoria (idcategoria, descripcioncategoria) VALUES (7, 'Especiales                    ');
INSERT INTO public.categoria (idcategoria, descripcioncategoria) VALUES (8, 'Botellitas                    ');


--
-- TOC entry 3228 (class 0 OID 25285)
-- Dependencies: 223
-- Data for Name: categoriainventario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categoriainventario (idcategoriainventario, descripcioncategoriainventario) VALUES (1, 'Consumibles                   ');
INSERT INTO public.categoriainventario (idcategoriainventario, descripcioncategoriainventario) VALUES (2, 'Desechables                   ');
INSERT INTO public.categoriainventario (idcategoriainventario, descripcioncategoriainventario) VALUES (3, 'Licor                         ');
INSERT INTO public.categoriainventario (idcategoriainventario, descripcioncategoriainventario) VALUES (4, 'Frescos                       ');
INSERT INTO public.categoriainventario (idcategoriainventario, descripcioncategoriainventario) VALUES (5, 'Gaseosos                      ');
INSERT INTO public.categoriainventario (idcategoriainventario, descripcioncategoriainventario) VALUES (6, 'Hielo                         ');
INSERT INTO public.categoriainventario (idcategoriainventario, descripcioncategoriainventario) VALUES (7, 'Jugos y Cremas                ');


--
-- TOC entry 3220 (class 0 OID 25197)
-- Dependencies: 215
-- Data for Name: clasificacion; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.clasificacion (id, nombre_clasificacion, codigo_impuesto, descripcion_impuesto) VALUES (64, 'SELECTIVO DE CONSUMO', '02', 'Impuesto Selectivo de Consumo');
INSERT INTO public.clasificacion (id, nombre_clasificacion, codigo_impuesto, descripcion_impuesto) VALUES (67, 'VALOR AGREGADO', '01', 'Impuesto al Valor Agregado');
INSERT INTO public.clasificacion (id, nombre_clasificacion, codigo_impuesto, descripcion_impuesto) VALUES (65, 'IMPUESTO TBCO', '06', 'Impuesto a los Productos de Tabaco');
INSERT INTO public.clasificacion (id, nombre_clasificacion, codigo_impuesto, descripcion_impuesto) VALUES (69, 'COMBUSTIBLES', '03', 'Impuesto Unico a los Combustibles');


--
-- TOC entry 3202 (class 0 OID 25054)
-- Dependencies: 197
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.cliente (idcliente, identificacioncliente, estadocliente) VALUES (1, 'cliente default                                                                                     ', 1);


--
-- TOC entry 3204 (class 0 OID 25063)
-- Dependencies: 199
-- Data for Name: cuenta; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.cuenta (idcuenta, idcliente, fechaaperturacuenta, estadocuenta) VALUES (1, 1, '2018-08-02 11:03:11.148049', 'Activa                        ');


--
-- TOC entry 3224 (class 0 OID 25224)
-- Dependencies: 219
-- Data for Name: descuento; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.descuento (iddescuento, porcentajedescuento, descripciondescuento, creado_por, fecha_creacion, estadodescuento) VALUES (2, 45.00, 'dia del padre', 'Nombre', '2019-07-16 15:01:09.320404', true);
INSERT INTO public.descuento (iddescuento, porcentajedescuento, descripciondescuento, creado_por, fecha_creacion, estadodescuento) VALUES (3, 15.00, 'nuevo', 'Nombre', '2019-07-18 21:56:11.620598', true);
INSERT INTO public.descuento (iddescuento, porcentajedescuento, descripciondescuento, creado_por, fecha_creacion, estadodescuento) VALUES (1, 25.00, 'navideño', 'Nombre', '2019-07-12 14:48:23.0323', true);
INSERT INTO public.descuento (iddescuento, porcentajedescuento, descripciondescuento, creado_por, fecha_creacion, estadodescuento) VALUES (5, 20.00, 'descuento1', 'LUis Vargas', '2019-08-07 12:42:34.918457', true);


--
-- TOC entry 3243 (class 0 OID 25371)
-- Dependencies: 238
-- Data for Name: detalles_orden; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (1, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (2, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (3, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (4, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (5, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (6, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (7, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (8, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (9, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (10, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (11, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (12, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (13, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (14, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (15, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (16, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (17, '[object Object]');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (18, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1560.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (19, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1560.00"},"1":{"codigo":"a62cwes","codigoComercial":{"tipo":"2","codigo":"a62cwes"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"kg","detalle":"producto 33                                       ","precioUnitario":"2000.00","montoTotal":2000,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":2000,"impuesto":{"1":{"codigo":"06","tarifa":13,"monto":260}},"impuestoNeto":"","montoTotalLinea":"2260.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (20, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1560.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (21, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1560.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (22, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1560.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (23, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1560.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (24, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1560.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (25, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1560.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (26, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1560.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (27, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1560.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (28, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"baseImponible":1500,"impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":1,"monto":15}},"impuestoNeto":"","montoTotalLinea":"1515.00"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1560.00"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"kg","detalle":"producto 33                                       ","precioUnitario":"2000.00","montoTotal":2000,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":2000,"impuesto":{"1":{"codigo":"06","tarifa":13,"monto":260}},"impuestoNeto":"","montoTotalLinea":"2260.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (29, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"baseImponible":1500,"impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":1,"monto":15}},"impuestoNeto":"","montoTotalLinea":"1515.00"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"kg","detalle":"producto 33                                       ","precioUnitario":"2000.00","montoTotal":2000,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":2000,"impuesto":{"1":{"codigo":"06","tarifa":13,"monto":260}},"impuestoNeto":"","montoTotalLinea":"2260.00"},"2":{"codigo":"a62cwes","codigoComercial":{"tipo":"2","codigo":"a62cwes"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (30, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1560.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (31, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1560.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (32, '{"0":{"codigo":"a62cwes","codigoComercial":{"tipo":"2","codigo":"a62cwes"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1560.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (33, '{"0":{"codigo":"a62cwes","codigoComercial":{"tipo":"2","codigo":"a62cwes"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":1.5,"naturalezaDescuento":"Descuento general"},"subTotal":13.5,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"15.45"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (34, '{"0":{"codigo":"a62cwes","codigoComercial":{"tipo":"2","codigo":"a62cwes"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (35, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":1500,"baseImponible":1500,"impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":1,"monto":15}},"impuestoNeto":"","montoTotalLinea":"1515.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (36, '{"0":{"codigo":"21a2s1","codigoComercial":{"tipo":"2","codigo":"21a2s1"},"cantidad":1,"unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":20,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":20,"baseImponible":20,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":2.6}},"impuestoNeto":"","montoTotalLinea":"22.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (37, '{"0":{"codigo":"a62cwes","codigoComercial":{"tipo":"2","codigo":"a62cwes"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":1.5,"naturalezaDescuento":"Descuento general"},"subTotal":13.5,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"15.45"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (38, '{"0":{"codigo":"a62cwes","codigoComercial":{"tipo":"2","codigo":"a62cwes"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (39, '{"0":{"codigo":"06","codigoComercial":{"tipo":"2","codigo":"06"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":675,"naturalezaDescuento":"Descuento general"},"subTotal":825,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"885.00"},"1":{"codigo":"06","codigoComercial":{"tipo":"1","codigo":"06"},"cantidad":1,"unidadMedida":"kg","detalle":"producto 33                                       ","precioUnitario":"2000.00","montoTotal":2000,"descuento":{"montoDescuento":500,"naturalezaDescuento":"Descuento general"},"subTotal":1500,"impuesto":{"1":{"codigo":"06","tarifa":13,"monto":260}},"impuestoNeto":"","montoTotalLinea":"1760.00"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":225,"naturalezaDescuento":"Descuento general"},"subTotal":1275,"baseImponible":1500,"impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":1,"monto":15}},"impuestoNeto":"","montoTotalLinea":"1290.00"},"3":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":3,"naturalezaDescuento":"Descuento general"},"subTotal":12,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"13.95"},"4":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":20,"descuento":{"montoDescuento":5,"naturalezaDescuento":"Descuento general"},"subTotal":15,"baseImponible":20,"impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":13,"monto":2.6}},"impuestoNeto":"","montoTotalLinea":"17.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (40, '{"0":{"codigo":"06","codigoComercial":{"tipo":"2","codigo":"06"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":375,"naturalezaDescuento":"Descuento general"},"subTotal":1125,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1185.00"},"1":{"codigo":"06","codigoComercial":{"tipo":"1","codigo":"06"},"cantidad":1,"unidadMedida":"kg","detalle":"producto 33                                       ","precioUnitario":"2000.00","montoTotal":2000,"descuento":{"montoDescuento":900,"naturalezaDescuento":"Descuento general"},"subTotal":1100,"impuesto":{"1":{"codigo":"06","tarifa":13,"monto":260}},"impuestoNeto":"","montoTotalLinea":"1360.00"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":225,"naturalezaDescuento":"Descuento general"},"subTotal":1275,"baseImponible":1500,"impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":1,"monto":15}},"impuestoNeto":"","montoTotalLinea":"1290.00"},"3":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":3,"naturalezaDescuento":"Descuento general"},"subTotal":12,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"13.95"},"4":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":20,"descuento":{"montoDescuento":5,"naturalezaDescuento":"Descuento general"},"subTotal":15,"baseImponible":20,"impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":13,"monto":2.6}},"impuestoNeto":"","montoTotalLinea":"17.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (41, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (42, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (43, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (44, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (45, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (46, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (47, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (48, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (49, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (50, '{"0":{"codigo":"06","codigoComercial":{"tipo":"2","codigo":"06"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":375,"naturalezaDescuento":"Descuento general"},"subTotal":1125,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1185.00"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":3,"naturalezaDescuento":"Descuento general"},"subTotal":12,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"13.95"},"2":{"codigo":"06","codigoComercial":{"tipo":"1","codigo":"06"},"cantidad":1,"unidadMedida":"kg","detalle":"producto 33                                       ","precioUnitario":"2000.00","montoTotal":2000,"descuento":{"montoDescuento":900,"naturalezaDescuento":"Descuento general"},"subTotal":1100,"impuesto":{"1":{"codigo":"06","tarifa":13,"monto":260}},"impuestoNeto":"","montoTotalLinea":"1360.00"},"3":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":20,"descuento":{"montoDescuento":5,"naturalezaDescuento":"Descuento general"},"subTotal":15,"baseImponible":20,"impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":13,"monto":2.6}},"impuestoNeto":"","montoTotalLinea":"17.60"},"4":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":225,"naturalezaDescuento":"Descuento general"},"subTotal":1275,"baseImponible":1500,"impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":1,"monto":15}},"impuestoNeto":"","montoTotalLinea":"1290.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (51, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (52, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (53, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (54, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (55, '{}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (56, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (57, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (58, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (59, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":0,"naturalezaDescuento":"1"},"subTotal":15,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (60, '{"0":{"codigo":"06","codigoComercial":{"tipo":"2","codigo":"06"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":375,"naturalezaDescuento":"Descuento general"},"subTotal":1125,"impuesto":{"1":{"codigo":"06","tarifa":4,"monto":60}},"impuestoNeto":"","montoTotalLinea":"1185.00"},"1":{"codigo":"06","codigoComercial":{"tipo":"1","codigo":"06"},"cantidad":1,"unidadMedida":"kg","detalle":"producto 33                                       ","precioUnitario":"2000.00","montoTotal":2000,"descuento":{"montoDescuento":900,"naturalezaDescuento":"Descuento general"},"subTotal":1100,"impuesto":{"1":{"codigo":"06","tarifa":13,"monto":260}},"impuestoNeto":"","montoTotalLinea":"1360.00"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":1500,"descuento":{"montoDescuento":225,"naturalezaDescuento":"Descuento general"},"subTotal":1275,"baseImponible":1500,"impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":1,"monto":15}},"impuestoNeto":"","montoTotalLinea":"1290.00"},"3":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":15,"descuento":{"montoDescuento":3,"naturalezaDescuento":"Descuento general"},"subTotal":12,"baseImponible":15,"impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":13,"monto":1.95}},"impuestoNeto":"","montoTotalLinea":"13.95"},"4":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":1,"unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":20,"descuento":{"montoDescuento":5,"naturalezaDescuento":"Descuento general"},"subTotal":15,"baseImponible":20,"impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":13,"monto":2.6}},"impuestoNeto":"","montoTotalLinea":"17.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (61, '{"0":{"codigo":"06","codigoComercial":{"tipo":"2","codigo":"06"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"1500","impuesto":{"1":{"codigo":"06","tarifa":"4.00000","monto":"60"}},"impuestoNeto":"","montoTotalLinea":"1560.00"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"20","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.6"}},"impuestoNeto":"","montoTotalLinea":"22.60"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"15","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.95"}},"impuestoNeto":"","montoTotalLinea":"16.95"},"3":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"1500","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"15"}},"impuestoNeto":"","montoTotalLinea":"1515.00"},"4":{"codigo":"06","codigoComercial":{"tipo":"1","codigo":"06"},"cantidad":"1","unidadMedida":"kg","detalle":"producto 33                                       ","precioUnitario":"2000.00","montoTotal":"2000","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"2000","impuesto":{"1":{"codigo":"06","tarifa":"13.00000","monto":"260"}},"impuestoNeto":"","montoTotalLinea":"2260.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (62, '{"0":{"codigo":"06","codigoComercial":{"tipo":"2","codigo":"06"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"1500","impuesto":{"1":{"codigo":"06","tarifa":"4.00000","monto":"60"}},"Exoneración":{"tipoDocumento":"","NnmeroDocumento":"","nombreInstitucion":"","fechaEmision":"","porcentajeExoneracion":"","montoExoneracion":""},"impuestoNeto":"","montoTotalLinea":"1560.00"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"1500","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"15"}},"Exoneración":{"tipoDocumento":"","NnmeroDocumento":"","nombreInstitucion":"","fechaEmision":"","porcentajeExoneracion":"","montoExoneracion":""},"impuestoNeto":"","montoTotalLinea":"1515.00"},"2":{"codigo":"06","codigoComercial":{"tipo":"1","codigo":"06"},"cantidad":"1","unidadMedida":"kg","detalle":"producto 33                                       ","precioUnitario":"2000.00","montoTotal":"2000","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"2000","impuesto":{"1":{"codigo":"06","tarifa":"13.00000","monto":"260"}},"Exoneración":{"tipoDocumento":"","NnmeroDocumento":"","nombreInstitucion":"","fechaEmision":"","porcentajeExoneracion":"","montoExoneracion":""},"impuestoNeto":"","montoTotalLinea":"2260.00"},"3":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"15","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.95"}},"Exoneración":{"tipoDocumento":"","NnmeroDocumento":"","nombreInstitucion":"","fechaEmision":"","porcentajeExoneracion":"","montoExoneracion":""},"impuestoNeto":"","montoTotalLinea":"16.95"},"4":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"20","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.6"}},"Exoneración":{"tipoDocumento":"","NnmeroDocumento":"","nombreInstitucion":"","fechaEmision":"","porcentajeExoneracion":"","montoExoneracion":""},"impuestoNeto":"","montoTotalLinea":"22.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (63, '{"0":{"codigo":"06","codigoComercial":{"tipo":"1","codigo":"06"},"cantidad":"1","unidadMedida":"kg","detalle":"producto 33                                       ","precioUnitario":"2000.00","montoTotal":"2000","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"2000","impuesto":{"1":{"codigo":"06","tarifa":"13.00000","monto":"260"}},"impuestoNeto":260,"montoTotalLinea":"2260.00"},"1":{"codigo":"06","codigoComercial":{"tipo":"2","codigo":"06"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 32                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"1500","impuesto":{"1":{"codigo":"06","tarifa":"4.00000","monto":"60"}},"impuestoNeto":60,"montoTotalLinea":"1560.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (64, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"20","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.6"}},"impuestoNeto":2.6,"montoTotalLinea":"22.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (65, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"15","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.95"}},"impuestoNeto":1.95,"montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (66, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"3.75","naturalezaDescuento":"Descuento general"},"subTotal":"11.25","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.95"}},"impuestoNeto":1.95,"montoTotalLinea":"13.20"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (67, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"0","naturalezaDescuento":"1"},"subTotal":"15","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.95"}},"impuestoNeto":"1.95","montoTotalLinea":"16.95"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (68, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.95"}},"impuestoNeto":"1.95","montoTotalLinea":"15.45"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (69, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.95"}},"impuestoNeto":"1.95","montoTotalLinea":"15.45"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (70, '{"0":{"codigo":"06","codigoComercial":{"tipo":"1","codigo":"06"},"cantidad":"1","unidadMedida":"kg","detalle":"producto 33                                       ","precioUnitario":"2000.00","montoTotal":"2000","descuento":{"montoDescuento":"200","naturalezaDescuento":"Descuento general"},"subTotal":"1800","impuesto":{"1":{"codigo":"06","tarifa":"13.00000","monto":"260"}},"impuestoNeto":"260","montoTotalLinea":"2060.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (71, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.95"}},"impuestoNeto":"1.95","montoTotalLinea":"15.45"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (72, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.95"}},"impuestoNeto":"1.95","montoTotalLinea":"15.45"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (73, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.95"}},"impuestoNeto":"1.95","montoTotalLinea":"15.45"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (74, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.95"}},"impuestoNeto":"1.95","montoTotalLinea":"15.45"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (75, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.95"}},"impuestoNeto":"1.95","montoTotalLinea":"15.45"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (76, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"2","naturalezaDescuento":"Descuento general"},"subTotal":"18","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.6"}},"impuestoNeto":"2.6","montoTotalLinea":"20.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (77, '{"0":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"150","naturalezaDescuento":"Descuento general"},"subTotal":"1350","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"15"}},"impuestoNeto":"15","montoTotalLinea":"1365.00"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.95"}},"impuestoNeto":"1.95","montoTotalLinea":"15.45"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"2","naturalezaDescuento":"Descuento general"},"subTotal":"18","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.6"}},"impuestoNeto":"2.6","montoTotalLinea":"20.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (78, '{"0":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"150","naturalezaDescuento":"Descuento general"},"subTotal":"1350","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"13.5"}},"impuestoNeto":"13.5","montoTotalLinea":"1365.00"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.755"}},"impuestoNeto":"1.755","montoTotalLinea":"15.45"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"2","naturalezaDescuento":"Descuento general"},"subTotal":"18","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.34"}},"impuestoNeto":"2.34","montoTotalLinea":"20.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (79, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.755"}},"impuestoNeto":"1.755","montoTotalLinea":"15.45"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"2","naturalezaDescuento":"Descuento general"},"subTotal":"18","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.34"}},"impuestoNeto":"2.34","montoTotalLinea":"20.60"},"2":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"150","naturalezaDescuento":"Descuento general"},"subTotal":"1350","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"13.5"}},"impuestoNeto":"13.5","montoTotalLinea":"1365.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (80, '{"0":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"150","naturalezaDescuento":"Descuento general"},"subTotal":"1350","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"13.5"}},"impuestoNeto":"13.5","montoTotalLinea":"1365.00"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.755"}},"impuestoNeto":"1.755","montoTotalLinea":"15.45"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"2","naturalezaDescuento":"Descuento general"},"subTotal":"18","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.34"}},"impuestoNeto":"2.34","montoTotalLinea":"20.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (81, '{"0":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"675","naturalezaDescuento":"Descuento general"},"subTotal":"825","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"8.25"}},"impuestoNeto":"8.25","montoTotalLinea":"840.00"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"9","naturalezaDescuento":"Descuento general"},"subTotal":"11","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"1.43"}},"impuestoNeto":"1.43","montoTotalLinea":"13.60"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"3.75","naturalezaDescuento":"Descuento general"},"subTotal":"11.25","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.4625"}},"impuestoNeto":"1.4625","montoTotalLinea":"13.20"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (82, '{"0":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"150","naturalezaDescuento":"Descuento general"},"subTotal":"1350","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"13.5"}},"impuestoNeto":"13.5","montoTotalLinea":"1365.00"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.755"}},"impuestoNeto":"1.755","montoTotalLinea":"15.45"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"2","naturalezaDescuento":"Descuento general"},"subTotal":"18","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.34"}},"impuestoNeto":"2.34","montoTotalLinea":"20.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (83, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"3.75","naturalezaDescuento":"Descuento general"},"subTotal":"11.25","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.4625"}},"impuestoNeto":"1.4625","montoTotalLinea":"13.20"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"9","naturalezaDescuento":"Descuento general"},"subTotal":"11","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"1.43"}},"impuestoNeto":"1.43","montoTotalLinea":"13.60"},"2":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"375","naturalezaDescuento":"Descuento general"},"subTotal":"1125","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"11.25"}},"impuestoNeto":"11.25","montoTotalLinea":"1140.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (84, '{"0":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"225","naturalezaDescuento":"Descuento general"},"subTotal":"1275","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"12.75"}},"impuestoNeto":"12.75","montoTotalLinea":"1290.00"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"2.25","naturalezaDescuento":"Descuento general"},"subTotal":"12.75","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.6575"}},"impuestoNeto":"1.6575","montoTotalLinea":"14.70"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"3","naturalezaDescuento":"Descuento general"},"subTotal":"17","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.21"}},"impuestoNeto":"2.21","montoTotalLinea":"19.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (85, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.755"}},"impuestoNeto":"1.755","montoTotalLinea":"15.45"},"1":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"150","naturalezaDescuento":"Descuento general"},"subTotal":"1350","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"13.5"}},"impuestoNeto":"13.5","montoTotalLinea":"1365.00"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"2","naturalezaDescuento":"Descuento general"},"subTotal":"18","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.34"}},"impuestoNeto":"2.34","montoTotalLinea":"20.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (86, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.755"}},"impuestoNeto":"1.755","montoTotalLinea":"15.45"},"1":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"150","naturalezaDescuento":"Descuento general"},"subTotal":"1350","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"13.5"}},"impuestoNeto":"13.5","montoTotalLinea":"1365.00"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"2","naturalezaDescuento":"Descuento general"},"subTotal":"18","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.34"}},"impuestoNeto":"2.34","montoTotalLinea":"20.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (87, '{"0":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"150","naturalezaDescuento":"Descuento general"},"subTotal":"1350","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"13.5"}},"impuestoNeto":"13.5","montoTotalLinea":"1365.00"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.755"}},"impuestoNeto":"1.755","montoTotalLinea":"15.45"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"2","naturalezaDescuento":"Descuento general"},"subTotal":"18","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.34"}},"impuestoNeto":"2.34","montoTotalLinea":"20.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (88, '{"0":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"150","naturalezaDescuento":"Descuento general"},"subTotal":"1350","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"13.5"}},"impuestoNeto":"13.5","montoTotalLinea":"1365.00"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.755"}},"impuestoNeto":"1.755","montoTotalLinea":"15.45"},"2":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"2","naturalezaDescuento":"Descuento general"},"subTotal":"18","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.34"}},"impuestoNeto":"2.34","montoTotalLinea":"20.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (89, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.755"}},"impuestoNeto":"1.755","montoTotalLinea":"15.45"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (90, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.755"}},"impuestoNeto":"1.755","montoTotalLinea":"15.45"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (91, '{"0":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"cm","detalle":"producto 36                                       ","precioUnitario":"20.00","montoTotal":"20","descuento":{"montoDescuento":"2","naturalezaDescuento":"Descuento general"},"subTotal":"18","baseImponible":"20.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"13.00000","monto":"2.34"}},"impuestoNeto":"2.34","montoTotalLinea":"20.60"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (92, '{"0":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"150","naturalezaDescuento":"Descuento general"},"subTotal":"1350","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"13.5"}},"impuestoNeto":"13.5","montoTotalLinea":"1365.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (93, '{"0":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"225","naturalezaDescuento":"Descuento general"},"subTotal":"1275","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"1.00000","monto":"12.75"}},"impuestoNeto":"12.75","montoTotalLinea":"1290.00"}}');
INSERT INTO public.detalles_orden (iddetalle, descripcion_detalle) VALUES (94, '{"0":{"codigo":"01","codigoComercial":{"tipo":"1","codigo":"01"},"cantidad":"1","unidadMedida":"m","detalle":"Producto 34                                       ","precioUnitario":"1500.00","montoTotal":"1500","descuento":{"montoDescuento":"150","naturalezaDescuento":"Descuento general"},"subTotal":"1350","baseImponible":"1500.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"07","tarifa":"8.00000","monto":"108"}},"impuestoNeto":"108","montoTotalLinea":"1365.00"},"1":{"codigo":"01","codigoComercial":{"tipo":"2","codigo":"01"},"cantidad":"1","unidadMedida":"mL","detalle":"producto prueba                                   ","precioUnitario":"15.00","montoTotal":"15","descuento":{"montoDescuento":"1.5","naturalezaDescuento":"Descuento general"},"subTotal":"13.5","baseImponible":"15.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"08","tarifa":"13.00000","monto":"1.755"}},"impuestoNeto":"1.755","montoTotalLinea":"15.45"},"2":{"codigo":"sdf5f56","codigoComercial":{"tipo":"2","codigo":"sdf5f56"},"cantidad":"1","unidadMedida":"mL","detalle":"Producto excento                                  ","precioUnitario":"65.00","montoTotal":"65","descuento":{"montoDescuento":"6.5","naturalezaDescuento":"Descuento general"},"subTotal":"58.5","baseImponible":"65.00","impuesto":{"1":{"codigo":"01","codigoTarifa":"01","tarifa":"0.00000","monto":"0"}},"impuestoNeto":"0","montoTotalLinea":"58.50"}}');


--
-- TOC entry 3241 (class 0 OID 25364)
-- Dependencies: 236
-- Data for Name: distrito; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (1, 1, 1, 1, 'CARMEN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (2, 1, 1, 2, 'MERCED');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (3, 1, 1, 3, 'HOSPITAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (4, 1, 1, 4, 'CATEDRAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (5, 1, 1, 5, 'ZAPOTE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (6, 1, 1, 6, 'SAN FRANCISCO DE DOS RÍOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (7, 1, 1, 7, 'URUCA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (8, 1, 1, 8, 'MATA REDONDA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (9, 1, 1, 9, 'PAVAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (10, 1, 1, 10, 'HATILLO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (11, 1, 1, 11, 'SAN SEBASTIÁN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (12, 1, 2, 1, 'ESCAZÚ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (13, 1, 2, 2, 'SAN ANTONIO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (14, 1, 2, 3, 'SAN RAFAEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (15, 1, 3, 1, 'DESAMPARADOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (16, 1, 3, 2, 'SAN MIGUEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (17, 1, 3, 3, 'SAN JUAN DE DIOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (18, 1, 3, 4, 'SAN RAFAEL ARRIBA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (19, 1, 3, 5, 'SAN ANTONIO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (20, 1, 3, 6, 'FRAILES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (21, 1, 3, 7, 'PATARRÁ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (22, 1, 3, 8, 'SAN CRISTÓBAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (23, 1, 3, 9, 'ROSARIO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (24, 1, 3, 10, 'DAMAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (25, 1, 3, 11, 'SAN RAFAEL ABAJO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (26, 1, 3, 12, 'GRAVILIAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (27, 1, 3, 13, 'LOS GUIDO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (28, 1, 4, 1, 'SANTIAGO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (29, 1, 4, 2, 'MERCEDES SUR');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (30, 1, 4, 3, 'BARBACOAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (31, 1, 4, 4, 'GRIFO ALTO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (32, 1, 4, 5, 'SAN RAFAEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (33, 1, 4, 6, 'CANDELARITA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (34, 1, 4, 7, 'DESAMPARADITOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (35, 1, 4, 8, 'SAN ANTONIO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (36, 1, 4, 9, 'CHIRES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (37, 1, 5, 1, 'SAN MARCOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (38, 1, 5, 2, 'SAN LORENZO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (39, 1, 5, 3, 'SAN CARLOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (40, 1, 6, 1, 'ASERRI');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (41, 1, 6, 2, 'TARBACA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (42, 1, 6, 3, 'VUELTA DE JORCO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (43, 1, 6, 4, 'SAN GABRIEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (44, 1, 6, 5, 'LEGUA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (45, 1, 6, 6, 'MONTERREY');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (46, 1, 6, 7, 'SALITRILLOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (47, 1, 7, 1, 'COLÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (48, 1, 7, 2, 'GUAYABO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (49, 1, 7, 3, 'TABARCIA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (50, 1, 7, 4, 'PIEDRAS NEGRAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (51, 1, 7, 5, 'PICAGRES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (52, 1, 7, 6, 'JARIS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (53, 1, 7, 7, 'QUITIRRISI');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (54, 1, 8, 1, 'GUADALUPE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (55, 1, 8, 2, 'SAN FRANCISCO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (56, 1, 8, 3, 'CALLE BLANCOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (57, 1, 8, 4, 'MATA DE PLÁTANO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (58, 1, 8, 5, 'IPÍS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (59, 1, 8, 6, 'RANCHO REDONDO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (60, 1, 8, 7, 'PURRAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (61, 1, 9, 1, 'SANTA ANA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (62, 1, 9, 2, 'SALITRAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (63, 1, 9, 3, 'POZOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (64, 1, 9, 4, 'URUCA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (65, 1, 9, 5, 'PIEDADES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (66, 1, 9, 6, 'BRASIL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (67, 1, 10, 1, 'ALAJUELITA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (68, 1, 10, 2, 'SAN JOSECITO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (69, 1, 10, 3, 'SAN ANTONIO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (70, 1, 10, 4, 'CONCEPCIÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (71, 1, 10, 5, 'SAN FELIPE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (72, 1, 11, 1, 'SAN ISIDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (73, 1, 11, 2, 'SAN RAFAEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (74, 1, 11, 3, 'DULCE NOMBRE DE JESÚS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (75, 1, 11, 4, 'PATALILLO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (76, 1, 11, 5, 'CASCAJAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (77, 1, 12, 1, 'SAN IGNACIO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (78, 1, 12, 2, 'GUAITIL Villa');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (79, 1, 12, 3, 'PALMICHAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (80, 1, 12, 4, 'CANGREJAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (81, 1, 12, 5, 'SABANILLAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (82, 1, 13, 1, 'SAN JUAN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (83, 1, 13, 2, 'CINCO ESQUINAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (84, 1, 13, 3, 'ANSELMO LLORENTE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (85, 1, 13, 4, 'LEON XIII');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (86, 1, 13, 5, 'COLIMA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (87, 1, 14, 1, 'SAN VICENTE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (88, 1, 14, 2, 'SAN JERÓNIMO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (89, 1, 14, 3, 'LA TRINIDAD');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (90, 1, 15, 1, 'SAN PEDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (91, 1, 15, 2, 'SABANILLA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (92, 1, 15, 3, 'MERCEDES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (93, 1, 15, 4, 'SAN RAFAEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (94, 1, 16, 1, 'SAN PABLO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (95, 1, 16, 2, 'SAN PEDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (96, 1, 16, 3, 'SAN JUAN DE MATA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (97, 1, 16, 4, 'SAN LUIS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (98, 1, 16, 5, 'CARARA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (99, 1, 17, 1, 'SANTA MARÍA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (100, 1, 17, 2, 'JARDÍN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (101, 1, 17, 3, 'COPEY');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (102, 1, 18, 1, 'CURRIDABAT');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (103, 1, 18, 2, 'GRANADILLA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (104, 1, 18, 3, 'SÁNCHEZ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (105, 1, 18, 4, 'TIRRASES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (106, 1, 19, 1, 'SAN ISIDRO DE EL GENERAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (107, 1, 19, 2, 'EL GENERAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (108, 1, 19, 3, 'DANIEL FLORES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (109, 1, 19, 4, 'RIVAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (110, 1, 19, 5, 'SAN PEDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (111, 1, 19, 6, 'PLATANARES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (112, 1, 19, 7, 'PEJIBAYE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (113, 1, 19, 8, 'CAJÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (114, 1, 19, 9, 'BARÚ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (115, 1, 19, 10, 'RÍO NUEVO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (116, 1, 19, 11, 'PÁRAMO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (117, 1, 20, 1, 'SAN PABLO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (118, 1, 20, 2, 'SAN ANDRÉS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (119, 1, 20, 3, 'LLANO BONITO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (120, 1, 20, 4, 'SAN ISIDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (121, 1, 20, 5, 'SANTA CRUZ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (122, 1, 20, 6, 'SAN ANTONIO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (123, 2, 21, 1, 'ALAJUELA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (124, 2, 21, 2, 'SAN JOSÉ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (125, 2, 21, 3, 'CARRIZAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (126, 2, 21, 4, 'SAN ANTONIO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (127, 2, 21, 5, 'GUÁCIMA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (128, 2, 21, 6, 'SAN ISIDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (129, 2, 21, 7, 'SABANILLA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (130, 2, 21, 8, 'SAN RAFAEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (131, 2, 21, 9, 'RÍO SEGUNDO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (132, 2, 21, 10, 'DESAMPARADOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (133, 2, 21, 11, 'TURRÚCARES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (134, 2, 21, 12, 'TAMBOR');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (135, 2, 21, 13, 'GARITA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (136, 2, 21, 14, 'SARAPIQUÍ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (137, 2, 22, 1, 'SAN RAMÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (138, 2, 22, 2, 'SANTIAGO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (139, 2, 22, 3, 'SAN JUAN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (140, 2, 22, 4, 'PIEDADES NORTE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (141, 2, 22, 5, 'PIEDADES SUR');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (142, 2, 22, 6, 'SAN RAFAEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (143, 2, 22, 7, 'SAN ISIDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (144, 2, 22, 8, 'ÁNGELES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (145, 2, 22, 9, 'ALFARO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (146, 2, 22, 10, 'VOLIO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (147, 2, 22, 11, 'CONCEPCIÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (148, 2, 22, 12, 'ZAPOTAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (149, 2, 22, 13, 'PEÑAS BLANCAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (150, 2, 23, 1, 'GRECIA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (151, 2, 23, 2, 'SAN ISIDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (152, 2, 23, 3, 'SAN JOSÉ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (153, 2, 23, 4, 'SAN ROQUE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (154, 2, 23, 5, 'TACARES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (155, 2, 23, 6, 'RÍO CUARTO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (156, 2, 23, 7, 'PUENTE DE PIEDRA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (157, 2, 23, 8, 'BOLÍVAR');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (158, 2, 24, 1, 'SAN MATEO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (159, 2, 24, 2, 'DESMONTE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (160, 2, 24, 3, 'JESÚS MARÍA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (161, 2, 24, 4, 'LABRADOR');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (162, 2, 25, 1, 'ATENAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (163, 2, 25, 2, 'JESÚS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (164, 2, 25, 3, 'MERCEDES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (165, 2, 25, 4, 'SAN ISIDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (166, 2, 25, 5, 'CONCEPCIÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (167, 2, 25, 6, 'SAN JOSE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (168, 2, 25, 7, 'SANTA EULALIA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (169, 2, 25, 8, 'ESCOBAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (170, 2, 26, 1, 'NARANJO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (171, 2, 26, 2, 'SAN MIGUEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (172, 2, 26, 3, 'SAN JOSÉ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (173, 2, 26, 4, 'CIRRÍ SUR');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (174, 2, 26, 5, 'SAN JERÓNIMO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (175, 2, 26, 6, 'SAN JUAN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (176, 2, 26, 7, 'EL ROSARIO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (177, 2, 26, 8, 'PALMITOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (178, 2, 27, 1, 'PALMARES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (179, 2, 27, 2, 'ZARAGOZA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (180, 2, 27, 3, 'BUENOS AIRES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (181, 2, 27, 4, 'SANTIAGO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (182, 2, 27, 5, 'CANDELARIA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (183, 2, 27, 6, 'ESQUÍPULAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (184, 2, 27, 7, 'LA GRANJA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (185, 2, 28, 1, 'SAN PEDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (186, 2, 28, 2, 'SAN JUAN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (187, 2, 28, 3, 'SAN RAFAEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (188, 2, 28, 4, 'CARRILLOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (189, 2, 28, 5, 'SABANA REDONDA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (190, 2, 29, 1, 'OROTINA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (191, 2, 29, 2, 'EL MASTATE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (192, 2, 29, 3, 'HACIENDA VIEJA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (193, 2, 29, 4, 'COYOLAR');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (194, 2, 29, 5, 'LA CEIBA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (195, 2, 30, 1, 'QUESADA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (196, 2, 30, 2, 'FLORENCIA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (197, 2, 30, 3, 'BUENAVISTA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (198, 2, 30, 4, 'AGUAS ZARCAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (199, 2, 30, 5, 'VENECIA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (200, 2, 30, 6, 'PITAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (201, 2, 30, 7, 'LA FORTUNA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (202, 2, 30, 8, 'LA TIGRA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (203, 2, 30, 9, 'LA PALMERA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (204, 2, 30, 10, 'VENADO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (205, 2, 30, 11, 'CUTRIS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (206, 2, 30, 12, 'MONTERREY');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (207, 2, 30, 13, 'POCOSOL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (208, 2, 31, 1, 'ZARCERO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (209, 2, 31, 2, 'LAGUNA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (210, 2, 31, 4, 'GUADALUPE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (211, 2, 31, 5, 'PALMIRA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (212, 2, 31, 6, 'ZAPOTE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (213, 2, 31, 7, 'BRISAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (214, 2, 32, 1, 'SARCHÍ NORTE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (215, 2, 32, 2, 'SARCHÍ SUR');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (216, 2, 32, 3, 'TORO AMARILLO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (217, 2, 32, 4, 'SAN PEDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (218, 2, 32, 5, 'RODRÍGUEZ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (219, 2, 33, 1, 'UPALA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (220, 2, 33, 2, 'AGUAS CLARAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (221, 2, 33, 3, 'SAN JOSÉ o PIZOTE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (222, 2, 33, 4, 'BIJAGUA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (223, 2, 33, 5, 'DELICIAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (224, 2, 33, 6, 'DOS RÍOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (225, 2, 33, 7, 'YOLILLAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (226, 2, 33, 8, 'CANALETE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (227, 2, 34, 1, 'LOS CHILES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (228, 2, 34, 2, 'CAÑO NEGRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (229, 2, 34, 3, 'EL AMPARO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (230, 2, 34, 4, 'SAN JORGE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (231, 2, 35, 2, 'BUENAVISTA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (232, 2, 35, 3, 'COTE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (233, 2, 35, 4, 'KATIRA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (234, 3, 36, 1, 'ORIENTAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (235, 3, 36, 2, 'OCCIDENTAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (236, 3, 36, 3, 'CARMEN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (237, 3, 36, 4, 'SAN NICOLÁS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (238, 3, 36, 5, 'AGUACALIENTE o SAN FRANCISCO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (239, 3, 36, 6, 'GUADALUPE o ARENILLA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (240, 3, 36, 7, 'CORRALILLO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (241, 3, 36, 8, 'TIERRA BLANCA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (242, 3, 36, 9, 'DULCE NOMBRE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (243, 3, 36, 10, 'LLANO GRANDE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (244, 3, 36, 11, 'QUEBRADILLA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (245, 3, 37, 1, 'PARAÍSO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (246, 3, 37, 2, 'SANTIAGO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (247, 3, 37, 3, 'OROSI');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (248, 3, 37, 4, 'CACHÍ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (249, 3, 37, 5, 'LLANOS DE SANTA LUCÍA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (250, 3, 38, 1, 'TRES RÍOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (251, 3, 38, 2, 'SAN DIEGO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (252, 3, 38, 3, 'SAN JUAN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (253, 3, 38, 4, 'SAN RAFAEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (254, 3, 38, 5, 'CONCEPCIÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (255, 3, 38, 6, 'DULCE NOMBRE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (256, 3, 38, 7, 'SAN RAMÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (257, 3, 38, 8, 'RÍO AZUL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (258, 3, 39, 1, 'JUAN VIÑAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (259, 3, 39, 2, 'TUCURRIQUE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (260, 3, 39, 3, 'PEJIBAYE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (261, 3, 40, 1, 'TURRIALBA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (262, 3, 40, 2, 'LA SUIZA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (263, 3, 40, 3, 'PERALTA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (264, 3, 40, 4, 'SANTA CRUZ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (265, 3, 40, 5, 'SANTA TERESITA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (266, 3, 40, 6, 'PAVONES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (267, 3, 40, 7, 'TUIS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (268, 3, 40, 8, 'TAYUTIC');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (269, 3, 40, 9, 'SANTA ROSA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (270, 3, 40, 10, 'TRES EQUIS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (271, 3, 40, 11, 'LA ISABEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (272, 3, 40, 12, 'CHIRRIPÓ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (273, 3, 41, 1, 'PACAYAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (274, 3, 41, 2, 'CERVANTES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (275, 3, 41, 3, 'CAPELLADES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (276, 3, 42, 1, 'SAN RAFAEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (277, 3, 42, 2, 'COT');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (278, 3, 42, 3, 'POTRERO CERRADO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (279, 3, 42, 4, 'CIPRESES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (280, 3, 42, 5, 'SANTA ROSA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (281, 3, 43, 1, 'EL TEJAR');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (282, 3, 43, 2, 'SAN ISIDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (283, 3, 43, 3, 'TOBOSI');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (284, 3, 43, 4, 'PATIO DE AGUA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (285, 4, 44, 1, 'HEREDIA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (286, 4, 44, 2, 'MERCEDES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (287, 4, 44, 3, 'SAN FRANCISCO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (288, 4, 44, 4, 'ULLOA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (289, 4, 44, 5, 'VARABLANCA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (290, 4, 45, 1, 'BARVA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (291, 4, 45, 2, 'SAN PEDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (292, 4, 45, 3, 'SAN PABLO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (293, 4, 45, 4, 'SAN ROQUE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (294, 4, 45, 5, 'SANTA LUCÍA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (295, 4, 45, 6, 'SAN JOSÉ DE LA MONTAÑA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (296, 4, 46, 2, 'SAN VICENTE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (297, 4, 46, 3, 'SAN MIGUEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (298, 4, 46, 4, 'PARACITO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (299, 4, 46, 5, 'SANTO TOMÁS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (300, 4, 46, 6, 'SANTA ROSA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (301, 4, 46, 7, 'TURES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (302, 4, 46, 8, 'PARÁ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (303, 4, 47, 1, 'SANTA BÁRBARA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (304, 4, 47, 2, 'SAN PEDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (305, 4, 47, 3, 'SAN JUAN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (306, 4, 47, 4, 'JESÚS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (307, 4, 47, 5, 'SANTO DOMINGO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (308, 4, 47, 6, 'PURABÁ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (309, 4, 48, 1, 'SAN RAFAEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (310, 4, 48, 2, 'SAN JOSECITO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (311, 4, 48, 3, 'SANTIAGO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (312, 4, 48, 4, 'ÁNGELES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (313, 4, 48, 5, 'CONCEPCIÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (314, 4, 49, 1, 'SAN ISIDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (315, 4, 49, 2, 'SAN JOSÉ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (316, 4, 49, 3, 'CONCEPCIÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (317, 4, 49, 4, 'SAN FRANCISCO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (318, 4, 50, 1, 'SAN ANTONIO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (319, 4, 50, 2, 'LA RIBERA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (320, 4, 50, 3, 'LA ASUNCIÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (321, 4, 51, 1, 'SAN JOAQUÍN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (322, 4, 51, 2, 'BARRANTES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (323, 4, 51, 3, 'LLORENTE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (324, 4, 52, 1, 'SAN PABLO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (325, 4, 53, 1, 'PUERTO VIEJO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (326, 4, 53, 2, 'LA VIRGEN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (327, 4, 53, 3, 'LAS HORQUETAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (328, 4, 53, 4, 'LLANURAS DEL GASPAR');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (329, 4, 53, 5, 'CUREÑA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (330, 5, 54, 1, 'LIBERIA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (331, 5, 54, 2, 'CAÑAS DULCES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (332, 5, 54, 3, 'MAYORGA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (333, 5, 54, 4, 'NACASCOLO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (334, 5, 54, 5, 'CURUBANDÉ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (335, 5, 55, 1, 'NICOYA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (336, 5, 55, 2, 'MANSIÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (337, 5, 55, 3, 'SAN ANTONIO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (338, 5, 55, 4, 'QUEBRADA HONDA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (339, 5, 55, 5, 'SÁMARA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (340, 5, 55, 6, 'NOSARA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (341, 5, 55, 7, 'BELÉN DE NOSARITA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (342, 5, 56, 1, 'SANTA CRUZ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (343, 5, 56, 2, 'BOLSÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (344, 5, 56, 3, 'VEINTISIETE DE ABRIL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (345, 5, 56, 4, 'TEMPATE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (346, 5, 56, 5, 'CARTAGENA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (347, 5, 56, 6, 'CUAJINIQUIL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (348, 5, 56, 7, 'DIRIÁ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (349, 5, 56, 8, 'CABO VELAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (350, 5, 56, 9, 'TAMARINDO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (351, 5, 57, 1, 'BAGACES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (352, 5, 57, 2, 'LA FORTUNA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (353, 5, 57, 3, 'MOGOTE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (354, 5, 57, 4, 'RÍO NARANJO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (355, 5, 58, 1, 'FILADELFIA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (356, 5, 58, 2, 'PALMIRA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (357, 5, 58, 3, 'SARDINAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (358, 5, 58, 4, 'BELÉN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (359, 5, 59, 1, 'CAÑAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (360, 5, 59, 2, 'PALMIRA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (361, 5, 59, 3, 'SAN MIGUEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (362, 5, 59, 4, 'BEBEDERO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (363, 5, 59, 5, 'POROZAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (364, 5, 60, 1, 'LAS JUNTAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (365, 5, 60, 2, 'SIERRA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (366, 5, 60, 3, 'SAN JUAN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (367, 5, 60, 4, 'COLORADO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (368, 5, 61, 1, 'TILARÁN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (369, 5, 61, 2, 'QUEBRADA GRANDE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (370, 5, 61, 3, 'TRONADORA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (371, 5, 61, 4, 'SANTA ROSA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (372, 5, 61, 5, 'LÍBANO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (373, 5, 61, 6, 'TIERRAS MORENAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (374, 5, 61, 7, 'ARENAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (375, 5, 62, 1, 'CARMONA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (376, 5, 62, 2, 'SANTA RITA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (377, 5, 62, 3, 'ZAPOTAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (378, 5, 62, 4, 'SAN PABLO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (379, 5, 62, 5, 'PORVENIR');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (380, 5, 62, 6, 'BEJUCO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (381, 5, 63, 1, 'LA CRUZ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (382, 5, 63, 2, 'SANTA CECILIA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (383, 5, 63, 3, 'LA GARITA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (384, 5, 63, 4, 'SANTA ELENA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (385, 5, 64, 1, 'HOJANCHA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (386, 5, 64, 2, 'MONTE ROMO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (387, 5, 64, 3, 'PUERTO CARRILLO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (388, 5, 64, 4, 'HUACAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (389, 6, 65, 1, 'PUNTARENAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (390, 6, 65, 2, 'PITAHAYA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (391, 6, 65, 3, 'CHOMES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (392, 6, 65, 4, 'LEPANTO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (393, 6, 65, 5, 'PAQUERA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (394, 6, 65, 6, 'MANZANILLO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (395, 6, 65, 7, 'GUACIMAL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (396, 6, 65, 8, 'BARRANCA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (397, 6, 65, 9, 'MONTE VERDE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (398, 6, 65, 11, 'CÓBANO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (399, 6, 65, 12, 'CHACARITA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (400, 6, 65, 13, 'CHIRA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (401, 6, 65, 14, 'ACAPULCO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (402, 6, 65, 15, 'EL ROBLE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (403, 6, 65, 16, 'ARANCIBIA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (404, 6, 66, 1, 'ESPÍRITU SANTO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (405, 6, 66, 2, 'SAN JUAN GRANDE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (406, 6, 66, 3, 'MACACONA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (407, 6, 66, 4, 'SAN RAFAEL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (408, 6, 66, 5, 'SAN JERÓNIMO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (409, 6, 66, 6, 'CALDERA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (410, 6, 67, 1, 'BUENOS AIRES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (411, 6, 67, 2, 'VOLCÁN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (412, 6, 67, 3, 'POTRERO GRANDE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (413, 6, 67, 4, 'BORUCA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (414, 6, 67, 5, 'PILAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (415, 6, 67, 6, 'COLINAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (416, 6, 67, 7, 'CHÁNGUENA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (417, 6, 67, 8, 'BIOLLEY');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (418, 6, 67, 9, 'BRUNKA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (419, 6, 68, 1, 'MIRAMAR');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (420, 6, 68, 2, 'LA UNIÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (421, 6, 68, 3, 'SAN ISIDRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (422, 6, 69, 1, 'PUERTO CORTÉS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (423, 6, 69, 2, 'PALMAR');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (424, 6, 69, 3, 'SIERPE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (425, 6, 69, 4, 'BAHÍA BALLENA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (426, 6, 69, 5, 'PIEDRAS BLANCAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (427, 6, 69, 6, 'BAHÍA DRAKE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (428, 6, 70, 1, 'QUEPOS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (429, 6, 70, 2, 'SAVEGRE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (430, 6, 70, 3, 'NARANJITO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (431, 6, 71, 1, 'GOLFITO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (432, 6, 71, 2, 'PUERTO JIMÉNEZ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (433, 6, 71, 3, 'GUAYCARÁ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (434, 6, 71, 4, 'PAVÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (435, 6, 72, 1, 'SAN VITO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (436, 6, 72, 2, 'SABALITO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (437, 6, 72, 3, 'AGUABUENA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (438, 6, 72, 4, 'LIMONCITO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (439, 6, 72, 5, 'PITTIER');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (440, 6, 72, 6, 'GUTIERREZ BRAUN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (441, 6, 73, 1, 'PARRITA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (442, 6, 74, 1, 'CORREDOR');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (443, 6, 74, 2, 'LA CUESTA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (444, 6, 74, 3, 'CANOAS');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (445, 6, 74, 4, 'LAUREL');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (446, 6, 75, 1, 'JACÓ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (447, 6, 75, 2, 'TÁRCOLES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (448, 7, 76, 1, 'LIMÓN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (449, 7, 76, 2, 'VALLE LA ESTRELLA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (450, 7, 76, 4, 'MATAMA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (451, 7, 77, 1, 'GUÁPILES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (452, 7, 77, 2, 'JIMÉNEZ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (453, 7, 77, 3, 'RITA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (454, 7, 77, 4, 'ROXANA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (455, 7, 77, 5, 'CARIARI');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (456, 7, 77, 6, 'COLORADO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (457, 7, 77, 7, 'LA COLONIA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (458, 7, 78, 1, 'SIQUIRRES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (459, 7, 78, 2, 'PACUARITO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (460, 7, 78, 3, 'FLORIDA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (461, 7, 78, 4, 'GERMANIA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (462, 7, 78, 5, 'EL CAIRO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (463, 7, 78, 6, 'ALEGRÍA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (464, 7, 79, 1, 'BRATSI');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (465, 7, 79, 2, 'SIXAOLA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (466, 7, 79, 3, 'CAHUITA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (467, 7, 79, 4, 'TELIRE');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (468, 7, 80, 1, 'MATINA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (469, 7, 80, 2, 'BATÁN');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (470, 7, 80, 3, 'CARRANDI');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (471, 7, 81, 1, 'GUÁCIMO');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (472, 7, 81, 2, 'MERCEDES');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (473, 7, 81, 3, 'POCORA');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (474, 7, 81, 4, 'RÍO JIMÉNEZ');
INSERT INTO public.distrito (id, codigo_provincia, codigo_canton, codigo_distrito, nombre_distrito) VALUES (475, 7, 81, 5, 'DUACARÍ');


--
-- TOC entry 3214 (class 0 OID 25126)
-- Dependencies: 209
-- Data for Name: emisor; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.emisor (idemisor, e_nombre, emisor_tipo_identificacion, emisor_numero, e_nombrecomercial, e_provincia, e_canton, e_distrito, e_otras_senas, emisor_telefono_codigopais, emisor_telefono_numtelefono, emisor_fax_codigopais, emisor_fax_numtelefono, e_correoelectronico, file_p12, key_username, key_password, pin_p12, casamatriz, puntoventa, tipo_producto, codigo_producto, codigo_actividad, password_email, idfile, downloadcode, iduserapi, acercade, ubicacion) VALUES (1, 'Nombre', '00', '000000000000', NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- TOC entry 3206 (class 0 OID 25077)
-- Dependencies: 201
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.empleado (idempleado, nombreempleado, apellidoempleado, passwordempleado, idpuesto, estadoempleado) VALUES (1, 'Empleado1                                         ', 'Apellido1                                         ', 'pass                                              ', 1, 1);
INSERT INTO public.empleado (idempleado, nombreempleado, apellidoempleado, passwordempleado, idpuesto, estadoempleado) VALUES (2, 'Empleado2                                         ', 'Apellido2                                         ', 'pass                                              ', 1, 1);
INSERT INTO public.empleado (idempleado, nombreempleado, apellidoempleado, passwordempleado, idpuesto, estadoempleado) VALUES (3, 'Nico                                              ', 'Godin                                             ', 'ngodin                                            ', 2, 1);


--
-- TOC entry 3216 (class 0 OID 25137)
-- Dependencies: 211
-- Data for Name: factura; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (1, 1, 1, 2, 0, 1, '2019-08-14 18:31:03.591596', '01        ', 3000.00, 0.00, 1, 1, 'CRC', 566.60000, 0.00000, 0.00000, 0.00000, 3000.00000, 0.00000, 3000.00000, 3000.00000, 0.00000, 3000.00000, 0.00000, 3000.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 1, '000000000000', '5061408190000000000000040000000001154817236', '0040000000001', 1, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (14, 1, 1, 2, 0, 1, '2019-08-21 21:47:10.996463', '01        ', 3515.00, 0.00, 1, 1, 'CRC', 0.00000, 0.00000, 0.00000, 0.00000, 3515.00000, 0.00000, 3515.00000, 3515.00000, 0.00000, 3515.00000, 0.00000, 3515.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, NULL, 19, '000000000000', NULL, NULL, 14, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (2, 1, 1, 2, 0, 1, '2019-08-14 18:35:51.560989', '01        ', 6500.00, 0.00, 1, 1, 'CRC', 566.60000, 0.00000, 0.00000, 0.00000, 6500.00000, 0.00000, 6500.00000, 6500.00000, 0.00000, 6500.00000, 0.00000, 6500.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 2, '000000000000', '5061408190000000000000040000000002147813562', '0040000000002', 2, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (21, 1, 1, 2, NULL, NULL, '2019-08-22 09:29:52.725225', '01        ', 1500.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '01', NULL, NULL, NULL, NULL, NULL, 26, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (15, 1, 1, 2, 0, 1, '2019-08-21 22:10:01.041281', '01        ', 1500.00, 0.00, 1, 1, 'CRC', 561.39000, 0.00000, 0.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, 1500.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, NULL, 20, '000000000000', NULL, NULL, 15, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (3, 1, 1, 2, 0, 1, '2019-08-14 18:45:04.817192', '01        ', 1500.00, 0.00, 1, 1, 'CRC', 566.60000, 0.00000, 0.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, 1500.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 3, '000000000000', '5061408190000000000000040000000003168451372', '0040000000003', 3, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (4, 1, 1, 2, 0, 1, '2019-08-16 12:33:58.451076', '01        ', 3000.00, 0.00, 1, 1, 'CRC', 565.42000, 0.00000, 0.00000, 0.00000, 3000.00000, 0.00000, 3000.00000, 3000.00000, 0.00000, 3000.00000, 0.00000, 3000.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 4, '000000000000', '5061608190000000000000040000000004163478521', '0040000000004', 4, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (16, 1, 1, 2, 0, 1, '2019-08-22 07:06:04.80364', '01        ', 1500.00, 0.00, 1, 1, 'CRC', 561.75000, 0.00000, 0.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, 1500.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 21, '000000000000', '5062208190000000000000010000000016112547386', '0010000000016', 16, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (5, 1, 1, 2, 0, 1, '2019-08-17 12:05:43.167936', '01        ', 3500.00, 0.00, 1, 1, 'CRC', 563.82000, 0.00000, 0.00000, 0.00000, 3500.00000, 0.00000, 3500.00000, 3500.00000, 0.00000, 3500.00000, 0.00000, 3500.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 5, '000000000000', '5061708190000000000000040000000005184751236', '0040000000005', 5, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (9, 1, 1, 2, 0, 1, '2019-08-19 17:37:40.361544', '01        ', 3500.00, 0.00, 1, 1, 'CRC', 563.82000, 0.00000, 0.00000, 0.00000, 3500.00000, 0.00000, 3500.00000, 3500.00000, 0.00000, 3500.00000, 0.00000, 3500.00000, '01', 0, '01', '', NULL, NULL, NULL, NULL, NULL, 9, '000000000000', '', '', 9, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (6, 1, 1, 2, 0, 1, '2019-08-17 12:17:59.08311', '01        ', 1500.00, 0.00, 1, 1, 'CRC', 563.82000, 0.00000, 0.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, 1500.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 6, '000000000000', '5061708190000000000000040000000006114375682', '0040000000006', 6, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (25, 1, 1, 2, NULL, NULL, '2019-08-22 10:54:11.578876', '01        ', 1500.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 30, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (7, 1, 1, 2, 0, 1, '2019-08-17 14:15:50.930926', '01        ', 3500.00, 0.00, 1, 1, 'CRC', 563.82000, 0.00000, 0.00000, 0.00000, 3500.00000, 0.00000, 3500.00000, 3500.00000, 0.00000, 3500.00000, 0.00000, 3500.00000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 7, '000000000000', '5061708190000000000000010000000007165248137', '0010000000007', 7, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (10, 1, 1, 2, 0, 1, '2019-08-20 19:20:53.428084', '01        ', 4500.00, 0.00, 1, 1, 'CRC', 562.23000, 0.00000, 0.00000, 0.00000, 4500.00000, 0.00000, 4500.00000, 4500.00000, 0.00000, 4500.00000, 0.00000, 4500.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 16, '000000000000', '5062008190000000000000040000000010112847365', '0040000000010', 10, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (8, 1, 1, 2, 0, 1, '2019-08-19 17:37:16.069543', '01        ', 5035.00, 0.00, 1, 1, 'CRC', 563.82000, 0.00000, 0.00000, 0.00000, 5035.00000, 0.00000, 5035.00000, 5035.00000, 0.00000, 5035.00000, 0.00000, 5035.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 8, '000000000000', '5061908190000000000000040000000008146812537', '0040000000008', 8, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (22, 1, 1, 2, 0, 1, '2019-08-22 09:30:20.107818', '01        ', 1500.00, 0.00, 1, 1, 'CRC', 561.75000, 333.00000, 444.00000, 555.00000, 1500.00000, 0.00000, 1500.00000, 1500.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 27, '000000000000', '5062208190000000000000040000000022161482537', '0040000000022', 22, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (17, 1, 1, 2, 0, 1, '2019-08-22 07:44:55.92544', '01        ', 1500.00, 0.00, 1, 1, 'CRC', 561.75000, 333.00000, 444.00000, 555.00000, 1500.00000, 0.00000, 1500.00000, 1500.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 22, '000000000000', '5062208190000000000000010000000017163512748', '0010000000017', 17, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (11, 1, 1, 2, NULL, NULL, '2019-08-21 18:38:56.429856', '01        ', 5015.00, 0.03, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 17, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (12, 1, 1, 2, 0, 1, '2019-08-21 18:40:21.586722', '01        ', 1500.00, 0.00, 1, 1, 'CRC', 561.39000, 0.00000, 0.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, 1500.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 17, '000000000000', '5062108190000000000000010000000012142531768', '0010000000012', 12, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (18, 1, 1, 2, 0, 1, '2019-08-22 09:03:34.06387', '01        ', 1500.00, 0.00, 1, 1, 'CRC', 561.75000, 333.00000, 444.00000, 555.00000, 1500.00000, 0.00000, 1500.00000, 1500.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 23, '000000000000', '5062208190000000000000040000000018167218543', '0040000000018', 18, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (13, 1, 1, 2, 0, 1, '2019-08-21 18:48:39.421341', '01        ', 1500.00, 0.00, 1, 1, 'CRC', 561.39000, 0.00000, 0.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, 1500.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 18, '000000000000', '5062108190000000000000040000000013113267485', '0040000000013', 13, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (19, 1, 1, 2, NULL, NULL, '2019-08-22 09:28:59.318781', '01        ', 1500.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 24, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (20, 1, 1, 2, NULL, NULL, '2019-08-22 09:29:24.864262', '01        ', 1500.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 25, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (27, 1, 1, 2, 0, 1, '2019-08-22 10:55:26.257554', '01        ', 1515.00, 0.00, 1, 1, 'CRC', 561.75000, 0.00000, 444.00000, 555.00000, 1515.00000, 0.00000, 1515.00000, 1515.00000, 0.00000, 1515.00000, 0.00000, 1515.00000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 32, '000000000000', '5062208190000000000000010000000027124168753', '0010000000027', 27, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (23, 1, 1, 2, 0, 1, '2019-08-22 09:30:47.495465', '01        ', 5000.00, 0.00, 1, 1, 'CRC', 561.75000, 333.00000, 444.00000, 555.00000, 5000.00000, 0.00000, 5000.00000, 5000.00000, 0.00000, 5000.00000, 0.00000, 5000.00000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 28, '000000000000', '5062208190000000000000010000000023181654237', '0010000000023', 23, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (26, 1, 1, 2, 0, 1, '2019-08-22 10:55:02.868414', '01        ', 1500.00, 0.00, 1, 1, 'CRC', 561.75000, 0.00000, 444.00000, 555.00000, 1500.00000, 0.00000, 1500.00000, 1500.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 31, '000000000000', '5062208190000000000000040000000026162841573', '0040000000026', 26, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (24, 1, 1, 2, 0, 1, '2019-08-22 09:31:57.398488', '01        ', 3515.00, 0.00, 1, 1, 'CRC', 561.75000, 333.00000, 444.00000, 555.00000, 3515.00000, 0.00000, 3515.00000, 3515.00000, 0.00000, 3515.00000, 0.00000, 3515.00000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 29, '000000000000', '5062208190000000000000010000000024185167243', '0010000000024', 24, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (28, 1, 1, 2, NULL, NULL, '2019-08-22 11:02:56.61705', '01        ', 15.00, 10.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 33, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (30, 1, 1, 2, NULL, NULL, '2019-08-22 11:05:29.935959', '01        ', 1500.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 35, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (29, 1, 1, 2, NULL, NULL, '2019-08-22 11:04:53.737113', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 34, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (31, 1, 1, 2, NULL, NULL, '2019-08-22 11:05:57.447306', '01        ', 20.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 36, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (32, 1, 1, 2, NULL, NULL, '2019-08-22 11:06:54.645319', '01        ', 15.00, 10.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 37, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (33, 1, 1, 2, NULL, NULL, '2019-08-22 11:09:26.524213', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 38, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (34, 1, 1, 2, NULL, NULL, '2019-08-22 11:26:03.854866', '01        ', 5035.00, 27.96, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 39, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (35, 1, 1, 2, NULL, NULL, '2019-08-22 11:31:40.404739', '01        ', 5035.00, 29.95, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 40, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (36, 1, 1, 2, NULL, NULL, '2019-08-22 11:36:22.319478', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 41, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (37, 1, 1, 2, NULL, NULL, '2019-08-22 11:36:44.199403', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 42, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (38, 1, 1, 2, NULL, NULL, '2019-08-22 11:40:25.675121', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 43, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (39, 1, 1, 2, NULL, NULL, '2019-08-22 11:41:00.478187', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 44, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (40, 1, 1, 2, NULL, NULL, '2019-08-22 11:44:47.028803', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 45, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (41, 1, 1, 2, NULL, NULL, '2019-08-22 11:46:04.930395', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 46, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (42, 1, 1, 2, NULL, NULL, '2019-08-22 11:47:10.681645', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 47, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (43, 1, 1, 2, NULL, NULL, '2019-08-22 11:47:29.554588', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 48, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (52, 1, 1, 2, NULL, NULL, '2019-08-22 13:56:34.49829', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 57, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (44, 1, 1, 2, 0, 1, '2019-08-22 11:48:28.093194', '01        ', 15.00, 0.00, 1, 1, 'CRC', 561.75000, 0.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 1.95000, 16.95000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 49, '000000000000', '5062208190000000000000040000000044183657412', '0040000000044', 44, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (53, 1, 1, 2, NULL, NULL, '2019-08-22 13:58:51.273959', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 58, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (45, 1, 1, 2, 0, 1, '2019-08-22 11:50:12.858971', '01        ', 5035.00, 29.95, 1, 1, 'CRC', 561.75000, 0.00000, 0.00000, 1515.00000, 20.00000, 1515.00000, 20.00000, 1535.00000, 130.00000, 1405.00000, 336.95000, 1741.95000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 50, '000000000000', '5062208190000000000000040000000045137625814', '0040000000045', 45, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (46, 1, 1, 2, 0, 1, '2019-08-22 11:52:46.848738', '01        ', 0.00, 29.95, 0, 1, 'CRC', 561.75000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 51, '000000000000', '5062208190000000000000010000000046132761584', '0010000000046', 46, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (54, 1, 1, 2, 0, 1, '2019-08-22 14:05:35.304744', '01        ', 15.00, 0.00, 1, 1, 'CRC', 561.75000, 0.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 1.95000, 16.95000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 59, '000000000000', '5062208190000000000000040000000054168357241', '0040000000054', 54, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (47, 1, 1, 2, 0, 1, '2019-08-22 11:53:13.275229', '01        ', 15.00, 0.00, 1, 1, 'CRC', 561.75000, 0.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 1.95000, 16.95000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 52, '000000000000', '5062208190000000000000010000000047174132586', '0010000000047', 47, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (48, 1, 1, 2, NULL, NULL, '2019-08-22 13:37:36.721627', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 53, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (49, 1, 1, 2, NULL, NULL, '2019-08-22 13:45:11.385587', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 54, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (50, 1, 1, 2, NULL, NULL, '2019-08-22 13:48:02.629082', '01        ', 0.00, 0.00, NULL, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 55, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (51, 1, 1, 2, NULL, NULL, '2019-08-22 13:48:10.260171', '01        ', 15.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 56, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (64, 1, 1, 2, 0, 1, '2019-08-26 20:44:47.661597', '01        ', 15.00, 10.00, 1, 1, 'CRC', 563.07000, 0.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 1.50000, 13.50000, 1.95000, 15.45000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 69, '000000000000', '5062608190000000000000040000000064136847125', '0040000000064', 64, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (58, 1, 3, 2, 0, 1, '2019-08-26 20:27:50.126766', '01        ', 3500.00, 0.00, 1, 1, 'CRC', 563.07000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 320.00000, 320.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 63, '000000000000', '5062608190000000000000040000000058137854216', '0040000000058', 58, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (55, 1, 1, 2, 0, 1, '2019-08-22 14:07:34.248812', '01        ', 5035.00, 29.95, 1, 1, 'CRC', 561.75000, 0.00000, 0.00000, 1515.00000, 20.00000, 1515.00000, 20.00000, 1535.00000, 130.00000, 1405.00000, 336.95000, 1741.95000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 60, '000000000000', '5062208190000000000000010000000055184532176', '0010000000055', 55, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (61, 1, 1, 2, 0, 1, '2019-08-26 20:39:57.918784', '01        ', 15.00, 25.00, 1, 1, 'CRC', 563.07000, 0.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 25.00000, -10.00000, 1.95000, -8.05000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 66, '000000000000', '5062608190000000000000010000000061185273416', '0010000000061', 61, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (56, 1, 1, 2, 0, 1, '2019-08-22 16:22:39.679817', '01        ', 5035.00, 0.00, 1, 1, 'CRC', 561.75000, 0.00000, 0.00000, 1515.00000, 20.00000, 1515.00000, 20.00000, 1535.00000, 0.00000, 1535.00000, 336.95000, 1871.95000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 61, '000000000000', '5062208190000000000000040000000056121678345', '0040000000056', 56, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (59, 1, 3, 2, 0, 1, '2019-08-26 20:36:24.199305', '01        ', 20.00, 0.00, 1, 1, 'CRC', 563.07000, 0.00000, 0.00000, 0.00000, 20.00000, 0.00000, 20.00000, 20.00000, 0.00000, 20.00000, 0.00000, 20.00000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 64, '000000000000', '5062608190000000000000010000000059142571863', '0010000000059', 59, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (57, 1, 1, 2, 0, 1, '2019-08-22 16:54:19.207728', '01        ', 5035.00, 0.00, 1, 1, 'CRC', 561.75000, 0.00000, 0.00000, 1515.00000, 20.00000, 1515.00000, 20.00000, 1535.00000, 0.00000, 1535.00000, 336.95000, 1871.95000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 62, '000000000000', '5062208190000000000000040000000057145826713', '0040000000057', 57, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (63, 1, 1, 2, 0, 1, '2019-08-26 20:42:39.235268', '01        ', 15.00, 10.00, 1, 1, 'CRC', 563.07000, 0.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 150.00000, -135.00000, 1.95000, -133.05000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 68, '000000000000', '5062608190000000000000010000000063145376128', '0010000000063', 63, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (60, 1, 1, 2, 0, 1, '2019-08-26 20:37:44.36679', '01        ', 15.00, 0.00, 1, 1, 'CRC', 563.07000, 0.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 1.95000, 16.95000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 65, '000000000000', '5062608190000000000000010000000060178241653', '0010000000060', 60, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (62, 1, 1, 2, 0, 1, '2019-08-26 20:41:54.390059', '01        ', 15.00, 0.00, 1, 1, 'CRC', 563.07000, 0.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 1.95000, 16.95000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 67, '000000000000', '5062608190000000000000040000000062147815263', '0040000000062', 62, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (66, 1, 1, 2, 0, 1, '2019-08-28 09:48:07.316429', '01        ', 15.00, 10.00, 1, 1, 'CRC', 563.95000, 0.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 1.50000, 13.50000, 1.95000, 15.45000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 71, '000000000000', '5062808190000000000000040000000066136758412', '0040000000066', 66, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (65, 1, 1, 2, 0, 1, '2019-08-26 20:47:06.74603', '01        ', 2000.00, 10.00, 1, 1, 'CRC', 563.07000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 200.00000, -200.00000, 260.00000, 60.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 70, '000000000000', '5062608190000000000000040000000065113826475', '0040000000065', 65, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (67, 1, 1, 2, NULL, NULL, '2019-08-28 10:15:34.026936', '01        ', 15.00, 10.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 72, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (68, 1, 1, 2, 0, 1, '2019-08-28 10:16:42.927541', '01        ', 15.00, 10.00, 1, 1, 'CRC', 563.95000, 0.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 1.50000, 13.50000, 1.95000, 15.45000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 73, '000000000000', '5062808190000000000000040000000068142756381', '0040000000068', 68, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (69, 1, 1, 2, 0, 1, '2019-08-28 10:31:28.825807', '01        ', 15.00, 10.00, 1, 1, 'CRC', 563.95000, 0.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 1.50000, 13.50000, 0.13000, 13.63000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 74, '000000000000', '5062808190000000000000040000000069137845621', '0040000000069', 69, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (70, 1, 1, 2, 0, 1, '2019-08-28 10:34:43.758974', '01        ', 15.00, 10.00, 1, 1, 'CRC', 563.95000, 0.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 1.50000, 13.50000, 1.95000, 15.45000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 75, '000000000000', '5062808190000000000000040000000070161437852', '0040000000070', 70, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (89, 1, 1, 2, 0, 1, '2019-08-28 17:00:40.938843', '01        ', 1580.00, 10.00, 1, 1, 'CRC', 563.95000, 1500.00000, 0.00000, 15.00000, 65.00000, 1515.00000, 65.00000, 1580.00000, 158.00000, 1422.00000, 109.75500, 1531.75500, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 94, '000000000000', '5062808190000000000000040000000089136851427', '0040000000089', 89, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (80, 1, 1, 2, 0, 1, '2019-08-28 16:26:02.704827', '01        ', 1535.00, 10.00, 1, 1, 'CRC', 563.95000, 1500.00000, 0.00000, 15.00000, 20.00000, 1515.00000, 20.00000, 1535.00000, 153.50000, 1381.50000, 15.25500, 1396.75500, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 85, '000000000000', '5062808190000000000000040000000080141325786', '0040000000080', 80, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (71, 1, 1, 2, 0, 1, '2019-08-28 10:57:08.166025', '01        ', 20.00, 10.00, 1, 1, 'CRC', 563.95000, 0.00000, 0.00000, 0.00000, 20.00000, 0.00000, 20.00000, 20.00000, 2.00000, 18.00000, 0.00000, 18.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 76, '000000000000', '5062808190000000000000040000000071185631427', '0040000000071', 71, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (72, 1, 1, 2, 0, 1, '2019-08-28 11:04:13.761742', '01        ', 1535.00, 10.00, 1, 1, 'CRC', 563.95000, 1500.00000, 0.00000, 15.00000, 20.00000, 1515.00000, 20.00000, 1535.00000, 153.50000, 1381.50000, 16.95000, 1398.45000, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 77, '000000000000', '5062808190000000000000010000000072151728463', '0010000000072', 72, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (73, 1, 1, 2, NULL, NULL, '2019-08-28 15:40:35.623653', '01        ', 1535.00, 10.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 78, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (74, 1, 1, 2, NULL, NULL, '2019-08-28 15:45:57.449696', '01        ', 1535.00, 10.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 79, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (75, 1, 1, 2, NULL, NULL, '2019-08-28 15:49:30.343653', '01        ', 1535.00, 10.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 80, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (86, 1, 1, 2, 0, 1, '2019-08-28 16:39:42.660628', '01        ', 20.00, 10.00, 1, 1, 'CRC', 563.95000, 0.00000, 0.00000, 0.00000, 20.00000, 0.00000, 20.00000, 20.00000, 2.00000, 18.00000, 0.00000, 18.00000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 91, '000000000000', '5062808190000000000000040000000086147231856', '0040000000086', 86, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (81, 1, 1, 2, 0, 1, '2019-08-28 16:28:26.552448', '01        ', 1535.00, 10.00, 1, 1, 'CRC', 563.95000, 1500.00000, 0.00000, 15.00000, 20.00000, 1515.00000, 20.00000, 1535.00000, 153.50000, 1381.50000, 15.25500, 1396.75500, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 86, '000000000000', '5062808190000000000000040000000081171586234', '0040000000081', 81, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (76, 1, 1, 2, 0, 1, '2019-08-28 15:51:07.302463', '01        ', 1535.00, 44.80, 1, 1, 'CRC', 563.95000, 1500.00000, 0.00000, 15.00000, 20.00000, 1515.00000, 20.00000, 1535.00000, 687.75000, 847.25000, 9.71250, 856.96250, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 81, '000000000000', '5062808190000000000000040000000076173521846', '0040000000076', 76, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (77, 1, 1, 2, NULL, NULL, '2019-08-28 16:07:14.008016', '01        ', 1535.00, 10.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 82, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (78, 1, 1, 2, 0, 1, '2019-08-28 16:20:29.187726', '01        ', 1535.00, 25.26, 1, 1, 'CRC', 563.95000, 1500.00000, 0.00000, 15.00000, 20.00000, 1515.00000, 20.00000, 1535.00000, 387.75000, 1147.25000, 1.46110, 1147.25010, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 83, '000000000000', '5062808190000000000000040000000078168537142', '0040000000078', 78, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (82, 1, 1, 2, 0, 1, '2019-08-28 16:34:59.8142', '01        ', 1535.00, 10.00, 1, 1, 'CRC', 563.95000, 1500.00000, 0.00000, 15.00000, 20.00000, 1515.00000, 20.00000, 1535.00000, 153.50000, 1381.50000, 15.25500, 1396.75500, '01', 0, '01', 'FE', NULL, NULL, NULL, NULL, '01', 87, '000000000000', '5062808190000000000000010000000082154137628', '0010000000082', 82, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (79, 1, 1, 2, 0, 1, '2019-08-28 16:24:37.016', '01        ', 1535.00, 15.00, 1, 1, 'CRC', 563.95000, 1500.00000, 0.00000, 15.00000, 20.00000, 1515.00000, 20.00000, 1535.00000, 230.25000, 1304.75000, 14.40750, 1319.15750, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 84, '000000000000', '5062808190000000000000040000000079158612473', '0040000000079', 79, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (83, 1, 1, 2, NULL, NULL, '2019-08-28 16:35:44.054055', '01        ', 1535.00, 10.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, '01', 0, '01', '04', NULL, NULL, NULL, NULL, NULL, 88, NULL, NULL, NULL, 0, NULL, NULL, NULL);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (87, 1, 1, 2, 0, 1, '2019-08-28 16:40:32.217802', '01        ', 1500.00, 10.00, 1, 1, 'CRC', 563.95000, 1500.00000, 0.00000, 0.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, 150.00000, 1350.00000, 13.50000, 1363.50000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 92, '000000000000', '5062808190000000000000040000000087135476218', '0040000000087', 87, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (84, 1, 1, 2, 0, 1, '2019-08-28 16:36:27.165283', '01        ', 15.00, 10.00, 1, 1, 'CRC', 563.95000, 0.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 1.50000, 13.50000, 1.75500, 15.25500, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 89, '000000000000', '5062808190000000000000040000000084148367125', '0040000000084', 84, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (85, 1, 1, 2, 0, 1, '2019-08-28 16:37:46.591346', '01        ', 15.00, 10.00, 1, 1, 'CRC', 563.95000, 0.00000, 0.00000, 15.00000, 0.00000, 15.00000, 0.00000, 15.00000, 1.50000, 13.50000, 1.75500, 15.25500, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 90, '000000000000', '5062808190000000000000040000000085161724358', '0040000000085', 85, 0.00000, 0.00000, 0.00000);
INSERT INTO public.factura (idfactura, idcuenta, idempleado, idperiodoventa, idreceptor, idemisor, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante, condicion_venta, plazo_credito, medio_pago, tipo, status, razon, referencia, razon_nota, tipo_comprobante, iddetalle, receptor_numero, clavenumerica, consecutivo, num_documento, totalservexonerados, totalmercanciasexoneradas, totalexonerado) VALUES (88, 1, 1, 2, 0, 1, '2019-08-28 16:41:51.547165', '01        ', 1500.00, 15.00, 1, 1, 'CRC', 563.95000, 1500.00000, 0.00000, 0.00000, 0.00000, 1500.00000, 0.00000, 1500.00000, 225.00000, 1275.00000, 12.75000, 1287.75000, '01', 0, '01', 'TE', NULL, NULL, NULL, NULL, '04', 93, '000000000000', '5062808190000000000000040000000088131872546', '0040000000088', 88, 0.00000, 0.00000, 0.00000);


--
-- TOC entry 3244 (class 0 OID 25380)
-- Dependencies: 239
-- Data for Name: fila; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.fila (idorden) VALUES (251);


--
-- TOC entry 3238 (class 0 OID 25349)
-- Dependencies: 233
-- Data for Name: gasto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.gasto (idgasto, idtipogasto, descripciongasto, estadogasto, montogasto, fechagasto, observaciongasto) VALUES (1, 1, 'Recibo Agua                                       ', 'Se debe             ', 50000.00, '2018-08-02 11:03:11.148049', 'Pago mes de Octubre                                                                                 ');
INSERT INTO public.gasto (idgasto, idtipogasto, descripciongasto, estadogasto, montogasto, fechagasto, observaciongasto) VALUES (2, 2, 'Salario Empleado1                                 ', 'Pagado              ', 150000.00, '2018-08-02 11:03:11.148049', 'Planilla Octubre                                                                                    ');
INSERT INTO public.gasto (idgasto, idtipogasto, descripciongasto, estadogasto, montogasto, fechagasto, observaciongasto) VALUES (3, 3, 'Ron                                               ', 'Pagado              ', 15000.00, '2018-08-02 11:03:11.148049', 'Litro de Ron                                                                                        ');


--
-- TOC entry 3250 (class 0 OID 25414)
-- Dependencies: 245
-- Data for Name: impuesto; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3230 (class 0 OID 25293)
-- Dependencies: 225
-- Data for Name: inventario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (2, 1, 'Pmienta                                           ', 150.00, 1000.00, 10.00, 'Gramos    ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (3, 1, 'Sal                                               ', 150.00, 1000.00, 10.00, 'Gramos    ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (4, 1, 'Salsa Inglesa                                     ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (7, 2, 'Botellita 500ml                                   ', 150.00, 1000.00, 10.00, 'Unidades  ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (43, 7, 'Jugo de Naranja                                   ', 150.00, 973.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (22, 3, 'Licor de Melocoton                                ', 150.00, 998.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (32, 4, 'Hierba Buena                                      ', 150.00, 820.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (13, 3, 'Chachaca                                          ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (16, 3, 'Cranberry                                         ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (17, 3, 'Crema de Cacao Blanco                             ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (19, 3, 'Ginebra                                           ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (21, 3, 'Licor de Cafe                                     ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (23, 3, 'Malibu                                            ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (39, 7, 'Horchata                                          ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (41, 7, 'Jugo de Fresa                                     ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (42, 7, 'Jugo de Maracuya                                  ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (47, 7, 'Leche                                             ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (48, 7, 'Leche Evaporada                                   ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (33, 4, 'Limon                                             ', 150.00, 979.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (29, 3, 'Vino de Nance                                     ', 150.00, 997.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (35, 5, 'Soda                                              ', 150.00, 762.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (45, 7, 'Jugo de Tomate                                    ', 150.00, 996.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (37, 7, 'Crema de Coco                                     ', 150.00, 931.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (24, 3, 'Ron Blanco                                        ', 150.00, 874.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (5, 1, 'Tabasco                                           ', 150.00, 999.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (46, 7, 'Jugo de Toronja                                   ', 150.00, 988.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (28, 3, 'Vermount Seco                                     ', 150.00, 972.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (25, 3, 'Tequilaa                                          ', 150.00, 985.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (31, 3, 'Whisky                                            ', 150.00, 991.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (15, 3, 'Cerveza                                           ', 150.00, 988.00, 10.00, 'Unidades  ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (44, 7, 'Jugo de Piña                                      ', 150.00, 770.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (40, 7, 'Jugo de Cereza                                    ', 150.00, 980.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (12, 3, 'Blue Curacao                                      ', 150.00, 991.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (6, 2, 'Botellita 240ml                                   ', 150.00, 996.00, 10.00, 'Unidades  ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (20, 3, 'Jager                                             ', 150.00, 989.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (49, 7, 'Limonada                                          ', 150.00, 926.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (34, 5, 'Coca-Cola                                         ', 150.00, 988.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (38, 7, 'Granadina                                         ', 150.00, 997.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (50, 7, 'Sirope de Cola                                    ', 150.00, 999.50, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (26, 3, 'Tequila Rose                                      ', 150.00, 992.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (27, 3, 'Triple Sec                                        ', 150.00, 994.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (30, 3, 'Vodka                                             ', 150.00, 979.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (18, 3, 'Crema de Menta                                    ', 150.00, 996.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (36, 6, 'Hielo                                             ', 150.00, 72.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (14, 3, 'Cacique                                           ', 150.00, 991.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (51, 7, 'Te Frio                                           ', 150.00, 990.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (1, 1, 'Azucar                                            ', 150.00, 902.00, 10.00, 'Unidad    ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (11, 2, 'Vaso                                              ', 150.00, 942.00, 10.00, 'Unidades  ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (9, 2, 'Postal                                            ', 150.00, 940.00, 10.00, 'Unidades  ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (10, 2, 'Tapa                                              ', 150.00, 942.00, 10.00, 'Unidades  ', NULL, 1);
INSERT INTO public.inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (8, 2, 'Pajilla                                           ', 150.00, 941.00, 10.00, 'Unidades  ', NULL, 1);


--
-- TOC entry 3231 (class 0 OID 25305)
-- Dependencies: 226
-- Data for Name: inventarioproducto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (2, 48, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (3, 48, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (21, 48, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (8, 47, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (11, 47, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (10, 47, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (36, 47, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (25, 44, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (11, 44, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (25, 44, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (51, 44, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (18, 43, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (18, 43, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (30, 43, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (51, 43, 1.00);
INSERT INTO public.inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (51, 43, 1.00);


--
-- TOC entry 3226 (class 0 OID 25234)
-- Dependencies: 221
-- Data for Name: orden; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (12, 1, 99, 5, 1, 'Cancelada ', '2019-08-17 17:02:57', 2000.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-17 12:02:57.465597', 1.00000, 1, 1.00000, 5, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (11, 1, 98, 5, 1, 'Cancelada ', '2019-08-17 17:02:41', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-17 12:02:42.433354', 1.00000, 1, 1.00000, 5, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (1, 1, 98, 1, 1, 'Cancelada ', '2019-08-14 23:30:54', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-14 18:30:54.331224', 1.00000, 1, 1.00000, 1, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (2, 1, 98, 1, 1, 'Cancelada ', '2019-08-14 23:30:57', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-14 18:30:57.774735', 1.00000, 1, 1.00000, 1, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (81, 1, 102, 31, 1, 'Cancelada ', '2019-08-22 16:05:55', 20.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:05:55.198996', 1.00000, 1, 1.00000, 36, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (14, 1, 98, 6, 1, 'Cancelada ', '2019-08-17 17:11:35', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-17 12:11:35.480725', 1.00000, 1, 1.00000, 6, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (27, 1, 102, 8, 1, 'Cancelada ', '2019-08-19 22:23:51', 20.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-19 17:23:51.49063', 1.00000, 1, 1.00000, 8, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (28, 1, 101, 8, 1, 'Cancelada ', '2019-08-19 22:24:13', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-19 17:24:14.021639', 1.00000, 1, 1.00000, 8, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (25, 1, 98, 8, 1, 'Cancelada ', '2019-08-19 19:04:33', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-19 14:04:33.20816', 1.00000, 1, 1.00000, 8, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (4, 1, 99, 2, 1, 'Cancelada ', '2019-08-14 23:34:23', 2000.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-14 18:34:24.025908', 1.00000, 1, 1.00000, 2, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (5, 1, 100, 2, 1, 'Cancelada ', '2019-08-14 23:34:23', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-14 18:34:24.053059', 1.00000, 1, 1.00000, 2, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (3, 1, 98, 2, 1, 'Cancelada ', '2019-08-14 23:34:23', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-14 18:34:23.982097', 1.00000, 1, 1.00000, 2, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (6, 1, 100, 2, 1, 'Cancelada ', '2019-08-14 23:34:34', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-14 18:34:34.545158', 1.00000, 1, 1.00000, 2, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (15, 1, 98, 7, 1, 'Cancelada ', '2019-08-17 19:10:51', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-17 14:10:51.366117', 1.00000, 1, 1.00000, 7, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (16, 1, 99, 7, 1, 'Cancelada ', '2019-08-17 19:15:30', 2000.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-17 14:15:30.221735', 1.00000, 1, 1.00000, 7, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (7, 1, 98, 3, 1, 'Cancelada ', '2019-08-14 23:44:59', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-14 18:44:59.508819', 1.00000, 1, 1.00000, 3, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (100, 1, 101, 42, 1, 'Cancelada ', '2019-08-22 16:47:08', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:47:08.763728', 1.00000, 1, 1.00000, 47, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (120, 1, 98, 56, 1, 'Cancelada ', '2019-08-22 21:22:34', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 16:22:34.291901', 1.00000, 1, 1.00000, 61, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (8, 1, 98, 4, 1, 'Cancelada ', '2019-08-15 16:36:30', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-15 11:36:30.745929', 1.00000, 1, 1.00000, 4, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (9, 1, 98, 4, 1, 'Cancelada ', '2019-08-15 16:36:40', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-15 11:36:40.941799', 1.00000, 1, 1.00000, 4, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (139, 1, 101, 66, 1, 'Cancelada ', '2019-08-28 14:47:05', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 09:47:05.379751', 1.00000, 1, 1.00000, 71, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (23, 1, 100, 8, 1, 'Cancelada ', '2019-08-18 03:27:16', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-17 22:27:16.88914', 1.00000, 1, 1.00000, 8, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (26, 1, 99, 8, 1, 'Cancelada ', '2019-08-19 19:04:38', 2000.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-19 14:04:38.934067', 1.00000, 1, 1.00000, 8, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (46, 1, 98, 12, 1, 'Cancelada ', '2019-08-21 23:40:09', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-21 18:40:09.163904', 1.00000, 1, 1.00000, 17, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (29, 1, 98, 9, 1, 'Cancelada ', '2019-08-19 22:37:35', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-19 17:37:35.590383', 1.00000, 1, 1.00000, 9, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (30, 1, 99, 9, 1, 'Cancelada ', '2019-08-19 22:37:35', 2000.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-19 17:37:35.593737', 1.00000, 1, 1.00000, 9, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (43, 1, 98, 11, 1, 'Cancelada ', '2019-08-21 03:27:42', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-20 22:27:42.515614', 1.00000, 1, 1.00000, 17, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (35, 1, 98, 10, 1, 'Cancelada ', '2019-08-20 15:18:15', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-20 10:18:15.096739', 1.00000, 1, 1.00000, 16, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (36, 1, 98, 10, 2, 'Cancelada ', '2019-08-20 15:18:20', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-20 10:18:20.141545', 1.00000, 1, 1.00000, 16, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (40, 1, 101, 11, 1, 'Cancelada ', '2019-08-21 00:27:49', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-20 19:27:49.409502', 1.00000, 1, 1.00000, 17, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (44, 1, 99, 11, 1, 'Cancelada ', '2019-08-21 03:27:42', 2000.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-20 22:27:42.555652', 1.00000, 1, 1.00000, 17, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (45, 1, 100, 11, 1, 'Cancelada ', '2019-08-21 03:27:42', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-20 22:27:42.605043', 1.00000, 1, 1.00000, 17, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (47, 1, 98, 13, 1, 'Cancelada ', '2019-08-21 23:48:35', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-21 18:48:35.947823', 1.00000, 1, 1.00000, 18, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (62, 1, 98, 17, 1, 'Cancelada ', '2019-08-22 12:44:37', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 07:44:37.952112', 1.00000, 1, 1.00000, 22, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (60, 1, 98, 15, 1, 'Cancelada ', '2019-08-22 03:09:55', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-21 22:09:55.677412', 1.00000, 1, 1.00000, 20, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (65, 1, 98, 20, 1, 'Cancelada ', '2019-08-22 14:29:21', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 09:29:21.257422', 1.00000, 1, 1.00000, 25, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (58, 1, 99, 14, 1, 'Cancelada ', '2019-08-22 02:46:56', 2000.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-21 21:46:56.415266', 1.00000, 1, 1.00000, 19, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (57, 1, 98, 14, 1, 'Cancelada ', '2019-08-22 02:46:56', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-21 21:46:56.408611', 1.00000, 1, 1.00000, 19, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (59, 1, 101, 14, 1, 'Cancelada ', '2019-08-22 02:46:56', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-21 21:46:56.42689', 1.00000, 1, 1.00000, 19, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (61, 1, 98, 16, 1, 'Cancelada ', '2019-08-22 12:05:49', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 07:05:49.792203', 1.00000, 1, 1.00000, 21, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (64, 1, 98, 19, 1, 'Cancelada ', '2019-08-22 14:28:54', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 09:28:54.864682', 1.00000, 1, 1.00000, 24, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (63, 1, 98, 18, 1, 'Cancelada ', '2019-08-22 12:56:14', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 07:56:14.315043', 1.00000, 1, 1.00000, 23, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (66, 1, 98, 21, 1, 'Cancelada ', '2019-08-22 14:29:44', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 09:29:44.866079', 1.00000, 1, 1.00000, 26, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (67, 1, 98, 22, 1, 'Cancelada ', '2019-08-22 14:30:14', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 09:30:14.652719', 1.00000, 1, 1.00000, 27, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (68, 1, 98, 23, 1, 'Cancelada ', '2019-08-22 14:30:40', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 09:30:40.495503', 1.00000, 1, 1.00000, 28, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (69, 1, 99, 23, 1, 'Cancelada ', '2019-08-22 14:30:40', 2000.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 09:30:40.497117', 1.00000, 1, 1.00000, 28, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (82, 1, 101, 32, 1, 'Cancelada ', '2019-08-22 16:06:45', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:06:45.258385', 1.00000, 1, 1.00000, 37, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (101, 1, 101, 43, 1, 'Cancelada ', '2019-08-22 16:47:27', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:47:27.243027', 1.00000, 1, 1.00000, 48, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (124, 1, 102, 56, 1, 'Cancelada ', '2019-08-22 21:22:34', 20.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 16:22:34.295522', 1.00000, 1, 1.00000, 61, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (130, 1, 98, 58, 1, 'Cancelada ', '2019-08-27 01:27:42', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-26 20:27:42.577414', 1.00000, 1, 1.00000, 63, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (131, 1, 99, 58, 1, 'Cancelada ', '2019-08-27 01:27:42', 2000.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-26 20:27:42.578456', 1.00000, 1, 1.00000, 63, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (153, 1, 101, 74, 1, 'Cancelada ', '2019-08-28 20:45:29', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 15:45:29.795092', 1.00000, 1, 1.00000, 79, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (140, 1, 101, 67, 1, 'Cancelada ', '2019-08-28 14:55:00', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 09:55:00.906776', 1.00000, 1, 1.00000, 72, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (174, 1, 101, 81, 1, 'Cancelada ', '2019-08-28 21:27:55', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:27:55.30975', 1.00000, 1, 1.00000, 86, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (173, 1, 100, 81, 1, 'Cancelada ', '2019-08-28 21:27:55', 1500.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:27:55.307063', 1.00000, 1, 1.00000, 86, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (71, 1, 100, 24, 1, 'Cancelada ', '2019-08-22 14:31:47', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 09:31:47.506195', 1.00000, 1, 1.00000, 29, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (83, 1, 101, 33, 1, 'Cancelada ', '2019-08-22 16:09:24', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:09:24.27569', 1.00000, 1, 1.00000, 38, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (102, 1, 101, 44, 1, 'Cancelada ', '2019-08-22 16:48:26', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:48:26.06751', 1.00000, 1, 1.00000, 49, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (123, 1, 101, 56, 1, 'Cancelada ', '2019-08-22 21:22:34', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 16:22:34.29465', 1.00000, 1, 1.00000, 61, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (132, 1, 102, 59, 1, 'Cancelada ', '2019-08-27 01:36:18', 20.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-26 20:36:18.57027', 1.00000, 1, 1.00000, 64, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (154, 1, 102, 74, 1, 'Cancelada ', '2019-08-28 20:45:29', 20.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 15:45:29.797141', 1.00000, 1, 1.00000, 79, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (175, 1, 102, 81, 1, 'Cancelada ', '2019-08-28 21:27:55', 20.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:27:55.354504', 1.00000, 1, 1.00000, 86, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (141, 1, 101, 68, 1, 'Cancelada ', '2019-08-28 15:16:30', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 10:16:30.380587', 1.00000, 1, 1.00000, 73, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (72, 1, 99, 24, 1, 'Cancelada ', '2019-08-22 14:31:47', 2000.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 09:31:47.506156', 1.00000, 1, 1.00000, 29, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (84, 1, 98, 34, 1, 'Cancelada ', '2019-08-22 16:25:14', 1500.00, NULL, 45.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:25:14.52672', 1.00000, 1, 1.00000, 39, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (103, 1, 98, 45, 1, 'Cancelada ', '2019-08-22 16:49:47', 1500.00, NULL, 25.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:49:47.250154', 1.00000, 1, 1.00000, 50, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (122, 1, 100, 56, 1, 'Cancelada ', '2019-08-22 21:22:34', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 16:22:34.293454', 1.00000, 1, 1.00000, 61, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (152, 1, 100, 74, 1, 'Cancelada ', '2019-08-28 20:45:29', 1500.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 15:45:29.794456', 1.00000, 1, 1.00000, 79, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (133, 1, 101, 60, 1, 'Cancelada ', '2019-08-27 01:37:37', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-26 20:37:37.415206', 1.00000, 1, 1.00000, 65, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (176, 1, 100, 82, 1, 'Cancelada ', '2019-08-28 21:34:46', 1500.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:34:46.1612', 1.00000, 1, 1.00000, 87, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (142, 1, 101, 69, 1, 'Cancelada ', '2019-08-28 15:30:51', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 10:30:51.529061', 1.00000, 1, 1.00000, 74, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (73, 1, 101, 24, 1, 'Cancelada ', '2019-08-22 14:31:47', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 09:31:47.508673', 1.00000, 1, 1.00000, 29, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (85, 1, 99, 34, 1, 'Cancelada ', '2019-08-22 16:25:14', 2000.00, NULL, 25.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:25:14.560529', 1.00000, 1, 1.00000, 39, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (106, 1, 101, 45, 1, 'Cancelada ', '2019-08-22 16:49:47', 15.00, NULL, 20.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:49:47.252206', 1.00000, 1, 1.00000, 50, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (121, 1, 99, 56, 1, 'Cancelada ', '2019-08-22 21:22:34', 2000.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 16:22:34.292139', 1.00000, 1, 1.00000, 61, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (155, 1, 100, 75, 1, 'Cancelada ', '2019-08-28 20:49:05', 1500.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 15:49:05.467809', 1.00000, 1, 1.00000, 80, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (134, 1, 101, 61, 1, 'Cancelada ', '2019-08-27 01:39:40', 15.00, NULL, 25.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-26 20:39:40.340413', 1.00000, 1, 1.00000, 66, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (177, 1, 101, 82, 1, 'Cancelada ', '2019-08-28 21:34:46', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:34:46.169318', 1.00000, 1, 1.00000, 87, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (143, 1, 101, 70, 1, 'Cancelada ', '2019-08-28 15:34:30', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 10:34:30.635352', 1.00000, 1, 1.00000, 75, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (74, 1, 98, 25, 1, 'Cancelada ', '2019-08-22 15:54:06', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 10:54:06.986385', 1.00000, 1, 1.00000, 30, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (86, 1, 100, 34, 1, 'Cancelada ', '2019-08-22 16:25:14', 1500.00, NULL, 15.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:25:14.566362', 1.00000, 1, 1.00000, 39, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (104, 1, 99, 45, 1, 'Cancelada ', '2019-08-22 16:49:47', 2000.00, NULL, 45.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:49:47.250983', 1.00000, 1, 1.00000, 50, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (125, 1, 98, 57, 1, 'Cancelada ', '2019-08-22 21:54:08', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 16:54:08.440584', 1.00000, 1, 1.00000, 62, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (135, 1, 101, 62, 1, 'Cancelada ', '2019-08-27 01:41:45', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-26 20:41:45.597453', 1.00000, 1, 1.00000, 67, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (156, 1, 101, 75, 1, 'Cancelada ', '2019-08-28 20:49:05', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 15:49:05.477813', 1.00000, 1, 1.00000, 80, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (178, 1, 102, 82, 1, 'Cancelada ', '2019-08-28 21:34:46', 20.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:34:46.174753', 1.00000, 1, 1.00000, 87, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (75, 1, 98, 26, 1, 'Cancelada ', '2019-08-22 15:54:58', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 10:54:58.186278', 1.00000, 1, 1.00000, 31, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (76, 1, 101, 27, 1, 'Cancelada ', '2019-08-22 15:55:11', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 10:55:11.852654', 1.00000, 1, 1.00000, 32, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (87, 1, 101, 34, 1, 'Cancelada ', '2019-08-22 16:25:14', 15.00, NULL, 20.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:25:14.574443', 1.00000, 1, 1.00000, 39, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (107, 1, 102, 45, 1, 'Cancelada ', '2019-08-22 16:49:47', 20.00, NULL, 25.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:49:47.284924', 1.00000, 1, 1.00000, 50, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (126, 1, 100, 57, 1, 'Cancelada ', '2019-08-22 21:54:08', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 16:54:08.467492', 1.00000, 1, 1.00000, 62, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (157, 1, 102, 75, 1, 'Cancelada ', '2019-08-28 20:49:05', 20.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 15:49:05.486755', 1.00000, 1, 1.00000, 80, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (136, 1, 101, 63, 1, 'Cancelada ', '2019-08-27 01:42:10', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-26 20:42:10.711584', 1.00000, 1, 1.00000, 68, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (179, 1, 100, 83, 1, 'Cancelada ', '2019-08-28 21:35:17', 1500.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:35:17.77197', 1.00000, 1, 1.00000, 88, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (145, 1, 102, 71, 1, 'Cancelada ', '2019-08-28 15:56:31', 20.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 10:56:31.844921', 1.00000, 1, 1.00000, 76, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (77, 1, 98, 27, 1, 'Cancelada ', '2019-08-22 15:55:21', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 10:55:21.331021', 1.00000, 1, 1.00000, 32, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (88, 1, 102, 34, 1, 'Cancelada ', '2019-08-22 16:25:14', 20.00, NULL, 25.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:25:14.58324', 1.00000, 1, 1.00000, 39, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (105, 1, 100, 45, 1, 'Cancelada ', '2019-08-22 16:49:47', 1500.00, NULL, 15.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:49:47.251521', 1.00000, 1, 1.00000, 50, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (127, 1, 99, 57, 1, 'Cancelada ', '2019-08-22 21:54:08', 2000.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 16:54:08.471144', 1.00000, 1, 1.00000, 62, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (158, 1, 100, 76, 1, 'Cancelada ', '2019-08-28 20:50:54', 1500.00, NULL, 45.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 15:50:54.384296', 1.00000, 1, 1.00000, 81, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (137, 1, 101, 64, 1, 'Cancelada ', '2019-08-27 01:44:15', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-26 20:44:15.620164', 1.00000, 1, 1.00000, 69, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (180, 1, 101, 83, 1, 'Cancelada ', '2019-08-28 21:35:17', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:35:17.773397', 1.00000, 1, 1.00000, 88, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (146, 1, 100, 72, 1, 'Cancelada ', '2019-08-28 16:03:35', 1500.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 11:03:35.237317', 1.00000, 1, 1.00000, 77, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (78, 1, 101, 28, 1, 'Cancelada ', '2019-08-22 16:02:42', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:02:42.288365', 1.00000, 1, 1.00000, 33, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (89, 1, 98, 35, 1, 'Cancelada ', '2019-08-22 16:31:07', 1500.00, NULL, 25.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:31:07.555931', 1.00000, 1, 1.00000, 40, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (108, 1, 101, 47, 1, 'Cancelada ', '2019-08-22 16:52:50', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:52:50.91158', 1.00000, 1, 1.00000, 52, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (128, 1, 101, 57, 1, 'Cancelada ', '2019-08-22 21:54:08', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 16:54:08.479072', 1.00000, 1, 1.00000, 62, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (160, 1, 102, 76, 1, 'Cancelada ', '2019-08-28 20:50:54', 20.00, NULL, 45.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 15:50:54.385311', 1.00000, 1, 1.00000, 81, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (138, 1, 99, 65, 1, 'Cancelada ', '2019-08-27 01:46:49', 2000.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-26 20:46:49.546186', 1.00000, 1, 1.00000, 70, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (181, 1, 102, 83, 1, 'Cancelada ', '2019-08-28 21:35:17', 20.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:35:17.777187', 1.00000, 1, 1.00000, 88, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (147, 1, 101, 72, 1, 'Cancelada ', '2019-08-28 16:03:35', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 11:03:35.238246', 1.00000, 1, 1.00000, 77, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (79, 1, 101, 29, 1, 'Cancelada ', '2019-08-22 16:04:49', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:04:49.387798', 1.00000, 1, 1.00000, 34, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (90, 1, 99, 35, 1, 'Cancelada ', '2019-08-22 16:31:07', 2000.00, NULL, 45.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:31:07.563009', 1.00000, 1, 1.00000, 40, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (109, 1, 101, 48, 1, 'Cancelada ', '2019-08-22 18:37:33', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 13:37:33.209999', 1.00000, 1, 1.00000, 53, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (129, 1, 102, 57, 1, 'Cancelada ', '2019-08-22 21:54:08', 20.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 16:54:08.488349', 1.00000, 1, 1.00000, 62, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (159, 1, 101, 76, 1, 'Cancelada ', '2019-08-28 20:50:54', 15.00, NULL, 25.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 15:50:54.384647', 1.00000, 1, 1.00000, 81, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (148, 1, 102, 72, 1, 'Cancelada ', '2019-08-28 16:03:35', 20.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 11:03:35.239604', 1.00000, 1, 1.00000, 77, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (182, 1, 101, 84, 1, 'Cancelada ', '2019-08-28 21:36:13', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:36:13.919579', 1.00000, 1, 1.00000, 89, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (80, 1, 100, 30, 1, 'Cancelada ', '2019-08-22 16:05:26', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:05:26.612643', 1.00000, 1, 1.00000, 35, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (91, 1, 100, 35, 1, 'Cancelada ', '2019-08-22 16:31:07', 1500.00, NULL, 15.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:31:07.564704', 1.00000, 1, 1.00000, 40, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (110, 1, 101, 49, 1, 'Cancelada ', '2019-08-22 18:45:08', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 13:45:09.011252', 1.00000, 1, 1.00000, 54, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (149, 1, 100, 73, 1, 'Cancelada ', '2019-08-28 20:39:51', 1500.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 15:39:51.23229', 1.00000, 1, 1.00000, 78, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (161, 1, 100, 77, 1, 'Cancelada ', '2019-08-28 21:06:38', 1500.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:06:38.559171', 1.00000, 1, 1.00000, 82, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (183, 1, 101, 85, 1, 'Cancelada ', '2019-08-28 21:37:33', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:37:33.108009', 1.00000, 1, 1.00000, 90, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (92, 1, 101, 35, 1, 'Cancelada ', '2019-08-22 16:31:07', 15.00, NULL, 20.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:31:07.565656', 1.00000, 1, 1.00000, 40, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (111, 1, 101, 51, 1, 'Cancelada ', '2019-08-22 18:48:03', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 13:48:03.393279', 1.00000, 1, 1.00000, 56, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (150, 1, 101, 73, 1, 'Cancelada ', '2019-08-28 20:39:51', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 15:39:51.23426', 1.00000, 1, 1.00000, 78, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (162, 1, 101, 77, 1, 'Cancelada ', '2019-08-28 21:06:38', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:06:38.56662', 1.00000, 1, 1.00000, 82, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (184, 1, 102, 86, 1, 'Cancelada ', '2019-08-28 21:39:05', 20.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:39:05.524618', 1.00000, 1, 1.00000, 91, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (93, 1, 102, 35, 1, 'Cancelada ', '2019-08-22 16:31:07', 20.00, NULL, 25.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:31:07.566764', 1.00000, 1, 1.00000, 40, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (112, 1, 101, 52, 1, 'Cancelada ', '2019-08-22 18:56:29', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 13:56:29.979328', 1.00000, 1, 1.00000, 57, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (151, 1, 102, 73, 1, 'Cancelada ', '2019-08-28 20:39:51', 20.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 15:39:51.265348', 1.00000, 1, 1.00000, 78, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (163, 1, 102, 77, 1, 'Cancelada ', '2019-08-28 21:06:38', 20.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:06:38.610433', 1.00000, 1, 1.00000, 82, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (185, 1, 100, 87, 1, 'Cancelada ', '2019-08-28 21:40:21', 1500.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:40:21.421473', 1.00000, 1, 1.00000, 92, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (94, 1, 101, 36, 1, 'Cancelada ', '2019-08-22 16:36:10', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:36:10.424967', 1.00000, 1, 1.00000, 41, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (113, 1, 101, 53, 1, 'Cancelada ', '2019-08-22 18:58:47', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 13:58:47.864618', 1.00000, 1, 1.00000, 58, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (165, 1, 101, 78, 1, 'Cancelada ', '2019-08-28 21:20:18', 15.00, NULL, 25.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:20:18.805951', 1.00000, 1, 1.00000, 83, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (186, 1, 100, 88, 1, 'Cancelada ', '2019-08-28 21:41:40', 1500.00, NULL, 15.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:41:40.517136', 1.00000, 1, 1.00000, 93, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (95, 1, 101, 37, 1, 'Cancelada ', '2019-08-22 16:36:37', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:36:37.474913', 1.00000, 1, 1.00000, 42, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (114, 1, 101, 54, 1, 'Cancelada ', '2019-08-22 19:05:31', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 14:05:31.786456', 1.00000, 1, 1.00000, 59, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (166, 1, 102, 78, 1, 'Cancelada ', '2019-08-28 21:20:18', 20.00, NULL, 45.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:20:18.809397', 1.00000, 1, 1.00000, 83, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (187, 1, 100, 89, 1, 'Cancelada ', '2019-08-28 22:00:21', 1500.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 17:00:22.009604', 1.00000, 1, 1.00000, 94, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (96, 1, 101, 38, 1, 'Cancelada ', '2019-08-22 16:40:13', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:40:13.057535', 1.00000, 1, 1.00000, 43, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (115, 1, 98, 55, 1, 'Cancelada ', '2019-08-22 19:07:06', 1500.00, NULL, 25.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 14:07:06.413491', 1.00000, 1, 1.00000, 60, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (164, 1, 100, 78, 1, 'Cancelada ', '2019-08-28 21:20:18', 1500.00, NULL, 25.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:20:18.804931', 1.00000, 1, 1.00000, 83, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (188, 1, 101, 89, 1, 'Cancelada ', '2019-08-28 22:00:21', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 17:00:22.056267', 1.00000, 1, 1.00000, 94, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (97, 1, 101, 39, 1, 'Cancelada ', '2019-08-22 16:40:58', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:40:58.05851', 1.00000, 1, 1.00000, 44, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (116, 1, 99, 55, 1, 'Cancelada ', '2019-08-22 19:07:06', 2000.00, NULL, 45.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 14:07:06.415209', 1.00000, 1, 1.00000, 60, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (167, 1, 100, 79, 1, 'Cancelada ', '2019-08-28 21:24:04', 1500.00, NULL, 15.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:24:04.768473', 1.00000, 1, 1.00000, 84, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (189, 1, 103, 89, 1, 'Cancelada ', '2019-08-28 22:00:21', 65.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 17:00:22.062246', 1.00000, 1, 1.00000, 94, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (98, 1, 101, 40, 1, 'Cancelada ', '2019-08-22 16:44:43', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:44:43.476387', 1.00000, 1, 1.00000, 45, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (117, 1, 100, 55, 1, 'Cancelada ', '2019-08-22 19:07:06', 1500.00, NULL, 15.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 14:07:06.417108', 1.00000, 1, 1.00000, 60, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (168, 1, 101, 79, 1, 'Cancelada ', '2019-08-28 21:24:04', 15.00, NULL, 15.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:24:04.781862', 1.00000, 1, 1.00000, 84, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (99, 1, 101, 41, 1, 'Cancelada ', '2019-08-22 16:46:01', 15.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 11:46:01.785632', 1.00000, 1, 1.00000, 46, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (118, 1, 101, 55, 1, 'Cancelada ', '2019-08-22 19:07:06', 15.00, NULL, 20.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 14:07:06.417249', 1.00000, 1, 1.00000, 60, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (169, 1, 102, 79, 1, 'Cancelada ', '2019-08-28 21:24:04', 20.00, NULL, 15.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:24:04.785394', 1.00000, 1, 1.00000, 84, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (119, 1, 102, 55, 1, 'Cancelada ', '2019-08-22 19:07:06', 20.00, NULL, 25.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 14:07:06.441032', 1.00000, 1, 1.00000, 60, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (170, 1, 101, 80, 1, 'Cancelada ', '2019-08-28 21:25:07', 15.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:25:07.649648', 1.00000, 1, 1.00000, 85, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (171, 1, 100, 80, 1, 'Cancelada ', '2019-08-28 21:25:07', 1500.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:25:07.649516', 1.00000, 1, 1.00000, 85, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (172, 1, 102, 80, 1, 'Cancelada ', '2019-08-28 21:25:07', 20.00, NULL, 10.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, 'Descuento general', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-28 16:25:07.653084', 1.00000, 1, 1.00000, 85, NULL);
INSERT INTO public.orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea, iddetalle, baseimponible) VALUES (70, 1, 100, 23, 1, 'Cancelada ', '2019-08-22 14:30:40', 1500.00, NULL, 0.00, 1, '1', '2', '1', '1', '1', 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2019-08-22 09:30:40.49968', 1.00000, 1, 1.00000, 28, NULL);


--
-- TOC entry 3208 (class 0 OID 25086)
-- Dependencies: 203
-- Data for Name: periodoventa; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.periodoventa (idperiodoventa, nombreperiodoventa, estadoperiodoventa, fechainicioperiodoventa, fechafinperiodoventa, idempleado) VALUES (2, 'Periodo1                                          ', 'Activo    ', '2018-08-02 11:03:11.148049', NULL, NULL);


--
-- TOC entry 3222 (class 0 OID 25205)
-- Dependencies: 217
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (46, 'Producto 10                                       ', 7, 3500, NULL, 1, '1', 3.00000, '05', 'unidad 10', 2500, 105.00000, '1', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (47, 'Producto 11                                       ', 7, 3500, NULL, 1, '1', 3.00000, '05', 'unidad 11', 2500, 105.00000, '2', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (48, 'Producto 12                                       ', 7, 3500, NULL, 1, '1', 3.00000, '05', 'unidad 12', 2500, 105.00000, '2', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (50, 'Producto 14                                       ', 2, 3500, NULL, 1, '4', 7.00000, '06', 'unidad 14', 2500, 245.00000, '2', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (54, 'Producto 18                                       ', 6, 3500, NULL, 1, '2', 5.00000, '06', 'unidad 18', 2500, 175.00000, '2', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (42, 'Producto 6                                        ', 6, 2500, NULL, 1, '4', 175.00000, '06', 'unidad 6', 1500, 7.00000, '01', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (55, 'Producto 19                                       ', 8, 3500, NULL, 1, '1', 2.00000, '05', 'unidad 19', 2500, 70.00000, '2', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (56, 'Producto 20                                       ', 1, 3500, NULL, 1, '2', 5.00000, '05', 'Unidad', 3000, 175.00000, '2', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (57, 'Producto 21                                       ', 2, 4000, NULL, 1, '1', 3.00000, '02', 'Unidad', 3500, 120.00000, '2', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (58, 'Producto 22                                       ', 8, 5000, NULL, 1, '98', 10.00000, '02', 'Otros', 4500, 500.00000, '2', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (59, 'Producto 22                                       ', 2, 3500, NULL, 1, '1', 3.00000, '02', 'Unidad', 3000, 105.00000, '2', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (62, 'Producto 25                                       ', 7, 5000, NULL, 1, '1', 2.00000, '05', 'Unidad', 4500, 100.00000, '1', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (61, 'Producto 24                                       ', 8, 3500, NULL, 1, '98', 350.00000, '03', 'Unidad', 3000, 10.00000, '02', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (53, 'Producto 17                                       ', 2, 3500, NULL, 1, '2', 175.00000, '05', 'unidad 17', 2500, 5.00000, '01', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (43, 'Producto 7                                        ', 7, 2500, NULL, 1, '1', 75.00000, '06', 'unidad 7', 1500, 3.00000, '01', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (52, 'Producto 16                                       ', 2, 3500, NULL, 1, '4', 245.00000, '05', 'unidad 16', 2500, 7.00000, '01', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (67, 'Producto 29                                       ', 1, 2500, NULL, 1, '4', 175.00000, '06', 'Unidad', 2000, 7.00000, '04', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (60, 'Producto 23                                       ', 7, 2500, NULL, 1, '13', 325.00000, '06', 'Unidad', 2000, 8.00000, '99', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (51, 'Producto 15                                       ', 1, 3500, NULL, 1, '4', 245.00000, '05', 'unidad 15', 2500, 7.00000, '01', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (49, 'Producto 13                                       ', 2, 3500, NULL, 1, '4', 245.00000, '05', 'unidad 13', 2500, 7.00000, '01', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (44, 'Producto 8                                        ', 7, 2500, NULL, 1, '2', 125.00000, '06', 'unidad 8', 1500, 5.00000, '01', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (45, 'Producto 9                                        ', 8, 3500, NULL, 1, '2', 175.00000, '05', 'unidad 9', 2500, 5.00000, '05', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (64, 'Producto 27                                       ', 1, 2000, NULL, 1, '4', 140.00000, '06', 'copa', 1500, 7.00000, '05', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (66, 'Producto 28                                       ', 1, 5000, NULL, 1, '3', 300.00000, '05', 'vaso', 4500, 6.00000, '02', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (68, 'Producto 30                                       ', 2, 10, NULL, 1, '1', 0.30000, '02', 'Unidad', 10, 3.00000, '01', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (37, 'Producto 1                                        ', 1, 2500, NULL, 1, '1', 75.00000, '03', 'unidad 1', 1500, 3.00000, '01', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (38, 'Producto 2                                        ', 2, 2500, NULL, 1, '4', 175.00000, '03', 'unidad 2', 1500, 7.00000, '01', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (39, 'Producto 3                                        ', 3, 3000, NULL, 1, '4', 210.00000, '06', 'unidad 3', 2500, 7.00000, '01', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (40, 'Producto 4                                        ', 4, 2500, NULL, 1, '4', 175.00000, '06', 'unidad 4', 1500, 7.00000, '01', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (41, 'Producto 5                                        ', 5, 5000, NULL, 1, '4', 350.00000, '05', 'unidad 5', 3000, 7.00000, '01', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (63, 'Producto 26                                       ', 2, 2500, NULL, 1, '4', 175.00000, '06', 'por vaso', 3000, 7.00000, '04', NULL, NULL, NULL, NULL);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (102, 'producto 36                                       ', 1, 20, NULL, 1, '08', 2.60000, 'cm', NULL, 15, 13.00000, '2', '01', 23, 67, 2.60000);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (101, 'producto prueba                                   ', 2, 15, NULL, 1, '08', 1.95000, 'mL', NULL, 8, 13.00000, '2', '01', 17, 67, 1.95000);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (103, 'Producto excento                                  ', 8, 65, NULL, 1, '01', 0.00000, 'mL', NULL, 55, 0.00000, '2', 'sdf5f56', 65, 67, 0.00000);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (99, 'producto 33                                       ', 2, 2000, NULL, 1, '03', 260.00000, 'kg', 'kilos', 2500, 13.00000, '1', '06', 2260, 65, 260.00000);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (98, 'Producto 32                                       ', 1, 1500, NULL, 1, '03', 60.00000, 'm', 'metros', 2000, 4.00000, '2', '06', 1560, 65, 60.00000);
INSERT INTO public.producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto, tipo_impuesto, montoimpuesto, unidadmedida, unidadmedidacomercial, costounitario, porcentajeimpuesto, tipo_producto, codigoproducto, precio_ivi, idclasificacion, impuestoneto) VALUES (100, 'Producto 34                                       ', 3, 1500, NULL, 1, '07', 15.00000, 'm', 'metro', 2500, 8.00000, '1', '01', 1515, 67, 15.00000);


--
-- TOC entry 3233 (class 0 OID 25320)
-- Dependencies: 228
-- Data for Name: proveedor; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (1, 'AMPM                                              ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (2, 'El Glaciar                                        ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (3, 'Envasa                                            ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (4, 'Esteban                                           ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (5, 'Goti                                              ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (6, 'Licorera                                          ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (7, 'Mayca                                             ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (8, 'Walmart                                           ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO public.proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (9, 'Sin Definir                                       ', NULL, NULL, NULL, NULL, NULL, 1);


--
-- TOC entry 3234 (class 0 OID 25327)
-- Dependencies: 229
-- Data for Name: proveedorinventario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (1, 32, 100.00, '2018-08-02 11:03:11.148049', 700.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (2, 36, 100.00, '2018-08-02 11:03:11.148049', 900.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (3, 6, 100.00, '2018-08-02 11:03:11.148049', 500.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (3, 7, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (4, 9, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 12, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 13, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 14, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 16, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 17, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 19, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 20, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 21, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 22, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 23, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 24, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 25, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 26, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 27, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 28, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 30, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 31, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 38, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (6, 29, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (7, 8, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (7, 10, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (7, 11, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (7, 18, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (7, 37, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (7, 50, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 1, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 2, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 3, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 4, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 5, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 33, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 34, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 35, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 39, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 40, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 41, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 42, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 43, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 44, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 45, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 46, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 47, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 48, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 49, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 51, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO public.proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (9, 15, 100.00, '2018-08-02 11:03:11.148049', 800.00);


--
-- TOC entry 3239 (class 0 OID 25354)
-- Dependencies: 234
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.provincia (id, codigo_provincia, nombre_provincia) VALUES (1, 1, 'San José');
INSERT INTO public.provincia (id, codigo_provincia, nombre_provincia) VALUES (2, 2, 'Alajuela');
INSERT INTO public.provincia (id, codigo_provincia, nombre_provincia) VALUES (3, 3, 'Cartago');
INSERT INTO public.provincia (id, codigo_provincia, nombre_provincia) VALUES (4, 4, 'Heredia');
INSERT INTO public.provincia (id, codigo_provincia, nombre_provincia) VALUES (5, 5, 'Guanacaste');
INSERT INTO public.provincia (id, codigo_provincia, nombre_provincia) VALUES (6, 6, 'Puntarenas');
INSERT INTO public.provincia (id, codigo_provincia, nombre_provincia) VALUES (7, 7, 'Limón');


--
-- TOC entry 3210 (class 0 OID 25101)
-- Dependencies: 205
-- Data for Name: puesto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.puesto (idpuesto, descripcionpuesto, departamentopuesto) VALUES (1, 'Administrador                                     ', 'Gerencia                                          ');
INSERT INTO public.puesto (idpuesto, descripcionpuesto, departamentopuesto) VALUES (2, 'Cajero                                            ', 'Ventas                                            ');


--
-- TOC entry 3212 (class 0 OID 25114)
-- Dependencies: 207
-- Data for Name: receptor; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado, identificacion_extranjero, otras_senas_extranjero) VALUES (58, 'Daniel Gonzales', '01', '000115200399', 'imagineing', 1, 15, 2, 'centro', 506, 88888888, 506, 88888888, 'info@imagineing.com', 1, NULL, NULL);
INSERT INTO public.receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado, identificacion_extranjero, otras_senas_extranjero) VALUES (59, 'Natanael Venegas Mendez', '01', '000114820869', 'imagineing', 2, 15, 0, 'Deportivas UCR', 506, 88888888, 506, 88888888, 'nrv2391@gmail.com', 1, NULL, NULL);
INSERT INTO public.receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado, identificacion_extranjero, otras_senas_extranjero) VALUES (62, 'Nombre o razon 4', '01', '000114250369', 'sfsf', 6, 8, 3, 'sdfsdaf', 506, 88888888, 506, 88888888, 'navemen23@hotmail.com', 1, NULL, NULL);
INSERT INTO public.receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado, identificacion_extranjero, otras_senas_extranjero) VALUES (0, 'receptor genérico', '02', '000000000000', 'Nombre Comercial', 1, 1, 1, '1', 506, 89883456, 506, 27103456, 'info@imagineing.com', 1, NULL, NULL);
INSERT INTO public.receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado, identificacion_extranjero, otras_senas_extranjero) VALUES (63, 'Josue Venegas Mendez', '01', '000611510236', 'escuela meta ponto', 7, 2, 1, 'San vito centro', 506, 88888888, 506, 88888888, 'josh_77@hotmail.com', 1, NULL, NULL);
INSERT INTO public.receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado, identificacion_extranjero, otras_senas_extranjero) VALUES (60, 'JeanCarlos Chavarria Hughes', '01', '000702110235', 'imagineing', 7, 2, 1, 'calle vargas', 506, 89888447, 506, 27102083, 'jchavarria@imagineing.com', 1, NULL, NULL);
INSERT INTO public.receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado, identificacion_extranjero, otras_senas_extranjero) VALUES (1, 'Nombre prueba', '01', '000123456789', 'comercial N', 1, 3, 2, 'calle 23 sur 2341', 506, 5061234568, 506, 123456785, 'email@mai.com', 1, NULL, NULL);


--
-- TOC entry 3236 (class 0 OID 25343)
-- Dependencies: 231
-- Data for Name: tipogasto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tipogasto (idtipogasto, descripciontipogasto) VALUES (1, 'Servicio                                          ');
INSERT INTO public.tipogasto (idtipogasto, descripciontipogasto) VALUES (2, 'Planilla                                          ');
INSERT INTO public.tipogasto (idtipogasto, descripciontipogasto) VALUES (3, 'Inventario Bebidas                                ');
INSERT INTO public.tipogasto (idtipogasto, descripciontipogasto) VALUES (4, 'Activos                                           ');


--
-- TOC entry 3252 (class 0 OID 25423)
-- Dependencies: 247
-- Data for Name: tipoimpuesto; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3248 (class 0 OID 25401)
-- Dependencies: 243
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3246 (class 0 OID 25385)
-- Dependencies: 241
-- Data for Name: xml; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3284 (class 0 OID 0)
-- Dependencies: 212
-- Name: categoria_idcategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categoria_idcategoria_seq', 1, false);


--
-- TOC entry 3285 (class 0 OID 0)
-- Dependencies: 222
-- Name: categoriainventario_idcategoriainventario_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categoriainventario_idcategoriainventario_seq', 1, false);


--
-- TOC entry 3286 (class 0 OID 0)
-- Dependencies: 214
-- Name: clasificacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.clasificacion_id_seq', 1, true);


--
-- TOC entry 3287 (class 0 OID 0)
-- Dependencies: 196
-- Name: cliente_idcliente_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cliente_idcliente_seq', 1, false);


--
-- TOC entry 3288 (class 0 OID 0)
-- Dependencies: 198
-- Name: cuenta_idcuenta_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cuenta_idcuenta_seq', 1, false);


--
-- TOC entry 3289 (class 0 OID 0)
-- Dependencies: 218
-- Name: descuento_iddescuento_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.descuento_iddescuento_seq', 1, false);


--
-- TOC entry 3290 (class 0 OID 0)
-- Dependencies: 237
-- Name: detalles_orden_iddetalle_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.detalles_orden_iddetalle_seq', 94, true);


--
-- TOC entry 3291 (class 0 OID 0)
-- Dependencies: 208
-- Name: emisor_idemisor_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.emisor_idemisor_seq', 1, true);


--
-- TOC entry 3292 (class 0 OID 0)
-- Dependencies: 200
-- Name: empleado_idempleado_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.empleado_idempleado_seq', 1, false);


--
-- TOC entry 3293 (class 0 OID 0)
-- Dependencies: 210
-- Name: factura_idfactura_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.factura_idfactura_seq', 89, true);


--
-- TOC entry 3294 (class 0 OID 0)
-- Dependencies: 232
-- Name: gasto_idgasto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.gasto_idgasto_seq', 1, false);


--
-- TOC entry 3295 (class 0 OID 0)
-- Dependencies: 244
-- Name: impuesto_idimpuesto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.impuesto_idimpuesto_seq', 1, false);


--
-- TOC entry 3296 (class 0 OID 0)
-- Dependencies: 224
-- Name: inventario_idinventario_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventario_idinventario_seq', 51, true);


--
-- TOC entry 3297 (class 0 OID 0)
-- Dependencies: 220
-- Name: orden_idorden_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orden_idorden_seq', 189, true);


--
-- TOC entry 3298 (class 0 OID 0)
-- Dependencies: 202
-- Name: periodoventa_idperiodoventa_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.periodoventa_idperiodoventa_seq', 1, false);


--
-- TOC entry 3299 (class 0 OID 0)
-- Dependencies: 216
-- Name: producto_idproducto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.producto_idproducto_seq', 103, true);


--
-- TOC entry 3300 (class 0 OID 0)
-- Dependencies: 227
-- Name: proveedor_idproveedor_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.proveedor_idproveedor_seq', 1, false);


--
-- TOC entry 3301 (class 0 OID 0)
-- Dependencies: 204
-- Name: puesto_idpuesto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.puesto_idpuesto_seq', 1, false);


--
-- TOC entry 3302 (class 0 OID 0)
-- Dependencies: 206
-- Name: receptor_idreceptor_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.receptor_idreceptor_seq', 1, true);


--
-- TOC entry 3303 (class 0 OID 0)
-- Dependencies: 230
-- Name: tipogasto_idtipogasto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tipogasto_idtipogasto_seq', 1, false);


--
-- TOC entry 3304 (class 0 OID 0)
-- Dependencies: 246
-- Name: tipoimpuesto_idtipoimpuesto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tipoimpuesto_idtipoimpuesto_seq', 1, false);


--
-- TOC entry 3305 (class 0 OID 0)
-- Dependencies: 242
-- Name: users_iduser_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_iduser_seq', 1, false);


--
-- TOC entry 3306 (class 0 OID 0)
-- Dependencies: 240
-- Name: xml_idxml_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.xml_idxml_seq', 1, false);


--
-- TOC entry 3045 (class 2606 OID 25363)
-- Name: canton canton_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canton
    ADD CONSTRAINT canton_pkey PRIMARY KEY (id);


--
-- TOC entry 3027 (class 2606 OID 25194)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (idcategoria);


--
-- TOC entry 3037 (class 2606 OID 25290)
-- Name: categoriainventario categoriainventario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoriainventario
    ADD CONSTRAINT categoriainventario_pkey PRIMARY KEY (idcategoriainventario);


--
-- TOC entry 3029 (class 2606 OID 25202)
-- Name: clasificacion clasificacion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clasificacion
    ADD CONSTRAINT clasificacion_pkey PRIMARY KEY (id);


--
-- TOC entry 3011 (class 2606 OID 25060)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (idcliente);


--
-- TOC entry 3013 (class 2606 OID 25069)
-- Name: cuenta cuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cuenta
    ADD CONSTRAINT cuenta_pkey PRIMARY KEY (idcuenta);


--
-- TOC entry 3033 (class 2606 OID 25231)
-- Name: descuento descuento_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.descuento
    ADD CONSTRAINT descuento_pkey PRIMARY KEY (iddescuento);


--
-- TOC entry 3049 (class 2606 OID 25379)
-- Name: detalles_orden detalles_orden_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalles_orden
    ADD CONSTRAINT detalles_orden_pkey PRIMARY KEY (iddetalle);


--
-- TOC entry 3047 (class 2606 OID 25368)
-- Name: distrito distrito_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.distrito
    ADD CONSTRAINT distrito_pkey PRIMARY KEY (id);


--
-- TOC entry 3023 (class 2606 OID 25134)
-- Name: emisor emisor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.emisor
    ADD CONSTRAINT emisor_pkey PRIMARY KEY (idemisor);


--
-- TOC entry 3015 (class 2606 OID 25083)
-- Name: empleado empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (idempleado);


--
-- TOC entry 3025 (class 2606 OID 25161)
-- Name: factura factura_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_pkey PRIMARY KEY (idfactura);


--
-- TOC entry 3055 (class 2606 OID 25420)
-- Name: impuesto impuesto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.impuesto
    ADD CONSTRAINT impuesto_pkey PRIMARY KEY (idimpuesto);


--
-- TOC entry 3039 (class 2606 OID 25299)
-- Name: inventario inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (idinventario);


--
-- TOC entry 3035 (class 2606 OID 25267)
-- Name: orden orden_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden
    ADD CONSTRAINT orden_pkey PRIMARY KEY (idorden);


--
-- TOC entry 3017 (class 2606 OID 25093)
-- Name: periodoventa periodoventa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periodoventa
    ADD CONSTRAINT periodoventa_pkey PRIMARY KEY (idperiodoventa);


--
-- TOC entry 3031 (class 2606 OID 25211)
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (idproducto);


--
-- TOC entry 3041 (class 2606 OID 25326)
-- Name: proveedor proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proveedor
    ADD CONSTRAINT proveedor_pkey PRIMARY KEY (idproveedor);


--
-- TOC entry 3043 (class 2606 OID 25358)
-- Name: provincia provincia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provincia
    ADD CONSTRAINT provincia_pkey PRIMARY KEY (id);


--
-- TOC entry 3019 (class 2606 OID 25106)
-- Name: puesto puesto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.puesto
    ADD CONSTRAINT puesto_pkey PRIMARY KEY (idpuesto);


--
-- TOC entry 3021 (class 2606 OID 25123)
-- Name: receptor receptor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.receptor
    ADD CONSTRAINT receptor_pkey PRIMARY KEY (idreceptor);


--
-- TOC entry 3057 (class 2606 OID 25429)
-- Name: tipoimpuesto tipoimpuesto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipoimpuesto
    ADD CONSTRAINT tipoimpuesto_pkey PRIMARY KEY (idtipoimpuesto);


--
-- TOC entry 3053 (class 2606 OID 25406)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (iduser);


--
-- TOC entry 3051 (class 2606 OID 25393)
-- Name: xml xml_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.xml
    ADD CONSTRAINT xml_pkey PRIMARY KEY (idxml);


--
-- TOC entry 3078 (class 2620 OID 25467)
-- Name: detalles_orden details; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER details AFTER INSERT ON public.detalles_orden FOR EACH ROW EXECUTE PROCEDURE public.new_order_detail();


--
-- TOC entry 3079 (class 2620 OID 25468)
-- Name: detalles_orden detalles_factura; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER detalles_factura AFTER INSERT ON public.detalles_orden FOR EACH ROW EXECUTE PROCEDURE public.iddetalle_factura();


--
-- TOC entry 3077 (class 2620 OID 25463)
-- Name: factura update_period_bill; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_period_bill BEFORE INSERT ON public.factura FOR EACH ROW EXECUTE PROCEDURE public.update_period_bill();


--
-- TOC entry 3058 (class 2606 OID 25070)
-- Name: cuenta cuenta_idcliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cuenta
    ADD CONSTRAINT cuenta_idcliente_fkey FOREIGN KEY (idcliente) REFERENCES public.cliente(idcliente);


--
-- TOC entry 3059 (class 2606 OID 25107)
-- Name: empleado empleado_idpuesto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_idpuesto_fkey FOREIGN KEY (idpuesto) REFERENCES public.puesto(idpuesto);


--
-- TOC entry 3061 (class 2606 OID 25162)
-- Name: factura factura_idcuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_idcuenta_fkey FOREIGN KEY (idcuenta) REFERENCES public.cuenta(idcuenta);


--
-- TOC entry 3064 (class 2606 OID 25182)
-- Name: factura factura_idemisor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_idemisor_fkey FOREIGN KEY (idemisor) REFERENCES public.emisor(idemisor);


--
-- TOC entry 3062 (class 2606 OID 25167)
-- Name: factura factura_idempleado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_idempleado_fkey FOREIGN KEY (idempleado) REFERENCES public.empleado(idempleado);


--
-- TOC entry 3063 (class 2606 OID 25172)
-- Name: factura factura_idperiodoventa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_idperiodoventa_fkey FOREIGN KEY (idperiodoventa) REFERENCES public.periodoventa(idperiodoventa);


--
-- TOC entry 3070 (class 2606 OID 25300)
-- Name: inventario inventario_idcategoriainventario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventario
    ADD CONSTRAINT inventario_idcategoriainventario_fkey FOREIGN KEY (idcategoriainventario) REFERENCES public.categoriainventario(idcategoriainventario);


--
-- TOC entry 3071 (class 2606 OID 25308)
-- Name: inventarioproducto inventarioproducto_idinventario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventarioproducto
    ADD CONSTRAINT inventarioproducto_idinventario_fkey FOREIGN KEY (idinventario) REFERENCES public.inventario(idinventario);


--
-- TOC entry 3072 (class 2606 OID 25313)
-- Name: inventarioproducto inventarioproducto_idproducto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventarioproducto
    ADD CONSTRAINT inventarioproducto_idproducto_fkey FOREIGN KEY (idproducto) REFERENCES public.producto(idproducto);


--
-- TOC entry 3067 (class 2606 OID 25268)
-- Name: orden orden_idcuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden
    ADD CONSTRAINT orden_idcuenta_fkey FOREIGN KEY (idcuenta) REFERENCES public.cuenta(idcuenta);


--
-- TOC entry 3069 (class 2606 OID 25278)
-- Name: orden orden_idfactura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden
    ADD CONSTRAINT orden_idfactura_fkey FOREIGN KEY (idfactura) REFERENCES public.factura(idfactura);


--
-- TOC entry 3068 (class 2606 OID 25273)
-- Name: orden orden_idproducto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden
    ADD CONSTRAINT orden_idproducto_fkey FOREIGN KEY (idproducto) REFERENCES public.producto(idproducto);


--
-- TOC entry 3060 (class 2606 OID 25094)
-- Name: periodoventa periodoventa_idempleado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periodoventa
    ADD CONSTRAINT periodoventa_idempleado_fkey FOREIGN KEY (idempleado) REFERENCES public.empleado(idempleado);


--
-- TOC entry 3065 (class 2606 OID 25212)
-- Name: producto producto_idcategoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_idcategoria_fkey FOREIGN KEY (idcategoria) REFERENCES public.categoria(idcategoria);


--
-- TOC entry 3066 (class 2606 OID 25217)
-- Name: producto producto_idclasificacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_idclasificacion_fkey FOREIGN KEY (idclasificacion) REFERENCES public.clasificacion(id);


--
-- TOC entry 3074 (class 2606 OID 25336)
-- Name: proveedorinventario proveedorinventario_idinventario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proveedorinventario
    ADD CONSTRAINT proveedorinventario_idinventario_fkey FOREIGN KEY (idinventario) REFERENCES public.inventario(idinventario);


--
-- TOC entry 3073 (class 2606 OID 25331)
-- Name: proveedorinventario proveedorinventario_idproveedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proveedorinventario
    ADD CONSTRAINT proveedorinventario_idproveedor_fkey FOREIGN KEY (idproveedor) REFERENCES public.proveedor(idproveedor);


--
-- TOC entry 3076 (class 2606 OID 25430)
-- Name: tipoimpuesto tipoimpuesto_idimpuesto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipoimpuesto
    ADD CONSTRAINT tipoimpuesto_idimpuesto_fkey FOREIGN KEY (idimpuesto) REFERENCES public.impuesto(idimpuesto);


--
-- TOC entry 3075 (class 2606 OID 25394)
-- Name: xml xml_idfactura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.xml
    ADD CONSTRAINT xml_idfactura_fkey FOREIGN KEY (idfactura) REFERENCES public.factura(idfactura);


-- Completed on 2019-08-29 22:13:11 -05

--
-- PostgreSQL database dump complete
--

