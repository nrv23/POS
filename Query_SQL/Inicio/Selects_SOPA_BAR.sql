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

--------------------------------------------------------------------------------------------------
-- REPORTES
--------------------------------------------------------------------------------------------------
-- Reporte 1: Informe General
SELECT pv.idPeriodoVenta, TO_CHAR(pv.fechaInicioPeriodoVenta, 'Month') AS Mes, TO_CHAR(pv.fechaInicioPeriodoVenta, 'WW') AS Semana, TO_CHAR(pv.fechaInicioPeriodoVenta, 'DD/MM/YY HH24:MI:SS') AS Fecha, pv.nombrePeriodoVenta as NombrePeriodo, pv.estadoPeriodoVenta as EstadoPeriodo, SUM(f.subTotal) AS subTotal, SUM(f.subtotal * f.porcentajeDescuento / 100) AS Descuento, SUM(CASE WHEN f.formapago = 'Efectivo' THEN f.subTotal END) AS Efectivos, SUM(CASE WHEN f.formapago = 'Tarjeta' THEN f.subTotal END) AS Tarjetas, SUM(CASE WHEN f.formapago = 'Efectivo' THEN (f.subtotal * f.porcentajeDescuento / 100) END) AS EfectivosDescuentos, SUM(CASE WHEN f.formapago = 'Tarjeta' THEN (f.subtotal * f.porcentajeDescuento / 100) END) AS TarjetasDescuentos FROM PERIODOVENTA pv INNER JOIN FACTURA f ON pv.idPeriodoVenta = f.idPeriodoVenta GROUP BY pv.idPeriodoVenta ORDER BY pv.estadoPeriodoVenta;

-- Reporte 2: Detalle de ordenes por periodo
SELECT o.idOrden, f.idFactura, TO_CHAR(f.fechaRegistroFactura, 'DD/MM/YY HH24:MI:SS') AS fechafactura, 
p.descripcionProducto, o.cantidadProducto, o.precioUnitarioProducto * o.cantidadProducto AS subtotal, 
f.porcentajeDescuento, 
o.precioUnitarioProducto * o.cantidadProducto * (1 - CAST(f.porcentajeDescuento AS FLOAT8) / CAST(100 AS FLOAT8)) AS TOTAL 
FROM ORDEN o 
INNER JOIN PRODUCTO p ON o.idProducto = p.idProducto 
INNER JOIN FACTURA f ON f.idFactura = o.idFactura 
WHERE f.idPeriodoVenta = $1 
ORDER BY f.idFactura;

-- Reporte 3: Inventario Disponible
SELECT i.idInventario, i.descripcionInventario, ci.descripcionCategoriaInventario, i.cantidadDisponibleInventario, 
i.costoInventario, i.cantidadMinimaInventario 
FROM INVENTARIO i 
INNER JOIN CATEGORIAINVENTARIO ci ON i.idCategoriaInventario = ci.idCategoriaInventario 
ORDER BY ci.idCategoriaInventario;

-- Reporte 4: Materias Primas Consumidas por rango de fecha
SELECT i.idInventario, i.descripcionInventario, 
SUM(o.cantidadProducto * ip.cantidadNecesaria) as Consumo, i.unidad 
FROM INVENTARIO i 
INNER JOIN INVENTARIOPRODUCTO ip ON i.idInventario = ip.idInventario 
INNER JOIN ORDEN o ON ip.idProducto = o.idProducto
GROUP BY i.idInventario
ORDER BY i.idInventario;

-- Reporte 5: Gastos por rango de fecha
SELECT descripcionGasto, fechaGasto, montoGasto FROM GASTO;