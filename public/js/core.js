var app = angular.module('routeApp', ['ngRoute', 'routeStyles', 'angularUtils.directives.dirPagination']) // , 'ui.bootstrap'])

var scopeId = null
var $
var alert
// var proveedorId = null
// var cantidadActualInventario = null
var scopeidEmpleado = ''
var sessionKeyGlobal = ''
var userNameAPIGlobal = ''
var porcentajeExoneracionGlobal = 0
var DEBUG = true

const normativa="Autorizado mediante resolucion DGT-R-48-2016 del 07/10/2016";

app.directive('stringToNumber', function() {
  return {
    require: 'ngModel',
    link: function(scope, element, attrs, ngModel) {
      ngModel.$parsers.push(function(value) {
        return '' + value;
      });
      ngModel.$formatters.push(function(value) {
        return parseFloat(value);
      });
    }
  };
})

app.factory('myService', function () {
  var savedData = {}

  function set (data) { savedData = data }

  function get () { return savedData }

  return { set: set, get: get }
})

app.service('serviceRestaurant', function () {
  var idCuenta = '-1'
  var periodoVenta // = '-1';
  var idEmpleado

  this.getidCuenta = function () { return idCuenta }
  this.setidCuenta = function (cuenta) { idCuenta = cuenta }

  this.getPeriodoVenta = function () { return periodoVenta }
  this.set_periodoVenta = function (period) { periodoVenta = period }

  this.getperiodo = function () { return periodoVenta }
  this.set_periodoVenta = function (period) { periodoVenta = period }

  this.getidEmpleado = function () { return idEmpleado }
  this.setidEmpleado = function (empleado) { idEmpleado = empleado }
})

app.service('serviceCliente', function () {
  var idCuenta = '-1'
  this.getidCuenta = function () { return idCuenta }
})

app.config(function ($logProvider) { $logProvider.debugEnabled(true) })

app.config(function ($routeProvider) {
  $routeProvider.when('/', {
    templateUrl: '/partials/main.html'
  }).when('/clientes', {
    templateUrl: '/partials/clientes.html',
    controller: 'clientController'
  }).when('/restaurante', {
    css: '/css/restaurante.css',
    templateUrl: '/partials/restaurant.html',
    controller: 'restaurantController'
  }).when('/tabla', {
    templateUrl: '/partials/tabla.html',
    css: '/css/tabla.css'
  }).when('/productos', {
    css: '/css/productos.css',
    templateUrl: '/partials/productos.html',
    controller: 'productController'
  }).when('/dashboard', {
    css: '/css/dashboard.css',
    templateUrl: '/partials/dashboard.html',
    controller: 'dashboardController'
  }).when('/ordenes', {
    templateUrl: '/partials/ordenes.html',
    controller: 'order1Ctrl'
  }).when('/meseros', {
    templateUrl: '/partials/meseros.html',
    controller: 'waiterController'
  }).when('/factura', {
    css: '/css/factura.css',
    templateUrl: '/partials/factura.html',
    controller: 'facturaController'
  }).when('/cuentas', {
    css: '/css/factura.css',
    templateUrl: 'partials/cuentas.html',
    controller: 'cuentasController'
  }).when('/proveedores', {
    css: '/css/proveedores.css',
    templateUrl: 'partials/proveedores.html',
    controller: 'proveedoresController'
  }).when('/gastos', {
    templateUrl: 'partials/gastos.html',
    controller: 'gastosController'
  }).when('/nosotros', {
    templateUrl: '/partials/nosotros.html'
  }).when('/pagina', {
    templateUrl: '../partials/pagina.html'
  }).when('/emisor', {
    templateUrl: 'partials/emisor.html',
    controller: 'emisorController',
     css: '/css/emisor.css'
  }).when('/receptor', {
    templateUrl: 'partials/receptor.html',
    controller: 'receptorController'
  }).when('/credencialesEmisor', {
    templateUrl: 'partials/credencialesEmisor.html',
    controller: 'credencialesEmisorController'
  }).when('/comprobantes', {
    templateUrl: 'partials/comprobantes.html',
    controller: 'comprobantesController'
  }).when('/descuentos', {
    templateUrl: 'partials/descuentos.html',
    controller: 'descuentosController'
  }).when('/impuestos',{
    templateUrl: 'partials/impuestos.html',
    controller: 'impuestosController'
  }).when('/clasificacion',{
    templateUrl: 'partials/clasificacion.html',
    controller: 'clasificacionController'
  }).when('/reportes',{
    templateUrl: 'partials/reportes.html',
    controller: 'reportesController'
  }).otherwise({
    redirectTo: '/'
  })
}).controller('clientController', function ($scope, $http, $log, serviceRestaurant) {
  var data = {}
  scopeId = null
  loadData($scope, $http, $log, '/api/client', data)

  // editar cliente selecionado
  $scope.edit = function (info) {
    $scope.client = angular.copy(info, $scope.data)
    scopeId = info.idCliente
  }

  // resetear los valores del formulario.
  $scope.clearData = function () {
    $scope.client = {}
    scopeId = null
  }

  $scope.saveClient = function (client) {
    var data = {
      nombre: client.nombreCliente,
      apellido: client.apellidoCliente,
      identificacion: client.identificacionCliente,
      id: scopeId
    }
    if (scopeId !== null) {
      update($scope, $http, $log, '/update_client', data)
      $scope.clearData()
    } else if (scopeId === null) {
      insert($scope, $http, $log, '/create_client', data)
      $scope.clearData()
    } else {
      alert('Accion no valida')
      return
    }
    // cerrar el modal dialog despues de hacer submit
    $('#clientModal').modal('toggle')
    $scope.refreshClient()
  }

  $scope.getBill = function (idCliente) {
    if (idCliente) {
      var data = { idCliente: idCliente }
      idClienteidCuenta($scope, $http, $log, '/getBill', data)
      var idCuenta = $scope.idCuenta
      if (idCuenta === '' || !idCuenta || idCuenta === null || idCuenta === undefined) {
        alert('Este Cliente no tiene cuentas activas')
      } else {
        serviceRestaurant.setidCuenta(idCuenta)
      }
    } else {
      console.error('idCliente is not defined')
    }
  }

  function idClienteidCuenta ($scope, $http, $log, route, data) {
    $http({
      method: 'GET',
      url: route,
      params: data
    }).then(function (response) {
      if (typeof response.data[0].idCuenta !== 'undefined') {
        $scope.idCuenta = response.data[0].idCuenta
        return response.data[0].idCuenta
      } else {
        $scope.idCuenta = ''
        return ''
      }
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.addAccount = function () {
    var data = { id: scopeId }
    $http({
      method: 'GET',
      url: '/get_client_account',
      params: data
    }).then(function (response) {
      $scope.clientAddAccount = response.data
      if ($scope.clientAddAccount.length > 0) {
        alert('El cliente: ' + $('#txtNombreCliente').val().trim() + ' ya tiene una cuenta activa.')
      } else {
        insert($scope, $http, $log, '/creat_client_account', data)
      }
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.addClientAccount = function (id, nombreCliente, apellidoCliente) {
    scopeId = id
    $('#txtNombreCliente').val(nombreCliente + ' ' + apellidoCliente)
  }

  $(document).ready(function () { validateAlphanumeric() })

  $scope.sortClient = function (keyname) {
    $scope.sortKey = keyname // set the sortKey to the param passed
    $scope.reverse = !$scope.reverse // if true make it false and vice versa
  }

  $scope.refreshClient = function () { loadData($scope, $http, $log, '/api/client', {}) }
}).controller('proveedoresController', function ($scope, $http, $log) {
  var data = {}
  loadData($scope, $http, $log, '/proveedor', data)

  // Cargar Empleados
  $http({
    method: 'GET',
    url: '/empleados'
  }).then(function (response) {
    $scope.Empleados = response.data
  }, function errorCallback (response) {
    $log.error(response)
  }).catch(function (error) {
    $log.error(error)
  })

  // Cargar Puestos
  $http({
    method: 'GET',
    url: '/puestos'
  }).then(function (response) {
    $scope.Puestos = response.data
  }, function errorCallback (response) {
    $log.error(response)
  }).catch(function (error) {
    $log.error(error)
  })

  $scope.rowClicked = function (proveedor) {
    $scope.selectedRow = false
    $scope.person_selected = proveedor
    if (typeof proveedor.idproveedor !== 'undefined') {
      $scope.selectedRow = proveedor.idproveedor
    }
  }

  // delete proveedor method
  $scope.deleteProveedor = function (proveedorDelete) {
    var data = { idproveedor: proveedorDelete }
    if (proveedorDelete !== null) {
      updatePromise($scope, $http, $log, '/proveedor/delete', data)
    } else {
      alert('Accion no valida')
      return
    }
    $scope.clearData()
    $('#delete-proveedor-modal').modal('toggle')
    $scope.refreshProveedor()
  }

  // insert update proveedor method
  $scope.updateProveedor = function (proveedorUpdate) {
    var data = {
      idProveedor: proveedorUpdate.idproveedor,
      empresa: proveedorUpdate.empresa,
      nombreContacto: proveedorUpdate.nombrecontacto,
      contacto1: proveedorUpdate.contactoproveedor1,
      contacto2: proveedorUpdate.contactoproveedor2,
      correo: proveedorUpdate.correoproveedor,
      observacion: proveedorUpdate.observacionproveedor
    }
    if (proveedorUpdate.idproveedor !== null) {
      updatePromise($scope, $http, $log, '/proveedor/update', data)
    } else {
      insertPromise($scope, $http, $log, '/proveedor/create', data)
    }
    $scope.clearData()
    $('#update-proveedor-modal').modal('toggle')
    $scope.refreshProveedor()
  }

  // delete empleado method
  /* $scope.deleteEmpleado = function (empleadoDelete)
    var data = { idempleado: empleadoDelete }
    if (empleadoDelete !== null) {
      updatePromise($scope, $http, $log, '/delete_empleado', data)
    } else {
      alert('Accion no valida')
      return
    }
    $scope.clearData()
    $('#delete-proveedor-modal').modal('toggle')
    $scope.refreshProveedor()
  } */

  // insert update Empleado method
  $scope.updateEmpleado = function (empleadoUpdate) {
    var data = {
      idEmpleado: empleadoUpdate.idempleado,
      nombre: empleadoUpdate.nombreempleado,
      apellido: empleadoUpdate.apellidoempleado
      // puesto: empleadoUpdate.idpuesto.idpuesto
    }
    if (empleadoUpdate.idempleado !== null) {
      updatePromise($scope, $http, $log, '/update_empleado', data)
    }
    /* else {
      insertPromise($scope, $http, $log, '/create_empleado', data)
    } */

    $scope.clearData()
    $('#update-empleado-modal').modal('hide')
    $scope.refreshEmpleado()
  }

  // resetear los valores del formulario.
  $scope.clearData = function (template_Right) {
    $scope.proveedor = {}
    scopeId = null
    $log.info('clearData()')
    $log.info($scope.template_Right)
    $scope.refresh($scope.template_Right)
    $scope.person_selected = []
  }

  $scope.sortProveedor = function (keyname) {
    $scope.sortKey = keyname // set the sortKey to the param passed
    $scope.reverse = !$scope.reverse // if true make it false and vice versa
  }

  $(document).ready(function () {
    getProveedoresData($scope)
    getEmpleadosData($scope)
    validateAlphanumeric()
    validateLetters()
    validateNumbers()
  })

  if (typeof $scope.template_Right === 'undefined') {
    $scope.template_Right = 'proveedores'
    $scope.template_Left = 'proveedores_table'
  }

  $scope.template_Right_action = function (key) {
    if (key === 'empleados') {
      $scope.template_Right = 'empleados'
    }
  }

  $scope.refreshProveedor = function () {
    loadData($scope, $http, $log, '/proveedor', {})
  }

  $scope.refreshEmpleado = function () {
    // Cargar Empleados
    $http({
      method: 'GET',
      url: '/empleados'
    }).then(function (response) {
      $scope.Empleados = response.data
    }, function errorCallback (response) {
      $log.error(response)
    }).catch(function (error) {
      $log.error(error)
    })

  // Cargar Puestos
    $http({
      method: 'GET',
      url: '/puestos'
    }).then(function (response) {
      $scope.Puestos = response.data
    }, function errorCallback (response) {
      $log.error(response)
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.refresh = function (templateRight) {
    if (templateRight === 'proveedores') {
      $scope.refreshProveedor()
    } else if (templateRight === 'empleados') {
      $scope.refreshEmpleado()
    } else {
      $log.error('templateRight does not match')
      $log.error(templateRight)
    }
  }
}).controller('productController', function ($scope, $http, $log) {
  var data = {}
  $scope.default_idcategory = ''
  $scope.materials_update = []

  // var onCheckBoxCargarInventarioChange = '';
  loadData($scope, $http, $log, '/api/product', data)
  // save (insert & update) product method
  /* $scope.saveProdsaveProduct = function () {
    if (!$('#txtDescripcionProducto').val()) {
      alert('Descripcion no definido')
    } else if (!$('#txtPrecioProducto').val()) {
      lert('Precio no definido')
    } else if (!$('#txtdescripcionCategoria').val()) {
      alert('Categoria no valida')
    } else {
      var data = {
        descripcionProducto: $('#txtDescripcionProducto').val().trim(),
        precioProducto: $('#txtPrecioProducto').val().trim(),
        idCategoria: $('#txtdescripcionCategoria').val(),
        id: scopeId
      }
      if (scopeId !== null) {
        update($scope, $http, $log, '/api/product/update', data)
        scopeId = null
        loadData($scope, $http, $log, '/api/product', data)
      } else if (scopeId === null) {
        insert($scope, $http, $log, '/api/product/create/old', data)
        scopeId = null
        loadData($scope, $http, $log, '/api/product', data)
      } else {
        alert('Accion no valida')
        return
      }
    }
    $scope.refreshProduct()
  } */

  /* $scope.cargarProductosInventario = function () {
    $scope.onCheckBoxCargarInventarioChange = $scope.valueCargarInventario tipo_ 'Checked' : 'UnChecked'
    if ($scope.onCheckBoxCargarInventarioChange === 'Checked') {
      for (var i = 0; i < $scope.object.length; i++) {
        if ($scope.object[i].tieneInventario === 'No') {
          $scope.object.splice(i,1)
          i--
        }
      }
    } else {
      $scope.data = {}
      loadData($scope, $http, $log, '/api/product', data)
    }
  } */

  ///api/product/clasificacion
  let insertarFila = (data, route) =>{
    return new Promise((resolve,reject) => {
      $http({ method: 'POST', url: route, params: data, data: data})
      .then(data => {
       resolve(data);
      }).catch(err =>{
        reject(err);
      })
    })
}

let getLinea= (data,route)=> {
 return new Promise((resolve,reject) => {
      $http({ method: 'GET', url: route, params: data})
      .then(data => {
       resolve(data);
      }).catch(err =>{
        reject(err);
      })
    })
}

let actualizarLinea= (data,route)=> {
 return new Promise((resolve,reject) => {
      $http({ method: 'PUT', url: route, params: data})
      .then(data => {
       resolve(data);
      }).catch(err =>{
        reject(err);
      })
    })
}

getPromise($scope, $http, $log, '/api/product/clasificacion', {}, false).then(clasificaciones =>  {


  $scope.clasificacionProductos= clasificaciones;
  console.log("clasificacion ",$scope.clasificacionProductos)
}).catch(err => { console.error(err)});


  getPromise($scope, $http, $log, '/impuestos', {}, false).then(listaImpuestos =>  {

    $scope.impuestos= listaImpuestos;

  }).catch(err => { console.error(err)});

  let listarTiposImpuesto= (idimpuesto) => {
    console.log(idimpuesto)
    return new Promise((resolve,reject)=> {
      getPromise($scope, $http, $log, '/tipos_impuesto', idimpuesto, false).then(listaTiposImpuestos =>  {
        resolve(listaTiposImpuestos);
      }).catch(err => { reject(err)});
    })
  }


  let obtenerSubImpuestos = async () => {

    let response;
    const subImpuesto01="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoIVA01.json";
    const subImpuesto02="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoSelectivoConsumo02.json";
    const subImpuesto03="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoUnicoCombustibles03.json";
    const subImpuesto04="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoBebidasAlcoholicas04.json";
    const subImpuesto05="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoBebidasEnvasadasSinAlcoholJabones05.json";
    const subImpuesto06="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoProductosTabaco06.json";
    const subImpuesto07="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoIVACalculoEspecial07.json";
    const subImpuesto99="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoOtros99.json";

    response= await fetch(subImpuesto01)
    $scope.subImpuesto01= await response.json();

    response= await fetch(subImpuesto02)
    $scope.subImpuesto02= await response.json();

    response= await fetch(subImpuesto03)
    $scope.subImpuesto03= await response.json();

    response= await fetch(subImpuesto04)
    $scope.subImpuesto04= await response.json();

    response= await fetch(subImpuesto05)
    $scope.subImpuesto05= await response.json();

    response= await fetch(subImpuesto06)
    $scope.subImpuesto06= await response.json();

    response= await fetch(subImpuesto07);
    $scope.subImpuesto07= await response.json();
   
    response= await fetch(subImpuesto99)
    $scope.subImpuesto99= await response.json();
    
  } 
  obtenerSubImpuestos();

  function UnidadesMedidaServicios () {
    return  ['Al','Alc','Cm','I','Os','Sp','Spe','St','d','h','s'];
  }
  
  getLinea({},'/api/unidadmedida/').then(data => {
    $scope.unidadMedida= data.data;
  })
  //--------------------------------------

$scope.cargarCodigoImpuesto = (clasificacion,tipo) =>{

  console.log(clasificacion);
    if(typeof clasificacion !== "undefined"){

      $scope.listaSubImpuestos={};

      switch(clasificacion.codigo_impuesto){
        case '01':
            $scope.listaSubImpuestos= $scope.subImpuesto01.tipoImpuesto;
            break;
        case '02':
            $scope.listaSubImpuestos= $scope.subImpuesto02.tipoImpuesto;
            break;
        case '03':
            $scope.listaSubImpuestos= $scope.subImpuesto03.tipoImpuesto;
            break;
        case '04':
            $scope.listaSubImpuestos= $scope.subImpuesto04.tipoImpuesto;
            break;
        case '05':
            $scope.listaSubImpuestos= $scope.subImpuesto05.tipoImpuesto;
            break;
        case '06': 
            $scope.listaSubImpuestos= $scope.subImpuesto06.tipoImpuesto;
            break;
        case '07':
            $scope.listaSubImpuestos= $scope.subImpuesto07.tipoImpuesto;
            break;
        case '99':
            $scope.listaSubImpuestos= $scope.subImpuesto99.tipoImpuesto;
            break;
        default:
          throw new Error("El codigo de impuesto no pertenece a ninguna de las posibles opciones");
       }
    }else{
      console.error("El valor es indefinido");
    }
}

  $scope.calcularImpuesto= (new_precioProducto,porcentaje,monto, tipoimpuesto, precio_ivi,campoprecio) => {
      console.log("llego")
      //porcentaje es la caja donde el porcentaje de impuesto
      //monto es la caja donde va el monto del impuesto
      // new_precioProducto es el precio del producto
      //tipoimpuesto saco los valores de porcentaje para obtener el monton del impuesto
    console.log(tipoimpuesto)
      let new_precio;
      let precio;
      let valorImpuesto;

      if(typeof tipoimpuesto === 'undefined' || typeof new_precioProducto === 'undefined'){
          console.error("valor indefinido")
        return;
      }else{

        if(document.getElementById(campoprecio).value.length === 0){
           precio = 0;
           valorImpuesto= precio * Number(tipoimpuesto.porcentaje) /100;
           new_precio= precio + valorImpuesto ;

          }else{

          precio= Number(new_precioProducto);
          valorImpuesto= precio * Number(tipoimpuesto.porcentaje) /100;
          new_precio= precio + valorImpuesto;
        }

        document.getElementById(porcentaje).setAttribute("value", tipoimpuesto.porcentaje);
        document.getElementById(precio_ivi).setAttribute("value",new_precio);
        document.getElementById(monto).setAttribute("value",valorImpuesto);
      }
  }

  $scope.editInventory = function (idinventario, descripcioninventario, cantidaddisponibleinventario, costoinventario, cantidadminimainventario, unidad, idcategoriainventario) {
    data = {
      idinventario: idinventario,
      descripcioninventario: descripcioninventario.replace(/ +$/, ''),
      cantidaddisponibleinventario: cantidaddisponibleinventario,
      costoinventario: costoinventario,
      cantidadminimainventario: cantidadminimainventario,
      unidad: unidad,
      idcategoriainventario: idcategoriainventario.idcategoriainventario
    }
    insert($scope, $http, $log, '/update_inventario', data)
    $scope.refreshInventory()
  }

  $scope.saveInventory = function (descripcioninventario, cantidaddisponibleinventario, costoinventario, cantidadminimainventario, unidad, nuevaCategoria) {
    data = {
      descripcioninventario: descripcioninventario,
      cantidaddisponibleinventario: cantidaddisponibleinventario,
      costoinventario: costoinventario,
      cantidadminimainventario: cantidadminimainventario,
      unidad: unidad,
      idcategoriainventario: nuevaCategoria.idcategoriainventario
    }

    console.log(data)

    insert($scope, $http, $log, '/insert_inventario', data)
    $scope.refreshInventory()
  }

  $scope.loadInventario = function () {
    var idInventario = $('#descripcionInventario').val() * 1
    var idProveedor = $('#empresa').val() * 1
    var cantidad = $('#txtCantidadProducto').val() * 1
    var costo = $('#txtCostoProducto').val() * 1
    var descripcionGasto
    var proveedor
    data = {
      idInventario: idInventario,
      idProveedor: idProveedor,
      cantidad: cantidad,
      costo: costo
    }

    for (var i = 0; i < $scope.Inventario.length; i++) {
      if ($scope.Inventario[i].idinventario === idInventario) {
        descripcionGasto = $scope.Inventario[i].descripcioninventario
      }
    }

    for (var j = 0; j < $scope.Proveedores.length; j++) {
      if ($scope.Proveedores[j].idproveedor === idProveedor) {
        proveedor = $scope.Proveedores[j].empresa
      }
    }

    var dataGasto = {
      descripcionGasto: 'Carga de Inventario de: ' + descripcionGasto,
      montoGasto: cantidad * costo,
      idTipoGasto: 1,
      estadoGasto: 'Se debe',
      observacionGasto: 'Compra al proveedor: ' + proveedor
    }

    insertPromise($scope, $http, $log, '/api/registrar_gasto/insert', dataGasto).then(function () {}).catch(function (error) {
      $log.error(error)
    })
    update($scope, $http, $log, 'load_inventario', data)
    insert($scope, $http, $log, 'insert_proveedorinventario', data)

    $scope.refreshInventory()
  }

  $scope.deleteInventory = function (idinventario) {
    data = { idinventario: idinventario }
    insert($scope, $http, $log, '/delete_inventario', data)
    $scope.refreshInventory()
  }

    $scope.saveProduct = function (descripcionproducto, codigoProducto,precioproducto,costounitario, nuevaCategoria,nuevoClasificacion, nuevoTipoImpuesto,porcentajeImpuesto ,nuevaUnidadMedida, nuevounidadmedidacomercial) {

      let codigo;
      let tipoProducto='';
      const unidadesMedidaServicios = UnidadesMedidaServicios();
      //No borrar el codigo comentado 
      /*for(let i=0; i < unidadesMedidaServicios.length; i++){
        if(nuevaUnidadMedida.simbolo == unidadesMedidaServicios[i]){
            codigo ='Servicio';
            tipoProducto='01';
         }
      }

      if(tipoProducto === ''){
        codigo='Mercancía';
        tipoProducto='02';
      }*/

      if(unidadesMedidaServicios.includes(nuevaUnidadMedida.simbolo)){
        codigo ='Servicio';
        tipoProducto='01';
      }else{
        codigo='Mercancía';
        tipoProducto='02';
      }

      if(typeof codigoProducto === 'undefined') codigoProducto='';
      data = {

          descripcionproducto: descripcionproducto,
          codigoproducto: codigo ,
          precioproducto: precioproducto,
          costounitario: costounitario,
          idcategoria: nuevaCategoria.idcategoria,
          tipoProducto: tipoProducto,
          clasificacion: nuevoClasificacion.id,
          impuesto: nuevoTipoImpuesto.idimpuesto,
          porcentajeImpuesto: parseFloat(document.getElementById("txtporcentajeImpuesto").value),
          unidadmedida: nuevaUnidadMedida.simbolo,
          unidadmedidacomercial: nuevounidadmedidacomercial,
          codigoBarra: codigoProducto
      }

      console.log("data ",data);
    
      insertarFila(data, '/api/product/insert').then(response => {

          if(response.status === 200){
            alert("Producto insertado");
          }

      })

      limpiarFormProductosCrear();
      $scope.refreshInventory()
  }

  $scope.deleteInventory = function (idinventario) {
    data = { idinventario: idinventario }
    insert($scope, $http, $log, '/delete_inventario', data)
    $scope.refreshInventory()
  }

  $scope.composicion_sendData = function (idproducto, descripcionproducto, descripcioncategoria, raw_material) {
    /* for (var i = 0 ; i <raw_material.length; i++) {
      console.log(raw_material[i].cantidadminimainventario)
      console.log(raw_material[i].descripcioninventario)
      console.log(raw_material[i].idinventario)
    } */
    if (typeof idproducto !== 'undefined') {
      $scope.raw_material_copy = raw_material
    } else {
      alert('Por favor seleccione un Producto para editar la Composicion')
      // $scope.clickOnUpload = clickOnUpload;
      setTimeout(hideModal.bind(null, '#composicion-producto-modal'), 1)
      // $('#composicion-producto-modal').modal('hide')
    }
    /* $scope.raw_material_old = [];
      for (var i = 0; i < $scope.raw_material.length ; i++) {
        if (raw_material && typeof raw_material[i].cantidadnecesaria !== 'undefined' && raw_material[i].cantidadnecesaria !== null ) {
          $scope.raw_material_old.push(raw_material[i])
        }
      } */
  }

  $scope.editProduct = function (product_selected) {

    if(typeof product_selected === 'undefined'){
        alert("Seleccione un producto para editar");
        return;
    }else{
      
      let unidadMedida= document.getElementById("txtDescripcionUnidadMedidaAC");
      let unidadSeleccionada= unidadMedida.options[unidadMedida.selectedIndex].value;
      let categoria = document.getElementById("txtDescripcionCategoriaAC");
      let categoriaSeleccionada = categoria.options[categoria.selectedIndex].value;
      let clasificacion= document.getElementById("clasificacioProductoAC");
      let clasificacionSeleccionado = clasificacion.options[clasificacion.selectedIndex].value;
      let tipoImpuesto = document.getElementById("txtTipoImpuestoAC");
      let tipoImpuestoSeleccionado = tipoImpuesto.options[tipoImpuesto.selectedIndex].value;
      const unidadesMedidaServicios = UnidadesMedidaServicios();
      let tipoProducto='';
      let codigo ='';

      //NO BORRAR EL CODIGO COMENTADO
      /*for(let i=0; i < unidadesMedidaServicios.length; i++){
        if(unidadSeleccionada == unidadesMedidaServicios[i]){
            codigo ='Servicio';
            tipoProducto='01';
         }
      }

      if(tipoProducto === ''){
        tipoProducto='02';
        codigo='Mercancía';
      }*/

      if(unidadesMedidaServicios.includes(unidadSeleccionada)){ // saber si existe dentro de los elementos del array
        codigo ='Servicio';
        tipoProducto='01';
        console.log('si')
      }else{
        console.log('NO')
        codigo='Mercancía';
        tipoProducto='02';
      }

      data = {

          idproducto: product_selected.idproducto,
          descripcionproducto: product_selected.descripcionproducto.replace(/ +$/, ''),
          precioproducto: product_selected.precioproducto,
          costounitario: product_selected.costounitario,
          categoria: categoriaSeleccionada,
          impuesto: tipoImpuestoSeleccionado,
          porcentajeimpuesto: product_selected.porcentajeimpuesto,
          unidadmedida: unidadSeleccionada,
          unidadmedidacomercial: product_selected.unidadmedidacomercial,
          tipoProducto: tipoProducto,
          codigoProducto: codigo,
          codigo_impuesto: product_selected.codigo_impuesto,
          clasificacion: product_selected.idclasificacion,
      }

      console.log("data ",data); 
      
      actualizarLinea(data, '/api/product/update').then(response =>{
          if(response.status === 200){
            alert("Actualizado");

            $scope.person_selected=undefined;
          }
      })
      .catch(err => console.error(err));
        limpiarFormProductosEditar();
        $scope.refreshProduct();
      }
  }

  $scope.deleteProduct = function (idproducto) {
    data = {idproducto: idproducto}
    insert($scope, $http, $log, '/api/product/delete', data)
    $scope.refreshProduct()
  }

  /* $scope.saveInventario = function (){
    if (!$('#txtCantidadProducto').val()) {
      alert('Cantidad no definida')
     else if (!$('#txtCostoProducto').val()) {
      alert('Costo no definido')
    } else {
      var data = {
        idProducto: scopeId,
        idProveedor: proveedorId,
        cantidad: cantidadActualInventario + $('#txtCantidadProducto').val().trim() * 1,
        costo: $('#txtCostoProducto').val().trim() * 1
      }
      insert($scope, $http, $log, '/insert_inventario', data)
      update($scope, $http, $log, '/update_inventario', data)
    }
    scopeId = null
    proveedorId = null
    cantidadActualInventario = null
  } */

  /* $http({
      method: 'GET',
      url: '/proveedores'
    then(function (response) {
      $scope.Proveedores = response.data
    }, function errorCallback (response) {
      $log.info(response)
  }) */

  // Cargar Inventarios
  $http({
    method: 'GET',
    url: '/api/inventario'
  }).then(function (response) {
    $scope.Inventario = response.data
    // $log.info(response.data)
    // $scope.inventario_id_array = [];
    // for (var i = 0; i <$scope.Inventario.lenth ; i++) {
    // $scope.inventario_id_array.push($scope.Inventario.lenth[i].idinventario) // saving all inventario index in an Array
  }, function errorCallback (response) {
    $log.error(response)
  }).catch(function (error) {
    $log.error(error)
  })

  // Cargar Categorias de Productos
  $http({
    method: 'GET',
    url: '/categorias_load'
  }).then(function (response) {
    $scope.Categorias = response.data
  }, function errorCallback (response) {
    $log.error(response)
  }).catch(function (error) {
    $log.error(error)
  })

  // Cargar Categorias de Inventario
  $http({
    method: 'GET',
    url: '/categorias_inventario_load'
  }).then(function (response) {
    $scope.CategoriasInventario = response.data
  }, function errorCallback (response) {
    $log.error(response)
  }).catch(function (error) {
    $log.error(error)
  })

  // Cargar Proveedores
  $http({
    method: 'GET',
    url: '/proveedor'
  }).then(function (response) {
    $scope.Proveedores = response.data
  }, function errorCallback (response) {
    $log.error(response)
  }).catch(function (error) {
    $log.error(error)
  })

  /* $scope.deleteProduct = function () {
    var data = {
      descripcionProducto: $('#txtDescripcionProductoDelete').val().trim(),
      id: scopeId
    }
    update($scope, $http, $log, '/api/product/status', data)
    refreshProduct()
  } */

  $scope.refresh = function (templateRight) {
    if (templateRight === 'sell_products') {
      $scope.refreshProduct()
    } else if (templateRight === 'raw_products') {
      $scope.refreshInventory()
    } else {
      $log.error('templateRight does not match')
      $log.error(templateRight)
    }
  }

  $scope.refreshProduct = function () {
    var data = {}
    $scope.product_selected = ''
    $scope.selectedRow = ''
    $scope.raw_material = ''
    $scope.materials_update = []
    $scope.default_idcategory = ''
    loadData($scope, $http, $log, '/api/product', data)

    $http({
      method: 'GET',
      url: '/categorias_load'
    }).then(function (response) {
      $scope.Categorias = response.data
    }, function errorCallback (response) {
      $log.error(response)
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.refreshInventory = function () {
    // var data = {}
    $scope.product_selected = ''
    $scope.selectedRow = ''
    $scope.new_descripcioninventario = ''
    $scope.new_cantidaddisponibleinventario = ''
    $scope.new_costoinventario = ''
    $scope.new_cantidadminimainventario = ''
    $scope.default_idcategory = ''
    $http({
      method: 'GET',
      url: '/api/inventario'
    }).then(function (response) {
      $scope.Inventario = response.data
    }, function errorCallback (response) {
      $log.error(response)
    }).catch(function (error) {
      $log.error(error)
    })

    $http({
      method: 'GET',
      url: '/categorias_inventario_load'
    }).then(function (response) {
      $scope.CategoriasInventario = response.data
    }, function errorCallback (response) {
      $log.error(response)
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $(document).ready(function () {
    getProductData($scope)
    getProductDataDelete($scope)
    getProductInventory($scope)
    getInventoryData($scope)
    validateLetters()
    validateNumbers()
  })

  $scope.sort = function (keyname) {
    $scope.sortKey = keyname // set the sortKey to the param passed
    $scope.reverse = !$scope.reverse // if true make it false and vice versa
  }

  $scope.get_list_inventario_per_product = function (idproducto) {
    $scope.raw_material = ''
    data = { 'idproducto': idproducto }
    $http({
      method: 'GET',
      url: '/api/product/inventario',
      params: data
    }).then(function (response) {
      $scope.raw_material = response.data
      $scope.raw_material_id_array = []
      for (var i = 0; i < $scope.raw_material.length; i++) {
        $scope.raw_material_id_array.push($scope.raw_material[i].idinventario)
      }
    }, function errorCallback (response) {
      $log.error(response)
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.arrayObjectIndexOf = function (myArray, searchTerm, property) {
    for (var i = 0, len = myArray.length; i < len; i++) {
      if (myArray[i][property] === searchTerm) {
        console.log(i)
        return i
      }
    }
    return -1
  }

  $scope.rowClicked = function (product) {
    $scope.selectedRow = false
    $scope.product_selected = product
    if (typeof product.idproducto !== 'undefined') {
      // we are in the sell products tab
      $log.info(product.idproducto)
      $scope.raw_material = ''
      $scope.get_list_inventario_per_product(product.idproducto)
      $scope.selectedRow = product.idproducto
    } else if (typeof product.idinventario !== 'undefined') {
      // we are in the raw materials tab
      $scope.selectedRow = product.idinventario
    }
  }

  $scope.material_selected = function (element, product_selected) {
    var thisIndex = $scope.arrayObjectIndexOf($scope.materials_update, element, 'idinventario')
    console.log(thisIndex)
    if (thisIndex >= 0) {
      $scope.materials_update.push[thisIndex] = element
    } else {
      $scope.materials_update.push(element)
    }
  }

  $scope.save_new_composicion = function (product_selected) {
    for (var i = 0; i < $scope.materials_update.length; i++) {
      var data = {
        'idproducto': product_selected.idproducto,
        'idinventario': $scope.materials_update[i].idinventario,
        'cantidadnecesaria': $scope.materials_update[i].cantidadnecesaria
      }
      if (typeof data.cantidadnecesaria === 'number') {
        insertPromise($scope, $http, $log, '/update/producto/composicion', data).then(function () {
          // $log.info()
        }).catch(function (error) {
          $log.error('/update/producto/composicion FAILED')
        })
      } else {
        alert('La cantidad debe ser Numerica')
        alert(product_selected.descripcionproducto + ' tienen cantidad: ' + data.cantidadnecesaria)
      }
    }
    /* asyncLoop(Object.keys($scope.materials_update).length, function (loop) {
              var data = {
                'idproducto':product_selected.idproducto,
                'idinventario':$scope.materials_update[Object.keys($scope.materials_update)[loop.iteration()]].idinventario,
                'cantidadnecesaria':$scope.materials_update[Object.keys($scope.materials_update)[loop.iteration()]].cantidadnecesaria
              }
              updatePromise($scope, $http, $log, '/update/producto/composicion', data)
              .then(function () {
                console.log('done for idinventario: ' )
                console.log($scope.materials_update[Object.keys($scope.materials_update)[loop.iteration()]].idinventario)
              })
              .catch(function (error){
                $log.error('/update/producto/composicion FAILED')
              })
    }) */
    $scope.materials_update = []
  }

  $scope.cancelarComposicion = function (template_Right) {
    $scope.materials_update = []
    $scope.search = ''
    $scope.refresh(template_Right)
  }

  $scope.cancelarEditProduct = function (template_Right) {
    $scope.materials_update = []
    $scope.refresh(template_Right)
  }

  $scope.cancelarEditInventory = function (template_Right) {
    $scope.materials_update = []
    $scope.refresh(template_Right)
  }

  /* function asyncLoop(iterations, func, callback) {
    var index = 0
    var done = false
    var loop = {
      next: function () {
        if (done) {
          // Return nothing if you call loop.next when loop is finished.
          return
        }
        if (index < iterations) {
          index++;
          func(loop)
        } else {
          done = true;
          callback()
        }
      },
      iteration: function () {
        return index - 1
      },
      break: function () {
        // If one query fails you want to prematurely stop the for loop and inform the client.
        done = true;
        callback()
      }
    }
    loop.next()
    return loop
  } */

  if (typeof $scope.template_Right === 'undefined') {
    $scope.template_Right = 'sell_products'
    $scope.template_Left = 'sell_products_table'
  }

  $scope.reporte_excel4 = function () {
    /*  Metodo para descargar el tipo de reporte4
    https:// stackoverflow.com/questions/36931521/how-to-download-binary-file-in-angular-js-using-http
    https:// ramirezmery.wordpress.com/2016/04/17/angularjs-download-file-with-http-and-web-api/ */
    $http({
      method: 'GET',
      url: '/Excel4',
      responseType: 'arraybuffer'
    }).then(function (file) {
      $log.info(file)
      var ieEDGE = navigator.userAgent.match(/Edge/g)
      var ie = navigator.userAgent.match(/.NET/g) // IE 11+
      var oldIE = navigator.userAgent.match(/MSIE/g)
      var filename = 'Reporte_InventarioDisponible:' + '.xlsx'

      var blob = new window.Blob([file.data], { type: 'application/vnd.openxmlformats' })

      if (ie || oldIE || ieEDGE) {
        // 'Internet Explorer'
        window.navigator.msSaveBlob(blob, filename)
      } else {
        var file = new Blob([file.data], {
          type: 'application/vnd.openxmlformats'
        })
        var fileURL = URL.createObjectURL(file)
        var a = document.createElement('a')
        a.href = fileURL
        a.target = '_blank'
        a.download = filename
        document.body.appendChild(a)
        a.click()
      }
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.reporte_excel5 = function () {
    /* Metodo para descargar el tipo de reporte5
    https:// stackoverflow.com/questions/36931521/how-to-download-binary-file-in-angular-js-using-http
    https:// ramirezmery.wordpress.com/2016/04/17/angularjs-download-file-with-http-and-web-api/ */
    $http({
      method: 'GET',
      url: '/Excel5',
      responseType: 'arraybuffer'
    }).then(function (file) {
      $log.info(file)
      var ieEDGE = navigator.userAgent.match(/Edge/g)
      var ie = navigator.userAgent.match(/.NET/g) // IE 11+
      var oldIE = navigator.userAgent.match(/MSIE/g)
      var filename = 'Reporte_InventarioConsumido:' + '.xlsx'

      var blob = new window.Blob([file.data], { type: 'application/vnd.openxmlformats' })

      if (ie || oldIE || ieEDGE) {
        // 'Internet Explorer'
        window.navigator.msSaveBlob(blob, filename)
      } else {
        var file = new Blob([file.data], {
          type: 'application/vnd.openxmlformats'
        })
        var fileURL = URL.createObjectURL(file)
        var a = document.createElement('a')
        a.href = fileURL
        a.target = '_blank'
        a.download = filename
        document.body.appendChild(a)
        a.click()
      }
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.template_Right_action = function (key) {
    if (key === 'raw') {
      $scope.template_Right = 'raw_products'
    }
  }
}).controller('facturaController', function ($scope, $http, $log, serviceRestaurant, $window) {
  $scope.bill = ''
  $scope.scale = '2' // style='transform: scale(2)'
  $scope.idCuenta = serviceRestaurant.getidCuenta()
  $scope.idEmpleado = serviceRestaurant.getidEmpleado()
  $scope.idFactura = 0
  if (typeof $scope.idCuenta === 'undefined' || $scope.idCuenta === '-1') {
    alert('Por favor seleccione una Cuenta')
    $window.location.href = '/sopa#!/restaurante'
  }

  var data = { idCuenta: $scope.idCuenta }

  /* var porcentajeDescuento = ''
  var descuentoColones = ''
  // var porcentajeServicio = '';
  var cantidadDivisiones = ''
  var totalPagar = ''
  var totalMenosDescuento = ''
  // var totalMasServicio = '';
  // var sumaCargoServicio = 0;
  var totalDividida = ''
  var nombreCliente = '' */

  if ($scope.idCuenta !== '-1' || $scope.idCuenta !== 'undefined' || $scope.idCuenta !== undefined || $scope.idCuenta !== null || typeof $scope.idCuenta !== 'undefined') {
    loadData($scope, $http, $log, '/factura', data)

    infoCuenta($scope, $http, $log, '/pendingTotal', data)
    // $scope.totalPagar = infoCuenta($scope, $http, $log, '/pendingTotal', data)
    // $scope.totalMenosDescuento = $scope.totalPagar;
    // $scope.totalDividida = $scope.totalMenosDescuento;

    // var onCheckBoxDescuentoChange
    // var onCheckBoxServicioChange = '';
    // var onCheckBoxDividirChange

    $scope.cambiocboxDescuento = function () {
      $scope.onCheckBoxDescuentoChange = $scope.valueDescuento ? 'Checked' : 'UnChecked'
      recalcularFactura()
    }

    $scope.cambiotxtDescuento = function () {
      $scope.valueDescuento = 'UnChecked'
      recalcularFactura()
    }

    $scope.cambiocboxDividirCuenta = function () {
      $scope.onCheckBoxDividirChange = $scope.valueDividir ? 'Checked' : 'UnChecked'
      $scope.cantidadDivisiones = $scope.valueCantDivisiones
      if ($scope.cantidadDivisiones === '' || !$scope.cantidadDivisiones || typeof $scope.cantidadDivisiones === 'undefined') {
        $('#cantDivisiones').val(2)
      }
      recalcularFactura()
    }

    $scope.cambioSelectDivision = function () { recalcularFactura() }

    $scope.pagarCuenta = function () {
      if (!$scope.idCuenta) {
        alert('Por favor elija una cuenta activa antes de pagar')
        $('#new-factura-modal').modal('hide')
        return false // Pendiente que el modal no ejecute ningun query
      } else {
        var elementsRequested = []
        $('#facturaTable').find('tr').each(function () {
          var row = $(this)

          if (row.find('input[type="checkbox"]').is(':checked')) {
            var idOrden = row.find('input[type="checkbox"]').attr('idOrden') // si se ocupa
            var descripcionProducto = row.find('input[type="checkbox"]').attr('descripcionProducto')
            var subtotal = row.find('input[type="checkbox"]').attr('subTotal')
            var cantidadproducto = row.find('input[type="checkbox"]').attr('cantidad')
            var descuentoOrden = 0
            if ($scope.onCheckBoxDescuentoChange === true || $scope.onCheckBoxDescuentoChange === 'Checked') {
              descuentoOrden = row.find('input[type="checkbox"]').attr('descuentoOrden')
            }

            elementsRequested.push({
              'idOrden': idOrden,
              'descripcionproducto': descripcionProducto,
              'subtotal': subtotal,
              'cantidadproducto': cantidadproducto,
              'descuentoorden': descuentoOrden
            })
            $scope.bill = elementsRequested
          }
        })

        $scope.obj = elementsRequested
        $scope.elements = []

        if (elementsRequested.length === 0) {
          alert('Por favor, seleccione alguna de las ordenes para pagar.')
          $('#new-factura-modal').modal('hide')
          hideModal('#new-factura-modal')
          $window.location.href = '/sopa#!/restaurante'
          return
        }

        for (var i = 0; i < elementsRequested.length; i++) {
          if (!estaProductoFactura(elementsRequested[i])) {
            $scope.elements.push(elementsRequested[i])
          }
        }

        var totalPagar1 = $scope.totalPagar

        $scope.descuentoColones = totalPagar1 - $scope.totalMenosDescuento
        $scope.porcentajeDescuento = (1 - $scope.totalMenosDescuento / totalPagar1) * 100
        $scope.porcentajeDescuento = parseFloat($scope.porcentajeDescuento).toFixed(2)

        if ($scope.onCheckBoxDividirChange === false || typeof $scope.onCheckBoxDividirChange === 'undefined' || $scope.onCheckBoxDividirChange === 'UnChecked') {
          $scope.cantidadDivisiones = 1
        }

        $scope.totalDividida = $scope.totalMenosDescuento / $scope.cantidadDivisiones
      }
    }

    $scope.selectOrder = function () {
      $scope.totalPagar = 0
      $('#facturaTable').find('tr').each(function () {
        var row = $(this)
        if (row.find('input[type="checkbox"]').is(':checked')) {
          var subTotal = row.find('input[type="checkbox"]').attr('subTotal')
          $scope.totalPagar += subTotal * 1
        }
      })
      recalcularFactura()
    }

    $scope.cancelarPago = function () { $window.location.href = '/sopa#!/restaurante' }

    $(document).ready(function () { validateNumbers() })
  } else {
    alert('Por favor, seleccione una cuenta válida')
    $window.location.href = '/sopa#!/restaurante'
  }

  function estaProductoFactura (producto) {
    for (var j = 0; j < $scope.elements.length; j++) {
      if (producto.descripcionproducto.trim() === $scope.elements[j].descripcionproducto.trim()) {
        $scope.elements[j].cantidadproducto = ($scope.elements[j].cantidadproducto * 1) + (producto.cantidadproducto * 1)
        $scope.elements[j].subtotal = ($scope.elements[j].subtotal * 1) + (producto.subtotal * 1)
        return true
      }
    }
    return false
  }

  function infoCuenta ($scope, $http, $log, route, data) {
    $http({
      method: 'GET',
      url: route,
      params: data
    }).then(function (response) {
      var cuenta = response.data[0].cuenta
      $scope.totalPagar = cuenta // response.data[0].cuenta;
      $scope.totalMenosDescuento = cuenta // response.data[0].cuenta;
      $scope.totalDividida = cuenta // response.data[0].cuenta;
      return cuenta // response.data[0].cuenta;
    }).catch(function (error) {
      $log.error(error)
    })
  }

  function recalcularFactura () {
    $scope.totalMenosDescuento = $scope.totalDividida = $scope.totalPagar
    $scope.onCheckBoxDescuentoChange = $scope.valueDescuento
    $scope.cantidadDivisiones = $('#cantDivisiones').val().trim()
    if ($scope.onCheckBoxDescuentoChange === true) {
      var sumaDescuento = 0
      $('#facturaTable').find('tr').each(function () {
        var row = $(this)
        if (row.find('input[type="checkbox"]').is(':checked')) {
          var subtotal = row.find('input[type="checkbox"]').attr('subTotal')
          var descuentoOrden = row.find('input[type="checkbox"]').attr('descuentoOrden')
          if (descuentoOrden === '') { descuentoOrden = 0 }
          sumaDescuento += subtotal * descuentoOrden / 100
        }
      })
      $scope.totalMenosDescuento -= sumaDescuento
    }
    if ($scope.onCheckBoxDividirChange === 'Checked') {
      $scope.totalDividida = $scope.totalMenosDescuento / $scope.cantidadDivisiones
    } else {
      $scope.totalDividida = $scope.totalMenosDescuento
    }
  }

  function getRadioVal (form, name) {
    var val
    // get list of radio buttons with specified name
    var radios = form.elements[name]
    // loop through list of radio buttons
    for (var i = 0, len = radios.length; i < len; i++) {
      if (radios[i].checked) { // radio checked?
        val = radios[i].value // if so, hold its value in val
        break // and break out of for loop
      }
    }
    return val // return value of checked radio or undefined if none checked
  }
/*
  $scope.pagarOrden = function () {
    var val = getRadioVal(document.getElementById('formaPagoForm'), 'tipoPago')
    if (!$scope.idCuenta) {
      alert('Por favor elija una cuenta')
    } else if ($scope.obj.length === 0) {
    } else {
      $http({
        method: 'GET',
        url: '/cantidadFacturas',
        params: {}
      }).then(function (response) {
        $scope.idFactura = response.data[0].factura + 1
        if ($scope.porcentajeDescuento === '' || !$scope.porcentajeDescuento || typeof $scope.porcentajeDescuento === 'undefined') {
          $scope.porcentajeDescuento = 0
        }
        var dataFactura = {
          subTotal: $scope.totalPagar,
          descuento: $scope.porcentajeDescuento,
          cantPersonas: Math.floor($scope.totalPagar / $scope.totalDividida),
          idCuenta: $scope.idCuenta,
          idEmpleado: $scope.idEmpleado,
          formaPago: val
        }
        $http({
          method: 'POST',
          url: '/insertar_factura',
          data: JSON.stringify(dataFactura)
        }).then(function (response) {
          for (var i = 0; i < $scope.obj.length; i++) {
            if ($scope.obj[i].descuentoorden === '') {
              $scope.obj[i].descuentoorden = 0
            }
            var data = {
              id: $scope.obj[i].idOrden,
              idFactura: $scope.idFactura,
              cantidad: $scope.obj[i].cantidadproducto,
              descuentoOrden: $scope.obj[i].descuentoorden
              // servicioAplicado: servicio
            }
            // update inventario
            $http({
              method: 'POST',
              url: '/disminuir_inventario',
              data: JSON.stringify(data)
            }).then(function (response) {
              $log.info(response)
            }, function errorCallback (response) {
              $log.error(response)
            }).catch(function (error) {
              $log.error(error)/
            })
            if (i === $scope.obj.length - 1) {
              $('#imprimir-factura-modal').modal('show')
              $scope.imprimirFactura($scope.elements) // esto debe ser trabajado arduamente
            }
            insertPromise($scope, $http, $log, '/order_cost', data).then(function () {}).catch(function (error) {
              $log.error(error)
            })
            // update orden -> pasa a cancelada / pagada
            updatePromise($scope, $http, $log, '/api/order/pay', data).then(function () {}).catch(function (error) {
              $log.error(error)
            })
          }

            //--------------------------------

          $http({
            method: 'GET',
            url: '/get_products_to_update_details'
          }).then(function (response) {
            var productos = response.data


          console.log(productos)


          }, function errorCallback (response) {
            $log.error(response)
          }).catch(function (error) {
            $log.error(error)
          })

            //-------------------------------


        }, function errorCallback (response) {
          $log.error(response)
        }).catch(function (error) {
          $log.error(error)
        })
      }).catch(function (error) {
        $log.error(error)
      })
    }
  }

*/
 /* $scope.actualizarCamposOrden=function(){

            $http({
          method: 'GET',
          url: '/get_products_to_update_details'
        }).then(function (response) {
          var products=response.data;
           //console.log("response", response.data)
           //console.log(products);
           //console.log(descuentos);
         console.log($scope.detallesOrden(products));//
          AddnewOrders($scope.detallesOrden(products));n
          //console.log($scope.camposOrden(products));
        }, function errorCallback (response) {
          $log.error(response.data.idCuenta);
        }).catch(function (error) {
          $log.error(error)
        })
  }*/
  $scope.imprimirOrden = function (action) {
    if (action === 'ok') { $scope.imprimirFactura($scope.elements) }
    $window.location.href = '#!/restaurante'
  }

  $scope.refreshFactura = function () {
    var data = {idCuenta: $scope.idCuenta}
    loadData($scope, $http, $log, '/factura', data)
  }

  $scope.imprimirFactura = function (bill) {
    if ($scope.porcentajeDescuento === '' || !$scope.porcentajeDescuento || $scope.porcentajeDescuento === undefined) {
      $scope.porcentajeDescuento = 0
    }
    var descuentoAplicado = $scope.totalPagar * $scope.porcentajeDescuento / 100
    var data = {
      idCuenta: $scope.idCuenta,
      // nombreCliente: $scope.nombreCliente,
      idFactura: $scope.idFactura,
      cantidad: $scope.cantidad,
      bill: bill,
      idEmpleado: scopeidEmpleado,
      descuento: descuentoAplicado,
      totalMenosDescuento: $scope.totalMenosDescuento,
      subtotal: $scope.totalPagar
    }
    insert($scope, $http, $log, '/imprimirFactura', data)
  }
}).controller('restaurantController', function ($scope, $http, $interval, myService, $log, serviceRestaurant) {

  let insertarFila = (data, route) =>{
       return new Promise((resolve,reject) => {
         $http({ method: 'POST', url: route, params: data, data: data})
         .then(data => {
          resolve(data);
         }).catch(err =>{
           reject(err);
         })
       })
  }

  let enviar = (data, route) =>{
    return new Promise((resolve, reject) =>{
        $http({ method: 'POST', url: route, params: data})
        .then(data => {
        resolve(data);
        }).catch(err =>{
          reject(err);
        })
      })
  }

  let getLinea= (data,route)=> {
    return new Promise((resolve,reject) => {
         $http({ method: 'GET', url: route, params: data})
         .then(data => {
          resolve(data);
         }).catch(err =>{
           reject(err);
         })
       })
  }

  let actualizarLinea= (data,route)=> {
    return new Promise((resolve,reject) => {
         $http({ method: 'PUT', url: route, params: data})
         .then(data => {
          resolve(data);
         }).catch(err =>{
           reject(err);
         })
       })
  }

  let obtenerNumeros_Emisor_Receptor = function(numero){
    let contador=0;

    for(let i=0; i < numero.length; i++){
      console.log(numero[i])
      if(i < 3){
        if(numero[i] == '0'){
          contador++;
        }
      }
    }
    numero= numero.substring(contador, numero.length);
    return numero;
  }

  $http.get('/emisor').then(function success(response){
      if(response.data.length == 0){
        alert("Por favor ingrese al módulo de emisor para configurar su información")
      }
  },
   function error(err){
    console.log(err);
  });

  getLinea({},'/descuentos').then(data => {
    let array=data.data
    $scope.arrayDescuentos={};
    for (let i in array) {
      if(array[i].estadodescuento){
          $scope.arrayDescuentos[i]={
            'iddescuento': array[i].iddescuento,
            'descripciondescuento': array[i].descripciondescuento,
            'porcentajedescuento': array[i].porcentajedescuento
        }
      }
    }
    console.log($scope.arrayDescuentos)
  })
  .catch(err => {
      console.log(err);
  })

  var cantRefresh = 0
  $scope.cantidadPersonas = 1
  window.setInterval(function () {
    if (++cantRefresh < 3) {
      ordersPending()
      totalPagarPerIdCuenta('1')
    }
  }, 2000)

  $scope.periodoVenta = ''
  $scope.listaDescuentos = [5, 10, 15, 20, 22.22, 28.6, 50]
  var data = {}

  ordersPending()
  loadData($scope, $http, $log, '/api/product', data)

  getUserId()
  getPeriodInfo(getUserId)
  $scope.obj = {}

  $scope.my_idCuenta = 1
  serviceRestaurant.setidCuenta($scope.my_idCuenta)

  totalPagarPerIdCuenta($scope.my_idCuenta)

  // refresh restaurant page
  $scope.refresh = function () {
    // clear client search on restaurant
    $scope.searchClient = ''
    $scope.periodoVenta = ''
    ordersPending()
    getUserId()
    getPeriodInfo(getUserId)
    $scope.obj = {}
    $scope.clear_submit()
    $scope.my_idCuenta = 1
    serviceRestaurant.setidCuenta($scope.my_idCuenta)
    totalPagarPerIdCuenta($scope.my_idCuenta)
    getOrdersPerAccount($scope, $http, $log, '/api/orders/pending', {})
  }
  $scope.refreshReceptor=function(){


  }
  function getPeriodInfo (callback) {
    $http({
      method: 'GET',
      url: '/api/period'
    }).then(function (response) {
      $scope.idPeriodoVenta = response.data[0].idperiodoventa
      $scope.nombrePeriodo = response.data[0].nombreperiodoventa
      $scope.fechaInicioPeriodo = response.data[0].fechainicioperiodo
      $scope.horaInicioPeriodo = response.data[0].horainicioperiodo
      var temp = $scope.nombrePeriodo + ' ' + $scope.fechaInicioPeriodo
      serviceRestaurant.set_periodoVenta(temp) // serviceDashboard -> serviceRestaurant
      $scope.periodoVenta = serviceRestaurant.getPeriodoVenta()
    }).catch(function (error) {
      $log.error(error)
    })
    if (typeof callback === 'function') {
      callback()
      return true
    }
    return true
  }

  validateNumbers()
  validateLetters()


  $scope.tipoCambio=function(){



    getPromise($scope, $http, $log, '/emisor', {}, false).then(emisor =>  {

          var f = new Date();
          console.log(f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear());
        var obj={
          '1':{
              'tcIndicador': 317,
              'tcFechaInicio': f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear(),
              'tcFechaFinal': f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear(),
              'tcNombre': emisor[0].e_nombre,
              'tnSubNiveles': 'N'
          }
        }

        console.log(obj[1]);
      getPromise($scope, $http, $log, '/tipoCambio', obj[1], false).then(function (tipocambio) {
          console.log(tipocambio)

            if(window.DOMParser){ // PARSEAR el xml para poder leerlo
                      parser= new DOMParser();
                      xmlDoc=parser.parseFromString(tipocambio,"text/html");

                      //console.log("xml ",xmlDoc);
            }
             else
             {
                // EN EL CASO QUE SEA INTERNET EXPLORER
                      xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
                      xmlDoc.async=false;
                      xmlDoc.loadXML(tipocambio);
             }
              var tipocambio= Number(xmlDoc.getElementsByTagName("NUM_VALOR")[0].innerHTML).toFixed(2);
             console.log(tipocambio);

             $("#tipoCambio").val(tipocambio)

      })
    })


   }


    $scope.receptores = function(){
          $http.get('/receiver').then(function success(response){
          // Update Model-- Line X
          console.log(response.data)
           $scope.data = response.data;
           $scope.receptor=[];
           $scope.receptor=$scope.data;
           let primeros_3=[];
           let contador=0;
            for (var i = 0; i < $scope.receptor.length; i++) {

              $scope.receptor[i].checked = false
              primeros_3= $scope.receptor[i].receptor_numero.substr(0,3);


                for(let b=0; b < primeros_3.length; b++){

                    if(primeros_3.charAt(b) === "0"){

                      contador++;
                    }

                }

                $scope.receptor[i].receptor_numero= $scope.receptor[i].receptor_numero.substr(contador,$scope.receptor[i].receptor_numero.length);
                contador=0;
            }

         },
          function error(err){
            console.log(err);
            alert("Se ha producido un error al cargar los receptores")
        });
    }

    $http.get('/receiver/lastId').then(function success(response){
          // Update Model-- Line X
           if(response.data.length > 0){
            $("#ultimoIdRcecptor").val(response.data[0].idreceptor)
            console.log("ultimo ",$("#ultimoIdRcecptor").val());
           }else{
            $("#ultimoIdRcecptor").val(0);
           }
         },
          function error(err){
            console.log("error ")
        });

    $scope.receptores();
   $scope.tipoCambio();
  $scope.tipoIds = {
    '1': {
      id: '01',
      name: 'Fisica'
    },
    '2': {
      id: '02',
      name: 'Juridica'
    },
    '3': {
      id: '03',
      name: 'DIMEX'
    },
    '4': {
      id: '04',
      name: 'NITE'
    }
  }

  $scope.discounts = {
    '1': {
      valor: 5,
      texto: '5'
    },
    '2': {
      valor: 10,
      texto: '10'
    },
    '3': {
      valor: 20,
      texto: '20'
    },
    '4': {
      valor: 25,
      texto: '25'
    },
    '5': {
      valor: 50,
      texto: '50'
    }
  }

    $scope.Naturaleza = {
     '1':{
       id:'1',
       descripcion:'Naturaleza Descuento 1'
     },
     '2':{
       id:'2',
       descripcion:'Naturaleza Descuento 2'
     },
     '3':{
       id:'3',
       descripcion:'Naturaleza Descuento 3'
     },
     '4':{
       id:'4',
       descripcion:'Naturaleza Descuento 4'
     },
     '5':{
       id:'5',
       descripcion:'Naturaleza Descuento 5'
     }
    }

       $scope.tipoComprobante=[{

          descripcion:'Factura Electrónica',
          codigo:'01'
          },{
          descripcion:'Nota de débito electrónica',
          codigo:'02'
          },{
          descripcion:'Nota de crédito electrónica',
          codigo:'03'
          },{
          descripcion:'Tiquete electrónico',
          codigo:'04'
          },{
          descripcion:'Confirmación de aceptación del comprobante electrónico',
          codigo:'05'
          },{
          descripcion:'Confirmación de aceptación parcial del comprobante electrónico',
          codigo:'06'
          },{
          descripcion:'Confirmación de rechazo del comprobante electrónico',
          codigo:'07'
        }]



    $scope.condicionVenta=[{

         condicion: 'Contado',
         id:'01'
        },{
         condicion: 'Crédito',
         id:'02'

    }]


    $scope.mediosPago=[{
        id: '01',
        medio: 'Efectivo'
      },
     {
        id: '02',
        medio: 'Tarjeta'
      },
     {
        id: '03',
        medio: 'Cheque'
      },
      {
        id: '04',
        medio: 'Depósito bancario'
      },
      {
        id: '05',
        medio: 'Recaudado por terceros'
      },
      {
        id: '99',
        medio: 'Otros'
      }]
    //FUNCIONES PARA FACTURACION ELECTRONICA

    let actualizarFactura= function(tipo, tipoCambio, total_impuestos, ordenes){
        //console.log("comprobante ", tipo);
        return new Promise((resolve, reject)=> {

        var total_impuestos=0;
        var receptorNumero='';
        var idreceptor=0;

        if(document.getElementById("idreceptor").value == ""){
          
          idreceptor=0
          receptorNumero="000000000000";

        }else{
          //console.log("#idreceptor lleno")
          idreceptor=document.getElementById("idreceptor").value;
          receptorNumero=document.getElementById("receptor").value;
        }

        //console.log("ordenes actuales para operar",$scope.orders);

        /*----------------------------------TOTALIZA-------------------------------------------*/
        var TotalServGravados    = 0;
        var TotalServExentos     = 0;
        var TotalServExonerado   = 0; //No operable por ahora

        var TotalMercanciasGravadas  = 0;
        var TotalMercanciasExentas   = 0;
        var TotalMercExonerada     = 0; //No operable por ahora

        var TotalDescuentos  = 0;
        var TotalGravado     = 0;
        var TotalExento    = 0;
        var TotalExonerado   = 0; //No operable por ahora
        var TotalVenta     = 0;
        var TotalVentaNeta   = 0;
        var TotalImpuesto    = 0;
        var TotalIVADevuelto   = 0;
        var TotalOtrosCargos = 0;
        var TotalComprobante = 0;

            // $linea = null;

            console.log("ORDEN", ordenes);
            ordenes.forEach(function(orden){
              //Definimos variables operadoras
              var monto_total = parseFloat(orden.cantidadproducto) * parseFloat(orden.preciounitarioproducto);
              console.log("monto_total "+monto_total+" en "+orden.descripcionproducto);

              var subTotal = parseFloat(monto_total - (monto_total * parseFloat(orden.descuentoorden) / 100));
              console.log("subTotal "+subTotal+" en "+orden.descripcionproducto);
              //console.log("MONTO TOTAL", monto_total);

              /*
              * Sumatoria de productos RELACIONADOS con impuestos IVA - No excentos.
              */
              if((orden.codigo_impuesto == "01" || orden.codigo_impuesto == "07") && orden.tipo_impuesto != "01"){
                //console.log("entró en iva de no excentos");
                /*Suma los totales de productos de tipo SERVICIO */
                if(orden.tipo_producto == "01"){
                  TotalServGravados += monto_total;
                }

                /*Suma los totales de productos de tipo MERCANCIA */
                if(orden.tipo_producto == "02"){
                  TotalMercanciasGravadas += monto_total;
                }

                /* Sumatoria de impuestos relacionados con IVA*/
                TotalImpuesto += parseFloat(subTotal * parseFloat(orden.porcentajeimpuesto) / 100);
                TotalGravado  += monto_total;
              }

              /*
              * Sumatoria de productos con IVA, pero excentos del mismo (0%).
              */
              if((orden.codigo_impuesto == "01" || orden.codigo_impuesto == "07") && orden.tipo_impuesto == "01"){

                /*Suma los totales de productos de tipo SERVICIO */
                if(orden.tipo_producto == "01"){
                  TotalServExentos += monto_total;
                }
                /*Suma los totales de productos de tipo MERCANCIA */
                if(orden.tipo_producto == "02"){
                  TotalMercanciasExentas += monto_total;
                }

                TotalExento += monto_total;
              }

              /* Sumatoria de impuestos NO relacionados con IVA*/
              if(orden.codigo_impuesto != "01" && orden.codigo_impuesto != "07"){
                TotalImpuesto += parseFloat(subTotal * parseFloat(orden.porcentajeimpuesto)/ 100);
              }

              /*Suma todos los descuentos de una factura*/
              if(orden.descuentoorden > 0){
                TotalDescuentos += parseFloat(orden.montodescuento);
              }
            }); /*End Foreach*/

            TotalVenta     = TotalGravado + TotalExento + TotalExonerado;
            TotalVentaNeta   = TotalVenta - TotalDescuentos;
            TotalComprobante   = parseFloat(TotalVentaNeta + TotalImpuesto + TotalOtrosCargos);

            /*Respuesta en formato array*/
            var totales = {
                    "TotalServGravados":  TotalServGravados,
                    "TotalServExentos"      : TotalServExentos,
                    "TotalServExonerado"    : TotalServExonerado,
                    "TotalMercanciasGravadas" : TotalMercanciasGravadas,
                    "TotalMercanciasExentas"  : TotalMercanciasExentas,
                    "TotalMercExonerada"    : TotalMercExonerada,
                    "TotalGravado"        : TotalGravado,
                    "TotalExento"         : TotalExento,
                    "TotalExonerado"      : TotalExonerado,
                    "TotalVenta"          : TotalVenta,
                    "TotalDescuentos"     : TotalDescuentos,
                    "TotalVentaNeta"      : TotalVentaNeta,
                    "TotalImpuesto"       : TotalImpuesto,
                    "TotalIVADevuelto"      : TotalIVADevuelto,
                    "TotalOtrosCargos"      : TotalOtrosCargos,
                    "TotalComprobante"      : TotalComprobante
                  };

            console.log("TOTALIZACIÓN: ", totales);
          /*----------------------------------TOTALIZA-------------------------------------------*/
        let objeto = {

         
              'total_serv_gravados': parseFloat(totales.TotalServGravados),
              'total_serv_exentos': parseFloat(totales.TotalServExentos),
              'total_serv_exonerado': parseFloat(totales.TotalServExonerado), // -----------NUEVO
              'total_merc_gravada': parseFloat(totales.TotalMercanciasGravadas),
              'total_merc_exenta': parseFloat(totales.TotalMercanciasExentas),
              'total_merc_exonerada': parseFloat(totales.TotalMercExonerada), // -----------NUEVO
              'total_gravados': parseFloat(totales.TotalGravado),
              'total_exentos': parseFloat(totales.TotalExento),
              'total_exonerado': parseFloat(totales.TotalExonerado), // -----------NUEVO
              'total_ventas': parseFloat(totales.TotalVenta),
              'total_descuentos': parseFloat(totales.TotalDescuentos),
              'total_ventas_neta': parseFloat(totales.TotalVentaNeta),
              'total_impuestos': parseFloat(totales.TotalImpuesto),
              'total_comprobante': parseFloat(totales.TotalComprobante),
              'idreceptor': idreceptor,
              'receptorNumero': receptorNumero,
              'tipoCambio': tipoCambio,
              'tipo': tipo
             
           }

           const data={
            'obj': objeto
           }

           //console.log("objeto factura ", objeto[1]);

           actualizarLinea( data , '/factura/actualizar').then( response => {

              const data= {tipoComprobante: $scope.tipoComprobanteId}

              getLinea(data, '/send_tipoComprobante').then(response =>{

                  document.getElementById('tipoComprobante').selectedIndex = null;
                  const id = document.getElementById("idfactura").value;
                  

                  if(id != ""){

                  const idfactura=id;
                  const data_xml={ idfactura}

                  const datos= {
                   data: data_xml,
                    id:  idfactura
                   }
                  
                  resolve(datos);
                  }else{
                    throw new Error("ID de la factura está vacío");
                  }
              })
           })
           .catch(err => {
             //throw new Error("error "+err);
             reject(err);
           })
        })
    }

    let obtenerInformacion_ParaXML = function(obj){

        return new Promise((resolve, reject) => {
          getLinea(obj.data, '/get_data_toxml').then(response => {
            let ObjXML= response.data;
            console.log("objeto xml ", response.data);
            if(ObjXML.length < 1){
              throw new Error("La informacion de la factura está vacía");
            }else{

              resolve(response);
            }

          })
          .catch(err => {
            reject(err);
          })
        })
    }

    let ObjXMLFactura= function(response){

        let distrito_emisor='';
        let canton_receptor='';
        let distrito_receptor='';
        let numero_emisor= obtenerNumeros_Emisor_Receptor(response.data[0].emisor_numero);
        let numero_receptor=obtenerNumeros_Emisor_Receptor(response.data[0].receptor_numero);

        if(Number(response.data[0].e_canton) < 10){ canton_emisor= '0'+String(response.data[0].e_canton)  }else{ canton_emisor=response.data[0].e_canton }
        if(Number(response.data[0].e_distrito) < 10){ distrito_emisor= '0'+String(response.data[0].e_distrito) }else{ distrito_emisor= response.data[0].e_distrito }

        if(Number(response.data[0].canton) < 10){ canton_receptor= '0'+String(response.data[0].canton)  }else{ canton_receptor=response.data[0].canton }
        if(Number(response.data[0].distrito) < 10){ distrito_receptor= '0'+String(response.data[0].distrito) }else{ distrito_receptor= response.data[0].distrito }

        let medios_pago_json = '[{"codigo": "' + response.data[0].medio_pago + '"}]'
        $log.info("MediosPago:")
        $log.info(medios_pago_json)

          var obj={
                  '1':{
                    'w': 'genXML',
                    'r': 'gen_xml_fe',
                    'clave': response.data[0].clavenumerica,
                    'codigo_actividad': response.data[0].codigo_actividad,
                    'consecutivo': response.data[0].consecutivo,
                    'fecha_emision': response.data[0].fechaemision,
                    'emisor_nombre': response.data[0].e_nombre,
                    'emisor_tipo_identif': response.data[0].emisor_tipo_identificacion,
                    'emisor_num_identif': numero_emisor,
                    'emisor_nombre_comercial': response.data[0].e_nombrecomercial,
                    'emisor_provincia': response.data[0].e_provincia,
                    'emisor_canton': canton_emisor,
                    'emisor_distrito': distrito_emisor,
                    'emisor_barrio' : '01',
                    'emisor_otras_senas': response.data[0].e_otras_senas,
                    'emisor_cod_pais_tel': response.data[0].emisor_telefono_codigopais,
                    'emisor_tel': response.data[0].emisor_telefono_numtelefono,
                    'emisor_cod_pais_fax': response.data[0].emisor_fax_codigopais,
                    'emisor_fax': response.data[0].emisor_fax_numtelefono,
                    'emisor_email': response.data[0].e_correoelectronico,
                    'receptor_nombre': response.data[0].nombre,
                    'receptor_tipo_identif': response.data[0].receptor_tipo_identificacion,
                    'receptor_num_identif': numero_receptor,
                    'receptor_provincia': response.data[0].provincia,
                    'receptor_canton': canton_receptor,
                    'receptor_distrito': distrito_receptor,
                    'receptor_barrio' : '01',
                    'receptor_cod_pais_tel': response.data[0].receptor_telefono_codigopais,
                    'receptor_tel': response.data[0].receptor_telefono_numtelefono,
                    'receptor_cod_pais_fax': response.data[0].receptor_fax_codigopais,
                    'receptor_fax': response.data[0].receptor_fax_numtelefono,
                    'receptor_email': response.data[0].correoelectronico,
                    'condicion_venta': response.data[0].condicion_venta,
                    'plazo_credito': response.data[0].plazo_credito,
                    'medios_pago': medios_pago_json,
                    'cod_moneda': response.data[0].codigomoneda,
                    'tipo_cambio': response.data[0].tipocambio,
                    'total_serv_gravados': response.data[0].totalservgravados,
                    'total_serv_exentos': response.data[0].totalservexentos,
                    'total_serv_exonerados': response.data[0].totalservexonerado,
                    'total_merc_gravada': response.data[0].totalmercanciasgravadas,
                    'total_merc_exenta': response.data[0].totalmercanciasexentas,
                    'total_merc_exonerada': response.data[0].totalmercanciaexonerada,
                    'total_gravados': response.data[0].totalgravado,
                    'total_exentos': response.data[0].totalexento,
                    'total_exonerado': response.data[0].totalexonerado,
                    'total_ventas': response.data[0].totalventa,
                    'total_descuentos': response.data[0].totaldescuentos,
                    'total_ventas_neta': response.data[0].totalventaneta,
                    'total_impuestos': response.data[0].totalimpuesto,
                    'total_comprobante': response.data[0].totalcomprobante,
                    'otros': 'Muchas gracias',
                    'detalles': response.data[0].descripcion_detalle,
                    'password': response.data[0].password_email,
                    'tipoComprobante': "factura"
                    }
              }
        console.log("Objeto de factura ObjXMLFactura", obj)
        let data={obj : obj[1]}
        return data;
    }


    let ObjXMLTiquete= function(response){

        let canton_emisor='';
        let distrito_emisor='';
        let numero_emisor= obtenerNumeros_Emisor_Receptor(response.data[0].emisor_numero);

        if(Number(response.data[0].e_canton) < 10){ canton_emisor= '0'+String(response.data[0].e_canton)  }else{ canton_emisor=response.data[0].e_canton }
        if(Number(response.data[0].e_distrito) < 10){ distrito_emisor= '0'+String(response.data[0].e_distrito) }else{ distrito_emisor= response.data[0].e_distrito }

        let medios_pago_json = '[{"codigo": "' + response.data[0].medio_pago + '"}]'
        $log.info("MediosPago:")
        $log.info(medios_pago_json)

            var obj={
                  '1':{
                    'w': 'genXML',
                    'r': 'gen_xml_te',
                    'clave': response.data[0].clavenumerica,
                    'codigo_actividad': response.data[0].codigo_actividad,
                    'consecutivo': response.data[0].consecutivo,
                    'fecha_emision': response.data[0].fechaemision,
                    'emisor_nombre': response.data[0].e_nombre,
                    'emisor_tipo_identif': response.data[0].emisor_tipo_identificacion,
                    'emisor_num_identif': numero_emisor,
                    'emisor_nombre_comercial': response.data[0].e_nombrecomercial,
                    'emisor_provincia': response.data[0].e_provincia,
                    'emisor_canton': canton_emisor,
                    'emisor_distrito': distrito_emisor,
                    'emisor_barrio' : '01',
                    'emisor_otras_senas': response.data[0].e_otras_senas,
                    'emisor_cod_pais_tel': response.data[0].emisor_telefono_codigopais,
                    'emisor_tel': response.data[0].emisor_telefono_numtelefono,
                    'emisor_cod_pais_fax': response.data[0].emisor_fax_codigopais,
                    'emisor_fax': response.data[0].emisor_fax_numtelefono,
                    'emisor_email': response.data[0].e_correoelectronico,
                    'condicion_venta': response.data[0].condicion_venta,
                    'plazo_credito': response.data[0].plazo_credito,
                    'medios_pago': medios_pago_json,
                    'cod_moneda': response.data[0].codigomoneda,
                    'tipo_cambio': response.data[0].tipocambio,
                    'total_serv_gravados': response.data[0].totalservgravados,
                    'total_serv_exentos': response.data[0].totalservexentos,
                    'total_serv_exonerados': response.data[0].totalservexonerado,
                    'total_merc_gravada': response.data[0].totalmercanciasgravadas,
                    'total_merc_exenta': response.data[0].totalmercanciasexentas,
                    'total_merc_exonerada': response.data[0].totalmercanciaexonerada,
                    'total_gravados': response.data[0].totalgravado,
                    'total_exentos': response.data[0].totalexento,
                    'total_exonerado': response.data[0].totalexonerado,
                    'total_ventas': response.data[0].totalventa,
                    'total_descuentos': response.data[0].totaldescuentos,
                    'total_ventas_neta': response.data[0].totalventaneta,
                    'total_impuestos': response.data[0].totalimpuesto,
                    'total_comprobante': response.data[0].totalcomprobante,
                    'otros': 'Muchas gracias',
                    'detalles': response.data[0].descripcion_detalle,
                    'password': response.data[0].password_email,
                    'tipoComprobante': "tiquete"
                  }
            }

          console.log("Objeto de tiquete ObjXMLTiquete", obj)
          let data={obj : obj[1]}
          return data;
    }

    let ObtenerXMLComprobante= function(ObjXML){
      return new Promise((resolve, reject) => {
        insertarFila(ObjXML, 'send_to_crlibre_for_xml').then(data => {
           resolve(data.data.resp.xml);
        })
        .catch(err => {
          reject(err);
        })
      })
    }

    let convertirBase64_A_Xml= function(xml){

      return new Promise((resolve, reject)=>{

        if(xml == '' || typeof xml === 'undefined'){
          const err = new Error('xml vacío');
          reject(err);
        }else{
            if(window.DOMParser){
                parser= new DOMParser();
                xmlDoc= parser.parseFromString(atob(xml),"text/xml");

            }else{

                xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
                xmlDoc.async=false;
                xmlDoc.loadXML(atob(xml));
            }
            resolve(xmlDoc);
          }
      })
    }

    let loginAPI = function(){

      return new Promise((resolve,reject)=> {

        let username='';
        let password='';
        let obj={};
        getLinea({},'/emisor/username_password').then(data => {

          if(data.data.length > 0){

            username= data.data[0].usernameapi;
            pwd= data.data[0].passwordapi
            obj={
                  '1':{
                        'w': 'users', //ToDo Deprecate w in client side
                        'r': 'users_log_me_in', //ToDo Deprecate r in client side
                        'username': username,
                        'pwd': pwd
                      }
                }
            //insertPromise($scope, $http, $log, '/login', obj[1], false).then(response => {
            insertarFila(obj[1], '/login', false).then(response => {
              if (response.data.resp.sessionKey !== 'undefined' && response.data.resp.userName !== 'undefined') {
                sessionKeyGlobal = response.data.resp.sessionKey
                userNameAPIGlobal = response.data.resp.userName
                if (DEBUG) {
                  console.log("sessionKey: ", sessionKeyGlobal)
                }
                resolve({sessionKeyGlobal, userNameAPIGlobal});
              } else {
                console.error("insertPromise FAILED with: ")
                console.error(obj[1])
                throw new Error("Error en la peticion a la API");
              }

            /*
              insertarFila(obj[1],'/login').then( resp =>{
              let sessionKey='';
              let user='';
              if(typeof sessionKeyGlobal !== "undefined" && userNameAPIGlobal !== 'undefined'){
                sessionKey= resp.data.resp.sessionKey;
                sessionKeyGlobal = resp.data.resp.sessionKey;
                console.log("resp.data.resp.sessionKey");
                console.log(resp.data.resp.sessionKey);
                user= resp.data.resp.userName;
                resolve({sessionKey,user});
              }else{
                throw new Error("Error en la peticion a la API");
              }
              */

            })
            .catch(err => {
              reject(err);
            })
          }else{
            throw new Error("No se pudo obtener la informacion para la autenticación de la API");
          }
        })
        .catch(err => {
          reject(err);
        })
      })
    }

    let subirCertificado = function(sessionKey, username){
        // ToDo we should not use this function
        // DownloadCode is constant. We dont need to keep in client side
        // Deprecate
        return new Promise((resolve, reject)=>{

          let downloadCode='';
          let json={
            '1':{
                 //'w': 'fileUploader',
                 //'r': 'subir_certif',
                 'sessionKey': sessionKey,
                 'iam': username
            }
          }

          insertarFila(json[1], '/upload_certificado').then( dataCertificado => {
            if(typeof dataCertificado.data.resp.downloadCode !== "undefined"){
              downloadCode= dataCertificado.data.resp.downloadCode
              resolve(downloadCode);
            }else{
              throw new Error("Ha ocurrido un error al subir el certificado");
            }
          })
          .catch(err => {
            reject(err);
          })
      })
    }

    let firmarXML= function(xml,downloadCode){
      // ToDo Deprecate
      // Download Code should not be in client side
      // Use firmarXMLServerSide
      return new Promise((resolve, reject) =>{
        let data_firma= {
              '1':{
                    'w': 'firmarXML',
                    'r': 'signFE',
                    'p12Url': downloadCode,
                    'inXml': xml,
                    'tipodoc': 'FE'

                    }
                }

          insertarFila(data_firma[1], '/firma_electronica').then(data => {
            console.log("xml ",data)
            if(typeof data.data.resp.xmlFirmado !== "undefined"){
              resolve(data.data.resp.xmlFirmado);
            }else{

              throw new Error("Ha ocurrido un error al obtener el xml firmado");
            }
          })
          .catch(err => {
            reject(err);
          })
        })
    }

    let firmarXMLServerSide = function(xml,idfactura){

      return new Promise((resolve, reject) =>{
        let data_firma= {
              '1':{
                    'inXml': xml,
                    'tipodoc': 'FE',
                    'idfactura': idfactura
                    }
                }

          insertarFila(data_firma[1], '/firma_electronica/serverside').then(data => {
            console.log("xml ",data)
            if(typeof data.data.resp.xmlFirmado !== "undefined"){
              resolve(data.data.resp.xmlFirmado);
            }else{

              throw new Error("Ha ocurrido un error al obtener el xml firmado");
            }
          })
          .catch(err => {
            reject(err);
          })
        })
    }

    //firma_electronica_acuse_recibido
    let firmarXMLAcuseRecibido = function(obj){
      // ToDo Depreacte this function
      // Downloade code should not be in client side
      // Use firmarXMLAcuseRecibidoServerSide

      return new Promise((resolve, reject) =>{
        let data_firma= {
              '1':{
                    'w': 'signXML',
                    'r': 'signFE',
                    'p12Url': obj.downloadCode,
                    'inXml': obj.xml,
                    'tipodoc': 'FE',
                    'correo_emisor': obj.correo_emisor,
                    'correo_receptor': obj.correo_receptor,
                    'idfactura': obj.idfactura,
                    'password': obj.password,
                    'nombreinstitucion': obj.nombreinstitucion,
                    'clave': obj.clave,
                    'client_id': obj.client_id,
                    'nombre_receptor': obj.receptor,
                    'xml_comprobante': obj.xml_comprobante
                    }
                }

          insertarFila(data_firma[1], '/firma_electronica_acuse_recibido').then(data => {
            console.log("xml ",data)
            if(typeof data.data.resp.xmlFirmado !== "undefined"){
              resolve(data.data.resp.xmlFirmado);
            }else{

              throw new Error("Ha ocurrido un error al obtener el xml firmado");
            }
          })
          .catch(err => {
            reject(err);
          })
        })
    }
    let firmarXMLAcuseRecibidoServerSide = function(obj){

      return new Promise((resolve, reject) =>{
        let data_firma= {
              '1':{
                    'w': 'signXML',
                    'r': 'signFE',
                    'inXml': obj.xml,
                    'tipodoc': 'FE',
                    'correo_emisor': obj.correo_emisor,
                    'correo_receptor': obj.correo_receptor,
                    'idfactura': obj.idfactura,
                    'password': obj.password,
                    'nombreinstitucion': obj.nombreinstitucion,
                    'clave': obj.clave,
                    'client_id': obj.client_id,
                    'nombre_receptor': obj.receptor,
                    'xml_comprobante': obj.xml_comprobante
                    }
                }

          insertarFila(data_firma[1], '/firma_electronica_acuse_recibido').then(data => {
            console.log("xml ",data)
            if(typeof data.data.resp.xmlFirmado !== "undefined"){
              resolve(data.data.resp.xmlFirmado);
            }else{

              throw new Error("Ha ocurrido un error al obtener el xml firmado");
            }
          })
          .catch(err => {
            reject(err);
          })
        })
    }

    let obtenerToken= function(client_id){

      return new Promise((resolve, reject) => {

       let token='';
       let options = {

            '1':{
              'r': 'gettoken',
              'w': 'token',
              'grant_type': 'password',
              'client_id': client_id
            }
          }

        insertarFila(options[1], '/token').then(tokenData => {
          if(typeof tokenData.data.resp.access_token !== "undefined"){
            token=tokenData.data.resp.access_token;
            resolve(token);
          }else{
            throw new Error("Ha ocurrido un error al obtener el token");
          }
        })
        .catch(err => {
          reject(err);
        })
      })
    }

    let enviarXMLHacienda= function(object,tipo){
      
      //const data = { data: obj};
      //console.log("data comprobante ", data);
      return new Promise((resolve, reject) => {
       // console.log("antes de ejecutar la peticion http")
       //const data = {id: 9} 
        let datacomprobante={};
          if(tipo == 'FE'){
          datacomprobante={    
            
              'token': object.token,
              'clave': object.clave,
              'fecha': object.fecha,
              'emi_tipoIdentificacion': object.emi_tipoIdentificacion,
              'emi_numeroIdentificacion': object.emi_numeroIdentificacion,
              'recp_tipoIdentificacion': object.recp_tipoIdentificacion,
              'recp_numeroIdentificacion': object.recp_numeroIdentificacion,
            // 'comprobanteXml': object.xml_firmado,
              'client_id': object.client_id,
              'correo_emisor': object.correo_emisor,
              'correo_receptor': object.correo_receptor,
              'nombre_receptor': object.nombre_receptor,
              'nombreinstitucion': object.nombreinstitucion,
              'password': object.password,
              'idcomprobante': object.idfactura
          } 
        }
        else{
          datacomprobante={    
            
            'token': object.token,
            'clave': object.clave,
            'fecha': object.fecha,
            'emi_tipoIdentificacion': object.emi_tipoIdentificacion,
            'emi_numeroIdentificacion': object.emi_numeroIdentificacion,
            'client_id': object.client_id,
            'correo_emisor': object.correo_emisor,
            'correo_receptor': object.correo_receptor,
            'nombre_receptor': object.nombre_receptor,
            'nombreinstitucion': object.nombreinstitucion,
            'password': object.password,
            'idcomprobante': object.idfactura
          } 
        }
      console.log("Informacion de factura ",datacomprobante)
       insertarFila(datacomprobante,'/factura/comprobante/enviar').then(data => {
          console.log(data);
            resolve(data)
        })
        .catch(err =>{
          reject(err);
        })
      })
    }

     let obtenerInformacionDeXml = async function(object, tipodoc, idfactura){
      let data=  new Promise((resolve,reject)=> {
        
        let data_hacienda={};
        let w='';
        let r='';
        if(tipodoc == "FE"){

          w='send';
          r='json';

          data_hacienda={

                '1':{
                  'w': w,
                  'r': r,
                  'token': object.token,
                  'clave': object.clave,
                  'fecha': object.fecha,
                  'emi_tipoIdentificacion': object.tipoEmisor,
                  'emi_numeroIdentificacion': object.numEmisor,
                  'recp_tipoIdentificacion': object.tipoReceptor,
                  'recp_numeroIdentificacion': object.numReceptor,
                  'comprobanteXml': object.xml_firmado,
                  'client_id': object.client_id,
                  'correo_emisor': object.correo_emisor,
                  'correo_receptor': object.correo_receptor,
                  'nombre_receptor': object.nombre_receptor,
                  'nombreinstitucion': object.nombreinstitucion,
                  'password': object.password,
                  'idfactura': idfactura

                }
              }

        }else if(tipodoc == "TE"){

          w='send';
          r='sendTE';

          data_hacienda={

              '1':{

                  'w': w,
                  'r': r,
                  'token': object.token,
                  'clave': object.clave,
                  'fecha': object.fecha,
                  'emi_tipoIdentificacion': object.tipoEmisor,
                  'emi_numeroIdentificacion': object.numEmisor,
                  'comprobanteXml': object.xml_firmado,
                  'client_id': object.client_id,
                  'correo_emisor': object.correo_emisor,
                  'correo_receptor': object.correo_receptor,
                  'idfactura': idfactura
              }
            }
          }

          return resolve(data_hacienda[1]);
        })


        let result = await data;

        return result;
     }

     let dataXML= function (xmlDoc, tipodoc){
         let data_hacienda={}

         if(tipodoc =="FE"){

            data_hacienda= {
                clave: xmlDoc.getElementsByTagName("Clave")[0].childNodes[0].nodeValue,
                fecha: xmlDoc.getElementsByTagName("FechaEmision")[0].childNodes[0].nodeValue,
                tipoEmisor: xmlDoc.getElementsByTagName("Emisor")[0].childNodes[3].childNodes[1].innerHTML,
                numEmisor: xmlDoc.getElementsByTagName("Emisor")[0].childNodes[3].childNodes[3].innerHTML,
                tipoReceptor: xmlDoc.getElementsByTagName("Receptor")[0].children[1].children[0].innerHTML,
                numerReceptor: xmlDoc.getElementsByTagName("Receptor")[0].children[1].children[1].innerHTML,
            }

        }else{

            data_hacienda= {
                clave: xmlDoc.getElementsByTagName("Clave")[0].childNodes[0].nodeValue,
                fecha: xmlDoc.getElementsByTagName("FechaEmision")[0].childNodes[0].nodeValue,
                tipoEmisor: xmlDoc.getElementsByTagName("Emisor")[0].childNodes[3].childNodes[1].innerHTML,
                numEmisor: xmlDoc.getElementsByTagName("Emisor")[0].childNodes[3].childNodes[3].innerHTML,
            }
        }
        return data_hacienda;
     }


   let acuseDeComprobanteRecibido= (clavenumerica, token, client_id,idfactura, tipoComprobante,correoEmisor, correoReceptor) => {

     return new Promise((resolve, reject) => {


         let obj={

              clave: clavenumerica,
              token,
              client_id,
              idfactura,
              tipo: tipoComprobante,
              correoEmisor, 
              correoReceptor
          }
      
          console.log("Objeto a enviar ", obj);
          insertarFila(obj,'/factura/acuse/generar/').then(data=> {
            console.log("data ", data);
            if(data.data.status === "ok"){
              alert("Documentos de comprobante enviados vía correo electrónico");
              resolve(data.data);

            }else

              throw new Error("La respuesta de la peticion para el acuse del comprobante es indefinida");

           }).catch(err => {
              reject(err);
           })

      })
   }

  let firmaComprobante_con_Acuse = function(obj){

    return new Promise((resolve, reject) => {


        //firmarXMLAcuseRecibido(obj).then(xmlFirmado => {  // Deprecate
          firmarXMLAcuseRecibidoServerSide(obj).then(xmlFirmado => {

          console.log(xmlFirmado);
        })
        .catch(err => {

          reject(err)
        })
    })
  }

  $scope.cargarDescripcionNaturalezaDescuento=function(descripcion){

      console.log("Descripcion ",descripcion.descripcion)
      $("#descripcionNaturaleza").val(descripcion.descripcion)

      console.log($("#descripcionNaturaleza").val())
  }


  //----------------------------

  $http({
    method: 'GET',
    url: '/location/provincia'
  }).then(function (response) {
    $scope.provincias = response.data
  }, function errorCallback (response) {
    $log.error(response)
  }).catch(function (error) {
    $log.error(error)
  })




  $http({
    method: 'GET',
    url: '/emisor_tipo_identificacion'
  }).then(function (response) {

    $("#emisor_numero").val(response.data[0].emisor_numero);
        $("#casamatriz").val(response.data[0].casamatriz);
                $("#puntoventa").val(response.data[0].puntoventa);
    console.log(response.data[0]);

      if(response.data[0].emisor_tipo_identificacion == "01" || response.data[0].emisor_tipo_identificacion == "02"){
       $("#emisor").val("");

     console.log( $("#emisor").val())
     }else{
       $("#emisor").val(0);
       console.log( $("#emisor").val())
     }
  }, function errorCallback (response) {
    $log.error(response)
  }).catch(function (error) {
    $log.error(error)
  })



  //---------------------------------------------------


    $scope.validateId = function (receptor) {
    var contador=0;
    var id = String($('.identificacion_numero').val())
    var tipoId = String($("#tipo_id").val())
    if (tipoId === '01') {
      if (id.length != 9) {
        contador++;
        if(contador == 1){
          if(document.getElementById("mensaje").innerHTML == ""){
            document.getElementById("mensaje").innerHTML="Debe contener 9 dígitos";
        }
        return false;
       }
      }else{
        return true;
      }
    }
     if (tipoId === '02' || tipoId === '04') {

      if (id.length != 10) {
         if(document.getElementById("mensaje").innerHTML == ""){

          document.getElementById("mensaje").innerHTML="Debe contener 10 dígitos";
          }
        return false;
      }else{
        return true
      }
    }

   if(tipoId === '03'){
    if (id.length < 11) {
        if(document.getElementById("mensaje").innerHTML == ""){
          document.getElementById("mensaje").innerHTML="Debe contener un mínimo de 11 dígitos";
        }
        return false;
      }else{

        return true;
      }
    }
  }


    $("#insert-proveedor-modal").on('hidden.bs.modal', function () {
            limpiarFormReceptor();
    });

    $('#cancelarReceptor').click(function(){
      console.log("modal cerrado")
    })


  //----------------------------------------------------

  $scope.rcpClicked = function (rcpt) {
    $scope.receptorSelected='';
    for (var i = 0; i < $scope.receptor.length; i++) {
      $scope.receptor[i].checked = false
    }
     rcpt.checked=true
     $scope.receptorSelected=rcpt.idreceptor;

  }

  $scope.asignarCliente = function () {
    var estado = false
    for (var i = 0; i < $scope.receptor.length; i++) {
      if ($scope.receptor[i].checked) {
        $('#cliente_receptor').html($scope.receptor[i].nombre)
        hideModal('#choose-proveedor-modal')
        $("#receptor").val($scope.receptor[i].receptor_numero)
        $("#idreceptor").val($scope.receptor[i].idreceptor)
        alert("Se ha cargado el cliente: "+$scope.receptor[i].nombre);
        estado = true
      }
    }
    if (!estado) {
      alert('Debe seleccionar un cliente')
    }
  }

  $scope.receptorUpdate = function (receptorUpdate) {
    console.log("receptorUpdate", receptorUpdate)
    var combo = $('#tipo_id').val()
    var provincia = $('#id_provincia').val()
    var canton = $('#id_canton').val()
    var distrito = $('#id_distrito').val()

    if ($('#nombre').val() === '' || combo === null || $('.identificacion_numero').val() === '' || $('#email').val() === '' || provincia === '' || canton === '' || distrito === '') {
      alert('Debe llenar los campos requeridos')
    }else{
      if($scope.validateId(receptorUpdate)) {
        console.log(receptorUpdate.ubicacion_canton)
        validateAlphanumeric()
        validateNumbers()
        var identificacion_tipo_numero= String($("#txt_num_tipoIdentificacion").val()+$('.identificacion_numero').val());
        var nuevo_receptor_numero='';

        if(identificacion_tipo_numero.length > 12){
          nuevo_receptor_numero=identificacion_tipo_numero.substring(1,identificacion_tipo_numero.length);
          console.log(nuevo_receptor_numero)
        }else{
          nuevo_receptor_numero=identificacion_tipo_numero;
          console.log(nuevo_receptor_numero)
        }

        let nombrecomercial='';
        let codigo_pais='';
        let num_telefono='';
        let fax_codigopais='';
        let fax_num_telefono='';
        let otras_senas='';
        let new_canton='';
        let new_distrito='';

        if($("#nombreComercial").val() == "") nombrecomercial=''; else nombrecomercial=$("#nombreComercial").val();
        if($("#cod_telefono").val() == "") codigo_pais=0; else codigo_pais=$("#cod_telefono").val();
        if($("#telefono_numero").val() == "") num_telefono=0; else num_telefono=$("#telefono_numero").val();
        if($("#fax_codigoPais").val() == "") fax_codigopais=0; else fax_codigopais=$("#fax_codigoPais").val();
        if($("#fax_numero").val() == "") fax_num_telefono=0; else fax_num_telefono=$("#fax_numero").val();
        if($("#otras_senas").val() == "") otras_senas=''; else otras_senas=$("#otras_senas").val();

        if(receptorUpdate.ubicacion_canton.codigo_canton < 10) new_canton = '0'+String(receptorUpdate.ubicacion_canton.codigo_canton); else new_canton= receptorUpdate.ubicacion_canton.codigo_canton;
        if(receptorUpdate.ubicacion_distrito.codigo_distrito < 10 ) new_distrito = '0'+String(receptorUpdate.ubicacion_distrito.codigo_distrito); else new_distrito= receptorUpdate.ubicacion_distrito.codigo_distrito;
        console.log("nuevo canton ", new_canton)
        console.log("nuevo distrito ", new_distrito)
        var cadena3 = String(receptorUpdate.identificacion_tipo.id)
        var data = {
          nombre: receptorUpdate.nombre,
          receptor_tipo_identificacion: cadena3,
          nombrecomercial: nombrecomercial,
          provincia: Number(receptorUpdate.ubicacion_provincia.codigo_provincia),
          canton: new_canton,
          distrito: new_distrito,
          otras_senas: otras_senas,
          receptor_telefono_codigopais: codigo_pais,
          receptor_telefono_numtelefono: num_telefono,
          receptor_fax_codigopais: fax_codigopais,
          receptor_fax_numtelefono: fax_num_telefono,
          correoelectronico: receptorUpdate.correoelectronico,
          receptor_numero: nuevo_receptor_numero
        }

        console.log(data);
        insertPromise($scope, $http, $log, '/receiver/create', data)

        hideModal('#insert-proveedor-modal')
        limpiarFormReceptor()
        var ultimoId=Number($("#ultimoIdRcecptor").val())+1;
        $("#ultimoIdRcecptor").val(ultimoId)
        console.log("ultimo id ",$("#ultimoIdRcecptor").val())

        var nuevo_receptor= String(receptorUpdate.identificacion_numero);
        console.log("nuevo receptor", nuevo_receptor)
        $scope.receptor.push({
          idreceptor: $("#ultimoIdRcecptor").val(),
          nombre: receptorUpdate.nombre,
          receptor_tipo_identificacion: cadena3,
          receptor_numero: nuevo_receptor,
          nombrecomercial: receptorUpdate.nombrecomercial,
          provincia: Number(receptorUpdate.ubicacion_provincia.codigo_provincia),
          canton: Number(receptorUpdate.ubicacion_canton.codigo_canton),
          distrito: Number(receptorUpdate.ubicacion_distrito.codigo_distrito),
          otras_senas: receptorUpdate.ubicacion_otras_senas,
          receptor_telefono_codigopais: receptorUpdate.codigo_pais,
          receptor_telefono_numtelefono: receptorUpdate.telefono_numero,
          receptor_fax_codigopais: receptorUpdate.fax_codigopais,
          receptor_fax_numtelefono: receptorUpdate.fax_numero,
          correoelectronico: receptorUpdate.correoelectronico
        })
        console.log("receptores ",$scope.receptor)
        alert('Receptor insertado correctamente')
      }else{
          alert("Hay información con errores");
      }
    }
  }


  $scope.cargarId = function (receptor) {
    $('.identificacion_numero').val('')
    if (receptor.identificacion_tipo.id === '01') {
      $('#txt_num_tipoIdentificacion').val('000')
      document.getElementById("mensaje").innerHTML='';
    } else if (receptor.identificacion_tipo.id === '02') {
      $('#txt_num_tipoIdentificacion').val('00')
            document.getElementById("mensaje").innerHTML='';
    } else if (receptor.identificacion_tipo.id === '03') {
      $('#txt_num_tipoIdentificacion').val('0')
            document.getElementById("mensaje").innerHTML='';
    } else {
      $('#txt_num_tipoIdentificacion').val('00')
            document.getElementById("mensaje").innerHTML='';
    }
  }

  $scope.cargarCanton = function (receptor) {
    var data = {codigo_provincia: receptor.ubicacion_provincia.codigo_provincia}
    $http({
      method: 'GET',
      url: '/location/canton',
      params: data
    }).then(function (response) {
      $scope.cantones = response.data
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.cargarDistrito = function (receptor) {
    var data = {
      codigo_provincia: receptor.ubicacion_provincia.codigo_provincia,
      codigo_canton:   receptor.ubicacion_canton.id
    }

    console.log(data);
    $http({
      method: 'GET',
      url: '/location/distrito',
      params: data
    }).then(function (response) {
      $scope.distritos = response.data
      console.log($scope.distritos)
    }).catch(function (error) {
      $log.error(error)
    })
  }

  function truncate (value) {
    if (value < 0) {
      return Math.ceil(value)
    }
    return Math.floor(value)
  }

  $scope.nuevoPeriodoVenta = function () {
    var dataEmpleado = {
      idEmpleado: $scope.idEmpleado,
      idPeriodo: $scope.idPeriodoVenta
    }

    $http({
      method: 'GET',
      url: '/getInfoPeriodoCierre',
      params: dataEmpleado
    }).then(function (response) {
      // resolve(response.data)
      $log.info(response.data)
      var ventaTotal = truncate(response.data[0].ventatotal)
      var dataPeriodo = {
        idPeriodo: $scope.idPeriodoVenta,
        nombrePeriodo: $scope.nombrePeriodo.trim(),
        nombreEmpleado: response.data[0].nombreempleado,
        ventaTotal: ventaTotal
      }
      $log.info(dataPeriodo)
      $http({
        method: 'GET',
        url: '/execution',
        params: dataPeriodo,
        responseType: 'arraybuffer'
      }).then(function (file) {
        $log.info(file)
      }).catch(function (error) {
        $log.error(error)
      })
    }, function errorCallback (response) {
      $log.error(response)
    }).catch(function (error) {
      $log.error(error)
    })

    var nombreNuevoPeriodo = $('#txtNombrePeriodo').val()
    if (nombreNuevoPeriodo !== '') {
      var data = {
        nombrePeriodo: nombreNuevoPeriodo,
        idEmpleado: $scope.idEmpleado
      }
      insertPromise($scope, $http, $log, '/create_periodo_venta', data).then(function () {
        $scope.refresh()
      }).catch(function (error) {
        $log.error(error)
      })
    } else {
      alert('Por favor, registre el nombre del nuevo período de venta, antes de finalizar el actual')
    }
  }

  $scope.sortRestaurantAddOrder = function (keyname) {
    $scope.sortKey = keyname // set the sortKey to the param passed
    $scope.reverse = !$scope.reverse // if true make it false and vice versa
  }

  $scope.sortReceiver = function (keyname) {
    $scope.sortKeyR = keyname // set the sortKey to the param passed
    $scope.reverseR = !$scope.reverseR // if true make it false and vice versa
  }

  $scope.sortRestaurantPendinOrder = function (keyname) {
    $scope.sortKey = keyname // set the sortKey to the param passed
    $scope.reverse = !$scope.reverse // if true make it false and vice versa
  }

  $scope.clearfunction = function () { $scope.searchProduct = '' }

  // getClientAccounts()
  // Cargar cuentas de clientes, no aplica para SOPA BAR
  /* function getClientAccounts() {
    // var return_value = '';
    $http({
      method: 'GET',
      url: '/api/client/account'
    }).then(function (response) {
      // $log.info(response)
      $scope.cuentas = response.data
      return response.data // this return does not work
    })
  } */

  function getUserId () {
    $scope.periodoVenta = serviceRestaurant.getperiodo()
    $http({
      method: 'GET',
      url: '/userId'
    }).then(function (response) {
      $scope.userId = response.data.userId
      switch ($scope.userId) {
        case 'admin1':
          $scope.idEmpleado = 1
          scopeidEmpleado = '1'
          break
        case 'cajero1':
          $scope.idEmpleado = 3
          scopeidEmpleado = '3'
          break
        case 'cajero2':
          $scope.idEmpleado = 2
          scopeidEmpleado = '2'
          break
        case 'user1':
          $scope.idEmpleado = 3
          scopeidEmpleado = '3'
          break
        default:
          $scope.idEmpleado = 3
          scopeidEmpleado = '3'
          break
      }
      serviceRestaurant.setidEmpleado($scope.idEmpleado)
      return response.data.userId // this return does not work
    }).catch(function (error) {
      $log.error(error)
    })
  }

  // Function to clear productschecked
  $scope.clear_submit = function () {
    $scope.searchProduct = ''
    // console.dir($scope.object)
    angular.forEach($scope.object, function (product_id) {
      product_id.selected = false
    })
    var data = {}
    $scope.obj = []
    loadData($scope, $http, $log, '/api/product', data)
  }

  $scope.productSorter = function (a, b) {
    if (a.month < b.month) return -1
    if (a.month > b.month) return 1
    return 0
  }

  //console.log(listaDetalles);

  // costo unitario es el valor que le cuesta a la empresa comprar o hacer el producto y el precio es el valor de la venta

  $scope.createOrder = function () {
    $scope.idCuenta = serviceRestaurant.getidCuenta()
    if (typeof $scope.idCuenta === 'undefined' || $scope.idCuenta === '-1') {
      alert('Por favor seleccione una Cuenta')
      $window.location.href = '/sopa#!/restaurante'
    } else {
      $scope.obj = []
      return orderList_promise($scope.obj, $scope.object).then(function (orderlist_array) {
        if (orderlist_array.length > 0 && typeof orderlist_array !== 'undefined') {

          console.log("ordenes array ",orderlist_array)
          // alerta_stockSeguridad(orderlist_array) // Commenting this line to avoid alert of sinStock
          $scope.obj = {}
          for (var i = 0; i < orderlist_array.length; i++) {
            $scope.obj[i] = orderlist_array[i]
          }
          console.log();
          $scope.elements = orderlist_array
          var formData = JSON.stringify($scope.obj)
          myService.set(formData)
          addNewOrder($scope.obj)
          //AddnewOrders(lista_nuevos_detalles);
         // var iddetalle=$("#get_id_Orden").val();
        //$("#get_id_Orden").val(iddetalle+1);
         // $scope.clear_submit()

        } else {
          alert('Por favor seleccione el producto y la cantidad para agregar')
          $log.error('orderlist is empty: ' + orderlist_array)
        }
      }).catch(function (error) {
        $log.error(error)
      })
    }
  }

  function promiseAlertaStock (idProducto) {
    return new Promise(function (resolve, reject) {
      setTimeout(function () {
        data = { 'idproducto': idProducto }
        $http({
          method: 'GET',
          url: '/api/product/inventario/stock',
          params: data
        }).then(function (response) {
          resolve(response.data)
        }, function errorCallback (response) {
          $log.error(response)
        }).catch(function (error) {
          $log.error(error)
        })
      })
    })
  }

  function estaSinStock (idInventario, reducir) {
    for (var i = 0; i < $scope.inventario_SinStock.length; i++) {
      if ($scope.inventario_SinStock[i][0].idinventario === idInventario) {
        $scope.inventario_SinStock[i][0].disponible = $scope.inventario_SinStock[i][0].disponible - reducir
        if ($scope.inventario_SinStock[i][0].disponible < 0) { $scope.inventario_SinStock[i][0].disponible = 0 }
        return true
      }
    }
    return false
  }

  function promiseSinStock (inventorylist) {
    var sinStock = []
    return new Promise(function (resolve, reject) {
      setTimeout(function () {
        var disponible = inventorylist.disponible - inventorylist.necesaria * inventorylist.vendida
        var minima = inventorylist.minima
        if (disponible < minima) {
          if (!estaSinStock(inventorylist.idinventario, inventorylist.necesaria * inventorylist.vendida)) {
            inventorylist.disponible = disponible
            sinStock.push(inventorylist)
          }
        }
        resolve(sinStock)
      })
    })
  }

  function alerta_stockSeguridad (orderlist_array) {
    var p = []
    var c = []
    var productlist = []
    for (var j = 0; j < orderlist_array.length; j++) {
      p.push(orderlist_array[j].idproducto)
      c.push(orderlist_array[j].cantidad)
    }
    p.reduce(function (sequence, value) {
      return sequence.then(function () {
        return promiseAlertaStock(value)
      }).then(function (obj) {
        productlist.push(obj)
      })
    }, Promise.resolve()).then(function () {
      $scope.inventario_SinStock = []
      for (var i = 0; i < c.length; i++) {
        var inventorylist = productlist[i]
        for (var inv = 0; inv < inventorylist.length; inv++) {
          inventorylist[inv].vendida = c[i]
        }
        inventorylist.reduce(function (sequence, value) {
          return sequence.then(function () {
            return promiseSinStock(value)
          }).then(function (obj) {
            if (obj.length > 0) {
              $scope.inventario_SinStock.push(obj)
            }
          })
        }, Promise.resolve()).then(function () {
          if ($scope.inventario_SinStock.length > 0) {
            $('#producto-sinStock-modal').modal('show')
          }
        })
      }
      if ($scope.inventario_SinStock.length > 0) {
        $('#producto-sinStock-modal').modal('show')
      }
    })
  }

  function orderList_promise (orderlist_array, scope_object) {
    // scope_object trae todos los productos de la base de datos
    // orderList_array es un arreglo donde se van a obtener los productos que se van a cargar para vender en una orden
    return new Promise(function (resolve, reject) {
      for (var i = 0; i < scope_object.length; i++) {
        if (scope_object[i].checked === true) {
          if (typeof scope_object[i].cantidad === 'undefined' || scope_object[i].cantidad === 0) {
            alert('No se selecciono la cantidad del producto: ' + scope_object[i].descripcionproducto)
            reject('Cantidad null para: ' + scope_object[i].descripcionProducto)
          } else {
            console.log(scope_object[i]);
            orderlist_array.push(angular.extend({}, scope_object[i]))
          }
        }
      }
      resolve(orderlist_array)
    })
  }

  $scope.increment = function (product) {
    if (typeof product.cantidad === 'undefined') {
      product.cantidad = 1
    } else {
      product.cantidad++
    }
  }

  $scope.decrement = function (product) {
    if (typeof product.cantidad === 'undefined') {
      product.cantidad = 1
    } else {
      product.cantidad--
    }
  }

  function addNewOrder (obj) {
    if (!$scope.my_idCuenta) {
      alert('Por favor elija una cuenta')
      return false
    } else {
      var now = new Date().toJSON().replace('T', ' ').slice(0, -5)
      var data = {
        'idCuenta': $scope.my_idCuenta,
        'fechaRegistro': now,
        'objects': obj,
        'iddetalle': $("#get_id_Orden").val()
      }

      console.log(data);
      insertPromise($scope, $http, $log, '/order_insert', data)


      // insert($scope, $http, $log, '/commanda', data)
      $scope.refresh()
    }
  }

  function AddnewOrders(array){
    data={ detalles: array }
      insert($scope, $http, $log, '/insert_details', data)
  }

  function getOrdersPerAccount ($scope, $http, $log, route, data) {
    $http({
      method: 'GET',
      url: route,
      params: data
    }).then(function (response) {
      $scope.orders = response.data
      console.log("ordenes",$scope.orders)
      for (var i = 0; i < $scope.orders.length; i++) {
        $scope.orders[i].checked = true

      }
      // $log.debug(response)
      return response.data
    }).catch(function (error) {
      $log.error(error)
    })
  }

  // Cargar ordenes de cuentas, no aplica para SOPA BAR
  /* $scope.orders_reload = function (idCuenta, nombreCliente, apellidoCliente, totalPagar) {
    var data = {
      idCuenta: idCuenta
    }
    $scope.my_idCuenta = idCuenta;
    $scope.my_nombreCliente = nombreCliente.concat(' ')
    $scope.my_nombreCliente = $scope.my_nombreCliente.concat(apellidoCliente)
    serviceRestaurant.setidCuenta($scope.my_idCuenta)
    var orders = getOrdersPerAccount($scope, $http, $log, '/api/client/orders', data)
    $scope.pendienteTotal = totalPagar;
    $scope.selectedRow = null
    $scope.selectedRow = idCuenta;
    $scope.refresh()
  } */

  function ordersPending () { getOrdersPerAccount($scope, $http, $log, '/api/orders/pending', {}) }

  function totalPagarPerIdCuenta (idCuenta) {
    if (typeof idCuenta !== 'undefined') {
      data = {idCuenta: idCuenta}
      $http({
        method: 'GET',
        url: '/pendingTotal',
        params: data
      }).then(function (response) {
        var pendingResponse = response.data[0].cuenta
        if (pendingResponse === null) {
          pendingResponse = 0
        }
        $scope.pendienteTotal = pendingResponse
        $scope.total=$scope.pendienteTotal
      }).catch(function (error) {
        $log.error(error)
      })
    } else {
      $scope.pedienteTotal = $scope.pendienteTotal + '++'
    }
  }

  $scope.sendDataDeleteOrder = function () {
    $scope.deleteOrders = []
    for (var i = 0; i < $scope.orders.length; i++) {
      if ($scope.orders[i].checked === true) {
        $scope.deleteOrders.push({
          'idorden': $scope.orders[i].idorden,
          'producto': $scope.orders[i].producto,
          'cantidad': $scope.orders[i].cantidad
        })
      }
    }
  }

  $scope.deleteOrden = function () {
    for (var i = 0; i < $scope.deleteOrders.length; i++) {
      var data = { id: $scope.deleteOrders[i].idorden }
      insertPromise($scope, $http, $log, '/delete_order', data)
    }
    for (var i = 0; i < $scope.orders.length; i++) {
      if ($scope.orders[i].checked==true)
          $scope.orders[i]=[];
    }

    $scope.pendienteTotal=0;
   // $scope.refresh()
  }

//----------------------------------------------------------------------

$scope.cargarDescripcionDescuento = (elemento, descripcion) =>{
  elemento.naturalezadescuento = descripcion;
  console.log(elemento)
}

$scope.cargarDescuento = ( descuento, obj, tipo)=>{

  // esta funcion obtiene el descuento y el objeto de descuento para obtener el monto de descuento
  // y restarlo al precio de la orden y mostrarlo en la orden actual
  //tipo es un parametro que se envia para saber que tipo de naturaleza de descuento va tener
  // si el parametro es otros entonces quiere decir que se esta oprimiendo uno de los
  // 3 botones que asignan un descuento y su naturaleza de descuento va ser otros, sino entonces
  // quiere decir que el descuento viene de algun select y su naturaleza de descuento va ser la que tare 
  // la opcion seleccionada del select
  let descuentoOrden;
  if(descuento == 0){
    descuentoOrden = obj.descuento;

  }else{
    descuentoOrden= descuento;
  }
   obj.descuento= descuentoOrden;
   let newDescuento = descuento / 100;
   newDescuento = newDescuento * parseFloat(obj.subtotal);

    obj.descuentoColones=newDescuento;

   let total = parseFloat(obj.subtotal);
   
   obj.total = total - newDescuento;
    if(tipo === 'otros'){
      let select_descuento = document.getElementsByClassName("listaSelectsDescuentos");
     
      for(let i=0; i < select_descuento.length; i++){
        if(obj.idorden == select_descuento[i].getAttribute("id")){
           const options= select_descuento[i].options;
           for(let b=0; b < options.length; b++){
             if(options[b].innerText == "Otros")
              select_descuento[i].options[b].selected = true;
           }
        } 
      }
    }else{
      return;
    }
 }

 $scope.limpiarDescuennto = (obj) =>{ // esta funcion limpia el descuento aplicado y muestra el precio sin descuento
  // resetea los totales de las ordenes
   obj.descuento=0;
   $scope.cargarDescuento(0,obj);
}
let abrirModal = () =>{
  //$("#aplicar-descuentos-modal").modal("show");
  return new Promise((resolve, reject)=>{
    if($('#aplicar-descuentos-modal').data('bs.modal').isShown == true){

        resolve(true);
    }else{
      reject(false);
    }
  })
 }
 
$scope.sendDataDiscountOrder = function () {

// #aplicar-descuentos-modal

    $scope.discountOrders = [];
    
    for (var i = 0; i < $scope.orders.length; i++) {
      if ($scope.orders[i].checked === true) {
        $scope.discountOrders.push({
          'idorden': $scope.orders[i].idorden,
          'producto': $scope.orders[i].producto,
          'cantidad': $scope.orders[i].cantidad,
          'descuento': parseFloat($scope.orders[i].descuentoorden),
          'subtotal' : parseFloat($scope.orders[i].total).toFixed(2),
          'descuentoColones': 0,
          "total": parseFloat($scope.orders[i].total).toFixed(2),
          "naturalezadescuento": $scope.orders[i].naturalezadescuento
        })
      }  
    }
    $scope.discountOrders.forEach((orden,i) => { // las ordenes se van a cargar y actualizar los totales de orden en la pantalla
      // de descuentos al carga el modal
      $scope.cargarDescuento( orden.descuento, orden);
    }); 
}

 $scope.cargarDescuentos = function() {
    $http({
      method: 'GET',
      url: '/api/orders/pending',
      params: {}
    }).then(function (response) {
      $scope.orders = response.data
      for (var i = 0; i < $scope.orders.length; i++) {
        $scope.orders[i].checked = true  
      }
      
      $scope.sendDataDiscountOrder();
    }).catch(err => {
      console.error(err);
    })
}
$scope.descripcionDescuento = function (orden, descripcion) {  
  orden.naturalezadescuento=descripcion;

  console.log(orden);
}


//----------------------------------------------------------------------
  $scope.descuentoSeleccionado = function (orden, descuento) {
     console.log(orden.descuento)
     console.log(descuento)

     orden.descuento=descuento;
  }


  $scope.detallesOrden = function(orderlist_array) {

    let listaDetalles = {};
    let descuento = 0;
    let montototal = 0;
    let subTotal = 0;
    let impuesto = {};
    let descuentoorden = 0;
    let montototallinea = 0;
    let object = {};
    let index=0;
    let monto_impuesto = 0;
    let porcentaje='';
    let decimal='';
    let impuestoNeto=0;
    $scope.totalDescuento =0;

    for (let i = 0; i < orderlist_array.length; i++) {
      index=i+1;

        if (orderlist_array[i].descuentoorden === undefined || orderlist_array[i].descuentoorden == 0) {
            descuentoorden = 0;
        } else {
            descuentoorden = orderlist_array[i].descuentoorden;
        }

        montototal = Number(orderlist_array[i].subtotal);
        descuento = Number(orderlist_array[i].montodescuento);
        subTotal = Number(orderlist_array[i].total_orden);
        
        $scope.totalDescuento+=descuento;
        //Organizamos el Json
        object[index]={   
            'codigo'    : String(orderlist_array[i].codigoproducto),
            'codigoComercial' : {'tipo': String(orderlist_array[i].tipo_producto), 'codigo': String(orderlist_array[i].codigoproducto)},
            'cantidad'        : String(orderlist_array[i].cantidadproducto),
            'unidadMedida'    : String(orderlist_array[i].unidadmedida),
            'detalle'         : String(orderlist_array[i].descripcionproducto),
            'precioUnitario'  : String(orderlist_array[i].preciounitarioproducto),
            'montoTotal'      : String(montototal)
        }

        //Verifica si existe un descuento
        if(orderlist_array[i].descuentoorden > 0){
          object[index].descuento = [{'montoDescuento': String(descuento), 'naturalezaDescuento': String(orderlist_array[i].naturalezadescuento)}]
        }

        object[index].subtotal        = String(subTotal);

        //Se calcula el monto del impuesto en $
        

        //Si el impuesto que aplica es IVA o IVA cálculo especial
        if(orderlist_array[i].codigo_impuesto == "07" || orderlist_array[i].codigo_impuesto == "01"){

          //Si el impuesto tiene código 07, se declara la base impinible
          if(orderlist_array[i].codigo_impuesto == "07"){
            object[index].baseImponible = String(orderlist_array[i].preciounitarioproducto);
          }
          
          //se escribe el campo json
          object[index].impuesto = {
              '1': {
                'codigo': String(orderlist_array[i].codigo_impuesto),
                'codigoTarifa': String(orderlist_array[i].tipo_impuesto),
                'tarifa': String(orderlist_array[i].porcentajeimpuesto),
                'monto': ''
              }
            };
            if(Number(orderlist_array[i].porcentajeimpuesto) > 9){
              decimal = parseFloat(orderlist_array[i].porcentajeimpuesto).toFixed(0);
              porcentaje= '0.'+String(decimal);
              monto_impuesto= (parseFloat(object[index].subtotal) * parseFloat(porcentaje)).toFixed(2);
            }else{
              decimal = parseFloat(orderlist_array[i].porcentajeimpuesto).toFixed(0);
              porcentaje= '0.0'+String(decimal);
              monto_impuesto= (parseFloat(object[index].subtotal) * parseFloat(porcentaje)).toFixed(2);
            }
          
          object[index].impuesto[1].monto = String(monto_impuesto);
          montototallinea = (subTotal  + Number(object[index].impuesto[1].monto));
        }else{ //Si el impuesto que aplica no es ningún tipo de IVA

          //se escribe el campo json
          object[index].impuesto = {
              '1': {
                'codigo': String(orderlist_array[i].codigo_impuesto),
                'tarifa': String(orderlist_array[i].porcentajeimpuesto),
                'monto': ''
              }
            };

            if(Number(orderlist_array[i].porcentajeimpuesto) > 9){
              decimal = parseFloat(orderlist_array[i].porcentajeimpuesto).toFixed(0);
              porcentaje= '0.'+String(decimal);
              monto_impuesto= (parseFloat(object[index].subtotal) * parseFloat(porcentaje)).toFixed(2);
            }else{
              decimal = parseFloat(orderlist_array[i].porcentajeimpuesto).toFixed(0);
              porcentaje= '0.0'+String(decimal);
              monto_impuesto= (parseFloat(object[index].subtotal) * parseFloat(porcentaje)).toFixed(2);
            }


            object[index].impuesto[1].monto = String(monto_impuesto);
            montototallinea = (subTotal  + Number(object[index].impuesto[1].monto));
        }

        /*No se calcula todavía porque no están habilitadas las exnoeraciones en SOPA*/
        /*object['exoneracion'] = {
          'tipoDocumento': "",
          'numeroDocumento': "",
          'nombreInstitucion': "",
          'fechaEmision': "",
          'porcentajeExoneracion': "",
          'montoExoneracion': ""
        };*/
        impuestoNeto=(monto_impuesto - (monto_impuesto * porcentajeExoneracionGlobal).toFixed(2)).toFixed(2);
        object[index].impuestoNeto    = String(impuestoNeto);
        /*-----------------------------------------------------------------------------*/

        object[index].montoTotalLinea = String(montototallinea);

        //Agrega el array en formato JSON
        listaDetalles= object;
    }

    //para debug en consola
    console.log("detallesOrden:", listaDetalles);
    
    return listaDetalles;
  }

  $scope.saveDiscount = function () {
    let descuento=0;

    for (let i = 0; i < $scope.discountOrders.length; i++) {

      let data = {
        id: $scope.discountOrders[i].idorden,
        descuento: '',
        naturaleza: ''
      }

      if($scope.discountOrders[i].descuento > 0){

        //let select= document.getElementById("naturalezaDescuento");
       // let value= select.value;
        //naturalezadescuento= select.options[select.selectedIndex].innerText;
        
        data.descuento= $scope.discountOrders[i].descuentoColones;
        data.porcentajeDescuento= $scope.discountOrders[i].descuento;
        data.naturaleza= $scope.discountOrders[i].naturalezadescuento;
        data.total = $scope.discountOrders[i].total
        data.subtotal = $scope.discountOrders[i].subtotal 

      }else{
        
        data.descuento= 0;
        data.porcentajeDescuento= 0;
        data.naturaleza= '';
        data.total = $scope.discountOrders[i].total
        data.subtotal = $scope.discountOrders[i].subtotal

      }

      updatePromise($scope, $http, $log, '/update_discount', data)
      if(typeof ($scope.discountOrders[i].descuento) !== "undefined"){
       descuento+=Number($scope.discountOrders[i].descuento) * Number($scope.orders[i].total) /100;}
    }

    for (let i = 0; i < $scope.orders.length; i++) {
      $scope.orders[i].checked = true
      $scope.discountOrders[i].descuento= parseFloat($scope.orders[i].descuentoorden);
    }

    console.log($scope.discountOrders)

    console.log(descuento);
    $scope.pendienteTotal= $scope.total - descuento;


    //$scope.descuentoColones
    // var tot= Number($scope.orders[i].total) * Number($scope.orders[i].descuento) / 100

    //$scope.refresh()

    //detallesOrden( 
    //var naturalezadescuento =document.getElementById("naturalezaDescuento");
    //naturalezadescuento.selectedIndex=null;
  }

  $scope.sendDataSplitAccount = function () { $('#cantDivisiones').val($scope.cantidadPersonas) }

  $scope.cantidadDivisiones = function () { $scope.cantidadPersonas = $('#cantDivisiones').val() }

  $scope.imprimirFactura = function (bill) {
    if ($scope.porcentajeDescuento === '' || !$scope.porcentajeDescuento || $scope.porcentajeDescuento === undefined) {
      $scope.porcentajeDescuento = 0
    }

    var descuentoAplicado = $scope.totalPagar * $scope.porcentajeDescuento / 100

    var data = {
      idCuenta: $scope.idCuenta,
      // nombreCliente: $scope.nombreCliente,
      idFactura: $scope.idFactura,
      cantidad: $scope.cantidad,
      bill: bill,
      idEmpleado: scopeidEmpleado,
      descuento: descuentoAplicado,
      totalMenosDescuento: $scope.totalMenosDescuento,
      subtotal: $scope.totalPagar
    }
    insertPromise($scope, $http, $log, '/imprimirFactura', data).then(function (response) {
      $scope.refresh()
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.imprimirOrden = function (action) {
    console.log('action: ' + action)
    if (action === 'ok') {
      $scope.imprimirFactura($scope.elements)
    }
    $scope.refresh()
  }

  $scope.sendDataToPay = function (tipoPago) {
    $scope.tipoPago = tipoPago
    $scope.payOrders = []
    $scope.elements = []
    var sumaDescuento;
    // var elementsRequested = []
    $scope.totalPagar = 0
    $scope.descuentoColones = 0
    $scope.infoVenta=[];
    var descuento_=0;

     $http({
      method: 'GET',
      url: '/api/orders/pending',
      params: {}
    }).then(function (response) {
      $scope.orders = response.data
      console.log("ordenes ",$scope.orders)
      for (var i = 0; i < $scope.orders.length; i++) {
        $scope.orders[i].checked = true
      }
          for (var i = 0; i < $scope.orders.length; i++) {
      console.log("descuento por orden ", $scope.orders[i].descuentoorden);
      if ($scope.orders[i].checked === true) {
        console.log("total", $scope.orders[i].total);
        console.dir('descuento: ' +$scope.orders[i].descuentoorden)
        $scope.totalPagar += Number($scope.orders[i].total)
        $scope.descuentoColones += Number($scope.orders[i].total) * Number($scope.orders[i].descuentoorden) / 100
        console.log("descuentoColones ",$scope.descuentoColones);
        $scope.porcentajeDescuento = $scope.descuentoColones / $scope.totalPagar * 100
        console.log("porcentajeDescuento ",$scope.porcentajeDescuento);
        $scope.totalMenosDescuento = Number($scope.totalPagar) - Number($scope.descuentoColones)
        $scope.totalDividida = $scope.totalMenosDescuento / $scope.cantidadPersonas
        $scope.payOrders.push({
          'idorden': $scope.orders[i].idorden,
          'producto': $scope.orders[i].producto,
          'cantidad': $scope.orders[i].cantidad,
          'total': $scope.orders[i].total
        })
        $scope.elements.push({
          'descripcionproducto': $scope.orders[i].producto,
          'cantidadproducto': $scope.orders[i].cantidad,
          'subtotal': $scope.orders[i].total
        })
      }
    }
      return response.data
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.resetDataVenta= function(){
    $scope.totalPagar=0;
    $scope.descuentoColones=0;
    $scope.porcentajeDescuento=0;
    $scope.totalMenosDescuento=0;
    $scope.totalDividida=0;
  }

  $scope.camposOrden= function(orderlist_array){
    //console.log("llegó");
    let listaCampos = [];
    let ObjectOrder =[];
    let baseImponible = 0;
    let monto = 0;
    let data = {};
    let tarifa=0;
    for (var i = 0; i < orderlist_array.length; i++) {
      
      if(orderlist_array[i].codigo_impuesto == '07'){ // si el codigo de impuesto es 07 entonces hay una base imponible
        baseImponible = orderlist_array[i].preciounitarioproducto;
        monto = Number(orderlist_array[i].total_orden) *  Number(orderlist_array[i].porcentajeimpuesto) /100;
        ObjectOrder['baseImponible'] = baseImponible;
        tarifa = parseFloat(orderlist_array[i].porcentajeimpuesto);
      }{
        monto = Number(orderlist_array[i].total_orden) *  Number(orderlist_array[i].porcentajeimpuesto) /100;
        tarifa = parseFloat(orderlist_array[i].porcentajeimpuesto);
      }
    // CREO un array que me va cargar todos los datos que necesito
      ObjectOrder['idorden']= orderlist_array[i].idorden;
      ObjectOrder['costounitario']= orderlist_array[i].costounitario;
      ObjectOrder['numerolineadetalle']=i+1 ;
      ObjectOrder['codigoservicio']= orderlist_array[i].codigoproducto;
      ObjectOrder['tiposervicio']= orderlist_array[i].tipo_producto;
      ObjectOrder['unidadmedida']= orderlist_array[i].unidadmedida;
      ObjectOrder['unidadmedidacomercial']= orderlist_array[i].unidadmedidacomercial;
      ObjectOrder['detalle']=  orderlist_array[i].descripcionproducto;
      ObjectOrder['montototal']= orderlist_array[i].subtotal;
      ObjectOrder['subtotal']= orderlist_array[i].total_orden;
      ObjectOrder['codigoimpuesto']= String(orderlist_array[i].codigo_impuesto);
      ObjectOrder['tarifa']= tarifa;
      ObjectOrder['monto']= monto;
      ObjectOrder['montoimpuesto']= monto;
      ObjectOrder['montototallinea']= Number(orderlist_array[i].total_orden) + monto;
     
      //creo un objeto json y le asigno cada elemento del array por cada iteracion
      listaCampos.push(Object.assign({}, ObjectOrder));
      listaCampos[i] = Object.assign({}, listaCampos[i]);
      data = { // creo el objeto que voy a enviar al servidor
        orden :listaCampos[i]
      }
      updatePromise($scope, $http, $log, '/orden/actualizar', data) // envio elk objeto y hago la peticion
      // para que me actualice la orden
    }
  }

  $scope.camposFactura = async function(orderlist_array) {

    //console.log("orderlist_array en camposFactura", orderlist_array)

    let total_impuestos = 0;
    let tipocambio = 0;
    let xml = '';
    let tipo = '';
    let idfactura = '';
    let debug = true;
    let client_id = '';
    let objDataHacienda = {};
    let dataHacienda = {};

    if (debug) client_id = 'api-stag';
    else client_id = 'api-prod';

    //Sumatoria de impuestos
    for (var i = 0; i < orderlist_array.length; i++) {
      total_impuestos += parseFloat(orderlist_array[i].montoimpuesto)
      //console.log("total_impuestos ", total_impuestos)
    }

    tipocambio = Number($("#tipoCambio").val())

    //console.log("tipoComprobante ", $scope.tipoComprobanteId)

    if ($scope.tipoComprobanteId == "01") tipo = "FE";
    else if ($scope.tipoComprobanteId == "04") tipo = "TE";

    //console.log("tipo comprobante ", tipo);

    actualizarFactura(tipo, tipocambio, total_impuestos, orderlist_array).then(data => {
      //console.log("respuesta ", data)
      idfactura = data.id;

      obtenerInformacion_ParaXML(data).then(xmldata => {

        if (tipo == "FE") xml = ObjXMLFactura(xmldata);
        else if (tipo == "TE") xml = ObjXMLTiquete(xmldata);

        console.log("objeto para enviar a hacienda ", xml)

          ObtenerXMLComprobante(xml).then(responseXML => {
            console.log("response ", responseXML);

            
              console.log("archivo ", data);

              loginAPI().then(dataLogin => {
                console.log("dataLogin: ")
                console.dir(dataLogin)
                //subirCertificado(dataLogin.sessionKey, dataLogin.user).then(dataCertificado => { //ToDo Deprecated subirCertificado and keep downloadCode in server Side
                //console.log(dataCertificado);

                //firmarXML(responseXML,dataCertificado).then(xmlFirmado => {  //Deprecate
                firmarXMLServerSide(responseXML, idfactura).then(xmlFirmado => {
                  console.log("xml firmado ", xmlFirmado);
                convertirBase64_A_Xml(xmlFirmado).then(decodedXML => {
                  obtenerToken(client_id).then( async (token) => {
                    console.log("token ", token);

                    dataHacienda = dataXML(decodedXML, tipo);
                    console.log("xml hacienda ", dataHacienda);

                    if (tipo == "FE") {

                      objDataHacienda = {
                        token: token,
                        clave: dataHacienda.clave,
                        fecha: dataHacienda.fecha,
                        tipoEmisor: dataHacienda.tipoEmisor,
                        numEmisor: dataHacienda.numEmisor,
                        tipoReceptor: dataHacienda.tipoReceptor,
                        numReceptor: dataHacienda.numerReceptor,
                        xml_firmado: xmlFirmado,
                        client_id: client_id,
                        correo_emisor: xmldata.data[0].e_correoelectronico,
                        correo_receptor: xmldata.data[0].correoelectronico,
                        nombre_receptor: xmldata.data[0].nombre,
                        nombreinstitucion: xmldata.data[0].e_nombrecomercial,
                        password: xmldata.data[0].password_email
                      }

                     const infoXML = await obtenerInformacionDeXml(objDataHacienda, tipo, idfactura);
                      
                      console.log("Data comprobante hacienda ",objDataHacienda)
                      
                      enviarXMLHacienda(infoXML, 'FE').then(data => {
                        
                        console.log("xml data ", xml.obj.clave)
                        acuseDeComprobanteRecibido(objDataHacienda.clave, objDataHacienda.token, objDataHacienda.client_id,idfactura,'FE',objDataHacienda.correo_emisor, objDataHacienda.correo_receptor)
                        .then(dataAcuse => {
                          console.log(dataAcuse)
                          return;
                          obj = {
                            //downloadCode: dataCertificado,
                            xml: dataXML,
                            correo_emisor: objDataHacienda.correo_emisor,
                            correo_receptor: objDataHacienda.correo_receptor,
                            idfactura: idfactura,
                            password: objDataHacienda.password,
                            nombreinstitucion: objDataHacienda.nombreinstitucion,
                            clave: objDataHacienda.clave,
                            client_id: client_id,
                            receptor: objDataHacienda.nombre_receptor,
                            xml_comprobante: xmlFirmado
                          }

                          console.log("xml firma ", obj);
                          firmaComprobante_con_Acuse(obj).then(xml => {
                            console.log(xml)
                          }) /*firmaComprobante_con_Acuse*/
                        }).catch(err => {
                          return console.log(err);
                        }) /*acuseDeComprobanteRecibido*/
                      }) /*enviarXMLHacienda*/

                    } else {
                      objDataHacienda = {
                        token: token,
                        clave: dataHacienda.clave,
                        fecha: dataHacienda.fecha,
                        tipoEmisor: dataHacienda.tipoEmisor,
                        numEmisor: dataHacienda.numEmisor,
                        xml_firmado: xmlFirmado,
                        client_id: client_id,
                        correo_emisor: xmldata.data[0].e_correoelectronico,
                        correo_receptor: xmldata.data[0].correoelectronico

                      }
                      const infoXML = await obtenerInformacionDeXml(objDataHacienda, tipo, idfactura);
                      
                      console.log("Data comprobante hacienda ",objDataHacienda)
                      
                      enviarXMLHacienda(infoXML, 'TE').then(data => {
                        acuseDeComprobanteRecibido(objDataHacienda.clave, objDataHacienda.token, objDataHacienda.client_id,idfactura, 'TE', objDataHacienda.correo_emisor,'')
                        .then(dataAcuse => {
                          console.log(dataAcuse)
                        });
                      })/*enviarXMLHacienda*/
                    }
                  }) /*obtenerToken*/
                }) /*firmarXMLServerSide*/
              }) /*loginAPI*/
            }) /*convertirBase64_A_Xml*/
          }) /*ObtenerXMLComprobante*/
      }) /*obtenerInformacion_ParaXML*/
    }) /*actualizarFactura*/
    .catch(err => {
      return console.log(err);
    })
  }


  $scope.pagarOrden = function () {

    var descuentos = 0;
    //var val = $scope.tipoPago
    $http({
      method: 'GET',
      url: '/cantidadFacturas',
      params: {}
    }).then(function (response) {

      $scope.idFactura    = response.data[0].factura + 1;
      var tipoComprobante ='';

      //verifica si hay descuento
      if ($scope.porcentajeDescuento === '' || !$scope.porcentajeDescuento || typeof $scope.porcentajeDescuento === 'undefined') {
        $scope.porcentajeDescuento = 0;
      }

      var condicionVenta_id   = '';
      var tipoComprobante_id  = '';
      var medioPago_id        = '';

      var tipoComprobante_cmb = document.getElementById("tipoComprobante");
      var medioPago_cmb       = document.getElementById("mediosPago");
      var condicionVenta_cmb  = document.getElementById("condicionVenta");

      //console.log(tipoComprobante_cmb.selectedIndex+"| ")
      //console.log(medioPago_cmb.selectedIndex+" |")
      //console.log(condicionVenta_cmb.selectedIndex+" |")

      //Obtener el tipo de comprobante
      if(tipoComprobante_cmb.selectedIndex == 0 ) tipoComprobante_id = '01'; /* Factura electrónica */
      else if(tipoComprobante_cmb.selectedIndex == 1) tipoComprobante_id = '02'; /* Nota de débito electrónica  */
      else if(tipoComprobante_cmb.selectedIndex == 2) tipoComprobante_id = '03'; /* Nota de crédito electrónica */
      else if(tipoComprobante_cmb.selectedIndex == 3) tipoComprobante_id = '04'; /* Tiquete Electrónico */
      else if(tipoComprobante_cmb.selectedIndex == 4) tipoComprobante_id = '05'; /* Confirmación de aceptación del comprobante electrónico */
      else if(tipoComprobante_cmb.selectedIndex == 5) tipoComprobante_id = '06'; /* Confirmación de aceptación parcial del comprobante
electrónico */
      else tipoComprobante_id = '07'; /* Confirmación de rechazo del comprobante electrónico  */

      //Obtener el medio de pago
      if(medioPago_cmb.selectedIndex == 0) medioPago_id = '01'; /* Efectivo */
      else if(medioPago_cmb.selectedIndex == 1) medioPago_id = '02'; /* Tarjeta */
      else if(medioPago_cmb.selectedIndex == 2) medioPago_id = '03'; /* Cheque */
      else if(medioPago_cmb.selectedIndex == 3) medioPago_id = '04'; /* Transferencia-Deposito-Bancario */
      else if(medioPago_cmb.selectedIndex == 4) medioPago_id = '05'; /* Recaudado-por-terceros */
      else medioPago_id = '99'; /* Otros */

      //Obtener la condicion de venta
      if(condicionVenta_cmb.selectedIndex == 0){
        condicionVenta_id = '01' /* Contado */
      }else{
        condicionVenta_id = '02' /* Crédito */
      }

      //console.log("tipoComprobante "+ tipoComprobante_id+",  medioPago "+medioPago_id+", condicionVenta "+condicionVenta_id)
      $scope.tipoComprobanteId = tipoComprobante_id;

      //configura la info a insertar en BD
      var dataFactura = {
        subTotal:         $scope.totalPagar,
        descuento:        $scope.porcentajeDescuento,
        cantPersonas:     Math.floor($scope.totalPagar / $scope.totalDividida),
        idCuenta:         $scope.my_idCuenta,
        idEmpleado:       $scope.idEmpleado,
        //formaPago:      val,
        tipoComprobante:  tipoComprobante_id,
        condicionVenta:   condicionVenta_id,
        medioPago:        medioPago_id
      }

      //console.log("dataFactura")
      //console.dir(dataFactura)

      $http({
        method: 'POST',
        url: '/insertar_factura',
        data: JSON.stringify(dataFactura)
      }).then(function (response) {
        //Recorre cada una de las órdenes a pagar
        for (var i = 0; i < $scope.payOrders.length; i++) {

          //verifica si existe un descuento en la orden
          if ($scope.payOrders[i].descuentoorden === '') {
            $scope.obj[i].descuentoorden = 0
          }

          //configura la info a modificar en BD
          var data = {
            id: $scope.payOrders[i].idorden,
            idFactura: $scope.idFactura,
            cantidad: $scope.payOrders[i].cantidad
          }         
          //console.log("idfactura DEVUELTO: ",response.data[0].idfactura)
          $("#idfactura").val(response.data[0].idfactura)
          //console.log("#idfactura ",$("#idfactura").val())

          //Modifica el inventario
          $http({
            method: 'POST',
            url: '/disminuir_inventario',
            data: JSON.stringify(data)
          }).then(function (response) {
            $log.info(response)
          }, function errorCallback (response) {
            $log.error(response)
          }).catch(function (error) {
            $log.error(error)
          })

          /*Verfifica si el nodo actual del FOR es el último para mostrar la modal de impresión
            e inicia el proceso de impresión*/
          if (i === $scope.payOrders.length - 1) {
            $('#imprimir-factura-modal').modal('show')
            $scope.imprimirFactura($scope.elements)
            ordersPending()
            totalPagarPerIdCuenta($scope.my_idCuenta)
            $scope.refresh()
          }

          

          //Activa la función en BD para calcular los costos de esta orden
          insertPromise($scope, $http, $log, '/order_cost', data).then(function () {}).catch(function (error) {
            $log.error(error)
          })
          console.log("data ", data)
          // Actualiza la orden de cancelada a pagada
          updatePromise($scope, $http, $log, '/api/order/pay', data).then(function () {}).catch(function (error) {
            $log.error(error)
          })
        }

        $http({
          method: 'GET',
          url: '/get_products_to_update_details'
        }).then(function (response) {
          var products=response.data;
          //console.log("data: ", products)
           //console.log("response", response.data)
           //console.log(products);
           //console.log(descuentos);
          //console.log($scope.detallesOrden(products));
          AddnewOrders($scope.detallesOrden(products))
          $scope.camposOrden(products)
          $scope.camposFactura(products)


          //----------------------------------------

          //----------------------------------------
        }, function errorCallback (response) {
          $log.error(response.data.idCuenta);
        }).catch(function (error) {
          $log.error(error)
        })

      }, function errorCallback (response) {
        $log.error(response)
      }).catch(function (error) {
        $log.error(error)
      })
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.rowClicked = function (product) {
    product.checked = !product.checked
    if (product.checked) {
      product.cantidad = 1
    } else {
      product.cantidad = 0
    }
  }


  $scope.rowClickedOrder = function (order) { order.checked = !order.checked }

  $scope.loadFacturacion_page = function () {
    // This function is to load the facturacion page 'cuentas' from a button. No footbar
    window.location.href = '/sopa#!/cuentas'
  }

  $scope.loadProductos_page = function () {
    //This function is to load products page
    window.location.href = '/sopa#!/productos'
  }

  $scope.loadReceptorPage = function () {
    // This function is to load the receptor page  'receptor' from a button.
    window.location.href = '/sopa#!/receptor'
  }

  $(document).ready(function () { validateAlphanumeric() })

  $('#menu-toggle').click(function (e) {
    e.preventDefault()
    $('#wrapper').toggleClass('toggled')
  })
}).controller('order1Ctrl', function ($scope, $http, $interval, myService, $log) {
  var data = {}
  loadData($scope, $http, $log, '/order_load', data)

  $scope.refreshOrder = function () {
    var data = {}
    loadData($scope, $http, $log, '/order_load', data)
  }

  $scope.desiredLocation = myService.get()

  $scope.sortOrder = function (keyname) {
    $scope.sortKey = keyname // set the sortKey to the param passed
    $scope.reverse = !$scope.reverse // if true make it false and vice versa
  }

  // http:// embed.plnkr.co/rbB3nf/
  var format = 'DD/MM/YY'
  $scope.format = format

  // https:// pterkildsen.com/2015/03/22/filtering-angularjs-items-based-on-start-and-end-date/
  // Daterange filter
  $scope.dateRangeFilter = function (property, startDate, endDate) {
    $scope.dateRangeSelected = startDate + ' - ' + endDate
    return function (item) {
      if (item.Fecha === null) {
        return false
      } else {
        var itemDate = moment(item.Fecha, format)
        var s = moment(startDate, format)
        var e = moment(endDate, format)
        if (itemDate >= s && itemDate <= e && itemDate !== 'undefined') {
          return true
        } else {
          return false
        }
      }
    }
  }

  // http:// www.daterangepicker.com/
  $(function () {
    var picker_id = '#daterangepicker' // 'reportrange';
    var start = moment().subtract(29, 'days')
    var end = moment()

    function cb (start, end) {
      $scope.changeDate1 = start.format(format) // $(picker_id_span).text()// start.format(format))
      $scope.changeDate2 = end.format(format)
      $scope.dateRangeFilter('Fecha', $scope.changeDate1, $scope.changeDate2)
    }

    $(picker_id).daterangepicker({
      startDate: start,
      endDate: end,
      ranges: {
        'Hoy': [moment(), moment()],
        'Ayer': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
        'Ultimos 7 Dias': [moment().subtract(6, 'days'), moment()],
        'Ultimos 30 Dias': [moment().subtract(29, 'days'), moment()],
        'Este Mes': [moment().startOf('month'), moment().endOf('month')],
        'Ultimos 5 Años': [moment().subtract(5, 'years'), moment()],
        'Ultimo Mes': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
      }
    }, cb)
    cb(start, end)
  })

  $scope.deleteOrder = function () {
    // console.log('Delete Order ID: ' + scopeId + ' Descripción: ' + $('#txtDescripcionProductoDelete').val())
    var data = {
      descripcionProducto: $('#txtDescripcionProductoDelete').val().trim(),
      id: scopeId
    }
    update($scope, $http, $log, '/delete_order', data)
    // $('#productFormDelete')[0].reset()
    $scope.refreshProduct()
  }

  $scope.refreshOrder()
}).controller('cuentasController', function ($scope, $http, $log, serviceRestaurant, $window) {
  /* var ordersElements
  var ordersAccounts
  var bill2
  var totalDescuento
  var totalPagar
  var subTotalPagar
  var totalServicio = '' */
  $scope.datosNotaCredito=[];

  let obtenerNumeros_Emisor_Receptor = function(numero){
    let contador=0;

    for(let i=0; i < numero.length; i++){
      console.log(numero[i])
      if(i < 3){
        if(numero[i] == '0'){
          contador++;
        }
      }
    }
    numero= numero.substring(contador, numero.length);
    return numero;
  }

  //-------------------------------------------- LISTENERS -------------------------------------------//
  // AL ABRIR LOS MODALES TODAS LAS LINEAS VAN A ESTAR DESHABILITADAS ṔOR DEFECTO Y PINTADAS CCON SOMBREADO PARA QUE
  // AL HABILITAR UNA LINEA SOLO SE AYUDE AL USUARIO A SABER CUAL LINEA ESTA HABILITADA PARA EDITAR LA CANTIDAD
    $('#nota-credito-modal').on('shown.bs.modal', function (e) {
      // listener para validar cantidad maxima y minima por linea para nota de credito
      var botonAumentar=$(".btn_aumentarCantidadCredito");
      var botonDisminuir=$(".btn_disminuirCantidadCredito");
      var cantidad= $(".cantidadproducto");
      var tr= $(".tr");
      //var check=$(".check");
      var max_cant='';
      var cantidadProductoLinea='';
      for(var i=0; i < $scope.ordersElementsModal.length; i++){

          max_cant=Number($scope.ordersElementsModal[i].cantidadproducto);
          $(cantidad[i]).prop("max",max_cant);
          $(cantidad[i]).prop("min",1);
          $(tr[i]).css('border-radius', '7px');
          $(tr[i]).css('margin-bottom', '5px');
          $(cantidad[i]).prop("disabled",true);

          //$(botonAumentar[i]).addClass("deshabilitar");
          //$(botonDisminuir[i]).addClass("deshabilitar");
          $(botonDisminuir[i]).attr("disabled", true);
          $(botonAumentar[i]).attr("disabled", true);
      }

    })

    $('#nota-debito-modal').on('shown.bs.modal', function (e) {
    //Listener para validar cantidad minima por linea para nota de debito
      //$("#HabilitarLinea").addClass("disabledbutton");
        var botonAumentar=$(".btn_aumentarCantidadCredito2");
      var botonDisminuir=$(".btn_disminuirCantidadCredito2");
      var cantidad= $(".cantidadproducto2");
      var tr= $(".tr2");
      var min_cant='';
      for(var i=0; i < $scope.ordersElementsModal.length; i++){
          min_cant=Number($scope.ordersElementsModal[i].cantidadproducto);
          $(cantidad[i]).prop("min",min_cant);
          $(tr[i]).css('border-radius', '7px');
          $(tr[i]).css('margin-bottom', '5px');
          $(cantidad[i]).prop("disabled",true);
          $(botonDisminuir[i]).attr("disabled", true);
          $(botonAumentar[i]).attr("disabled", true);
      }

    })
    //HABILITAR LAS LINEAS CUANDO SE ABREN LOS MODALES
    $("#nota-credito tbody").on( "change", ".check", function() {

      var botonAumentar=$(this).parent().parent().parent().children("#Aumentar").children();
      var botonDisminuir=$(this).parent().parent().parent().children("#Disminuir").children();

      console.log("Aumentar ", botonAumentar);
      console.log("Disminuir ", botonDisminuir);

      var habilitarCantidad=$(this).parent().parent().parent().children('#cantidad').children();
      var pintarFila=$(this).parent().parent().parent();
      pintarFila.css('border-radius', '7px');
      pintarFila.css('margin-bottom', '5px');
      if($(this).context.checked){
        pintarFila.css("background-color","#FFFFFF");
        habilitarCantidad.prop("readonly",true);
        $(botonDisminuir).attr("disabled", false);
        $(botonAumentar).attr("disabled", false);
      }else{
        habilitarCantidad.prop("readonly",true);
        pintarFila.css("background-color","#BFBFBF");
        $(botonDisminuir).attr("disabled", true);
        $(botonAumentar).attr("disabled", true);
        //#BFBFBF // deshabilitado
        //#FFFFFF // habilitado

      }

    });

    $("#nota-debito tbody").on( "change", ".check2", function() {

      var botonAumentar=$(this).parent().parent().parent().children("#Aumentar").children(".btn_aumentarCantidadCredito2");
      var botonDisminuir=$(this).parent().parent().parent().children("#Disminuir").children(".btn_disminuirCantidadCredito2");
      var habilitarCantidad=$(this).parent().parent().parent().children('#cantidad').children();
      var pintarFila=$(this).parent().parent().parent();

      pintarFila.css('border-radius', '7px');
      pintarFila.css('margin-bottom', '5px');
      if($(this).context.checked){
       //
        pintarFila.css("background-color","#FFFFFF");
        habilitarCantidad.prop("disabled",false);
        $(botonDisminuir).attr("disabled", false);
        $(botonAumentar).attr("disabled", false);
      }else{
        habilitarCantidad.prop("disabled",true);
        pintarFila.css("background-color","#BFBFBF");
        $(botonDisminuir).attr("disabled", true);
        $(botonAumentar).attr("disabled", true);
        //#BFBFBF // deshabilitado
        //#FFFFFF // habilitado
      }

    });
    // RESETEAR MODALES CUANDO SE CIERRAN SIN ENVIAR NOTAS
    $('#nota-credito-modal').on('hide.bs.modal', function (e) {

        var tr= $(".tr");
        var check=$(".check");
        var cantidad=$(".cantidadproducto");
        var new_cantidad= 0;
       for (var i = 0; i < $scope.ordersElementsModal.length; i++) {
         console.log("cantidadproducto ",$scope.cantidad_idorden[i].cantidad)
         new_cantidad=$scope.cantidad_idorden[i].cantidad;
         if($scope.ordersElementsModal[i].idorden == $(cantidad[i]).attr("idorden")){
            $(cantidad[i]).val(new_cantidad)
         }
         $(check[i]).context.checked=false;
         $(tr[i]).css("background-color","#BFBFBF");
       }
    })

    $('#nota-debito-modal').on('hide.bs.modal', function (e) {

        var tr= $(".tr2");
        var check=$(".check2");
        var cantidad=$(".cantidadproducto2");
        var new_cantidad= 0;

       for (var i = 0; i < $scope.ordersElementsModal.length; i++) {
         console.log("cantidadproducto ",$scope.cantidad_idorden[i].cantidad)
         new_cantidad=$scope.cantidad_idorden[i].cantidad;
         if($scope.ordersElementsModal[i].idorden == $(cantidad[i]).attr("idorden")){
            $(cantidad[i]).val(new_cantidad)
         }
         $(check[i]).context.checked=false;
         $(tr[i]).css("background-color","#BFBFBF");
       }
    })

  /*  $('#nota-credito-modal').on('click', "#btn_aumentarCantidadCredito", function (e) {

        var cantidad= $(this).parent().parent().children("#cantidad").children()
        console.log($(cantidad).val())
        $(cantidad).val(Number($(cantidad).val()) + 1);

    })

    $('#nota-credito-modal').on('click', "#btn_disminuirCantidadCredito", function (e) {

        var cantidad= $(this).parent().parent().children("#cantidad").children()
        console.log(cantidad.val())
        cantidad.val(Number(cantidad.val()) - 1);
    })*/



//----------------------------------- FIN SEGMENTO LISTENERS ---------------------------------------- //



   $scope.KeyBackspace= function(event){
      console.log(event.keyCode)
      if(event.keyCode === 8 || event.keyCode === 46 || event.keyCode === 13){
          event.preventDefault();
      }
    }


    $scope.tipoCambioNotas=function(){


    getPromise($scope, $http, $log, '/emisor', {}, false).then(emisor =>  {

        var f = new Date();
        var obj={
            '1':{
            'tcIndicador': 317,
            'tcFechaInicio': f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear(),
            'tcFechaFinal': f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear(),
            'tcNombre': emisor[0].e_nombre,
            'tnSubNiveles': 'N'
          }
        }

        console.log(obj[1]);
      getPromise($scope, $http, $log, '/tipoCambio', obj[1], false).then(function (tipocambio) {


            if(window.DOMParser){ // PARSEAR el xml para poder leerlo
                      parser= new DOMParser();
                      xmlDoc=parser.parseFromString(tipocambio,"text/html");

                      //console.log("xml ",xmlDoc);
            }
             else
             {
                      xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
                      xmlDoc.async=false;
                      xmlDoc.loadXML(tipocambio);
             }

              var tipo= Number(xmlDoc.getElementsByTagName("NUM_VALOR")[0].innerHTML).toFixed(2);
              $("#tipoCambioNota").val(tipo);
      })
    })


   }
   $scope.tipoCambioNotas();

     $scope.Pagar = [{
       id:'01',
       descripcion:'Efectivo'
     },{
       id:'02',
       descripcion:'Tarjeta'
    }]

  $scope.nombreEmpleado = ''
  $scope.periodo = ''
  $scope.formapago = ''
  $scope.fecha = ''
  $scope.idEmpleado = serviceRestaurant.getidEmpleado()

  $scope.referencia= {
    '1':{
      id: '01',
      descripcion: 'Anula documento de refencia'
    },

    '2':{
      id: '02',
      descripcion: 'Corrige texto documento de referencia'
    },
    '3':{
      id: '03',
      descripcion: 'Corrige monto'
    },
    '4':{
      id: '04',
      descripcion: 'Referencia a otro documento'
    },
    '5':{
      id: '05',
      descripcion: 'Sustituye comprobante por contingencia'
    },
    '6':{
      id:'06',
      descripcion: 'Otros'
    }
  }

  $scope.actualizarCuenta = function (idFactura) {
    var data = {
      idFactura: idFactura,
      formaPago: $('#txtFormaPago').val().trim()
    }
    updatePromise($scope, $http, $log, '/actualizarFactura', data).then(function () {
      $scope.refreshCuenta()
    }).catch(function (error) {
      $log.error(error)
    })
  }

    $scope.getUserId = function() {
    return new Promise((resolve, reject) => {
    $scope.periodoVenta = serviceRestaurant.getperiodo()
    $http({
      method: 'GET',
      url: '/userId'
    }).then(response => {
      $scope.userId= response.data.userId
        switch ($scope.userId) {
          case 'admin1':
             $scope.idEmpleadoNota = 1;

             resolve($scope.idEmpleadoNota)
            break;
          case 'cajero1':
             $scope.idEmpleadoNota = 3;

             resolve($scope.idEmpleadoNota)
             break;
          case 'cajero2':
             $scope.idEmpleadoNota = 2;

             resolve($scope.idEmpleadoNota)
              break;
          case 'user1':
             $scope.idEmpleadoNota = 3;

             resolve($scope.idEmpleadoNota)
             break;
          default:
             $scope.idEmpleadoNota = 3;

             resolve($scope.idEmpleadoNota)
          }
      })
    })
  }


 $scope.getPeriodInfo=  function() {
    return new Promise((resolve,reject) => {
          $http({
          method: 'GET',
          url: '/api/period'
        }).then(function (response) {

          $scope.idPeriodoVenta = response.data[0].idperiodoventa
          resolve($scope.idPeriodoVenta)
        }).catch(function (error) {
          reject(error)
        })
    })
  }

  $scope.eliminarCuenta = function (idFactura) {
    var data = { idFactura: idFactura }
    updatePromise($scope, $http, $log, '/eliminarFactura', data).then(function () {
      for (var i = 0; i < $scope.ordersElements.length; i++) {
        var data = {
          cantidad: $scope.ordersElements[i].cantidadproducto,
          orden: $scope.ordersElements[i].idorden
        }
        $http({
          method: 'POST',
          url: '/aumentar_inventario',
          data: JSON.stringify(data)
        }).then(function (response) {
          $log.info(response)
        }, function errorCallback (response) {
          $log.error(response)
        }).catch(function (error) {
          $log.error(error)
        })
      }
      $scope.refreshCuenta()
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.refreshCuenta = function () {
    $http({
      method: 'GET',
      url: '/getCanceledBills'
    }).then(function (response) {
      $scope.object = response.data
      for (var i = 0; i < $scope.object.length; i++) {
        if ($scope.object[i].estadofactura === 1) {
          $scope.object[i].estadofactura = 'Activa'
        } else {
          $scope.object[i].estadofactura = 'Anulada'
        }
      }
    }, function errorCallback (response) {
      $log.error(response)
      $log.error('callback function not exist')
    }).catch(function (error) {
      $log.error(error)
    })

    $http({
      method: 'GET',
      url: '/dashboard_load'
    }).then(function (response) {
      console.log(response)
      $scope.periodoInfo = response.data
      $scope.nombrePeriodo = $scope.periodoInfo[0].nombreperiodo
      $scope.fechaInicioPeriodo = $scope.periodoInfo[0].fecha
      $scope.totalEfectivo = $scope.periodoInfo[0].efectivos * 1
      $scope.totalTarjeta = $scope.periodoInfo[0].tarjetas * 1
      $scope.total = $scope.totalEfectivo + $scope.totalTarjeta
    }, function errorCallback (response) {
      $log.error(response)
      $log.error('callback function not exist')
    }).catch(function (error) {
      $log.error(error)
    })
  }

   $scope.filaClicked = function (factura) {
    $scope.facturaSelected='';
    for (var i = 0; i < $scope.object.length; i++) { // poner todas las filas de facturas en checked=false;
      $scope.object[i].checked = false
    }
     factura.checked=true; // obtener la fila que ha sido chequeada
     $scope.facturaSelected =factura;

  }

  let insertarFila = (data, route) =>{
       return new Promise((resolve,reject) => {
         $http({ method: 'POST', url: route, params: data, data: data})
         .then(data => {
          resolve(data);
         }).catch(err =>{
           reject(err);
         })
       })
  }

  let getLinea= (data,route)=> {
    return new Promise((resolve,reject) => {
         $http({ method: 'GET', url: route, params: data})
         .then(data => {
          resolve(data);
         }).catch(err =>{
           reject(err);
         })
       })
  }

  let actualizarLinea= (data,route)=> {
    return new Promise((resolve,reject) => {
         $http({ method: 'PUT', url: route, params: data})
         .then(data => {
          resolve(data);
         }).catch(err =>{
           reject(err);
         })
       })
  }

       $scope.eliminarOrden=function(item){
          var descuento=0;
          var descuento_total=0;

         for (var i = 0; i < $scope.ordersElementsModal.length; i++) {
              if($scope.ordersElementsModal[i].idorden == item.idorden){
                 descuento= item.subtotal * item.descuentoorden / 100;
                 console.log(descuento)
                  descuento_total= descuento / $scope.totalPagar * 100;
                  //$scope.descuentoColones / $scope.totalPagar * 100
                 //console.log(descuento_total)
                  //$scope.dataSelected.porcentajedescuento-= descuento_total.toFixed(2);
                  $scope.porcentajeDescuento = Number($scope.dataSelected.porcentajedescuento).toFixed(2)
                  $scope.subTotalPagar -= Number(item.subtotal)
                  $scope.totalDescuento = $scope.subTotalPagar * $scope.porcentajeDescuento / 100
                  //console.log()
                  $scope.totalPagar = $scope.subTotalPagar - $scope.totalDescuento
                  $scope.montoPorPersona = $scope.totalPagar / Number($scope.dataSelected.cantidadpersonas)
                $scope.ordersElementsModal.splice(i,1);
              }
           }
       }
       //var desc=0;

       /* $scope.DescuentoOrden= function(item, descuento){
          console.log($scope.dataSelected.totaldescuentos)
        let descuento_aplicado=0;
        let total=0;
                if(descuento === undefined){
                  descuento=0;
                }
                console.log(descuento)
                descuento_aplicado= Number(item.subtotal) * descuento / 100;
                console.log("descuentoAplicado ",descuento_aplicado);
                //item.subtotal-=descuento_aplicado;
                var descuento_total=0;

                for (var i = 0; i < $scope.ordersElementsModal.length; i++) {

                  //if($scope.ordersElementsModal[i].idorden == item.idorden){

                 // }
                    total+=$scope.ordersElementsModal[i].subtotal;
                    item.descuentoorden=descuento;
                    $scope.ordersElementsModal[i].montodescuento=  descuento_aplicado;
                }


                item.montodescuento= descuento_aplicado;
                item.descuentoorden=descuento;
                //$scope.subTotalPagar=total;
                console.log(descuento_aplicado)
                desc+=descuento_aplicado;
                console.log(desc)
                var porcentajedescuento=Number($scope.dataSelected.porcentajedescuento);
                descuento_total=  desc * 100 / $scope.subTotalPagar;
                console.log(descuento_total.toFixed(2))
                $scope.porcentajeDescuento= (porcentajedescuento + descuento_total).toFixed(2);
                console.log(" $scope.totalDescuento", $scope.totalDescuento)
                $scope.totalDescuento+=  descuento_aplicado;
                console.log(" $scope.totalDescuento", $scope.totalDescuento)
                $scope.totalPagar -= descuento_aplicado
                $scope.montoPorPersona = $scope.totalPagar / Number($scope.dataSelected.cantidadpersonas)

      };*/

  $scope.editarCantidadCredito= function(item,tipo, cantidad,tipoNota , aumentar, disminuir){

    console.log(item)
    console.log(tipo)

    var clase='';
    var botonAumentar=document.getElementsByClassName(String(aumentar)); //$("#btn_aumentarCantidadCredito");
    var botonDisminuir= document.getElementsByClassName(String(disminuir)) //$("#btn_aumentarCantidadCredito");
    var cantidadLinea= document.getElementsByClassName(String(cantidad));
    console.log(cantidadLinea)

    /*for (var i = 0; i < cantidadLinea.length; i++) {
      $(cantidadLinea[i]).attr("max", $scope.ordersElementsModal[i].cantidadproducto);
      $(cantidadLinea[i]).attr("min", 1);
    }*/
    //thepiratebay.org/search/

    var cantidadFInal=0;


      if(String(tipo) === '1'){

        for (var i = 0; i < cantidadLinea.length; i++) {
          if(botonAumentar[i].getAttribute("idorden") == item.idorden){

             cantidadFInal= Number(cantidadLinea[i].getAttribute("value")) + 1;
             console.log("cantidad credito", cantidadFInal)
            cantidadLinea[i].setAttribute("value", cantidadFInal)

            obtenerCantidad(item, cantidadFInal,tipoNota);
          }
        }

      }else{

         for (var i = 0; i < cantidadLinea.length; i++) {
          if(botonDisminuir[i].getAttribute("idorden") == item.idorden){
            cantidadFInal= Number(cantidadLinea[i].getAttribute("value")) - 1;
            console.log("cantidad credito", cantidadFInal)
            cantidadLinea[i].setAttribute("value", cantidadFInal)

            obtenerCantidad(item, cantidadFInal,tipoNota);
          }
        }

      }

   }

  $scope.editarCantidaddEBITO= function(item,tipo, tipoNota){


    console.log(item)
    console.log(tipo)
    var botonAumentar=document.getElementsByClassName("btn_aumentarCantidadCredito"); //$("#btn_aumentarCantidadCredito");
    var botonDisminuir= document.getElementsByClassName("btn_disminuirCantidadCredito") //$("#btn_aumentarCantidadCredito");
    var cantidadLinea= document.getElementsByClassName("cantidadproducto");

    for (var i = 0; i < cantidadLinea.length; i++) {
      $(cantidadLinea[i]).attr("max", $scope.ordersElementsModal[i].cantidadproducto);
      $(cantidadLinea[i]).attr("min", 1);
    }
   // console.log("cantidad ",cantidadLinea)
    var cantidadFInal=0;


      if(String(tipo) === '1'){

        for (var i = 0; i < botonAumentar.length; i++) {
          if(botonAumentar[i].getAttribute("idorden") == item.idorden){

            cantidadFInal= Number(cantidadLinea[i].getAttribute("value")) + 1;
             console.log("cantidad credito", cantidadFInal)
            cantidadLinea[i].setAttribute("value", cantidadFInal)

            obtenerCantidad(item, cantidadFInal,tipoNota);
          }
        }

      }else{

         for (var i = 0; i < botonDisminuir.length; i++) {

          if(botonDisminuir[i].getAttribute("idorden") == item.idorden){
            cantidadFInal= Number(cantidadLinea[i].getAttribute("value")) - 1;
            console.log("cantidad credito", cantidadFInal)
            cantidadLinea[i].setAttribute("value", cantidadFInal)

            obtenerCantidad(item, cantidadFInal,tipoNota);
          }
      }

    }

  }

  let obtenerCantidad= function(item,cantidad,tipoNota){

        console.log("cantidad ",cantidad)

        let subtotal=0;
        let total=0;
        let desc_orden=0;
        let cantidadProductoLinea=0;
        let tiponota=''
       $scope.datosNotaCredito= $scope.ordersElementsModal;

        if(item.descuentoorden === undefined ){
          item.descuentoorden=0;
        }
               subtotal= Number(item.preciounitarioproducto) * Number(cantidad);
               item.subtotal=subtotal;
               item.cantidadproducto= cantidad;
               console.log("cantidad linea",item.cantidadproducto)

          for (var i = 0; i < $scope.ordersElementsModal.length; i++) {

            if($scope.ordersElementsModal[i].idorden == item.idorden){

                $scope.ordersElementsModal[i].subtotal= subtotal;
                $scope.ordersElementsModal[i].cantidadproducto= cantidad;


                if(tipoNota == "credito") {

                  tiponota="credito"
                 // cantidadProductoLinea= Number($scope.cantidad_idorden[i].cantidad) - Number(cantidad);
                }
                else {

                  tiponota="debito"
                 // cantidadProductoLinea= Number(cantidad) - Number($scope.cantidad_idorden[i].cantidad)
                }

               if(typeof($scope.datosNotaCredito[i].tipoNota) === 'undefined'){

                  Object.defineProperty($scope.datosNotaCredito[i], 'tipoNota', {
                    value: tiponota
                  });

                }else{
                  $scope.datosNotaCredito[i].tipoNota= tiponota;
                }

                if($scope.datosNotaCredito[i].idorden== item.idorden){

                  // AQUI ES DONDE FALLA EL CODIGO
                  if(typeof ($scope.datosNotaCredito[i].estado) === 'undefined' ){
                    //$scope.datosNotaCredito[i].cantidadproducto= cantidadProductoLinea;

                      Object.defineProperty($scope.datosNotaCredito[i], 'estado', {
                        value: 'actualizado'
                      });
                      console.log($scope.datosNotaCredito);
                  }else{
                    console.log($scope.datosNotaCredito);
                  }
                }
             }

               total+=$scope.ordersElementsModal[i].subtotal;

         }


          desc_orden+=item.descuentoorden;
          $scope.subTotalPagar=total;
          $scope.porcentajeDescuento = Number($scope.dataSelected.porcentajedescuento) + desc_orden;
          $scope.totalDescuento = $scope.subTotalPagar * $scope.porcentajeDescuento / 100
          $scope.totalPagar = $scope.subTotalPagar - $scope.totalDescuento
          $scope.montoPorPersona = $scope.totalPagar / Number($scope.dataSelected.cantidadpersonas)

  }


      // INSITUTO COSVIC AVEINDA 10 POR LUMACA


     /* $scope.obtenerCantidadNotaDebito= function(item,cantidad){


        let subtotal=0;
        let total=0;
        let desc_orden=0;
        let cantidadProductoLinea=0;
        let subtotal_linea=0;
        $scope.datosNotaCredito= $scope.ordersElementsModal;

        if(item.descuentoorden === undefined ){
          item.descuentoorden=0;
        }
               subtotal= Number(item.preciounitarioproducto) * Number(cantidad);
               item.subtotal=subtotal;
               console.log("subTotal ",item.subtotal)

          for (var i = 0; i < $scope.ordersElementsModal.length; i++) {

            if($scope.ordersElementsModal[i].idorden == item.idorden){

                $scope.ordersElementsModal[i].subtotal= subtotal;
                $scope.ordersElementsModal[i].cantidadproducto= cantidad;

                cantidadProductoLinea= Number(cantidad) - Number($scope.cantidad_idorden[i].cantidad) ;
                subtotal_linea= Number($scope.cantidad_idorden[i].precio) * cantidadProductoLinea;
                console.log("subtotal_orden_nota_credito ", subtotal_linea)
                if($scope.datosNotaCredito[i].idorden== item.idorden){
                  console.log("cantidad ",cantidadProductoLinea)
                    if(typeof ($scope.datosNotaCredito[i].estado) === 'undefined' ){
                      //$scope.arrayTemp[i].cantidadproducto= cantidadProductoLinea;

                        Object.defineProperty($scope.datosNotaCredito[i], 'estado', {
                          value: 'actualizado'
                        });
                        console.log($scope.datosNotaCredito);
                    }else{}
                }
             }

               total+=$scope.ordersElementsModal[i].subtotal;

         }


          desc_orden+=item.descuentoorden;
          $scope.subTotalPagar=total;
          $scope.porcentajeDescuento = Number($scope.dataSelected.porcentajedescuento) + desc_orden;
          $scope.totalDescuento = $scope.subTotalPagar * $scope.porcentajeDescuento / 100
          $scope.totalPagar = $scope.subTotalPagar - $scope.totalDescuento
          $scope.montoPorPersona = $scope.totalPagar / Number($scope.dataSelected.cantidadpersonas)
      }*/


  $scope.Descuentos=['5','10','15','25','50'];
  // FUNCION PARA APLICAR LA NOTA DE CREDITO
  $scope.cacularDatosNota = function(ordersElementsModal, tipo) {

    var data = {
      detalles: $scope.detallesOrden_Nota(ordersElementsModal)
    }
    var DEBUG = true;
    var client_id = '';
    insertarFila(data, '/insert_details_nota').then(iddetalle => {
        if (DEBUG) {
          client_id = 'api-stag';
        } else {
          client_id = 'api-prod';
        }
        cuerpoFactura(iddetalle.data[0].iddetalle, tipo)
          .then(data => {
            var idfactura = data.data[0].insertar_nota.idfactura
            $scope.camposOrdenNota(ordersElementsModal, data.data[0].insertar_nota.idfactura, data.data[0].insertar_nota.iddetalle)
              .then(resp => {
                let data = {
                  idfactura: idfactura
                };
                getLinea(data, '/get_data_toxml')
                  .then(dataNota => {

                    let array = $scope.xmlNotaCredito(dataNota, tipo);
                    let password = dataNota.data[0].password_email;

                    console.log("data_toxml", array);

                    console.log("data array", array)
                    insertarFila(array, '/send_to_crlibre_for_xml').then(data => {
                      console.log(data)
                      var xml = data.data.resp.xml;
                      // AQUI ES DONDE SE VA VALIDAR EL XML CON EL API DE VALIDACIOND DE HACIENDA
                      console.log("xml ", xml) // se hace una peticion post y se envia el xml en base 64 sin firmar.

                      getLinea({}, '/emisor/username_password').then(response => {
                        //console.log("credenciales_emisor respuesta ",response[0].user_api + response[0].pwd_api);

                        let username = response.data[0].usernameapi;
                        let pwd = response.data[0].passwordapi;

                        var obj = {
                          '1': {
                            //'w': 'users',
                            //'r': 'users_log_me_in',
                            'username': username,
                            'pwd': pwd
                          }
                        }
                        console.log("login API ", obj)
                        insertarFila(obj[1],'/login').then(response => {  // ToDo improve
                        //insertPromise($scope, $http, $log, '/login', obj[1], false).then(response => {
                          if (response.data.resp.sessionKey !== 'undefined' && response.data.resp.userName !== 'undefined') {
                            sessionKeyGlobal = response.data.resp.sessionKey
                            userNameAPIGlobal = response.data.resp.userName
                            if (DEBUG) {
                              console.log("sessionKey: ", sessionKeyGlobal)
                            }


                            console.log(response);

                            // var sessionKey=response.data.resp.sessionKey;

                            var json = {
                              '1': {
                                'w': 'fileUploader',
                                'r': 'subir_certif',
                                'sessionKey': sessionKeyGlobal,
                                'iam': userNameAPIGlobal
                              }
                            }

                            console.log("JSON ", json[1])

                            //insertarFila(json[1],'/upload_certificado').then(data=> {


                            //var downloadCode= data.data.resp.downloadCode;
                            var data_firma = {
                              '1': {
                                //'w': 'signXML',
                                //'r': 'signFE',
                                //'p12Url': downloadCode,
                                'inXml': xml,
                                'tipodoc': 'NC'

                              }
                            }


                            console.log("data_firma ", data_firma)

                            insertarFila(data_firma[1], '/firma_electronica/serverside').then(firma => {
                              var xml_firmado = firma.data.resp.xmlFirmado
                              console.log("xml firmado ", xml_firmado);
                              var data_token = {

                                '1': {
                                  'r': 'gettoken',
                                  'w': 'token',
                                  'grant_type': 'password',
                                  'client_id': client_id
                                }
                              }

                              insertarFila(data_token[1], '/token').then(tokenData => {
                                console.log(tokenData);
                                if (window.DOMParser) { // PARSEAR el xml para poder leerlo9
                                  parser = new DOMParser();
                                  xmlDoc = parser.parseFromString(atob(xml), "text/xml");

                                  /*
                                  var data={
                                    data_xml: atob(xml),
                                    id: idfactura
                                  }

                                  insert_xml ($scope, $http, $log, data)
                                  */
                                  console.log(xmlDoc);
                                } else {
                                  xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                                  xmlDoc.async = false;
                                  xmlDoc.loadXML(atob(xml));
                                }
                                // AQUI se imprimen datos del XML
                                console.log("clave ", xmlDoc.getElementsByTagName("Clave")[0].childNodes[0].nodeValue);
                                console.log("fecha ", xmlDoc.getElementsByTagName("FechaEmision")[0].childNodes[0].nodeValue);
                                console.log("tipo emisor ", xmlDoc.getElementsByTagName("Emisor")[0].childNodes[3].childNodes[1].innerHTML);
                                console.log("numero emisor ", xmlDoc.getElementsByTagName("Emisor")[0].childNodes[3].childNodes[3].innerHTML);
                                console.log("tipo receptor ", xmlDoc.getElementsByTagName("Receptor")[0].childNodes[2].childNodes[1].innerHTML);
                                console.log("numero receptor ", xmlDoc.getElementsByTagName("Receptor")[0].childNodes[2].childNodes[3].innerHTML);

                                var data_hacienda = {
                                  clave: xmlDoc.getElementsByTagName("Clave")[0].childNodes[0].nodeValue,
                                  fechaE: xmlDoc.getElementsByTagName("FechaEmision")[0].childNodes[0].nodeValue,
                                  tipoEmisor: xmlDoc.getElementsByTagName("Emisor")[0].childNodes[3].childNodes[1].innerHTML,
                                  numEmisor: xmlDoc.getElementsByTagName("Emisor")[0].childNodes[3].childNodes[3].innerHTML,
                                  tipoReceptor: xmlDoc.getElementsByTagName("Receptor")[0].childNodes[2].childNodes[1].innerHTML,
                                  numerReceptor: xmlDoc.getElementsByTagName("Receptor")[0].childNodes[2].childNodes[3].innerHTML,
                                }

                                var data_send_hacienda = {
                                  '1': {
                                    'w': 'send',
                                    'r': 'json',
                                    'token': tokenData.data.resp.access_token,
                                    'clave': data_hacienda.clave,
                                    'fecha': data_hacienda.fechaE,
                                    'emi_tipoIdentificacion': data_hacienda.tipoEmisor,
                                    'emi_numeroIdentificacion': data_hacienda.numEmisor,
                                    'recp_tipoIdentificacion': data_hacienda.tipoReceptor,
                                    'recp_numeroIdentificacion': data_hacienda.numerReceptor,
                                    'comprobanteXml': xml_firmado,
                                    'client_id': client_id,
                                    'correo_emisor': array.emisor_email,
                                    'correo_receptor': array.receptor_email,
                                    'nombre_receptor': array.receptor_nombre,
                                    'nombreinstitucion': array.nombre_comercial,
                                    'password': password
                                  }
                                }

                                console.log(data_send_hacienda);

                                insertarFila(data_send_hacienda[1], '/envio_hacienda')
                                  .then(estado => {

                                    console.log(estado.data.resp.Status)
                                    if (typeof estado.data.resp.Status !== 'undefined') {
                                      var datos = {};
                                      if (estado.data.resp.Status == 202) {
                                        datos = {
                                          estado: estado.data.resp.Status,
                                          razon: 'El comprobante ha sido recibido'
                                        }
                                        JSON.stringify(datos)
                                        actualizarLinea(datos, '/update_reason_status_factura')
                                          .then(data => {
                                            console.log(data)
                                          })

                                      } else {
                                        datos = {
                                          estado: estado.data.resp.Status,
                                          razon: estado.data.resp.text[15]
                                        }
                                        JSON.stringify(datos)
                                        actualizarLinea(datos, '/update_reason_status_factura')
                                          .then(data => {
                                            console.log(data)
                                          })
                                      }
                                    }
                                  })
                              })
                            })
                            //})
                          }
                        })
                      })
                    })
                  })
              })
          })
      })
      .catch(err => {
        console.log(err)
      })

  }

  $scope.xmlNotaCredito= function(data, tipo){

     var tipo_nota='';

  if(String(tipo) === '1') tipo_nota= 'gen_xml_nc'; else tipo_nota= 'gen_xml_nd';
   let claveReferencia= $scope.dataSelected.clavenumerica.substr(3,$scope.dataSelected.clavenumerica.length);
   claveReferencia= "000"+claveReferencia;
   console.log("clave ",claveReferencia)

    let canton_emisor='';
    let distrito_emisor='';
    let canton_receptor='';
    let distrito_receptor='';
    let numero_emisor= obtenerNumeros_Emisor_Receptor(data.data[0].emisor_numero);
    let numero_receptor=obtenerNumeros_Emisor_Receptor(data.data[0].receptor_numero);

    if(Number(data.data[0].e_canton) < 10){ canton_emisor= '0'+String(data.data[0].e_canton)  }else{ canton_emisor=data.data[0].e_canton }
    if(Number(data.data[0].e_distrito) < 10){ distrito_emisor= '0'+String(data.data[0].e_distrito) }else{ distrito_emisor= data.data[0].e_distrito }
    if(Number(data.data[0].canton) < 10){ canton_receptor= '0'+String(data.data[0].canton)  }else{ canton_receptor=data.data[0].canton }
    if(Number(data.data[0].distrito) < 10){ distrito_receptor= '0'+String(data.data[0].distrito) }else{ distrito_receptor= data.data[0].distrito }

    let medios_pago_json = '[{"codigo": "' + data.data[0].medio_pago + '"}]'
    $log.info("MediosPago:")
    $log.info(medios_pago_json)
    var obj={
                '1':{
                  'w': 'genXML',
                  'r': tipo_nota,
                  'clave': data.data[0].clavenumerica,
                  'consecutivo': $scope.dataSelected.consecutivo,
                  'fecha_emision': $scope.dataSelected.fecharegistrofactura,
                  'emisor_nombre': data.data[0].e_nombre,
                  'emisor_tipo_identif': data.data[0].emisor_tipo_identificacion,
                  'emisor_num_identif': numero_emisor,
                  'emisor_nombre_comercial': data.data[0].e_nombrecomercial,
                  'emisor_provincia': data.data[0].e_provincia,
                  'emisor_canton': canton_emisor,
                  'emisor_distrito': distrito_emisor,
                  'emisor_barrio' : '01',
                  'emisor_otras_senas': data.data[0].e_otras_senas,
                  'emisor_cod_pais_tel': data.data[0].emisor_telefono_codigopais,
                  'emisor_tel': data.data[0].emisor_telefono_numtelefono,
                  'emisor_cod_pais_fax': data.data[0].emisor_fax_codigopais,
                  'emisor_fax': data.data[0].emisor_fax_numtelefono,
                  'emisor_email': data.data[0].e_correoelectronico,
                  'receptor_nombre': data.data[0].nombre,
                  'receptor_tipo_identif': data.data[0].receptor_tipo_identificacion,
                  'receptor_num_identif': numero_receptor,
                  'receptor_provincia': data.data[0].provincia,
                  'receptor_canton': canton_receptor,
                  'receptor_distrito': distrito_receptor,
                  'receptor_barrio' : '01',
                  'receptor_cod_pais_tel': data.data[0].receptor_telefono_codigopais,
                  'receptor_tel': data.data[0].receptor_telefono_numtelefono,
                  'receptor_cod_pais_fax': data.data[0].receptor_fax_codigopais,
                  'receptor_fax': data.data[0].receptor_fax_numtelefono,
                  'receptor_email': data.data[0].correoelectronico,
                  'condicion_venta': data.data[0].condicion_venta,
                  'plazo_credito': data.data[0].plazo_credito,
                  'medios_pago': medios_pago_json,
                  'cod_moneda': data.data[0].codigomoneda,
                  'tipo_cambio': data.data[0].tipocambio,
                  'total_serv_gravados': data.data[0].totalservgravados,
                  'total_serv_exentos': data.data[0].totalservexentos,
                  'total_merc_gravada': data.data[0].totalmercanciasgravadas,
                  'total_merc_exenta': data.data[0].totalmercanciasexentas,
                  'total_gravados': data.data[0].totalgravado,
                  'total_exentos': data.data[0].totalexento,
                  'total_ventas': data.data[0].totalventa,
                  'total_descuentos': data.data[0].totaldescuentos,
                  'total_ventas_neta': data.data[0].totalventaneta,
                  'total_impuestos': data.data[0].totalimpuesto,
                  'total_comprobante': data.data[0].totalcomprobante,
                  'otros': 'Muchas gracias',
                  'infoRefeTipoDoc': '01',
                  'infoRefeNumero': $scope.dataSelected.clavenumerica,
                  'infoRefeFechaEmision': data.data[0].fecharegistrofactura,
                  'infoRefeCodigo': data.data[0].tipo_comprobante,
                  'infoRefeRazon': numero_emisor,
                  'detalles': data.data[0].descripcion_detalle,

                  }
                }

        return obj[1];
  }





// EL PROCESO DE CREAR FACTURAS ES PRIMERO INSERTA ALGUNOS CAMPOS DE LA NUEVA FACTURA, LUEGO LOS DETALLES DE CADA ORDEN
// LAS LINEAS DE CADA ORDEN DE LA FACTURA Y POR ULTIMO ACTUALIZAR LOS CAMPOS MATEMATICOS DE LA FACTURA.
  $scope.detallesOrden_Nota= function(orderlist_array) {


    //console.log($("#total_pagar").text());
    let listaDetalles= {};
    var descuento=0;
    var montototal=0;
    var subtotal=0; //25407581
    var totalLinea=0;
    var cantidad=0;


        for (let i = 0; i < orderlist_array.length ;i++) {
          if($scope.datosNotaCredito[i].tipoNota= "credito"){
            cantidad= Number($scope.cantidad_idorden[i].cantidad) - Number(orderlist_array[i].cantidadproducto);
            $scope.datosNotaCredito[i].cantidadproducto= cantidad;
          }else{
            cantidad=  ordersElementsModal[i].cantidadproducto - cantidad_idorden[i].cantidad;
            $scope.datosNotaCredito[i].cantidadproducto= cantidad;

          }
          console.log("cantidad final ", $scope.datosNotaCredito[i].cantidadproducto);
          if((typeof ($scope.datosNotaCredito[i].estado) !== 'undefined' && $scope.datosNotaCredito[i].estado === "actualizado" ) &&
            Number( $scope.datosNotaCredito[i].cantidadproducto) > 0){

          subtotal=Number($scope.datosNotaCredito[i].cantidadproducto * $scope.datosNotaCredito[i].preciounitarioproducto);
          montototal=Number($scope.datosNotaCredito[i].cantidadproducto * $scope.datosNotaCredito[i].preciounitarioproducto - $scope.datosNotaCredito[i].montoimpuesto);
          totalLinea= subtotal + $scope.datosNotaCredito[i].montoimpuesto
          if($scope.datosNotaCredito[i].descuentoorden == ""){
              descuento=0;
          }else{
              descuento=  Number($scope.datosNotaCredito[i].preciounitarioproducto) * Number($scope.datosNotaCredito[i].descuentoorden)/100;
          }

              listaDetalles[i+1] ={
              'cantidad': Number(cantidad).toString(),
              'unidadMedida': String($scope.datosNotaCredito[i].unidadmedida),
              'detalle': String($scope.datosNotaCredito[i].descripcionproducto),
              'precioUnitario': Number($scope.datosNotaCredito[i].preciounitarioproducto).toFixed(0).toString(),
              'montoTotal': montototal.toFixed(0).toString() ,
              'subtotal': subtotal.toFixed(0).toString(),
              'montoTotalLinea': totalLinea.toFixed(0).toString(),
              'montoDescuento': descuento.toString(),
              'naturalezaDescuento': $scope.datosNotaCredito[i].naturalezadescuento,
              'impuesto':{"1": {"codigo": String($scope.datosNotaCredito[i].impuesto),"tarifa":parseFloat($scope.datosNotaCredito[i].porcentajeimpuesto).toString(), "monto":Number(subtotal * $scope.datosNotaCredito[i].porcentajeimpuesto).toFixed(0).toString()
            }}};
          }else{}
        }

        console.log("detalles ",listaDetalles);
    return JSON.stringify(listaDetalles);
  }




  $scope.camposOrdenNota= function(orderlist_array, idfactura, iddetalle){

           return new Promise((resolve, reject) => {

            var listaCampos = [];
            var total=0;
            var descuento=0;
            var subtotal=0;
            var impuesto=0;
        for (var i = 0; i < orderlist_array.length; i++) {

          if((typeof ($scope.datosNotaCredito[i].estado) !== 'undefined' && $scope.datosNotaCredito[i].estado === "actualizado") &&
            Number($scope.datosNotaCredito[i].cantidadproducto) > 0){
            subtotal= Number($scope.datosNotaCredito[i].preciounitarioproducto) * Number($scope.datosNotaCredito[i].cantidadproducto);
            impuesto=parseFloat($scope.datosNotaCredito[i].montoimpuesto);
           var montototallinea= subtotal + impuesto;
           console.log("subtotal orden",subtotal)
           console.log("impuesto ", impuesto)
           total=Number($scope.datosNotaCredito[i].cantidadproducto * $scope.datosNotaCredito[i].preciounitarioproducto);
           descuento= Number($scope.datosNotaCredito[i].preciounitarioproducto) * Number($scope.datosNotaCredito[i].descuentoorden)/100;
              listaCampos.push({
                'idcuenta': $scope.datosNotaCredito[i].idcuenta,
                'idproducto': $scope.datosNotaCredito[i].idproducto,
                'idfactura': idfactura,
                 'cantidad': $scope.datosNotaCredito[i].cantidadproducto,
                 'estado': 'Cancelada',
                 'preciounitario': $scope.datosNotaCredito[i].preciounitarioproducto,
                'costounitario': $scope.datosNotaCredito[i].costounitarioproducto,
                'descuento': $scope.datosNotaCredito[i].descuentoorden,
                'numerolineadetalle':i+1 ,
                'codigoservicio': $scope.datosNotaCredito[i].codigo_producto,
                'tiposervicio': $scope.datosNotaCredito[i].tipo_producto,
                'unidadmedida': $scope.datosNotaCredito[i].unidadmedida,
                'unidadmedidacomercial': $scope.datosNotaCredito[i].unidadmedidacomercial,
                'detalle':  $scope.datosNotaCredito[i].descripcionproducto,
                'montototal': total,
                'montodescuento': descuento,
                'naturalezadescuento': $scope.datosNotaCredito[i].naturalezadescuento,
                'subtotal': subtotal,
                'codigoimpuesto': $scope.datosNotaCredito[i].codigoimpuesto ,
                'tarifa': $scope.datosNotaCredito[i].porcentajeimpuesto,
                'monto': subtotal * $scope.datosNotaCredito[i].porcentajeimpuesto,
                'nombreinstitucion': $scope.datosNotaCredito[i].nombreinstitucion,
                'numero_documento': idfactura,
                'montoimpuesto': $scope.datosNotaCredito[i].montoimpuesto,
                'porcentajecompra': 0,
                'montototallinea': montototallinea,
                'iddetalle': iddetalle
              });
            }else{}
          }

      console.log("lista: ",listaCampos);
      var data= {datos: JSON.stringify(listaCampos)}

      insertarFila(data, '/insertar_ordenes_nota').then(data => {
         resolve(data)
      })
      .catch(err => {
        reject(err);
      })
    })
  }

  let cuerpoFactura= (iddetalle,tipo) => {

    return new Promise((resolve,reject) => {


    var estado=''
    var impuestos=0;
    var tipo_nota='';
    $scope.impuestos=0;
      let pago='';

      if($scope.formapago == 'Efectivo'){
        pago='01';
      }else{
        pago='02';
      }

      if(String(tipo) === '1') tipo_nota= 'NC';
      else tipo_nota= 'ND';

        for (var i = 0; i < $scope.ordersElementsModal.length; i++) {
           $scope.impuestos+=parseFloat($scope.ordersElementsModal[i].montoimpuesto)

        }

    if($scope.dataSelected.estadofactura == "Activa") { estado= 1}
      $scope.dataFacturaNota={

          idcuenta: $scope.dataSelected.idcuenta,
          idempleado: $scope.dataSelected.idempleado,
          idperiodo: $scope.dataSelected.idperiodoventa,
          formapago: $scope.formapago,
          subtotal:   $scope.subTotalPagar,
          porcentajedescuento: $scope.dataSelected.porcentajedescuento,
          cantidadpersonas: $scope.dataSelected.cantidadpersonas,
          estado: estado,
          codigomoneda: 'CRC',
          tipoCambio: $("#tipoCambioNota").val(),
          totalservgravados: 0,
          totalservexentos: 0,
          total_merc_gravada: 0,
          total_merc_exenta: Number($scope.totalPagar),
          total_gravados: 0,
          total_exentos: Number(0 + $scope.totalPagar),
          total_ventas:  Number(0 + $scope.totalPagar),
          total_descuentos: Number($scope.totalDescuento),
          total_ventas_neta: Number(0 + $scope.totalPagar) - Number($scope.totalDescuento).toFixed(2),
          total_impuestos:  $scope.impuestos,
          total_comprobante: (Number(0 + $scope.totalPagar) - Number($scope.totalDescuento).toFixed(2)) +  $scope.impuestos,
          idreceptor: $scope.dataSelected.idreceptor,
          idemisor: $scope.dataSelected.idemisor,
          receptor_numero: $scope.dataSelected.receptor_numero,
          tipo: tipo_nota,
          clave: $scope.claveNumericaReferencia,
          consecutivo: $scope.consecutivo_nota,
          medio_pago: pago,
          condicion_venta: $scope.dataSelected.condicion_venta,
          plazo_credito: 0,
          num_documento: $scope.num_documento,
          referencia: $scope.factura.referencia_nota_credito.id,
          razon_nota: $scope.factura_nc.razon,
          tipoComprobante: $("#tipo_nota").val(),
          iddetalle: iddetalle

      }

      console.log($scope.dataFacturaNota)

      insertarFila($scope.dataFacturaNota, '/insertar_nota').then(data => {

        resolve(data)
      })
      .catch(err => {
        reject(err);
      })
    })
  }

  $scope.reporte_excel1 = function () {
    /* Metodo para descargar el tipo de reporte1.
    https:// stackoverflow.com/questions/36931521/how-to-download-binary-file-in-angular-js-using-http
    https:// ramirezmery.wordpress.com/2016/04/17/angularjs-download-file-with-http-and-web-api/ */
    //#FFFFFF


    $http({
      method: 'GET',
      url: '/Excel1',
      responseType: 'arraybuffer'
    }).then(function (file) {
      $log.info(file)
      var ieEDGE = navigator.userAgent.match(/Edge/g)
      var ie = navigator.userAgent.match(/.NET/g) // IE 11+
      var oldIE = navigator.userAgent.match(/MSIE/g)
      var filename = 'Reporte_Facturas:' + '.xlsx'

      var blob = new window.Blob([file.data], { type: 'application/vnd.openxmlformats' })

      if (ie || oldIE || ieEDGE) {
        // 'Internet Explorer'
        window.navigator.msSaveBlob(blob, filename)
      } else {
        var file = new Blob([file.data], {
          type: 'application/vnd.openxmlformats'
        })
        var fileURL = URL.createObjectURL(file)
        var a = document.createElement('a')
        a.href = fileURL
        a.target = '_blank'
        a.download = filename
        document.body.appendChild(a)
        a.click()
      }
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.imprimir_cuenta = function () {
    return createFactura_promise($scope, $http, $log).then(function (data) {
      insert($scope, $http, $log, '/imprimirFactura', data)
    }).catch(function (error) {
      $log.error(error)
    })
  }

  function createFactura_promise ($scope, $http, $log) {
    $scope.bill2 = $scope.ordersElements
    // var descuentoAplicado = $scope.totalMenosDescuento * $scope.porcentajeDescuento / 100;
    $scope.subTotalPagar = 0 * 1
    $scope.totalDescuento = 0 * 1
    console.log('orderElements')
    console.dir($scope.ordersElements)
    for (var i = 0; i < $scope.ordersElements.length; i++) {
      // $scope.idEmpleado = $scope.ordersElements[i].idEmpleado;
      $scope.subTotalPagar += $scope.ordersElements[i].subtotal * 1
      $scope.totalDescuento += $scope.ordersElements[i].subtotal * $scope.ordersElements[i].porcentajedescuento / 100
      // $scope.totalDescuento += $scope.ordersElements[i].subtotal * descuentoAplicado/ 100;
    }

    $scope.totalPagar = $scope.subTotalPagar - $scope.totalDescuento
    if (typeof $scope.idEmpleado === 'undefined') {
      alert('Regargue la vista de Ventas. idEmpleado no ha sido definido')
      $window.location.href = '/sopa#!/restaurante'
    } else {
      var data = {
        idCuenta: $scope.idCuenta,
        // nombreCliente: $scope.nombreCliente,
        bill: $scope.bill2,
        idEmpleado: $scope.idEmpleado,
        descuento: $scope.totalDescuento,
        totalMenosDescuento: $scope.totalPagar,
        subtotal: $scope.subTotalPagar,
        idFactura: $scope.idFactura,
        fechaFactura: $scope.fecha
      }
    }
    return new Promise(function (resolve, reject) {
      if (typeof data === 'undefined') {
        reject('data is: ' + data)
      } else {
        resolve(data)
      }
    })
  }

  $scope.sendDataLoad = function (idFactura, idCuenta, nombre, periodo, formaPago, cantidadPersonas, subTotal, porcentajeDescuento, fecha) {
    $scope.idFactura = idFactura
    $scope.idCuenta = idCuenta

    $scope.nombreEmpleado = nombre
    $scope.periodo = periodo
    $scope.formapago = formaPago
    $('#txtFormaPago').val($scope.formapago)
    $scope.fecha = fecha
    $scope.subTotalPagar = subTotal
    $scope.porcentajeDescuento = porcentajeDescuento

    $scope.totalDescuento = $scope.subTotalPagar * $scope.porcentajeDescuento / 100
    $scope.totalPagar = $scope.subTotalPagar - $scope.totalDescuento

    $scope.montoPorPersona = $scope.totalPagar / cantidadPersonas

    var data = {idFactura: idFactura}

    $http({
      method: 'GET',
      url: '/getOrdersCanceledBill',
      params: data
    }).then(function (response) {
      $scope.ordersAccounts = response.data
      $scope.ordersElements = []
      console.log("ordenes ",$scope.ordersAccounts)
      for (var i = 0; i < $scope.ordersAccounts.length; i++) {
        if (!estaProductoCuenta($scope.ordersAccounts[i])) {
          $scope.ordersElements.push($scope.ordersAccounts[i])
        }
      }

      function estaProductoCuenta (producto) {
        for (var j = 0; j < $scope.ordersElements.length; j++) {
          // $scope.elements[j].cantidad = 0*1;
          if (producto.descripcionproducto === $scope.ordersElements[j].descripcionproducto) {
            $scope.ordersElements[j].cantidadproducto = ($scope.ordersElements[j].cantidadproducto * 1) + (producto.cantidadproducto * 1)
            $scope.ordersElements[j].subtotal = ($scope.ordersElements[j].subtotal * 1) + (producto.subtotal * 1)
            return true
          }
        }
        return false
      }
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.tipoFactura=function(numero){

       $("#tipoFactura").val(numero);
  }
  //-----------------------------------------------------
    $scope.sendDataLoadModalFactura = function (facturaSelected) {


      if(Number($("#tipoFactura").val()) == 1){
        if(typeof facturaSelected === "undefined"){
          alert("Seleccione una factura")
          return;
        }else{
          $("#tipo_nota").val("03");
          $('#nota-credito-modal').modal('show')
        }
      }else{
        if(typeof facturaSelected === "undefined"){
          alert("Seleccione una factura")
          return;
        }else{
          $("#tipo_nota").val("03");
          $('#nota-debito-modal').modal('show')
        }
      }

      console.log($("#tipo_nota").val())
      var f= new Date()
     var getDia = function() {
  // pending to test in a date from 1 - 9
        var today = new Date()
        return ('0' + (today.getDate())).slice(-2)
      }

      var getMes = function() {
        var today = new Date()
        return ('0' + (today.getMonth() + 1)).slice(-2)
      }

      var getYear = function() {
        var today = new Date()
        return ('0' + (today.getYear())).slice(-2)
      }

      $scope.dataSelected=facturaSelected;

    for (var i = 0; i < facturaSelected.clavenumerica.length; i++) {
     if(i == 30){
        var clave_parte1=facturaSelected.clavenumerica.substring(0,30);
        var clave_parte2= facturaSelected.clavenumerica.substring(31,facturaSelected.clavenumerica.length);
        var tipo_comprobante= '1';
        var nueva_clave=clave_parte1+tipo_comprobante+clave_parte2;
      }
    }

   var consecutivo= facturaSelected.consecutivo;


   for (var i = 0; i < consecutivo.length; i++) {
     var p1_c= consecutivo.substring(0,9);
     var p2_c= consecutivo.substring(10,consecutivo.length);
   }
   consecutivo=p1_c+tipo_comprobante+p2_c;


    $scope. num_documento=Number( $scope.dataSelected.id) + 1;
    var idFactura = facturaSelected.idfactura
    $scope.idFactura= facturaSelected.idfactura
    $scope.idCuenta = facturaSelected.idcuenta
    $scope.consecutivo_nota= consecutivo
    $scope.claveNumericaReferencia= nueva_clave
    $scope.nombreEmpleado = facturaSelected.nombre
    $scope.periodo = facturaSelected.periodo
    $scope.formapago = facturaSelected.formapago
    console.log("forma de pago ",facturaSelected.formapago)

    if(Number(facturaSelected.formapago) == 1){
      console.log("Efectivo");
      $scope.formapago= 'Efectivo';
    }else{
      console.log("Tarjeta");

      $scope.formapago='Tarjeta';
    }
   //document.getElementById('txtFormaPagoNotaCredito').selectedIndex=idpago;
    $scope.fecha = facturaSelected.fecha
    //$scope.subTotalPagar = facturaSelected.subtotal
    $scope.subTotalPagar=0;
    $scope.porcentajeDescuento = facturaSelected.porcentajedescuento

    //$scope.totalPagar = $scope.subTotalPagar - $scope.totalDescuento

    //$scope.montoPorPersona = $scope.totalPagar / facturaSelected.cantidadpersonas

    var data = {idFactura: facturaSelected.idfactura}
    console.log
    $http({
      method: 'GET',
      url: '/getOrdersCanceledBill/nota',
      params: data
    }).then(function (response) {
      $scope.ordersAccountsModal = response.data
      $scope.ordersElementsModal = []
      $scope.cantidad_idorden= {};
      console.log("ordenes ",$scope.ordersAccountsModal)

      for (var i = 0; i < $scope.ordersAccountsModal.length; i++) {
          console.log("subtotal ",$scope.ordersAccountsModal[i].get_orders_per_factura.subtotal)
        if (!estaProductoCuenta($scope.ordersAccountsModal[i].get_orders_per_factura)) {
          $scope.ordersElementsModal.push($scope.ordersAccountsModal[i].get_orders_per_factura)
          $scope.cantidad_idorden[i]= {"id": $scope.ordersAccountsModal[i].get_orders_per_factura.idorden,
            "cantidad": $scope.ordersAccountsModal[i].get_orders_per_factura.cantidadproducto,
            "precio" : $scope.ordersAccountsModal[i].get_orders_per_factura.preciounitarioproducto};

            $scope.subTotalPagar += Number($scope.ordersAccountsModal[i].get_orders_per_factura.subtotal)
            $scope.totalDescuento = $scope.subTotalPagar * $scope.porcentajeDescuento / 100
            $scope.totalPagar = $scope.subTotalPagar - $scope.totalDescuento
            $scope.montoPorPersona = $scope.totalPagar / facturaSelected.cantidadpersonas

        }
        if( $scope.ordersElementsModal[i].descuentoorden === undefined){
          $scope.ordersElementsModal[i].descuentoorden=0;
        }
        console.log(" descuento en posicion "+i+" :",$scope.ordersElementsModal[i].descuentoorden)
      }
      console.log("array linea ",$scope.cantidad_idorden)
      function estaProductoCuenta (producto) {
        for (var j = 0; j < $scope.ordersElementsModal.length; j++) {
          // $scope.elements[j].cantidad = 0*1;
          if (producto.descripcionproducto === $scope.ordersElementsModal[j].descripcionproducto) {
            $scope.ordersElementsModal[j].cantidadproducto = ($scope.ordersElementsModal[j].cantidadproducto * 1) + (producto.cantidadproducto * 1)
            $scope.ordersElementsModal[j].subtotal = ($scope.ordersElementsModal[j].subtotal * 1) + (producto.subtotal * 1)
            return true
          }
        }
        return false
      }
      console.log($scope.ordersElementsModal)
    }).catch(function (error) {
      $log.error(error)
    })
  }
  //----------------------------------------------------

    $scope.showPDFbill = function (idFactura) {
    //$scope.idFactura = idFactura
    let data = {idFactura: idFactura}
    console.log("showing Factura with id: " + idFactura + " \n + data: ")
    //console.dir(data)
    $http({
      method: 'GET',
      url: '/getOrdersCancelledBill_forPDF',
      params: data
    }).then(function (response){
      //console.log(response)
      $scope.responsePDF = response.data
      $scope.responsePDF[0].fecharegistrofacturaFormat = new Date($scope.responsePDF[0].fecharegistrofactura).toLocaleString();
      $scope.idFactura = idFactura
      $scope.normativa = normativa
      if ($scope.responsePDF.length == 1) {
        console.log("$scope.responsePDF")
        console.dir($scope.responsePDF)
        //pending
            $http({
            method: 'GET',
            url: '/getOrdersCanceledBill',
            params: data
          }).then(function (responseBody){
            //console.log(response)
            $scope.responsePDF_Body = responseBody.data
            console.log('responsePDF_Body')
            console.dir($scope.responsePDF_Body)


           }).catch(function(error){
            $log.error(error)
          })
      } else {
        $log.error("getOrdersCancelledBill_forPDF is returning multiple rows for one idFactura: " + $scope.responsePDF)
      }
     }).catch(function(error){
      $log.error(error)
    })
  }
   $scope.imprimir_pdf = function (idFactura) {

    console.log('imprimir_pdf() receiving: ' + idFactura)

    source1 = document.querySelector('#pdfHeader1');
    source2 = document.querySelector('#pdfHeader2');
    source3 = document.querySelector('#pdfBody1');
    table1 = document.querySelector('#pdfTable');

    source1.height = parseInt(window.getComputedStyle(source1).height, 10)
    source2.height = parseInt(window.getComputedStyle(source2).height, 10)
    source3.height = parseInt(window.getComputedStyle(source3).height, 10)
    table1.height = parseInt(window.getComputedStyle(table1).height, 10)

    console.log("height1: " + window.getComputedStyle(source1).height)
    console.log("height2: " + window.getComputedStyle(source2).height)
    console.log("height3: " + window.getComputedStyle(source3).height)
    console.log("table1 height: " + window.getComputedStyle(table1).height)

    pageHeight = source1.height+source2.height+source3.height
    if (pageHeight < table1.height) {
      pageHeight = table1.height
      console.log("table1.height: " + table1.height + " is bigger than the rest of sections")
    }

    pageHeight = pageHeight
    // Thermal Printer 80mm = 302 px

    let doc = new jsPDF({
      orientation: 'portrait',
      unit: 'px',
      format: [302,pageHeight]
    })

    margins = {
      top: 17,
      bottom: 20,
      left: 6,
      width: 522
    };

    //doc.text(margins.left,margins.top,"--------------------------------------------------------------")

    margins1 = {
      top: margins.bottom,
      bottom: margins.bottom+source1.height,
      left: 6,
      width: 522
    };

    margins2 = {
      top: source1.height-40, //reduce gaps
      bottom: margins.bottom+source1.height+source2.height-140,
      left: 6,
      width: 522
    };

    margins3 = {
      top: source1.height+source2.height+table1.height-340,
      bottom: margins.bottom+source1.height+source2.height+source3.height-340,
      left: 6,
      width: 522
    };

    doc.setFont('COURIER')
    doc.setFontSize(9)

    //doc.text(3, 6, "Hello World")


    //doc.addPage();
    //doc.text(margins.left,margins.top,"--------------------------------------------------------------")



    specialElementHandlers = {
        // element with id of "bypass" - jQuery style selector
        '#bypassme': function (element, renderer) {
            // true = "handled elsewhere, bypass text extraction"
            return true
        }
    };


    //document.querySelector('#pdf-bill'),
    /*
    doc.fromHTML(
      source1,
      margins1.left,
      margins1.top,
      {
        'width': margins1.width, // max width of content on PDF
        'elementHandlers': specialElementHandlers
      }
    )

    doc.fromHTML(
      source2,
      margins2.left,
      margins2.top,
      {
        'width': margins2.width, // max width of content on PDF
        'elementHandlers': specialElementHandlers
      }
    )

    doc.autoTable({
      html:'#pdfTable',
      startY: margins2.bottom
    })

    doc.fromHTML(
      source3,
      margins3.left,
      margins3.top,
      {
        'width': margins3.width, // max width of content on PDF
        'elementHandlers': specialElementHandlers
      }
    )
    */

    doc.fromHTML(
      document.querySelector('#pdfGroup1'),
      20,
      6,
      {
        'width': 290, // max width of content on PDF
        'elementHandlers': specialElementHandlers
      }
    )

    doc.addPage();

    doc.autoTable({
      html:'#pdfTable',
      startY: 19
    })

    doc.save('Factura_'+idFactura)
  }


  //----------------------------------------------------


  $scope.refreshCuenta()

  $scope.deleteBill = function () {
    console.log($scope.idFactura)
    $('#delete-bill-modal').modal('show')
    $('#txtIdFacturaDelete').val('La factura: ' + $scope.idFactura)
  }

  $scope.sort = function (keyname) {
    $scope.sortKey = keyname // set the sortKey to the param passed
    $scope.reverse = !$scope.reverse // if true make it false and vice versa
  }
}).controller('emisorController', function ($scope, $http, $log) {

  $http({
    method: 'GET',
    url: '/location/provincia'
  }).then(function (response) {
    $scope.provincias = response.data

  }, function errorCallback (response) {
    $log.error(response)
  }).catch(function (error) {
    $log.error(error)
  })

  $scope.cargarCanton = function (emisor) {
    $("#id_canton_emisor").css("display","block")
    var data = {codigo_provincia: emisor.ubicacion_provincia.codigo_provincia}
    console.log(data)
    $http({
      method: 'GET',
      url: '/location/canton',
      params: data
    }).then(function (response) {
      $scope.cantones = response.data
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.cargarDistrito = function (emisor) {
    $("#id_distrito_emisor").css("display","block")

     var data = {codigo_provincia: document.getElementById("provincia").selectedIndex,
                codigo_canton:   emisor.ubicacion_canton.id
              }
    $http({
      method: 'GET',
      url: '/location/distrito',
      params: data
    }).then(function (response) {
      $scope.distritos = response.data
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.tipoIds = {
    '1': {
      id: '01',
      name: 'Fisica',
      cero: '000'
    },
    '2': {
      id: '02',
      name: 'Juridica',
      cero: '00'
    },
    '3': {
      id: '03',
      name: 'DIMEX',
      cero: '0'
    },
    '4': {
      id: '04',
      name: 'NITE',
      cero: '00'
    }
  }

   /* $scope.tipoCodigo = {
    '1': {
      codigo: '01',
      tipo: 'Código del producto del vendedor'
    },
    '2': {
      codigo: '02',
      tipo: 'Código del producto del comprador'
    },
    '3': {
      codigo: '03',
      tipo: 'Código del producto asignado por la industria'
    },
    '4': {
      codigo: '04',
      tipo: 'Código de uso interno'
    },
    '5': {
      codigo: '99',
      tipo: 'Otros'
    }
  }*/

  $scope.datos = [{
      nombre: "01",
      valor: "Código del producto del vendedor"
      }, {
      nombre: "02",
      valor: "Código del producto del comprador"
      }, {
      nombre: "03",
      valor: "Código del producto asignado por la industria"
      }, {
      nombre: "04",
      valor: "Código de uso interno"
      },{
      nombre: "99",
      valor: "Otros"
    }]


  console.log($scope.datos)
  $scope.asignarIdEmisor = function (emisor) {
    $('#identificacion_tipo_id').val(emisor.identificacion_tipo.cero)
    $('.identificacion_numero').val('')
  }


 $scope.cargarEmisor=function(){
      $http.get('/getEmisor').then(function success(response){
                    // Update Model-- Line
                    console.log(response.data.length)
              if(response.data.length > 0){
              var numero_emisor=response.data[0].emisor_numero;
              var contador=0;
                for (var i = 0; i < numero_emisor.length; i++) {
                  if(i < 3){
                    if(numero_emisor[i] == "0"){
                      contador++;
                     }
                  }
                }

                numero_emisor= numero_emisor.substring(contador, numero_emisor.length);
                $scope.password=response.data[0].password_email;
                console.log(numero_emisor)
                console.log(" provincia ",response.data[0].e_provincia)
                 $("#casamatriz").val(response.data[0].casamatriz)
                $("#puntoventa").val(response.data[0].puntoventa)
                $("#identificacion_tipo_producto").val(response.data[0].tipo_producto)
                $("#nombre_emisor").val(response.data[0].e_nombre)
                $("#tipo_id_emisor").val(response.data[0].emisor_tipo_identificacion)
                $(".identificacion_numero_emisor").val(numero_emisor)
                $("#email_emisor").val(response.data[0].e_correoelectronico)
                $("#provincia").val(response.data[0].e_provincia)
                //$("#canton").val(response.data[0].e_canton)
                //$("#distrito").val(response.data[0].e_distrito)
                $("#otras_senas_emisor").val(response.data[0].e_otras_senas)
                $("#tel_cod_emisor").val(response.data[0].emisor_telefono_codigopais)
                $("#tel_num_emisor").val(response.data[0].emisor_telefono_numtelefono)
                $("#fax_cod_emisor").val(response.data[0].emisor_fax_codigopais)
                $("#fax_tel_emisor").val(response.data[0].emisor_fax_numtelefono)
                $("#nombre_comercial_emisor").val(response.data[0].e_nombrecomercial)
                //$("#normativa").val(response.data[0].normativa)

                    if ( String($("#tipo_id_emisor").val()) === '01') {
                      $('#identificacion_tipo_id_emisor').val('000')

                    } else if ( String($("#tipo_id_emisor").val()) === '02') {
                      $('#identificacion_tipo_id_emisor').val('00')

                    } else if ( String($("#tipo_id_emisor").val()) === '03') {
                      $('#identificacion_tipo_id_emisor').val('0')

                    } else {
                      $('#identificacion_tipo_id_emisor').val('00')

                    }

                        $scope.cantonEmisor=response.data[0].e_canton;
                        $scope.distritoEmisor=response.data[0].e_distrito
                        console.log($scope.cantonEmisor)
                        console.log($scope.distritoEmisor);
                        console.log(response.data[0].e_provincia);
            }else{
              alert("Configure la información del emisor");
            }
            //var normativa="Autorizado mediante resolucion DGT-R-48-2016 del 07/10/2016";
                      $("#normativa").val(normativa)
      },
              function error(err){
                console.log(err);
                alert("Se ha producido un error al cargar la información del emisor")
      });

  }
  //------------------------------------------------------------------

    $scope.validateId = function (emisor) {
    var contador=0;
    var id = String($('#identificacion_numero_emisor').val())
    var tipoId = String($("#identificacion_tipo_id_emisor").val())
    console.log("tamaño ",id.length)
    console.log("tipo ",tipoId)

    if (tipoId === '000') {
      if (id.length != 9) {
        console.log("diferente de 9")
        contador++;
        if(contador == 1){
        if(!$.trim($("mensajeEmisor").html())){
            $("#mensajeEmisor").html("Debe contener 9 dígitos");
         }
        return false;
       }
      }else{
        $("#mensajeEmisor").html("");
        return true;
      }
    }

     if (tipoId === '00') {

      if (id.length != 10) {
        console.log("diferente de 10")
        if(!$.trim($("mensajeEmisor").html())){
            $("#mensajeEmisor").html("Debe contener 10 dígitos");
         }
        return false;
      }else{
        $("#mensajeEmisor").html("");
        return true
      }
    }

    if (tipoId === '0') {

      if (id.length < 11) {
                console.log("menor a 11")
         if(!$.trim($("mensajeEmisor").html())){
            $("#mensajeEmisor").html("Debe contener mínimo 11 dígitos");
         }
        return false;
      }else{
        $("#mensajeEmisor").html("");
        return true
      }
    }

  }

  //----------------------------------------------------------------
  $scope.emisorUpdate = function (canton,distrito) {
    console.log("canton ",canton)
    console.log("distrito ",distrito)
    let cadena3 = String($("#tipo_id_emisor").val())
    let cadena1 = String($("#identificacion_tipo_id_emisor").val())
    let cadena2 = String($("#identificacion_numero_emisor").val())
    let codigo_producto= document.getElementById('identificacion_tipo_producto')
    codigo_producto= codigo_producto.options[codigo_producto.selectedIndex].innerText;
    console.log(codigo_producto)
    let codigo_pais='';
    let num_telefono='';
    let fax_codigopais='';
    let fax_num_telefono='';
    var new_emisor_numero='';
    let password='';
    if(cadena2.length == 12){
      console.log("valor de 12 digitos")

      new_emisor_numero=cadena2
      console.log(new_emisor_numero)
    }else{
      new_emisor_numero= cadena1 + cadena2;
      console.log(new_emisor_numero)
    }

    if($("#tel_cod_emisor").val()==""){
      codigo_pais=0;
    }else{
      codigo_pais=$("#tel_cod_emisor").val();
    }
    if($("#tel_num_emisor").val() == ""){
      num_telefono=0
    }else{
      num_telefono=$("#tel_num_emisor").val();
    }

    if($("#fax_cod_emisor").val() == ""){
      fax_codigopais=0;
    }else{
      fax_codigopais=$("#fax_cod_emisor").val();
    }
    if($("#fax_tel_emisor").val() == ""){
      fax_num_telefono=0;
    }else{
      fax_num_telefono=$("#fax_tel_emisor").val();
    }

    if($("#pass_emisor").val() == ""){
        password= $scope.password;
    }else{
        password = $("#pass_emisor").val();
    }

    var data = {
      nombre: $("#nombre_emisor").val(),
      emisor_tipo_identificacion: cadena3,
      nombrecomercial:$("#nombre_comercial_emisor").val(),
      provincia: Number($("#provincia").val()),
      canton: canton,
      distrito: distrito,
      otras_senas: String($("#otras_senas_emisor").val()),
      emisor_telefono_codigopais: codigo_pais,
      emisor_telefono_numtelefono: num_telefono,
      emisor_fax_codigopais: fax_codigopais,
      emisor_fax_numtelefono: fax_num_telefono,
      correoelectronico: $("#email_emisor").val(),
      password: password,
      emisor_numero: new_emisor_numero,
      casamatriz: String($("#casamatriz").val()),
      puntoventa:String($("#puntoventa").val()),
      tipo_producto: $scope.emisor.identificacion_tipo_producto.nombre,
      codigo_producto: codigo_producto,
      codigo_actividad: $scope.emisor.codigoActividad
    }

    console.log(data);

    updatePromise($scope, $http, $log, '/emisor/update', data)
    limpiarPantallaEmisor()
      $('#id_search').val('')
      $("#id_canton_emisor").css("display","none")
      $("#id_distrito_emisor").css("display","none")

    alert("Actualizado correctamente con: " + JSON.stringify(data, null, 4))

  }

  $scope.validateAndSendEmisor=function(emisor){
    console.dir(emisor)
    if(typeof(emisor.codigoActividad) === 'undefined') {
      $log.error("emisor.codigoActividad is undefined")
      alert("El Codigo de Actividad debe ser seleccioado")
    }
    var canton=0;
    var distrito=0;
    if($("#id_canton_emisor").css("display") == 'none' && $("#id_distrito_emisor").css("display") == 'none'){
        console.log("Cargando campos por defecto de la base de datos...");
           canton = $scope.cantonEmisor
           distrito = $scope.distritoEmisor
           console.log(canton)
           console.log(distrito)
           if($scope.validateId(emisor)) $scope.emisorUpdate(canton,distrito)
           else alert("Hay información con errores")
    }else if($("#id_canton_emisor").css("display") == 'none' || $("#id_distrito_emisor").css("display") == 'none'){
        alert("El campo de canton y el campo de distrito son requeridos");
    }else{
      if($("#id_canton_emisor").css("display") == 'block' || $("#id_distrito_emisor").css("display") == 'block'){
        console.log("Se va escoger una nueva ubicación...");
        canton=String($("#canton").val());
        distrito=String($("#distrito").val());
        if(canton== "" || distrito == ""){
          alert("Debe seleccionar los campos de provincia, cantón y distrito para completa la ubicación");
        }else{
          console.log("Nueva ubicación escogida");
          console.log(canton);
          console.log(distrito);
          if($scope.validateId(emisor)) $scope.emisorUpdate(Number(canton),Number(distrito))
          else alert("Hay información con errores")
        }
      }
    }
  }

  $scope.validateAndSendEmisor2=function(emisor){
    console.dir(emisor)
    if(typeof(emisor.codigoActividad) === 'undefined') {
      $log.error("emisor.codigoActividad is undefined")
      alert("El Codigo de Actividad debe ser seleccioado")
    }
  };

  $scope.cargarId = function (emisor) {
    console.log("tipo ",emisor.identificacion_tipo.id)
    $('#identificacion_numero_emisor').val('')

    if (emisor.identificacion_tipo.id == '01') {
      $('#identificacion_tipo_id_emisor').val('000')
     document.getElementById("mensajeEmisor").innerHTML='';
    } else if (emisor.identificacion_tipo.id == '02') {
      $('#identificacion_tipo_id_emisor').val('00')
     document.getElementById("mensajeEmisor").innerHTML='';
    } else if (emisor.identificacion_tipo.id == '03') {
      $('#identificacion_tipo_id_emisor').val('0')
     document.getElementById("mensajeEmisor").innerHTML='';
    } else {
      $('#identificacion_tipo_id_emisor').val('00')
     document.getElementById("mensajeEmisor").innerHTML='';
    }
  }

   $scope.cargarData=function(){
    var provincia= document.getElementById('provincia');
    if(provincia.selectedIndex != 0){
        var indice=provincia.selectedIndex;
        console.log("Indice ", indice)
        $("#id_canton_emisor").css("display","block")
        var data = {codigo_provincia: indice}
        $http({
          method: 'GET',
          url: '/location/canton',
          params: data
        }).then(function (response) {
          $scope.cantones = response.data
        }).catch(function (error) {
          $log.error(error)
        })
      }
   }

   $scope.loadCodigoActividad = function(){
    $http({
      method: 'GET',
      url: 'https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/actividades_por_codigo.json',
    }).then(function (response) {
      //lost key
      //$scope.codigoActividadList = Object.keys(response.data).map(e => response.data[e]);
      $scope.codigoActividadList = Object.keys(response.data).map(function (key) {
        return { [key]: response.data[key]}
      });
    }).catch(function (error) {
      $log.error(error)
    })
   };

   $scope.selectCodigoActividad = function(codigoActividadSelected){
     $scope.emisor.codigoActividadTemp = codigoActividadSelected;
     alert("Codigo de Actividad Seleccionado: " + codigoActividadSelected);
   };

  $scope.saveCodigoActividad = function(){
    $scope.emisor.codigoActividad = $scope.emisor.codigoActividadTemp;
    $log.info("saveCodigoActividad with: \n $scope.emisor.codigoActividad: " +
                $scope.emisor.codigoActividad + "\n $scope.emisor.codigoActividadTemp: " +
                $scope.emisor.codigoActividadTemp);
    hideModal('#select-codigo-actividad-modal')
   };

   $scope.cargarEmisor();
   $scope.loadCodigoActividad();

}).controller('receptorController', function ($scope, $http, $log) {
  var data = {}
  loadData($scope, $http, $log, '/receiver', data)

  $http({
    method: 'GET',
    url: '/location/provincia'
  }).then(function (response) {
    $scope.provincias = response.data
  }, function errorCallback (response) {
    $log.error(response)
  }).catch(function (error) {
    $log.error(error)
  })

   $scope.cargarCantones=function(){
    var provincia= document.getElementById('id_provincia_update');
    if(provincia.selectedIndex != 0){
      var indice=provincia.selectedIndex;
      console.log("Indice ", indice)
      $("#div_canton").css("display","block")
    var data = {codigo_provincia: indice}
    $http({
      method: 'GET',
      url: '/location/canton',
      params: data
    }).then(function (response) {
      $scope.cantones = response.data
    }).catch(function (error) {
      $log.error(error)
    })

    }
   }

  $scope.tipoIds = {
    '1': {
      id: '01',
      name: 'Fisica'
    },
    '2': {
      id: '02',
      name: 'Juridica'
    },
    '3': {
      id: '03',
      name: 'DIMEX'
    },
    '4': {
      id: '04',
      name: 'NITE'
    }
  }


  $scope.validateId = function (receptor) {

    var contador=0;
    var id = String($('#identificacion_numero_Update').val())
    var tipoId = String($('#txt_num_tipoIdentificacion_Update').val())
    console.log("id ",id)
    console.log("tipoId ",tipoId)
    if (tipoId === '000') {
      if (id.length != 9) {
        contador++;
        if(contador == 1){
          if(!$.trim($("mensaje").html())){
            $("#mensaje").html("Debe contener 9 dígitos");
        }
        return false;
       }
      }else{
          $("#mensaje").html("");
        return true;
      }
    }
     if (tipoId === '00') {

      if (id.length != 10) {
          if(!$.trim($("mensaje").html())){
            $("#mensaje").html("Debe contener 10 dígitos");
          }
        return false;
      }else{
        $("#mensaje").html("");
        return true
      }
    }

   if(tipoId === '0'){
    if (id.length < 11) {
         if(!$.trim($("mensaje").html())){
            $("#mensaje").html("Debe contener un mínimo de 11 dígitos");
        }
        return false;
      }else{
        $("#mensaje").html("");
        return true;
      }
    }
  }

    $("#update-receiver-modal").on('hidden.bs.modal', function () {
            limpiarFormReceptorUpdate();
    });

    $('#cancelarInfo').click(function(){
      console.log("modal cerrado")
    })



  $scope.rowClicked = function (receptor) {
    $scope.selectedRow = false
    $scope.person_selected = receptor
    if (typeof receptor.idreceptor !== 'undefined') {
      $scope.selectedRow = receptor.idreceptor
    }else{
      alert("Debe selccionar un receptor")
    }
  }

  $scope.deleteReceptor = function (receptorDelete) {
    var data = { receptor_numero: receptorDelete }
    if (receptorDelete !== null) {
      updatePromise($scope, $http, $log, '/receiver/delete', data)
      alert('Recetor eliminado correctamente')
    } else {
      alert('Accion no valida')
      return
    }
    $scope.clearData()
    $('#delete-receptor-modal').modal('toggle')
  }

     $scope.guardarInformacionReceptor=function(canton,distrito){
      console.log("canton actualizar ",canton)
      console.log("distrito actualizar ",distrito)
        var receptor_numero=String($('#identificacion_numero_Update').val());
        console.log(receptor_numero)
        var contador=0;
        var new_receptor='';

      if(receptor_numero.length >= 12){
        new_receptor=receptor_numero;
      }else{
         new_receptor= String($("#txt_num_tipoIdentificacion_Update").val() + receptor_numero);
      }


      let nombrecomercial='';
      let codigo_pais='';
      let num_telefono='';
      let fax_codigopais='';
      let fax_num_telefono='';
      let otras_senas='';
      let new_canton='';
      let new_distrito='';

      if($("#nombreComercial_Update").val() == "") nombrecomercial=''; else nombrecomercial=$("#nombreComercial_Update").val();
      if($("#cod_telefono_Update").val() == "") codigo_pais=0; else codigo_pais=$("#cod_telefono_Update").val();
      if($("#telefono_numero_Update").val() == "") num_telefono=0; else num_telefono=$("#telefono_numero_Update").val();
      if($("#fax_codigoPais_Update").val() == "") fax_codigopais=0; else fax_codigopais=$("#fax_codigoPais_Update").val();
      if($("#fax_numero_Update").val() == "") fax_num_telefono=0; else fax_num_telefono=$("#fax_numero_Update").val();
      if($("#otras_senas_Update").val() == "") otras_senas=''; else otras_senas=$("#otras_senas_Update").val();
      if(canton < 10) new_canton = '0'+String(canton); else new_canton= canton;
      if(distrito < 10 ) new_distrito = '0'+String(distrito); else new_distrito= distrito;
      console.log("nuevo canton ", new_canton)
      console.log("nuevo distrito ", new_distrito)
      console.log(" numero receptor ",new_receptor)
      var data = {
        nombre: $('#nombre_Update').val(),
        receptor_tipo_identificacion: $('#tipo_id_Update').val(),
        nombrecomercial: nombrecomercial,
        provincia: String($('#id_provincia_update').val()),
        canton: new_canton,
        distrito: new_distrito,
        otras_senas: otras_senas,
        receptor_telefono_codigopais: codigo_pais,
        receptor_telefono_numtelefono: num_telefono,
        receptor_fax_codigopais: fax_codigopais,
        receptor_fax_numtelefono:fax_num_telefono,
        correoelectronico: $('#email_Update').val(),
        receptor_numero: String(new_receptor)
      }

      var info={
        'obj': data
      }
      updatePromise($scope, $http, $log, '/receiver/update', data)
      hideModal('#update-receiver-modal')
      console.log(info)
      limpiarFormReceptorUpdate();
      alert("Receptor actualizado correctamente ");
      $("#div_canton").css("display", "none");
      $("#div_distrito").css("display", "none");
  }

  $scope.receptorUpdate_u = function (receptor) {
    console.log("receptor ",receptor.ubicacion_canton)
    console.log("longitud ",$('#div_canton').length)
    console.log(String($("#txt_num_tipoIdentificacion_Update").val()+$('#identificacion_numero_Update').val()))
    var combo = $('#tipo_id_Update').val()
    var provincia = $('#id_provincia_update').val()
    var canton =0;
    var distrito = 0;
    console.log(combo)
    if ($('#nombre_Update').val() === '' || combo == null || $('#identificacion_numero_Update').val() === ''
      || $('#email_Update').val() === ''
      || provincia == null
      ){
      console.log(combo)
      alert('Debe llenar los campos requeridos')

      } else {
        if($("#div_canton").css("display")=='none' && $("#div_distrito").css("display") == 'none'){
        console.log("canton y distrito vacios")
        canton= $scope.cantonEscogido;
        distrito=$scope.distritoEscogido;
        console.log(combo)
        console.log(canton);
        console.log(distrito);
        $scope.guardarInformacionReceptor(canton,distrito);
      }

      else{

         if($("#div_canton").css("display") == 'none' || $("#div_distrito").css("display") == 'none'){
        console.log("un campo viene vacio")

        alert("Debe seleccionar los datos de provincia, cantón y distrito para completar la ubicación")
      }
     else{
      if($("#div_canton").css("display")== 'block' || $("#div_distrito").css("display")== 'block'
        || ($("#div_canton").css("display") == 'block' && $("#div_distrito").css("display") == 'block')){
        console.log("canton y distrito visibles")
         canton=String($("#id_canton_update").val())
         console.log("canton 1",canton)
         distrito=String($("#id_distrito_update").val())
         console.log("distrito 1",distrito)
        if( canton === "" ||  distrito === 'null'){
          alert("Debe seleccionar los datos de provincia, cantón y distrito para completar la ubicación")
        }else{
              console.log("canton ",canton)
              for (var i = 0; i < $scope.cantonUpdate.length; i++) {
              if(canton == $scope.cantonUpdate[i].id){
                console.log("igual")
                canton=$scope.cantonUpdate[i].codigo_canton
                console.log("codigo canton ",canton)
              }
            }

        distrito= Number($("#id_distrito_update").val());

        console.log("nuevo canton ",canton);
        console.log("nuevo distrito ",distrito)
//https://facturaelectronica.smartstrategyapps.com/Panel/FacturasRecibidas.aspx
       $scope.guardarInformacionReceptor(canton,distrito);
          }
        }
      }
    }

    }
  }



  $scope.actualizarReceptor=function(receptor){
    if(!$scope.validateId(receptor))
     alert("Hay datos erroneos en algunos campos");
    else
     $scope.receptorUpdate_u(receptor);
  }

  $scope.cargarId = function (receptor) {
    console.log(receptor.tipo_identificacion_Update.id)
    $('#identificacion_numero_Update').val('')
    if (receptor.tipo_identificacion_Update.id === '01') {
      $('#txt_num_tipoIdentificacion_Update').val('000')
      document.getElementById("mensaje").innerHTML='';
    } else if (receptor.tipo_identificacion_Update.id === '02') {
      $('#txt_num_tipoIdentificacion_Update').val('00')
      document.getElementById("mensaje").innerHTML='';
    } else if (receptor.tipo_identificacion_Update.id === '03') {
      $('#txt_num_tipoIdentificacion_Update').val('0')
     document.getElementById("mensaje").innerHTML='';
    } else {
      $('#txt_num_tipoIdentificacion_Update').val('00')
      document.getElementById("mensaje").innerHTML='';
    }
  }

  $scope.cargarCanton = function (receptor) {



    $("#div_canton").css("display", "block");
    var data = {codigo_provincia: receptor.ubicacion_provincia.codigo_provincia}
    $http({
      method: 'GET',
      url: '/location/canton',
      params: data
    }).then(function (response) {
      $scope.cantonUpdate = response.data
    }).catch(function (error) {
      $log.error(error)
    })
  }




  $scope.cargarDistrito = function (receptor) {
    $("#div_distrito").css("display", "block");
     var data = {codigo_provincia: document.getElementById('id_provincia_update').selectedIndex,
                codigo_canton:   receptor.ubicacion_canton.id
              }
    $http({
      method: 'GET',
      url: '/location/distrito',
      params: data
    }).then(function (response) {
      $scope.distritoUpdate = response.data
    }).catch(function (error) {
      $log.error(error)
    })
  }

  //----------------------------------------

  $scope.clearData = function (template_Right) {
    $scope.receiver = {}
    scopeId = null
    $log.info('clearData()')
    $log.info($scope.template_Right)
    $scope.refresh($scope.template_Right)
    $scope.person_selected = []
  }

  $scope.sortReceiver = function (keyname) {
    $scope.sortKey = keyname // set the sortKey to the param passed
    $scope.reverse = !$scope.reverse // if true make it false and vice versa
  }

  $(document).ready(function () {
    getReceptoresData($scope, $http, $log)
    validateAlphanumeric()
    validateLetters()
    validateNumbers()
  })

  if (typeof $scope.template_Right === 'undefined') {
    $scope.template_Right = 'proveedores'
    $scope.template_Left = 'proveedores_table'
  }
}).controller('waiterController', function ($scope, $http, $log) {
  /* var data = {}
  loadData($scope, $http, $log, '/waiter_load', data)
  // WAITER BUTTONS
  $scope.saveWaiter = function () {
    var data = {
      nombre: $('#txtNombre').val().trim(),
      apellido: $('#txtApellido').val().trim(),
      identificacion: $('#txtIdentificacion').val().trim(),
      contraseña: $('#txtPassword').val().trim(),
      puesto: $('#cmb_Puesto').val().trim(),
      id: scopeId
    }
    var recontraseña = $('#txtRepassword').val().trim()
    if (scopeId !== null) {
      if (data.contraseña !== recontraseña) {
        alert('las contraseñas no coinciden')
      } else {
        // console.log(data)
        update($scope, $http, $log, '/update_waiter', data)
        scopeId = null
        loadData($scope, $http, $log, '/waiter_load', data)
      }
    } else if (scopeId === null) {
      if (data.contraseña !== recontraseña) {
        alert('las contraseñas no coinciden')
      } else {
        insert($scope, $http, $log, '/create_waiter', data)
        scopeId = null
        loadData($scope, $http, $log, '/waiter_load', data)
      }
    } else {
      alert('Accion no valida')
      return
    }
    $scope.refreshWaiter()
  }

  $scope.refreshWaiter = function () {
    var data = {}
    loadData($scope, $http, $log, '/waiter_load', data)
  }

  $http({
    method: 'GET',
    url: '/job_load'
  }).then(function (response) {
    $scope.jobList = response.data
  }, function errorCallback (response) {
    $log.info(response)
  }).catch(function (error) {
    $log.error(error)
  })

  $scope.sendData = function (id, nombre, apellido, identificacion, puesto) {
    scopeId = id;
    $('#txtNombre').val(nombre)
    $('#txtApellido').val(apellido)
    $('#txtIdentificacion').val(identificacion)
    switch (puesto) {
    case 'Administrador':
      $('#cmb_Puesto').val(1)
      break
    case 'Cajero':
      $('#cmb_Puesto').val(2)
      break
    case 'Mesero':
      $('#cmb_Puesto').val(3)
      break
    }
  }

  $scope.sortWaiter = function (keyname) {
    $scope.sortKey = keyname; // set the sortKey to the param passed
    $scope.reverse = !$scope.reverse; // if true make it false and vice versa
  }

  $(document).ready(function () {
    validateLetters()
    validateNumbers()
  }) */
}).controller('clasificacionController', function ($scope, $http, $log) {

  loadData($scope, $http, $log, '/api/clasificacion/', {})



  let insertarFila = (data, route) =>{
    return new Promise((resolve,reject) => {
        $http({ method: 'POST', url: route, params: data, data: data})
        .then(data => {
        resolve(data);
        }).catch(err =>{
          reject(err);
        })
      })
  }

  let getLinea= (data,route)=> {
  return new Promise((resolve,reject) => {
        $http({ method: 'GET', url: route, params: data})
        .then(data => {
        resolve(data);
        }).catch(err =>{
          reject(err);
        })
      })
  }

  let actualizarLinea= (data,route)=> {
  return new Promise((resolve,reject) => {
        $http({ method: 'PUT', url: route, params: data})
        .then(data => {
        resolve(data);
        }).catch(err =>{
          reject(err);
        })
      })
  }

  /* $scope.arrFromMyObj = Object.keys(tipos).map(function(key) {
    return tipos[key];
  });*/

 /* let cargarLista= () =>{
  getLinea({},'/api/clasificacion/').then(response => {

      let lista=[];
      lista= response.data;
      let tipos= {};

      for(let i in lista){

        tipos[i]={
          'id': lista[i].id,
          'nombre_clasificacion': lista[i].nombre_clasificacion,
          'codigo_impuesto': lista[i].codigo_impuesto,
          'descripcion_impuesto': lista[i].descripcion_impuesto,
        };
      }

      $scope.listaClasficiaciones = Object.keys(tipos).map((key) => {
        return tipos[key];
      });

  })
  .catch(err => {
    console.error(err);
    alert("Error al cargar las clasificaciones de producto");
  })

 }*/
  $scope.clasificacionImpuestos= {};
  let obtenerCategoriaImpuestos = () =>{

    const url ='https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/Nota7_CodigoImpuesto.json';
      fetch(url).then(response => {
        return response.json();
      }).then(datos => {

        let codigo;

        datos.forEach((dato, i) => {

          if(Number(dato.Codigo) < 10){
            codigo = '0'+String(dato.Codigo);
          }else{
            codigo= String(dato.Codigo)
          }

          $scope.clasificacionImpuestos[i]={
            'descripcion': dato.CodigoDelImpuesto,
            'codigo': codigo
          }
        });

        console.log($scope.clasificacionImpuestos);
    })
    .catch(err => console.error(err));
  }


 // cargarLista();
  obtenerCategoriaImpuestos();


/*  $scope.ActualizarArrayClasificaciones = (tipo, array) => {

    if(tipo === "new" && JSON.stringify(array) == '{}'){

        let clasificacion = document.getElementById("descripcionClasificacion");
        let codigo_impuesto =document.getElementById("clasificacion_impuesto");
        let seleccionado = codigo_impuesto.options[codigo_impuesto.selectedIndex].value;
        let text = codigo_impuesto.options[codigo_impuesto.selectedIndex].text;
       // let length= Number(Object.keys($scope.listaClasficiaciones).length);
        let newID;
        let arrayNumeros=[];

        $scope.listaClasficiaciones.forEach((elemento) =>{

         arrayNumeros.push(elemento.id)

        });

         newID = Math.max(...arrayNumeros) + 1;
         console.log("Mayor ",newID);

         $scope.listaClasficiaciones.push({
          id: newID,
          nombre_clasificacion: clasificacion,
          codigo_impuesto: seleccionado,
          descripcion_impuesto: text
        });
          console.log($scope.listaClasficiaciones)
      }else{

        let clasificacion = document.getElementById("descripcionClasificacionActualizar");
        let codigo_impuesto =document.getElementById("clasificacion_impuesto_actualizar");
        let seleccionado = codigo_impuesto.options[codigo_impuesto.selectedIndex].value;
        let text = codigo_impuesto.options[codigo_impuesto.selectedIndex].text;

        let fila= $scope.clasificacionSelected;
        console.log(fila)
        $scope.listaClasficiaciones.forEach(lista => {
          if(lista.id == fila.id){
           console.log("encontrado")
            lista.nombre_clasificacion= clasificacion.value;
            lista.codigo_impuesto= seleccionado;
            lista.descripcion_impuesto=text;
          }
        })
        console.log($scope.listaClasficiaciones);
      }
    }*/

  let validarCamposVacios = (descripcion, impuesto) => {

    let clasificacion = document.getElementById(descripcion);
    let codigo_impuesto =document.getElementById(impuesto);
    let seleccionado = codigo_impuesto.options[codigo_impuesto.selectedIndex].value;

      if(seleccionado === '' || clasificacion.value === ''){
        return false;
      }else{
        return true;
      }

  }
  $scope.insertarClasificacion = (clasificacion) =>{

    let obj = {};

    if(validarCamposVacios("descripcionClasificacion", "clasificacion_impuesto")){

      obj={

        descripcion: clasificacion.descripcion,
        impuesto: clasificacion.impuesto.codigo,
        descr_impuesto: clasificacion.impuesto.descripcion,
      }

      insertarFila(obj, '/api/clasificacion/insert').then( resp =>{

        console.log(resp)
        if(resp.status === 200 ){
         // cargarLista();
   // $scope.ActualizarArrayClasificaciones("new",{});
          $('#clasificacion-modal').modal('hide')


          document.getElementById("descripcionClasificacion").value="";
          document.getElementById("clasificacion_impuesto").selectedIndex=null;
          alert("Insertado correctamente");
          loadData($scope, $http, $log, '/api/clasificacion/', {});



        }
      })
      .catch(err => {
        console.error(err)
      })

    }else{

      alert("Todos los campos son requeridos");

    }
  }

  $scope.cargarDatos = () => {
    if(typeof $scope.clasificacionSelected === "undefined"){
      alert("Debe selecciona una fila para editar la informacion");
    }else{
      console.log($scope.clasificacionSelected.codigo_impuesto);
      $('#actualizar-clasificacion-modal').modal({show:true});

      document.getElementById("descripcionClasificacionActualizar").setAttribute("value", $scope.clasificacionSelected.nombre_clasificacion);

      let comboImpuesto =document.getElementById("clasificacion_impuesto_actualizar");
        for(let i=0; i < comboImpuesto.options.length; i++){
          if(comboImpuesto.options[i].getAttribute("value") === $scope.clasificacionSelected.codigo_impuesto){
            comboImpuesto.options[i].selected=true;
          }
        }
      }
  }


  $scope.editarClasificacion = (clasificacion) => {

       if(validarCamposVacios("descripcionClasificacionActualizar","clasificacion_impuesto_actualizar")){

        let clasificacion = document.getElementById("descripcionClasificacionActualizar").value;
        let codigo_impuesto =document.getElementById("clasificacion_impuesto_actualizar");
        let seleccionado = codigo_impuesto.options[codigo_impuesto.selectedIndex].value;
        let text = codigo_impuesto.options[codigo_impuesto.selectedIndex].text;
        let obj= {
          id: $scope.clasificacionSelected.id,
          descripcion: clasificacion,
          impuesto: seleccionado,
          descr_impuesto: text
        };
        actualizarLinea(obj,'/api/clasificacion/update').then(data => {
          if(data.status === 200){
            $('#actualizar-clasificacion-modal').modal('hide');

            document.getElementById("descripcionClasificacionActualizar").value="";
            document.getElementById("clasificacion_impuesto_actualizar").selectedIndex=null;

            alert("Actualizado correctamente");
            loadData($scope, $http, $log, '/api/clasificacion/', {});
          }
        })
        .catch(err => {
          console.error(err);
        })

    } else alert("Todos los campos son requeridos");
  }

  $scope.rowClicked = function (clasificacion) {
    $scope.clasificacionSelected={};
   $scope.selectedRow = false
   $scope.clasificacionSelected = clasificacion
   if (typeof clasificacion.id !== 'undefined') {
     $scope.selectedRow = clasificacion.id
   }
 }
$scope.clearData = function (template_Right) {
   $scope.receiver = {}
   scopeId = null
   $log.info('clearData()')
   $log.info($scope.template_Right)
   $scope.refresh($scope.template_Right)
   $scope.person_selected = []
 }

 $scope.sortReceiver = function (keyname) {
   $scope.sortKey = keyname // set the sortKey to the param passed
   $scope.reverse = !$scope.reverse // if true make it false and vice versa
 }

 $(document).ready(function () {
   getReceptoresData($scope, $http, $log)
   validateAlphanumeric()
   validateLetters()
   validateNumbers()
 })

 if (typeof $scope.template_Right === 'undefined') {
   $scope.template_Right = 'proveedores'
   $scope.template_Left = 'proveedores_table'
 }




}).controller('comprobantesController', function ($scope, $http, $log) {


  $scope.tipo='1';
  var string='FE';

  var data= {
      tipo: string
  }

  loadData($scope, $http, $log, '/get_comprobantes', data)

  $scope.referencia= {
    '1':{
      id: '01',
      descripcion: 'Anula documento de refencia'
    },

    '2':{
      id: '02',
      descripcion: 'Corrige texto documento de referencia'
    },
    '3':{
      id: '03',
      descripcion: 'Corrige monto'
    },
    '4':{
      id: '04',
      descripcion: 'Referencia a otro documento'
    },
    '5':{
      id: '05',
      descripcion: 'Sustituye comprobante por contingencia'
    },
    '6':{
      id:'06',
      descripcion: 'Otros'
    }
  }


    let insertarFila = (data, route) =>{
       return new Promise((resolve,reject) => {
         $http({ method: 'POST', url: route, params: data, data: data})
         .then(data => {
          resolve(data);
         }).catch(err =>{
           reject(err);
         })
       })
  }

  let getLinea= (data,route)=> {
    return new Promise((resolve,reject) => {
         $http({ method: 'GET', url: route, params: data})
         .then(data => {
          resolve(data);
         }).catch(err =>{
           reject(err);
         })
       })
  }

  let actualizarLinea= (data,route)=> {
    return new Promise((resolve,reject) => {
         $http({ method: 'PUT', url: route, params: data})
         .then(data => {
          resolve(data);
         }).catch(err =>{
           reject(err);
         })
       })
  }

  $scope.llamarFuncion = function(string, tipo){

    var data= {
      tipo: string
    }

     loadData($scope, $http, $log, '/get_comprobantes', data)

     $scope.tipo= String(tipo);
  }


  $scope.loadDataComprobante= function(item){

    
    console.log("item ",item);
    $scope.claveComprobante=item.clavenumerica;
    $scope.consecutivoComprobante=item.consecutivo;
    $scope.empleado= item.empleado;
    $scope.fechaEmisionComprobante= item.fechaemision;
    $scope.idComprobante= item.idfactura;
    $scope.receptorComprobante= item.nombre;
    $scope.porcentajeDescuentoComprobante= item.porcentajedescuento;
    $scope.razonComprobante= item.razon;
    $scope.idreceptor= item.receptor_numero;
    $scope.statusComprobante= item.status;
    $scope.subtotalComprobante= item.subtotal;
    $scope.tipoComprobanteEmitido= item.tipo_comprobante;
    $scope.tipoCambioComprobante= item.tipocambio;
    $scope.descuentoComprobante= item.totaldescuentos;
    $scope.ventaTotalComprobante= item.totalventa;
    $scope.cuenta= item.idcuenta;
    $scope.periodoComprobante= item.pv;
    $scope.porpersona= item.monto_persona;
    $scope.cantidadpersonas= item.cantidadpersonas;
    $scope.razon_nota=item.razon_nota;
    var data= { idFactura: item.idfactura }
    // CARGAR VALORES DEL COMPROBANTE
    //TIṔ: PARA CARGAR UN ARRAY A UNA LISTA QUE SE DESPLIEGA EN UNA TABLA ES MEJOR USAR UNA FUNCION http directamente
    // Y no una funcion personalizada que devuelve una promesa. Aqui es donde fallaba la funcion que carga las
    //ordenes por factura
    $http({ method: 'GET', url: '/getOrdersCanceledBill/nota', params: data})
         .then(data => {

          console.log(data)

          $scope.ordenes=data.data;
          $scope.arrayOrdenesComprobantes=[];

          for (var i = 0; i < $scope.ordenes.length; i++) {

           $scope.arrayOrdenesComprobantes.push($scope.ordenes[i].get_orders_per_factura);

          }

    }).catch(err =>{

           throw new Error(err);
    })
}


}).controller('dashboardController', function ($scope, $http, $log, serviceRestaurant) {
  window.setInterval(function () { actualizaReloj($scope, $http, $log) }, 1000 * 60)

  cargarDashboard($scope, $http, $log)
  cargarPeriodosVentas($scope, $http, $log)
  cargarInventario($scope, $http, $log)
  actualizaReloj($scope, $http, $log)

  $scope.refreshDashboard = function () {
    var data = {}
    loadData($scope, $http, $log, '/dashboard_load', data)
    // var p = []
    cargarDashboard($scope, $http, $log)
    cargarPeriodosVentas($scope, $http, $log)
  }

  $scope.reporte_excel2 = function () {
    /* Metodo para descargar el tipo de reporte2.
    https:// stackoverflow.com/questions/36931521/how-to-download-binary-file-in-angular-js-using-http
    https:// ramirezmery.wordpress.com/2016/04/17/angularjs-download-file-with-http-and-web-api/ */
    $http({
      method: 'GET',
      url: '/Excel2',
      responseType: 'arraybuffer'
    }).then(function (file) {
      $log.info(file)
      var ieEDGE = navigator.userAgent.match(/Edge/g)
      var ie = navigator.userAgent.match(/.NET/g) // IE 11+
      var oldIE = navigator.userAgent.match(/MSIE/g)
      var filename = 'Reporte_Periodos:' + '.xlsx'

      var blob = new window.Blob([file.data], { type: 'application/vnd.openxmlformats' })

      if (ie || oldIE || ieEDGE) {
        // 'Internet Explorer'
        window.navigator.msSaveBlob(blob, filename)
      } else {
        var file = new Blob([file.data], {
          type: 'application/vnd.openxmlformats'
        })
        var fileURL = URL.createObjectURL(file)
        var a = document.createElement('a')
        a.href = fileURL
        a.target = '_blank'
        a.download = filename
        document.body.appendChild(a)
        a.click()
      }
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.reporte_excelDetellePeriodo = function () {
    $http({
      method: 'GET',
      url: '/Excel2/DetallePeriodo',
      responseType: 'arraybuffer'
    }).then(function (file) {
      $log.info(file)
      var ieEDGE = navigator.userAgent.match(/Edge/g)
      var ie = navigator.userAgent.match(/.NET/g) // IE 11+
      var oldIE = navigator.userAgent.match(/MSIE/g)
      var filename = 'Reporte_Detalle_Periodos:' + '.xlsx'

      var blob = new window.Blob([file.data], { type: 'application/vnd.openxmlformats' })

      if (ie || oldIE || ieEDGE) {
        // 'Internet Explorer'
        window.navigator.msSaveBlob(blob, filename)
      } else {
        var file = new Blob([file.data], {
          type: 'application/vnd.openxmlformats'
        })
        var fileURL = URL.createObjectURL(file)
        var a = document.createElement('a')
        a.href = fileURL
        a.target = '_blank'
        a.download = filename
        document.body.appendChild(a)
        a.click()
      }
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.sortDashboard = function (keyname) {
    $scope.sortKey = keyname // set the sortKey to the param passed
    $scope.reverse = !$scope.reverse // if true make it false and vice versa
  }

  $scope.cambioPeriodo = function () {
    var idPeriodoSeleccionado = $('#seleccionarPeriodo').val()
    var data = { idPeriodo: idPeriodoSeleccionado }
    $http({
      method: 'GET',
      url: '/info_periodo_load',
      params: data
    }).then(function (response) {
      $scope.infoPeriodoSeleccionado = response.data
      if ($scope.infoPeriodoSeleccionado.length === 0) {
        $scope.ventasTotal = 0
      } else if ($scope.infoPeriodoSeleccionado.length === 1) {
        $scope.ventasTotal = $scope.infoPeriodoSeleccionado[0].total
      } else {
        $scope.ventasTotal = $scope.infoPeriodoSeleccionado[0].total * 1 + $scope.infoPeriodoSeleccionado[1].total * 1
      }
    }).catch(function (error) {
      $log.error(error)
    })

    $http({
      method: 'GET',
      url: '/getPeriodDetails',
      params: data
    }).then(function (response) {
      $scope.periodoSeleccionadoDetalle = response.data
    }).catch(function (error) {
      $log.error(error)
    })
  }

  function cargarPeriodosVentas ($scope, $http, $log) {
    $http({
      method: 'GET',
      url: '/periodos_venta_load'
    }).then(function (response) {
      $scope.periodosVentas = response.data
    }).catch(function (error) {
      $log.error(error)
    })
  }

  function cargarInventario ($scope, $http, $log) {
    $http({
      method: 'GET',
      url: '/api/inventario/disponible'
    }).then(function (response) {
      $scope.inventarioDisponible = response.data
    }).catch(function (error) {
      $log.error(error)
    })

    $http({
      method: 'GET',
      url: '/api/inventario/consumido'
    }).then(function (response) {
      $scope.inventarioConsumido = response.data
    }).catch(function (error) {
      $log.error(error)
    })

    $http({
      method: 'GET',
      url: '/gastos'
    }).then(function (response) {
      $scope.Gastos = response.data
    }).catch(function (error) {
      $log.error(error)
    })

    getPromise($scope, $http, $log, '/api/total_gasto/get', {}, false).then(function (response) {
      $scope.totalGastos = response[0].total
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.rowClicked = function (periodo) {
    $scope.nombrePeriodo = periodo.nombreperiodo
    $scope.fechaInicioPeriodo = periodo.fecha
    var idPeriodoSeleccionado = periodo.idperiodoventa
    for (var i = 0; i < $scope.object.length; i++) {
      if (idPeriodoSeleccionado === $scope.object[i].idperiodoventa) {
        $scope.mesPeriodo = $scope.object[i].mes
        var infoMes = { mes: $scope.object[i].mes }
        $http({
          method: 'GET',
          url: '/getMonthSales',
          params: infoMes
        }).then(function (response) {
          $scope.acumuladoMes = response.data[0].totalventasmes
        }).catch(function (error) {
          $log.error(error)
        })
      }
    }
  }

  function cargarDashboard ($scope, $http, $log) {
    $http({
      method: 'GET',
      url: '/dashboard_load'
    }).then(function (response) {
      $scope.object = response.data
      for (var i = 0; i < $scope.object.length; i++) {
        $scope.object[i]['fecha_dated'] = new Date($scope.object[i]['fecha_date'])
      }
    }).catch(function (error) {
      $log.error(error)
    })
    $http({
      method: 'GET',
      url: '/getWeekSales'
    }).then(function (response) {
      if (response.data.length === 0) {
        $scope.ventasSemana = 0
      } else {
        $scope.ventasSemana = response.data[0].totalventassemana
      }
    }).catch(function (error) {
      $log.error(error)
    })
  }

  if (typeof $scope.template === 'undefined') { $scope.template = 'Sales' }

  $scope.templateAction = function (key) { $scope.template = key }

  // Script del Reloj
  function actualizaReloj ($scope, $http, $log) {
    cargarPeriodosVentas($scope, $http, $log)
    // Capturamos la Hora, los minutos y los segundos
    var marcacion = new Date()
    var Hora = marcacion.getHours()
    var Minutos = marcacion.getMinutes()
    var Segundos = marcacion.getSeconds()
    if (Hora <= 9) { Hora = '0' + Hora }
    if (Minutos <= 9) { Minutos = '0' + Minutos }
    // if (Segundos <= 9) { Segundos = '0' + Segundos }
    $scope.horaReloj = Hora + ':' + Minutos // + ':' + Segundos
  }
}).controller('reportesController', function($scope, $http, $log)  {
  window.setInterval(function () { actualizaReloj($scope, $http, $log) }, 1000 * 60)
  $scope.datosBusqueda={};
  $scope.copiaArrayRegistros={};
      let insertarFila = (data, route) =>{
        return new Promise((resolve,reject) => {
          $http({ method: 'POST', url: route, params: data, data: data})
          .then(data => {
          resolve(data);
          }).catch(err =>{
            reject(err);
          })
        })  
      } 

    let getLinea= (data,route)=> {
    return new Promise((resolve,reject) => {
          $http({ method: 'GET', url: route, params: data})
          .then(data => {
          resolve(data);
          }).catch(err =>{
            reject(err);
          })
        })
      }

    let actualizarLinea= (data,route)=> {
    return new Promise((resolve,reject) => {
          $http({ method: 'PUT', url: route, params: data})
          .then(data => {
          resolve(data);
          }).catch(err =>{
            reject(err);
          })
        })
      }

      let obtenerNumeros_Emisor_Receptor = function(numero){
        let contador=0;
    
        for(let i=0; i < numero.length; i++){
          if(i < 3){
            if(numero[i] == '0'){
              contador++;
            }
          }
        }
        numero= numero.substring(contador, numero.length);
        return numero;
      }

  actualizaReloj($scope, $http, $log)

  /*$scope.refreshDashboard = function () {
    var data = {}
    loadData($scope, $http, $log, '/dashboard_load', data)
    // var p = []
    cargarDashboard($scope, $http, $log)
    cargarPeriodosVentas($scope, $http, $log)
  }*/

  let datosIniciales =  () =>{
    // esta funcion de datosIniciales son  peticiones http que obtienen la informacion 
    // para filtrar las facturas por tipoFactura, condicionVenta y medioPago


    // cuando el modulo se carga, esta funcion se ejecuta y los dropdaown se cargan
    const headers = new Headers();
    $scope.listaTiposComprobante={};
    $scope.listaMediosPago={};

    const urlMedioPago='https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/Nota6_MediosPago.json';
    const urlTipoFactura='https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/Nota10_TipoDelDocumentoDeReferencia.json';
    const urlCondicionVenta ='https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/Nota5_CondicionesDeLaVenta.json';
    fetch(urlMedioPago).then(response =>{
       return response.json();
    })
    .then((data,i) =>{
      $scope.listaMediosPago = data
      let tipoFactura={};
      let codigo;
      const obj = {
        url: urlTipoFactura
      }
      getLinea(obj,'/getTiposFactura').then(response =>{
        response.data.forEach((element,i) =>{
          if(i > 3){
            return;
          }else{
            codigo = (element.Codigo < 10) ? '0'+element.Codigo: element.Codigo; 
            tipoFactura[i]={
              'tipo': element.TipoDelDocumentoDeReferencia,
              'codigo': codigo
            }
          }
        });

         
        $scope.listaTiposComprobante = Object.keys(tipoFactura).map((key) => {
          return tipoFactura[key];
        })
        const objeto ={
          url : urlCondicionVenta
        }
        getLinea(objeto,'getTCondicionVenta').then(data =>{
          $scope.listaCondicionVenta={};

          let newObjeto ={};

          data.data.forEach((element, i) =>{
            newObjeto[i]={
              'condicion': element.CondicionesDeLaVenta,
              'codigo': element.Codigo
            }
          })

          $scope.listaCondicionVenta = Object.keys(newObjeto).map((key) => {
            return newObjeto[key];
          })
        })
        .catch(err =>console.error(err));
      })
    })
    .catch(err => console.error(err));
  }

  datosIniciales();

  let obtenerSubImpuestos = async () => {

    let response;
    const subImpuesto01="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoIVA01.json";
    const subImpuesto02="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoSelectivoConsumo02.json";
    const subImpuesto03="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoUnicoCombustibles03.json";
    const subImpuesto04="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoBebidasAlcoholicas04.json";
    const subImpuesto05="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoBebidasEnvasadasSinAlcoholJabones05.json";
    const subImpuesto06="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoProductosTabaco06.json";
    const subImpuesto07="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoIVACalculoEspecial07.json";
    const subImpuesto99="https://cloud-cube.s3.amazonaws.com/sp5z9nxkd1ra/public/assets/json/subImpuestoOtros99.json";

    response= await fetch(subImpuesto01)
    $scope.subImpuesto01= await response.json();

    response= await fetch(subImpuesto02)
    $scope.subImpuesto02= await response.json();

    response= await fetch(subImpuesto03)
    $scope.subImpuesto03= await response.json();

    response= await fetch(subImpuesto04)
    $scope.subImpuesto04= await response.json();

    response= await fetch(subImpuesto05)
    $scope.subImpuesto05= await response.json();

    response= await fetch(subImpuesto06)
    $scope.subImpuesto06= await response.json();

    response= await fetch(subImpuesto07);
    $scope.subImpuesto07= await response.json();
   
    response= await fetch(subImpuesto99)
    $scope.subImpuesto99= await response.json();
    
  } 
  obtenerSubImpuestos();

  let obtenerImpuestos = () => {
    ///api/clasificacion/

    getLinea({},'/api/clasificacion/').then(data => {
      console.log(data.data);
     $scope.arrayImpuestos= data.data;
    })
    .catch(err => console.error(err));
  }
  obtenerImpuestos();

  $scope.loadTipoImpuesto = (impuesto) => {
      
     $scope.subImpuestoSeleccionado={};
     
     switch(impuesto.codigo_impuesto){
      case '01':
          $scope.subImpuestoSeleccionado= $scope.subImpuesto01.tipoImpuesto;
          break;
      case '02':
          $scope.subImpuestoSeleccionado= $scope.subImpuesto02.tipoImpuesto;
          break;
      case '03':
          $scope.subImpuestoSeleccionado= $scope.subImpuesto03.tipoImpuesto;
          break;
      case '04':
          $scope.subImpuestoSeleccionado= $scope.subImpuesto04.tipoImpuesto;
          break;
      case '05':
          $scope.subImpuestoSeleccionado= $scope.subImpuesto05.tipoImpuesto;
          break;
      case '06': 
          $scope.subImpuestoSeleccionado= $scope.subImpuesto06.tipoImpuesto;
          break;
      case '07':
          $scope.subImpuestoSeleccionado= $scope.subImpuesto07.tipoImpuesto;
          break;
      case '99':
          $scope.subImpuestoSeleccionado= $scope.subImpuesto99.tipoImpuesto;
          break;
      default:
        throw new Error("El codigo de impuesto no pertenece a ninguna de las posibles opciones");
     }
  }

  $scope.BuscarPorFechas=(busqueda, fecha)=>{
    //Aug 14 23:03:06
  // esta funcion recibe un parametro de mas que es fecha, es para saber si se va buscar por un rango de fechas
  // o por una fecha nada mas
    if(typeof busqueda === 'undefined'){
      alert("Los campos de fecha son requeridos para realizar la busqueda");
      return;
    }else{
      if(fecha===''){

          let fecha1,fecha2, datosFecha={
            fecha1:'',
            fecha2:''
          };

          fecha1=new Date(document.getElementById("fecha1").value);
          fecha2=new Date(document.getElementById("fecha2").value);

        let mes, anio, dia;
        mes = Number(fecha1.getMonth())+1;
        dia= Number(fecha1.getDate())+1;
        anio = fecha1.getFullYear();

        if(mes < 10) mes= '0'+String(mes);
        if(dia< 10) dia = '0'+String(dia);

        datosFecha.fecha1=[anio, mes, dia].join('/');

        // DATOS PARA FECHA 2
        mes = Number(fecha2.getMonth())+1;
        dia= Number(fecha2.getDate())+1;
        anio = fecha2.getFullYear();

        if(mes < 10) mes= '0'+String(mes);
        if(dia< 10) dia = '0'+dia;

        datosFecha.fecha2=[anio, mes, dia].join('/');

        //getLinea(datosFecha,'/dataFactura/perFechas').then(resultado => {
          $http({ method: 'GET', url: '/dataFactura/perFechas', params: datosFecha}) // se hace la peticion 
          // al server y se carga el objeto que carga la tabla
          .then(resultado => {  
          $scope.filtroBusquda='Por fechas';
          $scope.datosBusqueda= resultado.data;

          let objeto={};
          let mediopago;
          let receptorNumero='';
          $scope.datosBusqueda.forEach((dato,i) => {
            dato.medio_pago == '01'? mediopago='Efectivo': mediopago= 'Tarjeta';
            
            if(dato.tipo=='TE'){
              receptorNumero='-';
            }else if(dato.tipo=='FE'){
              receptorNumero= obtenerNumeros_Emisor_Receptor(dato.receptor_numero);
            }

            objeto[i]={
              'clavenumerica': dato.clavenumerica,
              'codigomoneda': dato.codigomoneda,
              'condicion_venta': dato.condicion_venta,
              'consecutivo': dato.consecutivo,
              'fecharegistrofactura': dato.fechaemision,
              'idfactura': dato.idfactura,
              'medio_pago': mediopago,
              'plazo_credito': dato.plazo_credito,
              'receptor_numero': receptorNumero,
              'status': dato.status,
              'tipo': dato.tipo,
              'tipocambio': dato.tipocambio,
              'totalcomprobante': dato.totalcomprobante,
              'totaldescuentos': dato.totaldescuentos,
              'totalexento': dato.totalexento,
              'totalgravado': dato.totalgravado,
              'totalimpuesto': dato.totalimpuesto,
              'totalmercanciasexentas': dato.totalmercanciasexentas,
              'totalmercanciasgravadas': dato.totalmercanciasgravadas,
              'totalservexentos': dato.totalservexentos,
              'totalservgravados': dato.totalservgravados,
              'totalventa': dato.totalventa,
              'totalventaneta': dato.totalventaneta,
              'subtotal': dato.subtotal,
              'receptorEmail': dato.correoelectronico,
              "emisorEmail": dato.e_correoelectronico
            }
          })

            $scope.listaBusqueda = Object.keys(objeto).map((key) => {
              return objeto[key];
            });
            $scope.copiaArrayRegistros=$scope.listaBusqueda;
            $scope.numeroResultados = (Object.keys($scope.listaBusqueda).length === 0) ? 'Sin resultados': Object.keys($scope.listaBusqueda).length; 
            $("#busqueda-fechas-modal").modal('hide');
          })
          .catch(err => console.error(err));
      }else{ // aqui se busca por solamente una fecha


        let fechaBusqueda,datosFechaBusqueda={
            valor:'',
            tipoBusqueda: 'fecha'
          };

          fechaBusqueda=new Date(document.getElementById("fecha").value);
          
          let mesFecha, anioFecha, diaFecha;
          mesFecha = Number(fechaBusqueda.getMonth())+1;
          diaFecha= Number(fechaBusqueda.getDate())+1;
          anioFecha = fechaBusqueda.getFullYear();
          
          if(mesFecha < 10) mesFecha= '0'+String(mesFecha);
          if(diaFecha< 10) diaFecha = '0'+String(diaFecha);

          datosFechaBusqueda.valor=[anioFecha, mesFecha, diaFecha].join('/'); // el objeto de busqueda se carga
          console.log(datosFechaBusqueda)

          $http({ method: 'GET', url: '/dataFactura/perParametro/', params: datosFechaBusqueda})
          // se hace la peticion y se carga el obj que carga la tabla
          .then(resultado => {
            $scope.filtroBusquda='Por fecha';
            $scope.arrayRespuesta= resultado.data;
            let mediopago;
            let datos={};  
            let receptorNumero=''
            $scope.arrayRespuesta.forEach((dato,i) => {
              dato.medio_pago == '01'? mediopago='Efectivo': mediopago= 'Tarjeta';

              if(dato.tipo=='TE'){
                receptorNumero='-';
              }else if(dato.tipo=='FE'){
                receptorNumero= obtenerNumeros_Emisor_Receptor(dato.receptor_numero);
              }
              datos[i]={
                'clavenumerica': dato.clavenumerica,
                'codigomoneda': dato.codigomoneda,
                'condicion_venta': dato.condicion_venta,
                'consecutivo': dato.consecutivo,
                'fecharegistrofactura': dato.fechaemision,
                'idfactura': dato.idfactura,
                'medio_pago': mediopago,
                'plazo_credito': dato.plazo_credito,
                'receptor_numero': receptorNumero,
                'status': dato.status,
                'tipo': dato.tipo,
                'tipocambio': dato.tipocambio,
                'totalcomprobante': dato.totalcomprobante,
                'totaldescuentos': dato.totaldescuentos,
                'totalexento': dato.totalexento,
                'totalgravado': dato.totalgravado,
                'totalimpuesto': dato.totalimpuesto,
                'totalmercanciasexentas': dato.totalmercanciasexentas,
                'totalmercanciasgravadas': dato.totalmercanciasgravadas,
                'totalservexentos': dato.totalservexentos,
                'totalservgravados': dato.totalservgravados,
                'totalventa': dato.totalventa,
                'totalventaneta': dato.totalventaneta,
                'subtotal': dato.subtotal,
                'receptorEmail': dato.correoelectronico,
                "emisorEmail": dato.e_correoelectronico
              }
              console.log(datos);  
            })

            $scope.listaBusqueda = Object.keys(datos).map((key) => {
              return datos[key];
            });
            $scope.copiaArrayRegistros=$scope.listaBusqueda;
            $scope.numeroResultados = (Object.keys($scope.listaBusqueda).length === 0) ? 'Sin resultados': Object.keys($scope.listaBusqueda).length; 
            $("#busqueda-fecha-modal").modal('hide');
          })
          .catch(err=> console.error(err));
        }
      }
  }
  $scope.busquedaPorCedula= busqueda =>{ // esta funcion busca por numero de cedula las facturas
    
    let cedula='';

    switch(busqueda.numerocedula.length){
      case 9:
        cedula ='000'+busqueda.numerocedula;
        break;
      case 10:
        cedula ='00'+busqueda.numerocedula;
        break;
      case 11:
        cedula ='0'+busqueda.numerocedula;
        break;
      case 12:
        cedula = busqueda.numerocedula;
        break;
      
      default:
        console.error("El valor de la cédula es inválido");
        break;  
    }

    let obj={//cargar objeto de busqueda
      tipoBusqueda: 'receptor',
      valor: cedula
    }
    $http({ method: 'GET', url: '/dataFactura/perParametro/', params: obj})
    // hacer la busqueda en el server, /dataFactura/perParametro/ este endpoint puede recibir varios tipos de valor tipoBusqueda
    // se hizo de esa manera para poder reutilizar el mismo endpoint para varias consultas
    .then(resultado => {

      // se carga el resulta en el objeto de la tabla html
        
        $scope.filtroBusquda='Por Cedula';
        $scope.datosBusqueda= resultado.data; 
        let objeto={};
        let mediopago='';
        let receptorNumero='';

        $scope.datosBusqueda.forEach((dato,i) => {
          
          dato.medio_pago == '01'? mediopago='Efectivo': mediopago= 'Tarjeta';
       
          if(dato.tipo=='TE'){
            receptorNumero='-';
          }else if(dato.tipo=='FE'){
            receptorNumero= obtenerNumeros_Emisor_Receptor(dato.receptor_numero);
          }
          objeto[i]={

            'clavenumerica': dato.clavenumerica,
            'codigomoneda': dato.codigomoneda,
            'condicion_venta': dato.condicion_venta,
            'consecutivo': dato.consecutivo,
            'fecharegistrofactura': dato.fechaemision,
            'idfactura': dato.idfactura,
            'medio_pago': mediopago,
            'plazo_credito': dato.plazo_credito,
            'receptor_numero': receptorNumero,
            'status': dato.status,
            'tipo': dato.tipo,
            'tipocambio': dato.tipocambio,
            'totalcomprobante': dato.totalcomprobante,
            'totaldescuentos': dato.totaldescuentos,
            'totalexento': dato.totalexento,
            'totalgravado': dato.totalgravado,
            'totalimpuesto': dato.totalimpuesto,
            'totalmercanciasexentas': dato.totalmercanciasexentas,
            'totalmercanciasgravadas': dato.totalmercanciasgravadas,
            'totalservexentos': dato.totalservexentos,
            'totalservgravados': dato.totalservgravados,
            'totalventa': dato.totalventa,
            'totalventaneta': dato.totalventaneta,
            'subtotal': dato.subtotal,
            'receptorEmail': dato.correoelectronico,
            "emisorEmail": dato.e_correoelectronico
          }
        })
   

        $scope.listaBusqueda = Object.keys(objeto).map((key) => {
          return objeto[key];
        });
        $scope.copiaArrayRegistros=$scope.listaBusqueda;
        $scope.numeroResultados = (Object.keys($scope.listaBusqueda).length === 0) ? 'Sin resultados': Object.keys($scope.listaBusqueda).length; 
        $("#busqueda-cedula-modal").modal('hide');
      }).catch(err => console.error(err));
  }

  
  $scope.busquedaPorClave= busqueda =>{

    // buscar por clavenumerica
    let obj={
      tipoBusqueda: 'clave',
      valor: busqueda.numeroclave
    }
      
      $http({ method: 'GET', url: '/dataFactura/perParametro/', params: obj})
      // el endpint busca por diferentes parametros
         .then(resultado => {
          // devolver y cargar resultados en la tabla
          $scope.filtroBusquda='Por clavenumerica';
          $scope.datosBusqueda= resultado.data;
          console.log("resultado ",resultado.data)
          let objeto={};
          let mediopago;
          let receptorNumero='';
          $scope.datosBusqueda.forEach((dato,i) => {
            dato.medio_pago == '01'? mediopago='Efectivo': mediopago= 'Tarjeta';
            if(dato.tipo=='TE'){
              receptorNumero='-';
            }else if(dato.tipo=='FE'){
              receptorNumero= obtenerNumeros_Emisor_Receptor(dato.receptor_numero);
            }
            objeto[i]={
              'clavenumerica': dato.clavenumerica,
              'codigomoneda': dato.codigomoneda,
              'condicion_venta': dato.condicion_venta,
              'consecutivo': dato.consecutivo,
              'fecharegistrofactura': dato.fechaemision,
              'idfactura': dato.idfactura,
              'medio_pago': mediopago,
              'plazo_credito': dato.plazo_credito,
              'receptor_numero': receptorNumero,
              'status': dato.status,
              'tipo': dato.tipo,
              'tipocambio': dato.tipocambio,
              'totalcomprobante': dato.totalcomprobante,
              'totaldescuentos': dato.totaldescuentos,
              'totalexento': dato.totalexento,
              'totalgravado': dato.totalgravado,
              'totalimpuesto': dato.totalimpuesto,
              'totalmercanciasexentas': dato.totalmercanciasexentas,
              'totalmercanciasgravadas': dato.totalmercanciasgravadas,
              'totalservexentos': dato.totalservexentos,
              'totalservgravados': dato.totalservgravados,
              'totalventa': dato.totalventa,
              'totalventaneta': dato.totalventaneta,
              'subtotal': dato.subtotal,
              'receptorEmail': dato.correoelectronico,
              "emisorEmail": dato.e_correoelectronico
            }
          })

        $scope.listaBusqueda = Object.keys(objeto).map((key) => {
          return objeto[key];
        });
        $scope.copiaArrayRegistros=$scope.listaBusqueda;
        $scope.numeroResultados = (Object.keys($scope.listaBusqueda).length === 0) ? 'Sin resultados': Object.keys($scope.listaBusqueda).length;
        $("#busqueda-clave-modal").modal('hide');
         }).catch(err =>{
        console.error(err);
      })  
  }

  $scope.BuscarPorImpuesto = (objeto) => {
    const impuesto = objeto.impuesto.id;
    const tipoimpuesto = objeto.tipoimpuesto.idimpuesto;

    const data = {
      impuesto,
      tipoimpuesto
    }

    $http({ method: 'GET', url: 'getFacturas/perImpuesto', params: data})
    // el endpint busca por diferentes parametros
       .then(resultado => { 
        $scope.filtroBusquda='Por clavenumerica';
          $scope.datosBusqueda= resultado.data;
          console.log("resultado ",resultado.data)
          let objeto={};
          let mediopago;
          let receptorNumero='';
          $scope.datosBusqueda.forEach((dato,i) => {
            dato.medio_pago == '01'? mediopago='Efectivo': mediopago= 'Tarjeta';
            if(dato.tipo=='TE'){
              receptorNumero='-';
            }else if(dato.tipo=='FE'){
              receptorNumero= obtenerNumeros_Emisor_Receptor(dato.receptor_numero);
            }
            objeto[i]={
              'clavenumerica': dato.clavenumerica,
              'codigomoneda': dato.codigomoneda,
              'condicion_venta': dato.condicion_venta,
              'consecutivo': dato.consecutivo,
              'fecharegistrofactura': dato.fechaemision,
              'idfactura': dato.idfactura,
              'medio_pago': mediopago,
              'plazo_credito': dato.plazo_credito,
              'receptor_numero': receptorNumero,
              'status': dato.status,
              'tipo': dato.tipo,
              'tipocambio': dato.tipocambio,
              'totalcomprobante': dato.totalcomprobante,
              'totaldescuentos': dato.totaldescuentos,
              'totalexento': dato.totalexento,
              'totalgravado': dato.totalgravado,
              'totalimpuesto': dato.totalimpuesto,
              'totalmercanciasexentas': dato.totalmercanciasexentas,
              'totalmercanciasgravadas': dato.totalmercanciasgravadas,
              'totalservexentos': dato.totalservexentos,
              'totalservgravados': dato.totalservgravados,
              'totalventa': dato.totalventa,
              'totalventaneta': dato.totalventaneta,
              'subtotal': dato.subtotal,
              'receptorEmail': dato.correoelectronico,
              "emisorEmail": dato.e_correoelectronico
            }
          })

        $scope.listaBusqueda = Object.keys(objeto).map((key) => {
          return objeto[key];
        });
        $scope.copiaArrayRegistros=$scope.listaBusqueda;
        $scope.numeroResultados = (Object.keys($scope.listaBusqueda).length === 0) ? 'Sin resultados': Object.keys($scope.listaBusqueda).length;

        $("#busqueda-impuesto-modal").modal('hide');

       }).catch(err => console.error(err));
    ///getFacturas/perImpuesto
  }
  
  $scope.filtroMedioPago = mediopago =>{

    let arrayResultados = $scope.listaBusqueda;
    let copiaArrayResultados =  $scope.copiaArrayRegistros;

    if(typeof $scope.listaBusqueda === 'undefined') return;// si no hay nada en la tabla html etnonces no se hace nada

    if(Object.keys(arrayResultados).length !== Object.keys(copiaArrayResultados).length){
      // esta linea del if me compara si el objeto que carga la tabla ya esta filtrado, es decir
      // si ya se hizo un filtro
      $scope.listaBusqueda=copiaArrayResultados; // de ser asi se carga de nuevo con un array que tiene la informacion original 
      // de la bd, de esa manera la informacion total se tiene y se filtrar todas las veces que sean 
    }
      $scope.filtroBusquda='Por MedioPago';
    
      $scope.listaBusqueda.forEach(e =>console.log(e));
      let MedioPago = $scope.listaBusqueda.filter(fila =>fila.medio_pago === mediopago.MediosDePago); // aqui es donde se filtran los resultados y se muestran en la tabla
      $scope.listaBusqueda = Object.keys(MedioPago).map((key) => {
        return MedioPago[key];
      });

      $scope.numeroResultados= (Object.keys($scope.listaBusqueda).length === 0)?  'Sin resultados': Object.keys($scope.listaBusqueda).length; 
  }


  $scope.filtroTipoFactura = tipoFactura =>{
    

    let codigo= tipoFactura.codigo;
    let arrayResultados = $scope.listaBusqueda;
    let copiaArrayResultados =  $scope.copiaArrayRegistros;
    
    if(typeof $scope.listaBusqueda === 'undefined') return;

    $scope.filtroBusquda="Por TipoFactura";

    if(codigo === '01') parametroCodigo = 'FE';
    if(codigo === '02') parametroCodigo = 'ND';
    if(codigo === '03') parametroCodigo = 'NC'; // se compara para saber cual tipo de factura es 
    if(codigo === '04') parametroCodigo = 'TE';
    
    if(Object.keys(arrayResultados).length !== Object.keys(copiaArrayResultados).length){
      
      $scope.listaBusqueda=copiaArrayResultados;
    }

    let listaTipoFactura= $scope.listaBusqueda.filter(fila => fila.tipo === parametroCodigo);
   
    $scope.listaBusqueda = Object.keys(listaTipoFactura).map((key) => {
      return listaTipoFactura[key];
    });

    $scope.numeroResultados= (Object.keys($scope.listaBusqueda).length === 0)?  'Sin resultados': Object.keys($scope.listaBusqueda).length;
  }


  $scope.filtroCondicionVenta = condicionVenta =>{

    let arrayResultados = $scope.listaBusqueda;
    let copiaArrayResultados =  $scope.copiaArrayRegistros;
    if(typeof $scope.listaBusqueda === 'undefined') return;

    $scope.filtroBusquda="Por CondicionVenta";
    if(Object.keys(arrayResultados).length !== Object.keys(copiaArrayResultados).length){
      
      $scope.listaBusqueda=copiaArrayResultados;
    }

    let listaCondicionVenta = $scope.listaBusqueda.filter(lista => lista.condicion_venta === condicionVenta.codigo);

    $scope.listaBusqueda = Object.keys(listaCondicionVenta).map((key) => {
      return listaCondicionVenta[key];
    });

    $scope.numeroResultados= (Object.keys($scope.listaBusqueda).length === 0)?  'Sin resultados': Object.keys($scope.listaBusqueda).length;
  }
//obtenerNumeros_Emisor_Receptor
  
  $scope.loadDataFactura = (dataFactura) =>{
    console.log(dataFactura)
       // se cargan los datos de l factura
        $scope.idComprobante= dataFactura.idfactura;
        $scope.fechaEmisionComprobante= dataFactura.fecharegistrofactura;
        $scope.claveComprobante = dataFactura.clavenumerica;
        $scope.subtotalComprobante = dataFactura.subtotal;
        $scope.descuentoComprobante= dataFactura.totaldescuentos;
        $scope.totalgravado= dataFactura.totalgravado;
        $scope.totalexcento= dataFactura.totalexento;
        $scope.mercgravada = dataFactura.totalmercanciasgravadas;
        $scope.totalmercexcenta = dataFactura.totalmercanciasexentas;
        $scope.servexcentos = dataFactura.totalservexentos;
        $scope.servgravados= dataFactura.totalservgravados
        $scope.totalventa = dataFactura.totalcomprobante;
        $scope.consecutivoComprobante = dataFactura.consecutivo; 
        $scope.totalimpuesto = dataFactura.totalimpuesto;
        $scope.formapago=dataFactura.medio_pago;
        $scope.estado= dataFactura.status;
        $scope.receptorEmail = dataFactura.receptorEmail;
        $scope.emisorEmail = dataFactura.emisorEmail;
        $scope.tipoFactura = dataFactura.tipo;
        if(dataFactura.tipo== 'TE') $scope.titulo='Tiquete Electrónico';
        else if(dataFactura.tipo== 'FE') $scope.titulo='Factura Electrónica';
    let obj ={
      idFactura: dataFactura.idfactura
    }
   // se hace una busqueda de las ordenes por el id de la factura
    $http({ method: 'GET', url: '/getOrdersCanceledBill/nota', params: obj})
         .then(data => {
           console.log(data)
          $scope.listaOrdenesFactura=[];
          let objOrdenes={};
          
          objOrdenes=data.data;
  
          // datos de factura
          // datos de orden
          objOrdenes.forEach((element,i) =>{ // se carga el objeto de las ordenes de la factura
             objOrdenes[i]={
               'cantidadproducto': element.get_orders_per_factura.cantidadproducto,
               'codigo_producto': element.get_orders_per_factura.codigo_producto,
               'codigoimpuesto': element.get_orders_per_factura.codigoimpuesto,
               'codigoservicio': element.get_orders_per_factura.codigoservicio,
               'costounitarioproducto': element.get_orders_per_factura.costounitarioproducto,
               'descripcionproducto': element.get_orders_per_factura.descripcionproducto,
               'descuentoorden': element.get_orders_per_factura.descuentoorden,
               'idorden': element.get_orders_per_factura.idorden,
               'idproducto': element.get_orders_per_factura.idproducto,
               'montodescuento': element.get_orders_per_factura.montodescuento,
               'montoimpuesto': element.get_orders_per_factura.montoimpuesto,
               'naturalezadescuento': element.get_orders_per_factura.naturalezadescuento,
               'preciounitarioproducto': element.get_orders_per_factura.preciounitarioproducto,
               'subtotal': element.get_orders_per_factura.subtotal,
               'total_orden': element.get_orders_per_factura.total_orden
             }
           $scope.listaOrdenesFactura.push(objOrdenes[i]); 
          })
  
        console.log($scope.listaOrdenesFactura);
        $('#detalle-factura-modal').modal('show'); // se carga el modal de detalle de comprobante
    }).catch(err =>{
        console.error(err);
    })
  }
  // esta es la funcion que exporta el reporte de hacienda desde aqui, sin necesidad de usar algun plugin ni
  // de enviar una peticion extra al servidor
    $scope.exportTableToExcel = (dataFactura)=>{ // esta funcion recibe el objeto actual que carga la tabla con los
      // registros de busqueda actuales, ya sea filtrados o cargados directamente de la base de datos
      if(typeof dataFactura === 'undefined' || dataFactura.length === 0){
        alert("No hay datos para exportar");
        return;
      }
      
      const data = dataFactura.map(row => ({ // aqui se carga el objeto que se va los datos a exportar en el csv
          clavenumerica: row.clavenumerica,
          cedula: row.receptor_numero,
          tipo: row.tipo,
          total: row.totalcomprobante,
          medioPago: row.medio_pago,
          condicionVenta: row.condicion_venta,
          fecha: row.fecharegistrofactura
      }));
     
     const objectToCsv = (obj) =>{ // esta funcion parse el objeto para que sea legible para ser exportado
        const csvRows = [];
        const headers = Object.keys(obj[0]);
        csvRows.push(headers.join(',')); // se obtienen y se guardan las cabeceras, es decir idfactura, total, etc
        
        for(const row of obj){ // se 
        const value= headers.map(header =>{ // aqui se obtienen los valores de cada iteracion, y se insertan en el 
          // objeto csvRows para que los valores vayan con sus keys, de maneras que en el excel muestre los keys 
          // y los valores
          const rowScaped= row[header].replace(/"/g,'\\"');
            return `"${rowScaped}"`;
          });
          csvRows.push(value);
        }
        return csvRows.join('\n');
     }

     const downloadReportCsv = (obj) =>{

      // obtener la fecha para agregarla al nombre del archivo a exportar
      let mesFecha, anioFecha, diaFecha;
      let fechaBusqueda=new Date();
      mesFecha = Number(fechaBusqueda.getMonth())+1;
      diaFecha= Number(fechaBusqueda.getDate())+1;
      anioFecha = fechaBusqueda.getFullYear();
      
      if(mesFecha < 10) mesFecha= '0'+String(mesFecha);
      if(diaFecha< 10) diaFecha = '0'+String(diaFecha);
      let fechaFinal =anioFecha+"/"+mesFecha+"/"+diaFecha;

        const blob= new Blob([obj], {type : 'text/csv'}); // se crea el archivo binario
        const url = window.URL.createObjectURL(blob); // esta url va ser la que el blob va usar para descarga el archivo
        const a = document.createElement('a'); // se crea un <a> escondido
        a.setAttribute("hidden", ''); 
        a.setAttribute("href", url); // se le carga la url
        a.setAttribute("download", "reporteHacienda_"+fechaFinal+"_.csv"); // se asigna el nombre del archivo con la fecha actual
        document.body.appendChild(a);
        a.click(); // se descarga el archivo
        document.body.removeChild(a);  
     }
      
      const csvData = objectToCsv(data);

      downloadReportCsv(csvData);
    }
  $scope.enviarReporte = (idfactura,receptorEmail, emisorEmail) => {
    
    let obj = {};

    if($scope.tipoFactura === 'FE'){
      obj ={
        tipo: 'pdf',
        emisor: $scope.emisorEmail,
        receptor: $scope.receptorEmail,
        idfactura: $scope.idComprobante,
        clave : $scope.claveComprobante
      }
    }else{
      obj ={
        tipo: 'pdf',
        emisor: $scope.emisorEmail,
        idfactura: $scope.idComprobante,
        clave : $scope.claveComprobante
      }
    }

    $http({ method: 'GET', url: '/download', params: obj})
      .then(response => { 
          if(response.status === 200){
            alert(response.data.message); 
          }
      })
      .catch(err => console.error(err));
  }

  $scope.sortDashboard = function (keyname) {
    $scope.sortKey = keyname // set the sortKey to the param passed
    $scope.reverse = !$scope.reverse // if true make it false and vice versa
  }


  /*$scope.rowClicked = function (periodo) {
    $scope.nombrePeriodo = periodo.nombreperiodo
    $scope.fechaInicioPeriodo = periodo.fecha
    var idPeriodoSeleccionado = periodo.idperiodoventa
    for (var i = 0; i < $scope.object.length; i++) {
      if (idPeriodoSeleccionado === $scope.object[i].idperiodoventa) {
        $scope.mesPeriodo = $scope.object[i].mes
        var infoMes = { mes: $scope.object[i].mes }
        $http({
          method: 'GET',
          url: '/getMonthSales',
          params: infoMes
        }).then(function (response) {
          $scope.acumuladoMes = response.data[0].totalventasmes
        }).catch(function (error) {
          $log.error(error)
        })
      }
    }
  }*/

  if (typeof $scope.template === 'undefined') { $scope.template = 'reportes' }

  $scope.templateAction = function (key) { $scope.template = key }

  // Script del Reloj
  function actualizaReloj ($scope, $http, $log) {
  
    // Capturamos la Hora, los minutos y los segundos
    var marcacion = new Date()
    var Hora = marcacion.getHours()
    var Minutos = marcacion.getMinutes()
    var Segundos = marcacion.getSeconds()
    if (Hora <= 9) { Hora = '0' + Hora }
    if (Minutos <= 9) { Minutos = '0' + Minutos }
    // if (Segundos <= 9) { Segundos = '0' + Segundos }
    $scope.horaReloj = Hora + ':' + Minutos // + ':' + Segundos
  }

     // escucha para cada boton y hacer la consulta de traer las ordenes
     //no borrar este comentario
    /*document.addEventListener('click',(e) => { // delegados
      //usando delegados no es necesario usar jquery para eventos click en tablas 
      if(e.target.tagName === 'BUTTON'){
        let obj={};
        if(e.target.getAttribute("id") === "orden"){
           obj= {
            idfactura: e.target.getAttribute("idfactura")
          }
        }
          getLinea(obj,'/orders_to_PDF').then(data =>{
            $scope.listaOrdenesFactura= data.data;
            console.log($scope.listaOrdenesFactura)
          })
          .catch(err =>console.error(err));
        }
    });*/
  
  

}).controller('gastosController', function ($scope, $http, $log) {
  // resetear los valores del formulario.
  $scope.clearData = function () {
    $scope.gasto = {}
    scopeId = null
  }

  $scope.estadoGastos = ['Cancelado', 'Se debe']

  $scope.sort = function (keyname) {
    $scope.sortKey = keyname // set the sortKey to the param passed
    $scope.reverse = !$scope.reverse // if true make it false and vice versa
  }

  $(document).ready(function () {
    validateAlphanumeric()
    validateLetters()
    validateNumbers()
  })

  $scope.rowClicked = function (gasto) {
    $scope.selectedRow = false
    $scope.gasto_selected = gasto
    if (typeof gasto.idgasto !== 'undefined') {
      $scope.selectedRow = gasto.idgasto
    }
  }

  $scope.rowClickedType = function (tipoGasto) {
    $scope.selectedRowType = false
    $scope.tipoGasto_selected = tipoGasto
    if (typeof tipoGasto.idtipogasto !== 'undefined') {
      $scope.selectedRowType = tipoGasto.idtipogasto
    }
  }

  $scope.refreshGasto = function () {
    var data = {}
    $scope.observacionGasto = ''
    $scope.descripcionGasto = ''
    $scope.montoGasto = ''
    loadData($scope, $http, $log, '/gastos', data, true) // Reload expenses

    getPromise($scope, $http, $log, '/tipoGasto', data, false).then(function (response) {
      $scope.TipoGastos = response
    }).catch(function (error) {
      $log.error(error)
    })

    getPromise($scope, $http, $log, '/api/total_gasto/get', data, false).then(function (response) {
      $scope.totalGastos = response[0].total
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.saveGasto = function () {
    if (typeof $scope.descripcionGasto === 'undefined') {
      alert('La descripcion no puede ser Vacio: ' + $scope.descripcionGasto)
      $log.error('descripcion: ' + $scope.descripcionGasto)
    } else if (typeof $scope.montoGasto === 'undefined') {
      alert('El monto no puede ser Vacio: ' + $scope.montoGasto)
      $log.info('monto: ' + $scope.montoGasto)
    } else if (typeof $scope.idTipoGasto === 'undefined') {
      alert('El tipo de gasto no puede ser Vacio: ' + $scope.idTipoGasto)
      $log.info('tipo: ' + $scope.idTipoGasto)
    } else if (typeof $scope.estadoGasto === 'undefined') {
      alert('El estado no puede ser Vacio: ' + $scope.estadoGasto)
      $log.info('Estado: ' + $scope.estadoGasto)
    } else {
      if (typeof $scope.observacionGasto === 'undefined') {
        alert('No se ha ingresado ninguna observacion')
        $log.info('observacion: ' + $scope.observacionGasto)
      }
      var data = {
        idTipoGasto: $scope.idTipoGasto,
        descripcionGasto: $scope.descripcionGasto,
        montoGasto: $scope.montoGasto,
        estadoGasto: $scope.estadoGasto,
        observacionGasto: $scope.observacionGasto
      }
      return insertPromise($scope, $http, $log, '/api/registrar_gasto/insert', data).then(function () {
        $scope.refreshGasto()
        $scope.idTipoGasto = ''
        $scope.descripcionGasto = ''
        $scope.montoGasto = ''
        $scope.estadoGasto = ''
        $scope.observacionGasto = ''
      }).catch(function (error) {
        $log.error(error)
      })
    }
  }

  $scope.saveTipoGasto = function () {
    if (typeof $scope.descripcionTipoGastoInsert === 'undefined' || $scope.descripcionTipoGastoInsert === '') {
      $log.error('descripcionTipoGasto es vacio: ' + $scope.descripcionTipoGastoInsert)
      alert('Accion no valida: descripcionTipoGasto es nulo: ' + $scope.descripcionTipoGastoInsert)
      $scope.refreshGasto()
    } else {
      var data = { descripcionTipoGasto: $scope.descripcionTipoGastoInsert }
      return insertPromise($scope, $http, $log, '/api/tipo_de_gasto/insert', data).then(function () {
        $scope.refreshGasto()
      }).catch(function (error) {
        $log.error(error)
      })
    }
  }

  $scope.editGasto_data = function (idGasto, descripcionGasto, montoGasto, estadoGasto, observacionGasto) {
    $scope.idGasto = idGasto
    $scope.descripcionGasto = descripcionGasto
    $scope.montoGasto = montoGasto
    $scope.estadoGasto = estadoGasto
    $scope.observacionGasto = observacionGasto
  }

  // save (insert & update) product method
  $scope.updateGasto = function () {
    if (typeof $scope.descripcionGasto === 'undefined') {
      alert('La descripcion no puede ser Vacio: ' + $scope.descripcionGasto)
      $log.error('descripcion: ' + $scope.descripcionGasto)
    } else if (typeof $scope.montoGasto === 'undefined') {
      alert('El monto no puede ser Vacio: ' + $scope.montoGasto)
      $log.info('monto: ' + $scope.montoGasto)
    } else if (typeof $scope.estadoGasto === 'undefined') {
      alert('El estado no puede ser Vacio: ' + $scope.estadoGasto)
      $log.info('Estado: ' + $scope.estadoGasto)
    } else {
      $scope.estadoGasto = $('#txtEstadoGasto').val()
      if (typeof $scope.observacionGasto === 'undefined') {
        alert('No se ha ingresado ninguna observacion')
        $log.info('observacion: ' + $scope.observacionGasto)
      }
      var data = {
        idGasto: $scope.idGasto,
        descripcionGasto: $scope.descripcionGasto,
        montoGasto: $scope.montoGasto,
        estadoGasto: $scope.estadoGasto,
        observacionGasto: $scope.observacionGasto
      }
      return updatePromise($scope, $http, $log, '/api/gasto/update', data).then(function () {
        $scope.refreshGasto()
      }).catch(function (error) {
        $log.error(error)
      })
    }
  }

  $scope.sendDatadeleteGasto = function (idGasto, descripcionGasto) {
    $scope.idGasto = idGasto
    $scope.descripcionGasto = descripcionGasto
  }

  $scope.deleteGasto = function () {
    var data = {idGasto: $scope.idGasto}
    return insertPromise($scope, $http, $log, '/api/gasto/delete', data).then(function () {
      $scope.refreshGasto()
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.editTipoGasto_data = function (descripcionTipoGasto, idTipoGasto) {
    $scope.descripcionTipoGasto = descripcionTipoGasto
    $scope.idTipoGasto = idTipoGasto
  }

  $scope.updateTipoGasto = function () {
    if (typeof $scope.descripcionTipoGasto === 'undefined') {
      alert('La descripcion del tipo de gasto no puede ser Vacio: ' + $scope.descricionTipoGasto)
      $log.error('descripcion: ' + $scope.descipcionTipoGasto)
    } else {
      var data = {
        descripcionTipoGasto: $scope.descripcionTipoGasto,
        idTipoGasto: $scope.idTipoGasto
      }
      // $log.info('Tipo de gasto: ' + $scope.descripcionTipoGasto)
      return updatePromise($scope, $http, $log, '/api/tipo_gasto/update', data).then(function () {
        $scope.refreshGasto()
      }).catch(function (error) {
        $log.error(error)
      })
    }
  }

  $scope.sendTipoGastoDataDelete = function (idTipoGasto, descripcionTipoGasto) {
    $scope.idTipoGasto = idTipoGasto
    $scope.descripcionTipoGasto = descripcionTipoGasto
  }

  $scope.deleteTipoGasto = function () {
    var data = {idTipoGasto: $scope.idTipoGasto}
    return insertPromise($scope, $http, $log, '/api/tipo_gasto/delete', data).then(function () {
      $scope.refreshGasto()
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.reporte_excel3 = function () {
    /* Metodo para descargar el tipo de reporte3
    https:// stackoverflow.com/questions/36931521/how-to-download-binary-file-in-angular-js-using-http
    https:// ramirezmery.wordpress.com/2016/04/17/angularjs-download-file-with-http-and-web-api/ */
    $http({
      method: 'GET',
      url: '/Excel3',
      responseType: 'arraybuffer'
    }).then(function (file) {
      $log.info(file)
      var ieEDGE = navigator.userAgent.match(/Edge/g)
      var ie = navigator.userAgent.match(/.NET/g) // IE 11+
      var oldIE = navigator.userAgent.match(/MSIE/g)
      var filename = 'Reporte_Gastos:' + '.xlsx'

      var blob = new window.Blob([file.data], { type: 'application/vnd.openxmlformats' })

      if (ie || oldIE || ieEDGE) {
        // 'Internet Explorer'
        window.navigator.msSaveBlob(blob, filename)
      } else {
        var file = new Blob([file.data], {
          type: 'application/vnd.openxmlformats'
        })
        var fileURL = URL.createObjectURL(file)
        var a = document.createElement('a')
        a.href = fileURL
        a.target = '_blank'
        a.download = filename
        document.body.appendChild(a)
        a.click()
      }
    }).catch(function (error) {
      $log.error(error)
    })
  }

  $scope.refreshGasto()
}).controller('descuentosController', function ($scope, $http, $log) {


  loadData($scope, $http, $log, '/descuentos', {});


  $scope.descripcionEstado='';
  //Funciones para manejo de base de datos

  let insertarFila = (data, route) =>{
       return new Promise((resolve,reject) => {
         $http({ method: 'POST', url: route, params: data, data: data})
         .then(data => {
          resolve(data);
         }).catch(err =>{
           reject(err);
         })
       })
  }

  let getLinea= (data,route)=> {
    return new Promise((resolve,reject) => {
         $http({ method: 'GET', url: route, params: data})
         .then(data => {
          resolve(data);
         }).catch(err =>{
           reject(err);
         })
       })
  }

  let actualizarLinea= (data,route)=> {
    return new Promise((resolve,reject) => {
         $http({ method: 'PUT', url: route, params: data})
         .then(data => {
          resolve(data);
         }).catch(err =>{
           reject(err);
         })
       })
  }


 //------------------------
  let descuentos = function(){


    getLinea({},'/descuentos').then(data => {

      let estado= data.data;
      let descuentos= $(".descuento");

      for(let i=0; i < descuentos.length; i++){
        console.log(estado[i].estadodescuento)
        $(descuentos[i]).attr("iddescuento",estado[i].iddescuento);

        if(estado[i].estadodescuento){

          $(descuentos[i]).text('Activo');
        }else{
          $(descuentos[i]).text('Inactivo');
        }
      }
    })
    .catch(err => {
      console.log(err);
    })
  }

  descuentos();

   let filaSeleccionada= function(){

     if(typeof $scope.descuentoSelected === 'undefined'){
        console.log("indefinido")
        return true;
     }else{
      return false;
     }
   }

    $scope.cargarModalDescuentoEditar= function(descuentoSelected){

      if(filaSeleccionada()){
        alert("Seleccione una fila de la tabla para editar información");
      }else{
        $('#actualizar-descuento-modal').modal('toggle');

         $("#descripciondescuentoActualizar").val(descuentoSelected.descripciondescuento)
         $("#porcentajedescuentoActualizar").val(descuentoSelected.porcentajedescuento)
      }

   }

   $scope.cargarModalDescuentoEliminar= function(descuentoSelected){

    if(filaSeleccionada()){
      alert("Seleccione una fila de la tabla para eliminar información");
    }else{
      $('#eliminar-descuento-modal').modal('toggle');

       $("#descripciondescuento").val(descuentoSelected.descripciondescuento)
       $("#porcentajedescuento").val(descuentoSelected.porcentajedescuento)
    }

 }

 $scope.insertarDescuento= function(descuento){

    let descripcion='';
    let porcentaje=0;
    let data={};

    if(document.getElementById("descripciondescuento").value === "" ||
      document.getElementById("porcentajedescuento").value === ""){
      alert("Todos los campos son requeridos");
    }else{
      console.log(descuento);

      descripcion= descuento.descripciondescuento;
      porcentaje= descuento.porcentajedescuento;

      data= {
        descripcion: descripcion,
        porcentaje: porcentaje
      }


        insertarFila(data, '/new_discount_table').then(new_discount => {
          console.log(new_discount)
          if(new_discount.status===200){
            loadData($scope, $http, $log, '/descuentos', {});
            descuentos();
            alert("Descuento guardado correctamente");
            descuento.porcentajedescuento='';
            descuento.descripciondescuento='';
            $("#descuento-modal").modal("hide");
          }
        })
        .catch(err => {
          console.error(err);
        })
      }
    }


   $scope.editarDescuento = function(descuentoSelected){

      let porcentaje=0;
      let descripcion='';
      let iddescuento=0;
      let data={};

    if(document.getElementById("descripciondescuentoActualizar").value === "" ||
      document.getElementById("porcentajedescuentoActualizar").value === ""){
      alert("Todos los campos son requeridos");

    }else{

        porcentaje= document.getElementById("porcentajedescuentoActualizar").value;
        descripcion= document.getElementById("descripciondescuentoActualizar").value;
        iddescuento= descuentoSelected.iddescuento;
        data={
          porcentaje: porcentaje,
          descripcion: descripcion,
          idDescuento: iddescuento
        }

        console.log(data);

        actualizarLinea(data, '/update_discount_table').then(descuentoActualizar => {
          if(descuentoActualizar.status === 200){
            loadData($scope, $http, $log, '/descuentos', {});
            descuentos();
            document.getElementById("porcentajedescuentoActualizar").setAttribute("value",'');
            document.getElementById("descripciondescuentoActualizar").setAttribute("value",'');
            descuentoSelected.porcentajedescuento='';
            descuentoSelected.descripciondescuento='';
            $scope.descuentoSelected = undefined;
            $("#actualizar-descuento-modal").modal("hide");
            alert("Descuento actualizado");
          }else{
            alert("No se pudo actualizar el descuento");
          }
        })
        .catch(err => {console.error(err); })
      }
    }

$scope.eliminarDescuento= function(descuentoSelected){


         let id='';
          let data={};
          id= descuentoSelected.iddescuento;

          data={
            iddescuento:id
          };
        getLinea(data,'/delete_discount').then(discountDeleted => {
            if(discountDeleted.status === 200){
              loadData($scope, $http, $log, '/descuentos', {});
              descuentos();
              alert("Descuento eliminado correctamente");
              descuentoSelected.porcentajedescuento='';
              descuentoSelected.descripciondescuento='';
              $scope.descuentoSelected = undefined
              $("#eliminar-descuento-modal").modal("hide");
            }else{
              alert("No se pudo eliminar el descuento");
            }
        }).catch(err => {
          console.log(err);
        })
   }

$scope.cambiarEstadoDescuento= function(descuento){

      console.log(descuento.estadodescuento);
      console.log(descuento.iddescuento);

      let id= descuento.iddescuento;
      let new_estado='';
      let data={};
      let arrayDescuentos= document.getElementsByClassName('descuento');

      console.log(arrayDescuentos)

      for(let i=0; i < arrayDescuentos.length; i++){
        if(arrayDescuentos[i].getAttribute('iddescuento') == descuento.iddescuento){
          if(descuento.estadodescuento) {
            new_estado=false;
            descuento.estadodescuento=false;
            arrayDescuentos[i].innerText='Inactivo';
          }else{
            new_estado=true;
            descuento.estadodescuento=true;
            arrayDescuentos[i].innerText='Activo';
          }
        }
      }

      data= {
        iddescuento: id,
        estado: new_estado
      }

      getLinea(data, '/disable_discount').then(statusDiscountChanged => {
        console.log(statusDiscountChanged)
      }).catch(err => { console.log(err ); })
   }

  $scope.rowClicked = function (descuento) {
     $scope.descuentoSelected={};
    $scope.selectedRow = false
    $scope.descuentoSelected = descuento
    if (typeof descuento.iddescuento !== 'undefined') {
      $scope.selectedRow = descuento.iddescuento
    }
  }
 $scope.clearData = function (template_Right) {
    $scope.receiver = {}
    scopeId = null
    $log.info('clearData()')
    $log.info($scope.template_Right)
    $scope.refresh($scope.template_Right)
    $scope.person_selected = []
  }

  $scope.sortReceiver = function (keyname) {
    $scope.sortKey = keyname // set the sortKey to the param passed
    $scope.reverse = !$scope.reverse // if true make it false and vice versa
  }

  $(document).ready(function () {
    getReceptoresData($scope, $http, $log)
    validateAlphanumeric()
    validateLetters()
    validateNumbers()
  })

  if (typeof $scope.template_Right === 'undefined') {
    $scope.template_Right = 'proveedores'
    $scope.template_Left = 'proveedores_table'
  }



})

.controller('impuestosController', function ($scope, $http, $log) {

  loadData($scope, $http, $log, '/impuestos', {});

  let insertarFila = (data, route) =>{
      return new Promise((resolve,reject) => {
        $http({ method: 'POST', url: route, params: data, data: data})
        .then(data => {
        resolve(data);
        }).catch(err =>{
          reject(err);
        })
      })
  }

  let getLinea= (data,route)=> {
  return new Promise((resolve,reject) => {
        $http({ method: 'GET', url: route, params: data})
        .then(data => {
        resolve(data);
        }).catch(err =>{
          reject(err);
        })
      })
  }

  let actualizarLinea= (data,route)=> {
  return new Promise((resolve,reject) => {
        $http({ method: 'PUT', url: route, params: data})
        .then(data => {
        resolve(data);
        }).catch(err =>{
          reject(err);
        })
      })
  }

  let ListarIumpuestos= () => {

    getLinea({},'/impuestos').then(listaImpuestos => {

        $scope.arrayImpuesto = listaImpuestos.data;
    })

  }
  ListarIumpuestos();
  $scope.cargarEstadoImpuestos= () => {

    getLinea({},'/impuestos').then( impuestos => {
      console.log(impuestos);
      let estado= impuestos.data;
      let arrayImpuestos= document.getElementsByClassName('impuesto');

      for(let i=0; i < arrayImpuestos.length; i++){
        arrayImpuestos[i].setAttribute("idimpuesto",estado[i].idimpuesto);
        if(estado[i].estadoimpuesto){
          arrayImpuestos[i].innerText='Activo';
        }else{
          arrayImpuestos[i].innerText='Inactivo';
        }
      }

    })
    .catch(error => { console.error(error)});
  }
  $scope.cargarEstadoImpuestos();
  //Funciones para manejo de base de datos

  $scope.filaSeleccionada= (impuesto_selected) => {

    if(typeof impuesto_selected === "undefined"){
      alert("Seleccione una fila para editar información");
    }else{

      $('#update-impuesto-modal').modal('toggle');
      console.log(impuesto_selected)
      $('#txtimpuestoActualizar').val(impuesto_selected.codigo_impuesto);
      $('#txtNombreImpuestoActualizar').val(impuesto_selected.nombre);
      $("#txtCodigoImpuestoActualizar").val(impuesto_selected.codigo_impuesto);
    }
  }

  $scope.cambiarEstadoTipoImpuesto = (tipoimpuesto) => {

    let TiposImpuesto= document.getElementsByClassName("tipoimpuesto");
    let new_estado='';
    let estadotexto='';
    let data={};
    for(let i=0; i < TiposImpuesto.length; i++){
      if(TiposImpuesto[i].getAttribute("idtipoimpuesto")== tipoimpuesto.idtipoimpuesto){

        if(tipoimpuesto.estadotipoimpuesto){
          console.log("false")
          new_estado=false;
          estadotexto='Inactivo';
          tipoimpuesto.estadotipoimpuesto=new_estado;
          TiposImpuesto[i].innerText=estadotexto;
        }else{
          console.log("true")
          new_estado=true;
          estadotexto='Activo';
          tipoimpuesto.estadotipoimpuesto=new_estado;
          TiposImpuesto[i].innerText=estadotexto;
        }
      }
    }

    data={
      idtipoimpuesto: tipoimpuesto.idtipoimpuesto,
      estado: new_estado
    }

    actualizarLinea(data,'/disabled_tipo_impuesto').then( tipoimpuestoUpdated => {
      console.log(tipoimpuestoUpdated)
    })
    .catch(err => { console.error(err); })

  }

  let camposVacios= (nombre, codigo) => { // funcion global para saber si hay datos vacios

      let nombreImpuesto= document.getElementById(nombre);
      let codigoImpuesto= document.getElementById(codigo);

      if(nombreImpuesto.value === "" || codigoImpuesto.value ===""){
        return true;

      }else{
        return false;
      }
  }

  $scope.cargarDataImpuesto= (impuesto, tipo) => {
    console.log(impuesto);
    console.log(tipo)
    if(tipo == 1){

      $scope.impuesto.nombreInsertar=impuesto.impuesto;
      $scope.impuesto.codigoInsertar=impuesto.id;

    }else{

      $scope.impuesto.nombreActualizar=impuesto.impuesto;
      $scope.impuesto.codigoActualizar=impuesto.id;
      console.log($scope.impuesto)
    }
  }
  //$scope.filaSeleccionada();

  $scope.insertImpuesto= (impuesto) => {
    if(camposVacios('txtNombreImpuestoInsertar','txtCodigoImpuestoInsertar')){
      alert("Los campos son requeridos");
    }else{

      let data={};
      let codigo='';
      let nombre ='';

      codigo= impuesto.id;
      nombre= impuesto.impuesto;

      data={
        nombreImpuesto: nombre,
        codigo
      }

      insertarFila(data,'/insert_impuesto').then(insertImpuesto => {
         if(insertImpuesto.status === 200){
          alert('Impuesto guardado');
          document.getElementById('txtNombreImpuestoInsertar').value='';
          document.getElementById('txtCodigoImpuestoInsertar').value='';
          let impuesto= document.getElementById('txtimpuestoInsertar')
          impuesto= impuesto.selectedIndex=null;
          loadData($scope, $http, $log, '/impuestos', {});
          cargarEstadoImpuestos();
         }else{
          alert("No se pudo guardar el impuesto")
         }
      }).catch(error => { console.error(error)})
    }
  }

  $scope.editarImpuesto= (impuesto) => {

    let nombre= impuesto.nombre;
    let codigo= impuesto.codigo_impuesto;
    let idimpuesto= impuesto.idimpuesto;
    let data={
      codigo,
      nombreImpuesto: nombre,
      idimpuesto
    };

    console.log(data);

    actualizarLinea(data,'/update_impuesto').then(impuestoUpdated => {
      if(impuestoUpdated.status===200) alert("Impuesto actualizado");
      else alert("No se pudo actualizar el impuesto");
    })
    .catch( errror => { console.error(error)})
  }

  $scope.cambiarEstadoImpuesto= (impuesto) => {
    console.log(impuesto.estadoimpuesto)
      let new_estado='';
      let idimpuesto=0;
      let data={};
      let arrayImpuestos= document.getElementsByClassName("impuesto");

    for(let i=0;  i < arrayImpuestos.length; i++){
      if(arrayImpuestos[i].getAttribute("idimpuesto") == impuesto.idimpuesto){

        if(impuesto.estadoimpuesto){
          console.log("false");
          new_estado=false;
          impuesto.estadoimpuesto=new_estado;
          arrayImpuestos[i].innerText='Inactivo';
        }else{
          console.log("true");
          new_estado=true;
          impuesto.estadoimpuesto=new_estado;
          arrayImpuestos[i].innerText='Activo';
        }
      }
    }

    data={
      idimpuesto: impuesto.idimpuesto,
      estado: new_estado
    }

    actualizarLinea(data,'/disabled_impuesto').then(impuestoDisabled => {
        console.log(impuestoDisabled)
    })
    .catch(error => { console.error(error); })
  }

  $scope.cargarTiposImpuesto = (id) => {

    let idimpuesto=id;
    let data={
      idimpuesto
    }
   /* getLinea(data, '/tipos_impuesto').then(response => {

      $scope.tipoImpuestos= response.data;

    }).catch(err => { console.error(err)})*/
   $http({
      method: 'GET',
      url: '/tipos_impuesto',
      params: data
    }).then(function (response) {

      let tipoImpuestos={};
      tipoImpuestos= response.data;
      let estado=true;
      let ind_activo='';
      let tipos={};

      for(let i in tipoImpuestos){

        if(tipoImpuestos[i].estadotipoimpuesto){
          estado=true;
          ind_activo='Activo';
        }else{
          estado=false;
          ind_activo='Inactivo';
        }

        tipos[i]={
          'descripcionimpuesto': tipoImpuestos[i].descripcionimpuesto,
          'estadotipoimpuesto': estado,
          'idimpuesto': tipoImpuestos[i].idimpuesto,
          'idtipoimpuesto': tipoImpuestos[i].idtipoimpuesto,
          'porcentajetipoimpuesto': tipoImpuestos[i].porcentajetipoimpuesto,
          'ind_activo': ind_activo,
          'nombre': tipoImpuestos[i].nombre,
        };
      }

      $scope.arrFromMyObj = Object.keys(tipos).map(function(key) {
        return tipos[key];
      });

    }
    , function errorCallback (response) {
      $log.error(response)
    }).catch(function (error) {
      $log.error(error)
    })
  }


  //"#update-impuesto-modal"

  $scope.ObtenerImpuesto = {
    '1': {
      consecutivo: 11,
      id: '01',
      impuesto: 'Impuesto General sobre las Ventas',
      porimp: '13',
      tipoImpuesto:{
        '1':{
          'idimpuesto': 11,
          'descripcion': 'Tabaco en rama o sin elaborar; desperdicios de tabaco',
          'porcentaje': 5
        },
        '2':{
          'idimpuesto': 11,
          'descripcion': 'Cigarros (puros) (incluso despuntados)',
          'porcentaje': 5
        },
        '3':{
          'idimpuesto': 11,
          'descripcion': 'Cigarritos (puritos) y cigarrillos de tabaco o de sucedáneos del tabaco',
          'porcentaje': 5
        },
        '4':{
          'idmpuesto': 11,
          'descripcion': 'Los demás tabacos y sucedáneos del tabaco, elaborados; tabaco “homogeneizado” o “reconstituido”; extractos y jugos de tabaco',
          'porcentaje': 5
        },
        '5':{
          'idmpuesto': 11,
          'descripcion': 'Venta afecta a tarifa general',
          'porcentaje': 13
        },
        '6':{
          'idmpuesto': 11,
          'descripcion': 'Venta de energía eléctrica residencial(*)',
          'porcentaje': 5
        },
        '7':{
          'idmpuesto': 11,
          'descripcion': 'Venta de madera(**)',
          'porcentaje': 10
        },
      }
    },
    '2': {
      consecutivo: 7,
      id: '02',
      impuesto: 'Impuesto Selectivo de Consumo',
      porimp: '95',
      tipoImpuesto:{
        '1':{
          'idimpuesto': 7,
          'descripcion': 'Tabaco en rama o sin elaborar; desperdicios de tabaco',
          'porcentaje': 5
        },
        '2':{
          'idimpuesto': 7,
          'descripcion': 'Cigarros (puros) (incluso despuntados)',
          'porcentaje': 5
        },
        '3':{
          'idimpuesto': 7,
          'descripcion': 'Cigarritos (puritos) y cigarrillos de tabaco o de sucedáneos del tabaco',
          'porcentaje': 5
        },
        '4':{
          'idmpuesto': 7,
          'descripcion': 'Los demás tabacos y sucedáneos del tabaco, elaborados; tabaco “homogeneizado” o “reconstituido”; extractos y jugos de tabaco',
          'porcentaje': 5
        }
      }
    },
    '3': {
      consecutivo: 10,
      id: '03',
      impuesto: 'Impuesto Único a los combustibles',
      porimp: '6',
    tipoImpuesto:{
      '1':{
        'idimpuesto': 10,
        'descripcion': 'Gasolina súper',
        'porcentaje': 10
      },
      '2':{
        'idimpuesto': 10,
        'descripcion': 'Gasolina regular',
        'porcentaje': 10
      },
      '3':{
        'idimpuesto': 10,
        'descripcion': 'Diésel',
        'porcentaje': 10
      },
      '4':{
        'idmpuesto': 10,
        'descripcion': 'Asfalto',
        'porcentaje': 10
      },
      '5':{
        'idmpuesto': 10,
        'descripcion': 'Emulsión asfáltica',
        'porcentaje': 10
      },
      '6':{
        'idmpuesto': 10,
        'descripcion': 'Bunker',
        'porcentaje': 10
      },
      '7':{
        'idmpuesto': 10,
        'descripcion': 'LPG',
        'porcentaje': 10
      },
      '8':{
        'idmpuesto': 10,
        'descripcion': 'Av Gas',
        'porcentaje': 10
      },
      '9':{
        'idmpuesto': 10,
        'descripcion': 'Queroseno',
        'porcentaje': 10
      },
      '10':{
        'idmpuesto': 10,
        'descripcion': 'Diésel pesado (gasóleo)',
        'porcentaje': 10
      },
      '11':{
        'idmpuesto': 10,
        'descripcion': 'Nafta pesada',
        'porcentaje': 10
      },
      '12':{
        'idmpuesto': 10,
        'descripcion': 'Nafta liviana',
        'porcentaje': 10
      }
    }
  },
    '4': {
      consecutivo: 12,
      id: '04',
      impuesto: 'Impuesto específico de Bebidas Alcohólicas',
      porimp: '7',
      tipoImpuesto:{
        '1':{
          'idimpuesto': 12,
          'descripcion': 'Hasta 15%',
          'porcentaje': 4
        },
        '2':{
          'idimpuesto': 12,
          'descripcion': 'Más 15% hasta 30%',
          'porcentaje': 4
        },
        '3':{
          'idimpuesto': 12,
          'descripcion': 'Más de 30%',
          'porcentaje': 4
        }
      }
    },
    '5': {
      consecutivo: 5,
      id: '05',
      impuesto: 'Impuesto Específico sobre las bebidas envasadas sin contenido alcohólico y jabones de tocador',
      porimp: '2',
      tipoImpuesto:{
        '1':{
          'idimpuesto': 5,
          'descripcion': 'Bebidas gaseosas y concentrados',
          'porcentaje': 19
        },
        '2':{
          'idimpuesto': 5,
          'descripcion': 'Otras bebidas liquidas (agua)',
          'porcentaje': 14
        },
        '3':{
          'idimpuesto': 5,
          'descripcion': 'Agua envases de 18 lts  ó más',
          'porcentaje': 6
        },
        '4':{
          'idimpuesto': 5,
          'descripcion': 'Por gramo de jabón',
          'porcentaje': 0.2
        }
      }
    },
    '6': {
      consecutivo: 8,
      id: '06',
      impuesto: 'Impuesto a los Productos de Tabaco',
      porimp: '8',
      tipoImpuesto:{
        '1':{
          'idimpuesto': 8,
          'descripcion': 'Tabaco en rama o sin elaborar; desperdicios de tabaco',
          'porcentaje': 5
        },
        '2':{
          'idimpuesto': 8,
          'descripcion': 'Cigarros (puros) (incluso despuntados)',
          'porcentaje': 5
        },
        '3':{
          'idimpuesto': 8,
          'descripcion': 'Cigarritos (puritos) y cigarrillos de tabaco o de sucedáneos del tabaco',
          'porcentaje': 5
        },
        '4':{
          'idmpuesto': 8,
          'descripcion': 'Los demás tabacos y sucedáneos del tabaco, elaborados; tabaco “homogeneizado” o “reconstituido”; extractos y jugos de tabaco',
          'porcentaje': 5
        }
      }
    },
    '7': {
      consecutivo: 9,
      id: '98',
      impuesto: 'Otros',
      porimp: '10',
      tipoImpuesto:{
        '1':{
          'idimpuesto': 9,
          'descripcion': 'Otros',
          'porcentaje': 10
        }
      }
    }
  }

    $scope.escogerImpuesto = (impuesto) => {
      console.log(impuesto.impuesto)
      $("#txttdescripciontipoimpuesto").val("")
      $("#txtporcentajetipoimpuesto").val("")
      $("#txtNombreImpuesto").val(impuesto.impuesto)//$scope.tipoimpuesto.impuesto= impuesto.impuesto
      $scope.tiposImpuesto={};
      $scope.tiposImpuesto= impuesto.tipoImpuesto;


    }

    $scope.escogerTipoImpuesto= function(tipoimpuesto){
     console.log(tipoimpuesto)
     $("#txttdescripciontipoimpuesto").val(tipoimpuesto.descripcion)
     $("#txtporcentajetipoimpuesto").val(tipoimpuesto.porcentaje)

    }

    $scope.insertarTipoImpuesto = function(tipoimpuesto){

      if(camposVacios('txttdescripciontipoimpuesto','txtporcentajetipoimpuesto')) {
        alert("Todos los campos son requeridos");
        return;
      }else{
        let data={
          idimpuesto: tipoimpuesto.idimpuesto,
          descripcion: tipoimpuesto.descripcion,
          porcentaje: tipoimpuesto.porcentaje
        }

        insertarFila(data, '/insert_tipo_impuesto').then(nuevotipoimpuesto => {
          if(nuevotipoimpuesto.status === 200){
            alert("Insertado correctamente");
          }
        })
      }
    }
      $scope.rowClicked = function (impuesto) {
        $scope.impuesto_selected={};
      $scope.selectedRow = false
      $scope.impuesto_selected = impuesto
      if (typeof impuesto.idimpuesto !== 'undefined') {
        $scope.selectedRow = impuesto.idimpuesto
      }
    }

    //rowClickedTipoImpuesto
    $scope.rowClickedTipoImpuesto = function (tipoimpuesto) {
      $scope.tipoimpuesto_selected={};
      $scope.selectedRow = false
      $scope.tipoimpuesto_selected = tipoimpuesto
      if (typeof tipoimpuesto.idtipoimpuesto !== 'undefined') {
        $scope.selectedRow = tipoimpuesto.idtipoimpuesto
      }
      console.log($scope.tipoImpuestos)
    }
  $scope.sortReceiver = function (keyname) {
    $scope.sortKey = keyname // set the sortKey to the param passed
    $scope.reverse = !$scope.reverse // if true make it false and vice versa
  }

  $(document).ready(function () {

    validateAlphanumeric()
    validateLetters()
    validateNumbers()
  })

  $scope.refresh = function (templateRight) {
    if (templateRight === 'sell_products') {
      $scope.refreshProduct()
    } else if (templateRight === 'raw_products') {
      $scope.refreshInventory()
    } else {
      $log.error('templateRight does not match')
      $log.error(templateRight)
    }
  }


  if (typeof $scope.template_Right === 'undefined') {
    console.log("llegó")
    $scope.template_Right = 'sell_products'
    $scope.template_Left = 'sell_products_table'
  }


   $scope.template_Right_action = function (key) {
    if (key === 'raw') {
      $scope.template_Right = 'raw_products'
    }
  }

}).controller('credencialesEmisorController', function ($scope, $http, $log) {

  let actualizarLinea= (data,route)=> {
    return new Promise((resolve,reject) => {
         $http({ method: 'PUT', url: route, params: data})
         .then(data => {
          resolve(data);
         }).catch(err =>{
           reject(err);
         })
       })
  }

  $http.get('/emisor').then(function success(response){

        if(response.data.length > 0){
         document.getElementById('nombrecompleto').readOnly = true;
          document.getElementById('email_user').readOnly = true;
          $("#nombrecompleto").val(response.data[0].e_nombre)
          $("#email_user").val(response.data[0].e_correoelectronico)

          console.log(response.data[0])
        }else{
          alert("Configure la informacion en la pantalla del emisor")
        }

      },
       function error(err){
        console.log(err);
        alert("Se ha producido un error al cargar la información del emisor")
      });

  $http.get('/emisor/username_password').then(function success(response){

       if(response.data.length > 0){
          //document.getElementById('username').readOnly = true;
          ///emisor/username_passworddocument.getElementById('pwd').readOnly = true;
          $("#username").val(response.data[0].user_api)
          $("#pwd").val(response.data[0].pwd_api)

        }else{
          console.log("No trae nada")
        }
  },
    function error(err){
     alert("Se ha producido un error al cargar la información para la autenticación de la api CRLibre");
  });


  $scope.insertarCredenciales = function(emisor) {
    console.dir(emisor)

    if ($("#nombrecompleto").val() == "" || $("#username").val() == "" || $("#pwd").val() == "" ||
      $("#email_user").val() == "" || $("#ubicacion_user").val() == "" || $("#about").val() == "" ||
      $("#key_username").val() == "" || $("#key_pwd").val() == "" || $("#idFile").val() == "" ||
      $("#downloadCode").val() == "" || $("#idUserAPI").val() == "" || $("#pin").val() == "") {
      alert("Todos los campos son requeridos");
    } else {
      var credencialesEmisor = {
        '1': {
          nombre: $("#nombrecompleto").val(),
          username: $("#username").val(),
          pwd: $("#pwd").val(),
          email: $("#email_user").val(),
          ubicacion: emisor.ubicacion_user,
          acerca: emisor.about,
          downloadCode: emisor.downloadCode,
          idFile: emisor.idFile,
          idUserAPI: emisor.idUserAPI,
          key_username: $("#key_username").val(),
          key_pwd: $("#key_pwd").val(),
          pin: $("#pin").val()
        }
      }

      var data = {
        '1': {
          key_username: emisor.key_username,
          key_pwd: emisor.key_pwd,
          pin: emisor.pin,
          email: $("#email_user").val(),
          nombre: $("#nombrecompleto").val()
        }
      }

      var dataUser = {
        '1': {
          user_api: emisor.username,
          pwd_api: emisor.pwd
        }
      }
      console.log("Credenciales ", credencialesEmisor)

      actualizarLinea(credencialesEmisor[1], '/emisor/credentials/update').then(response0 => {

        insertPromise($scope, $http, $log, '/login', credencialesEmisor[1], false).then(response => {
          if ($scope.insertResult.resp.sessionKey !== 'undefined' && $scope.insertResult.resp.userName !== 'undefined') {
            sessionKeyGlobal = $scope.insertResult.resp.sessionKey
            userNameAPIGlobal = $scope.insertResult.resp.userName
            if (DEBUG) {
              console.log("sessionKey: ", sessionKeyGlobal)
            }
          }

          getPromise($scope, $http, $log, '/emisor/username_password', dataUser[1], false).then(user => {

            if (user != "" && typeof sessionKeyGlobal === 'undefined') {
              // ToDo Deprecate
              updatePromise($scope, $http, $log, '/guardar_credenciales', data[1])
              return alert("El usuario ha sido actualizado");
            } else {

              if (typeof sessionKeyGlobal !== 'undefined') {

                //updatePromise($scope, $http, $log, '/guardar_credenciales', data[1]) DEPRECATED
                //updatePromise($scope, $http, $log, '/emisor/update_data_users', dataUser[1])  DEPRECATED
                //updatePromise($scope, $http, $log, '/emisor/update_data_users', dataUser[1])  DEPRECATED

                limpiarFormCredencialesEmisor();

                $("#nombrecompleto").val(credencialesEmisor[1].nombre)
                $("#email_user").val(credencialesEmisor[1].email)
                $("#username").val(credencialesEmisor[1].username)
                $("#pwd").val(credencialesEmisor[1].pwd)

                document.getElementById('nombrecompleto').readOnly = true;
                document.getElementById('email_user').readOnly = true;
                //document.getElementById('username').readOnly = true;
                //document.getElementById('pwd').readOnly = true;
                return alert('El usuario ' + userNameAPIGlobal + ' ha sido guardado con éxito');

              } else {
                return alert("El usuario " + userNameAPIGlobal + " ya existe en la api, inserte otro")

              }
            }
          })
        })
      })
    }

    }
    //user1011
    //1234
    })
.controller('FileUploadController', ['$scope', '$http',
    function($scope, $http) {
      $scope.file = '';

      $scope.sendFile = function(response) {
        var archivo = $("#file").val();
        var extension = archivo.substring(archivo.lastIndexOf("."));
        console.log('extension de archivo ',extension);
        if(document.getElementById("file").files.length == 0){
          alert("No ha seleccionado ningún archivo")
        }else{

        if(extension !=='.p12'){
          alert("El tipo de archivo no está permitido");
          var inputFile = document.getElementById("file");
           inputFile.value = '';
           //$('#up').attr("disabled", true);
        }else{
        var ajax=$http.post('/upload', $scope.file, {
          headers: {
            'Content-Type': undefined
          }
        });


        if(typeof ajax.$$state !== 'undefined') {
           alert("Archivo cargado con éxito");
           var inputFile = document.getElementById("file");
           inputFile.value = '';
         }
        else alert("No se cargó el archivo en el servidor")
          var inputFile = document.getElementById("file");
           inputFile.value = '';
        }
      }
      };
    }
  ])
  .directive('fileChanged', function() {
    return {
      restrict: 'A',
      scope: {
        model: '=',
        prop: '@'
      },
      link: function(scope, element) {
        function changeEvt(evt) {
          var fd = new FormData();
          fd.append(scope.prop || 'myFile', evt.target.files[0]);
          scope.$apply(function() {
            scope.model = fd;
          });

        }

        element.on('change', changeEvt);

        scope.$on('$destroy', function() {
          element.off('change', changeEvt);
        })
      }
    }
  })
// No aplica para SOPA-BAR
/* function getAccountDataDelete($scope) {
  $scope.sendDataDeleteAccount = function (idCuenta, nombreCliente, apellidoCliente) {
    $('#txtCuentaClienteDelete').val(nombreCliente + ' ' + apellidoCliente)
      scopeId = idCuenta;
      $scope.refresh()
    }
  } */

// PRODUCT BUTTONS
// PRODUCTOS
function insert_xml ($scope, $http, $log, xml) {
  console.log("data xml:", xml)


  $http({
    method: 'POST',
    url: '/insert_xml',
    params: xml,
    data: data
  }).then(function (response) {
    $log.info("response in insert_xml")
    $log.info(response.config.params.id)
    $log.info(response.config.params.data_xml)
    var data = {
    idXml: response.config.params.id,
    dataXml: response.config.params.data_xml
    }


    $http({
        method: 'GET',
    url: '/sendXMLtoEmail',
    params: data
    }).then(function(response){
        $log.info(response)
    }, function errorCallback(error) {
        $log.error(error)
    }).catch(function (error) {
        $log.error(error)
    })

  }, function errorCallback (response) {
    $log.error(response)
  }).catch(function (error) {
    $log.error(error)
  })
}


function sendDataForXML ($scope, $http, $log, data) {
  console.log("data send:", data)
  $http({
    method: 'POST',
    url: 'send_to_crlibre_for_xml',
    params: data,
    data: data
  }).then(function (response) {
    $log.info(response)
  }, function errorCallback (response) {
    $log.error(response)
  }).catch(function (error) {
    $log.error(error)
  })
}

function insertDataUser($scope, $http, $log, route ,data){
   $http({
    method: 'POST',
    url: route,
    params: data,
    data: data
  })
}

function getProductData ($scope) {

  $scope.sendData = function (product_selected){

    if(typeof product_selected === 'undefined'){
      return alert("Seleccione un producto para editar");
    }else{
          //product_selected.idproducto, product_selected.descripcionproducto, product_selected.precioproducto ,
    // product_selected.costounitario ,product_selected.descripcioncategoria, product_selected.idcategoria,
    //product_selected.impuesto,product_selected.montoimpuesto,
    //product_selected.unidadmedida,product_selected.unidadmedidacomercial, product_selected.tipo_producto,
    //product_selected.codigoproducto, product_selected.precio_ivi
     // console.log("producto  ",product_selected)
      console.log("PRODUCTO ",product_selected)

      $('#update-producto-modal').modal({show:true});

      let codigoproducto;
      let precio_ivi;
      let categorias;
      let tipoProducto;
      let unidadMedida;
      let clasificacionProducto;
      let tipoImpuesto;

      if(product_selected.codigoproducto === null) codigoproducto='';
      else codigoproducto= product_selected.codigoproducto;
      if(product_selected.precio_ivi === null) precio_ivi='';
      else precio_ivi= product_selected.precio_ivi;

      // llenar los campos

      document.getElementById("txtDescripcionProductoAC").setAttribute("value",product_selected.descripcionproducto);
      document.getElementById("txtCodigoProductoAC").setAttribute("value",codigoproducto);
      document.getElementById("txtPrecioProductoAC").setAttribute("value",product_selected.precioproducto);
      //document.getElementById("txtPrecioIVIAC").setAttribute("value",precio_ivi);
      document.getElementById("txtCostoUnitarioAC").setAttribute("value", product_selected.costounitario);
      document.getElementById("txtUnidadMedidaComercialAC").setAttribute("value", product_selected.unidadmedidacomercial);

      categorias= document.getElementById("txtDescripcionCategoriaAC");
      unidadMedida= document.getElementById("txtDescripcionUnidadMedidaAC");
      clasificacionProducto = document.getElementById("clasificacioProductoAC");
      tipoImpuesto= document.getElementById("txtTipoImpuestoAC");

      for (let i = 0; i < categorias.length; i++) {

          if(categorias.options[i].value == product_selected.idcategoria){
            categorias.options[i].selected=true;
          }
      }

      for (let i = 0; i < unidadMedida.length; i++) {

          if(unidadMedida.options[i].value == product_selected.unidadmedida){
            unidadMedida.options[i].selected=true;
          }
      }

      $scope.clasificacionProductos.forEach((clasificacion,i) =>{
        console.log("opciones ",clasificacionProducto.options[i].value);
       // console.log("opcion BD ",product_selected.codigo_impuesto);
        if(clasificacionProducto.options[i].value == product_selected.codigo_impuesto){
          clasificacionProducto.options[i].selected=true;

          $scope.cargarCodigoImpuesto(product_selected,'Text');

          setTimeout(() =>{
              for (let i = 0; i < tipoImpuesto.length; i++) {

                if(tipoImpuesto.options[i].value == product_selected.tipo_impuesto){

                  tipoImpuesto.options[i].selected=true;
                  let impuesto ={
                    porcentaje: product_selected.porcentajeimpuesto
                  }

                $scope.calcularImpuesto(product_selected.precioproducto,'txtporcentajeImpuestoAC','txtImpuestoValorAC',impuesto,'txtPrecioIVAAC','txtPrecioProductoAC');

                }
              }
          },800)
        }
      })
    }
  }
}
//494
function getProductInventory ($scope) {
  $scope.sendDataInventoryProduct = function (id, descripcionProducto, idProveedor, cantidadDisponible, costoUnitario, tieneInventario, idCategoria) {
    if (tieneInventario === 'No') { $('#cargar-inventario-modal').modal('toggle') }
    scopeId = id
    $('#descripcionProducto').val(scopeId)
    $('#empresa').val(idProveedor)
    $('#txtCantidadProducto').val(cantidadDisponible)
    $('#txtCostoProducto').val(costoUnitario)
    $('#descripcionCategoriaProducto').val(idCategoria)
    $('#txtCostoProducto')[0].disabled = true
    $('#descripcionCategoriaProducto')[0].disabled = true
    $('#descripcionProducto')[0].disabled = true
    $('#empresa').val(idProveedor)[0].disabled = true
  }

  $scope.sendDataInventory = function () {
    $('#txtCostoProducto')[0].disabled = false
    $('#descripcionCategoriaProducto')[0].disabled = false
    $('#descripcionProducto')[0].disabled = false
    $('#empresa')[0].disabled = false
  }
}

function getProductDataDelete ($scope) {
  $scope.sendDataDelete = function (id, descripcionProducto) {
    $('#txtDescripcionProductoDelete').val(descripcionProducto)
    scopeId = id
  }
}

// INVENTARIOS
function getInventoryData ($scope) {
  $scope.sendDataInventory = function (idInventario, idCategoriaInventario, descripcionInventario, cantidadDisponible, costo, cantidadMinima, unidad) {
    scopeId = idInventario
    $('#txtDescripcionInventario').val(descripcionInventario)
    $('#txtDescripcionCategoriaInventario').val(idCategoriaInventario)
    $('#txtCantidadDisponible').val(cantidadDisponible)
    $('#txtCostoInventario').val(costo)
    $('#txtCantidadMinima').val(cantidadMinima)
    $('#txtUnidadMedida').val(unidad)
  }

  $scope.sendDataInventoryForLoad = function (idInventario, descripcionInventario) {
    scopeId = idInventario
    $('#descripcionInventario').val(idInventario)
  }

  $scope.sendDataDeleteInventory = function (idInventario, descripcionInventario) {
    $('#txtDescripcionInventarioDelete').val(descripcionInventario)
    scopeId = idInventario
  }
}

// PERSONAS BUTTONS
// PROVEEDORES
function getProveedoresData ($scope) {
  $scope.sendDataDeleteProveedor = function (idProveedor, empresa) { $('#txtEmpresaDelete').val(empresa) }

  $scope.sendDataUpdateProveedor = function (idProveedor, empresa, nombreContacto, contacto1, contacto2, correo, observacion) {
    $('#txtEmpresa').val(empresa)
    $('#txtNombreContacto').val(nombreContacto)
    $('#txtContacto1').val(contacto1)
    $('#txtContacto2').val(contacto2)
    $('#txtCorreo').val(correo)
    $('#txtObservacion').val(observacion)
  }
}

function getReceptoresData ($scope, $http, $log) {
  $scope.sendDataDeleteReceptor = function (receptor_numero, nombre) {
    $('#txtNumeroReceptorDelete').val(receptor_numero)
    $('#txtnombreReceptorDelete').val(nombre)
  }

  $scope.sendDataUpdateReceptor = function (nombre, identificacion_tipo, identificacion_numero, nombrecomercial, codigo_provincia,
    id_canton, id_distrito, ubicacion_otras_senas, codigo_pais, telefono_numero, fax_codigopais,
    fax_numero, correoelectronico)
  {
    console.log($scope.person_selected)
    //data-toggle="modal" data-target="#update-receiver-modal"

    if( typeof $scope.person_selected === 'undefined'){
      alert("Debe seleccionar un receptor")  // evitar errores de enviar valores indefinidos al controlador
    }else{
      //$('#delete-receptor-modal').modal('toggle')


    var contador=0;
      var identificacion_numero_update='';
    $('#nombre_Update').val(nombre)
    $('#tipo_id_Update').val(identificacion_tipo)
    if (identificacion_tipo === '01') {
      $('#txt_num_tipoIdentificacion_Update').val('000')

    } else if (identificacion_tipo === '02') {
      $('#txt_num_tipoIdentificacion_Update').val('00')

    } else if (identificacion_tipo === '03') {
      $('#txt_num_tipoIdentificacion_Update').val('0')

    } else {
      $('#txt_num_tipoIdentificacion_Update').val('00')

    }
    console.log(identificacion_numero)

    for (var i = 0; i < identificacion_numero.length; i++) {
      if(i < 3){
        if(identificacion_numero[i] == "0"){
          contador++;
        }
      }
    }

    identificacion_numero_update= identificacion_numero.substring(contador,identificacion_numero.length);
      console.log(identificacion_numero_update);
    $("#nombre_Update").val(nombre)
    $("#tipo_id_update").val(identificacion_tipo)
    $('#identificacion_numero_Update').val(String(identificacion_numero_update))
     $('#nombreComercial_Update').val(nombrecomercial)
     $('#id_provincia_update').val(codigo_provincia)


    var data = {codigo_provincia: codigo_provincia }

    $http({
      method: 'GET',
      url: '/location/canton',
      params: data
    }).then(function (response) {

      $scope.cantonUpdate = response.data

        for (var i = 0; i < $scope.cantonUpdate.length; i++) {
        if($scope.person_selected.id == $scope.cantonUpdate[i].id){
          console.log("igual");
          $scope.cantonEscogido=$scope.cantonUpdate[i].codigo_canton;
          console.log("canton escodigo ",$scope.cantonEscogido)
        }
      }
       $scope.distritoEscogido=$scope.person_selected.distrito;
          console.log("distrito escodigo ",$scope.distritoEscogido)
          console.log("provincia ",codigo_provincia)
      $('#update-receiver-modal').modal('show');

      //--------------------------------------
    }).catch(function (error) {
      $log.error(error)
    })

      //
    $('#otras_senas_Update').val(ubicacion_otras_senas)
    $('#cod_telefono_Update').val(codigo_pais)
    $('#telefono_numero_Update').val(telefono_numero)
    $('#fax_codigoPais_Update').val(fax_codigopais)
    $('#fax_numero_Update').val(fax_numero)
    $('#email_Update').val(correoelectronico)
    }
  }

}
// EMPLEADOS
function getEmpleadosData ($scope) {
  $scope.sendDataDeleteEmpleado = function (idempleado, nombre, apellido) {
    $('#txtEmpleadoDelete').val(nombre.trim() + ' ' + apellido.trim())
  }

  $scope.sendDataUpdateEmpleado = function (idempleado, nombre, apellido, idPuesto) {
    $('#txtNombre').val(nombre)
    $('#txtApellido').val(apellido)
    $('#txtDescripcionPuesto').val(idPuesto)
  }
}

// HTTP FUNCTIONS
function loadData ($scope, $http, $log, route, data, updateObject) {
  $http({
    method: 'GET',
    url: route,
    params: data
  }).then(function (response) {
    if (typeof updateObject === 'undefined' || updateObject) {
      $scope.object = response.data
    } else if (!updateObject) {
      return response.data
    } else {
      $log.error('loadData() has received an invalid value for updateObject flag')
    }
  }, function errorCallback (response) {
    $log.error(response)
    $log.error('callback function not exist')
  }).catch(function (error) {
    $log.error(error)
  })
}

function insert ($scope, $http, $log, route, data) {
  $http({
    method: 'POST',
    url: route,
    data: JSON.stringify(data)
  }).then(function (response) {
    $log.info(response)
    $scope.insertResult = response.data
    return response.data
  }, function errorCallback (response) {
    $log.error(response)
    return response.data
  }).catch(function (error) {
    $log.error(error)
    return error
  })
}

function update ($scope, $http, $log, route, data) {
  $http({
    method: 'PUT',
    url: route,
    data: JSON.stringify(data)
  }).then(function (response) {
    $log.info(response)
    return response.data
  }, function errorCallback (response) {
    $log.error(response)
    return response.data
  }).catch(function (error) {
    $log.error(error)
    return error
  })
}

/* function remove ($scope, $http, $log, route, data) {
  $http({
    method: 'DELETE',
    url: route,
    data: JSON.stringify(data)
  }).then(function (response) {
    $log.info(response)
  }).catch(function (error) {
    $log.error(error)
  })
} */

// PROMISES


function getPromise ($scope, $http, $log, route, data, updateObject) {
  return new Promise(function (resolve, reject) {
    if (typeof data === 'undefined') {
      reject('data is undefined: ' + data)
    } else {
      $http({
        method: 'GET',
        url: route,
        params: data
      }).then(function (response) {
        if (typeof updateObject === 'undefined' || updateObject) {
          $scope.object = response.data
          resolve(response.data)
        } else if (!updateObject) {
          resolve(response.data)
        } else {
          reject('loadData() has received an invalid value for updateObject flag')
        }
      }, function errorCallback (response) {
        $log.error(response)
        reject(response)
      }).catch(function (error) {
        $log(error)
      })
    }
  })
}
//--------------------------------------------

//-------------------------------------------
function updatePromise ($scope, $http, $log, route, data) {
  return new Promise(function (resolve, reject) {
    if (typeof data === 'undefined') {
      reject('data is: ' + data)
    } else {
      update($scope, $http, $log, route, data)
      resolve()
    }
  })
}
function update_order($scope, $http, $log, array){ // cargar el 
  let listaOrdenes=[];
  let obj=[];
  let data = {};

  console.log(array)
  for(let i=0; i < array.length; i++){
    console.log(array[i]);
  
  }
    
  listaOrdenes = Object.assign({}, listaOrdenes);
  console.log("listaOrdenes ",listaOrdenes);

 
     
}

function insertPromise ($scope, $http, $log, url, data) {
  return new Promise(function (resolve, reject) {
    if (typeof data === 'undefined') {
      reject('data is: ' + data)
    } else {
      let result = insert($scope, $http, $log, url, data)
      resolve(result)
    }
  })
}

// OTHER FUNCTIONS
function validateLetters () {
  $(function () {
    $('.validateLetters').on('input', function () {
      this.value = this.value.replace(/[^a-zA-ZñÑ ]/g, '')
    })
  })
}

function validateNumbers () {
  $(function () { // <-- wrapped here
    $('.validateNumbers').on('input', function () {
      this.value = this.value.replace(/[^0-9]/g, '') // <-- replace all other than given set of values
    })
  })
}

function validateAlphanumeric () {
  $(function () {
    $('.validateAlphanumeric').on('input', function () {
      this.value = this.value.replace(/[^\w+ñÑ ]/g, '') // <-- replace all other than given set of values
    })
  })
}

function hideModal (modal) { $(modal).modal('hide') }

function limpiarPantallaEmisor () {
  $('#nombre_emisor').val('')
  var tipo_id_emisor = document.getElementById('tipo_id_emisor')
  tipo_id_emisor.selectedIndex = null
  $('#identificacion_tipo_id').val('')
  $('.identificacion_numero_emisor').val('')
  $('.email_emisor').val('')
  var provincia = document.getElementById('provincia')
  provincia.selectedIndex = null
  var canton = document.getElementById('canton')
  canton.selectedIndex = null
  var distrito = document.getElementById('distrito')
  distrito.selectedIndex = null
  $('#otras_senas_emisor').val('')
  $('#tel_num_emisor').val('')
  $('#tel_cod_emisor').val('')
  $('#fax_cod_emisor').val('')
  $('#fax_tel_emisor').val('')
}

function limpiarFormReceptor(){
    var tipo_id_emisor = document.getElementById('tipo_id')
  tipo_id_emisor.selectedIndex = null
  var provincia = document.getElementById('id_provincia')
  provincia.selectedIndex = null
  var canton = document.getElementById('id_canton')
  canton.selectedIndex = null
  var distrito = document.getElementById('id_distrito')
  distrito.selectedIndex = null
  document.getElementById("mensaje").innerHTML='';
  $("#nombre").val("");
  $("#txt_num_tipoIdentificacion").val("");
    $(".identificacion_numero").val("");
    $("#otras_senas").val("");
    $("#nombreComercial").val("");
    $("#cod_telefono").val("");
    $("#telefono_numero").val("");
    $("#fax_codigoPais").val("");
    $("#fax_numero").val("");
    $("#email").val("");
}

function limpiarFormReceptorUpdate(){
  var tipo_id_emisor = document.getElementById('tipo_id_Update');
  tipo_id_emisor.selectedIndex = null;
  var provincia = document.getElementById('id_provincia_update');
  provincia.selectedIndex = null;
  var canton = document.getElementById('id_canton_update');
  canton.selectedIndex = null;
  var distrito = document.getElementById('id_distrito_update');
  distrito.selectedIndex = null;
   $("#mensaje").html('');
  $("#nombre_Update").val("");
  $("#txt_num_tipoIdentificacion_Update").val("");
    $("#identificacion_numero_Update").val("");
    $("#otras_senas_Update").val("");
    $("#nombreComercial_Update").val("");
    $("#cod_telefono_Update").val("");
    $("#telefono_numero_Update").val("");
    $("#fax_codigoPais_Update").val("");
    $("#fax_numero_Update").val("");
    $("#email_Update").val("");
}

function limpiarFormCredencialesEmisor(){

  $("#nombrecompleto").val("");
  $("#username").val("");
  $("#pwd").val("");
  $("#email_user").val("");
  $("#ubicacion_user").val("");
  $("#about").val("");
  $("#key_username").val("");
  $("#key_pwd").val("");
}


function limpiarFormProductosEditar(){


  document.getElementById("txtDescripcionProductoAC").setAttribute("value",'');
  document.getElementById("txtCodigoProductoAC").setAttribute("value",'');
  document.getElementById("txtPrecioProductoAC").setAttribute("value",'');
  //$('#txtDescripcionCategoria').val(idCategoria)
  document.getElementById("txtCostoUnitarioAC").setAttribute("value",'');
  document.getElementById("txtUnidadMedidaComercialAC").setAttribute("value",'');
  document.getElementById("txtporcentajeImpuestoAC").setAttribute("value",'');
  document.getElementById("txtImpuestoValorAC").setAttribute("value",'');
  //$('#txttipoproducto').val(tipoProducto)
  document.getElementById("txtDescripcionCategoriaAC").selectedIndex=null;
  document.getElementById("txttipoproductoAC").selectedIndex=null;
  document.getElementById("clasificacioProductoAC").selectedIndex=null;
  document.getElementById("txtTipoImpuestoAC").selectedIndex=null;
  document.getElementById("txtDescripcionUnidadMedidaAC").selectedIndex=null;


}


function limpiarFormProductosCrear(){

  document.getElementById("txtDescripcionProducto").value='';
  document.getElementById("txtPrecioProducto").value='';
  document.getElementById("txtCostoUnitario").value='';
  document.getElementById("txtCodigoProducto").value="";
  document.getElementById("txtporcentajeImpuesto").value='';
  //document.getElementById("txtSimboloUnidad").value='';
  document.getElementById("txtSimboloUnidadMedidaComercial").value='';
  document.getElementById("txtDescripcionCategoria").selectedIndex=null;

  let seleccionado = document.getElementById("txttipoproducto");
  for (let i = 0; i < seleccionado.options.length; i++) {
     // dejar seleccionada una opcion por defecto
      if(seleccionado.options[i].textContent == 'Mercancía' )
        seleccionado.options[i].selected=true;
  }
  document.getElementById("clasificacioProducto").selectedIndex=null;
  document.getElementById("txtTipoImpuesto").selectedIndex=null;
  document.getElementById("clasificacioProducto").selectedIndex=null;
  document.getElementById("txtDescripcionUnidadMedida").selectedIndex=null;

}




  /*$( "#nota-credito tbody" ).on( "click", "#btn_eliminarOrden", function() {// evento que escucha cuando
    // hay un click en el boton eliminar de algunas de las filas de la tabla
      console.log("idorden", $( this ).attr('idorden'));

        var idorden=$( this ).attr('idorden');
        var arrayOrders=$scope.ordersElementsModal;

            for (var i = 0; i < arrayOrders.length; i++) {
              if(arrayOrders[i].idorden == idorden){
                  $scope.porcentajeDescuento = Number($scope.dataSelected.porcentajedescuento)
                  $scope.subTotalPagar -= Number(arrayOrders[i].subtotal)
                  $scope.totalDescuento = $scope.subTotalPagar * $scope.porcentajeDescuento / 100
                  $scope.totalPagar = $scope.subTotalPagar - $scope.totalDescuento
                  $scope.montoPorPersona = $scope.totalPagar / Number($scope.dataSelected.cantidadpersonas)
                arrayOrders.splice(i,1);
              }
            }
    });*/

    /*$("#nota-credito tbody").on( "click", ".btn_editarCantidad", function() {

        var cantidad= $('.btn_editarCantidad');

        for(var i=0; i < cantidad.length; i++ ){
          $(cantidad[i]).parent().parent().children('#cantidad').attr("contentEditable","false");
          $(cantidad[i]).parent().parent().children('#cantidad').css("border",'solid 1px #FFFFFF');
        }

         $(this).parent().parent().children("#cantidad").attr("contentEditable","true");
         $(this).parent().parent().children('#cantidad').css("border",'solid 1px #E99E00');
         $(this).parent().parent().children('#cantidad').focus();
   });*/

   /*
    $( "#nota-credito tbody" ).on( "change", "#cantidadproducto", function() {

     var id= $(this).parent().parent().children("#Eliminar").children().attr('idorden');
     let subtotal = $(this).parent().parent().children().children("#subtotal_orden_nota_credito");
     var total=0;
     var cantidadproducto=  $(this).val();

     if(String(cantidadproducto).length == 0){

        $(this).val('1');
       cantidadproducto=$(this).val();
     }
     if(cantidadproducto == '0' || Number(cantidadproducto) < 0){

       $(this).val('1');
       cantidadproducto=$(this).val();
     }

      for(let i = 0; i < $scope.ordersElementsModal.length; i++){


        if($scope.ordersElementsModal[i].idorden == id){

           if(Number($scope.ordersElementsModal[i].cantidadproducto) < Number(cantidadproducto)){

               $(this).val('1');
               cantidadproducto=$(this).val();
             }

              $scope.porcentajeDescuento = Number($scope.dataSelected.porcentajedescuento)
              total = Number(cantidadproducto) * Number($scope.ordersElementsModal[i].preciounitarioproducto)
              $scope.ordersElementsModal[i].subtotal= total;
              subtotal.text("₡"+total+'.00');

        }

      }

      for (var i = 0; i < $scope.ordersElementsModal.length; i++) {
        $scope.subTotalPagar+=$scope.ordersElementsModal[i].subtotal
      }

              $scope.totalDescuento = $scope.subTotalPagar * $scope.porcentajeDescuento / 100
              $scope.totalPagar = $scope.subTotalPagar - $scope.totalDescuento
              $scope.montoPorPersona = $scope.totalPagar / Number($scope.dataSelected.cantidadpersonas)

              console.log($scope.ordersElementsModal);
   });

   */
/* $scope.compararIdsArray = function(i,cantidadProductoLinea, item){
      for (var e = 0; e < $scope.datosNotaCredito.length; e++) {
                  console.log("id orden notas ",$scope.datosNotaCredito[e].idorden)
                  console.log("id orden ordenes ",$scope.ordersElementsModal[i].idorden)
                  console.log("repetciones")
                    if($scope.datosNotaCredito[e].idorden ===  $scope.ordersElementsModal[i].idorden){

                      console.log("indefinido")

                           $scope.datosNotaCredito[e].cantidadproducto= cantidadProductoLinea;
                           $scope.datosNotaCredito[e].idorden= item.idorden;
                           $scope.datosNotaCredito[e].subtotal = item.preciounitarioproducto * cantidadProductoLinea;
                           $scope.datosNotaCredito[e].descuentoorden=item.descuentoorden;
                        Object.defineProperty($scope.datosNotaCredito[e], 'estado', {
                          value: "actualizado"
                        });

                     console.log($scope.datosNotaCredito[e].estado)
                    }
        }
    }

   $scope.insertInArray= function(i){
    $scope.datosNotaCredito.push({

                        cantidadproducto: $scope.ordersElementsModal[i].cantidadproducto,
                        codigo_producto: $scope.ordersElementsModal[i].codigo_producto,
                        codigoimpuesto: $scope.ordersElementsModal[i].codigoimpuesto,
                        codigoservicio: $scope.ordersElementsModal[i].codigoservicio,
                        condicion_venta: $scope.ordersElementsModal[i].condicion_venta,
                        costounitarioproducto: $scope.ordersElementsModal[i].costounitarioproducto,
                        descripcionproducto: $scope.ordersElementsModal[i].descripcionproducto,
                        descuentoorden: $scope.ordersElementsModal[i].descuentoorden,
                        estadoorden: $scope.ordersElementsModal[i].estadoorden,
                        exoneracion_tipodocumento: $scope.ordersElementsModal[i].exoneracion_tipodocumento,
                        idcuenta: $scope.ordersElementsModal[i].idcuenta,
                        idfactura: $scope.ordersElementsModal[i].idfactura,
                        idorden: $scope.ordersElementsModal[i].idorden,
                        idproducto: $scope.ordersElementsModal[i].idproducto,
                        montodescuento: $scope.ordersElementsModal[i].montodescuento,
                        montoimpuesto: $scope.ordersElementsModal[i].montoimpuesto,
                        naturalezadescuento: $scope.ordersElementsModal[i].naturalezadescuento,
                        nombreinstitucion: $scope.ordersElementsModal[i].nombreinstitucion,
                        plazo_credito: $scope.ordersElementsModal[i].plazo_credito,
                        porcentajedescuento: $scope.ordersElementsModal[i].porcentajedescuento,
                        porcentajeimpuesto: $scope.ordersElementsModal[i].porcentajeimpuesto,
                        preciounitarioproducto: $scope.ordersElementsModal[i].preciounitarioproducto,
                        procentajecompra: $scope.ordersElementsModal[i].procentajecompra,
                        subtotal: $scope.ordersElementsModal[i].subtotal,
                        tipo_producto: $scope.ordersElementsModal[i].tipo_producto,
                        tiposervicio: $scope.ordersElementsModal[i].tiposervicio,
                        unidadmedida: $scope.ordersElementsModal[i].unidadmedida,
                        unidadmedidacomercial: $scope.ordersElementsModal[i].unidadmedidacomercial
                    });
>>>>>>> develop
  }*/