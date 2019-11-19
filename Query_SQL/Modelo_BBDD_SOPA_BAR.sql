
-- CREAR LA TABLA DE FACTURA
CREATE TABLE FACTURA
(
    clave VARCHAR(50) NOT NULL,
    factura_numeroConsecutivo VARCHAR(20) NOT NULL,
    fechaEmision TIMESTAMP NOT NULL DEFAULT current_timestamp,
    emisor_numero VARCHAR(12) NOT NULL,
    receptor_numero VARCHAR(12) NOT NULL,
    condicionVenta VARCHAR(2) NOT NULL,
    plazoCredito VARCHAR(10) NULL,
    medioPago VARCHAR(2) NOT NULL,
    lineaDetalle_numeroLinea INT NOT NULL,
    tipo_codigo VARCHAR(2),
    codigo VARCHAR(20),
    cantidad DECIMAL(16,3),
     unidadMedia VARCHAR(15),
     unidadMediaComercial VARCHAR(20),
     detalle TEXT,
     precioUnitario DECIMAL(18,5),
     montoTotal DECIMAL(18,5),
     montoDescuento DECIMAL(18,5),
     naturalezaDescuento VARCHAR(80),
     subTotal DECIMAL(18,5),
     impuesto_Codigo VARCHAR(2),
     impuesto_Tarifa DECIMAL(4,2),
     impuesto_Monto  DECIMAL(18,5),
     Exoneracion_tipoDocumento VARCHAR(2),
     Exoneracion_numeroDocumento VARCHAR(17),
     exoneracion_nombreInstitucion VARCHAR(100),
     exoneracion_fechaEmision TIMESTAMP,
     exoneracion_montoImpuesto DECIMAL(18,5),
     exoneracion_porcentajeCompra NUMERIC(3),
     montoTotalLinea DECIMAL(18,5),
     resumenFactura_codigoMoneda VARCHAR(3),
     resumenFactura_tipoCambio DECIMAL(18,2),
     resumenFactura_totalServExentos DECIMAL(18,2),
     resumenFactura_totalMercanciasGrabadas DECIMAL(18,2),
     resumenFactura_totalMercanciasExternas DECIMAL(18,2),
     resumenFactura_totalGravado DECIMAL(18,2),
     resumenFactura_totalExento DECIMAL(18,2),
     resumenFactura_totalVenta DECIMAL(18,2),
     resumenFactura_totalDescuentos DECIMAL(18,2),
     resumenFactura_totalVentaNeta DECIMAL(18,2),
     resumenFactura_totalImpuesto DECIMAL(18,2),
     resumenFactura_totalComprobante DECIMAL(18,2),
     informacionReferencia_tipoDoc VARCHAR(2),
     informacionReferencia_Numero VARCHAR(50),
     informacionReferencia_fechaEmision TIMESTAMP DEFAULT current_timestamp,
     informacionReferencia_Codigo VARCHAR(2),
     informacionReferencia_Razon VARCHAR(180),   


     normativa_numeroResolucion VARCHAR(13),
     normativa_fechaResolucion VARCHAR(20),

     otros_otroTexto TEXT,
     otros_otroContenido TEXT,

     ds_Signature_clave_factura VARCHAR(50),
     ds_Signature_numeroCedulaEmisor NUMERIC(12),
     ds_Signature_fechaEmisionDoc TIMESTAMP,
     ds_Signature_Mensaje NUMERIC(1),
      ds_Signature_detalleMensaje VARCHAR(80),
     ds_Signature_montoTotalImpuesto DECIMAL(18,5), 
    ds_Signature_totalFaactura DECIMAL(18,5),
     ds_Signature_numeroCedulaReceptor NUMERIC(12),
     ds_Signature_numConsecutivoReceptor VARCHAR(20),
    ds_Signature_firmaElectronica VARCHAR,

    /*FORMATO DE USO EXCLUSIVO POR PARTE DE LA DIRECCIÓN GENERAL DE TRIBUTACIÓN UNA VEZ TERMINADO EL PROCESO DE VALIDACIÓN*/
    clave_comprobante VARCHAR(50),
    nombreEmisor_comprobante VARCHAR(80),
    tipoIdentificacioEmisor VARCHAR(2),
    numeroCedulaEmisor_comprobante NUMERIC(12),
    nombreReceptor_comprobante VARCHAR(80),
    tipoIdentificacioReceptor VARCHAR(2),
    numeroCedulaReceptor_Comprobante NUMERIC(12),
    mensaje_Comprobante NUMERIC(1),
    detalleMensaje_Comprobante TEXT,
    montoTotalImpuesto_comprobante DECIMAL(18,5),
    totalfactura_comprobante DECIMAL(18,5),
    ds_Signature_firmaElectronicaComprobante VARCHAR,

    /*-----------------------------*/
    --idCuenta int,
    --idEmpleado int,
    --idPeriodoVenta int,
    --fechaRegistroFactura timestamp default current_timestamp,
    --formaPago char(10),
    --subTotal decimal(10,2),
    --porcentajeDescuento decimal(5,2),
    --cantidadPersonas int,
   -- estadoFactura smallint default 1,
    primary key (clave)
);
-- A LA FACTURA LE GENERAMOS UNA FK PARA LA CUENTA
--ALTER TABLE FACTURA ADD FOREIGN KEY (idCuenta) REFERENCES CUENTA(idCuenta);
-- A LA FACTURA LE GENERAMOS UNA FK PARA EL EMPLEADO
--ALTER TABLE FACTURA ADD FOREIGN KEY (idEmpleado) REFERENCES EMPLEADO(idEmpleado);
-- A LA FACTURA LE GENERAMOS UNA FK PARA EL PERIDO DE VENTA
--ALTER TABLE FACTURA ADD FOREIGN KEY (idPeriodoVenta) REFERENCES PERIODOVENTA(idPeriodoVenta);
ALTER TABLE FACTURA ADD FOREIGN KEY (emisor_numero) REFERENCES emisor(emisor_numero);
ALTER TABLE FACTURA ADD FOREIGN KEY (receptor_numero) REFERENCES receptor(receptor_numero);





INSERT INTO distrito(codigo_distrito, codigo_canton, nombre_distrito) VALUES(1001, 101, 'Carmen'), (1002, 101, 'Merced'),(1003, 101, 'Hospital'), 
                                          (1004, 101, 'Catedral'), (1005, 101, 'Zapote'),
                                                                             (1006, 101, 'San Francisco de Dos Ríos'), (1007, 101, 'Uruca'), (1008, 101, 'Mata Redonda'),
                                         (1009, 101, 'Pavas'), (1010, 101, 'Hatillo'), (1011, 101, 'San Sebastián'),
                                         (1012, 102, 'Escazú'),(1013, 102, 'San Antonio'), (1014, 102, 'San Rafael'),
                                         (1015, 103, 'Desamparados'), (1016, 103, 'San Miguel'), (1017, 103, 'San Juan de Dios'),
                                         (1018, 103, 'San Rafael Arriba'), (1019, 103, 'San Antonio'), (1020, 103, 'Frailes'), 
                                         (1021, 103, 'Patarrá'), (1022, 103, 'San cristóbal'), (1023, 103, 'Rosario'), 
                                         (1024, 103, 'Damas'), (1025, 103, 'San Rafael Abajo'), (1026, 103, 'Gravillas')
                                         (1027, 103, 'Los Guido')
                                         (1028, 104, 'Santiago'), (1029, 104, 'Mercedes Sur'),(1030, 104, 'Barbacoas'),
                                         (1031, 104, 'Grifo Alto'), (1032, 104, 'San rafael'), (1033, 104, 'Csndelarita'),
                                         (1034, 104, 'Desamparaditos'), (1035, 104, 'San Antonio'), (1036, 104, 'Chires')
                                         (1037, 104, 'La Cangreja')
                                         (1038, 105, 'San Marcos'), (1039, 105, 'San Lorenzo'),(1040, 105, 'San Carlos'),
                                         (1041, 106, 'Aserrí'), (1042, 106, 'Tarbaca'), (1043, 106, 'Vuelta de Jorco'),
                                         (1044, 106, 'San Gabriel'), (1045, 106, 'Legua'), (1046, 106, 'Monterrey'),
                                         (1047, 106, 'Salitrillos'),
                                         (1048, 107, 'Cuidad Colón'),(1049, 107, 'Guayabo'),(1050, 107, 'Tabarcia'), 
                                         (1051, 107, 'Piedras Negras'), (1052, 107, 'Picagres'), (1053, 107, 'Jaris'),
                                         (1054, 107, 'Quitirrisí');
                                         (1055, 108, 'Guadalupe'), (1056, 108, 'San Francisco'), (1057, 108, 'Calle Blancos'),
                                         (1058, 108, 'Mata de Plátano'), (1059, 108, 'Ipís'), (1060, 108, 'Rancho Redondo'),
                                         (1061, 108, 'Purral'),
                                         (1062, 109, 'Santa Ana'), (1063, 109, 'Salitral'), (1064,109, 'Pozos'), (1065,109, 'Uruca'),
                                         (1066,109, 'Piedades'), (1067,109, 'Brasil'),
                                         (1068,110, 'Alajuelita'), (1069,110, 'San Josecito'), (1070,110, 'San Antonio'),
                                         (1071,110, 'Concepción'), (1072,110, 'San Felipe'),
                                         (1073,111, 'San Isidro'), (1074,111, 'San Rafael'), (1075,111, 'Dulce Nombre de Jesús'),
                                         (1076,111, 'Patalillo'), (1077,111, 'Cascajal'),
                                         (1078,112, 'San Ignacio'), (1079,112, 'Guaitil'), (1080,112, 'Palmichal'),
                                         (1081,112, 'Cangrejal'), (1082,112, 'Sabanillas'),
                                         (1083,113, 'San Juan'), (1084,113, 'Cinco Esquinas'), (1085,113, 'Anselmo Llorente'),
                                         (1086,113, 'León XIII'), (1087,113, 'Colima'), 
                                         (1088,114, 'San Vicente'), (1089,114, 'San Jerónimo'), (1090,114, 'Trinidad'),
                                         (1091,115, 'San Pedro'), (1092,115, 'Sabanilla'), (1093,115, 'Mercedes'),
                                         (1094,115, 'San Rafael'),
                                         (1095,116, 'San Pablo'), (1096,116, 'San Pedro'), (1097,116, 'San Juan de Mata'),
                                         (1098,116, 'San Luis'), (1099,116, 'Carara'),
                                         (1100,117, 'Santa María'), (1101,117, 'Jardín'), (1102,117, 'Copey'),
                                         (1103,118, 'Curridabat'), (1104,118, 'Granadilla'), (1105,118, 'Sánchez'),
                                         (1106,118, 'Tirrases'),
                                         (1107,119, 'San Isidro de EL General'), (1108,119, 'El General'), (1109,119, 'Daniel Flores'),
                                         (1110,119, 'Rivas'), (1111,119, 'San Pedro'), (1112,119, 'Platanares'), (1113,119, 'Pejibaye'),
                                         (1114,119, 'Cajón'), (1115,119, 'Barú'), (1116,119, 'Río Nuevo'), (1117,119, 'Páramo'),
                                         (1118,119, 'La Amistad'),
                                         (1119,120, 'San Pablo'), (1120,120, 'San Andrés'), (1121,120, 'Llano Bonito'),
                                          (1122,120, 'San Isidro'), (1123,120, 'Santa Cruz'), (1124,120, 'San Antonio');

INSERT INTO distrito(codigo_distrito, codigo_canton, nombre_distrito) 
VALUES(2001, 201,'Alajuela'), (2002, 201,'San José'),
        (2003, 201,'Carrizal'), (2004, 201,'San Antonio'), (2005, 201,'Guácima'),
        (2006, 201,'San Isidro'), (2007, 201,'Sabanilla'), (2008, 201,'San Rafael'),
        (2009, 201,'Río Segundo'), (2010, 201,'Desamparados'), (2011, 201,'Turrúcares'),
        (2012, 201,'Tambor'), (2013, 201,'Garita'), (2014, 201,'Sarapiquí'),
        (2015, 202,'San Ramón'), (2016, 202,'Santiago'), (2017, 202,'San Juan'),
        (2018, 202,'Piedades Norte'), (2019, 202,'Piedades Sur'), (2020, 202,'San Rafael'),
        (2021, 202,'San Isidro'), (2022, 202,'Ángeles'), (2023, 202,'Alfaro'), 
        (2024, 202,'Volio'), (2025, 202,'Concepción'), (2026, 202,'Zapotal'),
    (2027, 202,'Peñas Blancas'), (2028, 202,'San Lorenzo'),
    (2029, 203,'Grecia'), (2030, 203,'San Isidro'), (2031, 203,'San José'),
    (2032, 203,'San Roque'), (2033, 203,'Tacares'), (2034, 203,'Puente de Piedra'),
    (2035, 203,'Bolivar'),
    (2036, 204,'San Mateo'), (2037, 204,'Desmonte'), (2038, 204,'Jesús María'),
    (2039, 204,'Labrador'),
    (2040, 205,'Atenas'), (2041, 205,'Jesús'), (2042, 205,'Mercedes'), (2043, 205,'San Isidro'),
    (2044, 205,'Concepción'), (2045, 205,'San José'), (2046, 205,'Santa Eulalia'),
    (2047, 205,'Escobal'),
     (2048, 206,'Naranjo'), (2049, 206,'San Miguel'), (2050, 206,'San José'), (2051, 206,'Cirrí'),
    (2052, 206,'San Jerónimo'),(2053, 206,'San Juan'), (2054, 206,'El Rosario'), 
    (2055, 206,'Palmitos'),
    (2056, 207,'Palamares'), (2057, 207,'Zaragoza'), (2058, 207,'Buenos Aires'),
    (2059, 207,'Santiago'), (2060, 207,'Candelaria'), (2061, 207,'Esquipulas'),
    (2062, 207,'La Granja'), (2063, 208,'San Pedro'), (2064, 208,'San Juan'), 
    (2065, 208,'San Rafael'), (2066, 208,'Carrillos'), (2067, 208,'Sabana Redonda'),
    (2068, 209,'Orotina'), (2069, 209,'Mastate'), (2070, 209,'Hacienda Vieja'),
    (2071, 209,'Coyolar'), (2072, 209,'La Ceiba'),
    (2073, 210,'Quesada'), (2074, 210,'Florencia'), (2075, 210,'Buenavista'),
    (2076, 210,'Aguas Zarcas'), (2077, 210,'Venecia'), (2078, 210,'Pital'),
    (2079, 210,'La Fortuna'), (2080, 210,'La Tigra'), (2081, 210,'La Palmera'),
    (2082, 210,'Venado'),(2083, 210,'Cutris'), (2084, 210,'Monterrey'),
    (2085, 210,'Pocosol'),(2086, 211,'Zarcero'),(2087, 211,'Laguna'), (2088, 211,'Tapezco'),
    (2089, 211,'Guadalupe'), (2090, 211,'Palmira'), (2091, 211,'Zapote'), (2092, 211,'Brisas'),
    (2093, 212,'Sarchí Norte'), (2094, 212,'Sarchí Sur'), (2095, 212,'Toro Amarillo'),
    (2096, 212,'San Pedro'), (2097, 212,'Rodríguez'),
    (2098, 213,'Upala'), (2099, 213,'Aguas Claras'), (2100, 213,'San José(Pizote)'),
    (2101, 213,'Bijagua'),(2102, 213,'Delicias'), (2103, 213,'Dos Ríos'), (2104, 213,'Yolillal'),
    (2105, 213,'Canalete'),
    (2106, 214,'Los Chiles'),(2107, 214,'Caño Negro'), (2108, 214,'El Amparo'), (2109, 214,'San Jorge'),
    (2110, 215,'San Rafael'), (2111, 215,'Buenavista'), (2112, 215,'Cote'), (2113, 215,'Katira'),
    (2114, 216,'Río Cuarto'),

INSERT INTO distrito(codigo_distrito,codigo_canton,nombre_distrito)  VALUES  
        (3001, 301,'Oriental'), (3002, 301,'Occidental'), (3003, 301,'Carmen'), (3004, 301,'San Nicolás'),
        (3005, 301,'Agua Caliente(San Francisco)'), (3006, 301,'Guadalupe(Arenilla)'), (3007, 301,'Corralillo'),
        (3008, 301,'Tierra Blanca'),(3009, 301,'Dulce Nombre'), (3010, 301,'Llano Grande'),
        (3011, 301,'Quebradilla'),
        (3012, 302,'Paraíso'), (3013, 302,'Santiago de Paraíso'), (3014, 302,'Orosi'),
        (3015, 302,'Cachí'), (3016, 302,'Llanos de Santa Lucía'),
        (3017, 303,'Tres Ríos'), (3018, 303,'San Diego'), (3019, 303,'San Juan'),(3020, 303,'San Rafael'),
        (3021, 303,'Concepción'), (3022, 303,'Dulce Nombre'), (3023, 303,'San Ramón'), (3024, 303,'Río Azul'),
        (3025, 304,'Juan Viñas'), (3026, 304,'Tucurrique'), (3027, 304,'Pejibaye'), 
        (3028, 305,'Turrialba'), (3029, 305,'La Suiza'), (3030, 305,'Peralta'), (3031, 305,'Santa Cruz'),
        (3032, 305,'Santa Teresita'), (3033, 305,'Pavones'), (3034, 305,'Tuis'), (3035, 305,'Tayutic'),
        (3036, 305,'Santa Rosa'), (3037, 305,'Tres Equis'), (3038, 305,'La Isabel'), (3039, 305,'Chirripó'),
        (3040, 306,'Pacayas'), (3041, 306,'Cervantes'), (3042, 306,'Cepellades'),
        (3043, 307,'San Rafael'), (3044, 307,'Cot'), (3045, 307,'Potrero Cerrado'), (3046, 307,'Cipreses'),
        (3047, 307,'Santa Rosa'),
        (3048, 308,'Tejar'), (3049, 308,'San Isidro'), (3050, 308,'San Rafael'), (3051, 308,'Patito de Agua');


 
 
 
INSERT INTO distrito(codigo_distrito,codigo_canton,nombre_distrito)  VALUES 
        (4001, 401,'Heredia'), (4002, 401,'Mercedes'),(4003, 401,'San Francisco'), (4004, 401,'Ulloa'),
        (4005, 401,'Vara Blanca'),
        (4006, 402,'Barva'), (4007, 402,'San Pedro'), (4008, 402,'San Pablo'), (4009, 402,'San Roque'),
        (4010, 402,'Santa Lucía'), (4011, 402,'San José de la Montaña'),
        (4012, 403,'Santo Domingo'), (4013, 403,'San Vicente'), (4014, 403,'San Miguel'),
        (4015, 403,'Paracito'), (4016, 403,'Santo Tomás'), (4017, 403,'Santa Rosa'), (4018, 403,'Tures'),
        (4019, 403,'Pará'),
        (4020, 404,'Santa Bárbara'), (4021, 404,'San Pedro'), (4022, 404,'San Juan'), (4023, 404,'Jesús'),
        (4024, 404,'Santo Domingo'), (4025, 404,'Purabá'), 
        (4026, 405,'San Rafael'), (4027, 405,'San Josecito'), (4028, 405,'Santiago'), (4029, 405,'Ángeles'),
        (4030, 405,'Concepción'),
        (4031, 406,'San Isidro'), (4032, 406,'San José'), (4033, 406,'Concepción'), (4034, 406,'San Francisco'),
        (4035, 407,'San Antonio'), (4036, 407,'La Ribera'), (4037, 407,'La Asunción'),
        (4038, 408,'San Joaquín'), (4039, 408,'Barrantes'), (4040, 408,'Llorente'), 
        (4041, 409,'San Pablo'),(4042, 409,'Rincón de Sabanilla'),
        (4043, 410,'Puerto Viejo'),(4044, 410,'La Virgen'), (4045, 410,'Horquetas'), (4046, 410,'Llanuras del Gaspar'),
        (4047, 410,'Cureña');




INSERT INTO distrito(codigo_distrito, codigo_canton, nombre_distrito) VALUES 
     (5001, 501, 'Liberia'), (5002, 501, 'Cañas Dulces'), (5003, 501, 'Mayorga'), (5004, 501, 'Nacascolo'),
     (5005, 501, 'Curudandé'), 
     (5006, 502, 'Nicoya'), (5007, 502, 'Mansión'), (5008, 502, 'San Antonio'), (5009, 502, 'Quebrada Honda'),
     (5010, 502, 'Sámara'), (5011, 502, 'Nosara'), (5012, 502, 'Belén de Nosarita'),
     (5013, 503, 'Santa Cruz'), (5014, 503, 'Bolsón'), (5015, 503, 'Veintisiete de Abril'), (5016, 503, 'Tempate'),
     (5017, 503, 'Cartagena'), (5018, 503, 'Cuanijiquil'), (5019, 503, 'Diriá'), (5020, 503, 'Cabo Velas'), 
     (5021, 503, 'Tamarindo'),
     (5022, 504, 'Bagaces'), (5023, 504, 'La Fortuna'), (5024, 504, 'Mogote'), (5025, 504, 'Río Naranjo'),
     (5026, 505, 'Filadelfia'), (5027, 505, 'Palmira'), (5028, 505, 'Sardinal'), (5029, 505, 'Belén'),
     (5030, 506, 'Cañas'), (5031, 506, 'Palmira'), (5032, 506, 'San Miguel'), (5033, 506, 'Bebedero'),
     (5034, 506, 'Porozal'), 
     (5035, 507, 'Las Juntas'), (5036, 507, 'Sierra'), (5037, 507, 'San Juan'), (5038, 507, 'Colorado'),
     (5039, 508, 'Tilarán'), (5040, 508, 'Quebrada Grande'), (5041, 508, 'Tronadora'), (5042, 508, 'Santa Rosa'),
     (5043, 508, 'Líbano'), (5044, 508, 'Tierras Morenas'), (5045, 508, 'Arenal'),
     (5046, 509, 'Carmona'), (5047, 509, 'Santa Rita'), (5048, 509, 'Zapotal'), (5049, 509, 'San Pablo'),
     (5050, 509, 'Provenir'), (5051, 509, 'Bejuco'),
     (5052, 510, 'La Cruz'), (5053, 510, 'Santa Cecilia'), (5054, 510, 'La Garita'), (5055, 510, 'Santa Elena'),
     (5056, 511, 'Hojancha'), (5057, 511, 'Monte Romo'), (5058, 511, 'Puerto Carrillo'), (5059, 511, 'Huacas'),
     (5060, 511, 'Matambú');
        
        
INSERT INTO distrito(codigo_distrito, codigo_canton, nombre_distrito) VALUES 
     (6001, 601, 'Puntarenas'), 6002, 601, 'Pitahaya'), 6003, 601, 'Chomes'), (6004, 601, 'Lepanto'),
     (6005, 601, 'Paquera'),(6006, 601, 'Manzanillo'), 6007, 601, 'Guacimal'), (6008, 601, 'Barranca'), 
     (6009, 601, 'Monteverde'),
     (6010, 601, 'Isla del Coco'), (6011, 601, 'Cóbano'), (6012, (601, 'Chacarita'),
     (6013, 601, 'Chira'), (6014, 601, 'Acapulco'), (6015, 601, 'El Roble'), (6016, 601, 'Arancibia'),
     (6017, 602, 'Espíritu Santo'), (6018, 602, 'San Juan Grande'), (6019, 602, 'Macacona'), (6020, 602, 'San Rafael'), 
     (6021, 602, 'San Jerónimo'),(
     (6022, 602, 'Caldera'), (6023, 603, 'Buenos Aires'), (6024, 603, 'Volcán'), (6025, 603, 'Potrero Grande'),
     (6026, 603, 'Boruca'),( 6027, 603, 'Pilas'), (6028, 603, 'Colinas'), (6029, 603, 'Chánguena'),
     (6030, 603, 'Biolley'), (6031, 603, 'Brunka'), (6032, 604, 'San Miguel'), (6033, 604, 'Bebedero'),
     (6034, 604, 'Porozal'), 
     (6035, 605, 'Cortés'), (6036, 605, 'Palmar'), (6037, 605, 'Sierpe'), (6038, 605, ' Bahía Ballena'),
     (6039, 605, 'Piedras Blancas'), (6040, 605, 'Bahía Drake'), 
     (6041, 606, 'Quepos'), 6042, 606, 'Savegre'),(6043, 606, 'Naranjito'), 
     (6044, 607, 'Golfito'), (6045, 607, 'Puerto Jiménez'),
     (6046, 607, 'Guaycará'), (6047, 607, 'Pavón'), 
     (6048, 608, 'San Vito'), (6049, 608, 'Sabalito'),
     (6050, 608, 'Aguabuena'),( 6051, 608, 'Limoncito'),
     (6052, 608, 'Pittier'), (6053, 608, 'Gutiérrez Brown'), (6054, 619, 'Parrita'), (6055, 610, 'Corredor'),
     (6056, 610, 'La Cuesta'), (6057, 611, 'Paso Canoas'),( 6058, 611, 'Laurel'), (6059, 611, 'Jacó'),
     (6060, 611, 'Tárcoles');
        
 
 
INSERT INTO distrito(codigo_distrito, codigo_canton, nombre_distrito) VALUES
            (7001, 701,'Limón'), (7002, 701,'Valle La Estrella'), (7003, 701,'Río Blanco'), (7004, 701,'Matama'),
            (7005, 702,'Guápiles'), (7006, 702,'Jiménez'), (7007, 707,'La Rita'), (7008, 702,'Roxana'),
            (7009, 702,'Cariari'),  (7010, 702,'Colorado'), (7011, 702,'La Colonia'),
            (7012, 703,'Siquirres'), (7013, 703,'Pacuarito'), (7014, 703,'Florida'), (7015, 703,'Germania'),
            (7016, 703,'Cairo'), (7017, 703,'Alegría'), 
            (7018, 704,'Bratsi'),(7019, 704,'Sixaola'),(7020, 704,'Cahuita'), (7021, 704,'Telire'),
            (7022, 705,'Matina'), (7023, 705,'Batán'), (7024, 705,'Carrandi')
            (7025, 706,'Guácimo'), (7026, 706,'Mercedes'), (7027, 706,'Pocora'), (7028, 706,'Río Jiménez'),
            (7029, 706,'Duacari');