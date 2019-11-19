--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

-- Started on 2018-07-25 15:27:49

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2290 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 207 (class 1259 OID 18495)
-- Name: canton; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE canton (
    codigo_canton numeric(3,0) NOT NULL,
    codigo_provincia numeric(2,0) NOT NULL,
    nombre_canton character varying(45) NOT NULL
);


----

--
-- TOC entry 190 (class 1259 OID 18285)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categoria (
    idcategoria integer NOT NULL,
    descripcioncategoria character(30)
);


----

--
-- TOC entry 189 (class 1259 OID 18283)
-- Name: categoria_idcategoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categoria_idcategoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


----

--
-- TOC entry 2291 (class 0 OID 0)
-- Dependencies: 189
-- Name: categoria_idcategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categoria_idcategoria_seq OWNED BY categoria.idcategoria;


--
-- TOC entry 194 (class 1259 OID 18307)
-- Name: categoriainventario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categoriainventario (
    idcategoriainventario integer NOT NULL,
    descripcioncategoriainventario character(30)
);


----

--
-- TOC entry 193 (class 1259 OID 18305)
-- Name: categoriainventario_idcategoriainventario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categoriainventario_idcategoriainventario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


----

--
-- TOC entry 2292 (class 0 OID 0)
-- Dependencies: 193
-- Name: categoriainventario_idcategoriainventario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categoriainventario_idcategoriainventario_seq OWNED BY categoriainventario.idcategoriainventario;


--
-- TOC entry 182 (class 1259 OID 18240)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cliente (
    idcliente integer NOT NULL,
    identificacioncliente character(100),
    estadocliente smallint DEFAULT 1
);


----

--
-- TOC entry 181 (class 1259 OID 18238)
-- Name: cliente_idcliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cliente_idcliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


----

--
-- TOC entry 2293 (class 0 OID 0)
-- Dependencies: 181
-- Name: cliente_idcliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cliente_idcliente_seq OWNED BY cliente.idcliente;


--
-- TOC entry 188 (class 1259 OID 18271)
-- Name: cuenta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cuenta (
    idcuenta integer NOT NULL,
    idcliente integer,
    fechaaperturacuenta timestamp without time zone DEFAULT now(),
    estadocuenta character(30)
);


----

--
-- TOC entry 187 (class 1259 OID 18269)
-- Name: cuenta_idcuenta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cuenta_idcuenta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


----

--
-- TOC entry 2294 (class 0 OID 0)
-- Dependencies: 187
-- Name: cuenta_idcuenta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cuenta_idcuenta_seq OWNED BY cuenta.idcuenta;


--
-- TOC entry 208 (class 1259 OID 18505)
-- Name: distrito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE distrito (
    codigo_distrito integer NOT NULL,
    codigo_canton integer NOT NULL,
    nombre_distrito character varying(45) NOT NULL
);


----

--
-- TOC entry 200 (class 1259 OID 18355)
-- Name: emisor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE emisor (
    nombre character varying(80) NOT NULL,
    emisor_tipo_identificacion character varying(2) NOT NULL,
    emisor_numero character varying(12) NOT NULL,
    nombrecomercial character varying(80),
    provincia character varying(1) NOT NULL,
    canton character varying(2) NOT NULL,
    distrito character varying(2) NOT NULL,
    otras_senas text,
    emisor_telefono_codigopais numeric(3,0),
    emisor_telefono_numtelefono numeric(20,0),
    emisor_fax_codigopais numeric(3,0),
    emisor_fax_numtelefono numeric(20,0),
    correoelectronico character varying(60)
);


----

--
-- TOC entry 186 (class 1259 OID 18257)
-- Name: empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE empleado (
    idempleado integer NOT NULL,
    nombreempleado character(50),
    apellidoempleado character(50),
    passwordempleado character(50),
    idpuesto integer NOT NULL,
    estadoempleado smallint DEFAULT 1
);


----

--
-- TOC entry 185 (class 1259 OID 18255)
-- Name: empleado_idempleado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE empleado_idempleado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


----

--
-- TOC entry 2295 (class 0 OID 0)
-- Dependencies: 185
-- Name: empleado_idempleado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE empleado_idempleado_seq OWNED BY empleado.idempleado;


--
-- TOC entry 203 (class 1259 OID 18374)
-- Name: factura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE factura (
    idfactura integer NOT NULL,
    idcuenta integer,
    idempleado integer,
    idperiodoventa integer,
    clave character varying(50) NOT NULL,
    factura_numeroconsecutivo character varying(20) NOT NULL,
    fechaemision timestamp without time zone DEFAULT now() NOT NULL,
    emisor_numero character varying(12) NOT NULL,
    receptor_numero character varying(12) NOT NULL,
    condicionventa character varying(2) NOT NULL,
    plazocredito character varying(10),
    mediopago character varying(2) NOT NULL,
    lineadetalle_numerolinea integer NOT NULL,
    tipo_codigo character varying(2),
    codigo character varying(20),
    cantidad numeric(16,3),
    unidadmedia character varying(15),
    unidadmediacomercial character varying(20),
    detalle text,
    preciounitario numeric(18,5),
    montototal numeric(18,5),
    montodescuento numeric(18,5),
    naturalezadescuento character varying(80),
    subtotal numeric(18,5),
    impuesto_codigo character varying(2),
    impuesto_tarifa numeric(4,2),
    impuesto_monto numeric(18,5),
    exoneracion_tipodocumento character varying(2),
    exoneracion_numerodocumento character varying(17),
    exoneracion_nombreinstitucion character varying(100),
    exoneracion_fechaemision timestamp without time zone,
    exoneracion_montoimpuesto numeric(18,5),
    exoneracion_porcentajecompra numeric(3,0),
    montototallinea numeric(18,5),
    resumenfactura_codigomoneda character varying(3),
    resumenfactura_tipocambio numeric(18,2),
    resumenfactura_totalservexentos numeric(18,2),
    resumenfactura_totalmercanciasgrabadas numeric(18,2),
    resumenfactura_totalmercanciasexternas numeric(18,2),
    resumenfactura_totalgravado numeric(18,2),
    resumenfactura_totalexento numeric(18,2),
    resumenfactura_totalventa numeric(18,2),
    resumenfactura_totaldescuentos numeric(18,2),
    resumenfactura_totalventaneta numeric(18,2),
    resumenfactura_totalimpuesto numeric(18,2),
    resumenfactura_totalcomprobante numeric(18,2),
    informacionreferencia_tipodoc character varying(2),
    informacionreferencia_numero character varying(50),
    informacionreferencia_fechaemision timestamp without time zone DEFAULT now(),
    informacionreferencia_codigo character varying(2),
    informacionreferencia_razon character varying(180),
    normativa_numeroresolucion character varying(13),
    normativa_fecharesolucion character varying(20),
    otros_otrotexto text,
    otros_otrocontenido text,
    ds_signature_clave_factura character varying(50),
    ds_signature_numerocedulaemisor numeric(12,0),
    ds_signature_fechaemisiondoc timestamp without time zone,
    ds_signature_mensaje numeric(1,0),
    ds_signature_detallemensaje character varying(80),
    ds_signature_montototalimpuesto numeric(18,5),
    ds_signature_totalfaactura numeric(18,5),
    ds_signature_numerocedulareceptor numeric(12,0),
    ds_signature_numconsecutivoreceptor character varying(20),
    ds_signature_firmaelectronica character varying,
    clave_comprobante character varying(50),
    nombreemisor_comprobante character varying(80),
    tipoidentificacioemisor character varying(2),
    numerocedulaemisor_comprobante numeric(12,0),
    nombrereceptor_comprobante character varying(80),
    tipoidentificacioreceptor character varying(2),
    numerocedulareceptor_comprobante numeric(12,0),
    mensaje_comprobante numeric(1,0),
    detallemensaje_comprobante text,
    montototalimpuesto_comprobante numeric(18,5),
    totalfactura_comprobante numeric(18,5),
    ds_signature_firmaelectronicacomprobante character varying
);


----

--
-- TOC entry 202 (class 1259 OID 18372)
-- Name: factura_idfactura_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE factura_idfactura_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


----

--
-- TOC entry 2296 (class 0 OID 0)
-- Dependencies: 202
-- Name: factura_idfactura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE factura_idfactura_seq OWNED BY factura.idfactura;


--
-- TOC entry 196 (class 1259 OID 18315)
-- Name: inventario; Type: TABLE; Schema: public; Owner: postgres
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


----

--
-- TOC entry 195 (class 1259 OID 18313)
-- Name: inventario_idinventario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE inventario_idinventario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


----

--
-- TOC entry 2297 (class 0 OID 0)
-- Dependencies: 195
-- Name: inventario_idinventario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE inventario_idinventario_seq OWNED BY inventario.idinventario;


--
-- TOC entry 197 (class 1259 OID 18327)
-- Name: inventarioproducto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE inventarioproducto (
    idinventario integer,
    idproducto integer,
    cantidadnecesaria numeric(8,2)
);


----

--
-- TOC entry 205 (class 1259 OID 18412)
-- Name: orden; Type: TABLE; Schema: public; Owner: postgres
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
    descuentoorden numeric(4,2) DEFAULT 0
);


----

--
-- TOC entry 204 (class 1259 OID 18410)
-- Name: orden_idorden_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE orden_idorden_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


----

--
-- TOC entry 2298 (class 0 OID 0)
-- Dependencies: 204
-- Name: orden_idorden_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE orden_idorden_seq OWNED BY orden.idorden;


--
-- TOC entry 199 (class 1259 OID 18342)
-- Name: periodoventa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE periodoventa (
    idperiodoventa integer NOT NULL,
    nombreperiodoventa character(50),
    estadoperiodoventa character(10) DEFAULT 'Activo'::bpchar,
    fechainicioperiodoventa timestamp without time zone DEFAULT now(),
    fechafinperiodoventa timestamp without time zone,
    idempleado integer
);


----

--
-- TOC entry 198 (class 1259 OID 18340)
-- Name: periodoventa_idperiodoventa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE periodoventa_idperiodoventa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


----

--
-- TOC entry 2299 (class 0 OID 0)
-- Dependencies: 198
-- Name: periodoventa_idperiodoventa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE periodoventa_idperiodoventa_seq OWNED BY periodoventa.idperiodoventa;


--
-- TOC entry 192 (class 1259 OID 18293)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE producto (
    idproducto integer NOT NULL,
    descripcionproducto character(50),
    idcategoria integer,
    precioproducto integer,
    codigobarraproducto character(50),
    estadoproducto smallint DEFAULT 1
);


----

--
-- TOC entry 191 (class 1259 OID 18291)
-- Name: producto_idproducto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE producto_idproducto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


----

--
-- TOC entry 2300 (class 0 OID 0)
-- Dependencies: 191
-- Name: producto_idproducto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE producto_idproducto_seq OWNED BY producto.idproducto;


--
-- TOC entry 206 (class 1259 OID 18490)
-- Name: provincia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE provincia (
    codigo_provincia numeric(1,0) NOT NULL,
    nombre_provincia character varying(20) NOT NULL
);


----

--
-- TOC entry 184 (class 1259 OID 18249)
-- Name: puesto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE puesto (
    idpuesto integer NOT NULL,
    descripcionpuesto character(50),
    departamentopuesto character(50)
);


----

--
-- TOC entry 183 (class 1259 OID 18247)
-- Name: puesto_idpuesto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE puesto_idpuesto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


----

--
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 183
-- Name: puesto_idpuesto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE puesto_idpuesto_seq OWNED BY puesto.idpuesto;


--
-- TOC entry 201 (class 1259 OID 18363)
-- Name: receptor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE receptor (
    nombre character varying(80) NOT NULL,
    receptor_tipo_identificacion character varying(2) NOT NULL,
    receptor_numero character varying(12) NOT NULL,
    identificacionextranjero character varying(20),
    nombrecomercial character varying(80),
    provincia INTEGER,
    canton INTEGER,
    distrito INTEGER,
    otras_senas text,
    receptor_telefono_codigopais numeric(3,0),
    receptor_telefono_numtelefono numeric(20,0),
    receptor_fax_codigopais numeric(3,0),
    receptor_fax_numtelefono numeric(20,0),
    correoelectronico character varying(60),
    estado boolean DEFAULT true
);

----

--
-- TOC entry 2075 (class 2604 OID 18288)
-- Name: idcategoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria ALTER COLUMN idcategoria SET DEFAULT nextval('categoria_idcategoria_seq'::regclass);


--
-- TOC entry 2078 (class 2604 OID 18310)
-- Name: idcategoriainventario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoriainventario ALTER COLUMN idcategoriainventario SET DEFAULT nextval('categoriainventario_idcategoriainventario_seq'::regclass);


--
-- TOC entry 2068 (class 2604 OID 18243)
-- Name: idcliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cliente ALTER COLUMN idcliente SET DEFAULT nextval('cliente_idcliente_seq'::regclass);


--
-- TOC entry 2073 (class 2604 OID 18274)
-- Name: idcuenta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cuenta ALTER COLUMN idcuenta SET DEFAULT nextval('cuenta_idcuenta_seq'::regclass);


--
-- TOC entry 2071 (class 2604 OID 18260)
-- Name: idempleado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY empleado ALTER COLUMN idempleado SET DEFAULT nextval('empleado_idempleado_seq'::regclass);


--
-- TOC entry 2085 (class 2604 OID 18377)
-- Name: idfactura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura ALTER COLUMN idfactura SET DEFAULT nextval('factura_idfactura_seq'::regclass);


--
-- TOC entry 2079 (class 2604 OID 18318)
-- Name: idinventario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inventario ALTER COLUMN idinventario SET DEFAULT nextval('inventario_idinventario_seq'::regclass);


--
-- TOC entry 2088 (class 2604 OID 18415)
-- Name: idorden; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orden ALTER COLUMN idorden SET DEFAULT nextval('orden_idorden_seq'::regclass);


--
-- TOC entry 2081 (class 2604 OID 18345)
-- Name: idperiodoventa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY periodoventa ALTER COLUMN idperiodoventa SET DEFAULT nextval('periodoventa_idperiodoventa_seq'::regclass);


--
-- TOC entry 2076 (class 2604 OID 18296)
-- Name: idproducto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY producto ALTER COLUMN idproducto SET DEFAULT nextval('producto_idproducto_seq'::regclass);


--
-- TOC entry 2070 (class 2604 OID 18252)
-- Name: idpuesto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY puesto ALTER COLUMN idpuesto SET DEFAULT nextval('puesto_idpuesto_seq'::regclass);


--
-- TOC entry 2281 (class 0 OID 18495)
-- Dependencies: 207
-- Data for Name: canton; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (101, 1, 'San Jos‚');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (102, 1, 'Escaz£');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (103, 1, 'Desamparados');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (104, 1, 'Puriscal');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (105, 1, 'Tarraz£');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (106, 1, 'Aserr¡');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (107, 1, 'Mora');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (108, 1, 'Goicoechea');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (109, 1, 'Santa Ana');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (110, 1, 'Alajuelita');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (111, 1, 'Vasquez de Coronado');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (112, 1, 'Acosta');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (113, 1, 'Tib s');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (114, 1, 'Moravia');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (115, 1, 'Montes de Oca');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (116, 1, 'Turrubares');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (117, 1, 'Dota');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (118, 1, 'Curridabat');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (119, 1, 'P‚rez Zeled¢n');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (120, 1, 'Le¢n Cort‚s');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (201, 2, 'Alajuela');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (202, 2, 'San Ram¢n');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (203, 2, 'Grecia');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (204, 2, 'San Mateo');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (205, 2, 'Atenas');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (206, 2, 'Naranjo');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (207, 2, 'Palmares');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (208, 2, 'Po s');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (209, 2, 'Orotina');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (210, 2, 'San Carlos');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (211, 2, 'Alfaro Ruiz');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (212, 2, 'Valverde Vega');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (213, 2, 'Upala');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (214, 2, 'Los Chiles');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (215, 2, 'Guatuso');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (301, 3, 'Cartago');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (302, 3, 'Para¡so');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (303, 3, 'La Uni¢n');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (304, 3, 'Jim‚nez');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (305, 3, 'Turrialba');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (306, 3, 'Alvarado');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (307, 3, 'Oreamuno');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (308, 3, 'El Guarco');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (401, 4, 'Heredia');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (402, 4, 'Barva');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (403, 4, 'Santo Domingo');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (404, 4, 'Santa B rbara');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (405, 4, 'San Rafael');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (406, 4, 'San Isidro');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (407, 4, 'Bel‚n');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (408, 4, 'Flores');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (409, 4, 'San Pablo');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (410, 4, 'Sarapiqu¡ ');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (501, 5, 'Liberia');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (502, 5, 'Nicoya');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (503, 5, 'Santa Cruz');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (504, 5, 'Bagaces');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (505, 5, 'Carrillo');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (506, 5, 'Ca¤as');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (507, 5, 'Abangares');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (508, 5, 'Tilar n');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (509, 5, 'Nandayure');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (510, 5, 'La Cruz');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (511, 5, 'Hojancha');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (601, 6, 'Puntarenas');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (602, 6, 'Esparza');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (603, 6, 'Buenos Aires');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (604, 6, 'Montes de Oro');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (605, 6, 'Osa');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (606, 6, 'Aguirre');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (607, 6, 'Golfito');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (608, 6, 'Coto Brus');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (609, 6, 'Parrita');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (610, 6, 'Corredores');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (611, 6, 'Garabito');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (701, 7, 'Lim¢n');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (702, 7, 'Pococ¡');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (703, 7, 'Siquirres ');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (704, 7, 'Talamanca');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (705, 7, 'Matina');
INSERT INTO canton (codigo_canton, codigo_provincia, nombre_canton) VALUES (706, 7, 'Gu cimo');


--
-- TOC entry 2264 (class 0 OID 18285)
-- Dependencies: 190
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 189
-- Name: categoria_idcategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categoria_idcategoria_seq', 1, false);


--
-- TOC entry 2268 (class 0 OID 18307)
-- Dependencies: 194
-- Data for Name: categoriainventario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 193
-- Name: categoriainventario_idcategoriainventario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categoriainventario_idcategoriainventario_seq', 1, false);


--
-- TOC entry 2256 (class 0 OID 18240)
-- Dependencies: 182
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 181
-- Name: cliente_idcliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cliente_idcliente_seq', 1, false);


--
-- TOC entry 2262 (class 0 OID 18271)
-- Dependencies: 188
-- Data for Name: cuenta; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 187
-- Name: cuenta_idcuenta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cuenta_idcuenta_seq', 1, false);


--
-- TOC entry 2282 (class 0 OID 18505)
-- Dependencies: 208
-- Data for Name: distrito; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10101, 101, 'Carmen');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10102, 101, 'Merced');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10103, 101, 'Hospital');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10104, 101, 'Catedral');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10105, 101, 'Zapote');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10106, 101, 'San Francisco de Dos R¡os');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10107, 101, 'Uruca');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10108, 101, 'Mata Redonda');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10109, 101, 'Pavas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10110, 101, 'Hatillo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10111, 101, 'San Sebasti n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10201, 102, 'Escaz£');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10202, 102, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10203, 102, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10301, 103, 'Desamparados');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10302, 103, 'San Miguel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10303, 103, 'San Juan de Dios');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10304, 103, 'San Rafael Arriba');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10305, 103, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10306, 103, 'Frailes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10307, 103, 'Patarr ');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10308, 103, 'San Crist¢bal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10309, 103, 'Rosario');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10310, 103, 'Damas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10311, 103, 'San Rafael Abajo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10312, 103, 'Gravilias');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10313, 103, 'Los Guido');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10401, 104, 'Santiago');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10402, 104, 'Mercedes Sur');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10403, 104, 'Barbacoas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10404, 104, 'Grifo Alto');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10405, 104, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10406, 104, 'Candelaria');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10407, 104, 'Desamparaditos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10408, 104, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10409, 104, 'Chires');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10501, 105, 'San Marcos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10502, 105, 'San Lorenzo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10503, 105, 'San Carlos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10601, 106, 'Aserr¡');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10602, 106, 'Tarbaca o Praga');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10603, 106, 'Vuelta de Jorco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10604, 106, 'San Gabriel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10605, 106, 'La Legua');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10606, 106, 'Monterrey');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10607, 106, 'Salitrillos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10701, 107, 'Col¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10702, 107, 'Guayabo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10703, 107, 'Tabarcia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10704, 107, 'Piedras Negras');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10705, 107, 'Picagres');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10801, 108, 'Guadalupe');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10802, 108, 'San Francisco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10803, 108, 'Calle Blancos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10804, 108, 'Mata de Pl tano');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10805, 108, 'Ip¡s');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10806, 108, 'Rancho Redondo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10807, 108, 'Purral');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10901, 109, 'Santa Ana');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10902, 109, 'Salitral');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10903, 109, 'Pozos o Concepci¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10904, 109, 'Uruca o San Joaqu¡n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10905, 109, 'Piedades');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (10906, 109, 'Brasil');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11001, 110, 'Alajuelita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11002, 110, 'San Josecito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11003, 110, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11004, 110, 'Concepci¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11005, 110, 'San Felipe');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11101, 111, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11102, 111, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11103, 111, 'Dulce Nombre de Jes£s');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11104, 111, 'Patalillo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11105, 111, 'Cascajal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11201, 112, 'San Ignacio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11202, 112, 'Guaitil');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11203, 112, 'Palmichal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11204, 112, 'Cangrejal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11205, 112, 'Sabanillas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11301, 113, 'San Juan');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11302, 113, 'Cinco Esquinas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11303, 113, 'Anselmo Llorente');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11304, 113, 'Le¢n XIII');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11305, 113, 'Colima');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11401, 114, 'San Vicente');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11402, 114, 'San Jer¢nimo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11403, 114, 'Trinidad');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11501, 115, 'San Pedro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11502, 115, 'Sabanilla');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11503, 115, 'Mercedes o Betania');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11504, 115, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11601, 116, 'San Pablo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11602, 116, 'San Pedro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11603, 116, 'San Juan de Mata');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11604, 116, 'San Luis');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11605, 116, 'C rara');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11701, 117, 'Santa Mar¡a');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11702, 117, 'Jard¡n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11703, 117, 'Copey');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11801, 118, 'Curridabat');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11802, 118, 'Granadilla');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11803, 118, 'S nchez');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11804, 118, 'Tirrases');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11901, 119, 'San Isidro de el General');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11902, 119, 'General');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11903, 119, 'Daniel Flores');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11904, 119, 'Rivas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11905, 119, 'San Pedro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11906, 119, 'Platanares');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11907, 119, 'Pejibaye');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11908, 119, 'Caj¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11909, 119, 'Bar£');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11910, 119, 'R¡o Nuevo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (11911, 119, 'P ramo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (12001, 120, 'San Pablo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (12002, 120, 'San Andr‚s');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (12003, 120, 'Llano Bonito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (12004, 120, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (12005, 120, 'Santa Cruz');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (12006, 120, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20101, 201, 'Alajuela');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20102, 201, 'San Jos‚');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20103, 201, 'Carrizal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20104, 201, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20105, 201, 'Gu cima');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20106, 201, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20107, 201, 'Sabanilla');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20108, 201, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20109, 201, 'R¡o Segundo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20110, 201, 'Desamparados');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20111, 201, 'Turrucares');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20112, 201, 'Tambor');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20113, 201, 'La Garita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20114, 201, 'Sarapiqu¡');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20201, 202, 'San Ram¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20202, 202, 'Santiago');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20203, 202, 'San Juan');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20204, 202, 'Piedades Norte');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20205, 202, 'Piedades Sur');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20206, 202, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20207, 202, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20208, 202, 'Angeles');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20209, 202, 'Alfaro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20210, 202, 'Volio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20211, 202, 'Concepci¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20212, 202, 'Zapotal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20213, 202, 'San Isidro de Pe¤as Blancas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20301, 203, 'Grecia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20302, 203, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20303, 203, 'San Jos‚');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20304, 203, 'San Roque');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20305, 203, 'Tacares');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20306, 203, 'R¡o Cuarto');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20307, 203, 'Puente Piedra');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20308, 203, 'Bol¡var');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20401, 204, 'San Mateo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20402, 204, 'Desmonte');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20403, 204, 'Jes£s Mar¡a');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20501, 205, 'Atenas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20502, 205, 'Jes£s');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20503, 205, 'Mercedes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20504, 205, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20505, 205, 'Concepci¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20506, 205, 'San Jos‚');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20507, 205, 'Santa Eulalia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20508, 205, 'Escobal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20601, 206, 'Naranjo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20602, 206, 'San Miguel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20603, 206, 'San Jos‚');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20604, 206, 'Cirr¡ Sur');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20605, 206, 'San Jer¢nimo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20606, 206, 'San Juan');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20607, 206, 'Rosario');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20701, 207, 'Palmares');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20702, 207, 'Zaragoza');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20703, 207, 'Buenos Aires');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20704, 207, 'Santiago');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20705, 207, 'Candelaria');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20706, 207, 'Esquipulas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20707, 207, 'La Granja');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20801, 208, 'San Pedro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20802, 208, 'San Juan');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20803, 208, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20804, 208, 'Carrillos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20805, 208, 'Sabana Redonda');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20901, 209, 'Orotina');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20902, 209, 'Mastate');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20903, 209, 'Hacienda Vieja');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20904, 209, 'Coyolar');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (20905, 209, 'Ceiba');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21001, 210, 'Quesada');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21002, 210, 'Florencia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21003, 210, 'Buenavista');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21004, 210, 'Aguas Zarcas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21005, 210, 'Venecia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21006, 210, 'Pital');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21007, 210, 'Fortuna');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21008, 210, 'Tigra');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21009, 210, 'Palmera');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21010, 210, 'Venado');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21011, 210, 'Cutris');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21012, 210, 'Monterrey');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21013, 210, 'Pocosol');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21101, 211, 'Zarcero');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21102, 211, 'Laguna');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21103, 211, 'Tapezco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21104, 211, 'Guadalupe');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21105, 211, 'Palmira');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21106, 211, 'Zapote');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21107, 211, 'Las Brisas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21201, 212, 'Sarch¡ Norte');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21202, 212, 'Sarch¡ Sur');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21203, 212, 'Toro Amarillo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21204, 212, 'San Pedro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21205, 212, 'Rodr¡guez');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21301, 213, 'Upala');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21302, 213, 'Aguas Claras');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21303, 213, 'San Jos‚ o Pizote');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21304, 213, 'Bijagua');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21305, 213, 'Delicias');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21306, 213, 'Dos R¡os');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21307, 213, 'Yolillal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21401, 214, 'Los Chiles');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21402, 214, 'Ca¤o Negro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21403, 214, 'Amparo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21404, 214, 'San Jorge');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21501, 215, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21502, 215, 'Buenavista');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (21503, 215, 'Cote');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30101, 301, 'Oriental');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30102, 301, 'Occidental');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30103, 301, 'Carmen');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30104, 301, 'San Nicol s');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30105, 301, 'Aguacaliente o San Francisco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30106, 301, 'Guadalupe o Arenilla');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30107, 301, 'Corralillo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30108, 301, 'Tierra Blanca');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30109, 301, 'Dulce Nombre');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30110, 301, 'Llano Grande');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30111, 301, 'Quebradilla');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30201, 302, 'Para¡so');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30202, 302, 'Santiago');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30203, 302, 'Orosi');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30204, 302, 'Cach¡');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30205, 302, 'Los Llanos de Santa Luc¡a');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30301, 303, 'Tres R¡os');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30302, 303, 'San Diego');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30303, 303, 'San Juan');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30304, 303, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30305, 303, 'Concepci¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30306, 303, 'Dulce Nombre');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30307, 303, 'San Ram¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30308, 303, 'R¡o Azul');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30401, 304, 'Juan Vi¤as');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30402, 304, 'Tucurrique');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30403, 304, 'Pejibaye');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30501, 305, 'Turrialba');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30502, 305, 'La Suiza');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30503, 305, 'Peralta');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30504, 305, 'Santa Cruz');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30505, 305, 'Santa Teresita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30506, 305, 'Pavones');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30507, 305, 'Tuis');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30508, 305, 'Tayutic');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30509, 305, 'Santa Rosa');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30510, 305, 'Tres Equis');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30511, 305, 'La Isabel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30512, 305, 'Chirrip¢');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30601, 306, 'Pacayas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30602, 306, 'Cervantes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30603, 306, 'Capellades');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30701, 307, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30702, 307, 'Cot');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30703, 307, 'Potrero Cerrado');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30704, 307, 'Cipreses');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30705, 307, 'Santa Rosa');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30801, 308, 'El Tejar');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30802, 308, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30803, 308, 'Tobosi');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (30804, 308, 'Patio de Agua');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40101, 401, 'Heredia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40102, 401, 'Mercedes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40103, 401, 'San Francisco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40104, 401, 'Ulloa');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40105, 401, 'Varablanca');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40201, 402, 'Barva');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40202, 402, 'San Pedro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40203, 402, 'San Pablo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40204, 402, 'San Roque');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40205, 402, 'Santa Luc¡a');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40206, 402, 'San Jos‚ de la Monta¤a');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40301, 403, 'Santo Domingo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40302, 403, 'San Vicente');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40303, 403, 'San Miguel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40304, 403, 'Paracito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40305, 403, 'Santo Tom s');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40306, 403, 'Santa Rosa');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40307, 403, 'Tures');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40308, 403, 'Par ');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40401, 404, 'Santa B rbara');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40402, 404, 'San Pedro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40403, 404, 'San Juan');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40404, 404, 'Jes£s');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40405, 404, 'Santo Domingo del Roble');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40406, 404, 'Puraba');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40501, 405, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40502, 405, 'San Josecito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40503, 405, 'Santiago');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40504, 405, 'Angeles');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40505, 405, 'Concepci¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40601, 406, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40602, 406, 'San Jos‚');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40603, 406, 'Concepci¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40604, 406, 'San Francisco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40701, 407, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40702, 407, 'La Ribera');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40703, 407, 'Asunci¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40801, 408, 'San Joaqu¡n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40802, 408, 'Barrantes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40803, 408, 'Llorente');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (40901, 409, 'San Pablo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (41001, 410, 'Puerto Viejo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (41002, 410, 'La Virgen');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (41003, 410, 'Horquetas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (41004, 410, 'Llanuras de Gaspar');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (41005, 410, 'Cure¤a');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50101, 501, 'Liberia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50102, 501, 'Ca¤as Dulces');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50103, 501, 'Mayorga');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50104, 501, 'Nacascolo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50105, 501, 'Curubande');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50201, 502, 'Nicoya');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50202, 502, 'Mansi¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50203, 502, 'San Antonio');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50204, 502, 'Quebrada Honda');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50205, 502, 'S mara');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50206, 502, 'N¢sara');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50207, 502, 'Bel‚n de Nosarita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50301, 503, 'Santa Cruz');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50302, 503, 'Bols¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50303, 503, 'Veintisiete de Abril');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50304, 503, 'Tempate');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50305, 503, 'Cartagena');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50306, 503, 'Cuajiniquil');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50307, 503, 'Diri ');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50308, 503, 'Cabo Velas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50309, 503, 'Tamarindo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50401, 504, 'Bagaces');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50402, 504, 'Fortuna');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50403, 504, 'Mogote');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50404, 504, 'R¡o Naranjo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50501, 505, 'Filadelfia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50502, 505, 'Palmira');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50503, 505, 'Sardinal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50504, 505, 'Bel‚n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50601, 506, 'Ca¤as');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50602, 506, 'Palmira');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50603, 506, 'San Miguel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50604, 506, 'Bebedero');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50605, 506, 'Porozal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50701, 507, 'Juntas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50702, 507, 'Sierra');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50703, 507, 'San Juan');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50704, 507, 'Colorado');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50801, 508, 'Tilar n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50802, 508, 'Quebrada Grande');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50803, 508, 'Tronadora');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50804, 508, 'Santa Rosa');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50805, 508, 'L¡bano');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50806, 508, 'Tierras Morenas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50807, 508, 'Arenal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50901, 509, 'Carmona');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50902, 509, 'Santa Rita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50903, 509, 'Zapotal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50904, 509, 'San Pablo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50905, 509, 'Porvenir');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (50906, 509, 'Bejuco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (51001, 510, 'La Cruz');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (51002, 510, 'Santa Cecilia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (51003, 510, 'Garita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (51004, 510, 'Santa Elena');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (51101, 511, 'Hojancha');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (51102, 511, 'Monte Romo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (51103, 511, 'Puerto Carrillo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (51104, 511, 'Huacas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60101, 601, 'Puntarenas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60102, 601, 'Pitahaya');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60103, 601, 'Chomes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60104, 601, 'Lepanto');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60105, 601, 'Paquera');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60106, 601, 'Manzanillo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60107, 601, 'Guacimal');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60108, 601, 'Barranca');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60109, 601, 'Monte Verde');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60110, 601, 'Isla del Coco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60111, 601, 'C¢bano');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60112, 601, 'Chacarita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60113, 601, 'Chira');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60114, 601, 'Acapulco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60115, 601, 'Roble');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60116, 601, 'Arancibia');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60201, 602, 'Esp¡ritu Santo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60202, 602, 'San Juan Grande');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60203, 602, 'Macacona');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60204, 602, 'San Rafael');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60205, 602, 'San Jer¢nimo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60301, 603, 'Buenos Aires');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60302, 603, 'Volc n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60303, 603, 'Potrero Grande');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60304, 603, 'Boruca');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60305, 603, 'Pilas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60306, 603, 'Colinas o Bajo de Ma¡z');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60307, 603, 'Ch nguena');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60308, 603, 'Bioley');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60309, 603, 'Brunka');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60401, 604, 'Miramar');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60402, 604, 'Uni¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60403, 604, 'San Isidro');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60501, 605, 'Puerto Cort‚s');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60502, 605, 'Palmar');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60503, 605, 'Sierpe');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60504, 605, 'Bah¡a Ballena');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60505, 605, 'Piedras Blancas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60601, 606, 'Quepos');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60602, 606, 'Savegre');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60603, 606, 'Naranjito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60701, 607, 'Golfito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60702, 607, 'Puerto Jim‚nez');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60703, 607, 'Guaycar ');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60704, 607, 'Pavon');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60801, 608, 'San Vito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60802, 608, 'Sabalito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60803, 608, 'Agua Buena');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60804, 608, 'Limoncito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60805, 608, 'Pittier');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (60901, 609, 'Parrita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (61001, 610, 'Corredor');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (61002, 610, 'La Cuesta');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (61003, 610, 'Paso Canoas');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (61004, 610, 'Laurel');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (61101, 611, 'Jac¢');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (61102, 611, 'T rcoles');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70101, 701, 'Lim¢n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70102, 701, 'Valle La Estrella');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70103, 701, 'R¡o Blanco');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70104, 701, 'Matama');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70201, 702, 'Gu piles');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70202, 702, 'Jim‚nez');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70203, 702, 'Rita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70204, 702, 'Roxana');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70205, 702, 'Cariari');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70206, 702, 'Colorado');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70301, 703, 'Siquirres');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70302, 703, 'Pacuarito');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70303, 703, 'Florida');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70304, 703, 'Germania');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70305, 703, 'Cairo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70306, 703, 'Alegr¡a');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70401, 704, 'Bratsi');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70402, 704, 'Sixaola');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70403, 704, 'Cahuita');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70404, 704, 'Telire');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70501, 705, 'Matina');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70502, 705, 'Bat n');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70503, 705, 'Carrand¡');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70601, 706, 'Gu cimo');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70602, 706, 'Mercedes');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70603, 706, 'Pocora');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70604, 706, 'R¡o Jim‚nez');
INSERT INTO distrito (codigo_distrito, codigo_canton, nombre_distrito) VALUES (70605, 706, 'Duacar¡');


--
-- TOC entry 2274 (class 0 OID 18355)
-- Dependencies: 200
-- Data for Name: emisor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO emisor (nombre, emisor_tipo_identificacion, emisor_numero, nombrecomercial, provincia, canton, distrito, otras_senas, emisor_telefono_codigopais, emisor_telefono_numtelefono, emisor_fax_codigopais, emisor_fax_numtelefono, correoelectronico) VALUES ('dsfsd', 'cd', '324234', 'dssdf', '1', '2', '2', 'ddfsdfsdfsdf', 506, 4234234, 506, 324324, 'hola@hotmail.com');


--
-- TOC entry 2260 (class 0 OID 18257)
-- Dependencies: 186
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 185
-- Name: empleado_idempleado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('empleado_idempleado_seq', 1, false);


--
-- TOC entry 2277 (class 0 OID 18374)
-- Dependencies: 203
-- Data for Name: factura; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 202
-- Name: factura_idfactura_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('factura_idfactura_seq', 1, false);


--
-- TOC entry 2270 (class 0 OID 18315)
-- Dependencies: 196
-- Data for Name: inventario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 195
-- Name: inventario_idinventario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('inventario_idinventario_seq', 1, false);


--
-- TOC entry 2271 (class 0 OID 18327)
-- Dependencies: 197
-- Data for Name: inventarioproducto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2279 (class 0 OID 18412)
-- Dependencies: 205
-- Data for Name: orden; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 204
-- Name: orden_idorden_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('orden_idorden_seq', 1, false);


--
-- TOC entry 2273 (class 0 OID 18342)
-- Dependencies: 199
-- Data for Name: periodoventa; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2310 (class 0 OID 0)
-- Dependencies: 198
-- Name: periodoventa_idperiodoventa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('periodoventa_idperiodoventa_seq', 1, false);


--
-- TOC entry 2266 (class 0 OID 18293)
-- Dependencies: 192
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2311 (class 0 OID 0)
-- Dependencies: 191
-- Name: producto_idproducto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('producto_idproducto_seq', 1, false);


--
-- TOC entry 2280 (class 0 OID 18490)
-- Dependencies: 206
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO provincia (codigo_provincia, nombre_provincia) VALUES (2, 'Alajuela');
INSERT INTO provincia (codigo_provincia, nombre_provincia) VALUES (3, 'Cartago');
INSERT INTO provincia (codigo_provincia, nombre_provincia) VALUES (4, 'Heredia');
INSERT INTO provincia (codigo_provincia, nombre_provincia) VALUES (5, 'Guanacaste');
INSERT INTO provincia (codigo_provincia, nombre_provincia) VALUES (6, 'Puntarenas');
INSERT INTO provincia (codigo_provincia, nombre_provincia) VALUES (7, 'Lim¢n');
INSERT INTO provincia (codigo_provincia, nombre_provincia) VALUES (1, 'San Jose');


--
-- TOC entry 2258 (class 0 OID 18249)
-- Dependencies: 184
-- Data for Name: puesto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2312 (class 0 OID 0)
-- Dependencies: 183
-- Name: puesto_idpuesto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('puesto_idpuesto_seq', 1, false);


--
-- TOC entry 2275 (class 0 OID 18363)
-- Dependencies: 201
-- Data for Name: receptor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO receptor (nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES ('nuevo nombre ', '02', '32232332', '23423', 'sfsdf', '1', '1', '1', 'asdasdad', 211, 23433, 111, 123123, 'asadad', true);
INSERT INTO receptor (nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES ('nuevo nombre 2', '02', '32554654', '23423', 'sfsdf', '1', '1', '1', 'asdasdad', 211, 23433, 111, 123123, 'asadad', true);
INSERT INTO receptor (nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES ('nuevo nombre 6 actualizado', '03', '32554789', '23423', 'sfsdf', '1', '1', '1', 'asdasdad', 10, 23433, 111, 123123, 'asadad', false);
INSERT INTO receptor (nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES ('nuevo nombre 7 ', '03', '32554110', '23423', 'sfsdf', '1', '1', '1', 'asdasdad', 211, 23433, 111, 123123, 'asadad', true);
INSERT INTO receptor (nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES ('nuevo nombre 9', '03', '123456789', '23423', 'sfsdf', '1', '1', '1', 'asdasdad', 211, 23433, 111, 123123, 'asadad', true);
INSERT INTO receptor (nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES ('sddsfsd', '01', '00114820875', NULL, 'sdfs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'navemen23@hotmail.com', true);
INSERT INTO receptor (nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES ('34sdfsdf', '01', '01234324234', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'nvm23@hotmail.com', true);
INSERT INTO receptor (nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES ('saasasdds', '01', '01234345321', '123445887', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'navemen23@hotmail.com', true);
INSERT INTO receptor (nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES ('sdffsffds', '02', '02123456788', '123456789', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'nvm231191@hotmail.com', true);
INSERT INTO receptor (nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES ('asdasdadasad', '01', '011234566778', '2131233212', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'navemen23@hotmail.com', true);
INSERT INTO receptor (nombre, receptor_tipo_identificacion, receptor_numero, identificacionextranjero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico, estado) VALUES ('nombre1', '02', '02123456789', '123456789', NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'navemen23@hotmail.com', true);


--
-- TOC entry 2122 (class 2606 OID 18499)
-- Name: canton_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY canton
    ADD CONSTRAINT canton_pkey PRIMARY KEY (codigo_canton);


--
-- TOC entry 2102 (class 2606 OID 18290)
-- Name: categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (idcategoria);


--
-- TOC entry 2106 (class 2606 OID 18312)
-- Name: categoriainventario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoriainventario
    ADD CONSTRAINT categoriainventario_pkey PRIMARY KEY (idcategoriainventario);


--
-- TOC entry 2094 (class 2606 OID 18246)
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (idcliente);


--
-- TOC entry 2100 (class 2606 OID 18277)
-- Name: cuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cuenta
    ADD CONSTRAINT cuenta_pkey PRIMARY KEY (idcuenta);


--
-- TOC entry 2124 (class 2606 OID 18539)
-- Name: distrito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY distrito
    ADD CONSTRAINT distrito_pkey PRIMARY KEY (codigo_distrito);


--
-- TOC entry 2112 (class 2606 OID 18362)
-- Name: emisor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY emisor
    ADD CONSTRAINT emisor_pkey PRIMARY KEY (emisor_numero);


--
-- TOC entry 2098 (class 2606 OID 18263)
-- Name: empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (idempleado);


--
-- TOC entry 2116 (class 2606 OID 18384)
-- Name: factura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT factura_pkey PRIMARY KEY (clave, idfactura);


--
-- TOC entry 2108 (class 2606 OID 18321)
-- Name: inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (idinventario);


--
-- TOC entry 2118 (class 2606 OID 18421)
-- Name: orden_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orden
    ADD CONSTRAINT orden_pkey PRIMARY KEY (idorden);


--
-- TOC entry 2110 (class 2606 OID 18349)
-- Name: periodoventa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY periodoventa
    ADD CONSTRAINT periodoventa_pkey PRIMARY KEY (idperiodoventa);


--
-- TOC entry 2120 (class 2606 OID 18494)
-- Name: pkprovincia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincia
    ADD CONSTRAINT pkprovincia PRIMARY KEY (codigo_provincia);


--
-- TOC entry 2104 (class 2606 OID 18299)
-- Name: producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (idproducto);


--
-- TOC entry 2096 (class 2606 OID 18254)
-- Name: puesto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY puesto
    ADD CONSTRAINT puesto_pkey PRIMARY KEY (idpuesto);


--
-- TOC entry 2114 (class 2606 OID 18370)
-- Name: receptor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY receptor
    ADD CONSTRAINT receptor_pkey PRIMARY KEY (receptor_numero);


--
-- TOC entry 2126 (class 2606 OID 18278)
-- Name: cuenta_idcliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cuenta
    ADD CONSTRAINT cuenta_idcliente_fkey FOREIGN KEY (idcliente) REFERENCES cliente(idcliente);


--
-- TOC entry 2125 (class 2606 OID 18264)
-- Name: empleado_idpuesto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT empleado_idpuesto_fkey FOREIGN KEY (idpuesto) REFERENCES puesto(idpuesto);


--
-- TOC entry 2135 (class 2606 OID 18400)
-- Name: factura_emisor_numero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT factura_emisor_numero_fkey FOREIGN KEY (emisor_numero) REFERENCES emisor(emisor_numero);


--
-- TOC entry 2132 (class 2606 OID 18385)
-- Name: factura_idcuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT factura_idcuenta_fkey FOREIGN KEY (idcuenta) REFERENCES cuenta(idcuenta);


--
-- TOC entry 2133 (class 2606 OID 18390)
-- Name: factura_idempleado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT factura_idempleado_fkey FOREIGN KEY (idempleado) REFERENCES empleado(idempleado);


--
-- TOC entry 2134 (class 2606 OID 18395)
-- Name: factura_idperiodoventa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT factura_idperiodoventa_fkey FOREIGN KEY (idperiodoventa) REFERENCES periodoventa(idperiodoventa);


--
-- TOC entry 2136 (class 2606 OID 18405)
-- Name: factura_receptor_numero_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT factura_receptor_numero_fkey FOREIGN KEY (receptor_numero) REFERENCES receptor(receptor_numero);


--
-- TOC entry 2139 (class 2606 OID 18500)
-- Name: fkcanton; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY canton
    ADD CONSTRAINT fkcanton FOREIGN KEY (codigo_provincia) REFERENCES provincia(codigo_provincia);


--
-- TOC entry 2140 (class 2606 OID 18529)
-- Name: fkdistrito; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY distrito
    ADD CONSTRAINT fkdistrito FOREIGN KEY (codigo_canton) REFERENCES canton(codigo_canton);


--
-- TOC entry 2128 (class 2606 OID 18322)
-- Name: inventario_idcategoriainventario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inventario
    ADD CONSTRAINT inventario_idcategoriainventario_fkey FOREIGN KEY (idcategoriainventario) REFERENCES categoriainventario(idcategoriainventario);


--
-- TOC entry 2129 (class 2606 OID 18330)
-- Name: inventarioproducto_idinventario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inventarioproducto
    ADD CONSTRAINT inventarioproducto_idinventario_fkey FOREIGN KEY (idinventario) REFERENCES inventario(idinventario);


--
-- TOC entry 2130 (class 2606 OID 18335)
-- Name: inventarioproducto_idproducto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inventarioproducto
    ADD CONSTRAINT inventarioproducto_idproducto_fkey FOREIGN KEY (idproducto) REFERENCES producto(idproducto);


--
-- TOC entry 2137 (class 2606 OID 18422)
-- Name: orden_idcuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orden
    ADD CONSTRAINT orden_idcuenta_fkey FOREIGN KEY (idcuenta) REFERENCES cuenta(idcuenta);


--
-- TOC entry 2138 (class 2606 OID 18427)
-- Name: orden_idproducto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orden
    ADD CONSTRAINT orden_idproducto_fkey FOREIGN KEY (idproducto) REFERENCES producto(idproducto);


--
-- TOC entry 2131 (class 2606 OID 18350)
-- Name: periodoventa_idempleado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY periodoventa
    ADD CONSTRAINT periodoventa_idempleado_fkey FOREIGN KEY (idempleado) REFERENCES empleado(idempleado);


--
-- TOC entry 2127 (class 2606 OID 18300)
-- Name: producto_idcategoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY producto
    ADD CONSTRAINT producto_idcategoria_fkey FOREIGN KEY (idcategoria) REFERENCES categoria(idcategoria);


--
-- TOC entry 2289 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-07-25 15:27:57

--
-- PostgreSQL database dump complete
--
