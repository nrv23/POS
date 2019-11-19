-- Insertar Cliente
INSERT INTO public.cliente(identificacioncliente)
	VALUES ('cliente default');
    
-- Insertar Cuenta    
INSERT INTO public.cuenta(idcliente, estadocuenta)
	VALUES (1, 'Activa');

-- Insertar Tipos de Gastos
INSERT INTO public.tipogasto(descripciontipogasto)
	VALUES ('Servicio'),
    ('Planilla'),
    ('Inventario Bebidas'),
    ('Activos');
    
-- Insertar Gastos
INSERT INTO public.gasto(idtipogasto, descripciongasto, estadogasto, montogasto, 
                           observaciongasto)
	VALUES (1, 'Recibo Agua', 'Se debe', 50000, 'Pago mes de Octubre'),
    		(2, 'Salario Empleado1', 'Pagado', 150000, 'Planilla Octubre'),
            (3, 'Ron', 'Pagado', 15000, 'Litro de Ron');

-- Insertar Puestos
INSERT INTO public.puesto(descripcionpuesto, departamentopuesto)
	VALUES ('Administrador', 'Gerencia'),
    		('Cajero', 'Ventas');
            
-- Insertar Empleados            
INSERT INTO public.empleado(nombreempleado, apellidoempleado, passwordempleado, idpuesto)
	VALUES ('Empleado1', 'Apellido1', 'pass', 1),
    		('Empleado2', 'Apellido2', 'pass', 1),
    		('Nico', 'Godin', 'ngodin', 2);

-- Insertar Período de Venta
INSERT INTO public.periodoventa(nombreperiodoventa)
	VALUES ('Periodo1');
    
-- Insertar Categorias
INSERT INTO public.categoria(descripcioncategoria)
	VALUES ('Ron'),
    		('Whisky'),
    		('Vodka'),
            ('Cacique'),
            ('Tequila'),
            ('Jager'),
            ('Especiales'),
            ('Botellitas');
            
-- Insertar Productos
INSERT INTO public.producto(descripcionproducto, idcategoria, precioproducto)
	VALUES ('Piña Colada', 		1, 3500),
    		('Mojito Frozen', 	 1, 3500),
    		('Cuba Libre Frozen',1, 3500),
    		('Daiquiri Fresa', 	 1, 3500),
    		('Hurricane', 		 1, 3500),
    		('Sueño Rosado', 	 1, 3500),
    		('Pasion Tropical',  1, 3500),
    		('Blue Lagoon', 	 3, 3500),
    		('Sex On The Beach', 3, 3500),
    		('Bloddy Mary', 	 3, 3500),
    		('Ruso Blanco', 	 3, 3500),
    		('Destornillador', 	 3, 3500),
    		('Coca Frozen', 	 2, 3500),
    		('Manhattan', 		 2, 3500),
    		('Whisky Sour', 	 2, 3500),
    		('Cow Boy',		 	 2, 3500),
    		('Chili Birra',		 4, 3500),
    		('Chepe De Noche',	 4, 3500),
    		('Jugo de Piña',	 4, 3500),
    		('Nieve de Cacique', 4, 3500),
    		('Paloma',			 5, 3500),
    		('Margarita',		 5, 3500),
    		('Tequila Sunrise',	 5, 3500),
    		('Vertigo',			 5, 3500),
    		('Submarino',		 5, 3500),
    		('Te Jager',		 6, 3500),
    		('Hasta Nunca',		 6, 3500),
    		('Bomba Atomica',	 6, 3500),
    		('Iguana',			 6, 3500),
    		('Malibu Surf',		 6, 3500),
    		('Grasshopper',		 6, 3500),
    		('Santa Shot',		 7, 3500),
    		('Bella Y Bestia',	 7, 3500),
    		('Diablo Azul',		 7, 3500),
    		('Horpacha',	 	 7, 3500),
    		('Chiliguaro',		 7, 3500);

-- Insertar Categorias de Inventario
INSERT INTO public.categoriainventario(descripcioncategoriainventario)
	VALUES ('Consumibles'),
    		('Desechables'),
    		('Licor'),
    		('Frescos'),
    		('Gaseosos'),
    		('Hielo'),
    		('Jugos y Cremas');

-- Insertar Inventarios    
INSERT INTO public.inventario(descripcioninventario, costoinventario, 
                              cantidaddisponibleinventario, cantidadminimainventario, 
                              idcategoriainventario, unidad)
	VALUES ('Azucar', 				  150, 1000, 10, 1, 'Unidad'),
    		('Pmienta', 			  150, 1000, 10, 1, 'Gramos'),
    		('Sal', 				  150, 1000, 10, 1, 'Gramos'),
    		('Salsa Inglesa', 		  150, 1000, 10, 1, 'Onzas'),
    		('Tabasco', 			  150, 1000, 10, 1, 'Onzas'),
            ('Botellita 240ml',		  150, 1000, 10, 2, 'Unidades'),
            ('Botellita 500ml',		  150, 1000, 10, 2, 'Unidades'),
            ('Pajilla',		  		  150, 1000, 10, 2, 'Unidades'),
            ('Postal',				  150, 1000, 10, 2, 'Unidades'),
            ('Tapa', 				  150, 1000, 10, 2, 'Unidades'),
            ('Vaso', 				  150, 1000, 10, 2, 'Unidades'),
            ('Blue Curacao',		  150, 1000, 10, 3, 'Onzas'),
            ('Chachaca',			  150, 1000, 10, 3, 'Onzas'),
            ('Cacique',				  150, 1000, 10, 3, 'Onzas'),
            ('Cerveza',				  150, 1000, 10, 3, 'Unidades'),
            ('Cranberry',			  150, 1000, 10, 3, 'Onzas'),
            ('Crema de Cacao Blanco', 150, 1000, 10, 3, 'Onzas'),
            ('Crema de Menta',		  150, 1000, 10, 3, 'Onzas'),
            ('Ginebra',		  		  150, 1000, 10, 3, 'Onzas'),
            ('Jager',		  		  150, 1000, 10, 3, 'Onzas'),
            ('Licor de Cafe',		  150, 1000, 10, 3, 'Onzas'),
            ('Licor de Melocoton',	  150, 1000, 10, 3, 'Onzas'),
            ('Malibu',		  		  150, 1000, 10, 3, 'Onzas'),
            ('Ron Blanco',			  150, 1000, 10, 3, 'Onzas'),
            ('Tequilaa',			  150, 1000, 10, 3, 'Onzas'),
            ('Tequila Rose',		  150, 1000, 10, 3, 'Onzas'),
            ('Triple Sec',		  	  150, 1000, 10, 3, 'Onzas'),
            ('Vermount Seco',		  150, 1000, 10, 3, 'Onzas'),
            ('Vino de Nance',		  150, 1000, 10, 3, 'Onzas'),
            ('Vodka',				  150, 1000, 10, 3, 'Onzas'),
            ('Whisky',		  		  150, 1000, 10, 3, 'Onzas'),
            ('Hierba Buena',		  150, 1000, 10, 4, 'Onzas'),
            ('Limon',		  		  150, 1000, 10, 4, 'Onzas'),
            ('Coca-Cola',		  	  150, 1000, 10, 5, 'Onzas'),
            ('Soda',			  	  150, 1000, 10, 5, 'Onzas'),
            ('Hielo',			  	  150, 1000, 10, 6, 'Onzas'),
            ('Crema de Coco',		  150, 1000, 10, 7, 'Onzas'),
            ('Granadina',			  150, 1000, 10, 7, 'Onzas'),
            ('Horchata',			  150, 1000, 10, 7, 'Onzas'),
            ('Jugo de Cereza',		  150, 1000, 10, 7, 'Onzas'),
            ('Jugo de Fresa',		  150, 1000, 10, 7, 'Onzas'),
            ('Jugo de Maracuya',	  150, 1000, 10, 7, 'Onzas'),
            ('Jugo de Naranja',		  150, 1000, 10, 7, 'Onzas'),
            ('Jugo de Piña',		  150, 1000, 10, 7, 'Onzas'),
            ('Jugo de Tomate',		  150, 1000, 10, 7, 'Onzas'),
            ('Jugo de Toronja',		  150, 1000, 10, 7, 'Onzas'),
            ('Leche',		  		  150, 1000, 10, 7, 'Onzas'),
            ('Leche Evaporada',		  150, 1000, 10, 7, 'Onzas'),
            ('Limonada',	  		  150, 1000, 10, 7, 'Onzas'),
            ('Sirope de Cola',		  150, 1000, 10, 7, 'Onzas'),
            ('Te Frio',		  		  150, 1000, 10, 7, 'Onzas');   
  
-- Insertar Inventario Producto
INSERT INTO public.inventarioproducto(idproducto, idinventario, cantidadnecesaria)
	VALUES (1, 37, 3), (1, 24, 3), (1, 44, 10), (1, 36, 16), (1, 11, 1), (1, 9, 1), (1, 10, 1), (1, 8, 1), 
    		(2, 1, 5), (2, 32, 10), (2, 33, 1), (2, 24, 3), (2, 35, 12), (2, 36, 16), (2, 11, 1), (2, 9, 1),
    		(2, 10, 1), (2, 8, 1), 
    		(8, 12, 2), (8, 49, 12), (8, 30, 3), (8, 36, 16), (8, 11, 1), (8, 9, 1), (8, 10, 1), (8, 8, 1), 
            (9, 38, 1), (9, 43, 10), (9, 22, 1), (9, 30, 3), (9, 36, 16), (9, 11, 1), (9, 9, 1), (9, 10, 1), 
            (9, 8, 1), 
            (13, 34, 12), (13, 31, 3), (13, 36, 16), (13, 11, 1), (13, 9, 1), (13, 10, 1), (13, 8, 1), 
            (14, 28, 12), (14, 31, 3), (14, 40, 10), (14, 36, 16), (14, 11, 1), (14, 9, 1), 
            (14, 10, 1), (14, 8, 1), 
            (17, 45, 4), (17, 5, 1), (17, 33, 1), (17, 15, 12), (17, 14, 3), (17, 36, 16), (17, 11, 1), 
            (17, 9, 1), (17, 10, 1), (9, 8, 1), 
            (18, 50, 0.5), (18, 14, 3), (18, 29, 3), (18, 35, 10), (18, 36, 16), (18, 11, 1), (18, 9, 1), 
            (18, 10, 1), (18, 8, 1), 
            (21, 46, 6), (21, 33, 1), (21, 35, 6), (21, 25, 3), (21, 36, 16), (21, 11, 1), (21, 9, 1), 
            (21, 10, 1), (21, 8, 1), 
            (22, 49, 10), (22, 27, 3), (22, 1, 4), (22, 25, 3), (22, 36, 16), (22, 11, 1), (22, 9, 1), 
            (22, 10, 1), (22, 8, 1), 
            (26, 20, 3), (26, 14, 3), (26, 51, 10), (26, 36, 16), (26, 11, 1), (26, 9, 1), (26, 10, 1), 
            (26, 8, 1), 
            (27, 12, 1), (27, 49, 6), (27, 24, 3), (27, 25, 3), (27, 30, 3), (27, 36, 16), (27, 11, 1), 
            (27, 9, 1), (27, 10, 1), (27, 8, 1), 
            (32, 18, 4), (32, 28, 4), (32, 43, 7), (32, 38, 1), (32, 6, 2), (32, 9, 1), 
            (33, 20, 8), (33, 26, 8), (32, 6, 2), (32, 9, 1); 
            
-- Insertar Proveedores
INSERT INTO public.proveedor(empresa)
	VALUES ('AMPM'),
    		('El Glaciar'),
            ('Envasa'),
    		('Esteban'),
    		('Goti'),
            ('Licorera'),
    		('Mayca'),
    		('Walmart'),
    		('Sin Definir');
    
-- Insertar Proveedores Inventario
INSERT INTO public.proveedorinventario(idproveedor, idinventario, cantidadproducto, costounitario)
	VALUES (1, 32, 100, 700), (2, 36, 100, 900), (3, 6, 100, 500), (3, 7, 100, 800), (4, 9, 100, 800),
    		(5, 12, 100, 800), (5, 13, 100, 800), (5, 14, 100, 800), (5, 16, 100, 800), (5, 17, 100, 800),
    		(5, 19, 100, 800), (5, 20, 100, 800), (5, 21, 100, 800), (5, 22, 100, 800), (5, 23, 100, 800), 
    		(5, 24, 100, 800), (5, 25, 100, 800), (5, 26, 100, 800), (5, 27, 100, 800), (5, 28, 100, 800), 
    		(5, 30, 100, 800), (5, 31, 100, 800), (5, 38, 100, 800), 
    		(6, 29, 100, 800), 
            (7, 8, 100, 800), (7, 10, 100, 800), (7, 11, 100, 800), (7, 18, 100, 800), (7, 37, 100, 800), 
            (7, 50, 100, 800), 
            (8, 1, 100, 800), (8, 2, 100, 800), (8, 3, 100, 800), (8, 4, 100, 800), (8, 5, 100, 800), 
            (8, 33, 100, 800), (8, 34, 100, 800), (8, 35, 100, 800), (8, 39, 100, 800), (8, 40, 100, 800), 
            (8, 41, 100, 800), (8, 42, 100, 800), (8, 43, 100, 800), (8, 44, 100, 800), (8, 45, 100, 800), 
            (8, 46, 100, 800), (8, 47, 100, 800), (8, 48, 100, 800), (8, 49, 100, 800), (8, 51, 100, 800), 
            (9, 15, 100, 800);