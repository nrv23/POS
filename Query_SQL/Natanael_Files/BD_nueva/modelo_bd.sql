SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;
SET search_path = public, pg_catalog;

DROP EXTENSION IF EXISTS plpgsql;
DROP SCHEMA IF EXISTS public CASCADE;

CREATE SCHEMA public;
COMMENT ON SCHEMA public IS 'standard public schema';


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
DROP TRIGGER IF EXISTS details ON public.detalles_orden;
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
ALTER TABLE IF EXISTS ONLY public.detalles_orden DROP CONSTRAINT IF EXISTS detalles_orden_pkey;
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
ALTER TABLE IF EXISTS public.detalles_orden ALTER COLUMN iddetalle DROP DEFAULT;
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
DROP FUNCTION IF EXISTS public.update_order_table(pidorden integer, pidfactura integer, pcostounitario numeric, pdescuentoorden numeric, pnumerolineadetalle integer, pcodigoservicio character varying, ptiposervicio character varying, punidadmedida character varying, punidadmedidacomercial character varying, pdetalle text, pmontototal numeric, pmontodescuento numeric, pnaturalezadescuento character varying, psubtotal numeric, pcodigoimpuesto character varying, ptarifa numeric, pmonto numeric, pexoneracion_tipodocumento character varying, pnumerodocumento character varying, pnombreinstitucion character varying, pmontoimpuesto numeric, pporcentajecompra integer, pmontoitotallinea numeric);
DROP FUNCTION IF EXISTS public.update_order_cost(ordenactualizar integer);
DROP FUNCTION IF EXISTS public.update_inventory(ordencancelada integer, cantidad integer);
DROP FUNCTION IF EXISTS public.update_insert_inventarioproducto(producto integer, inventario integer, cantidad integer);
DROP FUNCTION IF EXISTS public.reload_inventory(ordencancelada integer, cantidad integer);
DROP FUNCTION IF EXISTS public.new_order_detail();
DROP EXTENSION IF EXISTS plpgsql;
DROP SCHEMA IF EXISTS public;
DROP SCHEMA public CASCADE;
--
-- TOC entry 7 (class 2615 OID 21168)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';

--
-- TOC entry 1 (class 3079 OID 21169)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

-- MODELO DE LA BASE DE DATOS

CREATE TABLE cliente (
    idcliente SERIAL,
    identificacioncliente character(100),
    estadocliente smallint DEFAULT 1,

    PRIMARY  KEY(idcliente)
);

-- CREAR LA TABLA CUENTA
CREATE TABLE CUENTA
(
	idCuenta SERIAL,
    idCliente int,
    fechaAperturaCuenta timestamp default current_timestamp,
    estadoCuenta char(30),
    primary key (idCuenta)    
);
ALTER TABLE CUENTA ADD FOREIGN KEY (idCliente) references CLIENTE(idCliente);
-- PERDIODO VENTA
CREATE TABLE empleado (
    idempleado SERIAL,
    nombreempleado character(50),
    apellidoempleado character(50),
    passwordempleado character(50),
    idpuesto integer NOT NULL,
    estadoempleado smallint DEFAULT 1,
    primary key (idEmpleado)
);

CREATE TABLE periodoventa (
    idperiodoventa SERIAL,
    nombreperiodoventa character(50),
    estadoperiodoventa character(10) DEFAULT 'Activo'::bpchar,
    fechainicioperiodoventa timestamp without time zone DEFAULT now(),
    fechafinperiodoventa timestamp without time zone,
    idempleado integer,
     primary key(idperiodoventa)
);

ALTER TABLE PERIODOVENTA ADD FOREIGN KEY (idEmpleado) REFERENCES EMPLEADO (idEmpleado);

CREATE TABLE puesto (
    idpuesto SERIAL,
    descripcionpuesto character(50),
    departamentopuesto character(50),
    primary key(idPuesto)
);

ALTER TABLE EMPLEADO ADD foreign key (idPuesto) references PUESTO(idPuesto);

CREATE TABLE receptor (
    idreceptor SERIAL,
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
    primary key(idreceptor)
);

CREATE TABLE emisor (
    idemisor SERIAL,
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
    file_p12 VARCHAR(16),
    key_username VARCHAR(52),
    key_password VARCHAR(20),
    pin_p12 VARCHAR(4),
    casaMatriz VARCHAR(3),
    puntoVenta VARCHAR(5),
    tipo_producto VARCHAR(2),
    codigo_producto VARCHAR(50),
    codigo_actividad VARCHAR(6),
    password_email VARCHAR(150),
    idFile integer,
    downloadCode VARCHAR(64),
    idUserAPI integer,
    acercade VARCHAR(16),
    ubicacion VARCHAR(16),
    usernameapi character varying,
    passwordapi character varying,
    primary key(idemisor)
);


CREATE TABLE factura (
    idfactura SERIAL,
    idcuenta integer,
    idempleado integer,
    idperiodoventa integer,
    idreceptor integer NULL,
    idemisor integer NULL,
    fecharegistrofactura date DEFAULT now(),
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
    status character varying(25),
    razon character varying(300),
    referencia character varying(2),
    razon_nota character varying(500),
    tipo_comprobante character varying(2),
    iddetalle integer DEFAULT 0,
    receptor_numero character varying(12),
    clavenumerica character varying(50),
    consecutivo character varying(20),
    num_documento integer DEFAULT 0,
    totalservexonerado numeric(18,5),
    totalmercanciaexonerada numeric(18,5),
    totalexonerado numeric(18,5),
    fechaemision timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    primary key(idfactura)
);

ALTER TABLE FACTURA ADD FOREIGN KEY (idCuenta) REFERENCES CUENTA(idCuenta);
-- A LA FACTURA LE GENERAMOS UNA FK PARA EL EMPLEADO
ALTER TABLE FACTURA ADD FOREIGN KEY (idEmpleado) REFERENCES EMPLEADO(idEmpleado);
-- A LA FACTURA LE GENERAMOS UNA FK PARA EL PERIDO DE VENTA
ALTER TABLE FACTURA ADD FOREIGN KEY (idPeriodoVenta) REFERENCES PERIODOVENTA(idPeriodoVenta);
-- FK DE RECEPTOR
ALTER TABLE FACTURA ADD FOREIGN KEY (idreceptor) REFERENCES RECEPTOR(idreceptor);
-- FK DE EMISOR 
ALTER TABLE FACTURA ADD FOREIGN KEY (idemisor) REFERENCES emisor(idemisor);

CREATE TABLE categoria (
    idcategoria SERIAL,
    descripcioncategoria character(30),
    primary key (idCategoria)
);

CREATE TABLE clasificacion (

    id SERIAL,
    nombre_clasificacion varchar(50),
    codigo_impuesto VARCHAR(2),
    descripcion_impuesto VARCHAR(100),
    PRIMARY KEY(id)
);

CREATE TABLE producto (
    idproducto SERIAL,
    descripcionproducto character(50),
    idcategoria integer,
    precioproducto integer,
    codigobarraproducto character(50),
    estadoproducto smallint DEFAULT 1,
    tipo_impuesto character varying(2),
    unidadmedida character varying(20),
    unidadmedidacomercial character varying(20),
    costounitario integer,
    porcentajeimpuesto numeric(10,5),
    tipo_producto character varying(10),
    codigoproducto character varying(24),
    idclasificacion integer,
    PRIMARY KEY(idproducto)
);

ALTER TABLE PRODUCTO ADD FOREIGN KEY (idCategoria) references CATEGORIA(idCategoria);
ALTER TABLE PRODUCTO ADD FOREIGN KEY(idclasificacion) REFERENCES clasificacion(id);

CREATE TABLE descuento(

    iddescuento SERIAL,
    porcentajedescuento DECIMAL(4,2) NOT NULL,
    descripciondescuento VARCHAR(40) NOT NULL,
    creado_por VARCHAR(40),
    fecha_creacion TIMESTAMP  DEFAULT NOW(),
    estadodescuento BOOLEAN DEFAULT true,

 PRIMARY KEY(iddescuento)
);
-- AL PRODUCTO LE GENERAMOS UNA FK PARA LA CATEGORIA


CREATE TABLE orden (
    idorden SERIAL,
     idcuenta integer,
    idproducto integer,
    idfactura integer,
    cantidadproducto integer NOT NULL,
    estadoorden character(10),
    fecharegistroorden timestamp without time zone DEFAULT now(),
    preciounitarioproducto numeric(10,2) DEFAULT 0,
    costounitarioproducto numeric(10,2) DEFAULT 0,
    descuentoorden numeric(18,5) DEFAULT 0,
    numerolineadetalle integer DEFAULT 1 NOT NULL,
    codigoservicio character varying(50) DEFAULT 1 NOT NULL,
    tiposervicio character varying(2) DEFAULT '2'::character varying NOT NULL,
    unidadmedida character varying(20) DEFAULT '1'::character varying NOT NULL,
    unidadmedidacomercial character varying(20) DEFAULT '1'::character varying NOT NULL,
    detalle text DEFAULT '1'::text NOT NULL,
    montototal numeric(18,5) DEFAULT 1 NOT NULL,
    montodescuento numeric(18,5) DEFAULT 1 NOT NULL,
    naturalezadescuento character varying(50) DEFAULT ''::character varying NOT NULL,
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
    baseimponible numeric(18,5),
    total_orden numeric(18,5),

    PRIMARY KEY(idorden)
);
-- A LA ORDEN LE GENERAMOS UNA FK PARA LA CUENTA
ALTER TABLE ORDEN ADD FOREIGN KEY (idCuenta) REFERENCES CUENTA(idCuenta);
-- A LA ORDEN LE GENERAMOS UNA FK PARA EL PRODUCTO
ALTER TABLE ORDEN ADD FOREIGN KEY (idProducto) REFERENCES PRODUCTO(idProducto);
-- A LA ORDEN LE GENERAMOS UNA FK PARA LA FACTURA
ALTER TABLE ORDEN ADD FOREIGN KEY (idFactura) REFERENCES FACTURA(idFactura);

CREATE TABLE categoriainventario (
    idcategoriainventario SERIAL,
    descripcioncategoriainventario character(30),
    primary key (idCategoriaInventario)
);

CREATE TABLE inventario (
    idinventario SERIAL,
    idcategoriainventario integer,
    descripcioninventario character(50),
    costoinventario numeric(10,2),
    cantidaddisponibleinventario numeric(10,2),
    cantidadminimainventario numeric(10,2),
    unidad character(10),
    codigobarrainventario character(50),
    estadoinventario smallint DEFAULT 1,
     primary key (idInventario)
);

ALTER TABLE INVENTARIO ADD FOREIGN KEY (idCategoriaInventario) REFERENCES CATEGORIAINVENTARIO(idCategoriaInventario);

CREATE TABLE inventarioproducto (
    idinventario integer,
    idproducto integer,
    cantidadnecesaria numeric(8,2)
);
-- A LA INVENTARIOPRODUCTO LE GENERAMOS UNA FK PARA EL INVENTARIO
ALTER TABLE INVENTARIOPRODUCTO ADD FOREIGN KEY (idInventario) REFERENCES INVENTARIO(idInventario);
-- A LA INVENTARIOPRODUCTO LE GENERAMOS UNA FK PARA EL PRODUCTO
ALTER TABLE INVENTARIOPRODUCTO ADD FOREIGN KEY (idProducto) REFERENCES PRODUCTO(idProducto);

CREATE TABLE proveedor (
    idproveedor SERIAL,
    empresa character(50),
    nombrecontacto character(100),
    contactoproveedor1 character(20),
    contactoproveedor2 character(20),
    correoproveedor character(20),
    observacionproveedor character(100),
    estadoproveedor smallint DEFAULT 1,
    primary key (idProveedor)
);

CREATE TABLE proveedorinventario (
    idproveedor integer,
    idinventario integer,
    cantidadproducto numeric(10,2),
    fecharegistro timestamp without time zone DEFAULT now(),
    costounitario numeric(10,2)
);
-- A LA TABLA PROVEEDORPRODUCTO LE GENERAMOS UNA FK PARA EL PROVEEDOR
ALTER TABLE PROVEEDORINVENTARIO ADD FOREIGN KEY (idProveedor) REFERENCES PROVEEDOR (idProveedor);
-- A LA TABLA PROVEEDORPRODUCTO LE GENERAMOS UNA FK PARA EL PRODCUTO
ALTER TABLE PROVEEDORINVENTARIO ADD FOREIGN KEY (idInventario) REFERENCES INVENTARIO (idInventario);

CREATE TABLE tipogasto (
    idtipogasto SERIAL,
    descripciontipogasto character(50)
);



CREATE TABLE gasto (
    idgasto SERIAL,
    idtipogasto integer,
    descripciongasto character(50),
    estadogasto character(20),
    montogasto numeric(10,2),
    fechagasto timestamp without time zone DEFAULT now(),
    observaciongasto character(100)
);

CREATE TABLE provincia (
    id  INTEGER NOT NULL,
    codigo_provincia integer NOT NULL,
    nombre_provincia character varying(20) NOT NULL,

    PRIMARY KEY(id)
);

CREATE TABLE canton (
    id INTEGER NOT NULL,
    codigo_provincia integer NOT NULL,
    codigo_canton integer NOT NULL,
    nombre_canton character varying(45) NOT NULL,

    PRIMARY KEY(id)
);

CREATE TABLE distrito (
     id integer NOT NULL,
    codigo_provincia integer,
    codigo_canton integer,
    codigo_distrito integer,
    nombre_distrito character varying(70),
    PRIMARY KEY(id)
);

CREATE TABLE detalles_orden (
    iddetalle SERIAL,
    descripcion_detalle text,

    primary key(iddetalle)
);
CREATE TABLE fila (
    idorden integer
);

CREATE TABLE XML(
    idxml SERIAL,
    idfactura integer,
    xml text,
    xml_firmado text,
    acuse text,
    PRIMARY KEY(idxml)
);

ALTER TABLE XML ADD FOREIGN KEY(idfactura) REFERENCES factura(idfactura);

CREATE TABLE users
(
  iduser SERIAL,
  idemisor integer NULL,
  user_api character varying(10),
  pwd_api character varying(10),
  PRIMARY KEY (iduser)
);

ALTER TABLE users ADD FOREIGN KEY(idemisor) REFERENCES emisor(idemisor);


CREATE TABLE impuesto(
    idimpuesto SERIAL,
    codigo_impuesto varchar(2) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    estadoimpuesto BOOLEAN DEFAULT true,

    PRIMARY KEY(idimpuesto)
); 

CREATE TABLE tipoImpuesto( 
    idtipoimpuesto SERIAL,
    idimpuesto INTEGER NOT NULL,
    descripcionimpuesto varchar(50) NOT NULL,
    porcentajetipoimpuesto DECIMAL(5,2) NOT NULL,
    estadotipoimpuesto BOOLEAN DEFAULT true,

    PRIMARY KEY(idtipoimpuesto),
    FOREIGN KEY (idimpuesto) REFERENCES IMPUESTO(idimpuesto) 		

);
-- cambio en la columna de tarifa

-- ALTER TABLE ORDEN ALTER COLUMN TARIFA TYPE DECIMAL(8,2);
-- ALTER TABLE factura add column iddetalle INTEGER default 0;
-- ALTER TABLE FACTURA ADD COLUMN receptor_numero VARCHAR(12);
-- ALTER TABLE FACTURA ADD COLUMN clavenumerica VARCHAR(50);
-- ALTER TABLE factura ADD COLUMN consecutivo VARCHAR(20);
-- ALTER TABLE factura ADD COLUMN num_documento INTEGER default 0;
-- ALTER TABLE emisor ADD COLUMN casaMatriz VARCHAR(3);
-- ALTER TABLE emisor ADD COLUMN puntoVenta VARCHAR(5);

-- ALTER TABLE ORDEN ADD COLUMN condicion_venta VARCHAR(2);
-- ALTER TABLE ORDEN ADD COLUMN medio_pago VARCHAR(2);
-- ALTER TABLE ORDEN ADD COLUMN plazo_credito INTEGER DEFAULT 0;
-- ALTER TABLE FACTURA DROP CONSTRAINT factura_idreceptor_fkey;
-- ALTER TABLE users DROP CONSTRAINT users_idemisor_fkey;  

-- ALTER SEQUENCE producto_idproducto_seq RESTART WITH 37;