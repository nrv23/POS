--
-- PostgreSQL database dump
-- Nueva version de base de datos

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

-- Started on 2018-08-29 22:43:51

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

ALTER TABLE IF EXISTS ONLY public.proveedorinventario DROP CONSTRAINT IF EXISTS proveedorinventario_idproveedor_fkey;
ALTER TABLE IF EXISTS ONLY public.proveedorinventario DROP CONSTRAINT IF EXISTS proveedorinventario_idinventario_fkey;
ALTER TABLE IF EXISTS ONLY public.producto DROP CONSTRAINT IF EXISTS producto_idcategoria_fkey;
ALTER TABLE IF EXISTS ONLY public.periodoventa DROP CONSTRAINT IF EXISTS periodoventa_idempleado_fkey;
ALTER TABLE IF EXISTS ONLY public.orden DROP CONSTRAINT IF EXISTS orden_idproducto_fkey;
ALTER TABLE IF EXISTS ONLY public.orden DROP CONSTRAINT IF EXISTS orden_idfactura_fkey;
ALTER TABLE IF EXISTS ONLY public.orden DROP CONSTRAINT IF EXISTS orden_idcuenta_fkey;
ALTER TABLE IF EXISTS ONLY public.inventarioproducto DROP CONSTRAINT IF EXISTS inventarioproducto_idproducto_fkey;
ALTER TABLE IF EXISTS ONLY public.inventarioproducto DROP CONSTRAINT IF EXISTS inventarioproducto_idinventario_fkey;
ALTER TABLE IF EXISTS ONLY public.inventario DROP CONSTRAINT IF EXISTS inventario_idcategoriainventario_fkey;
ALTER TABLE IF EXISTS ONLY public.distrito DROP CONSTRAINT IF EXISTS fkdistrito;
ALTER TABLE IF EXISTS ONLY public.cliente_is_receptor DROP CONSTRAINT IF EXISTS fkcliente_is_receptor_receptor;
ALTER TABLE IF EXISTS ONLY public.cliente_is_receptor DROP CONSTRAINT IF EXISTS fkcliente_is_receptor_cliente;
ALTER TABLE IF EXISTS ONLY public.canton DROP CONSTRAINT IF EXISTS fkcanton;
ALTER TABLE IF EXISTS ONLY public.factura DROP CONSTRAINT IF EXISTS factura_idperiodoventa_fkey;
ALTER TABLE IF EXISTS ONLY public.factura DROP CONSTRAINT IF EXISTS factura_idempleado_fkey;
ALTER TABLE IF EXISTS ONLY public.factura DROP CONSTRAINT IF EXISTS factura_idcuenta_fkey;
ALTER TABLE IF EXISTS ONLY public.empleado DROP CONSTRAINT IF EXISTS empleado_idpuesto_fkey;
ALTER TABLE IF EXISTS ONLY public.cuenta DROP CONSTRAINT IF EXISTS cuenta_idcliente_fkey;
DROP TRIGGER IF EXISTS update_period_bill ON public.factura;
ALTER TABLE IF EXISTS ONLY public.receptor DROP CONSTRAINT IF EXISTS receptor_pkey;
ALTER TABLE IF EXISTS ONLY public.puesto DROP CONSTRAINT IF EXISTS puesto_pkey;
ALTER TABLE IF EXISTS ONLY public.proveedor DROP CONSTRAINT IF EXISTS proveedor_pkey;
ALTER TABLE IF EXISTS ONLY public.producto DROP CONSTRAINT IF EXISTS producto_pkey;
ALTER TABLE IF EXISTS ONLY public.provincia DROP CONSTRAINT IF EXISTS pkprovincia;
ALTER TABLE IF EXISTS ONLY public.periodoventa DROP CONSTRAINT IF EXISTS periodoventa_pkey;
ALTER TABLE IF EXISTS ONLY public.orden DROP CONSTRAINT IF EXISTS orden_pkey;
ALTER TABLE IF EXISTS ONLY public.inventario DROP CONSTRAINT IF EXISTS inventario_pkey;
ALTER TABLE IF EXISTS ONLY public.factura DROP CONSTRAINT IF EXISTS factura_pkey;
ALTER TABLE IF EXISTS ONLY public.empleado DROP CONSTRAINT IF EXISTS empleado_pkey;
ALTER TABLE IF EXISTS ONLY public.emisor DROP CONSTRAINT IF EXISTS emisor_pkey;
ALTER TABLE IF EXISTS ONLY public.distrito DROP CONSTRAINT IF EXISTS distrito_pkey;
ALTER TABLE IF EXISTS ONLY public.cuenta DROP CONSTRAINT IF EXISTS cuenta_pkey;
ALTER TABLE IF EXISTS ONLY public.cliente DROP CONSTRAINT IF EXISTS cliente_pkey;
ALTER TABLE IF EXISTS ONLY public.categoriainventario DROP CONSTRAINT IF EXISTS categoriainventario_pkey;
ALTER TABLE IF EXISTS ONLY public.categoria DROP CONSTRAINT IF EXISTS categoria_pkey;
ALTER TABLE IF EXISTS ONLY public.canton DROP CONSTRAINT IF EXISTS canton_pkey;
ALTER TABLE IF EXISTS public.tipogasto ALTER COLUMN idtipogasto DROP DEFAULT;
ALTER TABLE IF EXISTS public.receptor ALTER COLUMN idreceptor DROP DEFAULT;
ALTER TABLE IF EXISTS public.puesto ALTER COLUMN idpuesto DROP DEFAULT;
ALTER TABLE IF EXISTS public.proveedor ALTER COLUMN idproveedor DROP DEFAULT;
ALTER TABLE IF EXISTS public.producto ALTER COLUMN idproducto DROP DEFAULT;
ALTER TABLE IF EXISTS public.periodoventa ALTER COLUMN idperiodoventa DROP DEFAULT;
ALTER TABLE IF EXISTS public.orden ALTER COLUMN idorden DROP DEFAULT;
ALTER TABLE IF EXISTS public.inventario ALTER COLUMN idinventario DROP DEFAULT;
ALTER TABLE IF EXISTS public.gasto ALTER COLUMN idgasto DROP DEFAULT;
ALTER TABLE IF EXISTS public.factura ALTER COLUMN idfactura DROP DEFAULT;
ALTER TABLE IF EXISTS public.empleado ALTER COLUMN idempleado DROP DEFAULT;
ALTER TABLE IF EXISTS public.emisor ALTER COLUMN idemisor DROP DEFAULT;
ALTER TABLE IF EXISTS public.cuenta ALTER COLUMN idcuenta DROP DEFAULT;
ALTER TABLE IF EXISTS public.cliente ALTER COLUMN idcliente DROP DEFAULT;
ALTER TABLE IF EXISTS public.categoriainventario ALTER COLUMN idcategoriainventario DROP DEFAULT;
ALTER TABLE IF EXISTS public.categoria ALTER COLUMN idcategoria DROP DEFAULT;
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
DROP SEQUENCE IF EXISTS public.gasto_idgasto_seq;
DROP TABLE IF EXISTS public.gasto;
DROP SEQUENCE IF EXISTS public.factura_idfactura_seq;
DROP TABLE IF EXISTS public.factura;
DROP SEQUENCE IF EXISTS public.empleado_idempleado_seq;
DROP TABLE IF EXISTS public.empleado;
DROP SEQUENCE IF EXISTS public.emisor_idemisor_seq;
DROP TABLE IF EXISTS public.emisor;
DROP TABLE IF EXISTS public.distrito;
DROP SEQUENCE IF EXISTS public.cuenta_idcuenta_seq;
DROP TABLE IF EXISTS public.cuenta;
DROP TABLE IF EXISTS public.cliente_is_receptor;
DROP SEQUENCE IF EXISTS public.cliente_idcliente_seq;
DROP TABLE IF EXISTS public.cliente;
DROP SEQUENCE IF EXISTS public.categoriainventario_idcategoriainventario_seq;
DROP TABLE IF EXISTS public.categoriainventario;
DROP SEQUENCE IF EXISTS public.categoria_idcategoria_seq;
DROP TABLE IF EXISTS public.categoria;
DROP TABLE IF EXISTS public.canton;
DROP FUNCTION IF EXISTS public.update_period_status(nombreperiodo character, idempleadoactualizo integer);
DROP FUNCTION IF EXISTS public.update_period_bill();
DROP FUNCTION IF EXISTS public.update_order_cost(ordenactualizar integer);
DROP FUNCTION IF EXISTS public.update_inventory(ordencancelada integer, cantidad integer);
DROP FUNCTION IF EXISTS public.update_insert_inventarioproducto(producto integer, inventario integer, cantidad integer);
DROP FUNCTION IF EXISTS public.reload_inventory(ordencancelada integer, cantidad integer);
DROP EXTENSION IF EXISTS plpgsql;
DROP SCHEMA IF EXISTS public;
--
-- TOC entry 7 (class 2615 OID 20192)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 2383 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 1 (class 3079 OID 20193)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2384 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 219 (class 1255 OID 20198)
-- Name: reload_inventory(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION reload_inventory(ordencancelada integer, cantidad integer) RETURNS text
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



END;                                                            



$$;


--
-- TOC entry 220 (class 1255 OID 20199)
-- Name: update_insert_inventarioproducto(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION update_insert_inventarioproducto(producto integer, inventario integer, cantidad integer) RETURNS text
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



END;                                                            



$$;


--
-- TOC entry 233 (class 1255 OID 20200)
-- Name: update_inventory(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION update_inventory(ordencancelada integer, cantidad integer) RETURNS text
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



END;                                                            



$$;


--
-- TOC entry 234 (class 1255 OID 20201)
-- Name: update_order_cost(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION update_order_cost(ordenactualizar integer) RETURNS text
    LANGUAGE plpgsql
    AS $$



DECLARE



	resultado_txt TEXT DEFAULT 'Resultado OK';



    total decimal(10,2);



BEGIN



    total = (select sum(ip.cantidadnecesaria * i.costoinventario) as total from inventarioproducto ip inner join inventario i on ip.idinventario = i.idinventario WHERE ip.idproducto = (SELECT idproducto FROM orden WHERE idorden = ordenActualizar));



    UPDATE ORDEN SET costounitarioproducto = total WHERE idorden = ordenActualizar; 



    RETURN resultado_txt;



END;                                                          



$$;


--
-- TOC entry 235 (class 1255 OID 20202)
-- Name: update_period_bill(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION update_period_bill() RETURNS trigger
    LANGUAGE plpgsql
    AS $$



DECLARE 



    id_periodo_venta_activo integer;



BEGIN



	id_periodo_venta_activo = (SELECT idperiodoventa FROM periodoventa WHERE estadoperiodoventa = 'Activo');



    NEW.idperiodoventa = id_periodo_venta_activo;



  	RETURN NEW;



END;



$$;


--
-- TOC entry 236 (class 1255 OID 20203)
-- Name: update_period_status(character, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION update_period_status(nombreperiodo character, idempleadoactualizo integer) RETURNS text
    LANGUAGE plpgsql
    AS $$



DECLARE



	resultado_txt TEXT DEFAULT 'Resultado OK';



BEGIN



	UPDATE PERIODOVENTA SET estadoperiodoventa = 'Finalizado', fechafinperiodoventa = (SELECT NOW()), idEmpleado = idEmpleadoActualizo WHERE estadoperiodoventa = 'Activo';



    INSERT INTO public.PERIODOVENTA (nombreperiodoventa) VALUES (nombreperiodo);



    



    RETURN resultado_txt;



END;



$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 181 (class 1259 OID 20204)
-- Name: canton; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE canton (
    codigo_canton integer NOT NULL,
    codigo_provincia integer NOT NULL,
    nombre_canton character varying(45) NOT NULL
);


--
-- TOC entry 182 (class 1259 OID 20207)
-- Name: categoria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categoria (
    idcategoria integer NOT NULL,
    descripcioncategoria character(30)
);


--
-- TOC entry 183 (class 1259 OID 20210)
-- Name: categoria_idcategoria_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categoria_idcategoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2385 (class 0 OID 0)
-- Dependencies: 183
-- Name: categoria_idcategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categoria_idcategoria_seq OWNED BY categoria.idcategoria;


--
-- TOC entry 184 (class 1259 OID 20212)
-- Name: categoriainventario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categoriainventario (
    idcategoriainventario integer NOT NULL,
    descripcioncategoriainventario character(30)
);


--
-- TOC entry 185 (class 1259 OID 20215)
-- Name: categoriainventario_idcategoriainventario_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categoriainventario_idcategoriainventario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2386 (class 0 OID 0)
-- Dependencies: 185
-- Name: categoriainventario_idcategoriainventario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categoriainventario_idcategoriainventario_seq OWNED BY categoriainventario.idcategoriainventario;


--
-- TOC entry 186 (class 1259 OID 20217)
-- Name: cliente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cliente (
    idcliente integer NOT NULL,
    identificacioncliente character(100),
    estadocliente smallint DEFAULT 1
);


--
-- TOC entry 187 (class 1259 OID 20221)
-- Name: cliente_idcliente_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cliente_idcliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2387 (class 0 OID 0)
-- Dependencies: 187
-- Name: cliente_idcliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cliente_idcliente_seq OWNED BY cliente.idcliente;


--
-- TOC entry 188 (class 1259 OID 20223)
-- Name: cliente_is_receptor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cliente_is_receptor (
    idcliente integer,
    idreceptor character varying(12)
);


--
-- TOC entry 189 (class 1259 OID 20226)
-- Name: cuenta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cuenta (
    idcuenta integer NOT NULL,
    idcliente integer,
    fechaaperturacuenta timestamp without time zone DEFAULT now(),
    estadocuenta character(30)
);


--
-- TOC entry 190 (class 1259 OID 20230)
-- Name: cuenta_idcuenta_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cuenta_idcuenta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2388 (class 0 OID 0)
-- Dependencies: 190
-- Name: cuenta_idcuenta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cuenta_idcuenta_seq OWNED BY cuenta.idcuenta;


--
-- TOC entry 191 (class 1259 OID 20232)
-- Name: distrito; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE distrito (
    codigo_distrito integer NOT NULL,
    codigo_canton integer NOT NULL,
    nombre_distrito character varying(45) NOT NULL
);


--
-- TOC entry 192 (class 1259 OID 20235)
-- Name: emisor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE emisor (
    idemisor smallint NOT NULL,
    nombre character varying(80) NOT NULL,
    emisor_tipo_identificacion character varying(2) NOT NULL,
    emisor_numero character varying(12) NOT NULL,
    nombrecomercial character varying(80),
    provincia integer NOT NULL,
    canton integer NOT NULL,
    distrito integer NOT NULL,
    otras_senas text,
    emisor_telefono_codigopais numeric(3,0),
    emisor_telefono_numtelefono numeric(20,0),
    emisor_fax_codigopais numeric(3,0),
    emisor_fax_numtelefono numeric(20,0),
    correoelectronico character varying(60)
);


--
-- TOC entry 193 (class 1259 OID 20241)
-- Name: emisor_idemisor_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE emisor_idemisor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2389 (class 0 OID 0)
-- Dependencies: 193
-- Name: emisor_idemisor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE emisor_idemisor_seq OWNED BY emisor.idemisor;


--
-- TOC entry 194 (class 1259 OID 20243)
-- Name: empleado; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE empleado (
    idempleado integer NOT NULL,
    nombreempleado character(50),
    apellidoempleado character(50),
    passwordempleado character(50),
    idpuesto integer NOT NULL,
    estadoempleado smallint DEFAULT 1
);


--
-- TOC entry 195 (class 1259 OID 20247)
-- Name: empleado_idempleado_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE empleado_idempleado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 195
-- Name: empleado_idempleado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE empleado_idempleado_seq OWNED BY empleado.idempleado;


--
-- TOC entry 196 (class 1259 OID 20249)
-- Name: factura; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE factura (
    idfactura integer NOT NULL,
    idcuenta integer,
    idempleado integer,
    idperiodoventa integer,
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
    totalcomprobante numeric(18,5) DEFAULT 1 NOT NULL
);


--
-- TOC entry 197 (class 1259 OID 20254)
-- Name: factura_idfactura_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE factura_idfactura_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 197
-- Name: factura_idfactura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE factura_idfactura_seq OWNED BY factura.idfactura;


--
-- TOC entry 198 (class 1259 OID 20256)
-- Name: gasto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE gasto (
    idgasto integer NOT NULL,
    idtipogasto integer,
    descripciongasto character(50),
    estadogasto character(20),
    montogasto numeric(10,2),
    fechagasto timestamp without time zone DEFAULT now(),
    observaciongasto character(100)
);


--
-- TOC entry 199 (class 1259 OID 20260)
-- Name: gasto_idgasto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gasto_idgasto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 199
-- Name: gasto_idgasto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE gasto_idgasto_seq OWNED BY gasto.idgasto;


--
-- TOC entry 200 (class 1259 OID 20262)
-- Name: inventario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE inventario (
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
-- TOC entry 201 (class 1259 OID 20266)
-- Name: inventario_idinventario_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE inventario_idinventario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 201
-- Name: inventario_idinventario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE inventario_idinventario_seq OWNED BY inventario.idinventario;


--
-- TOC entry 202 (class 1259 OID 20268)
-- Name: inventarioproducto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE inventarioproducto (
    idinventario integer,
    idproducto integer,
    cantidadnecesaria numeric(8,2)
);


--
-- TOC entry 203 (class 1259 OID 20271)
-- Name: orden; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE orden (
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
    codigoservicio character varying(30) DEFAULT 1 NOT NULL,
    tiposervicio character varying(2) DEFAULT '2'::character varying NOT NULL,
    cantidad numeric(16,3) DEFAULT 1 NOT NULL,
    unidadmedida character varying(20) DEFAULT '1'::character varying NOT NULL,
    unidadmedidacomercial character varying(20) DEFAULT '1'::character varying NOT NULL,
    detalle text DEFAULT '1'::text NOT NULL,
    preciounitario numeric(18,5) DEFAULT 1 NOT NULL,
    montototal numeric(18,5) DEFAULT 1 NOT NULL,
    montodescuento numeric(18,5) DEFAULT 1 NOT NULL,
    naturalezadescuento character varying(80) DEFAULT '1'::character varying NOT NULL,
    subtotal numeric(18,5) DEFAULT 1 NOT NULL,
    codigoimpuesto character varying(2) DEFAULT '1'::character varying NOT NULL,
    tarifa numeric(4,2) DEFAULT 1 NOT NULL,
    monto numeric(18,5) DEFAULT 1 NOT NULL,
    exoneracion_tipodocumento character varying(2) DEFAULT '1'::character varying NOT NULL,
    numerodocumento character varying(17) DEFAULT '1'::character varying NOT NULL,
    nombreinstitucion character varying(100) DEFAULT '1'::character varying NOT NULL,
    fechaemision timestamp without time zone DEFAULT '2001-01-01 11:01:02'::timestamp without time zone NOT NULL,
    montoimpuesto numeric(18,5) DEFAULT 1 NOT NULL,
    procentajecompra integer DEFAULT 1 NOT NULL,
    montoitotallinea numeric(18,5) DEFAULT 1 NOT NULL
);


--
-- TOC entry 204 (class 1259 OID 20278)
-- Name: orden_idorden_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE orden_idorden_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2394 (class 0 OID 0)
-- Dependencies: 204
-- Name: orden_idorden_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE orden_idorden_seq OWNED BY orden.idorden;


--
-- TOC entry 205 (class 1259 OID 20280)
-- Name: periodoventa; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE periodoventa (
    idperiodoventa integer NOT NULL,
    nombreperiodoventa character(50),
    estadoperiodoventa character(10) DEFAULT 'Activo'::bpchar,
    fechainicioperiodoventa timestamp without time zone DEFAULT now(),
    fechafinperiodoventa timestamp without time zone,
    idempleado integer
);


--
-- TOC entry 206 (class 1259 OID 20285)
-- Name: periodoventa_idperiodoventa_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE periodoventa_idperiodoventa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2395 (class 0 OID 0)
-- Dependencies: 206
-- Name: periodoventa_idperiodoventa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE periodoventa_idperiodoventa_seq OWNED BY periodoventa.idperiodoventa;


--
-- TOC entry 207 (class 1259 OID 20287)
-- Name: producto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE producto (
    idproducto integer NOT NULL,
    descripcionproducto character(50),
    idcategoria integer,
    precioproducto integer,
    codigobarraproducto character(50),
    estadoproducto smallint DEFAULT 1
);


--
-- TOC entry 208 (class 1259 OID 20291)
-- Name: producto_idproducto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE producto_idproducto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2396 (class 0 OID 0)
-- Dependencies: 208
-- Name: producto_idproducto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE producto_idproducto_seq OWNED BY producto.idproducto;


--
-- TOC entry 209 (class 1259 OID 20293)
-- Name: proveedor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE proveedor (
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
-- TOC entry 210 (class 1259 OID 20297)
-- Name: proveedor_idproveedor_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE proveedor_idproveedor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2397 (class 0 OID 0)
-- Dependencies: 210
-- Name: proveedor_idproveedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE proveedor_idproveedor_seq OWNED BY proveedor.idproveedor;


--
-- TOC entry 211 (class 1259 OID 20299)
-- Name: proveedorinventario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE proveedorinventario (
    idproveedor integer,
    idinventario integer,
    cantidadproducto numeric(10,2),
    fecharegistro timestamp without time zone DEFAULT now(),
    costounitario numeric(10,2)
);


--
-- TOC entry 212 (class 1259 OID 20303)
-- Name: provincia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE provincia (
    codigo_provincia integer NOT NULL,
    nombre_provincia character varying(20) NOT NULL
);


--
-- TOC entry 213 (class 1259 OID 20306)
-- Name: puesto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE puesto (
    idpuesto integer NOT NULL,
    descripcionpuesto character(50),
    departamentopuesto character(50)
);


--
-- TOC entry 214 (class 1259 OID 20309)
-- Name: puesto_idpuesto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE puesto_idpuesto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2398 (class 0 OID 0)
-- Dependencies: 214
-- Name: puesto_idpuesto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE puesto_idpuesto_seq OWNED BY puesto.idpuesto;


--
-- TOC entry 215 (class 1259 OID 20311)
-- Name: receptor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE receptor (
    idreceptor integer NOT NULL,
    nombre character varying(80) NOT NULL,
    receptor_tipo_identificacion character varying(2) NOT NULL,
    receptor_numero character varying(12) NOT NULL,
    identificacionextranjero character varying(20),
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
    estado smallint DEFAULT 1
);


--
-- TOC entry 216 (class 1259 OID 20317)
-- Name: receptor_idreceptor_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE receptor_idreceptor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2399 (class 0 OID 0)
-- Dependencies: 216
-- Name: receptor_idreceptor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE receptor_idreceptor_seq OWNED BY receptor.idreceptor;


--
-- TOC entry 217 (class 1259 OID 20319)
-- Name: tipogasto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tipogasto (
    idtipogasto integer NOT NULL,
    descripciontipogasto character(50)
);


--
-- TOC entry 218 (class 1259 OID 20322)
-- Name: tipogasto_idtipogasto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tipogasto_idtipogasto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2400 (class 0 OID 0)
-- Dependencies: 218
-- Name: tipogasto_idtipogasto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tipogasto_idtipogasto_seq OWNED BY tipogasto.idtipogasto;


--
-- TOC entry 2104 (class 2604 OID 20324)
-- Name: idcategoria; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categoria ALTER COLUMN idcategoria SET DEFAULT nextval('categoria_idcategoria_seq'::regclass);


--
-- TOC entry 2105 (class 2604 OID 20325)
-- Name: idcategoriainventario; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categoriainventario ALTER COLUMN idcategoriainventario SET DEFAULT nextval('categoriainventario_idcategoriainventario_seq'::regclass);


--
-- TOC entry 2107 (class 2604 OID 20326)
-- Name: idcliente; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cliente ALTER COLUMN idcliente SET DEFAULT nextval('cliente_idcliente_seq'::regclass);


--
-- TOC entry 2109 (class 2604 OID 20327)
-- Name: idcuenta; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cuenta ALTER COLUMN idcuenta SET DEFAULT nextval('cuenta_idcuenta_seq'::regclass);


--
-- TOC entry 2110 (class 2604 OID 20328)
-- Name: idemisor; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY emisor ALTER COLUMN idemisor SET DEFAULT nextval('emisor_idemisor_seq'::regclass);


--
-- TOC entry 2112 (class 2604 OID 20329)
-- Name: idempleado; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY empleado ALTER COLUMN idempleado SET DEFAULT nextval('empleado_idempleado_seq'::regclass);


--
-- TOC entry 2115 (class 2604 OID 20330)
-- Name: idfactura; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY factura ALTER COLUMN idfactura SET DEFAULT nextval('factura_idfactura_seq'::regclass);


--
-- TOC entry 2130 (class 2604 OID 20331)
-- Name: idgasto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY gasto ALTER COLUMN idgasto SET DEFAULT nextval('gasto_idgasto_seq'::regclass);


--
-- TOC entry 2132 (class 2604 OID 20332)
-- Name: idinventario; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY inventario ALTER COLUMN idinventario SET DEFAULT nextval('inventario_idinventario_seq'::regclass);


--
-- TOC entry 2137 (class 2604 OID 20333)
-- Name: idorden; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY orden ALTER COLUMN idorden SET DEFAULT nextval('orden_idorden_seq'::regclass);


--
-- TOC entry 2162 (class 2604 OID 20334)
-- Name: idperiodoventa; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY periodoventa ALTER COLUMN idperiodoventa SET DEFAULT nextval('periodoventa_idperiodoventa_seq'::regclass);


--
-- TOC entry 2164 (class 2604 OID 20335)
-- Name: idproducto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY producto ALTER COLUMN idproducto SET DEFAULT nextval('producto_idproducto_seq'::regclass);


--
-- TOC entry 2166 (class 2604 OID 20336)
-- Name: idproveedor; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY proveedor ALTER COLUMN idproveedor SET DEFAULT nextval('proveedor_idproveedor_seq'::regclass);


--
-- TOC entry 2168 (class 2604 OID 20337)
-- Name: idpuesto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY puesto ALTER COLUMN idpuesto SET DEFAULT nextval('puesto_idpuesto_seq'::regclass);


--
-- TOC entry 2169 (class 2604 OID 20338)
-- Name: idreceptor; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY receptor ALTER COLUMN idreceptor SET DEFAULT nextval('receptor_idreceptor_seq'::regclass);


--
-- TOC entry 2171 (class 2604 OID 20339)
-- Name: idtipogasto; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tipogasto ALTER COLUMN idtipogasto SET DEFAULT nextval('tipogasto_idtipogasto_seq'::regclass);


--
-- TOC entry 2340 (class 0 OID 20204)
-- Dependencies: 181
-- Data for Name: canton; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (101, 1, 'San José');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (102, 1, 'Escazú');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (103, 1, 'Desamparados');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (104, 1, 'Puriscal');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (105, 1, 'Tarrazú');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (106, 1, 'Aserrí');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (107, 1, 'Mora');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (108, 1, 'Goicoecheca');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (109, 1, 'Santa Ana');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (110, 1, 'Alajuelita');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (111, 1, 'Vázquez de Coronado');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (112, 1, 'Acosta');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (113, 1, 'Tibás');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (114, 1, 'Moravia');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (115, 1, 'Montes de Oca');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (116, 1, 'Turrubares');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (117, 1, 'Dota');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (118, 1, 'Curridabat');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (119, 1, 'Pérez Zeledón');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (120, 1, 'León Cortéz Castro');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (201, 2, 'Alajuela');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (202, 2, 'San Ramón');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (203, 2, 'Grecia');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (204, 2, 'San Mateo');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (205, 2, 'Atenas');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (206, 2, 'Naranjo');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (207, 2, 'Palmares');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (208, 2, 'Poás');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (209, 2, 'Orotina');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (210, 2, 'San Carlos');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (211, 2, 'Zarcero');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (212, 2, 'Valverde Vega');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (213, 2, 'Upala');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (214, 2, 'Los Chiles');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (215, 2, 'Guatuso');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (216, 2, 'Río Claro');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (301, 3, 'Cartago');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (302, 3, 'Paraíso');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (303, 3, 'La Unión');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (304, 3, 'Jiménez');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (305, 3, 'Turrialba');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (306, 3, 'Alvarado');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (307, 3, 'Oreamuno');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (308, 3, 'El Guarco');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (401, 4, 'Heredia');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (402, 4, 'Barva');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (403, 4, 'Santo Domingo');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (404, 4, 'Santa Bárbara');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (405, 4, 'San Rafael');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (406, 4, 'San Isidro');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (407, 4, 'Belén');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (408, 4, 'Flores');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (409, 4, 'San Pablo');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (410, 4, 'Sarapiquí');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (501, 5, 'Liberia');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (502, 5, 'Nicoya');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (503, 5, 'Santa Cruz');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (504, 5, 'Bagaces');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (505, 5, 'Carrillo');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (506, 5, 'Cañas');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (507, 5, 'Abangares');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (508, 5, 'Tilarán');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (509, 5, 'Nandayure');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (510, 5, 'La Cruz');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (511, 5, 'Hojancha');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (601, 6, 'Puntarenas');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (602, 6, 'Esparza');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (603, 6, 'Buenos Aires');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (604, 6, 'Montes de Oro');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (605, 6, 'Osa');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (606, 6, 'Quepos');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (607, 6, 'Golfito');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (608, 6, 'Coto Brus');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (609, 6, 'Parrita');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (610, 6, 'Corredores');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (611, 6, 'Garabito');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (701, 7, 'Limón');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (702, 7, 'Pococí');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (703, 7, 'Siquirres');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (704, 7, 'Talamanca');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (705, 7, 'Matina');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (706, 7, 'Guácimo');


--
-- TOC entry 2341 (class 0 OID 20207)
-- Dependencies: 182
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO categoria (idcategoria, descripcioncategoria) VALUES (1, 'Ron                           ');
INSERT INTO categoria (idcategoria, descripcioncategoria) VALUES (2, 'Whisky                        ');
INSERT INTO categoria (idcategoria, descripcioncategoria) VALUES (3, 'Vodka                         ');
INSERT INTO categoria (idcategoria, descripcioncategoria) VALUES (4, 'Cacique                       ');
INSERT INTO categoria (idcategoria, descripcioncategoria) VALUES (5, 'Tequila                       ');
INSERT INTO categoria (idcategoria, descripcioncategoria) VALUES (6, 'Jager                         ');
INSERT INTO categoria (idcategoria, descripcioncategoria) VALUES (7, 'Especiales                    ');
INSERT INTO categoria (idcategoria, descripcioncategoria) VALUES (8, 'Botellitas                    ');


--
-- TOC entry 2401 (class 0 OID 0)
-- Dependencies: 183
-- Name: categoria_idcategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('categoria_idcategoria_seq', 8, true);


--
-- TOC entry 2343 (class 0 OID 20212)
-- Dependencies: 184
-- Data for Name: categoriainventario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO categoriainventario (idcategoriainventario, descripcioncategoriainventario) VALUES (1, 'Consumibles                   ');
INSERT INTO categoriainventario (idcategoriainventario, descripcioncategoriainventario) VALUES (2, 'Desechables                   ');
INSERT INTO categoriainventario (idcategoriainventario, descripcioncategoriainventario) VALUES (3, 'Licor                         ');
INSERT INTO categoriainventario (idcategoriainventario, descripcioncategoriainventario) VALUES (4, 'Frescos                       ');
INSERT INTO categoriainventario (idcategoriainventario, descripcioncategoriainventario) VALUES (5, 'Gaseosos                      ');
INSERT INTO categoriainventario (idcategoriainventario, descripcioncategoriainventario) VALUES (6, 'Hielo                         ');
INSERT INTO categoriainventario (idcategoriainventario, descripcioncategoriainventario) VALUES (7, 'Jugos y Cremas                ');


--
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 185
-- Name: categoriainventario_idcategoriainventario_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('categoriainventario_idcategoriainventario_seq', 7, true);


--
-- TOC entry 2345 (class 0 OID 20217)
-- Dependencies: 186
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cliente (idcliente, identificacioncliente, estadocliente) VALUES (1, 'cliente default                                                                                     ', 1);


--
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 187
-- Name: cliente_idcliente_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cliente_idcliente_seq', 1, true);


--
-- TOC entry 2347 (class 0 OID 20223)
-- Dependencies: 188
-- Data for Name: cliente_is_receptor; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 2348 (class 0 OID 20226)
-- Dependencies: 189
-- Data for Name: cuenta; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cuenta (idcuenta, idcliente, fechaaperturacuenta, estadocuenta) VALUES (1, 1, '2018-08-02 11:03:11.148049', 'Activa                        ');


--
-- TOC entry 2404 (class 0 OID 0)
-- Dependencies: 190
-- Name: cuenta_idcuenta_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cuenta_idcuenta_seq', 1, true);


--
-- TOC entry 2350 (class 0 OID 20232)
-- Dependencies: 191
-- Data for Name: distrito; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5050, 509, 'Porvenir');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1001, 101, 'Carmen');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1002, 101, 'Merced');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1003, 101, 'Hospital');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1004, 101, 'Catedral');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1005, 101, 'Zapote');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1006, 101, 'San Francisco de Dos Ríos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1007, 101, 'Uruca');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1008, 101, 'Mata Redonda');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1009, 101, 'Pavas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1010, 101, 'Hatillo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1011, 101, 'San Sebastián');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1012, 102, 'Escazú');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1013, 102, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1014, 102, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1015, 103, 'Desamparados');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1016, 103, 'San Miguel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1017, 103, 'San Juan de Dios');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1018, 103, 'San Rafael Arriba');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1019, 103, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1020, 103, 'Frailes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1021, 103, 'Patarrá');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1022, 103, 'San cristóbal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1023, 103, 'Rosario');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1024, 103, 'Damas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1025, 103, 'San Rafael Abajo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1026, 103, 'Gravillas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1027, 103, 'Los Guido');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1028, 104, 'Santiago');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1029, 104, 'Mercedes Sur');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1030, 104, 'Barbacoas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1031, 104, 'Grifo Alto');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1032, 104, 'San rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1033, 104, 'Csndelarita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1034, 104, 'Desamparaditos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1035, 104, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1036, 104, 'Chires');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1037, 104, 'La Cangreja');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1038, 105, 'San Marcos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1039, 105, 'San Lorenzo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1040, 105, 'San Carlos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1041, 106, 'Aserrí');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1042, 106, 'Tarbaca');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1043, 106, 'Vuelta de Jorco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1044, 106, 'San Gabriel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1045, 106, 'Legua');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1046, 106, 'Monterrey');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1047, 106, 'Salitrillos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1048, 107, 'Cuidad Colón');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1049, 107, 'Guayabo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1050, 107, 'Tabarcia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1051, 107, 'Piedras Negras');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1052, 107, 'Picagres');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1053, 107, 'Jaris');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1054, 107, 'Quitirrisí');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1055, 108, 'Guadalupe');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1056, 108, 'San Francisco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1057, 108, 'Calle Blancos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1058, 108, 'Mata de Plátano');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1059, 108, 'Ipís');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1060, 108, 'Rancho Redondo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1061, 108, 'Purral');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1062, 109, 'Santa Ana');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1063, 109, 'Salitral');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1064, 109, 'Pozos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1065, 109, 'Uruca');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1066, 109, 'Piedades');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1067, 109, 'Brasil');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1068, 110, 'Alajuelita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1069, 110, 'San Josecito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1070, 110, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1071, 110, 'Concepción');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1072, 110, 'San Felipe');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1073, 111, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1074, 111, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1075, 111, 'Dulce Nombre de Jesús');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1076, 111, 'Patalillo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1077, 111, 'Cascajal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1078, 112, 'San Ignacio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1079, 112, 'Guaitil');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1080, 112, 'Palmichal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1081, 112, 'Cangrejal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1082, 112, 'Sabanillas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1083, 113, 'San Juan');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1084, 113, 'Cinco Esquinas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1085, 113, 'Anselmo Llorente');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1086, 113, 'León XIII');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1087, 113, 'Colima');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1088, 114, 'San Vicente');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1089, 114, 'San Jerónimo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1090, 114, 'Trinidad');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1091, 115, 'San Pedro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1092, 115, 'Sabanilla');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1093, 115, 'Mercedes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1094, 115, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1095, 116, 'San Pablo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1096, 116, 'San Pedro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1097, 116, 'San Juan de Mata');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1098, 116, 'San Luis');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1099, 116, 'Carara');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1100, 117, 'Santa María');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1101, 117, 'Jardín');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1102, 117, 'Copey');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1103, 118, 'Curridabat');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1104, 118, 'Granadilla');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1105, 118, 'Sánchez');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1106, 118, 'Tirrases');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1107, 119, 'San Isidro de EL General');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1108, 119, 'El General');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1109, 119, 'Daniel Flores');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1110, 119, 'Rivas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1111, 119, 'San Pedro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1112, 119, 'Platanares');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1113, 119, 'Pejibaye');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1114, 119, 'Cajón');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1115, 119, 'Barú');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1116, 119, 'Río Nuevo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1117, 119, 'Páramo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1118, 119, 'La Amistad');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1119, 120, 'San Pablo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1120, 120, 'San Andrés');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1121, 120, 'Llano Bonito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1122, 120, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1123, 120, 'Santa Cruz');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (1124, 120, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2001, 201, 'Alajuela');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2002, 201, 'San José');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2003, 201, 'Carrizal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2004, 201, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2005, 201, 'Guácima');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2006, 201, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2007, 201, 'Sabanilla');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2008, 201, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2009, 201, 'Río Segundo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2010, 201, 'Desamparados');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2011, 201, 'Turrúcares');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2012, 201, 'Tambor');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2013, 201, 'Garita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2014, 201, 'Sarapiquí');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2015, 202, 'San Ramón');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2016, 202, 'Santiago');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2017, 202, 'San Juan');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2018, 202, 'Piedades Norte');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2019, 202, 'Piedades Sur');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2020, 202, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2021, 202, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2022, 202, 'Ángeles');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2023, 202, 'Alfaro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2024, 202, 'Volio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2025, 202, 'Concepción');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2026, 202, 'Zapotal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2027, 202, 'Peñas Blancas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2028, 202, 'San Lorenzo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2029, 203, 'Grecia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2030, 203, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2031, 203, 'San José');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2032, 203, 'San Roque');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2033, 203, 'Tacares');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2034, 203, 'Puente de Piedra');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2035, 203, 'Bolivar');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2036, 204, 'San Mateo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2037, 204, 'Desmonte');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2038, 204, 'Jesús María');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2039, 204, 'Labrador');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2040, 205, 'Atenas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2041, 205, 'Jesús');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2042, 205, 'Mercedes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2043, 205, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2044, 205, 'Concepción');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2045, 205, 'San José');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2046, 205, 'Santa Eulalia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2047, 205, 'Escobal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2048, 206, 'Naranjo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2049, 206, 'San Miguel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2050, 206, 'San José');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2051, 206, 'Cirrí');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2052, 206, 'San Jerónimo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2053, 206, 'San Juan');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2054, 206, 'El Rosario');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2055, 206, 'Palmitos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2056, 207, 'Palamares');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2057, 207, 'Zaragoza');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2058, 207, 'Buenos Aires');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2059, 207, 'Santiago');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2060, 207, 'Candelaria');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2061, 207, 'Esquipulas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2062, 207, 'La Granja');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2063, 208, 'San Pedro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2064, 208, 'San Juan');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2065, 208, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2066, 208, 'Carrillos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2067, 208, 'Sabana Redonda');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2068, 209, 'Orotina');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2069, 209, 'Mastate');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2070, 209, 'Hacienda Vieja');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2071, 209, 'Coyolar');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2072, 209, 'La Ceiba');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2073, 210, 'Quesada');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2074, 210, 'Florencia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2075, 210, 'Buenavista');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2076, 210, 'Aguas Zarcas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2077, 210, 'Venecia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2078, 210, 'Pital');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2079, 210, 'La Fortuna');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2080, 210, 'La Tigra');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2081, 210, 'La Palmera');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2082, 210, 'Venado');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2083, 210, 'Cutris');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2084, 210, 'Monterrey');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2085, 210, 'Pocosol');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2086, 211, 'Zarcero');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2087, 211, 'Laguna');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2088, 211, 'Tapezco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2089, 211, 'Guadalupe');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2090, 211, 'Palmira');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2091, 211, 'Zapote');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2092, 211, 'Brisas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2093, 212, 'Sarchí Norte');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2094, 212, 'Sarchí Sur');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2095, 212, 'Toro Amarillo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2096, 212, 'San Pedro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2097, 212, 'Rodríguez');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2098, 213, 'Upala');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2099, 213, 'Aguas Claras');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2100, 213, 'San José(Pizote)');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2101, 213, 'Bijagua');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2102, 213, 'Delicias');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2103, 213, 'Dos Ríos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2104, 213, 'Yolillal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2105, 213, 'Canalete');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2106, 214, 'Los Chiles');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2107, 214, 'Caño Negro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2108, 214, 'El Amparo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2109, 214, 'San Jorge');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2110, 215, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2111, 215, 'Buenavista');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2112, 215, 'Cote');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2113, 215, 'Katira');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (2114, 216, 'Río Cuarto');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3001, 301, 'Oriental');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3002, 301, 'Occidental');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3003, 301, 'Carmen');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3004, 301, 'San Nicolás');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3005, 301, 'Agua Caliente(San Francisco)');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3006, 301, 'Guadalupe(Arenilla)');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3007, 301, 'Corralillo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3008, 301, 'Tierra Blanca');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3009, 301, 'Dulce Nombre');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3010, 301, 'Llano Grande');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3011, 301, 'Quebradilla');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3012, 302, 'Paraíso');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3013, 302, 'Santiago de Paraíso');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3014, 302, 'Orosi');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3015, 302, 'Cachí');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3016, 302, 'Llanos de Santa Lucía');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3017, 303, 'Tres Ríos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3018, 303, 'San Diego');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3019, 303, 'San Juan');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3020, 303, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3021, 303, 'Concepción');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3022, 303, 'Dulce Nombre');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3023, 303, 'San Ramón');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3024, 303, 'Río Azul');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3025, 304, 'Juan Viñas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3026, 304, 'Tucurrique');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3027, 304, 'Pejibaye');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3028, 305, 'Turrialba');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3029, 305, 'La Suiza');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3030, 305, 'Peralta');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3031, 305, 'Santa Cruz');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3032, 305, 'Santa Teresita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3033, 305, 'Pavones');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3034, 305, 'Tuis');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3035, 305, 'Tayutic');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3036, 305, 'Santa Rosa');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3037, 305, 'Tres Equis');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3038, 305, 'La Isabel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3039, 305, 'Chirripó');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3040, 306, 'Pacayas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3041, 306, 'Cervantes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3042, 306, 'Cepellades');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3043, 307, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3044, 307, 'Cot');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3045, 307, 'Potrero Cerrado');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3046, 307, 'Cipreses');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3047, 307, 'Santa Rosa');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3048, 308, 'Tejar');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3049, 308, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3050, 308, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (3051, 308, 'Patito de Agua');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4001, 401, 'Heredia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4002, 401, 'Mercedes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4003, 401, 'San Francisco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4004, 401, 'Ulloa');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4005, 401, 'Vara Blanca');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4006, 402, 'Barva');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4007, 402, 'San Pedro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4008, 402, 'San Pablo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4009, 402, 'San Roque');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4010, 402, 'Santa Lucía');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4011, 402, 'San José de la Montaña');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4012, 403, 'Santo Domingo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4013, 403, 'San Vicente');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4014, 403, 'San Miguel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4015, 403, 'Paracito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4016, 403, 'Santo Tomás');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4017, 403, 'Santa Rosa');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4018, 403, 'Tures');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4019, 403, 'Pará');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4020, 404, 'Santa Bárbara');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4021, 404, 'San Pedro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4022, 404, 'San Juan');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4023, 404, 'Jesús');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4024, 404, 'Santo Domingo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4025, 404, 'Purabá');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4026, 405, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4027, 405, 'San Josecito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4028, 405, 'Santiago');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4029, 405, 'Ángeles');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4030, 405, 'Concepción');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4031, 406, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4032, 406, 'San José');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4033, 406, 'Concepción');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4034, 406, 'San Francisco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4035, 407, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4036, 407, 'La Ribera');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4037, 407, 'La Asunción');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4038, 408, 'San Joaquín');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4039, 408, 'Barrantes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4040, 408, 'Llorente');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4041, 409, 'San Pablo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4042, 409, 'Rincón de Sabanilla');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4043, 410, 'Puerto Viejo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4044, 410, 'La Virgen');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4045, 410, 'Horquetas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4046, 410, 'Llanuras del Gaspar');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (4047, 410, 'Cureña');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5001, 501, 'Liberia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5002, 501, 'Cañas Dulces');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5003, 501, 'Mayorga');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5004, 501, 'Nacascolo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5005, 501, 'Curudandé');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5006, 502, 'Nicoya');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5007, 502, 'Mansión');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5008, 502, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5009, 502, 'Quebrada Honda');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5010, 502, 'Sámara');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5011, 502, 'Nosara');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5012, 502, 'Belén de Nosarita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5013, 503, 'Santa Cruz');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5014, 503, 'Bolsón');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5015, 503, 'Veintisiete de Abril');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5016, 503, 'Tempate');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5017, 503, 'Cartagena');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5018, 503, 'Cuanijiquil');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5019, 503, 'Diriá');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5020, 503, 'Cabo Velas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5021, 503, 'Tamarindo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5022, 504, 'Bagaces');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5023, 504, 'La Fortuna');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5024, 504, 'Mogote');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5025, 504, 'Río Naranjo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5026, 505, 'Filadelfia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5027, 505, 'Palmira');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5028, 505, 'Sardinal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5029, 505, 'Belén');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5030, 506, 'Cañas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5031, 506, 'Palmira');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5032, 506, 'San Miguel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5033, 506, 'Bebedero');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5034, 506, 'Porozal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5035, 507, 'Las Juntas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5036, 507, 'Sierra');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5037, 507, 'San Juan');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5038, 507, 'Colorado');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5039, 508, 'Tilarán');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5040, 508, 'Quebrada Grande');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5041, 508, 'Tronadora');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5042, 508, 'Santa Rosa');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5043, 508, 'Líbano');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5044, 508, 'Tierras Morenas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5045, 508, 'Arenal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5046, 509, 'Carmona');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5047, 509, 'Santa Rita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5048, 509, 'Zapotal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5049, 509, 'San Pablo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5051, 509, 'Bejuco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5052, 510, 'La Cruz');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5053, 510, 'Santa Cecilia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5054, 510, 'La Garita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5055, 510, 'Santa Elena');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5056, 511, 'Hojancha');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5057, 511, 'Monte Romo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5058, 511, 'Puerto Carrillo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5059, 511, 'Huacas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (5060, 511, 'Matambú');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6001, 601, 'Puntarenas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6002, 601, 'Pitahaya');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6003, 601, 'Chomes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6004, 601, 'Lepanto');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6005, 601, 'Paquera');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6006, 601, 'Manzanillo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6007, 601, 'Guacimal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6008, 601, 'Barranca');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6009, 601, 'Monteverde');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6010, 601, 'Isla del Coco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6011, 601, 'Cóbano');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6012, 601, 'Chacarita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6013, 601, 'Chira');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6014, 601, 'Acapulco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6015, 601, 'El Roble');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6016, 601, 'Arancibia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6017, 602, 'Espíritu Santo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6018, 602, 'San Juan Grande');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6019, 602, 'Macacona');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6020, 602, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6021, 602, 'San Jerónimo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6022, 602, 'Caldera');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6023, 603, 'Buenos Aires');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6024, 603, 'Volcán');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6025, 603, 'Potrero Grande');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6026, 603, 'Boruca');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6027, 603, 'Pilas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6028, 603, 'Colinas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6029, 603, 'Chánguena');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6030, 603, 'Biolley');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6031, 603, 'Brunka');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6032, 604, 'San Miguel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6033, 604, 'Bebedero');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6034, 604, 'Porozal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6035, 605, 'Cortés');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6036, 605, 'Palmar');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6037, 605, 'Sierpe');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6038, 605, ' Bahía Ballena');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6039, 605, 'Piedras Blancas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6040, 605, 'Bahía Drake');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6041, 606, 'Quepos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6042, 606, 'Savegre');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6043, 606, 'Naranjito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6044, 607, 'Golfito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6045, 607, 'Puerto Jiménez');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6046, 607, 'Guaycará');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6047, 607, 'Pavón');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6048, 608, 'San Vito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6049, 608, 'Sabalito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6050, 608, 'Aguabuena');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6051, 608, 'Limoncito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6052, 608, 'Pittier');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6053, 608, 'Gutiérrez Brown');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6054, 609, 'Parrita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6055, 610, 'Corredor');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6056, 610, 'La Cuesta');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6057, 611, 'Paso Canoas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6058, 611, 'Laurel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6059, 611, 'Jacó');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (6060, 611, 'Tárcoles');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7001, 701, 'Limón');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7002, 701, 'Valle La Estrella');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7003, 701, 'Río Blanco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7004, 701, 'Matama');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7005, 702, 'Guápiles');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7006, 702, 'Jiménez');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7007, 702, 'La Rita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7008, 702, 'Roxana');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7009, 702, 'Cariari');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7010, 702, 'Colorado');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7011, 702, 'La Colonia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7012, 703, 'Siquirres');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7013, 703, 'Pacuarito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7014, 703, 'Florida');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7015, 703, 'Germania');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7016, 703, 'Cairo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7017, 703, 'Alegría');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7018, 704, 'Bratsi');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7019, 704, 'Sixaola');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7020, 704, 'Cahuita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7021, 704, 'Telire');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7022, 705, 'Matina');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7023, 705, 'Batán');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7024, 705, 'Carrandi');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7025, 706, 'Guácimo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7026, 706, 'Mercedes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7027, 706, 'Pocora');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7028, 706, 'Río Jiménez');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (7029, 706, 'Duacari');


--
-- TOC entry 2351 (class 0 OID 20235)
-- Dependencies: 192
-- Data for Name: emisor; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO emisor (idemisor, nombre, emisor_tipo_identificacion, emisor_numero, nombrecomercial, provincia, canton, distrito, otras_senas, emisor_telefono_codigopais, emisor_telefono_numtelefono, emisor_fax_codigopais, emisor_fax_numtelefono, correoelectronico) VALUES (1, 'Nataniel Venegas Mendez', '01', '114820875', 'imagineING', 1, 103, 1016, NULL, 506, 89600099, 506, 83205986, 'navemen23@hotmail.com');


--
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 193
-- Name: emisor_idemisor_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('emisor_idemisor_seq', 1, true);


--
-- TOC entry 2353 (class 0 OID 20243)
-- Dependencies: 194
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO empleado (idempleado, nombreempleado, apellidoempleado, passwordempleado, idpuesto, estadoempleado) VALUES (1, 'Empleado1                                         ', 'Apellido1                                         ', 'pass                                              ', 1, 1);
INSERT INTO empleado (idempleado, nombreempleado, apellidoempleado, passwordempleado, idpuesto, estadoempleado) VALUES (2, 'Empleado2                                         ', 'Apellido2                                         ', 'pass                                              ', 1, 1);
INSERT INTO empleado (idempleado, nombreempleado, apellidoempleado, passwordempleado, idpuesto, estadoempleado) VALUES (3, 'Nico                                              ', 'Godin                                             ', 'ngodin                                            ', 2, 1);


--
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 195
-- Name: empleado_idempleado_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('empleado_idempleado_seq', 3, true);


--
-- TOC entry 2355 (class 0 OID 20249)
-- Dependencies: 196
-- Data for Name: factura; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO factura (idfactura, idcuenta, idempleado, idperiodoventa, fecharegistrofactura, formapago, subtotal, porcentajedescuento, cantidadpersonas, estadofactura, codigomoneda, tipocambio, totalservgravados, totalservexentos, totalmercanciasgravadas, totalmercanciasexentas, totalgravado, totalexento, totalventa, totaldescuentos, totalventaneta, totalimpuesto, totalcomprobante) VALUES (1, 1, 3, 2, '2018-08-04 17:56:22.273037', 'Efectivo  ', 3500.00, 0.00, 1, 1, '500', 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000, 1.00000);


--
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 197
-- Name: factura_idfactura_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('factura_idfactura_seq', 1, true);


--
-- TOC entry 2357 (class 0 OID 20256)
-- Dependencies: 198
-- Data for Name: gasto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO gasto (idgasto, idtipogasto, descripciongasto, estadogasto, montogasto, fechagasto, observaciongasto) VALUES (1, 1, 'Recibo Agua                                       ', 'Se debe             ', 50000.00, '2018-08-02 11:03:11.148049', 'Pago mes de Octubre                                                                                 ');
INSERT INTO gasto (idgasto, idtipogasto, descripciongasto, estadogasto, montogasto, fechagasto, observaciongasto) VALUES (2, 2, 'Salario Empleado1                                 ', 'Pagado              ', 150000.00, '2018-08-02 11:03:11.148049', 'Planilla Octubre                                                                                    ');
INSERT INTO gasto (idgasto, idtipogasto, descripciongasto, estadogasto, montogasto, fechagasto, observaciongasto) VALUES (3, 3, 'Ron                                               ', 'Pagado              ', 15000.00, '2018-08-02 11:03:11.148049', 'Litro de Ron                                                                                        ');


--
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 199
-- Name: gasto_idgasto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('gasto_idgasto_seq', 3, true);


--
-- TOC entry 2359 (class 0 OID 20262)
-- Dependencies: 200
-- Data for Name: inventario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (1, 1, 'Azucar                                            ', 150.00, 1000.00, 10.00, 'Unidad    ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (2, 1, 'Pmienta                                           ', 150.00, 1000.00, 10.00, 'Gramos    ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (3, 1, 'Sal                                               ', 150.00, 1000.00, 10.00, 'Gramos    ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (4, 1, 'Salsa Inglesa                                     ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (5, 1, 'Tabasco                                           ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (6, 2, 'Botellita 240ml                                   ', 150.00, 1000.00, 10.00, 'Unidades  ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (7, 2, 'Botellita 500ml                                   ', 150.00, 1000.00, 10.00, 'Unidades  ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (8, 2, 'Pajilla                                           ', 150.00, 1000.00, 10.00, 'Unidades  ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (9, 2, 'Postal                                            ', 150.00, 1000.00, 10.00, 'Unidades  ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (10, 2, 'Tapa                                              ', 150.00, 1000.00, 10.00, 'Unidades  ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (11, 2, 'Vaso                                              ', 150.00, 1000.00, 10.00, 'Unidades  ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (12, 3, 'Blue Curacao                                      ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (13, 3, 'Chachaca                                          ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (14, 3, 'Cacique                                           ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (15, 3, 'Cerveza                                           ', 150.00, 1000.00, 10.00, 'Unidades  ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (16, 3, 'Cranberry                                         ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (17, 3, 'Crema de Cacao Blanco                             ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (18, 3, 'Crema de Menta                                    ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (19, 3, 'Ginebra                                           ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (20, 3, 'Jager                                             ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (21, 3, 'Licor de Cafe                                     ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (22, 3, 'Licor de Melocoton                                ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (23, 3, 'Malibu                                            ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (24, 3, 'Ron Blanco                                        ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (25, 3, 'Tequilaa                                          ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (26, 3, 'Tequila Rose                                      ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (27, 3, 'Triple Sec                                        ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (28, 3, 'Vermount Seco                                     ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (29, 3, 'Vino de Nance                                     ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (30, 3, 'Vodka                                             ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (31, 3, 'Whisky                                            ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (32, 4, 'Hierba Buena                                      ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (33, 4, 'Limon                                             ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (34, 5, 'Coca-Cola                                         ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (35, 5, 'Soda                                              ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (36, 6, 'Hielo                                             ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (37, 7, 'Crema de Coco                                     ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (38, 7, 'Granadina                                         ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (39, 7, 'Horchata                                          ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (40, 7, 'Jugo de Cereza                                    ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (41, 7, 'Jugo de Fresa                                     ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (42, 7, 'Jugo de Maracuya                                  ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (43, 7, 'Jugo de Naranja                                   ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (44, 7, 'Jugo de Piña                                      ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (45, 7, 'Jugo de Tomate                                    ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (46, 7, 'Jugo de Toronja                                   ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (47, 7, 'Leche                                             ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (48, 7, 'Leche Evaporada                                   ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (49, 7, 'Limonada                                          ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (50, 7, 'Sirope de Cola                                    ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);
INSERT INTO inventario (idinventario, idcategoriainventario, descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, unidad, codigobarrainventario, estadoinventario) VALUES (51, 7, 'Te Frio                                           ', 150.00, 1000.00, 10.00, 'Onzas     ', NULL, 1);


--
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 201
-- Name: inventario_idinventario_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('inventario_idinventario_seq', 51, true);


--
-- TOC entry 2361 (class 0 OID 20268)
-- Dependencies: 202
-- Data for Name: inventarioproducto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (37, 1, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (24, 1, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (44, 1, 10.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (36, 1, 16.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (11, 1, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (9, 1, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (10, 1, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (8, 1, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (1, 2, 5.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (32, 2, 10.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (33, 2, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (24, 2, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (35, 2, 12.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (36, 2, 16.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (11, 2, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (9, 2, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (10, 2, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (8, 2, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (12, 8, 2.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (49, 8, 12.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (30, 8, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (36, 8, 16.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (11, 8, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (9, 8, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (10, 8, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (8, 8, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (38, 9, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (43, 9, 10.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (22, 9, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (30, 9, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (36, 9, 16.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (11, 9, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (9, 9, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (10, 9, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (8, 9, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (34, 13, 12.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (31, 13, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (36, 13, 16.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (11, 13, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (9, 13, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (10, 13, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (8, 13, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (28, 14, 12.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (31, 14, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (40, 14, 10.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (36, 14, 16.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (11, 14, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (9, 14, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (10, 14, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (8, 14, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (45, 17, 4.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (5, 17, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (33, 17, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (15, 17, 12.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (14, 17, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (36, 17, 16.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (11, 17, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (9, 17, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (10, 17, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (8, 9, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (50, 18, 0.50);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (14, 18, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (29, 18, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (35, 18, 10.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (36, 18, 16.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (11, 18, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (9, 18, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (10, 18, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (8, 18, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (46, 21, 6.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (33, 21, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (35, 21, 6.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (25, 21, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (36, 21, 16.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (11, 21, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (9, 21, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (10, 21, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (8, 21, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (49, 22, 10.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (27, 22, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (1, 22, 4.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (25, 22, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (36, 22, 16.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (11, 22, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (9, 22, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (10, 22, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (8, 22, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (20, 26, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (14, 26, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (51, 26, 10.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (36, 26, 16.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (11, 26, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (9, 26, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (10, 26, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (8, 26, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (12, 27, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (49, 27, 6.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (24, 27, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (25, 27, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (30, 27, 3.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (36, 27, 16.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (11, 27, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (9, 27, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (10, 27, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (8, 27, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (18, 32, 4.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (28, 32, 4.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (43, 32, 7.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (38, 32, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (6, 32, 2.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (9, 32, 1.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (20, 33, 8.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (26, 33, 8.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (6, 32, 2.00);
INSERT INTO inventarioproducto (idinventario, idproducto, cantidadnecesaria) VALUES (9, 32, 1.00);


--
-- TOC entry 2362 (class 0 OID 20271)
-- Dependencies: 203
-- Data for Name: orden; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, cantidad, unidadmedida, unidadmedidacomercial, detalle, preciounitario, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea) VALUES (33, 1, 3, 1, 1, 'Cancelada ', '2018-08-04 02:59:26', 3500.00, NULL, 0.00, 1, '1', '2', 1.000, '1', '1', '1', 1.00000, 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2001-01-01 11:01:02', 1.00000, 1, 1.00000);
INSERT INTO orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, cantidad, unidadmedida, unidadmedidacomercial, detalle, preciounitario, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea) VALUES (36, 1, 1, NULL, 1, 'Pendiente ', '2018-08-05 00:25:32', 3500.00, 0.00, 0.00, 1, '1', '2', 1.000, '1', '1', '1', 1.00000, 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2001-01-01 11:01:02', 1.00000, 1, 1.00000);
INSERT INTO orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, cantidad, unidadmedida, unidadmedidacomercial, detalle, preciounitario, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea) VALUES (37, 1, 2, NULL, 1, 'Pendiente ', '2018-08-05 00:25:32', 3500.00, 0.00, 0.00, 1, '1', '2', 1.000, '1', '1', '1', 1.00000, 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2001-01-01 11:01:02', 1.00000, 1, 1.00000);
INSERT INTO orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, cantidad, unidadmedida, unidadmedidacomercial, detalle, preciounitario, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea) VALUES (38, 1, 3, NULL, 1, 'Pendiente ', '2018-08-05 00:25:32', 3500.00, 0.00, 0.00, 1, '1', '2', 1.000, '1', '1', '1', 1.00000, 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2001-01-01 11:01:02', 1.00000, 1, 1.00000);
INSERT INTO orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, cantidad, unidadmedida, unidadmedidacomercial, detalle, preciounitario, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea) VALUES (39, 1, 2, NULL, 1, 'Pendiente ', '2018-08-05 00:25:37', 3500.00, 0.00, 0.00, 1, '1', '2', 1.000, '1', '1', '1', 1.00000, 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2001-01-01 11:01:02', 1.00000, 1, 1.00000);
INSERT INTO orden (idorden, idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, fecharegistroorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, codigoservicio, tiposervicio, cantidad, unidadmedida, unidadmedidacomercial, detalle, preciounitario, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, exoneracion_tipodocumento, numerodocumento, nombreinstitucion, fechaemision, montoimpuesto, procentajecompra, montoitotallinea) VALUES (40, 1, 3, NULL, 1, 'Pendiente ', '2018-08-05 00:25:37', 3500.00, 0.00, 0.00, 1, '1', '2', 1.000, '1', '1', '1', 1.00000, 1.00000, 1.00000, '1', 1.00000, '1', 1.00, 1.00000, '1', '1', '1', '2001-01-01 11:01:02', 1.00000, 1, 1.00000);


--
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 204
-- Name: orden_idorden_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('orden_idorden_seq', 40, true);


--
-- TOC entry 2364 (class 0 OID 20280)
-- Dependencies: 205
-- Data for Name: periodoventa; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO periodoventa (idperiodoventa, nombreperiodoventa, estadoperiodoventa, fechainicioperiodoventa, fechafinperiodoventa, idempleado) VALUES (2, 'Periodo1                                          ', 'Activo    ', '2018-08-02 11:03:11.148049', NULL, NULL);


--
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 206
-- Name: periodoventa_idperiodoventa_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('periodoventa_idperiodoventa_seq', 2, true);


--
-- TOC entry 2366 (class 0 OID 20287)
-- Dependencies: 207
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (1, 'Piña Colada                                       ', 1, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (2, 'Mojito Frozen                                     ', 1, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (3, 'Cuba Libre Frozen                                 ', 1, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (5, 'Hurricane                                         ', 1, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (6, 'Sueño Rosado                                      ', 1, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (7, 'Pasion Tropical                                   ', 1, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (8, 'Blue Lagoon                                       ', 3, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (9, 'Sex On The Beach                                  ', 3, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (10, 'Bloddy Mary                                       ', 3, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (11, 'Ruso Blanco                                       ', 3, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (12, 'Destornillador                                    ', 3, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (13, 'Coca Frozen                                       ', 2, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (14, 'Manhattan                                         ', 2, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (15, 'Whisky Sour                                       ', 2, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (16, 'Cow Boy                                           ', 2, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (17, 'Chili Birra                                       ', 4, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (18, 'Chepe De Noche                                    ', 4, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (19, 'Jugo de Piña                                      ', 4, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (20, 'Nieve de Cacique                                  ', 4, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (21, 'Paloma                                            ', 5, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (22, 'Margarita                                         ', 5, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (23, 'Tequila Sunrise                                   ', 5, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (24, 'Vertigo                                           ', 5, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (25, 'Submarino                                         ', 5, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (26, 'Te Jager                                          ', 6, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (27, 'Hasta Nunca                                       ', 6, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (28, 'Bomba Atomica                                     ', 6, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (29, 'Iguana                                            ', 6, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (30, 'Malibu Surf                                       ', 6, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (31, 'Grasshopper                                       ', 6, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (32, 'Santa Shot                                        ', 7, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (33, 'Bella Y Bestia                                    ', 7, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (34, 'Diablo Azul                                       ', 7, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (35, 'Horpacha                                          ', 7, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (36, 'Chiliguaro                                        ', 7, 3500, NULL, 1);
INSERT INTO producto (idproducto, descripcionproducto, idcategoria, precioproducto, codigobarraproducto, estadoproducto) VALUES (4, 'Daiquiri Fresa                                    ', 1, 3500, NULL, 0);


--
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 208
-- Name: producto_idproducto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('producto_idproducto_seq', 36, true);


--
-- TOC entry 2368 (class 0 OID 20293)
-- Dependencies: 209
-- Data for Name: proveedor; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (1, 'AMPM                                              ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (2, 'El Glaciar                                        ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (3, 'Envasa                                            ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (4, 'Esteban                                           ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (5, 'Goti                                              ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (6, 'Licorera                                          ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (7, 'Mayca                                             ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (8, 'Walmart                                           ', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO proveedor (idproveedor, empresa, nombrecontacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor, estadoproveedor) VALUES (9, 'Sin Definir                                       ', NULL, NULL, NULL, NULL, NULL, 1);


--
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 210
-- Name: proveedor_idproveedor_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('proveedor_idproveedor_seq', 9, true);


--
-- TOC entry 2370 (class 0 OID 20299)
-- Dependencies: 211
-- Data for Name: proveedorinventario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (1, 32, 100.00, '2018-08-02 11:03:11.148049', 700.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (2, 36, 100.00, '2018-08-02 11:03:11.148049', 900.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (3, 6, 100.00, '2018-08-02 11:03:11.148049', 500.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (3, 7, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (4, 9, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 12, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 13, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 14, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 16, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 17, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 19, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 20, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 21, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 22, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 23, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 24, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 25, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 26, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 27, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 28, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 30, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 31, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (5, 38, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (6, 29, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (7, 8, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (7, 10, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (7, 11, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (7, 18, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (7, 37, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (7, 50, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 1, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 2, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 3, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 4, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 5, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 33, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 34, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 35, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 39, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 40, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 41, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 42, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 43, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 44, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 45, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 46, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 47, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 48, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 49, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (8, 51, 100.00, '2018-08-02 11:03:11.148049', 800.00);
INSERT INTO proveedorinventario (idproveedor, idinventario, cantidadproducto, fecharegistro, costounitario) VALUES (9, 15, 100.00, '2018-08-02 11:03:11.148049', 800.00);


--
-- TOC entry 2371 (class 0 OID 20303)
-- Dependencies: 212
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO provincia (codigo_provincia, nombre_provincia) VALUES (1, 'San José');
INSERT INTO provincia (codigo_provincia, nombre_provincia) VALUES (2, 'Alajuela');
INSERT INTO provincia (codigo_provincia, nombre_provincia) VALUES (3, 'Cartago');
INSERT INTO provincia (codigo_provincia, nombre_provincia) VALUES (4, 'Heredia');
INSERT INTO provincia (codigo_provincia, nombre_provincia) VALUES (5, 'Guanacaste');
INSERT INTO provincia (codigo_provincia, nombre_provincia) VALUES (6, 'Puntarenas');
INSERT INTO provincia (codigo_provincia, nombre_provincia) VALUES (7, 'Limón');


--
-- TOC entry 2372 (class 0 OID 20306)
-- Dependencies: 213
-- Data for Name: puesto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO puesto (idpuesto, descripcionpuesto, departamentopuesto) VALUES (1, 'Administrador                                     ', 'Gerencia                                          ');
INSERT INTO puesto (idpuesto, descripcionpuesto, departamentopuesto) VALUES (2, 'Cajero                                            ', 'Ventas                                            ');


--
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 214
-- Name: puesto_idpuesto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('puesto_idpuesto_seq', 2, true);


--
-- TOC entry 2374 (class 0 OID 20311)
-- Dependencies: 215
-- Data for Name: receptor; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES (4, 'nombre prueba final', '01', '0', '11111111111111', 'iamgineing', 1, 102, 1013, NULL, 9, 89600099, 506, 88764325, 'navemen23@hotmail.com', 1);
INSERT INTO receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES (3, 'undefined', '01', '123456789', NULL, NULL, 2, 201, 2002, NULL, 9, NULL, NULL, NULL, NULL, 1);
INSERT INTO receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES (17, 'dfdsfsdf', '03', '22222222222', NULL, NULL, 3, 303, 3019, NULL, NULL, NULL, NULL, NULL, 'john.doe@gmail.com', 0);
INSERT INTO receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES (1, 'dfdsfsdf', '03', '12345678901', NULL, NULL, 2, 204, 2037, NULL, 9, NULL, NULL, NULL, 'nrv2391@gmail.com', 0);
INSERT INTO receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES (13, 'dfdsfsdf', '01', '999999999', NULL, NULL, 3, 304, 3026, NULL, 9, NULL, NULL, NULL, 'navemen23@hotmail.com', 0);
INSERT INTO receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES (2, 'undefined', '02', '1234567890', '5552220000', 'img', 2, 203, 2030, NULL, 9, NULL, NULL, NULL, NULL, 0);
INSERT INTO receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES (7, 'Nombre prueba actual', '01', '114820875', '1111111111111', 'iamgineing nueva ', 3, 303, 3018, 'UCR', 999, 89600099, 507, 88764525, 'prueba@actualizar.com', 1);
INSERT INTO receptor (idreceptor, nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES (8, 'dfdsfsdf', '02', '9999999999', '0123456789012', 'facebook123', 1, 104, 1032, 'actual ', 900, 9999999999, 507, 88764525, 'actual@actual.com', 1);


--
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 216
-- Name: receptor_idreceptor_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('receptor_idreceptor_seq', 17, true);


--
-- TOC entry 2376 (class 0 OID 20319)
-- Dependencies: 217
-- Data for Name: tipogasto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO tipogasto (idtipogasto, descripciontipogasto) VALUES (1, 'Servicio                                          ');
INSERT INTO tipogasto (idtipogasto, descripciontipogasto) VALUES (2, 'Planilla                                          ');
INSERT INTO tipogasto (idtipogasto, descripciontipogasto) VALUES (3, 'Inventario Bebidas                                ');
INSERT INTO tipogasto (idtipogasto, descripciontipogasto) VALUES (4, 'Activos                                           ');


--
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 218
-- Name: tipogasto_idtipogasto_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tipogasto_idtipogasto_seq', 4, true);


--
-- TOC entry 2173 (class 2606 OID 20341)
-- Name: canton_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY canton
    ADD CONSTRAINT canton_pkey PRIMARY KEY (codigo_canton);


--
-- TOC entry 2175 (class 2606 OID 20343)
-- Name: categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (idcategoria);


--
-- TOC entry 2177 (class 2606 OID 20345)
-- Name: categoriainventario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categoriainventario
    ADD CONSTRAINT categoriainventario_pkey PRIMARY KEY (idcategoriainventario);


--
-- TOC entry 2179 (class 2606 OID 20347)
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (idcliente);


--
-- TOC entry 2181 (class 2606 OID 20349)
-- Name: cuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cuenta
    ADD CONSTRAINT cuenta_pkey PRIMARY KEY (idcuenta);


--
-- TOC entry 2183 (class 2606 OID 20351)
-- Name: distrito_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY distrito
    ADD CONSTRAINT distrito_pkey PRIMARY KEY (codigo_distrito);


--
-- TOC entry 2185 (class 2606 OID 20353)
-- Name: emisor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY emisor
    ADD CONSTRAINT emisor_pkey PRIMARY KEY (emisor_numero);


--
-- TOC entry 2187 (class 2606 OID 20355)
-- Name: empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (idempleado);


--
-- TOC entry 2189 (class 2606 OID 20357)
-- Name: factura_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT factura_pkey PRIMARY KEY (idfactura);


--
-- TOC entry 2191 (class 2606 OID 20359)
-- Name: inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (idinventario);


--
-- TOC entry 2193 (class 2606 OID 20361)
-- Name: orden_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orden
    ADD CONSTRAINT orden_pkey PRIMARY KEY (idorden);


--
-- TOC entry 2195 (class 2606 OID 20363)
-- Name: periodoventa_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY periodoventa
    ADD CONSTRAINT periodoventa_pkey PRIMARY KEY (idperiodoventa);


--
-- TOC entry 2201 (class 2606 OID 20365)
-- Name: pkprovincia; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY provincia
    ADD CONSTRAINT pkprovincia PRIMARY KEY (codigo_provincia);


--
-- TOC entry 2197 (class 2606 OID 20367)
-- Name: producto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (idproducto);


--
-- TOC entry 2199 (class 2606 OID 20369)
-- Name: proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY proveedor
    ADD CONSTRAINT proveedor_pkey PRIMARY KEY (idproveedor);


--
-- TOC entry 2203 (class 2606 OID 20371)
-- Name: puesto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY puesto
    ADD CONSTRAINT puesto_pkey PRIMARY KEY (idpuesto);


--
-- TOC entry 2205 (class 2606 OID 20373)
-- Name: receptor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY receptor
    ADD CONSTRAINT receptor_pkey PRIMARY KEY (receptor_numero);


--
-- TOC entry 2225 (class 2620 OID 20374)
-- Name: update_period_bill; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_period_bill BEFORE INSERT ON factura FOR EACH ROW EXECUTE PROCEDURE update_period_bill();


--
-- TOC entry 2209 (class 2606 OID 20375)
-- Name: cuenta_idcliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cuenta
    ADD CONSTRAINT cuenta_idcliente_fkey FOREIGN KEY (idcliente) REFERENCES cliente(idcliente);


--
-- TOC entry 2211 (class 2606 OID 20380)
-- Name: empleado_idpuesto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT empleado_idpuesto_fkey FOREIGN KEY (idpuesto) REFERENCES puesto(idpuesto);


--
-- TOC entry 2212 (class 2606 OID 20385)
-- Name: factura_idcuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT factura_idcuenta_fkey FOREIGN KEY (idcuenta) REFERENCES cuenta(idcuenta);


--
-- TOC entry 2213 (class 2606 OID 20390)
-- Name: factura_idempleado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT factura_idempleado_fkey FOREIGN KEY (idempleado) REFERENCES empleado(idempleado);


--
-- TOC entry 2214 (class 2606 OID 20395)
-- Name: factura_idperiodoventa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT factura_idperiodoventa_fkey FOREIGN KEY (idperiodoventa) REFERENCES periodoventa(idperiodoventa);


--
-- TOC entry 2206 (class 2606 OID 20400)
-- Name: fkcanton; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY canton
    ADD CONSTRAINT fkcanton FOREIGN KEY (codigo_provincia) REFERENCES provincia(codigo_provincia);


--
-- TOC entry 2207 (class 2606 OID 20405)
-- Name: fkcliente_is_receptor_cliente; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cliente_is_receptor
    ADD CONSTRAINT fkcliente_is_receptor_cliente FOREIGN KEY (idcliente) REFERENCES cliente(idcliente);


--
-- TOC entry 2208 (class 2606 OID 20410)
-- Name: fkcliente_is_receptor_receptor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cliente_is_receptor
    ADD CONSTRAINT fkcliente_is_receptor_receptor FOREIGN KEY (idreceptor) REFERENCES receptor(receptor_numero);


--
-- TOC entry 2210 (class 2606 OID 20415)
-- Name: fkdistrito; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY distrito
    ADD CONSTRAINT fkdistrito FOREIGN KEY (codigo_canton) REFERENCES canton(codigo_canton);


--
-- TOC entry 2215 (class 2606 OID 20420)
-- Name: inventario_idcategoriainventario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inventario
    ADD CONSTRAINT inventario_idcategoriainventario_fkey FOREIGN KEY (idcategoriainventario) REFERENCES categoriainventario(idcategoriainventario);


--
-- TOC entry 2216 (class 2606 OID 20425)
-- Name: inventarioproducto_idinventario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inventarioproducto
    ADD CONSTRAINT inventarioproducto_idinventario_fkey FOREIGN KEY (idinventario) REFERENCES inventario(idinventario);


--
-- TOC entry 2217 (class 2606 OID 20430)
-- Name: inventarioproducto_idproducto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inventarioproducto
    ADD CONSTRAINT inventarioproducto_idproducto_fkey FOREIGN KEY (idproducto) REFERENCES producto(idproducto);


--
-- TOC entry 2218 (class 2606 OID 20435)
-- Name: orden_idcuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orden
    ADD CONSTRAINT orden_idcuenta_fkey FOREIGN KEY (idcuenta) REFERENCES cuenta(idcuenta);


--
-- TOC entry 2219 (class 2606 OID 20440)
-- Name: orden_idfactura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orden
    ADD CONSTRAINT orden_idfactura_fkey FOREIGN KEY (idfactura) REFERENCES factura(idfactura);


--
-- TOC entry 2220 (class 2606 OID 20445)
-- Name: orden_idproducto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orden
    ADD CONSTRAINT orden_idproducto_fkey FOREIGN KEY (idproducto) REFERENCES producto(idproducto);


--
-- TOC entry 2221 (class 2606 OID 20450)
-- Name: periodoventa_idempleado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY periodoventa
    ADD CONSTRAINT periodoventa_idempleado_fkey FOREIGN KEY (idempleado) REFERENCES empleado(idempleado);


--
-- TOC entry 2222 (class 2606 OID 20455)
-- Name: producto_idcategoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY producto
    ADD CONSTRAINT producto_idcategoria_fkey FOREIGN KEY (idcategoria) REFERENCES categoria(idcategoria);


--
-- TOC entry 2223 (class 2606 OID 20460)
-- Name: proveedorinventario_idinventario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY proveedorinventario
    ADD CONSTRAINT proveedorinventario_idinventario_fkey FOREIGN KEY (idinventario) REFERENCES inventario(idinventario);


--
-- TOC entry 2224 (class 2606 OID 20465)
-- Name: proveedorinventario_idproveedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY proveedorinventario
    ADD CONSTRAINT proveedorinventario_idproveedor_fkey FOREIGN KEY (idproveedor) REFERENCES proveedor(idproveedor);


-- Completed on 2018-08-29 22:43:55

--
-- PostgreSQL database dump complete
--

