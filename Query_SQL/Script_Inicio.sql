SELECT * FROM public.cliente;
SELECT * FROM public.cuenta;
SELECT * FROM public.tipogasto;
SELECT * FROM public.gasto;
SELECT * FROM public.puesto;
SELECT * FROM public.empleado;
SELECT * FROM public.periodoventa;
SELECT * FROM public.categoria;
SELECT * FROM public.producto;
SELECT * FROM public.categoriainventario;
SELECT * FROM public.inventario;
SELECT * FROM public.inventarioproducto;
SELECT * FROM public.proveedor;
SELECT * FROM public.proveedorinventario;
SELECT * FROM public.orden;
SELECT * FROM public.factura;

DELETE FROM ORDEN;
DELETE FROM INVENTARIOPRODUCTO;
DELETE FROM PRODUCTO;
DELETE FROM CATEGORIA;
-- DELETE FROM CUENTA;
-- DELETE FROM CLIENTE;
-- DELETE FROM EMPLEADO;
-- DELETE FROM PUESTO;
DELETE FROM FACTURA;
DELETE FROM TIPOGASTO;
DELETE FROM GASTO;
DELETE FROM PROVEEDORINVENTARIO;
DELETE FROM PROVEEDOR;
DELETE FROM INVENTARIO;
DELETE FROM CATEGORIAINVENTARIO;
DELETE FROM PERIODOVENTA;

ALTER SEQUENCE public.categoria_idcategoria_seq restart 1;
ALTER SEQUENCE public.categoriainventario_idcategoriainventario_seq restart 1;
-- ALTER SEQUENCE public.cliente_idcliente_seq restart 1;
-- ALTER SEQUENCE public.cuenta_idcuenta_seq restart 1;
-- ALTER SEQUENCE public.empleado_idempleado_seq restart 1;
ALTER SEQUENCE public.factura_idfactura_seq restart 1;
ALTER SEQUENCE public.inventario_idinventario_seq restart 1;
ALTER SEQUENCE public.gasto_idgasto_seq restart 1;
ALTER SEQUENCE public.orden_idorden_seq restart 1;
ALTER SEQUENCE public.periodoventa_idperiodoventa_seq restart 1;
ALTER SEQUENCE public.producto_idproducto_seq restart 1;
ALTER SEQUENCE public.proveedor_idproveedor_seq restart 1;
-- ALTER SEQUENCE public.puesto_idpuesto_seq restart 1;
ALTER SEQUENCE public.tipogasto_idtipogasto_seq restart 1;

-- Insertar Tipos de Gastos
INSERT INTO public.tipogasto(descripciontipogasto)
	VALUES ('Inventario Bebidas');

-- Insertar Período de Venta
INSERT INTO public.periodoventa(nombreperiodoventa)
	VALUES ('Periodo Inicio');
    
-- Insertar Categorias
INSERT INTO public.categoria(descripcioncategoria)
	VALUES ('Ron'), ('Vodka'), ('Whisky'), ('Cacique'), ('Tequila'), ('Jager'), ('Especiales');
            
-- Insertar Productos
INSERT INTO public.producto(descripcionproducto, idcategoria, precioproducto)
	VALUES  ('Pina Colada', 	 1, 4000),
    		('Daiquiri Fresa', 	 1, 4000),
    		('Hurricane', 		 1, 4000),
    		('Sueno Rosado', 	 1, 4000),
    		('Pasion Tropical',  1, 4000),
    		('Blue Lagoon', 	 2, 4000),
    		('Sex On The Beach', 2, 4000),
    		('Conga',          	 2, 4000),
    		('Destornillador', 	 2, 4000),
    		('Manhattan', 		 3, 4500),
    		('Whisky Sour', 	 3, 4500),
    		('Chili Birra',		 4, 3500),
    		('Chepe De Noche',	 4, 3500),
    		('Jugo de Pina',	 4, 3500),
    		('Nieve de Cacique', 4, 3500),
    		('Margarita',		 5, 4000),
    		('Tequila Sunrise',	 5, 4000),
    		('Vertigo',			 5, 4000),
    		('Te Jager',		 6, 4500),
    		('Bob Dylan',		 6, 4500),
    		('Sangre Negra',	 6, 4500),
    		('Ciervo Dulce',	 6, 4500),
    		('Chiliguaro',		 7, 3500),
    		('Hasta Nunca',		 7, 4500),
    		('Bomba Atomica',	 7, 4500),
    		('Iguana',			 7, 4500),
    		('Malibu Surf',		 7, 4500),
    		('Grasshopper',		 7, 4500),
    		('Coco-Nuts',		 7, 4500),
    		('Michelada',		 7, 4500),
            ('Extra Ron',        1, 1000),
            ('Extra Whisky',     3, 1000),
            ('Extra Vodka',      2, 1000),
            ('Extra Cacique',    4, 1000),
            ('Extra Tequila',    5, 1000),
            ('Extra Jager',      6, 1000);

-- Insertar Categorias de Inventario
INSERT INTO public.categoriainventario(descripcioncategoriainventario)
	VALUES ('Consumibles'), ('Desechables'), ('Licor'), ('Frescos'), ('Gaseosos'), ('Hielo'), ('Jugos y Cremas');

-- Insertar Inventarios    
INSERT INTO public.inventario(descripcioninventario, costoinventario, cantidaddisponibleinventario, cantidadminimainventario, idcategoriainventario, unidad) VALUES 
            ('Azucar',               20,  350,  150,  1,  'Onzas'),
            ('Salsa Inglesa',        66,  135,   50,  1,  'Onzas'),
            ('Tabasco',              53,  400,  100,  1,  'Onzas'),
            ('Pimienta',             12,   90,   30,  1,  'Onzas'),
            ('Sal',                  12,   90,   30,  1,  'Onzas'),
            ('Helado Vainilla',      25,  200,   50,  1,  'Onzas'),
            ('Botellita 500ml',     258,  210,   30,  2,  'Unidad'),
            ('Postal',               24, 5000, 1000,  2,  'Unidad'),
            ('Pajilla',               4, 1500,  300,  2,  'Unidad'),
            ('Tapa',                 13, 3120,  620,  2,  'Unidad'),
            ('Vaso',                 55, 2000,  200,  2,  'Unidad'),
            ('Vodka',               132,  423,  123,  3,  'Onzas'),
            ('Ron Blanco',          170,  423,  123,  3,  'Onzas'),
            ('Cacique',             149,  423,  123,  3,  'Onzas'),
            ('Tequila',             295,  423,  123,  3,  'Onzas'),
            ('Jager',               346,  212,   50,  3,  'Onzas'),
            ('Blue Curacao',        136,  212,   50,  3,  'Onzas'),
            ('Triple Sec',          136,  141,   41,  3,  'Onzas'),
            ('Whisky',              288,  141,   41,  3,  'Onzas'),
            ('Licor de Melocoton',  316,  106,   35,  3,  'Onzas'),
            ('Malibu',              268,  141,   41,  3,  'Onzas'),
            ('Vermouth Seco',       268,  141,   41,  3,  'Onzas'),
            ('Vino de Nance',        60,  159,   49,  3,  'Onzas'),
            ('Crema de Menta',      152,  159,   49,  3,  'Onzas'),
            ('Cerveza',             666,   45,   15,  3,  'Unidad'),
            ('Hierbabuena',           8,   70,   15,  4,  'Onzas'),
            ('Limon',                94,  160,   30,  4,  'Unidad'),
            ('Soda',                 20,  423,  123,  5,  'Onzas'),
            ('Coca Cola',            22,  423,  123,  5,  'Onzas'),
            ('Sprite',               22,  423,  123,  5,  'Onzas'),
            ('Hielo',                 6, 2822,  800,  6,  'Onzas'),
            ('Granadina',            66,  211,   50,  7,  'Onzas'),
            ('Jugo de Naranja',      25,  423,  123,  7,  'Onzas'),
            ('Jugo de Pina',         22,  423,  123,  7,  'Onzas'),
            ('Crema de Coco',        58, 1199,  199,  7,  'Onzas'),
            ('Jugo de Arandano',     47,  423,  123,  7,  'Onzas'),
            ('Jugo de Maracuya',      9, 1068,  168,  7,  'Onzas'),
            ('Leche Evaporada',      56,  212,   50,  7,  'Onzas'),
            ('Pulpa Fresa',          12, 1068,  168,  7,  'Onzas'),
            ('Leche',                31,  141,   41,  7,  'Onzas'),
            ('Sirope de Cola',       26,  134,   38,  7,  'Onzas'),
            ('Limonada',              5,  882,   92,  7,  'Onzas'),
            ('Jugo de Tomate',       22,  423,  123,  7,  'Onzas'),
            ('Te Frio',               5,  882,   92,  7,  'Onzas');
  
-- Insertar Inventario Producto
INSERT INTO public.inventarioproducto(idproducto, idinventario, cantidadnecesaria)
	VALUES (1,35,3), (1,13,3), (1,34,10),                              (1,31,16), (1,11,1), (1,8,1), (1,10,1), (1,9,1), 
           (2,27,1), (2,13,3), (2,39,12), (2,1,2),                     (2,31,16), (2,11,1), (2,8,1), (2,10,1), (2,9,1), 
           (3,32,1), (3,1,2), (3,33,6), (3,37,6), (3,27,1), (3,13,3),  (3,31,16), (3,11,1), (3,8,1), (3,10,1), (3,9,1), 
           (4,39,3), (4,40,9), (4,1,2), (4,13,3),                      (4,31,16), (4,11,1), (4,8,1), (4,10,1), (4,9,1), 
           (5,42,5), (5,37,8), (5,13,3),                               (5,31,16), (5,11,1), (5,8,1), (5,10,1), (5,9,1), 
           (6,17,1), (6,42,12), (6,12,3),                              (6,31,16), (6,11,1), (6,8,1), (6,10,1), (6,9,1), 
           (7,32,1), (7,33,10), (7,20,1), (7,12,3),                    (7,31,16), (7,11,1), (7,8,1), (7,10,1), (7,9,1), 
           (8,42,3), (8,33,6), (8,34,3), (8,12,4),                     (8,31,16), (8,11,1), (8,8,1), (8,10,1), (8,9,1), 
           (9,12,3), (9,33,12),                                        (9,31,16), (9,11,1), (9,8,1), (9,10,1), (9,9,1), 
           (10,22,3), (10,19,3), (10,36,10),                          (10,31,16), (10,11,1), (10,8,1), (10,10,1), (10,9,1),
           (11,27,2), (11,19,3), (11,1,4),                            (11,31,16), (11,11,1), (11,8,1), (11,10,1), (11,9,1),
           (12,43,33), (12,3,1), (12,2,3), (12,27,6), (12,25,1),      (12,31,16), (12,11,1), (12,8,1), (12,10,1), (12,9,1),
           (13,41,0.5), (13,14,3), (13,23,3), (13,28,10),             (13,31,16), (13,11,1), (13,8,1), (13,10,1), (13,9,1), 
           (14,34,6), (14,27,1), (14,26,10), (14,14,3), (14,28,6),    (14,31,16), (14,11,1), (14,8,1), (14,10,1), (14,9,1), 
           (15,14,4), (15,24,1), (15,32,1), (15,35,3), (15,38,6),     (15,31,16), (15,11,1), (15,8,1), (15,10,1), (15,9,1), 
           (16,42,10),(16,18,3), (16,1,2), (16,15,3),                 (16,31,16), (16,11,1), (16,8,1), (16,10,1), (16,9,1),
           (17,32,1), (17,33,12), (17,15,3),                          (17,31,16), (17,11,1), (17,8,1), (17,10,1), (17,9,1),
           (18,36,3), (18,33,10), (18,15,3),                          (18,31,16), (18,11,1), (18,8,1), (18,10,1), (18,9,1), 
           (19,16,3), (19,14,3), (19,44,10),                          (19,31,16), (19,11,1), (19,8,1), (19,10,1), (19,9,1), 
           (20,30,12), (20,16,4),                                     (20,31,16), (20,11,1), (20,8,1), (20,10,1), (20,9,1), 
           (21,17,3), (21,16,3), (21,30,10),                          (21,31,16), (21,11,1), (21,8,1), (21,10,1), (21,9,1), 
           (22,29,12), (22,16,3), (22,6,2),                           (22,31,16), (22,11,1), (22,8,1), (22,10,1), (22,9,1), 
           (23,43,12), (23,3,0.5), (23,27,1), (23,4,1), (23,5,1), (23,2,0.5), (23,14,3), (23,7,1), (23,8,1),
           (24,17,1), (24,42,9), (24,13,2), (24,15,2), (23,12,2),     (24,31,16), (24,11,1), (24,8,1), (24,10,1), (24,9,1), 
           (25,24,3), (25,15,2), (25,18,2), (25,12,2),                (25,31,20), (25,11,1), (25,8,1), (25,10,1), (25,9,1), 
           (26,33,9), (26,27,1), (26,13,2), (26,15,2), (26,12,2),     (26,31,16), (26,11,1), (26,8,1), (26,10,1), (26,9,1), 
           (27,17,3), (27,34,10), (27,21,3),                          (27,31,16), (27,11,1), (27,8,1), (27,10,1), (27,9,1),
           (28,24,3), (28,12,3), (28,38,10),                          (28,31,16), (28,11,1), (28,8,1), (28,10,1), (28,9,1),
           (30,25,1), (30,27,3), (30,5,1),                            (30,31,16), (30,11,1), (30,8,1), (30,10,1), (30,9,1);

-- Insertar Proveedores
INSERT INTO public.proveedor(empresa)
	VALUES  ('AMPM'), ('Automercado'), ('El Glaciar'), ('Envasa'), ('Esteban'), 
            ('Goti'), ('Licorera'), ('Mayca'), ('Walmart');
    
-- Insertar Proveedores Inventario
INSERT INTO public.proveedorinventario(idproveedor, idinventario, cantidadproducto, costounitario)
	VALUES (8,1,350,20), (8,2,135,66), (8,3,400,53), (8,4,90,12), (8,5,90,12), (1,6,200,25), (4,7,210,258), (5,8,5000,24),
(8,9,1500,4), (8,10,3120,13), (8,11,2000,55), (6,12,423,132), (6,13,423,170), (6,14,423,149), (6,15,423,295), (6,16,212,346),
(6,17,212,136), (6,18,141,136), (6,19,141,288), (6,20,106,316), (6,21,141,268), (6,22,141,268), (7,23,159,60), (8,24,159,152),
(9,25,45,666), (1,26,70,8), (9,27,160,94), (8,28,423,20), (8,29,423,22), (8,30,423,22), (3,31,2822,6), (2,32,211,66),
(8,33,423,25), (8,34,423,22), (8,35,1199,58), (8,36,423,47), (8,37,1068,9), (8,38,212,56), (8,39,1068,12), (8,40,141,31),
(8,41,134,26), (9,42,882,5), (9,43,423,22), (9,44,882,5);

UPDATE PRODUCTO SET descripcionproducto = 'ARTEMISA' WHERE idproducto = 1;
UPDATE PRODUCTO SET descripcionproducto = 'HERMES' WHERE idproducto = 2;
UPDATE PRODUCTO SET descripcionproducto = 'AQUILES' WHERE idproducto = 3;
UPDATE PRODUCTO SET descripcionproducto = 'HELENA' WHERE idproducto = 4;
UPDATE PRODUCTO SET descripcionproducto = 'NINFA' WHERE idproducto = 5;
UPDATE PRODUCTO SET descripcionproducto = 'CENTAURO' WHERE idproducto = 6;
UPDATE PRODUCTO SET descripcionproducto = 'AFRODITA' WHERE idproducto = 7;
UPDATE PRODUCTO SET descripcionproducto = 'ICARO' WHERE idproducto = 9;
UPDATE PRODUCTO SET descripcionproducto = 'FENIX' WHERE idproducto = 8;
UPDATE PRODUCTO SET descripcionproducto = 'GRIFO' WHERE idproducto = 10;
UPDATE PRODUCTO SET descripcionproducto = 'ATENEA' WHERE idproducto = 11;
UPDATE PRODUCTO SET descripcionproducto = 'HERCULES' WHERE idproducto = 12;
UPDATE PRODUCTO SET descripcionproducto = 'SATIRO' WHERE idproducto = 13;
UPDATE PRODUCTO SET descripcionproducto = 'DIONISIO' WHERE idproducto = 14;
UPDATE PRODUCTO SET descripcionproducto = 'CICLOPE' WHERE idproducto = 15;
UPDATE PRODUCTO SET descripcionproducto = 'SIRENA' WHERE idproducto = 16;
UPDATE PRODUCTO SET descripcionproducto = 'HEFESTO' WHERE idproducto = 17;
UPDATE PRODUCTO SET descripcionproducto = 'EDIPO' WHERE idproducto = 18;
UPDATE PRODUCTO SET descripcionproducto = 'MORFEO' WHERE idproducto = 19;
UPDATE PRODUCTO SET descripcionproducto = 'MEDUSA' WHERE idproducto = 20;
UPDATE PRODUCTO SET descripcionproducto = 'HERA' WHERE idproducto = 21;
UPDATE PRODUCTO SET descripcionproducto = 'ORION' WHERE idproducto = 22;
UPDATE PRODUCTO SET descripcionproducto = 'PEGASO' WHERE idproducto = 23;
UPDATE PRODUCTO SET descripcionproducto = 'HADES' WHERE idproducto = 24;
UPDATE PRODUCTO SET descripcionproducto = 'ZEUS' WHERE idproducto = 25;
UPDATE PRODUCTO SET descripcionproducto = 'ARES' WHERE idproducto = 26;
UPDATE PRODUCTO SET descripcionproducto = 'POSEIDON' WHERE idproducto = 27;
UPDATE PRODUCTO SET descripcionproducto = 'IRIS' WHERE idproducto = 28;
UPDATE PRODUCTO SET descripcionproducto = 'ODISEA' WHERE idproducto = 29;
UPDATE PRODUCTO SET descripcionproducto = 'HIDRA' WHERE idproducto = 30;