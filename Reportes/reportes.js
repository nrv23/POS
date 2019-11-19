const pdf = require("html-pdf");


exports.crearReporteSinReceptor = (dataOrdenes, dataFactura) => {

    return new Promise((resolve, reject)=> {

    if(typeof dataFactura.consecutivo === "undefined" || JSON.stringify(dataOrdenes) === "{}" 
     || typeof dataFactura.emisor_numero === "undefined"){
        let error= new Error("informacion indefinida");
        reject(error)
        
    }else{
    
    listaOrdenes(dataOrdenes).then(data => {
        
    let ordenes=data;
    let impuesto=parseFloat(dataFactura.totalimpuesto).toFixed(2);
    let descuento=parseFloat(dataFactura.totaldescuentos).toFixed(2);
    let subTotal=parseFloat(dataFactura.totalventa).toFixed(2);
    let total=parseFloat(dataFactura.totalcomprobante).toFixed(2);
    let cedula=obtenerNumeros_Emisor_Receptor(dataFactura.emisor_numero);
    
    var content=`<!DOCTYPE html>
                    <html lang="en">
                    <head>
                        <meta charset="utf-8">
                        <title>Example 1</title>
                    <!-- <link rel="stylesheet" href="style.css" media="all" /> --> 

                    <style type="text/css">
                        .clearfix:after {
                                content: "";
                                display: table;
                                clear: both;
                            }

                            a {
                                color: #5D6975;
                                text-decoration: underline;
                            }

                            body {
                                position: relative;
                                width: 16cm;  
                                height: 29.7cm; 
                                margin: 0 auto; 
                                color: #001028;
                                background: #FFFFFF; 
                                font-family: Arial, sans-serif; 
                                font-size: 12px; 
                                font-family: Arial;
                            }

                            header {
                                padding: 10px 0;
                                margin-bottom: 30px;
                            }

                            #logo {
                                text-align: center;
                                margin-bottom: 10px;
                            }

                            #logo img {
                                width: 90px;
                            }

                            h1 {
                                border-top: 1px solid  #5D6975;
                                border-bottom: 1px solid  #5D6975;
                                color: #5D6975;
                                font-size: 2.4em;
                                line-height: 1.4em;
                                font-weight: normal;
                                text-align: center;
                                margin: 0 0 20px 0;
                                background: url(dimension.png);
                            }

                            #project {
                                float: left;
                            }

                            #project span {
                                color: #5D6975;
                                text-align: right;
                                width: 52px;
                                margin-right: 10px;
                                display: inline-block;
                                font-size: 0.8em;
                            }

                            #company {
                                float: right;
                                text-align: right;
                            }

                            #project div,
                            #company div {
                                white-space: nowrap;        
                            }

                            table {
                                width: 100%;
                                border-collapse: collapse;
                                border-spacing: 0;
                                margin-bottom: 20px;
                            }

                            table tr:nth-child(2n-1) td {
                                background: #F5F5F5;
                            }

                            table th,
                            table td {
                                text-align: center;
                            }

                            table th {
                                padding: 5px 20px;
                                color: #5D6975;
                                border-bottom: 1px solid #C1CED9;
                                white-space: nowrap;        
                                font-weight: normal;
                            }

                            table .service,
                            table .desc {
                                text-align: left;
                            }

                            table td {
                                padding: 20px;
                                text-align: right;
                            }

                            table td.service,
                            table td.desc {
                                vertical-align: top;
                            }

                            table td.qty,
                            table td.total {
                                font-size: 1.2em;
                            }
                            table td.unit {
                                1em;
                            }    
                            table td.grand {
                                border-top: 1px solid #5D6975;;
                            }

                            #notices .notice {
                                color: #5D6975;
                                font-size: 1.2em;
                            }

                            footer {
                                color: #5D6975;
                                width: 100%;
                                height: 30px;
                                position: absolute;
                                bottom: 0;
                                border-top: 1px solid #C1CED9;
                                padding: 8px 0;
                                text-align: center;
                            }
                    </style>
                    </head>
                    <body>
                        <header class="clearfix">
                        <div id="logo">
                            <img src="logo.png">
                        </div>
                        <h2><center>COMPROBANTE ELECTRÓNICO</center></h2>
                            <div>
                                <center>
                                <div><span>CLAVE</span> ${dataFactura.clavenumerica}</div>
                                <div><span>CONSECUTIVO</span> ${dataFactura.consecutivo}</div>
                                <div><span>FECHA</span> ${dataFactura.fecharegistrofactura}</div>
                                <div><span>TIPO COMPROBANTE</span> ${dataFactura.tipo}</div>
                                </center>
                            </div>
                        <br><br>
                        <div id="project"  style="margin-left: 20px;">
                            <div><span>INFORMACION DEL EMISOR</span></div>
                            <div><span>NOMBRE COMERCIAL</span> &nbsp&nbsp&nbsp <p>${dataFactura.e_nombre}</p></div>
                            <div><span>NOMBRE COMERCIAL</span> &nbsp&nbsp&nbsp <p>${dataFactura.e_nombrecomercial}</p></div>
                            <div><span>CEDULA</span> &nbsp&nbsp&nbsp <p>${cedula}</p></div>
                            <div><span>PROVINCIA</span> &nbsp&nbsp&nbsp <p>${dataFactura.e_provincia}</p></div>
                            <div><span>CANTON</span> &nbsp&nbsp&nbsp <p>${dataFactura.e_canton}</p></div>
                            <div><span>DISTRITO</span> &nbsp&nbsp&nbsp <p>${dataFactura.e_distrito}</p></div>
                            <div><span>OTRAS SEÑAS  </span> &nbsp&nbsp&nbsp <p>${dataFactura.e_otras_senas}</p></div>
                            <div><span>EMAIL</span> &nbsp&nbsp&nbsp <p><a href="mailto:${dataFactura.e_correoelectronico}">${dataFactura.e_correoelectronico}</a></p></div>
                            <div><span>TELEFONO</span> &nbsp&nbsp&nbsp <p>${dataFactura.emisor_telefono_numtelefono}</p></div>
                        </div>

                        </header>
                        <main>
                        <table>
                            <thead>
                            <tr>
                                <th class="service">Descripcion</th>
                                <th class="desc">Cantidad</th>
                                <th>Precio</th>
                                <th>Descuento</th>
                                <th>Impuesto</th>
                                <th>Subtotal</th>
                            </tr>
                            </thead>
                            <tbody>         
                            ${ordenes}        
                            <tr>
                                <td colspan="5">TOTAL IMPUESTOS</td>
                                <td class="total">${impuesto}</td>
                            </tr>
                            <tr>
                                <td colspan="5">TOTAL DESCUENTO</td>
                                <td class="total">${descuento}</td>
                            </tr>
                            <tr>
                                <td colspan="5">SUBTOTAL</td>
                                <td class="total">${subTotal}</td>
                            </tr>
                            <tr>
                                <td colspan="5" class="grand total">TOTAL FACTURA</td>
                                <td class="grand total">${total}</td>
                            </tr>
                            </tbody>
                        </table>
                        <div id="notices">
                            <div><center>NORMATIVA:</center></div>
                            <div class="notice"><center>Autorizado mediante resolucion DGT-R-48-2016 del 07/10/2016</center></div>
                            <br>
                            <div><center>TIPO DE CAMBIO:</center></div>
                            <div class="notice"><center>CRC.. 1.0000</center></div>
                        </div>
                        </main>
                    </body>
                    </html>`;
                resolve(content);    
            })
        }    
    });
}

 exports.crearReporteConReceptor = (dataOrdenes, dataFactura) => {

    return new Promise((resolve, reject)=> {

    
    if(typeof dataFactura.consecutivo === "undefined" || JSON.stringify(dataOrdenes) === "{}" 
     || typeof dataFactura.emisor_numero === "undefined" || typeof dataFactura.receptor_numero === "undefined"){
        let error= new Error("informacion indefinida");
        reject(error)
    }else{
  
    listaOrdenes(dataOrdenes).then(data => {
        
    let ordenes=data;
    let impuesto=parseFloat(dataFactura.totalimpuesto).toFixed(2);
    let descuento=parseFloat(dataFactura.totaldescuentos).toFixed(2);
    let subTotal=parseFloat(dataFactura.totalventa).toFixed(2);
    let total=parseFloat(dataFactura.totalcomprobante).toFixed(2);
    let cedula=obtenerNumeros_Emisor_Receptor(dataFactura.emisor_numero);
    let cedula_receptor=obtenerNumeros_Emisor_Receptor(dataFactura.receptor_numero);

    var content=`<!DOCTYPE html>
                <html lang="en">
                <head>
                    <meta charset="utf-8">
                    <title>Example 1</title>
                <!-- <link rel="stylesheet" href="style.css" media="all" /> --> 

                <style type="text/css">
                    .clearfix:after {
                            content: "";
                            display: table;
                            clear: both;
                        }

                        a {
                            color: #5D6975;
                            text-decoration: underline;
                        }

                        body {
                            position: relative;
                            width: 16cm;  
                            height: 29.7cm; 
                            margin: 0 auto; 
                            color: #001028;
                            background: #FFFFFF; 
                            font-family: Arial, sans-serif; 
                            font-size: 12px; 
                            font-family: Arial;
                        }

                        header {
                            padding: 10px 0;
                            margin-bottom: 30px;
                        }

                        #logo {
                            text-align: center;
                            margin-bottom: 10px;
                        }

                        #logo img {
                            width: 90px;
                        }

                        h1 {
                            border-top: 1px solid  #5D6975;
                            border-bottom: 1px solid  #5D6975;
                            color: #5D6975;
                            font-size: 2.4em;
                            line-height: 1.4em;
                            font-weight: normal;
                            text-align: center;
                            margin: 0 0 20px 0;
                            background: url(dimension.png);
                        }

                        #project {
                            float: left;
                        }

                        #project2 {
                            float: right;
                        }

                        #project span,
                        #project2 span{
                            color: #5D6975;
                            text-align: right;
                            width: 52px;
                            margin-right: 10px;
                            display: inline-block;
                            font-size: 0.8em;
                        }



                        #company {
                            float: right;
                            text-align: right;
                        }

                        #project div,
                        #project2 div,
                        #company div {
                            white-space: nowrap;        
                        }

                        table {
                            width: 100%;
                            border-collapse: collapse;
                            border-spacing: 0;
                            margin-bottom: 20px;
                        }

                        table tr:nth-child(2n-1) td {
                            background: #F5F5F5;
                        }

                        table th,
                        table td {
                            text-align: center;
                        }

                        table th {
                            padding: 5px 20px;
                            color: #5D6975;
                            border-bottom: 1px solid #C1CED9;
                            white-space: nowrap;        
                            font-weight: normal;
                        }

                        table .service,
                        table .desc {
                            text-align: left;
                        }

                        table td {
                            padding: 20px;
                            text-align: right;
                        }

                        table td.service,
                        table td.desc {
                            vertical-align: top;
                        }

                        table td.qty,
                        table td.total {
                            font-size: 1.2em;
                        }
                        table td.unit {
                            1em;
                        }    
                        table td.grand {
                            border-top: 1px solid #5D6975;;
                        }

                        #notices .notice {
                            color: #5D6975;
                            font-size: 1.2em;
                        }

                        footer {
                            color: #5D6975;
                            width: 100%;
                            height: 30px;
                            position: absolute;
                            bottom: 0;
                            border-top: 1px solid #C1CED9;
                            padding: 8px 0;
                            text-align: center;
                        }
                </style>
                </head>
                <body>
                    <header class="clearfix">
                    <div id="logo">
                        <img src="logo.png">
                    </div>
                    <h2><center>COMPROBANTE ELECTRÓNICO</center></h2>
                        <div>
                            <center>
                            <div><span>CLAVE</span> ${dataFactura.clavenumerica}</div>
                            <div><span>CONSECUTIVO</span> ${dataFactura.consecutivo}</div>
                            <div><span>FECHA</span> ${dataFactura.fecharegistrofactura}</div>
                            <div><span>TIPO COMPROBANTE</span> ${dataFactura.tipo}</div>
                            </center>
                        </div>
                    <br><br>
                    <div id="project"  style="margin-left: 20px;">
                            <div><span>DATOS DEL EMISOR</span></div>
                            <div><span>NOMBRE COMERCIAL</span> &nbsp&nbsp&nbsp <p>${dataFactura.e_nombrecomercial}</p></div>
                            <div><span>NOMBRE</span> &nbsp&nbsp&nbsp <p>${dataFactura.e_nombre}</p></div>
                            <div><span>CEDULA</span> &nbsp&nbsp&nbsp <p>${cedula}</p></div>
                            <div><span>PROVINCIA</span> &nbsp&nbsp&nbsp <p>${dataFactura.e_provincia}</p></div>
                            <div><span>CANTON</span> &nbsp&nbsp&nbsp <p>${dataFactura.e_canton}</p></div>
                            <div><span>DISTRITO</span> &nbsp&nbsp&nbsp <p>${dataFactura.e_distrito}</p></div>
                            <div><span>OTRAS SEÑAS  </span> &nbsp&nbsp&nbsp <p>${dataFactura.e_otras_senas}</p></div>
                            <div><span>EMAIL</span> &nbsp&nbsp&nbsp <p><a href="mailto:${dataFactura.e_correoelectronico}">${dataFactura.e_correoelectronico}</a></p></div>
                            <div><span>TELEFONO</span> &nbsp&nbsp&nbsp <p>${dataFactura.emisor_telefono_numtelefono}</p></div>
                    </div>

                    <div id="project2"  style="margin-right: 20px;">
                        <div><span>DATOS DEL RECEPTOR</span></div>
                        <div><span>NOMBRE COMERCIAL</span> &nbsp&nbsp&nbsp <p>${dataFactura.nombrecomercial}</p></div>
                        <div><span>NOMBRE</span> &nbsp&nbsp&nbsp <p>${dataFactura.nombre}</p></div>
                        <div><span>CEDULA</span> &nbsp&nbsp&nbsp <p>${cedula_receptor}</p></div>
                        <div><span>PROVINCIA</span> &nbsp&nbsp&nbsp <p>${dataFactura.provincia}</p></div>
                        <div><span>CANTON</span> &nbsp&nbsp&nbsp <p>${dataFactura.canton}</p></div>
                        <div><span>DISTRITO</span> &nbsp&nbsp&nbsp <p>${dataFactura.distrito}</p></div>
                        <div><span>OTRAS SEÑAS  </span> &nbsp&nbsp&nbsp <p>${dataFactura.otras_senas}</p></div>
                        <div><span>EMAIL</span> &nbsp&nbsp&nbsp <p><a href="mailto:${dataFactura.correoelectronico}">${dataFactura.correoelectronico}</a></p></div>
                        <div><span>TELEFONO</span> &nbsp&nbsp&nbsp <p>${dataFactura.receptor_telefono_numtelefono}</p></div>
                    </div>
                    </header>
                    <main>
                    <table>
                        <thead>
                        <tr>
                            <th class="service">Producto</th>
                            <th class="desc">Cantidad</th>
                            <th>Precio</th>
                            <th>Descuento</th>
                            <th>Impuesto</th>
                            <th>Subtotal</th>
                        </tr>
                        </thead>
                        <tbody>         
                        ${ordenes}        
                        <tr>
                            <td colspan="5">TOTAL IMPUESTOS</td>
                            <td class="total">${impuesto}</td>
                        </tr>
                        <tr>
                            <td colspan="5">TOTAL DESCUENTO</td>
                            <td class="total">${descuento}</td>
                        </tr>
                        <tr>
                            <td colspan="5">SUBTOTAL</td>
                            <td class="total">${subTotal}</td>
                        </tr>
                        <tr>
                            <td colspan="5" class="grand total">TOTAL FACTURA</td>
                            <td class="grand total">${total}</td>
                        </tr>
                        </tbody>
                    </table>
                    <div id="notices">
                        <div><center>NORMATIVA:</center></div>
                        <div class="notice"><center>Autorizado mediante resolucion DGT-R-48-2016 del 07/10/2016</center></div>
                        <br>
                        <div><center>TIPO DE CAMBIO:</center></div>
                        <div class="notice"><center>CRC.. 1.0000</center></div>
                    </div>
                    </main>
                </body>
                </html>`;
                resolve(content);    
            })
        }
    
    });
}

const listaOrdenes = (dataOrdenes) => {
    
    console.log(dataOrdenes);
    return new Promise((resolve, reject) => {

    if(JSON.stringify(dataOrdenes) === "{}") {

        let error= new Error("Informacion indefinida");
        reject(error);
    }

    else{  
    let content ="";
    
        for(let i in  dataOrdenes){
                console.log(dataOrdenes[i])
                let precio= parseFloat(dataOrdenes[i].preciounitarioproducto).toFixed(2);
                let descuento = parseFloat(dataOrdenes[i].montodescuento).toFixed(2);
                let total= parseFloat(dataOrdenes[i].montoitotallinea).toFixed(2);
                let impuesto =parseFloat(dataOrdenes[i].montoimpuesto).toFixed(2); 
                 content+=`<tr>
                    <td class="service">${dataOrdenes[i].descripcionproducto}</td>
                    <td class="desc">${dataOrdenes[i].cantidadproducto}</td>
                    <td class="unit">${precio}</td>
                    <td class="qty">${descuento}</td>
                    <td class="total">${impuesto}</td>
                    <td class="total">${total}</td>
                    
                  </tr><br>`;
            }
                console.log(content)
                resolve(content);
        }
    })
}
  const obtenerNumeros_Emisor_Receptor = function(numero){
    let contador=0;

    for(let i=0; i < numero.length; i++){
      if(i < 3){
        if(numero[i] == "0"){
          contador++;
        }
      }
    }
    numero= numero.substring(contador, numero.length);
    return numero;
  }


  exports.generarPDFDeComprobante = (content, ruta) => {

    return new Promise((resolve, reject) => {
      pdf.create(content).toFile(ruta, function(err, res) {
          if (err){
              console.log(err);
              reject(err);
          } else {
              console.log(res);
              resolve(true);
          }
      });
    }) 
  }