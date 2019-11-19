--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

-- Started on 2018-08-02 23:59:46

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2303 (class 1262 OID 12373)
-- Dependencies: 2302
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 2 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 1 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 190 (class 1259 OID 17244)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categoria (
    idcategoria integer NOT NULL,
    descripcioncategoria character(30)
);


ALTER TABLE categoria OWNER TO imagine;

--
-- TOC entry 189 (class 1259 OID 17242)
-- Name: categoria_idcategoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categoria_idcategoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categoria_idcategoria_seq OWNER TO imagine;

--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 189
-- Name: categoria_idcategoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categoria_idcategoria_seq OWNED BY categoria.idcategoria;


--
-- TOC entry 194 (class 1259 OID 17266)
-- Name: categoriainventario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categoriainventario (
    idcategoriainventario integer NOT NULL,
    descripcioncategoriainventario character(30)
);


ALTER TABLE categoriainventario OWNER TO imagine;

--
-- TOC entry 193 (class 1259 OID 17264)
-- Name: categoriainventario_idcategoriainventario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categoriainventario_idcategoriainventario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categoriainventario_idcategoriainventario_seq OWNER TO imagine;

--
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 193
-- Name: categoriainventario_idcategoriainventario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categoriainventario_idcategoriainventario_seq OWNED BY categoriainventario.idcategoriainventario;


--
-- TOC entry 201 (class 1259 OID 18083)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cliente (
    idcliente integer NOT NULL,
    identificacioncliente character(100),
    estadocliente smallint DEFAULT 1
);


ALTER TABLE cliente OWNER TO imagine;

--
-- TOC entry 200 (class 1259 OID 18081)
-- Name: cliente_idcliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cliente_idcliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cliente_idcliente_seq OWNER TO imagine;

--
-- TOC entry 2310 (class 0 OID 0)
-- Dependencies: 200
-- Name: cliente_idcliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cliente_idcliente_seq OWNED BY cliente.idcliente;


--
-- TOC entry 188 (class 1259 OID 17235)
-- Name: cuenta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cuenta (
    idcuenta integer NOT NULL,
    idcliente integer,
    fechaaperturacuenta timestamp without time zone DEFAULT now(),
    estadocuenta character(30)
);


ALTER TABLE cuenta OWNER TO imagine;

--
-- TOC entry 187 (class 1259 OID 17233)
-- Name: cuenta_idcuenta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cuenta_idcuenta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cuenta_idcuenta_seq OWNER TO imagine;

--
-- TOC entry 2311 (class 0 OID 0)
-- Dependencies: 187
-- Name: cuenta_idcuenta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cuenta_idcuenta_seq OWNED BY cuenta.idcuenta;


--
-- TOC entry 204 (class 1259 OID 18169)
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


ALTER TABLE emisor OWNER TO imagine;

--
-- TOC entry 186 (class 1259 OID 17221)
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


ALTER TABLE empleado OWNER TO imagine;

--
-- TOC entry 185 (class 1259 OID 17219)
-- Name: empleado_idempleado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE empleado_idempleado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE empleado_idempleado_seq OWNER TO imagine;

--
-- TOC entry 2312 (class 0 OID 0)
-- Dependencies: 185
-- Name: empleado_idempleado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE empleado_idempleado_seq OWNED BY empleado.idempleado;


--
-- TOC entry 203 (class 1259 OID 18143)
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


ALTER TABLE factura OWNER TO imagine;

--
-- TOC entry 202 (class 1259 OID 18141)
-- Name: factura_idfactura_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE factura_idfactura_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE factura_idfactura_seq OWNER TO imagine;

--
-- TOC entry 2313 (class 0 OID 0)
-- Dependencies: 202
-- Name: factura_idfactura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE factura_idfactura_seq OWNED BY factura.idfactura;


--
-- TOC entry 196 (class 1259 OID 17274)
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


ALTER TABLE inventario OWNER TO imagine;

--
-- TOC entry 195 (class 1259 OID 17272)
-- Name: inventario_idinventario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE inventario_idinventario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE inventario_idinventario_seq OWNER TO imagine;

--
-- TOC entry 2314 (class 0 OID 0)
-- Dependencies: 195
-- Name: inventario_idinventario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE inventario_idinventario_seq OWNED BY inventario.idinventario;


--
-- TOC entry 197 (class 1259 OID 17286)
-- Name: inventarioproducto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE inventarioproducto (
    idinventario integer,
    idproducto integer,
    cantidadnecesaria numeric(8,2)
);


ALTER TABLE inventarioproducto OWNER TO imagine;

--
-- TOC entry 182 (class 1259 OID 16394)
-- Name: lista_contactos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lista_contactos (
    nombre character varying(50),
    telefono integer
);


ALTER TABLE lista_contactos OWNER TO imagine;

--
-- TOC entry 207 (class 1259 OID 18187)
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


ALTER TABLE orden OWNER TO imagine;

--
-- TOC entry 206 (class 1259 OID 18185)
-- Name: orden_idorden_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE orden_idorden_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orden_idorden_seq OWNER TO imagine;

--
-- TOC entry 2315 (class 0 OID 0)
-- Dependencies: 206
-- Name: orden_idorden_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE orden_idorden_seq OWNED BY orden.idorden;


--
-- TOC entry 199 (class 1259 OID 17301)
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


ALTER TABLE periodoventa OWNER TO imagine;

--
-- TOC entry 198 (class 1259 OID 17299)
-- Name: periodoventa_idperiodoventa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE periodoventa_idperiodoventa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE periodoventa_idperiodoventa_seq OWNER TO imagine;

--
-- TOC entry 2316 (class 0 OID 0)
-- Dependencies: 198
-- Name: periodoventa_idperiodoventa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE periodoventa_idperiodoventa_seq OWNED BY periodoventa.idperiodoventa;


--
-- TOC entry 192 (class 1259 OID 17252)
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


ALTER TABLE producto OWNER TO imagine;

--
-- TOC entry 191 (class 1259 OID 17250)
-- Name: producto_idproducto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE producto_idproducto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE producto_idproducto_seq OWNER TO imagine;

--
-- TOC entry 2317 (class 0 OID 0)
-- Dependencies: 191
-- Name: producto_idproducto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE producto_idproducto_seq OWNED BY producto.idproducto;


--
-- TOC entry 209 (class 1259 OID 18209)
-- Name: proveedor; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE proveedor OWNER TO imagine;

--
-- TOC entry 208 (class 1259 OID 18207)
-- Name: proveedor_idproveedor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE proveedor_idproveedor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE proveedor_idproveedor_seq OWNER TO imagine;

--
-- TOC entry 2318 (class 0 OID 0)
-- Dependencies: 208
-- Name: proveedor_idproveedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE proveedor_idproveedor_seq OWNED BY proveedor.idproveedor;


--
-- TOC entry 210 (class 1259 OID 18216)
-- Name: proveedorinventario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE proveedorinventario (
    idproveedor integer,
    idinventario integer,
    cantidadproducto numeric(10,2),
    fecharegistro timestamp without time zone DEFAULT now(),
    costounitario numeric(10,2)
);


ALTER TABLE proveedorinventario OWNER TO imagine;

--
-- TOC entry 184 (class 1259 OID 17213)
-- Name: puesto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE puesto (
    idpuesto integer NOT NULL,
    descripcionpuesto character(50),
    departamentopuesto character(50)
);


ALTER TABLE puesto OWNER TO imagine;

--
-- TOC entry 183 (class 1259 OID 17211)
-- Name: puesto_idpuesto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE puesto_idpuesto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE puesto_idpuesto_seq OWNER TO imagine;

--
-- TOC entry 2319 (class 0 OID 0)
-- Dependencies: 183
-- Name: puesto_idpuesto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE puesto_idpuesto_seq OWNED BY puesto.idpuesto;


--
-- TOC entry 205 (class 1259 OID 18177)
-- Name: receptor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE receptor (
    nombre character varying(80) NOT NULL,
    receptor_tipo_identificacion character varying(2) NOT NULL,
    receptor_numero character varying(12) NOT NULL,
    identificacionextranjero character varying(20),
    nombrecomercial character varying(80),
    provincia character varying(1) NOT NULL,
    canton character varying(2) NOT NULL,
    distrito character varying(2) NOT NULL,
    otras_senas text,
    receptor_telefono_codigopais numeric(3,0),
    receptor_telefono_numtelefono numeric(20,0),
    receptor_fax_codigopais numeric(3,0),
    receptor_fax_numtelefono numeric(20,0),
    correoelectronico character varying(60)
);


ALTER TABLE receptor OWNER TO imagine;

--
-- TOC entry 212 (class 1259 OID 18232)
-- Name: tipogasto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tipogasto (
    idtipogasto integer NOT NULL,
    descripciontipogasto character(50)
);


ALTER TABLE tipogasto OWNER TO imagine;

--
-- TOC entry 211 (class 1259 OID 18230)
-- Name: tipogasto_idtipogasto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipogasto_idtipogasto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tipogasto_idtipogasto_seq OWNER TO imagine;

--
-- TOC entry 2320 (class 0 OID 0)
-- Dependencies: 211
-- Name: tipogasto_idtipogasto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipogasto_idtipogasto_seq OWNED BY tipogasto.idtipogasto;


--
-- TOC entry 2082 (class 2604 OID 17247)
-- Name: idcategoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria ALTER COLUMN idcategoria SET DEFAULT nextval('categoria_idcategoria_seq'::regclass);


--
-- TOC entry 2085 (class 2604 OID 17269)
-- Name: idcategoriainventario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoriainventario ALTER COLUMN idcategoriainventario SET DEFAULT nextval('categoriainventario_idcategoriainventario_seq'::regclass);


--
-- TOC entry 2091 (class 2604 OID 18086)
-- Name: idcliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cliente ALTER COLUMN idcliente SET DEFAULT nextval('cliente_idcliente_seq'::regclass);


--
-- TOC entry 2080 (class 2604 OID 17238)
-- Name: idcuenta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cuenta ALTER COLUMN idcuenta SET DEFAULT nextval('cuenta_idcuenta_seq'::regclass);


--
-- TOC entry 2078 (class 2604 OID 17224)
-- Name: idempleado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY empleado ALTER COLUMN idempleado SET DEFAULT nextval('empleado_idempleado_seq'::regclass);


--
-- TOC entry 2093 (class 2604 OID 18146)
-- Name: idfactura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura ALTER COLUMN idfactura SET DEFAULT nextval('factura_idfactura_seq'::regclass);


--
-- TOC entry 2086 (class 2604 OID 17277)
-- Name: idinventario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inventario ALTER COLUMN idinventario SET DEFAULT nextval('inventario_idinventario_seq'::regclass);


--
-- TOC entry 2096 (class 2604 OID 18190)
-- Name: idorden; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orden ALTER COLUMN idorden SET DEFAULT nextval('orden_idorden_seq'::regclass);


--
-- TOC entry 2088 (class 2604 OID 17304)
-- Name: idperiodoventa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY periodoventa ALTER COLUMN idperiodoventa SET DEFAULT nextval('periodoventa_idperiodoventa_seq'::regclass);


--
-- TOC entry 2083 (class 2604 OID 17255)
-- Name: idproducto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY producto ALTER COLUMN idproducto SET DEFAULT nextval('producto_idproducto_seq'::regclass);


--
-- TOC entry 2101 (class 2604 OID 18212)
-- Name: idproveedor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY proveedor ALTER COLUMN idproveedor SET DEFAULT nextval('proveedor_idproveedor_seq'::regclass);


--
-- TOC entry 2077 (class 2604 OID 17216)
-- Name: idpuesto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY puesto ALTER COLUMN idpuesto SET DEFAULT nextval('puesto_idpuesto_seq'::regclass);


--
-- TOC entry 2104 (class 2604 OID 18235)
-- Name: idtipogasto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipogasto ALTER COLUMN idtipogasto SET DEFAULT nextval('tipogasto_idtipogasto_seq'::regclass);


--
-- TOC entry 2275 (class 0 OID 17244)
-- Dependencies: 190
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2321 (class 0 OID 0)
-- Dependencies: 189
-- Name: categoria_idcategoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categoria_idcategoria_seq', 1, false);


--
-- TOC entry 2279 (class 0 OID 17266)
-- Dependencies: 194
-- Data for Name: categoriainventario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2322 (class 0 OID 0)
-- Dependencies: 193
-- Name: categoriainventario_idcategoriainventario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categoriainventario_idcategoriainventario_seq', 1, false);


--
-- TOC entry 2286 (class 0 OID 18083)
-- Dependencies: 201
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2323 (class 0 OID 0)
-- Dependencies: 200
-- Name: cliente_idcliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cliente_idcliente_seq', 1, false);


--
-- TOC entry 2273 (class 0 OID 17235)
-- Dependencies: 188
-- Data for Name: cuenta; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2324 (class 0 OID 0)
-- Dependencies: 187
-- Name: cuenta_idcuenta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cuenta_idcuenta_seq', 1, false);


--
-- TOC entry 2289 (class 0 OID 18169)
-- Dependencies: 204
-- Data for Name: emisor; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2271 (class 0 OID 17221)
-- Dependencies: 186
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2325 (class 0 OID 0)
-- Dependencies: 185
-- Name: empleado_idempleado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('empleado_idempleado_seq', 1, false);


--
-- TOC entry 2288 (class 0 OID 18143)
-- Dependencies: 203
-- Data for Name: factura; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2326 (class 0 OID 0)
-- Dependencies: 202
-- Name: factura_idfactura_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('factura_idfactura_seq', 1, false);


--
-- TOC entry 2281 (class 0 OID 17274)
-- Dependencies: 196
-- Data for Name: inventario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2327 (class 0 OID 0)
-- Dependencies: 195
-- Name: inventario_idinventario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('inventario_idinventario_seq', 1, false);


--
-- TOC entry 2282 (class 0 OID 17286)
-- Dependencies: 197
-- Data for Name: inventarioproducto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2267 (class 0 OID 16394)
-- Dependencies: 182
-- Data for Name: lista_contactos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lista_contactos (nombre, telefono) VALUES ('natanael', 1234234);


--
-- TOC entry 2292 (class 0 OID 18187)
-- Dependencies: 207
-- Data for Name: orden; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2328 (class 0 OID 0)
-- Dependencies: 206
-- Name: orden_idorden_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('orden_idorden_seq', 1, false);


--
-- TOC entry 2284 (class 0 OID 17301)
-- Dependencies: 199
-- Data for Name: periodoventa; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2329 (class 0 OID 0)
-- Dependencies: 198
-- Name: periodoventa_idperiodoventa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('periodoventa_idperiodoventa_seq', 1, false);


--
-- TOC entry 2277 (class 0 OID 17252)
-- Dependencies: 192
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2330 (class 0 OID 0)
-- Dependencies: 191
-- Name: producto_idproducto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('producto_idproducto_seq', 1, false);


--
-- TOC entry 2294 (class 0 OID 18209)
-- Dependencies: 209
-- Data for Name: proveedor; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2331 (class 0 OID 0)
-- Dependencies: 208
-- Name: proveedor_idproveedor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('proveedor_idproveedor_seq', 1, false);


--
-- TOC entry 2295 (class 0 OID 18216)
-- Dependencies: 210
-- Data for Name: proveedorinventario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2269 (class 0 OID 17213)
-- Dependencies: 184
-- Data for Name: puesto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2332 (class 0 OID 0)
-- Dependencies: 183
-- Name: puesto_idpuesto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('puesto_idpuesto_seq', 1, false);


--
-- TOC entry 2290 (class 0 OID 18177)
-- Dependencies: 205
-- Data for Name: receptor; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2297 (class 0 OID 18232)
-- Dependencies: 212
-- Data for Name: tipogasto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2333 (class 0 OID 0)
-- Dependencies: 211
-- Name: tipogasto_idtipogasto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipogasto_idtipogasto_seq', 1, false);


--
-- TOC entry 2112 (class 2606 OID 17249)
-- Name: categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (idcategoria);


--
-- TOC entry 2116 (class 2606 OID 17271)
-- Name: categoriainventario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoriainventario
    ADD CONSTRAINT categoriainventario_pkey PRIMARY KEY (idcategoriainventario);


--
-- TOC entry 2122 (class 2606 OID 18089)
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (idcliente);


--
-- TOC entry 2110 (class 2606 OID 17241)
-- Name: cuenta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cuenta
    ADD CONSTRAINT cuenta_pkey PRIMARY KEY (idcuenta);


--
-- TOC entry 2126 (class 2606 OID 18176)
-- Name: emisor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY emisor
    ADD CONSTRAINT emisor_pkey PRIMARY KEY (emisor_numero);


--
-- TOC entry 2108 (class 2606 OID 17227)
-- Name: empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (idempleado);


--
-- TOC entry 2124 (class 2606 OID 18153)
-- Name: factura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT factura_pkey PRIMARY KEY (clave, idfactura);


--
-- TOC entry 2118 (class 2606 OID 17280)
-- Name: inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (idinventario);


--
-- TOC entry 2130 (class 2606 OID 18196)
-- Name: orden_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orden
    ADD CONSTRAINT orden_pkey PRIMARY KEY (idorden);


--
-- TOC entry 2120 (class 2606 OID 17308)
-- Name: periodoventa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY periodoventa
    ADD CONSTRAINT periodoventa_pkey PRIMARY KEY (idperiodoventa);


--
-- TOC entry 2114 (class 2606 OID 17258)
-- Name: producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (idproducto);


--
-- TOC entry 2132 (class 2606 OID 18215)
-- Name: proveedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY proveedor
    ADD CONSTRAINT proveedor_pkey PRIMARY KEY (idproveedor);


--
-- TOC entry 2106 (class 2606 OID 17218)
-- Name: puesto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY puesto
    ADD CONSTRAINT puesto_pkey PRIMARY KEY (idpuesto);


--
-- TOC entry 2128 (class 2606 OID 18184)
-- Name: receptor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY receptor
    ADD CONSTRAINT receptor_pkey PRIMARY KEY (receptor_numero);


--
-- TOC entry 2135 (class 2606 OID 18101)
-- Name: cuenta_idcliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cuenta
    ADD CONSTRAINT cuenta_idcliente_fkey FOREIGN KEY (idcliente) REFERENCES cliente(idcliente);


--
-- TOC entry 2133 (class 2606 OID 17228)
-- Name: empleado_idpuesto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT empleado_idpuesto_fkey FOREIGN KEY (idpuesto) REFERENCES puesto(idpuesto);


--
-- TOC entry 2134 (class 2606 OID 18094)
-- Name: empleado_idpuesto_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY empleado
    ADD CONSTRAINT empleado_idpuesto_fkey1 FOREIGN KEY (idpuesto) REFERENCES puesto(idpuesto);


--
-- TOC entry 2146 (class 2606 OID 18154)
-- Name: factura_idcuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT factura_idcuenta_fkey FOREIGN KEY (idcuenta) REFERENCES cuenta(idcuenta);


--
-- TOC entry 2147 (class 2606 OID 18159)
-- Name: factura_idempleado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT factura_idempleado_fkey FOREIGN KEY (idempleado) REFERENCES empleado(idempleado);


--
-- TOC entry 2148 (class 2606 OID 18164)
-- Name: factura_idperiodoventa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY factura
    ADD CONSTRAINT factura_idperiodoventa_fkey FOREIGN KEY (idperiodoventa) REFERENCES periodoventa(idperiodoventa);


--
-- TOC entry 2138 (class 2606 OID 17281)
-- Name: inventario_idcategoriainventario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inventario
    ADD CONSTRAINT inventario_idcategoriainventario_fkey FOREIGN KEY (idcategoriainventario) REFERENCES categoriainventario(idcategoriainventario);


--
-- TOC entry 2139 (class 2606 OID 18119)
-- Name: inventario_idcategoriainventario_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inventario
    ADD CONSTRAINT inventario_idcategoriainventario_fkey1 FOREIGN KEY (idcategoriainventario) REFERENCES categoriainventario(idcategoriainventario);


--
-- TOC entry 2140 (class 2606 OID 17289)
-- Name: inventarioproducto_idinventario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inventarioproducto
    ADD CONSTRAINT inventarioproducto_idinventario_fkey FOREIGN KEY (idinventario) REFERENCES inventario(idinventario);


--
-- TOC entry 2142 (class 2606 OID 18124)
-- Name: inventarioproducto_idinventario_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inventarioproducto
    ADD CONSTRAINT inventarioproducto_idinventario_fkey1 FOREIGN KEY (idinventario) REFERENCES inventario(idinventario);


--
-- TOC entry 2141 (class 2606 OID 17294)
-- Name: inventarioproducto_idproducto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inventarioproducto
    ADD CONSTRAINT inventarioproducto_idproducto_fkey FOREIGN KEY (idproducto) REFERENCES producto(idproducto);


--
-- TOC entry 2143 (class 2606 OID 18129)
-- Name: inventarioproducto_idproducto_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inventarioproducto
    ADD CONSTRAINT inventarioproducto_idproducto_fkey1 FOREIGN KEY (idproducto) REFERENCES producto(idproducto);


--
-- TOC entry 2149 (class 2606 OID 18197)
-- Name: orden_idcuenta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orden
    ADD CONSTRAINT orden_idcuenta_fkey FOREIGN KEY (idcuenta) REFERENCES cuenta(idcuenta);


--
-- TOC entry 2150 (class 2606 OID 18202)
-- Name: orden_idproducto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orden
    ADD CONSTRAINT orden_idproducto_fkey FOREIGN KEY (idproducto) REFERENCES producto(idproducto);


--
-- TOC entry 2144 (class 2606 OID 17309)
-- Name: periodoventa_idempleado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY periodoventa
    ADD CONSTRAINT periodoventa_idempleado_fkey FOREIGN KEY (idempleado) REFERENCES empleado(idempleado);


--
-- TOC entry 2145 (class 2606 OID 18136)
-- Name: periodoventa_idempleado_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY periodoventa
    ADD CONSTRAINT periodoventa_idempleado_fkey1 FOREIGN KEY (idempleado) REFERENCES empleado(idempleado);


--
-- TOC entry 2136 (class 2606 OID 17259)
-- Name: producto_idcategoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY producto
    ADD CONSTRAINT producto_idcategoria_fkey FOREIGN KEY (idcategoria) REFERENCES categoria(idcategoria);


--
-- TOC entry 2137 (class 2606 OID 18110)
-- Name: producto_idcategoria_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY producto
    ADD CONSTRAINT producto_idcategoria_fkey1 FOREIGN KEY (idcategoria) REFERENCES categoria(idcategoria);


--
-- TOC entry 2152 (class 2606 OID 18225)
-- Name: proveedorinventario_idinventario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY proveedorinventario
    ADD CONSTRAINT proveedorinventario_idinventario_fkey FOREIGN KEY (idinventario) REFERENCES inventario(idinventario);


--
-- TOC entry 2151 (class 2606 OID 18220)
-- Name: proveedorinventario_idproveedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY proveedorinventario
    ADD CONSTRAINT proveedorinventario_idproveedor_fkey FOREIGN KEY (idproveedor) REFERENCES proveedor(idproveedor);


--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM imagine;
GRANT ALL ON SCHEMA public TO imagine;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-08-02 23:59:48

--
-- PostgreSQL database dump complete
--

