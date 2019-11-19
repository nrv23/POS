--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

-- Started on 2018-07-09 19:15:14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP_TABLE=ON/OFF/IF_EXISTS: (OGR >= 1.8.1) Set to ON so that tables are destroyed before being recreated. Set to OFF to prevent DROP TABLE from being emitted. Set to IF_EXISTS (default in GDAL 2.0) in order DROP TABLE IF EXISTS to be emitted (needs PostgreSQL >= 8.2)
--
-- TOC entry 1 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2131 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 182 (class 1259 OID 17103)
-- Name: canton; Type: TABLE; Schema: public;
--

CREATE TABLE canton (
    numerocanton integer NOT NULL,
    numeroprovincia integer NOT NULL,
    nombre character varying(30) NOT NULL
);

--
-- TOC entry 183 (class 1259 OID 17113)
-- Name: distrito; Type: TABLE; Schema: public;
--

CREATE TABLE distrito (
    numerodistrito integer NOT NULL,
    numerocanton integer NOT NULL,
    numeroprovincia integer NOT NULL,
    nombre character varying(30) NOT NULL
);

--
-- TOC entry 184 (class 1259 OID 17146)
-- Name: emisor; Type: TABLE; Schema: public;
--

CREATE TABLE emisor (
    nombre VARCHAR(80) NOT NULL,
    emisor_tipo_identificacion VARCHAR(2) NOT NULL,
    emisor_numero VARCHAR(12) NOT NULL,
    nombrecomercial VARCHAR(80),
    provincia VARCHAR(1)  NOT NULL,
    canton  VARCHAR(2) not NULL,
    distrito  VARCHAR (2 )NOT NULL,
    otras_Senas TEXT NULL,
    emisor_telefono_codigoPais  NUMERIC(3) NULL,
    emisor_telefono_numTelefono  NUMERIC(20) NULL,
    emisor_fax_codigoPais NUMERIC(3) NULL,
    emisor_fax_numTelefono NUMERIC(20) NULL,
    correoElectronico VARCHAR(60) NULL,
    primary key(emisor_numero)
);

--
-- TOC entry 181 (class 1259 OID 17098)
-- Name: provincia; Type: TABLE; Schema: public;
--

CREATE TABLE provincia (
    numeroprovincia integer NOT NULL,
    nombre character varying(30) NOT NULL
);

--
-- TOC entry 185 (class 1259 OID 17152)
-- Name: receptor; Type: TABLE; Schema: public;
--

CREATE TABLE receptor (
    nombre VARCHAR(80) NOT NULL,
    receptor_tipo_identificacion VARCHAR(2) NOT NULL,
    receptor_numero VARCHAR(12) NOT NULL,
    IdentificacionExtranjero VARCHAR(20) NULL,
    nombrecomercial VARCHAR(80) NULL,
    provincia VARCHAR(1)  NOT NULL,
    canton  VARCHAR(2) not NULL,
    distrito  VARCHAR (2 )NOT NULL,
    otras_Senas TEXT NULL,
    receptor_telefono_codigoPais  NUMERIC(3) NULL,
    receptor_telefono_numTelefono  NUMERIC(20) NULL,
    receptor_fax_codigoPais NUMERIC(3) NULL,
    receptor_fax_numTelefono NUMERIC(20) NULL,
    correoElectronico VARCHAR(60) NULL,
    primary key(receptor_numero)
);

--
-- TOC entry 2120 (class 0 OID 17103)
-- Dependencies: 182
-- Data for Name: canton; Type: TABLE DATA; Schema: public;
--

INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (1, 1, 'San Jose');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (2, 1, 'Escazu');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (3, 1, 'Desamparados');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (4, 1, 'Puriscal');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (5, 1, 'Tarraz£');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (6, 1, 'Aserri');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (7, 1, 'Mora');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (8, 1, 'Goicoechea');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (9, 1, 'Santa Ana');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (10, 1, 'Alajuelita');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (11, 1, 'Vasquez de Coronado');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (12, 1, 'Acosta');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (13, 1, 'Tibas');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (14, 1, 'Moravia');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (15, 1, 'Montes de Oca');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (16, 1, 'Turrubares');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (17, 1, 'Dota');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (18, 1, 'Curridabat');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (19, 1, 'Perez Zeledon');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (20, 1, 'Leon Cortez');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (1, 2, 'Alajuela');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (2, 2, 'San Ramon');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (3, 2, 'Grecia');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (4, 2, 'San Mateo');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (5, 2, 'Atenas');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (6, 2, 'Naranjo');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (7, 2, 'Palmares');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (8, 2, 'Poas');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (9, 2, 'Orotina');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (10, 2, 'San Carlos');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (11, 2, 'Alfaro Ruiz');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (12, 2, 'Valverde Vega');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (13, 2, 'Upala');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (14, 2, 'Los Chiles');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (15, 2, 'Guatuso');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (1, 3, 'Cartago');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (2, 3, 'Paraiso');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (3, 3, 'La Union');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (4, 3, 'Jimenez');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (5, 3, 'Turrialba');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (6, 3, 'Alvarado');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (7, 3, 'Oreamuno');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (8, 3, 'El Guarco');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (1, 4, 'Heredia');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (2, 4, 'Barva');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (3, 4, 'Santo Domingo');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (4, 4, 'Santa Barbara');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (5, 4, 'San Rafael');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (6, 4, 'San Isidro');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (7, 4, 'Belen');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (8, 4, 'Flores');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (9, 4, 'San Pablo');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (10, 4, 'Sarapiqui');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (1, 5, 'Liberia');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (2, 5, 'Nicoya');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (3, 5, 'Santa Cruz');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (4, 5, 'Bagaces');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (5, 5, 'Carrillo');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (6, 5, 'Ca¤as');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (7, 5, 'Abangares');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (8, 5, 'Tilaran');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (9, 5, 'Nandayure');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (10, 5, 'La Cruz');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (11, 5, 'Hojancha');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (1, 6, 'Puntarenas');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (2, 6, 'Esparza');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (3, 6, 'Buenos Aires');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (4, 6, 'Montes de Oro');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (5, 6, 'Osa');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (6, 6, 'Aguirre');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (7, 6, 'Golfito');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (8, 6, 'Coto Brus');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (9, 6, 'Parrita');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (10, 6, 'Corredores');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (11, 6, 'Garabito');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (1, 7, 'Limon');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (2, 7, 'Pococi');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (3, 7, 'Siquirres');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (4, 7, 'Talamanca');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (5, 7, 'Matina');
INSERT INTO canton (numerocanton, numeroprovincia, nombre) VALUES (6, 7, 'Guacimo');


--
-- TOC entry 2121 (class 0 OID 17113)
-- Dependencies: 183
-- Data for Name: distrito; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 1, 1, 'Carmen');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 1, 1, 'Merced');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 1, 1, 'Hospital');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 1, 1, 'Catedral');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 1, 1, 'Zapote');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 1, 1, 'San Francisco de Dos Rios');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 1, 1, 'Uruca');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 1, 1, 'Mata Redonda');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (9, 1, 1, 'Pavas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (10, 1, 1, 'Hatillo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (11, 1, 1, 'San Sebastian');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 2, 1, 'Escazu');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 2, 1, 'San Antonio');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 2, 1, 'San Rafael');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 3, 1, 'Desamparados');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 3, 1, 'San Miguel');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 3, 1, 'San Juan de Dios');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 3, 1, 'San Rafael');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 3, 1, 'San Antonio');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 3, 1, 'Frailes');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 3, 1, 'Patarra');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 3, 1, 'San Cristobal');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (9, 3, 1, 'Rosario');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (10, 3, 1, 'Damas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (11, 3, 1, 'San Rafael Abajo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (12, 3, 1, 'Gravillas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 4, 1, 'Santiago');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 4, 1, 'Mercedes Sur');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 4, 1, 'Barbacoas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 4, 1, 'Grito Alto');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 4, 1, 'San Rafael');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 4, 1, 'Candelarita');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 4, 1, 'Desamparaditos');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 4, 1, 'San Antonio');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (9, 4, 1, 'Chires');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (10, 4, 1, 'Tarrazu');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (11, 4, 1, 'San Marcos');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (12, 4, 1, 'San Lorenzo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (13, 4, 1, 'San Carlos');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 5, 1, 'Aserri');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 5, 1, 'Tarbaca');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 5, 1, 'Vuelta de Jorco');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 5, 1, 'San Gabriel');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 5, 1, 'Legua');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 5, 1, 'Monterrey');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 5, 1, 'Salitrillos');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 6, 1, 'Colon');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 6, 1, 'Guayabo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 6, 1, 'Tabarcia');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 6, 1, 'Piedras Negras');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 6, 1, 'Picagres');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 7, 1, 'Guadalupe');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 7, 1, 'San Francisco');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 7, 1, 'Calle Blancos');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 7, 1, 'Mata de Platano');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 7, 1, 'Ipis');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 7, 1, 'Rancho Redondo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 7, 1, 'Purral');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 8, 1, 'Santa Ana');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 8, 1, 'Salitral');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 8, 1, 'Pozos');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 8, 1, 'Uruca');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 8, 1, 'Piedades');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 8, 1, 'Brasil');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 9, 1, 'Alajuelita');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 9, 1, 'San Josecito');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 9, 1, 'San Antonio');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 9, 1, 'Concepcion');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 9, 1, 'San Felipe');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 10, 1, 'San Isidro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 10, 1, 'San Rafael');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 10, 1, 'Jesus (Dulce Nombre)');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 10, 1, 'Patalillo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 10, 1, 'Cascajal');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 11, 1, 'San Ignacio');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 11, 1, 'Guaitil');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 11, 1, 'Palmichal');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 11, 1, 'Cangrejal');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 11, 1, 'Sabanillas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 12, 1, 'San Juan');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 12, 1, 'Cinco Esquinas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 12, 1, 'Anselmo Llorente');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 12, 1, 'Leon XIII');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 12, 1, 'Colima');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 13, 1, 'San Vicente');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 13, 1, 'San Jeronimo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 13, 1, 'Trinidad');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 14, 1, 'San Pedro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 14, 1, 'Sabanilla');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 14, 1, 'Mercedes(Betania)');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 14, 1, 'San Rafael');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 15, 1, 'San Pablo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 15, 1, 'San Pedro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 15, 1, 'San Juan de Mata');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 15, 1, 'San Luis');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 16, 1, 'Santa Maria');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 16, 1, 'Jardin');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 16, 1, 'Copey');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 16, 1, 'Curridabat');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 17, 1, 'Granadilla');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 17, 1, 'Sanchez');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 17, 1, 'Tirrases');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 17, 1, 'Curridabat');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 18, 1, 'San Isidro del General');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 18, 1, 'General');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 18, 1, 'Daniel Flores');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 18, 1, 'Rivas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 18, 1, 'San Pedro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 18, 1, 'Platanares');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 18, 1, 'Pejibaye');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 18, 1, 'Cajon');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (9, 18, 1, 'Baru');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (10, 18, 1, 'Rio Nuevo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (11, 18, 1, 'El P ramo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 19, 1, 'San Pablo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 19, 1, 'San Andres');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 19, 1, 'Llano Bonito');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 19, 1, 'San Isidro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 19, 1, 'Santa Cruz');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 19, 1, 'San Antonio');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 1, 2, 'Alajuela');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 1, 2, 'Carrizal');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 1, 2, 'San Antonio');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 1, 2, 'Guacima');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 1, 2, 'San Isidro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 1, 2, 'Sabanilla');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 1, 2, 'San Rafael');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 1, 2, 'Rio Segundo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (9, 1, 2, 'Desamparados');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (10, 1, 2, 'Turrucares');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (11, 1, 2, 'Tambor');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (12, 1, 2, 'Garita');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (13, 1, 2, 'Sarapiqui');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 2, 2, 'San Ramon');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 2, 2, 'Santiago');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 2, 2, 'San Juan');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 2, 2, 'Piedades Norte');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 2, 2, 'Piedades Sur');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 2, 2, 'San Rafael');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 2, 2, 'San Isidro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 2, 2, 'Angeles');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (9, 2, 2, 'Alfaro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (10, 2, 2, 'Volio');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (11, 2, 2, 'Concepcion');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (12, 2, 2, 'Zapotal');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (13, 2, 2, 'Pe¤as Blancas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 3, 2, 'Grecia');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 3, 2, 'San Isidro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 3, 2, 'San Jose');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 3, 2, 'San Roque');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 3, 2, 'Tacares');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 3, 2, 'Rio Cuarto');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 3, 2, 'Puente de Piedra');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 3, 2, 'Bolivar');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 4, 2, 'San Mateo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 4, 2, 'Desmonte');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 4, 2, 'Jesus Maria');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 5, 2, 'Atenas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 5, 2, 'Jesus');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 5, 2, 'Mercedes');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 5, 2, 'San Isidro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 5, 2, 'Concepcion');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 5, 2, 'San Jose');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 5, 2, 'Santa Eulalia');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 6, 2, 'Naranjo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 6, 2, 'San Miguel');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 6, 2, 'San Jose');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 6, 2, 'Cirri Sur');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 6, 2, 'San Jeronimo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 6, 2, 'San Juan');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 6, 2, 'Rosario');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 7, 2, 'Palmares');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 7, 2, 'Zaragoza');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 7, 2, 'Buenos Aires');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 7, 2, 'Santiago');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 7, 2, 'Candelaria');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 7, 2, 'Esquipulas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 7, 2, 'Granja');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 8, 2, 'San Pedro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 8, 2, 'San Juan');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 8, 2, 'San Rafael');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 8, 2, 'Carrillos');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 8, 2, 'Sabana Redonda');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 9, 2, 'Orotina');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 9, 2, 'Mastate');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 9, 2, 'Hacienda Vieja');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 9, 2, 'Coyolar');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 9, 2, 'Ceiba');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 10, 2, 'Quesada');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 10, 2, 'Florencia');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 10, 2, 'Buenavista');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 10, 2, 'Aguas Zarcas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 10, 2, 'Venecia');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 10, 2, 'Pital');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 10, 2, 'Fortuna');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 10, 2, 'Tigra');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (9, 10, 2, 'Palmera');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (10, 10, 2, 'Venado');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (11, 10, 2, 'Cutris');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (12, 10, 2, 'Monterrey');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (13, 10, 2, 'Pocosol');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 11, 2, 'Zarcero');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 11, 2, 'Laguna');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 11, 2, 'Tapezco');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 11, 2, 'Guadalupe');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 11, 2, 'Palmira');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 11, 2, 'Zapote');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 11, 2, 'Brisas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 12, 2, 'Sarchi Norte');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 12, 2, 'Sarchi Sur');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 12, 2, 'Toro Amarillo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 12, 2, 'San Pedro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 12, 2, 'Rodriguez');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 13, 2, 'Upala');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 13, 2, 'Aguas Claras');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 13, 2, 'San Jose (Pizote)');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 13, 2, 'Bijagua');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 13, 2, 'Delicias');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 13, 2, 'Dos Rios (Colonia Mayorga)');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 13, 2, 'Yolillal');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 14, 2, 'Los Chiles');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 14, 2, 'Ca¤o Negro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 14, 2, 'El Amparo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 14, 2, 'San Jorge');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 15, 2, 'San Rafael');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 15, 2, 'Buena Vista');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 15, 2, 'Cote');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 1, 3, 'Oriental');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 1, 3, 'Occidental');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 1, 3, 'Carmen');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 1, 3, 'San Nicolas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 1, 3, 'Aguacaliente (San Francisco)');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 1, 3, 'Guadalupe (Arenilla)');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 1, 3, 'Corralillo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 1, 3, 'Tierra Blanca');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (9, 1, 3, 'Dulce Nombre');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (10, 1, 3, 'Llano Grande');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (11, 1, 3, 'Quebradilla');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 2, 3, 'Paraiso');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 2, 3, 'Santiago');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 2, 3, 'Orosi');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 2, 3, 'Cachi');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 2, 3, 'Llanos de Santa Lucia');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 3, 3, 'Tres Rios');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 3, 3, 'San Diego');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 3, 3, 'San Juan');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 3, 3, 'San Rafael');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 3, 3, 'Concepcion');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 3, 3, 'Dulce Nombre');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 3, 3, 'San Ramon');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 3, 3, 'Rio Azul');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 4, 3, 'Juan Vi¤as');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 4, 3, 'Tucurrique');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 4, 3, 'Pejibaye');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 5, 3, 'Turrialba');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 5, 3, 'La Suiza');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 5, 3, 'Peralta');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 5, 3, 'Santa cruz');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 5, 3, 'Santa Teresita');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 5, 3, 'Pavones');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 5, 3, 'Tuis');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 5, 3, 'Tayutic');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (9, 5, 3, 'Santa Rosa');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (10, 5, 3, 'Tres Equis');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (11, 5, 3, 'La Isabel');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (12, 5, 3, 'Chirripo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 6, 3, 'Pacayas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 6, 3, 'Cervantes');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 6, 3, 'Capellades');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 7, 3, 'San Rafael');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 7, 3, 'Cot');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 7, 3, 'Potrero Cerrado');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 7, 3, 'Cipreses');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 7, 3, 'Santa Rosa');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 8, 3, 'Tejar');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 8, 3, 'San Isidro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 8, 3, 'Tobosi');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 8, 3, 'Patio de Agua');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 1, 4, 'Heredia');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 1, 4, 'Mercedes');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 1, 4, 'San Francisco');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 1, 4, 'Ulloa');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 1, 4, 'Varablanca');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 2, 4, 'Barva');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 2, 4, 'San Pedro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 2, 4, 'San Pablo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 2, 4, 'San Roque');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 2, 4, 'Santa Lucia');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 2, 4, 'San Jose de la Monta¤a');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 3, 4, 'Santo Domingo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 3, 4, 'San Vicente');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 3, 4, 'San Miguel');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 3, 4, 'Paracito');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 3, 4, 'Santo Tomas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 3, 4, 'Santa Rosa');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 3, 4, 'Tures');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 3, 4, 'Para');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 4, 4, 'Santa Barbara');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 4, 4, 'San Pedro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 4, 4, 'San Juan');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 4, 4, 'Jesus');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 4, 4, 'Santo Domingo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 4, 4, 'Puraba');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 5, 4, 'San Rafael');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 5, 4, 'San Josecito');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 5, 4, 'Santiago');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 5, 4, 'Angeles');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 5, 4, 'Concepcion');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 6, 4, 'San Isidro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 6, 4, 'San Jose');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 6, 4, 'Concepcion');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 6, 4, 'San Francisco');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 7, 4, 'San Antonio');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 7, 4, 'Ribera');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 7, 4, 'Asuncion');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 8, 4, 'San Joaquin de Flores');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 8, 4, 'Barrantes');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 8, 4, 'Llorente');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 9, 4, 'San Pablo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 9, 4, 'Rincon de Sabanilla');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 10, 4, 'Puerto Viejo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 10, 4, 'La Virgen');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 10, 4, 'Horquetas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 10, 4, 'Llanuras del Gaspar');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 10, 4, 'Cure¤a');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 1, 5, 'Liberia');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 1, 5, 'Ca¤as Dulces');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 1, 5, 'Mayorga');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 1, 5, 'Nacascolo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 1, 5, 'Curubande');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 2, 5, 'Nicoya');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 2, 5, 'Mansion');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 2, 5, 'San Antonio');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 2, 5, 'Quebrada Honda');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 2, 5, 'Samara');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 2, 5, 'Nosara');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 2, 5, 'Belen de Nosarita');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 3, 5, 'Santa Cruz');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 3, 5, 'Bolson');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 3, 5, 'Veintisiete de Abril');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 3, 5, 'Tempate');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 3, 5, 'Cartagena');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 3, 5, 'Coajiniquil');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 3, 5, 'Diria');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 3, 5, 'Cabo Velas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (9, 3, 5, 'Tamarindo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 4, 5, 'Bagaces');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 4, 5, 'Fortuna');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 4, 5, 'Mogote');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 4, 5, 'Rio Naranjo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 5, 5, 'Filadelfia');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 5, 5, 'Palmira');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 5, 5, 'Sardinal');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 5, 5, 'Belen');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 6, 5, 'Ca¤as');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 6, 5, 'Palmira');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 6, 5, 'San Miguel');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 6, 5, 'Bebedero');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 6, 5, 'Porozal');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 7, 5, 'Juntas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 7, 5, 'Sierra');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 7, 5, 'San Juan');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 7, 5, 'Colorado');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 8, 5, 'Tilaran');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 8, 5, 'Quebrada Grande');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 8, 5, 'Tronadora');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 8, 5, 'Santa Rosa');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 8, 5, 'Libano');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 8, 5, 'Tierras Morenas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 8, 5, 'Arenal');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 9, 5, 'Carmona');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 9, 5, 'Santa Rita');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 9, 5, 'Zapotal');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 9, 5, 'San Pablo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 9, 5, 'Porvenir');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 9, 5, 'Bejuco');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 10, 5, 'La Cruz');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 10, 5, 'Santa Cecilia');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 10, 5, 'Garita');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 10, 5, 'Santa Elena');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 11, 5, 'Hojancha');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 11, 5, 'Monte Romo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 11, 5, 'Puerto Carrillo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 11, 5, 'Huacas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 1, 6, 'Puntarenas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 1, 6, 'Pitahaya');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 1, 6, 'Chomes');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 1, 6, 'Lepanto');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 1, 6, 'Paquera');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 1, 6, 'Manzanillo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 1, 6, 'Guacimal');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 1, 6, 'Barranca');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (9, 1, 6, 'Monte Verde');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (10, 1, 6, 'Isla del Coco');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (11, 1, 6, 'Cobano');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (12, 1, 6, 'Chacarita');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (13, 1, 6, 'Chira');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (14, 1, 6, 'Acapulco');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (15, 1, 6, 'El Roble');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (16, 1, 6, 'Arancibia');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 2, 6, 'Espiritu Santo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 2, 6, 'San Juan Grande');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 2, 6, 'Macacona');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 2, 6, 'San Rafael');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 2, 6, 'San Jeronimo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 3, 6, 'Buenos Aires');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 3, 6, 'Volcan');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 3, 6, 'Potrero Grande');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 3, 6, 'Boruca');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 3, 6, 'Pilas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 3, 6, 'Colinas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 3, 6, 'Changuenas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 3, 6, 'Biolley');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 4, 6, 'Miramar');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 4, 6, 'Union');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 4, 6, 'San Isidro');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 5, 6, 'Cortes');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 5, 6, 'Palmar');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 5, 6, 'Sierpe');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 5, 6, 'Bahia Ballena');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 5, 6, 'Piedras Blancas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 6, 6, 'Quepos');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 6, 6, 'Savegre');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 6, 6, 'Naranjito');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 7, 6, 'Golfito');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 7, 6, 'Jimenez');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 7, 6, 'Guaycar');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 7, 6, 'Corredor');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 8, 6, 'San Vito');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 8, 6, 'Sabalito');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 8, 6, 'Aguabuena');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 8, 6, 'Limoncito');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 8, 6, 'Pittier');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 9, 6, 'Parrita');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 10, 6, 'Corredores');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 10, 6, 'La Cuesta');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 10, 6, 'Canoas');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 10, 6, 'Laurel');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 11, 6, 'Jaco');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 11, 6, 'Tarcoles');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 1, 7, 'Limon');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 1, 7, 'Valle la Estrella');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 1, 7, 'Rio Blanco');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 1, 7, 'Matama');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 2, 7, 'Guapiles');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 2, 7, 'Jimenez');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 2, 7, 'Rita');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 2, 7, 'Roxana');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 2, 7, 'Cariari');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 2, 7, 'Colorado');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 3, 7, 'Siquirres');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 3, 7, 'Pacuarito');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 3, 7, 'Florida');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 3, 7, 'Germania');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 3, 7, 'Cairo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (6, 3, 7, 'Alegria');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (7, 4, 7, 'Bratsi');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (8, 4, 7, 'Sixaola');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (9, 4, 7, 'Cahuita');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 5, 7, 'Matina');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 5, 7, 'Batan');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 5, 7, 'Carrandi');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (1, 6, 7, 'Guacimo');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (2, 6, 7, 'Mercedes');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (3, 6, 7, 'Pocora');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (4, 6, 7, 'Rio Jimenez');
INSERT INTO distrito (numerodistrito, numerocanton, numeroprovincia, nombre) VALUES (5, 6, 7, 'Duacari');


--
-- TOC entry 2122 (class 0 OID 17146)
-- Dependencies: 184
-- Data for Name: emisor; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2119 (class 0 OID 17098)
-- Dependencies: 181
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO provincia (numeroprovincia, nombre) VALUES (1, 'San Jose');
INSERT INTO provincia (numeroprovincia, nombre) VALUES (2, 'Alajuela');
INSERT INTO provincia (numeroprovincia, nombre) VALUES (3, 'Cartago');
INSERT INTO provincia (numeroprovincia, nombre) VALUES (4, 'Heredia');
INSERT INTO provincia (numeroprovincia, nombre) VALUES (5, 'Guanacaste');
INSERT INTO provincia (numeroprovincia, nombre) VALUES (6, 'Puntarenas');
INSERT INTO provincia (numeroprovincia, nombre) VALUES (7, 'Limon');


--
-- TOC entry 2123 (class 0 OID 17152)
-- Dependencies: 185
-- Data for Name: receptor; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2000 (class 2606 OID 17107)
-- Name: pkcanton; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY canton
    ADD CONSTRAINT pkcanton PRIMARY KEY (numeroprovincia, numerocanton);


--
-- TOC entry 2002 (class 2606 OID 17117)
-- Name: pkdistrito; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY distrito
    ADD CONSTRAINT pkdistrito PRIMARY KEY (numerodistrito, numerocanton, numeroprovincia);


--
-- TOC entry 1998 (class 2606 OID 17102)
-- Name: pkprovincia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincia
    ADD CONSTRAINT pkprovincia PRIMARY KEY (numeroprovincia);


--
-- TOC entry 2003 (class 2606 OID 17108)
-- Name: fkcanton; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY canton
    ADD CONSTRAINT fkcanton FOREIGN KEY (numeroprovincia) REFERENCES provincia(numeroprovincia);


--
-- TOC entry 2004 (class 2606 OID 17118)
-- Name: fkdistrito; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY distrito
    ADD CONSTRAINT fkdistrito FOREIGN KEY (numeroprovincia, numerocanton) REFERENCES canton(numeroprovincia, numerocanton);


--
-- TOC entry 2130 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--
/* yyug*/
REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-07-09 19:15:18

--
-- PostgreSQL database dump complete


--

