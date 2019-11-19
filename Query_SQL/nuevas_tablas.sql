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
    codigo_moneda VARCHAR(3),
    tipoCambio DECIMAL(18,5),
    TotalServGrabados DECIMAL(18,5),
    TotalServExentos DECIMAL(18,5),
    TotalMercanciasGravadas DECIMAL(18,5),
    TotalMercanciasExentas DECIMAL(18,5),
    TotalGravado DECIMAL(18,5) NOT NULL,
    TotalExento DECIMAL(18,5) NOT NULL,
    TotalVenta DECIMAL(18,5) NOT NULL,
    TotalDescuentos DECIMAL(18,5) NOT NULL,
    TotalVentaNeta DECIMAL(18,5) NOT NULL
    TotalImpuesto DECIMAL(18,5),
    TotalComprobante DECIMAL(18,5) NOT NULL,

);

ALTER TABLE ONLY orden
    ADD CONSTRAINT orden_pkey PRIMARY KEY (idorden);


ALTER TABLE ONLY orden
    ADD CONSTRAINT orden_idcuenta_fkey FOREIGN KEY (idcuenta) REFERENCES cuenta(idcuenta);

--
-- TOC entry 2180 (class 2606 OID 18923)
-- Name: orden_idproducto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orden
    ADD CONSTRAINT orden_idproducto_fkey FOREIGN KEY (idproducto) REFERENCES producto(idproducto);
--
-- TOC entry 2181 (class 2606 OID 18928)
-- Name: orden_idfactura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orden
    ADD CONSTRAINT orden_idfactura_fkey FOREIGN KEY (idfactura) REFERENCES factura(idfactura);




CREATE SEQUENCE orden_idorden_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

    ALTER SEQUENCE orden_idorden_seq OWNED BY orden.idorden;

    ALTER TABLE ONLY orden ALTER COLUMN idorden SET DEFAULT nextval('orden_idorden_seq'::regclass);