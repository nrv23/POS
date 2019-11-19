# SOPA API

## INITIALIZATION

### HTTP GET
1. 
#### */*
- Arguments: N/A
- Output: ```/sopa#!/restaurante```
- Description: Used to redirect the root page to the Restaurant's tab

2. 
#### */sopa*
- Arguments: N/A
- Output: ```/public/view/login.html```
- Description: Loads the Login page as: ```__dirname + LOGIN_PAGE```

3. 
#### */userId*
- Arguments: N/A
- Output: No redirection. (Possible an useless method).
- Description: This methods consoles the userdId previously saved by the server.

### HTTP POST

1. 
#### */sopa*
- Arguments: `username`, `password`
- Output: ```/public/view/home.html```
- Descrition: This loads the Home page is credentials are ok. If credentials are incorrect, it may reload the LoginPage from 0. It saves the _usedId_ from request body username.

## RESTAURANTE

### HTTP GET
1. 
#### */pendingTotal*
- Arguments: `idCuenta`
- Output: ```SELECT COALESCE(SUM(o.cantidad * p.precioProducto),0) as Cuenta FROM CLIENTE cl INNER JOIN CUENTA cu on cl.idCliente = cu.idCliente AND cu.estadocuenta NOT LIKE 'Cancelada' AND cu.idCuenta = ? LEFT JOIN ORDEN o on cu.idCuenta = o.idCuenta AND o.estadoOrden = 'Pendiente' LEFT JOIN PRODUCTO p on o.idProducto = p.idProducto;```
- Descrption: It executes the above query with the `idCuenta` argument. The result isthe pending total for the account as one simple number.

2. 
#### */clienteFactura*
- Arguments: `idCuenta`
- Output: ```SELECT CONCAT(cl.nombreCliente, ' ', cl.apellidoCliente) as NombreCliente FROM CLIENTE cl INNER JOIN CUENTA cu ON cl.idCliente = cu.idCliente WHERE cu.idCuenta = ?;```
Description: This is only to get the name and last name of a cliente from a given idCuenta

3. 
#### */api/client/orders*
- Arguments:`idCuenta`
- Output:```SELECT c.idCuenta as NumCuenta, o.idOrden, p.descripcionProducto as Producto, p.precioProducto as Precio, o.cantidad as Cantidad, (p.precioProducto * o.cantidad) as Total, o.estadoOrden as estadoOrden, o.fechaRegistro as Fecha FROM CUENTA c INNER JOIN ORDEN o ON o.idCuenta = c.idCuenta AND o.estadoOrden='Pendiente' INNER JOIN PRODUCTO p ON p.idProducto = o.idProducto WHERE c.idCuenta = ? GROUP BY o.idOrden  ```
- Description: get orders per account

4. 
#### */total_pay_client*
- Arguments:`idCuenta`
- Output:```SELECT SUM(p.precioProducto * o.cantidad) as Total FROM ORDEN o INNER JOIN CUENTA c ON o.idCuenta = c.idCuenta INNER JOIN PRODUCTO p ON o.idProducto = p.idProducto INNER JOIN EMPLEADO e ON o.idEmpleado = e.idEmpleado INNER JOIN CLIENTE cl ON c.idCliente = cl.idCliente INNER JOIN CATEGORIA ct ON p.idCategoria = ct.idCategoria INNER JOIN PUESTO pt ON e.idPuesto = pt.idPuesto WHERE c.idCuenta = ? and o.estadoOrden not like 'Cancelada' ORDER BY c.idCuenta, o.idOrden ```
- Description: it results the total amout to pay for a given idCuenta, where orders arent cancelled. total[0].Total.toString is used.
- *NOT USED*

5. 
#### */total_pay_client_JSON*
- Arguments:`idCuenta`
- Output: ```SELECT SUM(p.precioProducto * o.cantidad) as Total FROM ORDEN o INNER JOIN CUENTA c ON o.idCuenta = c.idCuenta INNER JOIN PRODUCTO p ON o.idProducto = p.idProducto INNER JOIN EMPLEADO e ON o.idEmpleado = e.idEmpleado INNER JOIN CLIENTE cl ON c.idCliente = cl.idCliente INNER JOIN CATEGORIA ct ON p.idCategoria = ct.idCategoria INNER JOIN PUESTO pt ON e.idPuesto = pt.idPuesto WHERE c.idCuenta = ? and o.estadoOrden not like 'Cancelada' ORDER BY c.idCuenta, o.idOrden ```
- Description: it results the total amout to pay for a given idCuenta, where orders a
rent cancelled. JSON.stringify is used.

6. 
#### */api/orders/pending*
- Arguments: N/A
- Output: ```SELECT o.idOrden, o.idCuenta as NumCuenta, p.descripcionProducto as Producto, p.precioProducto as Precio, o.cantidad as Cantidad, p.precioProducto * o.cantidad as Total, o.estadoOrden as EstadoOrden, o.fechaRegistro FROM ORDEN o INNER JOIN CUENTA c ON o.idCuenta = c.idCuenta INNER JOIN PRODUCTO p ON o.idProducto = p.idProducto INNER JOIN EMPLEADO e ON o.idEmpleado = e.idEmpleado INNER JOIN CLIENTE cl ON c.idCliente = cl.idCliente INNER JOIN CATEGORIA ct ON p.idCategoria = ct.idCategoria INNER JOIN PUESTO pt ON e.idPuesto = pt.idPuesto WHERE EstadoOrden NOT LIKE 'Cancelada' ORDER BY c.idCuenta, o.idOrden;```
- Description: Lists all orders NOT Cancelled.

7. 
#### */api/client/account*
- Arguments: N/A
- Output: ```SELECT cu.idCuenta, cl.nombreCliente, cl.apellidoCliente, COALESCE(SUM(o.cantidad * p.precioProducto),0) AS TotalPagar FROM CLIENTE cl INNER JOIN CUENTA cu ON cl.idCliente = cu.idCliente AND cu.estadocuenta NOT LIKE 'Cancelada' LEFT JOIN ORDEN o ON cu.idCuenta = o.idCuenta AND o.estadoOrden = 'Pendiente' LEFT JOIN PRODUCTO p on o.idProducto = p.idProducto group by cu.idCuenta;```
- Description: Lists all pending orders with its corresponding amout to pay.

### HTTP PUT
1. 
#### */cancel_cuenta*
- Arguments: `id` which is the idCuenta
- Output: ```UPDATE CUENTA SET estadoCuenta = 'Cancelada' WHERE idCuenta = ?```
- Description: Updates a certain idCuenta to _Cancelada_.


### HTTP POST
1. 
#### */delete_order*
- Arguments: `idOrden`
- Output: ```DELETE FROM ORDEN WHERE idOrden= ?```
-Description: Deletes an order from a given _idOrden_
	
## FACTURAS CANCELADAS

### HTTP GET
1. 
#### */getCanceledAccounts*
- Arguments: N/A
- Output: ```SELECT cu.idCuenta, cl.nombreCliente, cl.apellidoCliente, COALESCE(SUM(o.cantidad * p.precioProducto),0) AS TotalPagar FROM CLIENTE cl INNER JOIN CUENTA cu ON cl.idCliente = cu.idCliente AND cu.estadocuenta LIKE 'Cancelada' LEFT JOIN ORDEN o ON cu.idCuenta = o.idCuenta AND o.estadoOrden = 'Cancelada' LEFT JOIN PRODUCTO p on o.idProducto = p.idProducto group by cu.idCuenta;```
- Description: Return Facturas Canceladas
