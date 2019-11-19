// Requirements Section
var cors = require("cors");
var path = require("path");
var fileExists = require("file-exists"); // comprobar si existe un archivo
var express = require("express");
var app = express();
var middleware = require("./controller/middleware.js");
var bodyParser = require("body-parser"); // use body-parser
var compression = require("compression"); //compresses pages greater than 1kb
var _ = require("underscore"); // use to parse body req as json
var crypto = require("crypto-js"); // use to encrypt credentials
var storage = require("node-persist"); // use to maintain data when server down
var mysql = require("mysql"); // use to connect to mysql database
var printer = require("node-thermal-printer"); // use to print with the thermal printer
var nodeExcel = require("excel-export"); // use to create excel spreadsheets
var sopaapi = require("./public/js/sopa-api.js"); // Pending to confirm usage
var ping = require("net-ping"); // use to check connection to internet. isOnline()
var request = require("request"); //use to check connection with Hacienda API
var nodemailer = require("nodemailer");
let listaUnidadesMedida = require("./ServiciosWeb/unidadMedida");
let reportes = require('./Reportes/reportes');
//var reporte= require("./pantilla_PDF/reporte.js");
//var fs = require("file-system")
var fs = require("fs");
var fileUpload = require("express-fileupload");
var Secretkey = "SECRETKEY123";
var aes256 = require("aes256");
var API_indicadoresEconomicos = "https://gee.bccr.fi.cr/indicadoreseconomicos/WebServices/wsIndicadoresEconomicos.asmx/ObtenerIndicadoresEconomicos";

// Initial Configuration
var request = require("request"); // request to https
storage.initSync();

// Constant Parameters
var PORT = process.env.PORT || 8185;
var EMAIL_TO = process.env.EMAIL_TO || "info@imagineing.com";
var LOGIN_PAGE = "/public/view/login.html";
var LOGIN_BAD_PAGE = "/public/view/login-bad.html";
var HOME_PAGE = "/public/view/home.html";
var ORDER_REQUEST_PAGE = "/public/view/order_request.html";
var APIDOC_PAGE = "/apidoc/index.html";
var local = 0; // localhost true uses the local database
var userId = "";
var SOPA_PRINTER0 = "/dev/sopa_printer0";
var ONLINE_TARGET = "8.8.8.8" // Primary DNS Google. google-public-dns-a.google.com.
var HACIENDA_HTTP_ADDRESS = "https://api.comprobanteselectronicos.go.cr/recepcion/v1/";
var BCCR_INDICAORES_ECONOMICOS = "https://gee.bccr.fi.cr/indicadoreseconomicos/WebServices/wsIndicadoresEconomicos.asmx/ObtenerIndicadoresEconomicos";
//var API_HACIENDA = "http://api-demo.crlibre.org/api.php"; //crlibre deprecated
//var API_HACIENDA = "http://155.138.207.58/www/api.php"; // Vultr
var API_HACIENDA = "http://155.138.207.58/www/api.php"; //Heroku

var DEBUG = true;

var DATABASE_URL = process.env.DATABASE_URL || "postgresql://imagineing:admin@localhost:5432/SOPA-BAR-DESARROLLO?ssl=true";
// var DATABASE_URL = process.env.DATABASE_URL || "postgres:// jwriqjodrgfzuz:d13f6243f8264bae7d140d68c089a1b4da55e1da499519f47be7bc019a35c24d@ec2-23-21-158-253.compute-1.amazonaws.com:5432/d5r6dhbpekd3r8?ssl=true"
// var DATABASE_URL = "postgres:// rpi0-user-psql:d1d5bbfff34a062adff937303579c54d3212d9be9@localhost:5432/SOPA";
// var DATABASE_URL = process.env.DATABASE_URL || process.env.HEROKU_POSTGRESQL_GOLD_URL || "postgres:// adxpsrvidqnwit:a26ad70a8e561f075ab51d874a364c2ea8ffb599b3ee2e38b2cad39dd899efb6@ec2-54-163-238-169.compute-1.amazonaws.com:5432/d9jb3c99egmaqu?ssl=true"

var DATABASE_URL_LAPTOP = process.env.DATABASE_URL || "postgres://postgres:postgres@127.0.0.1:5432/sopa";
// Print Section
// var printerInterface = "/dev/usb/lp0";
var printerInterface = SOPA_PRINTER0;
printer.init({
    type: "epson",
    interface: printerInterface,
    width: "29"
});
// Configuration of Static Resources

var EMISOR_NUMERO = "";
var DOWNLOADCODE = "";
var consecutivo = "";
var casamatriz_puntoventa = "";
var statusFile = 0;
// Configure Settings
// tell express to show all files in public
app.use(express.static("public"));
app.use("/public/shared", express.static(path.join(__dirname, "/public/shared")));
app.use("/public/css", express.static(path.join(__dirname, "/public/css")));
app.use("/public/css/plugins", express.static(path.join(__dirname, "/public/css/plugins"))); // issue #22
app.use("/public/assets/img", express.static(path.join(__dirname, "/public/assets/img")));
app.use("/public/assets/icons", express.static(path.join(__dirname, "/public/assets/icons")));
app.use("/public/js", express.static(path.join(__dirname, "/public/js")));
app.use("/public/js/plugins", express.static(path.join(__dirname, "/public/js/plugins")));
app.use("/public/view", express.static(path.join(__dirname, "/public/view")));
app.use("/bower_components", express.static(path.join(__dirname, "/bower_components")));
app.use("/controller", express.static(path.join(__dirname, "/controller")));
app.use("/node_modules/bootstrap/dist/css", express.static(path.join(__dirname, "/node_modules/bootstrap/dist/css")));
app.use("/node_modules/bootstrap-daterangepicker", express.static(path.join(__dirname, "/node_modules/bootstrap-daterangepicker")));
app.use("/node_modules/datatables.net", express.static(path.join(__dirname, "/node_modules/datatables.net")));
app.use("/node_modules/datatables.net-dt", express.static(path.join(__dirname, "/node_modules/datatables.net-dt")));
app.use("/node_modules/jquery-ui", express.static(path.join(__dirname, "/node_modules/jquery-ui")));
app.use("/", express.static(path.join(__dirname, "/config")));
app.use("/apidoc", express.static(path.join(__dirname, "/apidoc")));

// Define MiddleWare
// app.use(middleware.requireAuthentication);
app.use(middleware.logger);
app.use(bodyParser.json({ limit: '5mb' }));
app.use(compression());
app.use(bodyParser.urlencoded({
    extended: true
}));

app.use(fileUpload());
// app.use(function (req, res, next) {
//   res.header("Access-Control-Allow-Origin", "*");
//   res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
//   next();
// });

app.use(cors());
app.options("*", cors({
    "origin": "*",
    "allowedHeaders": [
        "Origin",
        "X-Requested-With",
        "Content-Type",
        "Accept"
    ],
    "methods": "GET,HEAD,PUT,PATCH,POST,DELETE",
    "optionsSuccessStatus": 204,
    "exposedHeaders": ["sessionId"],
    "preflightContinue": false
}));

// ===================================================================
// Configure Routes
// ===================================================================

// Root of Web Application
app.get("/", function(req, res) {
    res.redirect("/sopa#!/restaurante")
})

// Login
// Get Accounts
app.get("/sopa", function(req, res) {
    console.log("GET /sopa")
    res.sendFile(path.join(__dirname, LOGIN_PAGE))
})

app.get("/apidoc", function(req, res) {
    res.sendFile(path.join(__dirname, APIDOC_PAGE))
})

var argv = require("yargs")
    .command("create", "Create a new account", function(yargs) {
        yargs.options({
            username: {
                demand: true,
                alias: "u",
                description: "Account username or email",

                type: "string"
            },
            password: {
                demand: true,
                alias: "p",
                description: "Account password",
                type: "string"
            },
            masterPassword: {
                demand: true,
                alias: "m",
                description: "Master password",
                type: "string"
            }
        }).help("help")
    })
    .command("get", "Get an existing account", function(yargs) {
        yargs.options({
            username: {
                demand: true,
                alias: "n",
                description: "Account username or email",
                type: "string"
            },
            masterPassword: {
                demand: true,
                alias: "m",
                description: "Master password",
                type: "string"
            }
        }).help("help")
    })
    .command("delete", "Delete an existing account", function(yargs) {
        yargs.options({
            username: {
                demand: true,
                alias: "n",
                description: "Account username or email",
                type: "string"
            },
            masterPassword: {
                demand: true,
                alias: "m",
                description: "Master password",
                type: "string"
            }
        }).help("help")
    })
    .command("mesero", "Mesero Version", function(yargs) {
        local = "mesero"
        yargs.options({
            local: "mesero"
        })
    }).command("nata_laptop", "version local natan", function(yargs) {
        local = "nata_laptop"
        yargs.options({
            local: "nata_laptop"
        })
    }).command("laco", "heroku sopa-bar-desarrollo", function(yargs) {
        local = "laco"
        yargs.options({
            local: "laco"
        })
    }).command("sopabardev", "heroku sopa-bar-desarrollo", function(yargs) {
        local = "sopabardev"
        yargs.options({
            local: "sopabardev"
        })
    }).command("koktela", "Sopa-Koktela", function(yargs) {
        local = "koktela"
        yargs.options({
            local: "koktela"
        })
    })
    .command("heliconias", "Using heliconias database in remote repository", function(yargs) {
        local = "heliconias"
        yargs.options({
            local: "heliconias"
        })
    })
    .command("desarrollo", "Use localhost enviroment ad DB", function(yargs) {
        local = "desarrollo"
        yargs.options({
            local: "desarrollo"
        })
    })
    .command("juniorsotto", "Use localhost enviroment", function(yargs) {
        local = "juniorsotto"
        yargs.options({
            local: "juniorsotto"
        })
    })
    .command("remote", "Use the database in remote repository", function(yargs) {
        local = "0"
        yargs.options({
            local: "0"
        })
    })
    .help("help")
    .argv

var command = argv._[0]

var masterPassword = "123456"

function getAccounts(masterPassword) {
    // use getItemSync to fetch accounts
    var encryptedAccount = storage.getItemSync("accounts")
    var accounts = []
    // decrypt
    if (typeof encryptedAccount !== "undefined") {
        var bytes = crypto.AES.decrypt(encryptedAccount, masterPassword)
        accounts = JSON.parse(bytes.toString(crypto.enc.Utf8))
    }
    // return accounts array
    return accounts
}

function deleteAccounts(account, masterPassword) {
    var accounts = getAccounts(masterPassword)
    var index = accounts.indexOf(account)
    if (index !== "-1") {
        accounts.splice(index, 1)
        console.log("account spliced")
    } else {
        console.log("account not spliced")
    }
}

function saveAccounts(accounts, masterPassword) {
    // encrypt accounts
    var encryptedAccounts = crypto.AES.encrypt(JSON.stringify(accounts), masterPassword)
    // setItemSync
    storage.setItemSync("accounts", encryptedAccounts.toString())
    // return accounts
    return accounts
}

function createAccount(account, masterPassword) {
    var accounts = getAccounts(masterPassword)
    accounts.push(account)
    saveAccounts(accounts, masterPassword)
    return account
}

function getAccount(accountUsername, masterPassword) {
    var accounts = getAccounts(masterPassword)
    var matchedAccount

    accounts.forEach(function(account) {
        if (account.username === accountUsername) {
            matchedAccount = account
        }
    })

    return matchedAccount
}

if (command === "create") {
    try {
        var createdAccount = createAccount({
            username: argv.username,
            password: argv.password
        }, argv.masterPassword)
        console.log("Account created!")
        console.log(createdAccount)
    } catch (e) {
        console.log("Unable to create account.")
    }
} else if (command === "get") {
    try {
        var fetchedAccount = getAccount(argv.username, argv.masterPassword)

        if (typeof fetchedAccount === "undefined") {
            console.log("Account not found")
        } else {
            console.log("Account found!")
            console.log(fetchedAccount)
            console.log("password: " + fetchedAccount.password)
        }
    } catch (e) {
        console.log("Unable to fetch account.")
    }
} else if (command === "delete") {
    try {
        fetchedAccount = getAccount(argv.username, argv.masterPassword)

        if (typeof fetchedAccount === "undefined") {
            console.log("Account not found")
        } else {
            console.log("Account found!")
            console.log(fetchedAccount)
            console.log("password: " + fetchedAccount.password)

            deleteAccounts(fetchedAccount, argv.masterPassword)
        }
    } catch (e) {
        console.log("Unable to fetch account.")
    }
}

app.post("/sopa", function(req, res) {
    // login.html
    // console.log(req);
    var body = _.pick(req.body, "username", "password")
    if (!_.isString(body.username) || !_.isString(body.password)) {
        return res.status(500).send()
    } else {
        try {
            var fetchedAccount = getAccount(body.username, masterPassword)
            if (typeof fetchedAccount === "undefined") {
                console.log("Account not found")
                res.sendFile(path.join(__dirname, LOGIN_BAD_PAGE))
            } else {
                console.log("Account found")
                // verify the credentials
                if (fetchedAccount.password === body.password) {
                    res.sendFile(path.join(__dirname, HOME_PAGE))
                } else {
                    console.log("Password Incorrect")
                    res.sendFile(path.join(__dirname, LOGIN_BAD_PAGE))
                }
            }
        } catch (e) {
            console.log("Unable to fetch account")
            res.send(500, "showAlert")
        }
    }
    console.log("username: " + req.body.username)
    userId = req.body.username
})


app.get("/userId", function(req, res) {
    var data = {
        userId: userId
    }
    console.log("userId: " + userId)
    res.end(JSON.stringify(data))
})
// ==========================================================================
// DataBase Connection
// var dbResults = []

if (local === "0") {
    console.log("remote")
    PORT = process.env.PORT || 8182
    var pool = mysql.createPool({
        // Remote Data Base
        connectionLimit: 100,
        host: "35.184.254.25",
        // port: "3306",
        user: "root",
        password: "sopaimagine",
        database: "SOPA"
    })
} else if (local === 1) {
    // Local Data Base
    console.log("local")
    PORT = process.env.PORT || 8181
    pool = mysql.createPool({
        connectionLimit: 100,
        host: "localhost",
        port: "3306",
        user: "root",
        password: "admin",
        database: "SOPA"
    })
} else if (local === "heliconias") {
    console.log("heliconias")
    PORT = process.env.PORT || 8183
    pool = mysql.createPool({
        connectionLimit: 100,
        host: "104.154.204.108",
        // port: "3306",
        user: "root",
        password: "sopaimagine",
        database: "SOPA"
    })
} else if (local === "mesero") {
    console.log("mesero")
    PORT = process.env.PORT || 8184
    pool = mysql.createPool({
        connectionLimit: 100,
        host: "localhost",
        port: "3306",
        user: "root",
        password: "admin",
        database: "SOPA"
    })
} else if (local === "desarrollo") {
    console.log("desarrollo")
    //DATABASE_URL = process.env.DATABASE_URL || "postgres://imagineing:admin@localhost:5432/SOPA-BAR-DESARROLLO?ssl=true"
    //PORT = process.env.PORT || 8183
    PORT = process.env.PORT || 8185
    DATABASE_URL = "postgres://ttibhnljulujez:d5fba49462b1f9510a14924ff3cc76a1d578da7471dfc7833ff93340c93add59@ec2-50-17-194-186.compute-1.amazonaws.com:5432/d1dbhic3sonvbt?ssl=true"
    console.log("DATABASE_URL")
    console.log(DATABASE_URL)
    console.log("process.env.DATABASE_URL")
    console.log(process.env.DATABASE_URL)
    var pgp = require("pg-promise")( /* options */ )
    /* var cn = {
      host: "localhost",
      port: 5432,
      database: "SOPA",
      user: "black",
      password: "admin"
      } */
    var cn = DATABASE_URL
    pool = pgp(cn)
} else if (local === "juniorsotto") {
    console.log("juniorsotto")
    PORT = 8888
    DATABASE_URL = "postgres://juniorsotto:123@127.0.0.1:5432/sopa_db?ssl=false"
    console.log("DATABASE_URL")
    console.log(DATABASE_URL)
    // console.log("process.env.DATABASE_URL")
    // console.log(process.env.DATABASE_URL)
    var pgp = require("pg-promise")( /* options */ )
    // var cn = {
    //  host: "localhost",
    //  port: 5432,
    //  database: "sopadb_dev",
    //  user: "juniorsotto",
    //  password: "123"
    //  }
    var cn = DATABASE_URL
    pool = pgp(cn)
} else if (local === "sopabardev") {
    PORT = process.env.PORT || 8185
    DATABASE_URL = "postgres://ttibhnljulujez:d5fba49462b1f9510a14924ff3cc76a1d578da7471dfc7833ff93340c93add59@ec2-50-17-194-186.compute-1.amazonaws.com:5432/d1dbhic3sonvbt?ssl=true"
    console.log("sopa-bar-dev")
    console.log("DATABASE_URL")
    console.log(DATABASE_URL)
    var pgp = require("pg-promise")( /* options */ )
    var cn = DATABASE_URL
    pool = pgp(cn)
} else if (local === "laco") {
    PORT = process.env.PORT || 8183
    DATABASE_URL = process.env.DATABASE_URL || "postgres://ttibhnljulujez:d5fba49462b1f9510a14924ff3cc76a1d578da7471dfc7833ff93340c93add59@ec2-50-17-194-186.compute-1.amazonaws.com:5432/d1dbhic3sonvbt?ssl=true"
    console.log("laco")
    console.log("DATABASE_URL")
    console.log(DATABASE_URL)
    var pgp = require("pg-promise")( /* options */ )
    var cn = DATABASE_URL
    pool = pgp(cn)
} else if (local === "nata_laptop") {
    PORT = process.env.PORT || 8185
    console.log("DATABASE_URL_LAPTOP")
    console.log(DATABASE_URL_LAPTOP)
    console.log("process.env")
    console.log(process.env.DATABASE_URL_LAPTOP)
    var pgp = require("pg-promise")( /* options */ )
    var cn = DATABASE_URL_LAPTOP
    pool = pgp(cn)
} else if (local === "koktela") {
    DATABASE_URL = process.env.DATABASE_URL || "postgres://jwriqjodrgfzuz:d13f6243f8264bae7d140d68c089a1b4da55e1da499519f47be7bc019a35c24d@ec2-23-21-158-253.compute-1.amazonaws.com:5432/d5r6dhbpekd3r8?ssl=true"
    console.log("koktela")
    PORT = process.env.PORT || 8185
    console.log("DATABASE_URL")
    console.log(DATABASE_URL)
    console.log("process.env")
    console.log(process.env.DATABASE_URL)
    var pgp = require("pg-promise")( /* options */ )
    var cn = DATABASE_URL
    pool = pgp(cn)
    /* // https:// devcenter.heroku.com/articles/heroku-postgresql#connecting-in-node-js
      const { Client } = require("pg");
      // The DATABASE_URL for the Heroku Postgres add-on follows this naming convention:
      // postgres:// <username>:<password>@<host>/<dbname>
      const client = new Client({
      connectionstring: process.env.DATABASE_URL,
      ssl: true,
      })
      client.connect();

      client.query("SELECT table_schema,table_name FROM information_schema.tables;",
      (err, res) => {
      if (err) throw err;
      for (let row of res.rows) {
        console.log(JSON.stringify(row));
      }
      client.end();
      }) */
} else {
    console.error("database is not local nor remote")
}

exports.getConnection = function(callback) {
    pool.getConnection(function(err, conn) {
        if (err) {
            return callback(err)
        }
    })
}
/* ==========================================
=      SECCION DEL provincia, canton, distrito      =
========================================== */

/**
 * @api {get} /location/provincia Read all provincias for location feature
 * @apiVersion 0.3.0
 * @apiName /location/provincia
 *
 * @apiDescription SELECT * FROM provincia ORDER BY codigo_provincia;
 *
 * @apiExample Example usage:
 * curl -i http://sopa-bar-desarrollo.herokuapp.com/location/provincia
 *
 * @apiSuccess {String}   id            The province Id.
 * @apiSuccess {Number}   codigo_provincia    Province Code.
 * @apiSuccess {String}     nombre_provincia          Province Name.
 *
 */
app.get("/location/provincia", function(req, res) {
    try {
        pool.query("SELECT * FROM provincia ORDER BY codigo_provincia;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("/location/provincia SQL Query Failed")
        })
    } catch (error) {}
})

/**
 * @api {get} /location/canton Read all cantones for location feature
 * @apiVersion 0.3.0
 * @apiName /location/canton
 *
 * @apiDescription SELECT c.codigo_canton , c.nombre_canton, c.id  FROM canton c INNER JOIN provincia p ON c.codigo_provincia = p.codigo_provincia WHERE p.codigo_provincia = $1;
 *
 * @apiParam {String} codigo_provincia The Province-ID.
 *
 * @apiExample Example usage:
 * curl -i http://sopa-bar-desarrollo.herokuapp.com/location/canton?codigo_provincia=1
 *
 * @apiSuccess {String}   id            The province Id.
 * @apiSuccess {String}   nombre_canton    Canton Name.
 * @apiSuccess {Number}   codigo_canton          Canton Code.
 *
 */
app.get("/location/canton", function(req, res) {
    try {
        pool.query("SELECT c.codigo_canton , c.nombre_canton, c.id  FROM canton c INNER JOIN provincia p ON c.codigo_provincia = p.codigo_provincia WHERE p.codigo_provincia = $1;", [req.query.codigo_provincia]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})


/**
 * @api {get} /location/distrito Read all cantones for location feature
 * @apiVersion 0.3.0
 * @apiName /location/distrito
 *
 * @apiDescription SELECT d.codigo_distrito, d.nombre_distrito FROM distrito d where d.codigo_provincia=$1 AND d.codigo_canton=$2;
 *
 * @apiParam {String} codigo_provincia The Province-ID.
 * @apiParam {String} codigo_canton The Canton-ID.
 *
 * @apiExample Example usage:
 * curl -i http://sopa-bar-desarrollo.herokuapp.com/location/distrito?codigo_provincia=7&codigo_canton=2
 *
 * @apiSuccess {String}   nombre_distrito    Distrito Name.
 * @apiSuccess {Number}   codigo_distrito          Distrito Code.
 *
 */
app.get("/location/distrito", function(req, res) {
    try {
        pool.query("SELECT d.codigo_distrito, d.nombre_distrito FROM distrito d where d.codigo_provincia=$1 AND d.codigo_canton=$2;", [req.query.codigo_provincia, req.query.codigo_canton]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("/location/distrito SQL Query Failed")
        })
    } catch (error) {}
})
/* =====  End of SECCION DEL EMISOR  ====== */

/*SECCION DE DESCUENTOS*/

app.get("/descuentos", (req, res) => {

    try {
        pool.query("SELECT idDescuento, descripciondescuento, porcentajedescuento, estadodescuento FROM descuento ORDER BY idDescuento ASC;", []).then(data => {
                res.status(200).send(JSON.stringify(data))
            })
            .catch(err => {
                res.status(500).send(err);
            })
    } catch (error) {}
})

app.post("/new_discount_table", (req, res) => {

    let descripciondescuento= req.body.descripcion;
    let porcentajedescuento=  req.body.porcentaje;
console.log(req.body)
    try{
        pool.query("INSERT INTO descuento (idDescuento,descripciondescuento, porcentajedescuento, estadodescuento, fecha_creacion) VALUES(DEFAULT,$1,$2,DEFAULT, NOW());",[descripciondescuento, porcentajedescuento]).then(data => {
            res.status(200).send(JSON.stringify(data))
        })
        .catch(err => {
            res.status(500).send(err);
        })
    }catch(error){}

})


app.put("/update_discount_table", (req, res) => {

    console.log(req.query)

    let descripciondescuento = req.query.descripcion;
    let porcentajedescuento = req.query.porcentaje;
    let idDescuento = req.query.idDescuento;

    try {
        pool.query("UPDATE DESCUENTO SET descripciondescuento=$1, porcentajedescuento=$2 WHERE idDescuento=$3", [descripciondescuento, porcentajedescuento, idDescuento]).then(data => {
                res.status(200).send(JSON.stringify(data))
            })
            .catch(err => {
                console.log(err);
                res.status(500).send(err);
            })
    } catch (error) {}

})

app.get("/delete_discount", (req, res) => {

    let iddescuento = req.query.iddescuento;

    try {

        pool.query("DELETE FROM DESCUENTO WHERE iddescuento=$1", [iddescuento]).then(data => {
                res.status(200).send(JSON.stringify(data));
            })
            .catch(error => {
                res.status(500).send(error);
            })
    } catch (err) {}
})


app.get("/disable_discount", (req, res) => {
    console.log(req.query)
    let iddescuento = req.query.iddescuento;
    let estado = req.query.estado;
    try {

        pool.query("UPDATE descuento x SET estadodescuento=$1 WHERE x.iddescuento=$2;", [estado, iddescuento])
            .then(data => {
                console.log(data);
                res.status(200).send(JSON.stringify(data));
            })
            .catch(err => {
                res.status(500).send(JSON.stringify(err));
            })
    } catch (err) {}
})

/*FIN SECCION DESCUENTOS*/

// =============================================================================
// INPUESTOS
// =============================================================================

app.get("/impuestos", (req, res) => {

    try {

        pool.query("SELECT idimpuesto, nombre, codigo_impuesto, estadoimpuesto FROM IMPUESTO ORDER BY idimpuesto ASC;", []).then(data => {
                res.status(200).send(data);
            })
            .catch(error => {
                res.status(500).send(JSON.stringify(error));
            });

    } catch (error) {}
})

app.post("/insert_impuesto", (req, res) => {

    let codigo = req.body.codigo;
    let nombre = req.body.nombreImpuesto;

    try {

        pool.query("INSERT INTO IMPUESTO(idimpuesto, nombre, codigo_impuesto, estadoimpuesto) VALUES(DEFAULT,$1,$2,DEFAULT);", [nombre, codigo]).then(data => {
                res.status(200).send(data);
            })
            .catch(err => {
                res.status(500).send(JSON.stringify(err));
            })

    } catch (error) {}
})

app.put("/update_impuesto", (req, res) => {

    let codigo = req.query.codigo;
    let nombre = req.query.nombreImpuesto;
    let idimpuesto = req.query.idimpuesto;

    try {

        pool.query("UPDATE IMPUESTO SET nombre=$1, codigo_impuesto=$2 WHERE idimpuesto=$3", [nombre, codigo, idimpuesto]).then(data => {
                res.status(200).send(data);
            })
            .catch(err => {
                res.status(500).send(JSON.stringify(err));
            })

    } catch (error) {}
})

app.put("/disabled_impuesto", (req, res) => {

    let idimpuesto = req.query.idimpuesto;
    let estado = req.query.estado;

    try {

        pool.query("UPDATE IMPUESTO SET estadoimpuesto=$1 WHERE idimpuesto=$2", [estado, idimpuesto])
            .then(data => {
                res.status(200).send(data);
            })
            .catch(err => {
                res.status(500).send(JSON.stringify(err));
            })

    } catch (error) {}
})

/*--------------------------------FIN SECCION IMPUESTOS -----------------------*/

// =============================================================================
//                                  TIPOS DE IMPUESTO
// =============================================================================
app.get("/tipos_impuesto", (req, res) => {
    console.log(req.query);
    let idimpuesto = req.query.idimpuesto;

    try {

        pool.query("SELECT  i.nombre, ti.idtipoimpuesto, ti.idimpuesto, ti.descripcionimpuesto, ti.estadotipoimpuesto, ti.porcentajetipoimpuesto FROM impuesto i, tipoimpuesto ti WHERE i.idimpuesto= ti.idimpuesto AND i.idimpuesto=$1;", [idimpuesto]).then(data => {
                console.log(data)
                res.status(200).send(JSON.stringify(data));
            })
            .catch(err => {
                res.status(500).send(JSON.stringify(err));
            })

    } catch (error) {}
})

app.put("/update_tipo_impuesto", (req, res) => {

    let idimpuesto = req.query.idimpuesto;
    let descripcion = req.query.descripcion;
    let porcentaje = req.query.porcentaje;
    let idtipoimpuesto = req.query.idtipoimpuesto;

    try {

        pool.query("UPDATE IMPUESTO SET idimpuesto=$1, descripcionimpuesto=$2, porcentajeimpuesto=$3 WHERE idtipoimpuesto=$4", [idimpuesto, descripcion, porcentaje, idtipoimpuesto]).then(data => {
                res.status(200).send(data);
            })
            .catch(err => {
                res.status(500).send(JSON.stringify(err));
            })

    } catch (error) {}
})

app.post("/insert_tipo_impuesto", (req, res) => {
    console.log(req.body)
    let idimpuesto = req.body.idimpuesto;
    let descripcion = req.body.descripcion;
    let porcentaje = req.body.porcentaje;

    try {

        pool.query("INSERT INTO TIPOIMPUESTO(idtipoimpuesto,idimpuesto,descripcionimpuesto,porcentajetipoimpuesto,estadotipoimpuesto) VALUES(DEFAULT,$1,$2,$3,DEFAULT);", [idimpuesto, descripcion, porcentaje]).then(data => {
                res.status(200).send(data);
            })
            .catch(err => {
                res.status(500).send(JSON.stringify(err));
            })

    } catch (error) {}
})

app.put("/disabled_tipo_impuesto", (req, res) => {

    let idtipoimpuesto = req.query.idtipoimpuesto;
    let estado = req.query.estado;

    try {

        pool.query("UPDATE TIPOIMPUESTO SET estadotipoimpuesto=$1 WHERE idtipoimpuesto=$2", [estado, idtipoimpuesto])
            .then(data => {
                res.status(200).send(data);
            })
            .catch(err => {
                res.status(500).send(JSON.stringify(err));
            })

    } catch (error) {}
})

/*--------------------------------- FIN TIPO IMPUESTOS ------------------------*/
/* =================================
=      Receiver      =
================================= */
app.get("/receiver", function(req, res) {

    try {
        pool.query("SELECT r.idreceptor, r.nombre, r.receptor_tipo_identificacion, r.receptor_numero, r.nombrecomercial, p.codigo_provincia, p.nombre_provincia, c.nombre_canton, c.id, r.distrito, d.nombre_distrito, r.otras_senas, r.receptor_telefono_codigopais, r.receptor_telefono_numtelefono,  r.receptor_fax_codigopais, r.receptor_fax_numtelefono, r.correoelectronico  FROM receptor r INNER JOIN provincia p ON r.provincia= p.codigo_provincia INNER JOIN canton c ON r.canton= c.codigo_canton AND c.codigo_provincia = p.codigo_provincia  INNER JOIN distrito d ON c.id = d.codigo_canton AND d.codigo_distrito= r.distrito WHERE r.idreceptor > 0 AND r.estado=1 ORDER BY r.idreceptor;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.get("/receiver_to_PDF", function(req, res) {

    let correo = req.query.correo;
    try {
        pool.query("SELECT r.nombre, r.nombrecomercial,r.correoelectronico, r.otras_senas, r.receptor_numero, r.receptor_fax_numtelefono,r.receptor_telefono_numtelefono, pr.nombre_provincia, c.nombre_canton, d.nombre_distrito FROM  receptor r, provincia pr, canton c, distrito d WHERE r.correoelectronico=$1 AND r.provincia= pr.codigo_provincia AND r.canton= c.codigo_canton AND c.codigo_provincia= pr.codigo_provincia AND c.id= d.codigo_canton AND d.codigo_distrito= r.distrito;", [correo]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.get('/factura/info', (req, res) => {

    try{
        const {idfactura} = req.query;

        pool.query('SELECT f.idfactura, e.e_nombre, e.e_nombrecomercial,e.e_correoelectronico, e.e_otras_senas, e.emisor_numero,  e.emisor_fax_numtelefono, e.emisor_telefono_numtelefono, e.password_email, (select p.nombre_provincia from provincia p where p.codigo_provincia = e.e_provincia) AS e_provincia, (select c.nombre_canton from canton c where c.codigo_provincia = e.e_provincia AND c.codigo_canton = e.e_canton) AS e_canton, (SELECT nombre_distrito from distrito d INNER JOIN canton c ON d.codigo_canton = c.id AND d.codigo_distrito = e.e_distrito INNER JOIN provincia p ON p.codigo_provincia = c.codigo_provincia WHERE p.codigo_provincia= e.e_provincia AND c.codigo_canton = e.e_canton ) e_distrito, r.nombre, r.nombrecomercial,r.correoelectronico, r.otras_senas, r.receptor_numero, r.receptor_fax_numtelefono, r.receptor_telefono_numtelefono, (select p.nombre_provincia from provincia p where p.codigo_provincia = r.provincia) AS provincia, (select c.nombre_canton from canton c where c.codigo_provincia = r.provincia AND c.codigo_canton = r.canton) AS canton, (SELECT nombre_distrito from distrito d INNER JOIN canton c ON d.codigo_canton = c.id AND d.codigo_distrito = r.distrito INNER JOIN provincia p ON p.codigo_provincia = c.codigo_provincia WHERE p.codigo_provincia= r.provincia AND c.codigo_canton = r.canton ) distrito,   f.consecutivo, f.clavenumerica, f.Fecharegistrofactura, f.plazo_credito, f.condicion_venta, f.medio_pago, f.codigomoneda, f.tipocambio, f.totalservgravados, f.totalservexentos, f.totalmercanciasgravadas, f.totalmercanciasexentas, f.totalgravado, f.totalexento, f.totalventa, f.totaldescuentos, f.totalventaneta, f.totalimpuesto, f.totalcomprobante, f.tipo FROM factura f, emisor e, receptor r WHERE f.idfactura = $1 AND f.idemisor= e.idemisor AND f.idreceptor = r.idreceptor',[idfactura])
            .then(data => {

            res.status(200).send(data);
        
        }).catch(err =>{
        
            res.status(500).send(err);
        
        })
    }catch(err){

    }
})
//---------------------------------------------------------------------------------------


app.get("/emiter_to_PDF", function(req, res) {

    let correo = req.query.correo;
    try {
        pool.query("SELECT r.e_nombre, r.e_nombrecomercial,r.e_correoelectronico, r.e_otras_senas, r.emisor_numero, r.emisor_fax_numtelefono,r.emisor_telefono_numtelefono, r.e_correoelectronico, r.password_email, pr.nombre_provincia, c.nombre_canton, d.nombre_distrito FROM  emisor r, provincia pr, canton c, distrito d WHERE r.e_correoelectronico=$1 AND r.e_provincia= pr.codigo_provincia AND r.e_canton= c.codigo_canton AND c.codigo_provincia= pr.codigo_provincia AND c.id= d.codigo_canton AND d.codigo_distrito= r.e_distrito;", [correo]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

//-------------------------------------------------------------------------------------------
app.post("/receiver/create", function(req, res) {

    console.log(req.body)
    try {
        pool.query("INSERT INTO public.receptor(nombre, receptor_tipo_identificacion, receptor_numero, nombrecomercial, provincia, canton, distrito, otras_senas, receptor_telefono_codigopais, receptor_telefono_numtelefono, receptor_fax_codigopais, receptor_fax_numtelefono, correoelectronico) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12,$13);", [req.body.nombre, req.body.receptor_tipo_identificacion, req.body.receptor_numero, req.body.nombrecomercial, req.body.provincia, req.body.canton, req.body.distrito, req.body.otras_senas, req.body.receptor_telefono_codigopais, req.body.receptor_telefono_numtelefono, req.body.receptor_fax_codigopais, req.body.receptor_fax_numtelefono, req.body.correoelectronico]).then(data => {
            if (DEBUG) {
                console.log("API POST: /receiver/create")
                console.dir(data)
            }
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})


// __ ACTULIZAR-------------------------------------------
app.put("/receiver/update", function(req, res) {
    // -------------------- VALIDAR LOS CAMPOS DE TEXTO ----------------
    //console.log(req.body)
    //-------------------------
    //console.log(req.body)
    try {
        pool.query("SELECT UPDATE_RECEIVER($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)", [req.body.nombre, req.body.receptor_tipo_identificacion, req.body.nombrecomercial, req.body.provincia, req.body.canton, req.body.distrito, req.body.otras_senas, req.body.receptor_telefono_codigopais, req.body.receptor_telefono_numtelefono, req.body.receptor_fax_codigopais, req.body.receptor_fax_numtelefono, req.body.correoelectronico, req.body.receptor_numero]).then(data => {
            if (DEBUG) {
                console.log("API PUT: /receiver/update")
                console.log("receptor actualizado")
                console.dir(data)
            }
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

// ------------- CAMBIAR EL ESTADO
app.put("/receiver/delete", function(req, res) {
    try {
        pool.query("UPDATE receptor SET estado = 0 WHERE receptor_numero= $1;", [req.body.receptor_numero]).then(data => {
            if (DEBUG) {
                console.log("API PUT: /receiver/delete")
                console.log("estado cambiado")
                console.dir(data)
            }
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

///lastIdreceiver
app.get("/receiver/lastId", function(req, res) {
    try {
        pool.query("SELECT idreceptor FROM receptor ORDER BY idreceptor DESC LIMIT 1", []).then(data => {
            res.status(200).send(data)
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

/* =====  End of Receiver  ====== */
/* ==============================
=      EMISOR      =
============================== */
app.get("/emisor", function(req, res) {
    try {
        pool.query("SELECT idemisor ,e_nombre, emisor_tipo_identificacion, emisor_numero, e_nombrecomercial, e_provincia, e_canton, e_distrito, e_otras_senas, emisor_telefono_codigopais, emisor_telefono_numtelefono, emisor_fax_codigopais, emisor_fax_numtelefono, e_correoelectronico, password_email , casamatriz, puntoventa, tipo_producto, codigo_actividad FROM emisor;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed: /emisor")
        })
    } catch (error) {}
})

app.get("/getEmisor", function(req, res) {

    try {
        getEmisor().then(data => {
                res.status(200).send(JSON.stringify(data))
            })
            .catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed: /emisor");
            })
    } catch (err) {}

})
app.get("/emisor/old/page", function(req, res) {
    // THIS METHOD IS DEPRECATED
    res.sendFile(path.join(__dirname, CONFIG_EMISOR_PAGE))
})

app.post("/emisor/old/writeFile", function(req, res) {
    // THIS METHOD IS DEPRECATED
    // login.html
    // var body = _.pick(req.body, "username", "password")
    var testing = 1
    if (testing !== 1) {
        return res.status(500).send()
    } else {
        try {
            // Save the information in a file
            var jsonData = JSON.stringify(req.body)
            var fs = require("fs")
            fs.writeFile("config/emisor.json", jsonData, function(err) {
                if (err) {
                    console.error(err)
                }
            })
            // Return to Login Page
            res.sendFile(path.join(__dirname, LOGIN_PAGE))
        } catch (e) {
            res.send(500, "showAlert")
        }
    }
})

/* app.post("/create_transmitter", function (req, res) {
  console.log("llego");
  // console.dir(req);
  try {
    pool.query("INSERT INTO public.emisor(nombre, emisor_tipo_identificacion, emisor_numero, nombrecomercial, provincia, canton, distrito, otras_senas, emisor_telefono_codigopais, emisor_telefono_numtelefono, emisor_fax_codigopais, emisor_fax_numtelefono, correoelectronico) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12,$13);", [req.body.nombre, req.body.emisor_tipo_identificacion, req.body.emisor_numero, req.body.nombrecomercial, req.body.provincia, req.body.canton, req.body.distrito, req.body.otras_senas, req.body.emisor_telefono_codigopais, req.body.emisor_telefono_numtelefono, req.body.emisor_fax_codigopais, req.body.emisor_fax_numtelefono, req.body.correoelectronico]).then(data => {
      console.dir(data);
      res.status(200).send(JSON.stringify(data))
    }).catch(error => {
      console.error(error)
      res.status(500).end("SQL Query Failed")
    })
  } catch (error) {}
}) */

app.put("/emisor/update", function(req, res) {

    console.log("emisor req.body:\n", req.body)

    try {
        pool.query("SELECT UPDATE_EMISOR($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19)", [req.body.nombre, req.body.emisor_tipo_identificacion, req.body.emisor_numero, req.body.nombrecomercial, req.body.provincia, String(req.body.canton), String(req.body.distrito), req.body.otras_senas, req.body.emisor_telefono_codigopais, req.body.emisor_telefono_numtelefono, req.body.emisor_fax_codigopais, req.body.emisor_fax_numtelefono, req.body.correoelectronico, req.body.casamatriz, req.body.puntoventa, req.body.tipo_producto, req.body.codigo_producto, encriptar_desencriptar_password(req.body.password, "encrypt"), String(req.body.codigo_actividad)]).then(data => {
            if (DEBUG) {
                console.log("API PUT: /emisor/update")
                console.log("emisor actualizado")
                console.dir(data)
            }
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed: /emisor/update")
        })
    } catch (error) {}
})

app.get("/emisor/emisor_numero", function(req, res) {
    try {
        pool.query("SELECT emisor_numero FROM emisor;", [])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed: /emisor/emisor_numero");
            })
    } catch (error) {}
})


app.get("/emisor/casamatriz_puntoventa", function(req, res) {
    try {
        pool.query("SELECT casamatriz,puntoventa FROM emisor;", [])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed: /emisor/casamatriz_puntoventa");
            })
    } catch (error) {}
})


app.put("/emisor/update_data_users", function(req, res) {
    /* Deprecate USERS table
    Ideally the system only have one active usernameAPI
    Then we will store API information into emisor table
    In the future. If required to maintain multiple API users
    then we can reactivate USERS table
    */
    console.log("data ", req.body)
    // Documentation: update_data_users
    // https://github.com/JeanCarlosChavarriaHughes/sopa-bar-desarrollo/blob/master/Query_SQL/Natanael_Files/BD_nueva/funciones_triggers.sql
    try {
        pool.query("SELECT update_data_users($1,$2);", [req.body.user_api, req.body.pwd_api])
            .then(data => {
                if (DEBUG) {
                    console.log("API PUT: /emisor/update_data_users")
                    console.log("credenciales de api actualizados")
                    console.dir(data)
                }
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed: /emisor/update_data_users")
            })
    } catch (error) {}
})


app.get("/users/username_password", function(req, res) {
    /* Deprecate USERS table
    Ideally the system only have one active usernameAPI
    Then we will store API information into emisor table
    In the future. If required to maintain multiple API users
    then we can reactivate USERS table
    */
    try {
        pool.query("SELECT user_api, pwd_api FROM USERS;", [])
            .then(data => {
                if (DEBUG) {
                    console.log("API GET: /users/username_password")
                    console.dir(data)
                }
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed: /users/username_password");
            })
    } catch (error) {}
})

app.get("/emisor/username_password", function(req, res) {
    try {
        pool.query("SELECT usernameapi, passwordapi FROM EMISOR where idemisor = 1;", [])
            .then(data => {
                if (DEBUG) {
                    console.log("API GET: /emisor/username_password")
                    console.dir(data)
                }
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed: /emisor/username_password");
            })
    } catch (error) {}
})
/* =====  End of EMISOR  ====== */

// =============================================================================
// FACTURA ELECTRONICA
// =============================================================================
/* app.get("/api/ubicacion/distrito/get", function (req, res) {
  try {
    pool.query("SELECT * FROM DISTRITO;", []).then(data => {
      res.status(200).send(JSON.stringify(data));
      // console.log(JSON.stringify(data))
    }).catch(error => {
      console.error(error)
      res.status(500).end("SQL Query Failed")
    })
  } catch (error) {}
}) */
// =============================================================================
// CLIENTES
// =============================================================================
/* app.get("/api/client", function (req, res) {
  try {
    pool.query("SELECT * FROM ??;", ["CLIENTE"], function (error, results) {
      if (error) {
        console.error(error)
        res.status(500).end()
        throw error
      } else {
        res.setHeader("Content-Type", "application/json; charset=utf-8")
        // spacing level = 2
        res.status(200).send(JSON.stringify(results, null, 2))
      }
    })
  } catch (error) {
    callback(error)
  }
})

app.post("/create_client", function (req, res) {
  var record = {}
  record = {
    nombreCliente: req.body.nombre,
    apellidoCliente: req.body.apellido,
    identificacionCliente: req.body.identificacion
  }
  if (!record.identificacionCliente || record.identificacionCliente === null || record.identificacionCliente === undefined) {
    record = {
      nombreCliente: req.body.nombre,
      apellidoCliente: req.body.apellido
    }
    console.error("Identificacion no ha sido agregada")
  }
  try {
    pool.query("INSERT INTO CLIENTE SET ? ", record, function (error, results) {
      if (error) {
        res.status(500).send("Failed Insert")
        console.error(error)
        throw error
      } else {
        res.status(200).end()
      }
    })
  } catch (error) {
    callback(error)
  }
})

app.post("/creat_client_account", function (req, res) {
  if (!req.body.id || req.body.id === undefined || req.body.id === undefined || req.body.id === null || req.body.id === null) {
    console.error("Failed in /creat_client_account: req.body.id: " + req.body.id)
    res.end()
  } else {
    try {
      pool.query("INSERT INTO CUENTA(idCliente, estadoCuenta) VALUES (?, "Activa");", req.body.id, function (error, results) {
        if (error) {
          res.status(500).send("Failed Insert")
          console.error(error)
          throw error
        } else {
          res.status(200).end()
        }
      })
    } catch (error) {
      callback(error)
    }
  }
})

app.put("/update_client", function (req, res) {
  // console.log(req.body);
  try {
  pool.query("UPDATE CLIENTE SET nombreCliente = ?, apellidoCliente = ?, identificacionCliente = ? WHERE idCliente = ?", [req.body.nombre, req.body.apellido, req.body.identificacion, req.body.id], function (error, results) {
    if (error) {
    res.status(500).send("Failed");
    console.error(error);
    throw error;
    } else {
      res.status(200).send(JSON.stringify(results));
    }
  });
  } catch (error) {
  callback(error);
  }

});

app.get("/getBill", function (req, res) {
  var idCliente = req.body.idCliente;
  if (idCliente) {
    try {
      pool.query("SELECT cu.idCuenta FROM CUENTA cu INNER JOIN CLIENTE cl ON cu.idCliente = cl.idCliente WHERE cl.idCliente = ?  AND cu.estadoCuenta = "Activa";", idCliente, function (error, results, fields) {
        if (error) {
          console.error(error)
          res.status(500).end()
          throw error
        }
        res.end(JSON.stringify(results))
      })
    } catch (error) {
      callback(error)
    }
  } else {
    console.error("Error: Cliente no ha sido seleccionado")
    console.error(error)
  }
})

app.get("/get_client_account", function (req, res) {
  var idCliente = req.body.id
  try {
    pool.query("SELECT * FROM CUENTA WHERE idCliente = ? AND estadoCuenta = "Activa";", idCliente, function (error, results, fields) {
      if (error) {
        console.error(error)
        res.status(500).end()
        throw error
      }
      res.end(JSON.stringify(results))
    })
  } catch (error) {
    callback(error)
  }
}) */
// =============================================================================
// PROVEEDORES
// =============================================================================
app.get("/proveedor", function(req, res) {
    try {
        pool.query("SELECT * FROM public.PROVEEDOR WHERE estadoproveedor = 1 ORDER BY idproveedor;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed: /proveedores")
        })
    } catch (error) {}
})

app.post("/proveedor/create", function(req, res) {
    try {
        pool.query("INSERT INTO PROVEEDOR (empresa, nombreContacto, contactoproveedor1, contactoproveedor2, correoproveedor, observacionproveedor) VALUES ($1, $2, $3, $4, $5, $6)", [req.body.empresa, req.body.nombreContacto, req.body.contacto1, req.body.contacto2, req.body.correo, req.body.observacion])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed: /proveedor/create")
            })
    } catch (error) {}
})

app.put("/proveedor/update", function(req, res) {
    try {
        pool.query("UPDATE PROVEEDOR SET empresa = $1, nombrecontacto = $2, contactoproveedor1 = $3, contactoproveedor2 = $4, correoproveedor = $5, observacionproveedor = $6 WHERE idproveedor = $7", [req.body.empresa, req.body.nombreContacto, req.body.contacto1, req.body.contacto2, req.body.correo, req.body.observacion, req.body.idProveedor])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed: /proveedor/update")
            })
    } catch (error) {}
})

app.put("/proveedor/delete", function(req, res, callback) {
    try {
        pool.query("UPDATE PROVEEDOR SET estadoproveedor = 0 WHERE idproveedor = $1", [req.body.idproveedor])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed: /proveedor/delete")
            })
    } catch (error) {}
})

// =============================================================================
// PRODUCTOS
// =============================================================================
app.get('/api/product', function(req, res, callback) {
    try {
        pool.query('SELECT p.codigoBarraProducto, p.idProducto, p.descripcionProducto, p.precioProducto,  p.unidadmedida, p.unidadmedidacomercial, p.costounitario, p.porcentajeImpuesto, p.tipo_producto,   p.codigoproducto, p.idclasificacion, p.tipo_impuesto, c.idcategoria, c.descripcioncategoria, cl.id as idclasificacion, cl.codigo_impuesto FROM  producto p INNER JOIN public.categoria c ON p.idcategoria = c.idcategoria INNER JOIN clasificacion cl ON p.idclasificacion = cl.id   WHERE p.estadoproducto = 1 ORDER BY p.idProducto;', []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end('SQL Query Failed: /api/product')
        })
    } catch (error) {}
})

app.put('/api/product/update', function(req, res) {


    try {

        let productObj = {
            descripcion: req.query.descripcionproducto,
            idcategoria: req.query.categoria,
            precio: req.query.precioproducto,
            tipoimpuesto: req.query.impuesto,
            unidadmedida: req.query.unidadmedida,
            unidadmedidacomercial: req.query.unidadmedidacomercial,
            costounitario: req.query.costounitario,
            porcentajeimpuesto: req.query.porcentajeimpuesto,
            tipoProducto: req.query.tipoProducto,
            codigo_producto: req.query.codigoProducto,
            clasificacion: req.query.clasificacion,
            idproducto: req.query.idproducto,
        }

        console.log(productObj)

        pool.query('UPDATE PRODUCTO SET descripcionproducto= $1, idcategoria= $2, precioproducto= $3, tipo_impuesto=$4, unidadmedida= $5, unidadmedidacomercial= $6, costounitario=$7, porcentajeimpuesto=$8, tipo_producto=$9, codigoproducto= $10, idclasificacion=$11 WHERE idproducto=$12   ', [productObj.descripcion, productObj.idcategoria, productObj.precio, productObj.tipoimpuesto,  productObj.unidadmedida, productObj.unidadmedidacomercial, productObj.costounitario,
                productObj.porcentajeimpuesto, productObj.tipoProducto, productObj.codigo_producto,  productObj.clasificacion,  productObj.idproducto
            ])
            .then(data => {
                //tipoProducto
                console.log("todo bien")
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end('SQL Query Failed: /api/product/update')
            })
    } catch (error) {}
})

app.post("/api/product/delete", function(req, res) {
    try {
        pool.query("UPDATE PRODUCTO SET estadoproducto = 0 WHERE idproducto = $1;", [req.body.idproducto])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.post('/api/product/insert', (req, res) => {


    try {

        console.log(req.body)
        let productObj = {
            descripcion: req.body.descripcionproducto,
            idcategoria: req.body.idcategoria,
            precio: req.body.precioproducto,
            tipoimpuesto: req.body.impuesto,
            unidadmedida: req.body.unidadmedida,
            unidadmedidacomercial: req.body.unidadmedidacomercial,
            costounitario: req.body.costounitario,
            porcentajeimpuesto: req.body.porcentajeImpuesto,
            tipoProducto: req.body.tipoProducto,
            codigo_producto: req.body.codigoproducto,
            idclasificacion: req.body.clasificacion,
            codigoBarra: req.body.codigoBarra
        }

        console.log("data ", productObj)

        pool.query('INSERT INTO PRODUCTO (idproducto, descripcionproducto, idcategoria, precioproducto,tipo_impuesto, unidadmedida, unidadmedidacomercial,costounitario, porcentajeimpuesto, tipo_producto,codigoproducto,idclasificacion, codigobarraproducto) VALUES (DEFAULT,$1,$2,$3,$4,$5,$6,$7,$8,$9, $10, $11, $12)', [
                productObj.descripcion, productObj.idcategoria, productObj.precio, productObj.tipoimpuesto, productObj.unidadmedida, productObj.unidadmedidacomercial, productObj.costounitario, productObj.porcentajeimpuesto, productObj.tipoProducto, productObj.codigo_producto, productObj.idclasificacion, productObj.codigoBarra
            ])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
                console.log("Todo bien")
            }).catch(error => {
                console.error(error)
                res.status(500).end('SQL Query Failed: /api/product/insert')
            })

    } catch (err) {}

})

app.put("/api/product/status", function(req, res) {
    try {
        pool.query("UPDATE PRODUCTO SET estadoProducto = 0 WHERE idProducto = ?", [req.body.id], function(error, result) {
            if (error) {
                res.stats(500).end()
                console.error(error)
                throw error
            } else {
                res.status(200).end("SQL Query Failed: /api/product/status")
            }
        })
    } catch (error) {}
})

// ABOVE UPDATED in this section
app.post("/api/product/create/old", function(req, res) {
    // THIS IS DEPRECATED
    var record = {
        descripcionProducto: req.body.descripcionProducto,
        precioProducto: req.body.precioProducto,
        idCategoria: req.body.idCategoria
    }
    try {
        pool.query("INSERT INTO PRODUCTO SET ? ", record, function(error, result) {
            if (error) {
                res.status(500).end()
                console.error(error)
                throw error
            } else {
                res.status(200).end("SQL FAILED IN /api/product/create/old")
            }
        })
    } catch (error) {}
})
//=============================CLASIFICACION DE PRODUCTOS =====================


app.post('/api/clasificacion/insert', (req, res) => {

    try {
        console.log(req.body);


        let descripcion = req.body.descripcion;
        let impuesto = req.body.impuesto;
        let descr_impuesto = req.body.descr_impuesto;

        pool.query('INSERT INTO clasificacion(id, nombre_clasificacion, codigo_impuesto,  descripcion_impuesto) VALUES(DEFAULT, $1, $2, $3)', [descripcion, impuesto, descr_impuesto]).then(data => {

                res.status(200).send(JSON.stringify(data))
            })
            .catch(error => {
                console.error(error)
                res.status(500).end('SQL Query Failed: /api/clasificacion/insert')
            })
    } catch (err) {}
})


app.put('/api/clasificacion/update', (req, res) => {


    console.log(req.query)
    try {

        let descripcion = req.query.descripcion;
        let impuesto = req.query.impuesto;
        let descr_impuesto = req.query.descr_impuesto;
        let id = req.query.id;

        pool.query("UPDATE CLASIFICACION SET nombre_clasificacion= $1,codigo_impuesto=$2, descripcion_impuesto=$3 WHERE id=$4", [descripcion, impuesto, descr_impuesto, id]).then(data => {

                res.status(200).send(JSON.stringify(data))

            })
            .catch(err => {
                console.error(err);

                res.status(500).end("SQL Query Failed: /api/clasificacion/update")
            })
    } catch (err) {}


})

app.get('/api/clasificacion/', (req, res) => {

    try {
        pool.query('SELECT id, nombre_clasificacion, codigo_impuesto,  descripcion_impuesto FROM clasificacion', []).then(data => {

                res.status(200).send(JSON.stringify(data))
            })
            .catch(error => {
                console.error(error)
                res.status(500).end('SQL Query Failed: api/clasificacion/insert')
            })
    } catch (err) {}
})

//==============================================================================
// =============================================================================
// CATEGORIAS
// =============================================================================

app.get("/categorias_load", function(req, res) {
    // var columns = ["idCategoria", "descripcionCategoria"];
    try {
        pool.query("SELECT idCategoria, descripcionCategoria FROM public.categoria", [])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.get("/categorias_inventario_load", function(req, res) {
    try {
        pool.query("SELECT idCategoriaInventario, descripcionCategoriaInventario FROM public.categoriainventario", [])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})


// =============================================================================
// INVENTARIO
// =============================================================================


app.post("/update_inventario", function(req, res) {
    try {
        pool.query("UPDATE INVENTARIO SET descripcioninventario = COALESCE($1,descripcioninventario), cantidaddisponibleinventario = COALESCE($2,cantidaddisponibleinventario), costoinventario = COALESCE($3,costoinventario), cantidadminimainventario = COALESCE($4,cantidadminimainventario), unidad = COALESCE($6,unidad), idcategoriainventario = COALESCE($7,idcategoriainventario) WHERE idinventario = $5", [req.body.descripcioninventario, req.body.cantidaddisponibleinventario, req.body.costoinventario, req.body.cantidadminimainventario, req.body.idinventario, req.body.unidad, req.body.idcategoriainventario])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.put("/load_inventario", function(req, res) {
    try {
        pool.query("UPDATE INVENTARIO SET costoinventario = $1, cantidaddisponibleinventario = cantidaddisponibleinventario + $2 WHERE idinventario = $3", [req.body.costo, req.body.cantidad, req.body.idInventario])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.post("/insert_proveedorinventario", function(req, res) {
    try {
        pool.query("INSERT INTO PROVEEDORINVENTARIO (idproveedor, idinventario, costounitario, cantidadproducto) VALUES ($1, $2, $3, $4)", [req.body.idProveedor, req.body.idInventario, req.body.costo, req.body.cantidad])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.get("/api/inventario", function(req, res, callback) {
    try {
        pool.query("SELECT i.codigobarrainventario, i.idinventario, i.descripcioninventario, i.costoinventario, i.cantidaddisponibleinventario, i.cantidadminimainventario, i.idcategoriainventario, i.unidad, ci.idcategoriainventario, ci.descripcioncategoriainventario FROM INVENTARIO i INNER JOIN CATEGORIAINVENTARIO ci ON i.idcategoriainventario = ci.idcategoriainventario WHERE estadoinventario = 1 ORDER BY i.idinventario;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

// =============================================================================
// INVENTARIOPRODUCTO
// =============================================================================


app.get("/api/product/inventario", function(req, res, callback) {
    try {
        pool.query("SELECT i.*, CAST(ip.cantidadnecesaria AS INTEGER) AS cantidadnecesaria FROM INVENTARIO i LEFT JOIN INVENTARIOPRODUCTO ip ON i.idinventario = ip.idinventario AND ip.idproducto = $1 ORDER BY ip.cantidadnecesaria ASC;", [req.query.idproducto])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})
app.get('/api/product/clasificacion', (req, res) => {


    try {

        pool.query('SELECT id, nombre_clasificacion, codigo_impuesto FROM clasificacion;', []).then(data => {

                res.status(200).send(JSON.stringify(data));

            })
            .catch(err => {
                console.log(err);
                res.status(500).end('SQL Query Failed: api/product/clasificacion');
            })

    } catch (err) {}

})
app.get("/api/product/inventario/stock", function(req, res, callback) {
    try {
        pool.query("SELECT CAST(ip.cantidadnecesaria AS INTEGER) AS necesaria, i.idinventario, i.descripcioninventario, i.cantidaddisponibleinventario AS disponible, i.cantidadminimainventario AS minima FROM INVENTARIO i INNER JOIN INVENTARIOPRODUCTO ip ON i.idinventario = ip.idinventario AND ip.idproducto = $1;", [req.query.idproducto])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.get("/api/inventario/disponible", function(req, res, callback) {
    try {
        pool.query("SELECT i.idInventario, i.descripcionInventario, ci.descripcionCategoriaInventario, i.cantidadDisponibleInventario, i.costoInventario, i.cantidadMinimaInventario FROM INVENTARIO i INNER JOIN CATEGORIAINVENTARIO ci ON i.idCategoriaInventario = ci.idCategoriaInventario ORDER BY ci.idCategoriaInventario;", [])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

// a copy of api/inventario/disponible
// it does not work if the address is /api/inventario/disponible
app.get("/disponible", function(req, res, callback) {
    try {
        pool.query("SELECT i.idInventario, i.descripcionInventario, ci.descripcionCategoriaInventario, i.cantidadDisponibleInventario, i.costoInventario, i.cantidadMinimaInventario FROM INVENTARIO i INNER JOIN CATEGORIAINVENTARIO ci ON i.idCategoriaInventario = ci.idCategoriaInventario ORDER BY ci.idCategoriaInventario;", [])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.get("/api/inventario/consumido", function(req, res, callback) {
    try {
        pool.query("SELECT i.idInventario, i.descripcionInventario, CAST (SUM(o.cantidadProducto * ip.cantidadNecesaria) AS INTEGER) AS Consumo, i.unidad FROM INVENTARIO i INNER JOIN INVENTARIOPRODUCTO ip ON i.idInventario = ip.idInventario INNER JOIN ORDEN o ON ip.idProducto = o.idProducto INNER JOIN FACTURA f ON o.idFactura = f.idFactura WHERE f.estadoFactura = 1 GROUP BY i.idInventario ORDER BY i.idInventario;", [])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.get("/consumido", function(req, res, callback) {
    // copy of api/inventario/consumido to export excel
    // it does not work if the address is /api/inventario/consumido
    try {
        pool.query("SELECT i.idInventario, i.descripcionInventario, CAST (SUM(o.cantidadProducto * ip.cantidadNecesaria) AS INTEGER) AS Consumo, i.unidad FROM INVENTARIO i INNER JOIN INVENTARIOPRODUCTO ip ON i.idInventario = ip.idInventario INNER JOIN ORDEN o ON ip.idProducto = o.idProducto INNER JOIN FACTURA f ON o.idFactura = f.idFactura WHERE f.estadoFactura = 1 GROUP BY i.idInventario ORDER BY i.idInventario;", [])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})



app.post("/insert_inventario", function(req, res) {

    console.log(req.body)

    try {
        pool.query("INSERT INTO INVENTARIO (idinventario,descripcioninventario,cantidaddisponibleinventario,costoinventario,cantidadminimainventario, unidad, idcategoriainventario, estadoinventario) VALUES (DEFAULT,$1,$2,$3,$4,$5,$6,1);", [req.body.descripcioninventario, req.body.cantidaddisponibleinventario, req.body.costoinventario, req.body.cantidadminimainventario, req.body.unidad, req.body.idcategoriainventario])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.post("/delete_inventario", function(req, res) {
    try {
        pool.query("UPDATE INVENTARIO SET estadoinventario = 0 WHERE idinventario= $1;", [req.body.idinventario])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.post("/update/producto/composicion", function(req, res) {
    try {
        pool.query("SELECT update_insert_inventarioproducto ($1,$2,$3);", [req.body.idproducto, req.body.idinventario, req.body.cantidadnecesaria]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})



app.put("/update_inventario", function(req, res) {
    try {
        pool.query("UPDATE PRODUCTO SET cantidadDisponible = ?, costoUnitario = ? WHERE idProducto = ?", [req.body.cantidad, req.body.costo, req.body.idProdcuto], function(error, result) {
            if (error) {
                res.status(500).end()
                console.error(error)
                throw error
            } else {
                res.status(200).end()
            }
        })
    } catch (error) {}
})

app.post("/disminuir_inventario", function(req, res) {
    try {
        pool.query("SELECT update_inventory ($1,$2);", [req.body.id, req.body.cantidad])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.post("/aumentar_inventario", function(req, res) {
    try {
        pool.query("SELECT reload_inventory ($1,$2);", [req.body.orden, req.body.cantidad])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})



app.post("/order_cost", function(req, res) {
    try {
        pool.query("SELECT update_order_cost ($1);", [req.body.id])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})
// =============================================================================
// MESEROS
// =============================================================================
app.get("/empleados", function(req, res) {
    try {
        pool.query("SELECT * FROM EMPLEADO e INNER JOIN PUESTO p ON e.idpuesto = p.idpuesto WHERE e.estadoempleado = 1 ORDER BY idempleado;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.get("/puestos", function(req, res) {
    try {
        pool.query("SELECT * FROM PUESTO", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.post("/create_waiter", function(req, res) {
    try {
        pool.query("INSERT INTO EMPLEADO (nombreEmpleado, apellidoEmpleado, idPuesto) VALUES ($1, $2, $3)", [req.body.nombre, req.body.apellido, req.body.puesto]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.put("/update_empleado", function(req, res) {
    try {
        pool.query("UPDATE EMPLEADO SET nombreEmpleado = $1, apellidoEmpleado = $2 WHERE idEmpleado = $3", [req.body.nombre, req.body.apellido, req.body.idEmpleado]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.put("/delete_empleado", function(req, res, callback) {
    try {
        pool.query("UPDATE EMPLEADO SET estadoempleado = 0 WHERE idempleado = $1", [req.body.idEmpleado])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {
        callback(error)
    }
})
// =============================================================================
// RESTAURANTE
// =============================================================================
app.get("/pendingTotal", function(req, res) {
    var idCuenta = req.query.idCuenta
    try {
        pool.query("SELECT COALESCE(SUM(o.cantidadproducto * o.precioUnitarioProducto),0) as Cuenta FROM CLIENTE cl INNER JOIN CUENTA cu on cl.idCliente = cu.idCliente AND cu.estadocuenta NOT LIKE 'Cancelada' AND cu.idCuenta = $1 LEFT JOIN ORDEN o on cu.idCuenta = o.idCuenta AND o.estadoOrden = 'Pendiente'", [idCuenta]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

// /api/client/orders/2
// /api/client/orders?idCuenta=3
// No aplica carga de ordenes por cliente, solo existe un cliente
/* app.get("/api/client/orders", function (req, res) {
  var idCuenta = req.query.idCuenta;
  try {
  pool.query("SELECT c.idCuenta as NumCuenta, o.idOrden, p.descripcionProducto as Producto, p.precioProducto as Precio, o.cantidad as Cantidad, (p.precioProducto * o.cantidad) as Total, o.estadoOrden as estadoOrden, o.fechaRegistro as Fecha FROM CUENTA c INNER JOIN ORDEN o ON o.idCuenta = c.idCuenta AND o.estadoOrden="Pendiente" INNER JOIN PRODUCTO p ON p.idProducto = o.idProducto WHERE c.idCuenta = ? GROUP BY o.idOrden", idCuenta,
    function (error, results) {
    if (error) {
      console.error(error);
      res.status(500).end();
      throw error;
    } else {
      res.setHeader("Content-Type", "application/json; charset=utf-8");
      dbResults = JSON.stringify(results, null, 2);
      res.end(dbResults);
    }
    });
  } catch (error) {
  callback(error);
  }
});
 */

// ----------------- eliminar orden y cuenta----------------
app.post("/delete_order", function(req, res) {
    var idOrden = req.body.id
    try {
        pool.query("DELETE FROM public.orden WHERE idOrden = $1", [idOrden])
            .then(data => {
                res.status(200).send(true)
            }).catch(error => {
                console.error(error)
            })
    } catch (error) {}
})

app.put("/cancel_cuenta", function(req, res) {
    try {
        pool.query("UPDATE CUENTA SET estadoCuenta = 'Cancelada' WHERE idCuenta = ?", [req.body.id], function(error, results) {
            if (error) {
                res.status(500).end()
                console.error(error)
                throw error
            } else {
                res.status(200).end()
            }
        })
    } catch (error) {}
})

app.get("/api/orders/pending", function(req, res) {
        try {
            pool.query("SELECT o.idOrden, o.idCuenta as NumCuenta, p.descripcionProducto as Producto, o.precioUnitarioProducto as Precio, p.costounitario, o.cantidadProducto as Cantidad, o.precioUnitarioProducto * o.cantidadProducto as Total, o.descuentoorden ,o.estadoOrden as EstadoOrden, o.fechaRegistroOrden, o.naturalezadescuento FROM ORDEN o INNER JOIN CUENTA c ON o.idCuenta = c.idCuenta INNER JOIN PRODUCTO p ON o.idProducto = p.idProducto WHERE o.estadoorden NOT LIKE 'Cancelada ' ORDER BY c.idCuenta, o.idOrden", []).then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
            })
        } catch (error) {}
    }) |
    // getClientAccounts
    app.get("/api/client/account", function(req, res) {
        try {
            pool.query("SELECT cu.idCuenta, cl.identificacionCliente, COALESCE(SUM(o.cantidadProducto * p.precioProducto),0) AS TotalPagar FROM public.CLIENTE cl INNER JOIN public.CUENTA cu ON cl.idCliente = cu.idCliente AND cu.estadocuenta NOT LIKE 'Cancelada' LEFT JOIN public.ORDEN o ON cu.idCuenta = o.idCuenta AND o.estadoOrden = 'Pendiente' LEFT JOIN public.PRODUCTO p on o.idProducto = p.idProducto group by cu.idCuenta, cl.identificacionCliente", []).then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
            })
        } catch (error) {}
    })
// =============================================================================
// ORDENES
// =============================================================================
app.get("/order_load", function(req, res) {
    try {
        pool.query("SELECT o.idOrden, o.idCuenta as NumCuenta, concat_ws(' ', cl.nombreCliente, cl.apellidoCliente) as Cliente, p.descripcionProducto as Producto, ct.descripcionCategoria as Categoria, c.estadoCuenta as EstadoCuenta, o.formaPago as Pago, o.descuentoAplicado as DescuentoAplicado, DATE_FORMAT(o.fechaRegistro, '%d/%m/%y') as Fecha, p.precioProducto as Precio, o.cantidad as Cantidad, p.precioProducto * o.cantidad as Total, o.estadoOrden as EstadoOrden, concat_ws(' ', e.nombreEmpleado, e.apellidoEmpleado) as Empleado, pt.descripcionPuesto as Puesto FROM ORDEN o INNER JOIN CUENTA c ON o.idCuenta = c.idCuenta INNER JOIN PRODUCTO p ON o.idProducto = p.idProducto INNER JOIN EMPLEADO e ON o.idEmpleado = e.idEmpleado INNER JOIN CLIENTE cl ON c.idCliente = cl.idCliente INNER JOIN CATEGORIA ct ON p.idCategoria = ct.idCategoria INNER JOIN PUESTO pt ON e.idPuesto = pt.idPuesto ORDER BY c.idCuenta, o.idOrden;", function(error, results, fields) {
            if (error) {
                console.error(error)
                res.status(500).end()
                throw error
            }
            // console.log("JSON.stringify: " + JSON.stringify(results));
            res.end(JSON.stringify(results))
        })
    } catch (error) {}
})

app.get("/orders_to_PDF", function(req, res) {
    console.log(req.query);
    let idfactura = Number(req.query.idfactura);
    try {
        pool.query("SELECT o.numerolineadetalle, o.cantidadproducto, o.preciounitarioproducto, o.monto, o.montodescuento, o.montoitotallinea, p.unidadmedida, p.descripcionproducto, o.montoimpuesto, o.total_orden FROM orden o, producto p  WHERE o.idfactura=$1 AND o.idproducto= p.idproducto;", [idfactura]).then(data => {
                res.status(200).send(data)
            })
            .catch(err => {
                res.status(500).end(err)
            })

    } catch (error) {}
})

//---------------------------------------------
//---------------------------------------------
//SELECT idfactura FROM factura ORDER BY idfactura DESC LIMIT 1;

//SELECT update_order_fields(1626,12,1,"02","02","KG","prueba 100","detalles del producto",1000.3,3000.59,"naturaleza",2343.97,"02",5,54400.5,"23","32423423423","dsfsdfsdfsdf",213123.34,3,345.6);
//-------------------------------------------------------------------------------------------
// ACTUALIZAR CAMPOS DE ORDEN
app.put("/orden/actualizar", function(req, res) {
    //console.log("body :", req.body.costounitario);
    //console.log(req.body.obj);
    const object = req.body.orden;
    
    const idorden = object.idorden;
    const costounitario = object.costounitario;
    const numerolineadetalle = object.numerolineadetalle;
    const codigoservicio = object.codigoservicio;
    const tiposervicio = object.tiposervicio;
    const unidadmedida = object.unidadmedida;
    const unidadmedidacomercial = object.unidadmedidacomercial;
    const detalle = object.detalle;
    const montototal = object.montototal;
    const subtotal = object.subtotal;
    const codigoimpuesto = object.codigoimpuesto;
    const tarifa = object.tarifa;
    const monto = object.monto;
    const montoimpuesto = object.montoimpuesto;
    const montototallinea = object.montototallinea;
    let baseImponible =0;

    if(typeof object.baseImponible !== 'undefined'){
        baseImponible = object.baseImponible;
    }
    
    try{
        pool.query('SELECT update_order_fields($1,$2,$3,$4,$5,$6,$7,$8,$9, $10, $11, $12, $13, $14, $15, $16)',[idorden,
        costounitario,numerolineadetalle,codigoservicio,tiposervicio,unidadmedida,unidadmedidacomercial,detalle,montototal,subtotal,codigoimpuesto,tarifa,monto,montoimpuesto,montototallinea,baseImponible])
        .then(data => {
            res.status(200).send(JSON.stringify(data));
        })
        .catch(err => res.status(400).send(JSON.stringify(err)));

    }catch(err){}
})
//------------------------------------------------------------------------------------------------//

//SELECT iddetalle FROM detalles_orden ORDER BY iddetalle DESC LIMIT 1;



//--------------------------------------------------------

app.post("/insert_xml", function(req, res) {
    console.log(req.query)
    try {
        pool.query("INSERT INTO XML (idfactura, xml) VALUES ($1, $2)", [req.query.id, req.query.data_xml]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})
//-------------------------------------------------------
app.put("/guardar_credenciales", function(req, res) {
    console.log(req.body)
    try {
        pool.query("UPDATE EMISOR SET  key_username=$1, key_password=$2, pin_p12=$3, e_correoelectronico=$4, e_nombre=$5;", [req.body.key_username, req.body.key_pwd, req.body.pin, req.body.email, req.body.nombre]).then(data => {
            res.status(200).send(JSON.stringify(data))
            console.log("Credenciales actualizados")
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}

})

//-------------------------------------------------------
app.get("/file_p12", function(req, res) {
    try {
        pool.query("SELECT file_p12 FROM emisor;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})
//--------------------------------------------------------
app.get("/login_llave_criptografica", function(req, res) {
    try {
        pool.query("SELECT key_username, key_password FROM emisor;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.get("/factura/xml/obtener", function(req, res) {
    try {

        let idfactura = req.query.idfactura;
        let tipo= req.query.tipo;
        let query ='';

        if(tipo == 'xml')
            query ='SELECT xml_firmado from XML WHERE idfactura =$1';
        else
            query= 'SELECT acuse from XML WHERE idfactura =$1';

        pool.query(query, [idfactura]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})
//-------------------------------------------------------
app.post("/upload", function(req, res) {
    var ruta = path.resolve(__dirname)
    var ruta_total = ruta + "/config/";
    try {


        if (Object.keys(req.files).length == 0) {
            res.status(400).send("No ha cargado ningun archivo");
        }


        var fullpath = ruta_total + req.files.myFile.name;
        fileExists(fullpath).then(exists => {
            if (exists) {
                console.log("archivo existe")
                console.log(fs.unlinkSync(fullpath))

                //------------------------------------------

                let myFile = req.files.myFile;

                myFile.mv(ruta_total + req.files.myFile.name, function(err) {
                    if (err) {
                        res.status(500).send(err);
                    } else {

                        console.log("cargando el archivo " + req.files.myFile.name + "...")
                        try {
                            pool.query("UPDATE EMISOR set file_p12=$1;", [req.files.myFile.name]).then(data => {
                                console.dir(data)
                                res.status(200).send("información actualizada con éxito");
                                console.log("información actualizada con éxito")
                            }).catch(error => {
                                console.error(error)
                                res.status(500).end("SQL Query Failed")
                            })
                        } catch (error) {}
                    }
                });

                //------------------------------------------
            } else {
                console.log("Archivo no existe")
                let myFile = req.files.myFile;

                myFile.mv(ruta_total + req.files.myFile.name, function(err) {
                    if (err) {
                        res.status(500).send(err);
                    } else {
                        console.log("cargando el archivo " + req.files.myFile.name + "...")
                        try {
                            pool.query("UPDATE EMISOR set file_p12=$1;", [req.files.myFile.name]).then(data => {
                                console.dir(data)
                                res.status(200).send("información actualizada con éxito");
                                console.log("información actualizada con éxito")
                            }).catch(error => {
                                console.error(error)
                                res.status(500).end("SQL Query Failed")
                            })
                        } catch (error) {}
                    }
                });

            }
        }).catch(err => {
            console.log(err);
        })
    } catch (e) {
        // no existe
        console.log("error: " + e);
        console.log("-----------------------------------------------------------------")
    }
});

app.put("/emisor/credentials/update", (req, res) => {
    console.log("body ", req.query);
    let obj = {
        "nombre": req.query.nombre,
        "usernameAPI": req.query.username,
        "passwordAPI": req.query.pwd,
        "email": req.query.email,
        "ubicacion": req.query.ubicacion,
        "acerca": req.query.acerca,
        "idFile": req.query.idFile,
        "downloadCode": req.query.downloadCode,
        "idUserAPI": req.query.idUserAPI,
        "key_username": req.query.key_username,
        "key_password": req.query.key_pwd,
        "pin_p12": req.query.pin
    }

    try {
        pool.query("UPDATE EMISOR SET e_nombre=$1, usernameapi=$2, passwordapi=$3, e_correoelectronico=$4, ubicacion=$5, acercade=$6, idfile=$7, downloadcode=$8, iduserapi=$9, key_username=$10, key_password=$11, pin_p12=$12 WHERE idemisor=1;",
                [obj.nombre, obj.usernameAPI, obj.passwordAPI, obj.email, obj.ubicacion, obj.acerca, obj.idFile, obj.downloadCode, obj.idUserAPI,
                    obj.key_username, obj.key_password, obj.pin_p12
                ]).then(data => {
                if (DEBUG) {
                    console.log("API PUT: /emisor/credentials/update")
                    console.log("Obj sent:")
                    console.dir(obj)
                    console.log("Data Received:")
                    console.dir(data)
                }
                res.status(200).send(data)
            })
            .catch(error => {
                console.error(error);
                res.status(500).send(error)
            })
    } catch (error) {}

})


app.get("/new_user", function(req, res) {
    /* Deprecate USERS table
    Ideally the system only have one active usernameAPI
    Then we will store API information into emisor table
    In the future. If required to maintain multiple API users
    then we can reactivate USERS table
    */
    console.log(req.query)
    var obj = {

        "nombre": req.query.nombre,
        "username": req.query.username,
        "pwd": req.query.pwd,
        "email": req.query.email,
        "ubicacion": req.query.ubicacion,
        "acerca": req.query.acerca
    }

    console.log("credenciales ", obj)

    try {
        request.get({
            headers: {
                "user-agent": req.headers["user-agent"]
            },
            url: API_HACIENDA + "?w=users&r=users_register&fullName=" + obj.nombre + "&userName=" + obj.username + "&email=" + obj.email + "&about=" + obj.acerca + "&country=" + obj.ubicacion + "&pwd=" + obj.pwd + "&type=1",
        }, function(error, response, body) {
            //console.log(body);
            res.status(200).send(body)
            console.log("res ", body);
            console.log("-----------------------------------------------------")
        });
    } catch (error) {
        console.log(error)
    }
})
//-------------------------------------------------------
app.get("/tipoCambio", function(req, res) {

    var obj = {

        "tcIndicador": req.query.tcIndicador,
        "tcFechaInicio": req.query.tcFechaInicio,
        "tcFechaFinal": req.query.tcFechaFinal,
        "tcNombre": req.query.tcNombre,
        "tnSubNiveles": req.query.tnSubNiveles
    }

    console.log("--------------------------------------------------------------------")
    var formBody = [];
    for (var property in obj) {
        var encodedKey = encodeURIComponent(property);
        var encodedValue = encodeURIComponent(obj[property]);
        formBody.push(encodedKey + "=" + encodedValue);
    }
    formBody = formBody.join("&");
    console.log(formBody)

    try {

        request.post({
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            url: BCCR_INDICAORES_ECONOMICOS,
            mode: "cors",
            body: formBody
        }, function(error, response, body) {
            if (error) {
                console.error(error)
                res.status(500).send(error)
            }
            console.log("tipo camio ", body);
            res.status(200).send(body)
        });

    } catch (error) {}
})
//--------------------------------------------------------
//GET DATA TO XML
app.post("/send_to_crlibre_for_xml", function(req, res) {
   
    let comprobante = JSON.parse(req.query.obj);
    let formBody = [];
    let obj = {};

    if (comprobante.tipoComprobante == "factura") {

        obj = {

            w: comprobante.w,
            r: comprobante.r,
            clave: comprobante.clave,
            codigo_actividad: comprobante.codigo_actividad,
            consecutivo: comprobante.consecutivo,
            fecha_emision: comprobante.fecha_emision,
            emisor_nombre: comprobante.emisor_nombre,
            emisor_tipo_identif: comprobante.emisor_tipo_identif,
            emisor_num_identif: comprobante.emisor_num_identif,
            emisor_nombre_comercial: comprobante.emisor_nombre_comercial,
            emisor_provincia: comprobante.emisor_provincia,
            emisor_canton: comprobante.emisor_canton,
            emisor_distrito: comprobante.emisor_distrito,
            emisor_barrio: comprobante.emisor_barrio,
            emisor_otras_senas: comprobante.emisor_otras_senas,
            emisor_cod_pais_tel: comprobante.emisor_cod_pais_tel,
            emisor_tel: comprobante.emisor_tel,
            emisor_cod_pais_fax: comprobante.emisor_cod_pais_fax,
            emisor_fax: comprobante.emisor_fax,
            emisor_email: comprobante.emisor_email,
            receptor_nombre: comprobante.receptor_nombre,
            receptor_tipo_identif: comprobante.receptor_tipo_identif,
            receptor_num_identif: comprobante.receptor_num_identif,
            receptor_provincia: comprobante.receptor_provincia,
            receptor_canton: comprobante.receptor_canton,
            receptor_distrito: comprobante.receptor_distrito,
            receptor_barrio: comprobante.receptor_barrio,
            receptor_cod_pais_tel: comprobante.receptor_cod_pais_tel,
            receptor_tel: comprobante.receptor_tel,
            receptor_cod_pais_fax: comprobante.receptor_cod_pais_fax,
            receptor_fax: comprobante.receptor_fax,
            receptor_email: comprobante.receptor_email,
            condicion_venta: comprobante.condicion_venta,
            plazo_credito: comprobante.plazo_credito,
            medios_pago: comprobante.medios_pago,
            cod_moneda: comprobante.cod_moneda,
            tipo_cambio: comprobante.tipo_cambio,
            total_serv_gravados: comprobante.total_serv_gravados,
            total_serv_exentos: comprobante.total_serv_exentos,
            total_serv_exonerados: comprobante.total_serv_exonerados,
            total_merc_gravada: comprobante.total_merc_gravada,
            total_merc_exenta: comprobante.total_merc_exenta,
            total_merc_exonerada: comprobante.total_merc_exonerada,
            total_gravados: comprobante.total_gravados,
            total_exento: comprobante.total_exentos,
            total_exonerado: comprobante.total_exonerado,
            total_ventas: comprobante.total_ventas,
            total_descuentos: comprobante.total_descuentos,
            total_ventas_neta: comprobante.total_ventas_neta,
            total_impuestos: comprobante.total_impuestos,
            total_comprobante: comprobante.total_comprobante,
            otros: comprobante.otros,
            detalles: comprobante.detalles

        }

    } else if (comprobante.tipoComprobante == "tiquete") {


        obj = {

            w: comprobante.w,
            r: comprobante.r,
            clave: comprobante.clave,
            codigo_actividad: comprobante.codigo_actividad,
            consecutivo: comprobante.consecutivo,
            fecha_emision: comprobante.fecha_emision,
            emisor_nombre: comprobante.emisor_nombre,
            emisor_tipo_identif: comprobante.emisor_tipo_identif,
            emisor_num_identif: comprobante.emisor_num_identif,
            emisor_nombre_comercial: comprobante.emisor_nombre_comercial,
            emisor_provincia: comprobante.emisor_provincia,
            emisor_canton: comprobante.emisor_canton,
            emisor_distrito: comprobante.emisor_distrito,
            emisor_barrio: comprobante.emisor_barrio,
            emisor_otras_senas: comprobante.emisor_otras_senas,
            emisor_cod_pais_tel: comprobante.emisor_cod_pais_tel,
            emisor_tel: comprobante.emisor_tel,
            emisor_cod_pais_fax: comprobante.emisor_cod_pais_fax,
            emisor_fax: comprobante.emisor_fax,
            emisor_email: comprobante.emisor_email,
            condicion_venta: comprobante.condicion_venta,
            plazo_credito: comprobante.plazo_credito,
            medios_pago: comprobante.medios_pago,
            cod_moneda: comprobante.cod_moneda,
            tipo_cambio: comprobante.tipo_cambio,
            total_serv_gravados: comprobante.total_serv_gravados,
            total_serv_exentos: comprobante.total_serv_exentos,
            total_serv_exonerados: comprobante.total_serv_exonerados,
            total_merc_gravada: comprobante.total_merc_gravada,
            total_merc_exenta: comprobante.total_merc_exenta,
            total_merc_exonerada: comprobante.total_merc_exonerada,
            total_gravados: comprobante.total_gravados,
            total_exento: comprobante.total_exentos,
            total_exonerado: comprobante.total_exonerado,
            total_ventas: comprobante.total_ventas,
            total_descuentos: comprobante.total_descuentos,
            total_ventas_neta: comprobante.total_ventas_neta,
            total_impuestos: comprobante.total_impuestos,
            total_comprobante: comprobante.total_comprobante,
            totalIVADevuelto: 0,
            otros: comprobante.otros,
            detalles: comprobante.detalles
        }

    }

    for (var property in obj) {
        var encodedKey = encodeURIComponent(property);
        var encodedValue = encodeURIComponent(obj[property]);
        formBody.push(encodedKey + "=" + encodedValue);
    }
    formBody = formBody.join("&");

    if (DEBUG) {
        console.log("API POST: /send_to_crlibre_for_xml")
        console.dir(obj)
        console.log("--------------------------------------------------------------------")
        console.log(formBody)
    }

    try {


        request.post({
            headers: {
                "user-agent": req.headers["user-agent"],
                "content-type": "application/x-www-form-urlencoded"
            },
            url: API_HACIENDA,
            mode: "cors",
            body: formBody
        }, function(error, response, body) {
            if (error) {
                res.status(500).send(error)
                console.error(error)
            }
            res.status(200).send(body)
            console.log("res ", body);
            console.log("-----------------------------------------------------")
        });

    } catch (error) {}
})



app.post("/token", function(req, res) {

    login_llave_criptografica().then(results => { // esta promesa trae los datos del login para la llave criptofráfica

        console.log(results[0].key_username + ' ' + results[0].key_password)
        console.log("llegó al token")
        var options = {
            "r": req.query.r,
            "w": req.query.w,
            "grant_type": req.query.grant_type,
            "client_id": req.query.client_id,
            "username": results[0].key_username,
            "password": results[0].key_password
        }

        console.log("opciones del token ", options)


        var formBody = [];
        for (var property in options) {
            var encodedKey = encodeURIComponent(property);
            var encodedValue = encodeURIComponent(options[property]);
            formBody.push(encodedKey + "=" + encodedValue);
        }
        formBody = formBody.join("&");
        console.log("data token ", formBody)

        //https://idp.comprobanteselectronicos.go.cr/auth/realms/rut-stag/protocol/openid-connect/token
        request.post({
            headers: {
                "user-agent": req.headers["user-agent"],
                "content-type": "application/x-www-form-urlencoded"
            },
            url: API_HACIENDA,
            mode: "cors",
            body: formBody
        }, function(error, response, body) {
            if (error) {
                console.error(error)
                res.status(500).send(error)
            }
            console.log("TOKEN ", body);
            res.status(200).send(body)
        }); //12345632517
    })
})



app.post("/firma_electronica", function(req, res) {
    // ToDo Deprecate
    // getPin_p12()
    // use /firma_electronica/serverside

    getPin_p12().then(resp => {
        console.log("User-Agent: " + req.headers["user-agent"]);
        console.log(resp)
        var obj = {
            p12Url: req.query.p12Url,
            pinP12: resp[0].pin_p12,
            inXml: req.query.inXml,
            w: req.query.w,
            r: req.query.r
        }

        console.log("data firma ", obj)
        console.log("--------------------------------------------------------------------")
        var formBody = [];
        for (var property in obj) {
            var encodedKey = encodeURIComponent(property);
            var encodedValue = encodeURIComponent(obj[property]);
            formBody.push(encodedKey + "=" + encodedValue);
        }
        formBody = formBody.join("&");
        console.log(formBody)

        try {


            request.post({
                headers: {
                    "user-agent": req.headers["user-agent"],
                    "content-type": "application/x-www-form-urlencoded"
                },
                url: API_HACIENDA,
                mode: "cors",
                body: formBody
            }, function(error, response, body) {
                if (error) {
                    console.error(error);
                    res.status(500).send(error);
                }
                console.log("-----------------------------------------------------")
                console.log("firma electronica")
                console.log(body)
                res.status(200).send(body)
                console.log("-----------------------------------------------------")
            });

        } catch (error) {}
    })
})


app.post("/firma_electronica/serverside", function(req, res) {
    getPin_p12().then(resp => {

        let obj = {
            "w": "firmarXML",
            "r": "firmar",
            "p12Url": DOWNLOADCODE,
            "inXml": req.body.inXml,
            "pinP12": resp[0].pin_p12
        }

        console.log("data firma ", obj)
        var formBody = [];
        for (var property in obj) {
            var encodedKey = encodeURIComponent(property);
            var encodedValue = encodeURIComponent(obj[property]);
            formBody.push(encodedKey + "=" + encodedValue);
        }
        formBody = formBody.join("&");
       

        try {

            request.post({
                headers: {
                    "user-agent": req.headers["user-agent"],
                    "content-type": "application/x-www-form-urlencoded"
                },
                url: API_HACIENDA,
                mode: "cors",
                body: formBody
            }, function(error, response, body) {
                if (error) {
                    console.error(error);
                    res.status(500).send(error);
                }else{

                    let idfactura = req.body.idfactura;
                    let data = JSON.parse(body);
                    let xmlBase64 = new Buffer.from(data.resp.xmlFirmado).toString('base64');
                    let xml = xmlBase64.toString('ascii');

                    pool.query('INSERT INTO XML (idfactura,xml,xml_firmado) VALUES($1,$2,$3)',[idfactura,xml,data.resp.xmlFirmado ]).then(data =>{
                        console.log("respuesta firma electronica");
                        console.log(body);
                        res.status(200).send(body);
                    })
                    .catch(err=> {
                        console.log("Error consulta ", err);    
                        res.status(500).send(error)
                    });
                }
            });

        } catch (error) {}
    })
})


app.post("/firma_electronica_acuse_recibido", function(req, res) {
    //getPin_p12()

    getPin_p12().then(resp => {

        //console.log(resp)

        let host = "";
        let subject = "";
        let message = "";
        let email_receptor = "";
        let correo_emisor = "";
        let receptor = "";
        let nombreinstitucion = "";
        let password = "";
        let path = "";
        let nombreComprobante = "";
        let comprobanteAcuse = "";
        let idfactura = "";
        let ruta_PDF = "";
        let nombre_PDF = "";
        let ruta_acuse = "";
        let nombre_acuse = "";
        let comprobante = "";
        let obj = {};


        //console.log("query ", req.query)
        var objeto = {
            "w": "signXML",
            "r": "signFE",
            "p12Url": DOWNLOADCODE,
            "inXml": req.query.inXml,
            "pinP12": resp[0].pin_p12,
            "tipodoc": req.query.tipodoc,
        }
        console.log("xml comprobante ", req.query);
        console.log("data firma ", objeto)
        console.log("--------------------------------------------------------------------")
        var formBody = [];
        for (var property in objeto) {
            var encodedKey = encodeURIComponent(property);
            var encodedValue = encodeURIComponent(objeto[property]);
            formBody.push(encodedKey + "=" + encodedValue);
        }
        formBody = formBody.join("&");
        console.log(formBody)

        try {


            request.post({
                headers: {
                    "user-agent": req.headers["user-agent"],
                    "content-type": "application/x-www-form-urlencoded"
                },
                url: API_HACIENDA,
                mode: "cors",
                body: formBody
            }, function(error, response, body) {
                if (error) {
                    console.error(error);
                    res.status(500).send(error);
                } else if (JSON.stringify(body) !== "{}") {

                    let resp = JSON.parse(body);

                    console.log(resp)
                    path = "xml_receptores/" + req.query.clave + ".xml";
                    correo_emisor = String(req.query.correo_emisor);
                    host = obtenerHostCorreo(correo_emisor);
                    email_receptor = req.query.correo_receptor;
                    receptor = req.query.nombre_receptor;
                    nombreinstitucion = req.query.nombreinstitucion;
                    subject = nombreinstitucion;
                    message = "Saludos coordiales señor(a) " + receptor + " se adjuntó los documentos xml y pdf de la factura.";
                    password = encriptar_desencriptar_password(req.query.password, "decrypt");
                    nombreComprobante = req.query.clave + ".xml";
                    comprobanteAcuse = resp.resp.xmlFirmado;
                    idfactura = req.query.idfactura;
                    ruta_PDF = "pdf_reportes/" + req.query.clave + ".pdf";
                    nombre_PDF = req.query.clave + ".pdf";
                    ruta_acuse = "acuses_xml/" + req.query.clave + ".xml";
                    nombre_acuse = "acuse_recibido_" + req.query.clave + ".xml";
                    comprobante = req.query.xml_comprobante;
                    crearDocumentoXML(ruta_acuse, comprobanteAcuse).then(dataFile => {
                        crearDocumentoXML(path, comprobante).then(dataAcuse => {
                                if (dataFile && dataAcuse) {
                                    emisorForPDF(correo_emisor).then(data => {
                                            console.log("información del emisor ", data);
                                            getDataReceptorToPdf(email_receptor).then(dataReceptor => {
                                                getDataOrdenesToPdf(idfactura).then(dataOrdenes => {
                                                    getDataFacturaToPdf(idfactura).then(dataFactura => {
                                                        crearReporteConReceptor(dataReceptor, data, dataOrdenes, dataFactura).then(data => {

                                                            generarPDFDeComprobante(data, ruta_PDF).then(xmlData => {
                                                                if (xmlData) {
                                                                    enviarCorreos(correo_emisor, email_receptor, password, host, comprobante, nombreinstitucion, nombreComprobante, message, ruta_PDF,
                                                                            nombre_PDF, nombre_acuse, comprobanteAcuse).then(dataEmail => {
                                                                            if (dataEmail) {
                                                                                res.status(200).send(body);

                                                                            }
                                                                        })
                                                                        .catch(err => {
                                                                            console.log(err);

                                                                        })
                                                                }
                                                            }).catch(err => {
                                                                console.log(err);
                                                            })
                                                        }).catch(err => {
                                                            console.log(err);
                                                        })
                                                    })
                                                })
                                            })
                                        })
                                        .catch(err => {
                                            console.log(err);
                                        })
                                }
                            })
                            .catch(err => {
                                console.log(err);

                            })
                    }).catch(err => {
                        console.log(err);
                    })
                } else {
                    res.status(500).send("respuesta indefinida")
                }


            });

        } catch (error) {}
    })
})
//-- login hacienda
app.post("/login", function(req, res) {

    //console.log("req.query")
    //console.dir(req.query)
    //console.log("req.body")
    //console.dir(req.body)

    var obj = {
        "r": "users_log_me_in",
        "w": "users",
        "userName": req.body.username, // userName with N capital case.
        "pwd": req.body.pwd,
    }
    try {
        console.dir(obj)
        request.post({
            headers: {
                "user-agent": req.headers["user-agent"],
                "content-type": "application/x-www-form-urlencoded"
            },
            url: API_HACIENDA,
            mode: "cors",
            form: obj
        }, function(error, response, body) {
            if (error) {
                console.error(error);
            }
            res.status(response.statusCode).send(body)
            console.log("statusCode:", response && response.statusCode); // Print the response status code if a response was received
            console.log("/login ", body)
        });
    } catch (error) {}

})
app.post('/factura/comprobante/enviar', (req, res) => {

    let comprobante='';
    let obj= {};
    if (typeof req.body.recp_numeroIdentificacion !== "undefined") {
        obj = {
            "r": 'json',
            "w": 'send',
            "token": req.body.token,
            "clave": req.body.clave,
            "fecha": req.body.fecha,
            "emi_tipoIdentificacion": req.body.emi_tipoIdentificacion,
            "emi_numeroIdentificacion": req.body.emi_numeroIdentificacion,
            "recp_tipoIdentificacion": req.body.recp_tipoIdentificacion,
            "recp_numeroIdentificacion": req.body.recp_numeroIdentificacion,
            "client_id": req.body.client_id
        }

        comprobante = "FE";

    } else {
        obj = {
            "r": 'sendTE',
            "w": 'send',
            "token": req.body.token,
            "clave": req.body.clave,
            "fecha": req.body.fecha,
            "emi_tipoIdentificacion": req.body.emi_tipoIdentificacion,
            "emi_numeroIdentificacion": req.body.emi_numeroIdentificacion,
            "client_id": req.body.client_id
        }

        comprobante = "TE";

    }
    
    try {
        let idfactura = req.body.idcomprobante;
        obtenerXMLParaEnviar(idfactura,'xml').then(xmlfirmado => {
            obj.comprobanteXml = xmlfirmado;
            console.log("Objeto a enviar ", obj);
            var formBody = [];
            for (var property in obj) {
                var encodedKey = encodeURIComponent(property);
                var encodedValue = encodeURIComponent(obj[property]);
                formBody.push(encodedKey + "=" + encodedValue);
            }
            formBody = formBody.join("&");
            request.post({
                headers: {
                    "user-agent": req.headers["user-agent"],
                    "content-type": "application/x-www-form-urlencoded"
                },
                url: API_HACIENDA,
                //mode: "cors",
                body: formBody
            }, function(error, response, body) {
                
                if (error) {
                    res.status(500).send(JSON.stringify(error));
                } else if (JSON.stringify(body) !== "{}") {

                    if (comprobante == "FE") {
                        console.log(body);
                        res.status(200).send(body);
                    } else {
                        console.log(body);
                        res.status(200).send(body);
                    }
                }
            })

        })  
        .catch(err => {
            console.log("Error de consulta ", err);
            res.status(500).send(err);
        })
    } catch (error) {}
})

app.post("/factura/acuse/generar/", function(req, res) {

    console.log(req.query);

    let obj = {
        w: 'consultar',
        r: 'consultarCom',
        clave: req.query.clave,
        token: req.query.token,
        client_id: req.query.client_id
    }
    let formBody = [];

    if (DEBUG) {
        console.log("API POST: /acuse_aceptacion_comprobante")
        console.dir(obj)
        console.log("--------------------------------------------------------------------")
    }

    for (let property in obj) {
            let encodedKey = encodeURIComponent(property);
            let encodedValue = encodeURIComponent(obj[property]);
            formBody.push(encodedKey + "=" + encodedValue);
        }
        formBody = formBody.join("&");
        console.log("body ", formBody)
        try {
    
            request.post({
                headers: {
                    "user-agent": req.headers["user-agent"],
                    "content-type": "application/x-www-form-urlencoded"
                },
                url: API_HACIENDA,
                mode: "cors",
                body: formBody
            }, function(error, response, body) {
                if (error) {
                    console.error(error)
                    return res.status(500).send(error)
                    
                }
                //res.status(200).send(body)
                console.log("body ", body);
                let respuestaReq= JSON.parse(body);    
                if(respuestaReq.resp['ind-estado'] != "procesando"){
                    pool.query("UPDATE FACTURA SET status =$1 WHERE clavenumerica=$2", [respuestaReq.resp['ind-estado'],req.query.clave]).then(data => {
      
                        let idfactura = req.query.idfactura;
                        let acuse = respuestaReq.resp['respuesta-xml'];

                        pool.query("UPDATE XML SET acuse =$1 WHERE idfactura=$2", [acuse,idfactura]).then(response => {
                            
                            console.log("Acuse generado y guardado en la base de datos")
                                                    
                            const subject='Documentos adjuntos de comprobante electrónico.'
                            let root = path.resolve(__dirname);
                            let clave = req.query.clave;
                            let ruta_acuse=root +'/acuses_xml/acuse_'+clave+'.xml';
                            let ruta_xml=root +'/xml_comprobantes/'+clave+'.xml';
                            let nombreComprobante =clave+'.xml';
                            let nombreAcuse = 'acuse_'+clave+'.xml';
                            
                            if(req.query.tipo=='FE'){

                                getDataEmailEmisorRecetor(idfactura).then(dataResponse => {
                                    obtenerXMLParaEnviar(idfactura,'xml').then(xml => {
                                        let xmlComprobante =Buffer.from(xml,'base64').toString('ascii');
                                            crearDocumentoXML(ruta_xml,xmlComprobante).then(xmlCreated => {
                                                obtenerXMLParaEnviar(idfactura,'acuse').then(acuse => {

                                                    let acuseComprobante =Buffer.from(acuse,'base64').toString('ascii'); 
                                                    crearDocumentoXML(ruta_acuse,acuseComprobante).then(data => {
                                                        let emailEmisor=dataResponse.e_correoelectronico;
                                                        let passwordEmailEmisor=dataResponse.password;
                                                        let emailReceptor=dataResponse.correoelectronico;
                                                        let host = obtenerHostCorreo(emailEmisor);
                                                        ruta_PDF="pdf_reportes/reporte_comprobante_" + req.query.clave + ".pdf";
                                                        let nombrePDF="reporte_comprobante_" + req.query.clave + ".pdf";
                                                            enviarCorreos(emailEmisor,emailReceptor,passwordEmailEmisor,host,xml,subject,nombreComprobante,'','',nombreAcuse,acuse).then(dataEmail => {
                                                                
                                                                enviarCorreos(emailEmisor,emailEmisor,passwordEmailEmisor,host,xml,subject,nombreComprobante,'','',nombreAcuse,acuse).then(dataEmail => {
                                                                    res.status(200).send({
                                                                        status: 'ok',
                                                                        description: 'Proceso de facturación completado'
                                                                    })
                                                                })
                                                            })
                                                        //prueba
                                                    }).catch(err => res.status(500).send(err));
                                                }).catch(err => res.status(500).send(err))
                                            }).catch(err => res.status(500).send(err));
                                        }).catch(err => res.status(500).send(err));                        //
                                    }).catch(err => res.status(500).send(err));
                            }else{

                                getDataEmailEmisorRecetor(idfactura).then(dataResponse => {
                                    obtenerXMLParaEnviar(idfactura,'xml').then(xml => {
                                        let xmlComprobante =Buffer.from(xml,'base64').toString('ascii');
                                            crearDocumentoXML(ruta_xml,xmlComprobante).then(xmlCreated => {
                                                obtenerXMLParaEnviar(idfactura,'acuse').then(acuse => {

                                                    let acuseComprobante =Buffer.from(acuse,'base64').toString('ascii'); 
                                                    crearDocumentoXML(ruta_acuse,acuseComprobante).then(data => {
                                                        let emailEmisor=dataResponse.e_correoelectronico;
                                                        let passwordEmailEmisor=dataResponse.password;
                                                        let host = obtenerHostCorreo(emailEmisor);
                                                        ruta_PDF="pdf_reportes/reporte_comprobante_" + req.query.clave + ".pdf";
                                                        let nombrePDF="reporte_comprobante_" + req.query.clave + ".pdf";
                                                    
                                                            enviarCorreos(emailEmisor,emailEmisor,passwordEmailEmisor,host,xml,subject,nombreComprobante,'','',nombreAcuse,acuse).then(dataEmail => {
                                                                res.status(200).send({
                                                                    status: 'ok',
                                                                    description: 'Proceso de facturación completado'
                                                                })
                                                            })
                                                    
                                                    }).catch(err => res.status(500).send(err));
                                                }).catch(err => res.status(500).send(err))
                                        }).catch(err => res.status(500).send(err));
                                    }).catch(err => res.status(500).send(err));
                                }).catch(err => res.status(500).send(err))                     
                            } 
                        }).catch(err => console.error(err));                        
                    }).catch(err => console.error(err));
                }

                console.log("-----------------------------------------------------")
            });
    
        } catch (error) {}

})
//----------------------------------------------------------------------------
app.post("/upload_certificado", function(req, res) {

    try {

        getFileP12().then(response => {
            console.log("file_p12 ", response)
            var ruta = path.resolve(__dirname)
            var ruta_total = ruta + "/config/" + response;

            console.log("subiendo el archivo: " + response + " a la api...");

            fileExists(ruta_total).then(exists => {
                if (exists) {

                    let formData = {
                        "w": "fileUploader",
                        "r": "subir_certif",
                        "fileToUpload": fs.createReadStream(ruta_total),
                        "sessionKey": req.query.sessionKey,
                        "iam": req.query.iam,
                    };

                    request.post({
                        url: API_HACIENDA,
                        headers: {
                            "user-agent": req.headers["user-agent"]
                        },
                        formData: formData
                    }, function optionalCallback(err, httpResponse, body) {
                        if (err) {
                            return console.error("error al cargar el archivo en la api:", err);
                        } else {

                            console.log("---------------------------------------------------")
                            console.log("archivo cargado a la api! \n respuesta de la api:", body);

                            console.log("---------------------------------------------------")

                            res.status(200).send(body)
                        }

                    });
                } else {
                    res.status(404).send({
                        error: "el archivo no existe"
                    })
                }
            })
        }).catch(err => {
            console.error(err);
        })
    } catch (e) {
        // no existe
        console.error("error: " + e);
        console.error("-----------------------------------------------------------------")
    }


})

app.put("/update_reason_status_factura", (req, res) => {

    var status = req.query.estado;
    var razon = String(req.query.razon)
    try {
        pool.query("UPDATE FACTURA SET status=$1, razon=$2 WHERE idfactura = (SELECT idfactura FROM FACTURA ORDER BY idfactura DESC LIMIT 1);", [status, razon]).then(data => {
                console.log("estado y razon actualizados");
                res.status(200).send(data)
            })
            .catch(error => {
                console.log(error);
                res.status(500).send(error)
            })
    } catch (error) {}

})

//-------------------------------------------

app.get("/get_data_toxml", function(req, res) {
    try {
        pool.query("SELECT f.idfactura, f.clavenumerica, f.consecutivo, f.FECHAEMISION , e.e_nombre, e.emisor_tipo_identificacion, e.emisor_numero, e.e_nombrecomercial, e.e_provincia, e.e_canton, e.e_distrito, e.e_otras_senas, e.emisor_telefono_codigopais, e.emisor_telefono_numtelefono, e.emisor_fax_codigopais, e.emisor_fax_numtelefono, e.e_correoelectronico, e.password_email,e.codigo_actividad, r.nombre, r.receptor_tipo_identificacion, r.receptor_numero, r.provincia, r.canton, r.distrito, r.otras_senas, r.receptor_telefono_codigopais, r.receptor_telefono_numtelefono, r.receptor_fax_codigopais, r.receptor_fax_numtelefono, r.correoelectronico, f.condicion_venta, f.plazo_credito , f.medio_pago  ,f.codigomoneda, f.tipocambio, f.totalservgravados, f.totalservexentos, f.totalservexonerado, f.totalmercanciasgravadas, f.totalmercanciasexentas, f.totalmercanciaexonerada ,f.totalgravado, f.totalexento, f.totalexonerado ,f.totalventa, f.totaldescuentos,f.totalventaneta, f.totalimpuesto, f.totalcomprobante, f.tipo_comprobante, d.descripcion_detalle FROM factura f, emisor e, receptor r, detalles_orden d WHERE f.idemisor= e.idemisor AND f.idreceptor= r.idreceptor  AND f.iddetalle= d.iddetalle AND f.idfactura = $1", [req.query.idfactura]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
        })
    } catch (error) {}
})



app.get('/get_products_to_update_details', function(req, res) {
    //console.log("respuesta desde /get_products_to_update_details",req.body.detalles);
    try {
        pool.query('SELECT o.idorden, o.idfactura, o.cantidadproducto, o.total_orden, o.subtotal, p.unidadmedida, p.descripcionproducto,o.montoimpuesto ,o.preciounitarioproducto, p.tipo_impuesto, p.porcentajeimpuesto, p.unidadmedida, o.naturalezadescuento, o.descuentoorden, o.montodescuento, p.unidadmedidacomercial, p.costounitario, o.iddetalle, p.tipo_producto, p.codigoproducto, cl.codigo_impuesto FROM orden o, producto p, emisor e, clasificacion cl WHERE o.iddetalle= 0 AND o.idproducto=p.idproducto AND e.idemisor=1 AND p.idclasificacion = cl.id;', []).then(data => {
            console.dir(data)
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end('SQL Query Failed')
        })
    } catch (error) {}
})

////SELECT descuentoOrden FROM orden WHERE iddetalle=0;
app.post("/insert_details", function(req, res) {

    console.log(req.body.detalles);
    try {
        pool.query("INSERT INTO DETALLES_ORDEN(iddetalle, descripcion_detalle) VALUES(DEFAULT, $1) RETURNING iddetalle;", [req.body.detalles]).then(data => {
            console.dir(data)
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})


app.post("/insert_details_nota", function(req, res) {
    console.log(req.query.detalles)
    //console.log(req.body.detalles); si la hago de esta manera el body viene vacío
    try {
        pool.query("INSERT INTO DETALLES_ORDEN(iddetalle, descripcion_detalle) VALUES(DEFAULT, $1) RETURNING iddetalle;", [req.query.detalles]).then(data => {
            console.dir(data)
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})
//---------------------------------------------
app.post("/order_request", function(req, res) {
    res.redirect("/order_req_get")
})

app.post("/order_insert", function(req, res) {
    var idCuenta = req.body.idCuenta
    var fechaRegistro = req.body.fechaRegistro
    // http://stackoverflow.com/questions/684672/how-do-i-loop-through-or-enumerate-a-javascript-object
    var objects = req.body.objects
    var query = ""
    var iddetalle = req.body.iddetalle;
    let total='';
    // var element = {}
    for (var key in objects) {

        total = objects[key].cantidad * objects[key].precioproducto;
        if (objects.hasOwnProperty(key)) {
            // ATENCION: No cambiar a comillas dobles. Crear el query aqui y realizar el insert en este caso dentro de este for se deben generar n inserts. uno por cada iteracion porque son ordenes independientes
            query = "INSERT INTO ORDEN (idProducto, idCuenta, cantidadProducto, estadoOrden, fechaRegistroOrden, precioUnitarioProducto,total_orden, subtotal,iddetalle, montodescuento) VALUES (" +
                objects[key].idproducto + ", " +
                idCuenta + ", " +
                objects[key].cantidad + ", " +
                "'Pendiente'" + ", " +
                "'" + fechaRegistro + "'" + ", " +
                objects[key].precioproducto + "," + 
                total + "," + 
                total + ","+ 0 + ", 0);"
            try {
                pool.query(query, function(error, results, fields) {

                    if (error) {
                        console.error(error)
                        res.status(500).end()
                        throw error
                    } else {}
                    // console.dir(results);
                    // res.send(true).end();
                })
            } catch (error) {}
        } else {
            console.error("Error: objects dont have own property key")
        }
    }
    res.send(true).end()
})
app.get("/get_numeroDocumento", function(req, res) {
    // del 32 al 41
    //var data= getParameterByName("datosConsecutivo");
    try {
        pool.query("SELECT idfactura FROM FACTURA ORDER BY idfactura DESC LIMIT 1;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
    //console.log("informacion de consecutivo ",req.obj.param("casamatriz"));
})

app.get("/emisor_tipo_identificacion", function(req, res) {
    try {
        pool.query("SELECT emisor_tipo_identificacion, emisor_numero, casamatriz, puntoventa FROM EMISOR;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
        })
    } catch (error) {}
})

app.get("/credenciales_emisor", function(req, res) {
    try {
        pool.query("SELECT idemisor, e_nombre, emisor_tipo_identificacion, emisor_numero, e_nombrecomercial, e_provincia, e_canton, e_distrito, e_otras_senas, emisor_telefono_codigopais, emisor_telefono_numtelefono, emisor_fax_codigopais, emisor_fax_numtelefono, e_correoelectronico, file_p12, key_username, casamatriz, puntoventa, tipo_producto, codigo_producto, idfile, downloadcode, iduserapi, usernameapi, passwordapi, acercade, ubicacion, codigo_actividad FROM EMISOR;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
        })
    } catch (error) {}
})

app.get('/api/unidadmedida/', (req, res) => {

    const unidadMedida = listaUnidadesMedida();
    res.status(200).send(unidadMedida);
})

app.get("/get_pin", function(req, res) {
    try {
        pool.query("SELECT pin_p12 FROM EMISOR;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
        })
    } catch (error) {}
})


app.put("/factura/actualizar", function(req, res) {

    //obtengo los datos que vienen del cliente en la variable dataFactura
    const datosFactura = JSON.parse(req.query.obj);

    //Luego asigno los valores del objeto en cada variable
    const totalservgravados = datosFactura.total_serv_gravados;
    const total_serv_exentos = datosFactura.total_serv_exentos;
    const total_serv_exonerado = datosFactura.total_serv_exonerado;
    const total_merc_gravada = datosFactura.total_merc_gravada;
    const total_merc_exenta = datosFactura.total_merc_exenta;
    const total_merc_exonerada = datosFactura.total_merc_exonerada;
    const total_gravados = datosFactura.total_gravados;
    const total_exentos = datosFactura.total_exentos;
    const total_exonerado = datosFactura.total_exonerado;
    const total_ventas = datosFactura.total_ventas;
    const total_descuentos = datosFactura.total_descuentos;
    const total_ventas_neta = datosFactura.total_ventas_neta;
    const total_impuestos = datosFactura.total_impuestos;
    const total_comprobante = datosFactura.total_comprobante;
    const idreceptor = datosFactura.idreceptor;
    const receptor_numero = datosFactura.receptorNumero;
    const tipoCambio = datosFactura.tipoCambio;
    const tipoFactura = datosFactura.tipo;

    try{
        pool.query('SELECT actualizar_campos_factura($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18)',[totalservgravados,total_serv_exentos,total_serv_exonerado,total_merc_gravada,total_merc_exenta,total_merc_exonerada,
            total_gravados,total_exentos,total_exonerado,total_ventas,total_descuentos,total_ventas_neta,total_impuestos,total_comprobante,idreceptor,receptor_numero,tipoCambio,tipoFactura]).then(data => {
                
            res.status(200).send(JSON.stringify(data));
        })
        .catch(err => res.status(500).send(JSON.stringify(err)));
    }catch(err){}
})
//--------------------------------------------------------------

//-----------------------------------------------------------
app.post("/order_update_other_fileds", function(req, res) {
    var idCuenta = req.body.idCuenta
    var fechaRegistro = req.body.fechaRegistro
    // http://stackoverflow.com/questions/684672/how-do-i-loop-through-or-enumerate-a-javascript-object
    var objects = req.body.objects
    var query = ""
    // var element = {}
    for (var key in objects) {
        if (objects.hasOwnProperty(key)) {


            // ATENCION: No cambiar a comillas dobles. Crear el query aqui y realizar el insert en este caso dentro de este for se deben generar n inserts. uno por cada iteracion porque son ordenes independientes
            query = "INSERT INTO ORDEN (idProducto, idCuenta, cantidadProducto, estadoOrden, fechaRegistroOrden, precioUnitarioProducto) VALUES (" +
                objects[key].idproducto + ", " +
                idCuenta + ", " +
                objects[key].cantidad + ", " +
                "'Pendiente'" + ", " +
                "'" + fechaRegistro + "'" + ", " +
                objects[key].precioproducto + ");"
            try {
                pool.query(query, function(error, results, fields) {
                    if (error) {
                        console.error(error)
                        res.status(500).end()
                    } else {
                        res.status(200).send(JSON.stringify(data))
                    }
                    // console.dir(results);
                    // res.send(true).end();
                })
            } catch (error) {}
        } else {
            console.error("Error: objects dont have own property key")
        }
    }
    res.send(true).end()
})

//--------------------------------------------------------------
app.get("/consumido", function(req, res, callback) {
    // copy of api/inventario/consumido to export excel
    // it does not work if the address is /api/inventario/consumido
    try {

        pool.query("SELECT i.idInventario, i.descripcionInventario, CAST (SUM(o.cantidadProducto * ip.cantidadNecesaria) AS INTEGER) AS Consumo, i.unidad FROM INVENTARIO i INNER JOIN INVENTARIOPRODUCTO ip ON i.idInventario = ip.idInventario INNER JOIN ORDEN o ON ip.idProducto = o.idProducto INNER JOIN FACTURA f ON o.idFactura = f.idFactura WHERE f.estadoFactura = 1 GROUP BY i.idInventario ORDER BY i.idInventario;", [])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}

})


//---------------------------------------------------------------

app.post("/commanda", function(req, res) {
    var idCuenta = req.body.idCuenta
    var idEmpleado = req.body.idEmpleado
    var fechaRegistro = req.body.fechaRegistro
    var cuentaMesero = "C:" + idCuenta + ":E:" + idEmpleado
    var objects = req.body.objects
    var element = {}
    var cliente = ""
    var queryCuenta = "SELECT concat(cl.nombreCliente, ' ', cl.apellidoCliente) AS nombre FROM CLIENTE cl inner JOIN CUENTA cu on cl.idCliente = cu.idCliente WHERE cu.idCuenta = ? AND cu.estadoCuenta = 'Activa';" // What is the nombreCliente+apellidoCliente WHERE idCuenta.
    try {
        pool.query(queryCuenta, idCuenta, function(error, results, fields) {
            if (error) {
                console.error(error)
                console.error("Failed with query: " + queryCuenta)
                res.status(500).end()
                throw error
            } else {
                // console.log("cantidad in commanda4 : " + objects[Object.keys(objects)[loop.iteration()]].cantidad);
                cliente = results[0].nombre
                // console.log("cliente: " + cliente);
            }
        })
    } catch (error) {}

    // for (var key in objects) {
    asyncLoop(Object.keys(objects).length, function(loop) {
        element = {}
        if (objects.hasOwnProperty(Object.keys(objects)[loop.iteration()])) {
            var qProducto = "SELECT descripcionProducto FROM PRODUCTO WHERE idProducto = ? ;"
            var descProducto = ""
            // console.log("cantidad in commanda2 : " + objects[Object.keys(objects)[loop.iteration()]].cantidad);
            try {
                pool.query(qProducto, objects[Object.keys(objects)[loop.iteration()]].idProducto, function(error, results, fields) {
                    if (error) {
                        console.error(error)
                        console.error("Failed with query: " + qProducto)
                        res.status(500).end()
                        loop.break()
                        throw error
                    } else {
                        // console.log("cantidad in commanda4 : " + objects[Object.keys(objects)[loop.iteration()]].cantidad);
                        descProducto = results[0].descripcionProducto
                        // console.log("cliente2: " + cliente);
                        element = {
                            idProducto: objects[Object.keys(objects)[loop.iteration()]].idProducto,
                            cantidad: objects[Object.keys(objects)[loop.iteration()]].cantidad,
                            categoria: objects[Object.keys(objects)[loop.iteration()]].descripcionCategoria,
                            descProducto: descProducto,
                            cuentaMesero: cuentaMesero,
                            fechaRegistro: fechaRegistro,
                            cliente: cliente
                        }
                        // console.log("commanda:" + element.categoria);
                        // console.dir(element);
                        if (element.categoria === "Restaurante") {
                            imprimirOrden(element)
                            console.log("Platillo_Solicitado: " + element.descProducto)
                            element = {}
                        }
                        loop.next()
                    }
                })
            } catch (error) {}
        }
    }, function() {
        // This is your final callback
        // ALL OBJECTS HANDLED PROPERLY. Maybe put your res.end here instead?
        printer.printVerticalTab()
        res.status(200).end()
    })
})

app.put("/update_discount", function(req, res) {


      let idorden = req.body.id;
      let descuento = req.body.descuento;
      let porcentajeDescuento = req.body.porcentajeDescuento;
      let naturaleza = req.body.naturaleza;
      let total = req.body.total;
      let subtotal = req.body.subtotal;
      
    try {
        pool.query("UPDATE ORDEN SET montodescuento = $1, descuentoorden = $2, naturalezadescuento= $3, total_orden= $4, subtotal= $5 WHERE idorden = $6", [descuento, porcentajeDescuento, naturaleza, total, subtotal, idorden]).then(data => {
            console.log("todo bien")
            res.status(200).send(JSON.stringify(data))

        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

function asyncLoop(iterations, func, callback) {
    var index = 0
    var done = false
    var loop = {
        next: function() {
            if (done) {
                // Return nothing if you call loop.next when loop is finished.
                return
            }
            if (index < iterations) {
                index++
                func(loop)
            } else {
                done = true
                callback()
            }
        },
        iteration: function() {
            return index - 1
        },
        break: function() {
            // If one query fails you want to prematurely stop the for loop and inform the client.
            done = true
            callback()
        }
    }
    loop.next()
    return loop
}

function imprimirOrden(element) {
    console.log("element")
    console.dir(element)
    printer.alignCenter()
    printer.bold(true)
    printer.tableCustom([{
        text: element.cuentaMesero,
        align: "LEFT",
        width: 0.40
    }, {
        text: element.descProducto,
        align: "CENTER",
        width: 0.49
    }, {
        text: element.cantidad,
        align: "RIGHT",
        width: 0.11
    }])
    printer.println(element.cliente)

    printer.bold(false)
    printer.printVerticalTab()
    send(element)
    printer.clear()
    // printer.println(element.fechaRegistro);
    /* printer.printImage("ln-line.png", function (done) {
      // printer.cut()
      // printer.printVerticalTab()
      printer.execute(function (err) {
      if (err) {
        console.error("Print failed", err);
      } else {
        console.log("Print done: " + element.descProducto + ": " + element.cantidad)
        printer.clear()
      }
      })
    }) */
}

function send(element) {
    // printer.cut();
    // printer.printVerticalTab();
    printer.execute(function(err) {
        if (err) {
            console.error("Print failed", err)
        } else {
            console.log("Print done for element")
            console.dir(element)
            // console.log("Print done: " + element.descProducto + ": " + element.cantidad)
            printer.clear()
        }
    })
}

app.get("/order_req_get", function(req, res) {
    res.sendFile(path.join(__dirname, ORDER_REQUEST_PAGE))
})
// =============================================================================
// FACTURAS
// =============================================================================
app.post("/insertar_factura", function(req, res) {

    console.log(req.body)
    var subTotal = req.body.subTotal
    var porcentajeDescuento = req.body.descuento
    var cantPersonas = req.body.cantPersonas
    var idCuenta = req.body.idCuenta
    var idEmpleado = req.body.idEmpleado
    var formaPago = req.body.medioPago
    var tipoComprobante = req.body.tipoComprobante
    var condicionVenta = req.body.condicionVenta
    var medioPago = req.body.medioPago
    if (DEBUG) {
        console.log("API POST: /insertar_factura")
        console.dir(req.body)
        //console.dir(tipoComprobante)
    }
    //console.log( generacion_clave_numerica());
    //this function internally calls a promise
    try {
        pool.query("INSERT INTO FACTURA (subTotal, porcentajeDescuento, cantidadPersonas, idCuenta, idEmpleado, formaPago, condicion_venta, medio_pago, tipo) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9) RETURNING idfactura", [subTotal, porcentajeDescuento, cantPersonas, idCuenta, idEmpleado, formaPago, condicionVenta, medioPago, tipoComprobante])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed: insertar_factura")
            })
    } catch (error) {}


})

app.get("/factura", function(req, res) {
    var idCuenta = req.query.idCuenta
    if (!idCuenta || idCuenta === undefined || idCuenta === null || idCuenta === null) {
        console.error("Seleccione una Cuenta")
        res.redirect("/sopa#!/restaurante")
    } else {
        try {
            pool.query("SELECT o.idOrden, p.descripcionProducto, p.precioProducto, p.idCategoria, o.cantidadProducto, o.preciounitarioproducto * o.cantidadproducto AS subTotal, TO_CHAR(o.fechaRegistroorden, 'DD/MM/YY HH24:MI') as fechaRegistro FROM ORDEN o INNER JOIN CUENTA c ON o.idCuenta = c.idCuenta INNER JOIN PRODUCTO p ON o.idProducto = p.idProducto WHERE c.idCuenta = $1 AND o.estadoOrden = 'Pendiente'", [idCuenta]).then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
        } catch (error) {}
    }
})

app.get("/cantidadFacturas", function(req, res) {
    try {
        pool.query("SELECT COALESCE(MAX(idFactura),0) AS Factura FROM FACTURA;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.get("/dataFactura_toPDF", function(req, res) {

    let idfactura = req.query.idfactura;
    try {
        pool.query("SELECT f.consecutivo, f.clavenumerica, f.Fecharegistrofactura, f.plazo_credito, f.condicion_venta, f.medio_pago, f.codigomoneda, f.tipocambio, f.totalservgravados, f.totalservexentos, f.totalmercanciasgravadas, f.totalmercanciasexentas, f.totalgravado, f.totalexento, f.totalventa, f.totaldescuentos, f.totalventaneta, f.totalimpuesto, f.totalcomprobante, f.tipo FROM factura f WHERE idfactura = $1; ", [idfactura]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.get("/dataFactura/perFechas", function (req, res) {
   
    let fecha1= req.query.fecha1;
    let fecha2= req.query.fecha2;


    try {
        pool.query("SELECT f.consecutivo, f.clavenumerica, f.fechaemision, f.plazo_credito, f.condicion_venta, f.medio_pago, f.codigomoneda, f.tipocambio, f.totalservgravados, f.totalservexentos, f.totalmercanciasgravadas, f.totalmercanciasexentas, f.totalgravado, f.totalexento, f.totalventa, f.totaldescuentos, f.totalventaneta, f.totalimpuesto, f.totalcomprobante, f.tipo, f.idfactura, f.status, r.receptor_numero, r.correoelectronico, e.e_correoelectronico FROM factura f, receptor r, emisor e WHERE f.fecharegistrofactura >= $1 AND f.fecharegistrofactura <= $2 AND f.idreceptor= r.idreceptor AND f.idemisor= e.idemisor;", [fecha1,fecha2]).then(data => {
            
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})


app.get('/dataFactura/perParametro/', (req, res) => {

    try{
  // este endpoint busca por cedula, clavenumerica y una fecha
        let valor = req.query.valor;
        let tipoBusqueda= req.query.tipoBusqueda;
        let consulta='';

        if(tipoBusqueda === 'receptor'){
            
            consulta='SELECT f.consecutivo, f.clavenumerica, f.fechaemision, f.plazo_credito, f.condicion_venta, f.medio_pago, f.codigomoneda, f.tipocambio, f.totalservgravados, f.totalservexentos, f.totalmercanciasgravadas, f.totalmercanciasexentas, f.totalgravado, f.totalexento, f.totalventa, f.totaldescuentos, f.totalventaneta, f.totalimpuesto, f.totalcomprobante, f.tipo, f.idfactura, f.status, f.subtotal, r.receptor_numero, r.correoelectronico, e.e_correoelectronico FROM factura f, receptor r, emisor e WHERE r.receptor_numero= $1 AND f.idreceptor= r.idreceptor AND f.idemisor = e.idemisor;'

        }else if(tipoBusqueda==='clave'){

            consulta='SELECT f.consecutivo, f.clavenumerica, f.fechaemision, f.plazo_credito, f.condicion_venta, f.medio_pago, f.codigomoneda, f.tipocambio, f.totalservgravados, f.totalservexentos, f.totalmercanciasgravadas, f.totalmercanciasexentas, f.totalgravado, f.totalexento, f.totalventa, f.totaldescuentos, f.totalventaneta, f.totalimpuesto, f.totalcomprobante, f.tipo, f.idfactura, f.status, f.subtotal, r.receptor_numero, r.correoelectronico, e.e_correoelectronico FROM factura f, receptor r, emisor e WHERE f.clavenumerica= $1 AND f.idreceptor= r.idreceptor AND f.idemisor = e.idemisor;';

        }else if(tipoBusqueda === 'fecha'){
            
            consulta='SELECT f.consecutivo, f.clavenumerica, f.fechaemision, f.plazo_credito, f.condicion_venta, f.medio_pago, f.codigomoneda, f.tipocambio, f.totalservgravados, f.totalservexentos, f.totalmercanciasgravadas, f.totalmercanciasexentas, f.totalgravado, f.totalexento, f.totalventa, f.totaldescuentos, f.totalventaneta, f.totalimpuesto, f.totalcomprobante, f.tipo, f.idfactura, f.status, f.subtotal, r.receptor_numero, r.correoelectronico, e.e_correoelectronico FROM factura f, receptor r, emisor e WHERE f.fecharegistrofactura= $1 AND f.idreceptor= r.idreceptor AND f.idemisor = e.idemisor;'
        }

        pool.query(consulta,[valor]).then(data => {
            
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    }catch(err){}
})

app.get('/getTiposFactura', (req, res) =>{

    const url = req.query.url;
    try {
        request.get({
           url
         }, function(error, response, body){
          if(error ){
            res.status(500).send(error);
          }
           
          res.status(200).send(body);
         });
   } catch (error) {
     console.log(error)
   }

})
app.get('/getFacturas/perImpuesto', (req, res) => {
    const impuesto = req.query.impuesto;
    const tipoImpuesto = req.query.tipoimpuesto;

    try{
        pool.query('SELECT f.consecutivo, f.clavenumerica, f.fechaemision, f.plazo_credito, f.condicion_venta, f.medio_pago, f.codigomoneda, f.tipocambio, f.totalservgravados, f.totalservexentos, f.totalmercanciasgravadas, f.totalmercanciasexentas, f.totalgravado, f.totalexento, f.totalventa, f.totaldescuentos, f.totalventaneta, f.totalimpuesto, f.totalcomprobante, f.tipo, f.idfactura, f.status, f.subtotal, r.receptor_numero, r.correoelectronico,  e.e_correoelectronico, o.idorden, p.idproducto, p.idclasificacion, p.tipo_impuesto FROM factura f, receptor r,emisor e ,orden o, producto p WHERE f.idfactura = o.idfactura AND o.idproducto = p.idproducto AND p.idclasificacion = $1 AND p.tipo_impuesto= $2 AND f.idreceptor= r.idreceptor AND f.idemisor= e.idemisor;',[impuesto, tipoImpuesto]).then(data =>{
            res.status(200).send(data);
        })
        .catch(err => res.status(500).send(err));
    }catch(err){}
})
app.get('/getTCondicionVenta', (req, res) =>{

    const url = req.query.url;
    try {
        request.get({
           url
         }, function(error, response, body){
          if(error ){
            res.status(500).send(error);
          }
           
          res.status(200).send(body);
         });
   } catch (error) {
     console.log(error)
   }

})

app.get('/download', (req, res) =>{
 
    // esta funcion es la que descarga los archivos dinamicos de acuse y xml del comporbante, ademas
    //genera y envia el reporte en pdf por correo
    
    let ruta = path.resolve(__dirname)
    let archivo;
    let rutatotal;
    let tipo = req.query.tipo;
    let idfactura = req.query.id;
    let clavenumerica = req.query.clave;

    try {
        
        if(tipo === 'acuse' || tipo === 'xml'){
            if(tipo === 'acuse'){ // aqui el parametro indica cual de los dos descargar
                rutatotal = ruta +'/acuses_xml/acuse_'+clavenumerica+'.xml';
                archivo='acuses_xml/acuse_'+clavenumerica+'.xml';
            }else {
                rutatotal= ruta +'/xml_comprobantes/'+clavenumerica+'.xml';
                archivo= 'xml_comprobantes/'+clavenumerica+'.xml';
            }
        
                        
                    fileExists(rutatotal).then(exists => { // comprobar que el archivo existe con la ruta que se le pasa
                            if (exists) {
                                console.log("existe")
                                res.download(path.join(__dirname, archivo), (err)=>{ // el archivo se descarga
                    
                                    if(err) {
                                        console.log(err);
                                        res.status(500).send(err);
                                    }
                                
                                });
        
                            }else{
                                console.log("no existe")
                                obtenerXMLParaEnviar(idfactura,tipo).then(xml => {
                
                                    let xmlComprobante =Buffer.from(xml,'base64').toString('ascii');
                                        console.log(xmlComprobante);
                                
                                    crearDocumentoXML(rutatotal,xmlComprobante).then(data => {
                                        res.download(path.join(__dirname, archivo), (err)=>{ // el archivo se descarga
                                            if(err) {
                                                console.log(err);
                                                res.status(500).send(err)
                                            };
                                        });
                                    }).catch(err => res.status(500).send(err));
                                }).catch(err => res.status(500).send(err))
                            }   
                        }).catch(err => res.status(500).send(err))
        }else if(tipo === 'pdf'){

                  let correo_emisor = "";
                  let host = "";
                  const subject = "Reporte de comprobante electrónico"; // nombrecomercial
                  //let message = (receptor) => (receptor) ? "Saludos coordiales señor(a) " + receptor + " se adjuntó los         documentos xml y pdf de la factura.": '';
                  let password ="";
                  let ruta_PDF = "";
                  let nombre_PDF = "";

            if(!req.query.receptor){
            
                const {emisor} = req.query;
                const {idfactura} = req.query;
                const {clave} = req.query;
                ruta_PDF='/pdf_reportes/reporte_comprobante_'+clave+'.pdf';
                host = obtenerHostCorreo(emisor);


                        getDataOrdenesToPdf(idfactura).then(dataOrdenes => {
                            DataEncabezadoDetallesFactura(idfactura).then(dataFactura => {
                                reportes.crearReporteSinReceptor(dataOrdenes, dataFactura).then(dataReporte => {
                                    reportes.generarPDFDeComprobante(dataReporte,ruta_PDF).then(dataPDF => {
                                        nombre_PDF='reporte_comprobante_'+clave+'.pdf';
                                        enviarCorreos(emisor,emisor,dataFactura.password,host,'',subject,'',ruta_PDF,nombre_PDF,''
                                        ,'','pdf').then(dataEmail => {
                                            if (dataEmail) {
                                                res.status(200).send({
                                                    message: 'Correo enviado exitosamente'
                                                })
                                            }
                                        }).catch(err =>{ console.log(err);
                                            res.status(500).send(err)
                                        
                                        });
                                    }).catch(err => { console.log(err);
                                            res.status(500).send(err)
                                        
                                        });
                                }).catch(err => { console.log(err);
                                            res.status(500).send(err)
                                        
                                        });
                            }).catch(err => { console.log(err);
                                            res.status(500).send(err)
                                        
                                        });
                        }).catch(err => { console.log(err);
                                            res.status(500).send(err)
                                        
                                        });
            
            }else{

                const {emisor} = req.query;
                const {idfactura} = req.query;
                const {receptor} = req.query;
                const {clave} =req.query;
                ruta_PDF='/pdf_reportes/reporte_comprobante_'+clave+'.pdf';
                host = obtenerHostCorreo(emisor);
                
    
                        getDataOrdenesToPdf(idfactura).then(dataOrdenes => {
                            DataEncabezadoDetallesFactura(idfactura).then(dataFactura => {
                                reportes.crearReporteConReceptor(dataOrdenes, dataFactura).then(dataReporte => {
                                    reportes.generarPDFDeComprobante(dataReporte,ruta_PDF).then(dataPDF => {
                                        nombre_PDF='reporte_comprobante_'+clave+'.pdf';
                                        enviarCorreos(emisor,receptor,dataFactura.password,host,'',subject,'',ruta_PDF,nombre_PDF,''
                                        ,'','pdf').then(dataEmail => {
                                            enviarCorreos(emisor,emisor,dataFactura.password,host,'',subject,'',ruta_PDF,nombre_PDF,''
                                        ,'','pdf').then(dataEmail => {
                                                if (dataEmail) {
                                                    res.status(200).send({
                                                        message: 'Correo enviado exitosamente'
                                                    })
                                                }
                                            }).catch(err => { console.log(err);
                                                res.status(500).send(err)
                                    
                                            });
                                        }).catch(err => { console.log(err);
                                            res.status(500).send(err)
                                        
                                        });
                                    }).catch(err => { console.log(err);
                                            res.status(500).send(err)
                                        
                                        });
                                }).catch(err => { console.log(err);
                                            res.status(500).send(err)
                                        
                                        });
                            }).catch(err => { console.log(err);
                                            res.status(500).send(err)
                                        
                                        });
                        }).catch(err => { console.log(err);
                                            res.status(500).send(err)
                                        
                                        });
            }
        }
   
    } catch(err){

        res.status(500).send(err)
    }
})

app.put("/api/order/pay", function (req, res) {
    var record = {
        id: req.body.id,
        idFactura: req.body.idFactura
    }

    try {
        pool.query("UPDATE ORDEN SET estadoOrden = 'Cancelada', idFactura = $1 WHERE idorden = $2", [record.idFactura, record.id]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.put("/actualizarFactura", function(req, res) {
    var record = {
        id: req.body.idFactura,
        formapago: req.body.formaPago
    }
    try {
        pool.query("UPDATE FACTURA SET formaPago = $1 WHERE idFactura = $2", [record.formapago, record.id]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.put("/eliminarFactura", function(req, res) {
    var record = {
        id: req.body.idFactura
    }
    try {
        pool.query("UPDATE FACTURA SET estadoFactura = 0 WHERE idFactura = $1", [record.id]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.post("/imprimirFactura", function(req, res) {
    var marcacion = new Date()
    var Dia = marcacion.getDate()
    var Mes = marcacion.getMonth() * 1 + 1
    var Anho = marcacion.getFullYear()
    var Hora = marcacion.getHours()
    var Minutos = marcacion.getMinutes()
    if (Dia < 10) {
        Dia = "0" + Dia
    }
    if (Mes < 10) {
        Mes = "0" + Mes
    }
    if (Hora < 10) {
        Hora = "0" + Hora
    }
    if (Minutos < 10) {
        Minutos = "0" + Minutos
    }

    // var cCuenta = "C:" + req.body.idCuenta + "E:" + req.body.idEmpleado;
    // var cCuenta = "E: " + req.body.idEmpleado + " ,F: " + req.body.idFactura
    // var descuentoP = req.body.descuento
    var fechaFactura = req.body.fechaFactura
    if (fechaFactura === undefined) {
        fechaFactura = Dia + "/" + Mes + "/" + Anho + "   " + Hora + ":" + Minutos
    }
    var record = {
        // idCuenta: cCuenta,
        bill: req.body.bill,
        // nombreCliente: req.body.nombreCliente,
        // descuento: descuentoP,
        total: req.body.totalMenosDescuento,
        subtotal: req.body.subtotal
        // servicio: req.body.porcentajeServicio
    }

    /* if (typeof record.servicio === "undefined") {
      record.servicio = "0"
    } */
    if (typeof record.descuento === "undefined") {
        record.descuento = "0"
    }

    printer.openCashDrawer()
    printer.alignCenter()
    printer.bold(true)
    printer.setTextQuadArea()
    printer.println("kokteLa") // title: PUEBLO ANTIGUO LODGE
    printer.setTextNormal()
    printer.bold(false)
    printer.println("--El ride para llevar--") // "EL RIDE PARA LLEVAR"
    printer.println("Jeos Consulting S.A.") // owner: Roberto Signini Cabezas
    printer.println("3-101-672199") // Ced 6 0369 0448
    printer.newLine() // new line
    // printer.bold(true)
    /* printer.tableCustom([ // Prints table with custom settings (text, align, width, bold)
    //  { text:"Cuenta ", align:"LEFT", width:0.24 },
    {
      text: record.nombreCliente,
      align: "LEFT",
      width: 0.79,
      bold: true
    },
    {
      text: record.idCuenta,
      align: "RIGHT",
      width: 0.21
    }
    ]);
 */
    // printer.table(["Factura.","Cuenta: ",record.idCuenta]);
    // printer.println(record.idCuenta)
    // printer.bold(false)
    printer.tableCustom([{
        text: "#" + req.body.idFactura,
        alingn: "LEFT",
        width: 0.2
    }, {
        text: fechaFactura,
        alingn: "RIGHT",
        width: 0.8
    }])
    printer.newLine()
    for (var key in record.bill) {
        if (record.bill.hasOwnProperty(key)) {
            // console.log(key + " -> " + record.bill[key]);
            // console.dir(record.bill[key]);
            var descProducto = record.bill[key].descripcionproducto.trim()
            // console.log("descProducto: ");
            // console.log(descProducto);
            var subTotal = record.bill[key].subtotal
            // console.log("subtotal: ");
            // console.log(subTotal);
            // console.log("nombreCliente");
            // console.log(record.nombreCliente);
            var cantidad = record.bill[key].cantidadproducto
            // console.log("cantidad");
            // console.log(cantidad);

            printer.tableCustom([{
                text: cantidad,
                align: "LEFT",
                width: 0.11
            }, {
                text: descProducto,
                align: "CENTER",
                width: 0.68
            }, {
                text: subTotal,
                align: "RIGHT",
                width: 0.21
            }])
        }
    }

    //  printer.printVerticalTab();
    printer.printImage("/public/assets/icons/line.png", function(done) {
        printer.newLine() // new line
        console.log("record")
        console.dir(record)
        /* printer.tableCustom([ // Prints table with custom settings (text, align, width, bold)
          {
          text: "SubTotal: ",
          align: "LEFT",
          width: 0.5,
          bold: true
          },
          {
          text: record.subtotal,
          align: "RIGHT",
          width: 0.5
          }
        ])
         printer.tableCustom([ // Prints table with custom settings (text, align, width, bold)
          //  { text:"Cuenta ", align:"LEFT", width:0.24 },
          {
          text: "Servicio: ",
          align: "LEFT",
          width: 0.6,
          bold: true
          },
          {
          text: record.servicio,
          align: "RIGHT",
          width: 0.4
          }
        ]);
        printer.tableCustom([ // Prints table with custom settings (text, align, width, bold)
          //  { text:"Cuenta ", align:"LEFT", width:0.24 },
          {
          text: "Descuento: ",
          align: "LEFT",
          width: 0.6,
          bold: true
          },
          {
          text: record.descuento,
          align: "RIGHT",
          width: 0.4
          }
        ]) */
        printer.tableCustom([ // Prints table with custom settings (text, align, width, bold)
            //  { text:"Cuenta ", align:"LEFT", width:0.24 },
            {
                text: "Total: ",
                align: "LEFT",
                width: 0.5,
                bold: true
            }, {
                text: record.total,
                align: "RIGHT",
                width: 0.5
            }
        ])
        printer.newLine()
        printer.alignCenter()
        printer.println("Cliente Contado")
        printer.println("Autorizado segun resolucion")
        printer.println("#11-97 del 05/09/97 D.G.T.D")
        printer.println("fb.com/koktelacr") // "EL RIDE PARA LLEVAR"
        printer.printVerticalTab()
        printer.execute(function(err) {
            if (err) {
                console.error("Print failed", err)
            } else {
                console.log("Print done: " + record.nombreCliente)
                console.dir(record)
            }
        })
    })
    res.status(200).end()
})

// get Facturas Canceladas
app.get("/getCanceledBills", function(req, res) {
    try {
        pool.query("SELECT f.idFactura, f.consecutivo, f.clavenumerica ,f.idCuenta, f.idempleado, f.num_documento, (SELECT idfactura FROM factura ORDER BY idfactura DESC LIMIT 1) as id ,f.idperiodoventa ,(e.nombreEmpleado || ' ' || e.apellidoEmpleado) as Nombre,f.idreceptor, f.idemisor, f.receptor_numero, f.num_documento ,pv.nombrePeriodoVenta as Periodo, f.estadofactura, f.formaPago, f.cantidadpersonas, f.subTotal, f.porcentajeDescuento, f.totaldescuentos,f.condicion_venta ,TO_CHAR(f.fecharegistrofactura, 'DD/MM/YYYY HH24:MI') as Fecha, f.fecharegistrofactura ,f.fecharegistrofactura AS fecha_date FROM FACTURA f INNER JOIN EMPLEADO e ON f.idEmpleado = e.idEmpleado INNER JOIN PERIODOVENTA pv ON f.idPeriodoVenta = pv.idPeriodoVenta WHERE f.tipo = 'TE' OR f.tipo='FE';", [])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.get("/getOrdersCanceledBill/nota", function(req, res) {
    var idFactura = req.query.idFactura;
    try {
        pool.query("SELECT GET_ORDERS_PER_FACTURA($1)", [idFactura]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}

})


app.get("/getOrdersCanceledBill", function(req, res) {
    var idFactura = req.query.idFactura

    try {
        pool.query("SELECT o.idfactura ,o.idOrden,o.idcuenta , o.estadoorden, o.preciounitarioproducto, o.costounitarioproducto, o.cantidadproducto ,o.codigoservicio, o.tiposervicio, o.unidadmedida, o.unidadmedidacomercial, o.naturalezadescuento, o.codigoimpuesto, o.exoneracion_tipodocumento, o.nombreinstitucion, o.montoimpuesto, o.procentajecompra, p.descripcionProducto, f.porcentajedescuento, o.precioUnitarioProducto * o.cantidadProducto AS subTotal, p.tipo_producto, p.porcentajeimpuesto, o.idproducto, f.condicion_venta, f.plazo_credito FROM ORDEN o INNER JOIN FACTURA f ON o.idFactura = f.idFactura INNER JOIN PRODUCTO p ON o.idProducto = p.idProducto WHERE f.idFactura = $1 ORDER BY o.idOrden DESC;", [idFactura]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.get("/getOrdersCancelledBill_forPDF", function(req, res) {
    let idFactura = req.query.idFactura
    try {
        pool.query("select factura.idfactura,emisor.e_nombre as emisor_nombre,emisor.emisor_numero,emisor.emisor_telefono_codigopais, emisor.emisor_telefono_numtelefono, provincia.nombre_provincia, canton.nombre_canton, distrito.nombre_distrito, emisor.e_correoelectronico, emisor.casamatriz, emisor.puntoventa, receptor.nombre as receptor_nombre,receptor.receptor_numero, factura.clavenumerica, factura.fecharegistrofactura, factura.subtotal, factura.totaldescuentos, factura.totalservgravados, factura.totalservexentos, factura.totalexento,factura.totalmercanciasgravadas, factura.totalmercanciasexentas, factura.totalgravado, factura.totalexento, factura.totalventa, factura.totalventaneta, factura.totalimpuesto, factura.totalcomprobante, factura.tipo, factura.consecutivo  from factura inner join emisor on factura.idemisor = emisor.idemisor inner join receptor on factura.idreceptor = receptor.idreceptor inner join provincia on emisor.e_provincia = provincia.codigo_provincia inner join canton on emisor.e_canton = canton.codigo_canton AND canton.codigo_provincia=provincia.codigo_provincia inner join distrito on canton.id= distrito.codigo_canton AND distrito.codigo_distrito=emisor.e_distrito where factura.idFactura= $1;", [idFactura]).then(data => {
            switch (data[0].tipo) {
                case "01":
                    data[0].tipoComprobante_description = "Factura Electrónica";
                    break;
                case "02":
                    data[0].tipoComprobante_description = "Nota de débito electrónica";
                    break;
                case "03":
                    data[0].tipoComprobante_description = "Nota de crédito electrónica";
                    break;
                case "04":
                    data[0].tipoComprobante_description = "Tiquete Electrónico";
                    break;
                case "05":
                    data[0].tipoComprobante_description = "Confirmación de aceptación del comprobante electrónico";
                    break;
                case "06":
                    data[0].tipoComprobante_description = "Confirmación de aceptación parcial del comprobante electrónico";
                    break;
                case "07":
                    data[0].tipoComprobante_description = "Confirmación de rechazo del comprobante electrónico";
                    break;
                default:
                    data[0].tipoComprobante_description = "Otros";
            }
            console.dir(data)
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})
// =============================================================================
// DASHBOARD
// =============================================================================
app.get("/dashboard_load", function(req, res) {
    try {
        pool.query("SELECT pv.idPeriodoVenta, e.nombreEmpleado, e.apellidoEmpleado, TO_CHAR(pv.fechaInicioPeriodoVenta, 'MM/YY') AS Mes, TO_CHAR(pv.fechaInicioPeriodoVenta, 'WW') AS Semana, TO_CHAR(pv.fechaInicioPeriodoVenta, 'DD/MM/YY HH24:MI:SS') AS Fecha, pv.nombrePeriodoVenta as NombrePeriodo, pv.estadoPeriodoVenta as EstadoPeriodo, SUM(f.subTotal) AS subTotal, SUM(f.subtotal * f.porcentajeDescuento / 100) AS Descuento, SUM(CASE WHEN f.formapago = 'Efectivo' THEN f.subTotal END) - SUM(CASE WHEN f.formapago = 'Efectivo' THEN (f.subtotal * f.porcentajeDescuento / 100) END) AS Efectivos, SUM(CASE WHEN f.formapago = 'Tarjeta' THEN f.subTotal END) - SUM(CASE WHEN f.formapago = 'Tarjeta' THEN (f.subtotal * f.porcentajeDescuento / 100) END) AS Tarjetas, SUM(CASE WHEN f.formapago = 'Efectivo' THEN (f.subtotal * f.porcentajeDescuento / 100) END) AS EfectivosDescuentos, SUM(CASE WHEN f.formapago = 'Tarjeta' THEN (f.subtotal * f.porcentajeDescuento / 100) END) AS TarjetasDescuentos, SUM(f.subtotal - f.subtotal * f.porcentajeDescuento / 100) AS Total, pv.fechaInicioPeriodoVenta AS Fecha_Date  FROM PERIODOVENTA pv INNER JOIN FACTURA f ON pv.idPeriodoVenta = f.idPeriodoVenta LEFT JOIN EMPLEADO e ON pv.idEmpleado = e.idEmpleado WHERE f.estadoFactura = 1 GROUP BY pv.idPeriodoVenta, e.nombreEmpleado, e.apellidoEmpleado ORDER BY pv.fechaInicioPeriodoVenta DESC;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.get("/dashboard_all", function(req, res) {
    try {
        pool.query("select *, TO_CHAR(fechainicioperiodoventa,'DD/MM/YY') AS FECHAINICIAL, TO_CHAR(fechafinperiodoventa,'DD/MM/YY') AS FECHAFINAL, TO_CHAR(fechainicioperiodoventa,'HH:MM:SS') AS HORAINICIAL, TO_CHAR(fechafinperiodoventa,'HH:MM:SS') AS HORAFINAL from periodoventa;", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.get("/periodos_venta_load", function(req, res) {
    try {
        pool.query("SELECT idPeriodoVenta, nombrePeriodoVenta, fechaInicioPeriodoVenta, TO_CHAR(fechaInicioPeriodoVenta, 'MM/YY') as Mes, TO_CHAR(fechaInicioPeriodoVenta, 'WW') as Semana FROM PERIODOVENTA WHERE TO_NUMBER(TO_CHAR(fechaInicioPeriodoVenta, 'WW'), '99G999D9S') >= (SELECT TO_NUMBER(TO_CHAR(NOW(), 'WW'), '99G999D9S')) - 1 AND TO_NUMBER(TO_CHAR(fechaInicioPeriodoVenta, 'YYYY'), '99G999D9S') = (SELECT TO_NUMBER(TO_CHAR(NOW(), 'YYYY'), '99G999D9S')) ORDER BY idPeriodoVenta DESC", []).then(data => {
            console.log("data ",data);
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.get("/info_periodo_load", function(req, res) {
    var idPeriodo = req.query.idPeriodo
    try {
        pool.query("SELECT SUM(f.subTotal) - SUM(f.subTotal * f.porcentajeDescuento / 100) as TOTAL, f.formaPago FROM FACTURA f WHERE f.idPeriodoVenta = $1 AND f.estadoFactura = 1 GROUP BY f.formaPago ORDER BY f.formaPago;", [idPeriodo])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.get("/getPeriodDetails", function(req, res) {
    var idPeriodoDetail = req.query.idPeriodo
    try {
        pool.query("SELECT o.idOrden, f.idFactura, TO_CHAR(f.fechaRegistroFactura, 'DD/MM/YY HH24:MI:SS') AS fechafactura, p.descripcionProducto, o.cantidadProducto, f.formapago, o.precioUnitarioProducto * o.cantidadProducto AS subtotal, f.porcentajeDescuento, o.precioUnitarioProducto * o.cantidadProducto * (1 - CAST(f.porcentajeDescuento AS FLOAT8) / CAST(100 AS FLOAT8)) AS TOTAL FROM ORDEN o INNER JOIN PRODUCTO p ON o.idProducto = p.idProducto INNER JOIN FACTURA f ON f.idFactura = o.idFactura WHERE f.idPeriodoVenta = $1 AND f.estadoFactura = 1 ORDER BY f.idFactura;", [idPeriodoDetail]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.post("/create_periodo_venta", function(req, res) {
    try {
        pool.query("SELECT update_period_status ($1, $2);", [req.body.nombrePeriodo, req.body.idEmpleado])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.get("/api/period", function(req, res) {
    try {
        pool.query("SELECT idPeriodoVenta, nombrePeriodoVenta, TO_CHAR(fechaInicioPeriodoVenta, 'DD/MM/YY') AS fechaInicioPeriodo, TO_CHAR(fechaInicioPeriodoVenta, 'HH24:MI:SS') AS horaInicioPeriodo FROM public.PERIODOVENTA WHERE estadoPeriodoVenta = 'Activo'", []).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
        })
    } catch (error) {}
})

app.get("/getInfoPeriodoCierre", function(req, res) {
    var idEmpleado = req.query.idEmpleado
    var idPeriodo = req.query.idPeriodo
    try {
        pool.query("SELECT e.nombreEmpleado || ' ' || e.apellidoEmpleado as NombreEmpleado, SUM(f.subTotal) - SUM(f.subTotal * f.porcentajeDescuento / 100) AS ventaTotal FROM public.empleado e, public.factura f WHERE e.idempleado = $1 AND f.idperiodoventa = $2 AND f.estadoFactura = 1 GROUP BY e.idempleado, f.idperiodoventa;", [idEmpleado, idPeriodo]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
        })
    } catch (error) {}
})
//----------------------- NOTAS --------------------------------------

app.post("/insertar_nota", function(req, res) {

    console.log(req.query)
    var default_clave = "00000000000000000000000000000000000000000000000000";
    try {
        generacion_clave_numerica_nota(default_clave, "01").then(clave => {
            nota_consecutivo("01").then(datos => {
                pool.query("SELECT insertar_nota($1,$2,$3,$4,$5,$6,$7,$8,$9,$10, $11,$12,$13,$14,$15,$16,$17,$18,$19,$20, $21, $22, $23,$24,$25,$26, $27, $28, $29,$30, $31, $32, $33, $34,$35);", [req.query.idcuenta, req.query.idempleado, req.query.idperiodo, req.query.idreceptor, req.query.idemisor, req.query.formapago, req.query.subtotal, req.query.porcentajedescuento, req.query.cantidadpersonas, req.query.estado, req.query.codigomoneda, req.query.tipoCambio, req.query.totalservgravados, req.query.totalservexentos, req.query.total_merc_gravada, req.query.total_merc_exenta, req.query.total_gravados, req.query.total_exentos, req.query.total_ventas, req.query.total_descuentos, req.query.total_ventas_neta, req.query.total_impuestos, req.query.total_comprobante, req.query.receptor_numero, clave, datos.consecutivo, req.query.plazo_credito, req.query.condicion_venta, req.query.medio_pago, req.query.tipo, datos.num_documento, req.query.iddetalle, req.query.referencia, req.query.razon_nota, req.query.tipoComprobante])
                    .then(data => {

                        console.log("Nueva nota de credito ha sido insertada")
                        res.status(200).send(JSON.stringify(data))
                    })
            })
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {
        console.error(error)
    }
})

app.post("/insertar_ordenes_nota", function(req, res) {

    var ordenes = JSON.parse(req.query.datos);
    var query = "";
    for (let i = 0; i < ordenes.length; i++) {
        console.log("orden ", ordenes[i]);
        query = "INSERT INTO ORDEN (idcuenta, idproducto, idfactura, cantidadproducto, estadoorden, preciounitarioproducto, costounitarioproducto, descuentoorden, numerolineadetalle, tiposervicio, codigoservicio, unidadmedida, unidadmedidacomercial, detalle, montototal, montodescuento, naturalezadescuento, subtotal, codigoimpuesto, tarifa, monto, numerodocumento, nombreinstitucion, montoimpuesto, procentajecompra, montoitotallinea, iddetalle) VALUES(" + ordenes[i].idcuenta + "," + ordenes[i].idproducto + "," + ordenes[i].idfactura + "," + ordenes[i].cantidad + "," + "'" + ordenes[i].estado + "'" + "," + ordenes[i].preciounitario + "," + ordenes[i].costounitario + "," + ordenes[i].descuento + "," + ordenes[i].numerolineadetalle + "," + "'" + ordenes[i].tiposervicio + "'" + "," + "'" + ordenes[i].codigoservicio + "'" + "," + "'" + ordenes[i].unidadmedida + "'" + "," + "'" + ordenes[i].unidadmedidacomercial + "'" + "," + "'" + ordenes[i].detalle + "'" + "," + ordenes[i].montototal + "," + ordenes[i].montodescuento + "," + "'" + ordenes[i].naturalezadescuento + "'" + "," + ordenes[i].subtotal + "," + "'" + ordenes[i].codigoimpuesto + "'" + "," + ordenes[i].tarifa + "," + ordenes[i].monto + "," + ordenes[i].numero_documento + "," + "'" + ordenes[i].nombreinstitucion + "'" + "," + ordenes[i].montoimpuesto + "," + ordenes[i].porcentajecompra + "," + ordenes[i].montototallinea + "," + ordenes[i].iddetalle + ");";
        //console.log("-----------------------------")
        //console.log(query);
        try {
            pool.query(query, function(error, results, fields) {

                if (error) {
                    console.error(error)
                    res.status(500).end()
                    throw error
                } else {}
            })
        } catch (error) {
            console.error(error)
        }
    }
    res.send({
        status: 200,
        descripcion: "ordenes insertadas"
    }).end()

})

app.get("/get_comprobantes", function(req, res) {

    let tipoComprobante = req.query.tipo
    console.log(tipoComprobante);
    try {
        pool.query("SELECT f.idfactura, f.tipo_comprobante, f.fecharegistrofactura AS fecha_date, f.status, f.razon,  f.subtotal, f.receptor_numero, f.consecutivo,f.clavenumerica, f.totaldescuentos, f.porcentajedescuento , f.tipocambio,  f.totalventa, f.razon_nota, (f.totalventa / f.cantidadpersonas) AS MONTO_PERSONA, f.cantidadpersonas ,r.nombre, CONCAT(e.nombreempleado,'',e.apellidoempleado) AS empleado, f.idcuenta, f.referencia , f.medio_pago, f.status ,p.nombreperiodoventa as pv FROM factura f, receptor r, empleado e, periodoventa p WHERE f.tipo=$1 AND r.idreceptor= f.idreceptor AND e.idempleado= f.idempleado ORDER BY f.idfactura DESC;", [tipoComprobante]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
        })
    } catch (error) {}
})



/* app.get("/getDashboardTable", function (req, res) {
  var periodos = req.body.idPeriodo
  var tablaTotales = []

  asyncLoop(Object.keys(periodos).length, function (loop) {
  if (periodos.hasOwnProperty(Object.keys(periodos)[loop.iteration()])) {
    var queryRestaurante = "SELECT SUM(o.cantidad * p.precioProducto) - SUM(o.cantidad * p.precioProducto * o.descuentoAplicado / 100) + SUM(o.cantidad * p.precioProducto * o.porcentajeServicio / 100) as TotalRestaurante, SUM(o.cantidad * p.precioProducto * o.porcentajeServicio / 100) as PorcentajeRestaurante FROM ORDEN o INNER JOIN PERIODOVENTA pv ON o.idPeriodoVenta = pv.idPeriodoVenta INNER JOIN PRODUCTO p ON o.idProducto = p.idProducto INNER JOIN CATEGORIA c ON p.idCategoria = c.idCategoria WHERE o.estadoOrden = "Cancelada" AND c.descripcionCategoria = "Restaurante" AND pv.idPeriodoVenta = ? GROUP BY o.idPeriodoVenta ORDER BY pv.estadoPeriodoVenta;"

    var queryBebidas = "SELECT SUM(o.cantidad * p.precioProducto) - SUM(o.cantidad * p.precioProducto * o.descuentoAplicado / 100) + SUM(o.cantidad * p.precioProducto * o.porcentajeServicio / 100) as TotalBar, SUM(o.cantidad * p.precioProducto * o.porcentajeServicio / 100) as PorcentajeBar FROM ORDEN o INNER JOIN PERIODOVENTA pv ON o.idPeriodoVenta = pv.idPeriodoVenta INNER JOIN PRODUCTO p ON o.idProducto = p.idProducto INNER JOIN CATEGORIA c ON p.idCategoria = c.idCategoria WHERE o.estadoOrden = "Cancelada" AND c.descripcionCategoria = "Bar" AND pv.idPeriodoVenta = ? GROUP BY o.idPeriodoVenta ORDER BY pv.estadoPeriodoVenta;"

    var queryOtros = "SELECT SUM(o.cantidad * p.precioProducto) - SUM(o.cantidad * p.precioProducto * o.descuentoAplicado / 100) as TotalOtros FROM ORDEN o INNER JOIN PERIODOVENTA pv ON o.idPeriodoVenta = pv.idPeriodoVenta INNER JOIN PRODUCTO p ON o.idProducto = p.idProducto INNER JOIN CATEGORIA c ON p.idCategoria = c.idCategoria WHERE o.estadoOrden = "Cancelada" AND c.descripcionCategoria NOT LIKE "Restaurante" AND c.descripcionCategoria NOT LIKE "Bar" AND pv.idPeriodoVenta = ? GROUP BY o.idPeriodoVenta ORDER BY pv.estadoPeriodoVenta;"

    // cambiar orden de los endpoints de pantalla emisor
    // tipo de servicio o producto y codigo servicio o producto en la tabla emisor
    // codigo_SKU -> VARCHAR(24) nueva columna para tabla de productos; No es requerido

    var totalRestaurante = 0
    var totalBebidas = 0
    var totalOtros = 0
    var servicioRestaurante = 0
    var servicioBar = 0
    var totalServicio = 0

    var totalesFila = []

    try {
    pool.query(queryRestaurante, periodos[Object.keys(periodos)[loop.iteration()]], function (error, results, fields) {
      if (error) {
      console.error(error)
      console.error("Failed with query: " + queryRestaurante)
      res.status(500).end()
      loop.break()
      throw error
      } else {
      if (results.length > 0) {
        totalRestaurante = results[0].TotalRestaurante
        servicioRestaurante = results[0].PorcentajeRestaurante
      } else {
        totalRestaurante = 0
      }
      totalesFila.push(totalRestaurante)

      pool.query(queryBebidas, periodos[Object.keys(periodos)[loop.iteration()]], function (error, results, fields) {
        if (error) {
        console.error(error)
        console.error("Failed with query: " + queryBebidas)
        res.status(500).end()
        loop.break()
        throw error
        } else {
        if (results.length > 0) {
          totalBebidas = results[0].TotalBar
          servicioBar = results[0].PorcentajeBar
        } else {
          totalBebidas = 0
        }
        totalesFila.push(totalBebidas)

        pool.query(queryOtros, periodos[Object.keys(periodos)[loop.iteration()]], function (error, results, fields) {
          if (error) {
          console.error(error)
          console.error("Failed with query: " + queryOtros)
          res.status(500).end()
          loop.break()
          throw error
          } else {
          if (results.length > 0) {
            totalOtros = results[0].TotalOtros
          } else {
            totalOtros = 0
          }
          totalesFila.push(totalOtros)
          loop.next()
          }
        })
        totalServicio = servicioRestaurante + servicioBar
        totalesFila.push(totalServicio)
        }
      })
      }
    })
    tablaTotales.push(totalesFila)
    } catch (error) { }
  }
  }, function () {
  res.status(200).end(JSON.stringify(tablaTotales))
  })
}) */

app.get("/getMonthSales", function(req, res) {
    var mes = req.query.mes
    try {
        pool.query("SELECT SUM(f.subTotal) - SUM(f.subTotal * f.porcentajeDescuento / 100) AS TotalVentasMes FROM FACTURA f WHERE  TO_CHAR(f.fechaRegistroFactura, 'MM/YY') = $1 AND f.estadoFactura = 1;", [mes])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.get("/getWeekSales", function(req, res) {
    try {
        pool.query("SELECT SUM(f.subTotal) - SUM(f.subTotal * f.porcentajeDescuento / 100) AS TotalVentasSemana, TO_CHAR(f.fechaRegistroFactura, 'WW') FROM FACTURA f WHERE TO_CHAR(f.fechaRegistroFactura, 'WW') = (SELECT TO_CHAR(NOW(), 'WW')) AND f.estadoFactura = 1 GROUP BY TO_CHAR(f.fechaRegistroFactura, 'WW');", [])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})
// =============================================================================
// GASTOS
// =============================================================================
app.get("/gastos", function(req, res) {
    try {
        pool.query("SELECT g.idGasto, TO_CHAR(g.fechaGasto, 'DD/MM/YY') as fechaGasto, tg.descripcionTipoGasto, g.descripcionGasto,  g.montoGasto, g.estadoGasto, g.observacionGasto FROM GASTO g INNER JOIN TIPOGASTO tg ON g.idTipoGasto = tg.idTipoGasto ORDER BY idgasto;", [])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.get("/tipoGasto", function(req, res) {
    try {
        pool.query("SELECT * FROM TIPOGASTO ORDER BY idtipogasto;", [])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.get("/api/total_gasto/get", function(req, res) {
    try {
        pool.query("SELECT SUM(montoGasto) AS TOTAL FROM GASTO WHERE estadoGasto = 'Cancelado';", [])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.post("/api/registrar_gasto/insert", function(req, res) {
    try {
        pool.query("INSERT INTO GASTO (idTipoGasto, descripcionGasto, estadoGasto, montoGasto, observacionGasto) VALUES ($1, $2, $3, $4, $5);", [req.body.idTipoGasto, req.body.descripcionGasto, req.body.estadoGasto, req.body.montoGasto, req.body.observacionGasto])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.post("/api/tipo_de_gasto/insert", function(req, res) {
    try {
        pool.query("INSERT INTO TIPOGASTO (descripcionTipoGasto) VALUES($1);", [req.body.descripcionTipoGasto])
            .then(data => {
                res.status(200).send(JSON.stringify(data))
            }).catch(error => {
                console.error(error)
                res.status(500).end("SQL Query Failed")
            })
    } catch (error) {}
})

app.put("/api/gasto/update", function(req, res) {
    try {
        pool.query("UPDATE GASTO SET descripcionGasto = $1, estadoGasto = $2, montoGasto = $3, observacionGasto = $4 WHERE idGasto = $5;", [req.body.descripcionGasto, req.body.estadoGasto, req.body.montoGasto, req.body.observacionGasto, req.body.idGasto]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.put("/api/tipo_gasto/update", function(req, res) {
    try {
        pool.query("UPDATE TIPOGASTO SET descripcionTipoGasto = $1 WHERE idTipoGasto = $2;", [req.body.descripcionTipoGasto, req.body.idTipoGasto]).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(500).end("SQL Query Failed")
        })
    } catch (error) {}
})

app.post("/api/gasto/delete", function(req, res) {
    try {
        pool.query("DELETE FROM GASTO WHERE idGasto = ?;", [req.body.idGasto], function(error, result) {
            if (error) {
                res.stats(500).end()
                console.error(error)
                throw error
            } else {
                res.status(200).end()
            }
        })
    } catch (error) {}
})

app.post("/api/tipo_gasto/delete", function(req, res) {
    // console.dir(record)
    try {
        pool.query("DELETE FROM TIPOGASTO WHERE idTipoGasto = ? ;", [req.body.idTipoGasto], function(error, result) {
            if (error) {
                res.stats(500).end()
                console.error(error)
                throw error
            } else {
                res.status(200).end()
            }
        })
    } catch (error) {}
})

/* // Prueba Will POST
app.post("/black1", function (req, res) {
  console.log("black1 POST: " + req.body)
  console.dir(req.body)
  res.send("listo")
})

app.get("/black1", function (req, res) {
  console.log("black1 GET: " + req)
  console.dir(req.body)
  res.send("listo")
}) */
// =================================================================
// Excel
// =================================================================
//exportar valores actuales del modulo reportes 

// Todas las Facturas canceladas
app.get("/Excel1", function(req, res) {
    var query1 = "getCanceledBills"
    var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
    console.log(url)
    sopaapi(url)
        .then(function(results) {
            var conf = {}
            conf.stylesXmlFile = "./public/xml/styles-reporte-bills.xml"
            conf.name = query1
            conf.cols = [{
                caption: "idfactura",
                type: "number"
            }, {
                caption: "idcuenta",
                type: "number"
            }, {
                caption: "nombre",
                type: "string"
            }, {
                caption: "periodo",
                type: "string"
            }, {
                caption: "formpago",
                type: "string"
            }, {
                caption: "cantidadpersonas",
                type: "number"
            }, {
                caption: "subtotal",
                type: "number"
            }, {
                caption: "porcentajedescuento",
                type: "number"
            }, {
                caption: "fecha",
                type: "string"
            }]
            let resultsMapped = results.map(result =>
                Object.keys(result).map(key =>
                    typeof(result[key]) === "string" ? result[key].trim() : result[key]
                )
            )
            conf.rows = resultsMapped
            var result = nodeExcel.execute(conf)
            res.setHeader("Content-Type", "application/vnd.openxmlformats")
            res.setHeader("Content-Disposition", "attachment; filename=" + "Reporte_Facturas.xlsx")
            res.end(result, "binary")
        }).catch(function(error) {
            console.error(error)
        })
})

app.get('/data-email', (req, res) => {
    
    const {idfactura} = req.query;
    
    try{
        pool.query('SELECT f.idfactura, e.e_correoelectronico, e.password_email AS password, r.correoelectronico FROM factura f, emisor e, receptor r WHERE f.idfactura=$1 AND f.idemisor= e.idemisor AND f.idreceptor= r.idreceptor;', [idfactura])
        .then(data => {
            res.status(200).send(data);
        })
        .catch(err => res.status(500).send(err));
    }catch(err){}
})

// Todos los periodos
app.get("/Excel2", function(req, res) {
    var query1 = "dashboard_load"
    var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
    console.log("url ",url)
    sopaapi(url)
        .then(function (results) {
            console.log(results);
            var conf = {}
            conf.stylesXmlFile = "./public/xml/styles-reporte-periodos.xml"
            conf.name = query1
            conf.cols = [{
                caption: "idperiodoventa",
                type: "number"
            }, {
                caption: "Nombre",
                type: "string"
            }, {
                caption: "Apellido",
                type: "string"
            }, {
                caption: "mes",
                type: "string"
            }, {
                caption: "semana",
                type: "number"
            }, {
                caption: "fecha",
                type: "string"
            }, {
                caption: "nombre",
                type: "string"
            }, {
                caption: "estado",
                type: "string"
            }, {
                caption: "subtotal",
                type: "number"
            }, {
                caption: "descuento",
                type: "number"
            }, {
                caption: "efectivos",
                type: "number"
            }, {
                caption: "tarjetas",
                type: "number"
            }, {
                caption: "efectivosdescuentos",
                type: "number"
            }, {
                caption: "tarjetasdescuentos",
                type: "number"
            }, {
                caption: "total",
                type: "number"
            }]
            let resultsMapped = results.map(result =>
                Object.keys(result).map(key =>
                    typeof(result[key]) === "string" ? result[key].trim() : result[key]
                )
            )
            conf.rows = resultsMapped
            console.log("resultsMapped ",resultsMapped )
            var result = nodeExcel.execute(conf)
            res.setHeader("Content-Type", "application/vnd.openxmlformats")
            res.setHeader("Content-Disposition", "attachment; filename=" + "Reporte_Periodos.xlsx")
            res.end(result, "binary")
        }).catch(function(error) {
            console.error(error)
        })
})

// Gastos
app.get("/Excel3", function(req, res) {
    var query1 = "gastos"
    var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
    console.log(url)
    sopaapi(url)
        .then(function(results) {
            var conf = {}
            conf.stylesXmlFile = "./public/xml/styles-reporte-gastos.xml"
            conf.name = query1
            conf.cols = [{
                caption: "idgasto",
                type: "number"
            }, {
                caption: "fechagasto",
                type: "string"
            }, {
                caption: "descripciontipogasto",
                type: "string"
            }, {
                caption: "descripciongasto",
                type: "string"
            }, {
                caption: "montogasto",
                type: "number"
            }, {
                caption: "estadogasto",
                type: "string"
            }, {
                caption: "observaciongasto",
                type: "string"
            }]
            let resultsMapped = results.map(result =>
                Object.keys(result).map(key =>
                    typeof(result[key]) === "string" ? result[key].trim() : result[key]
                )
            )
            console.log("conf.rows ", resultsMapped);
            conf.rows = resultsMapped
            var result = nodeExcel.execute(conf)
            res.setHeader("Content-Type", "application/vnd.openxmlformats")
            res.setHeader("Content-Disposition", "attachment; filename=" + "Reporte_Gasto.xlsx")
            res.end(result, "binary")
        }).catch(function(error) {
            console.error(error)
        })
})

// api/inventario/disponible
app.get("/Excel4", function(req, res) {
    var query1 = "disponible"
    var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
    console.log(url)
    sopaapi(url)
        .then(function(results) {
            var conf = {}
            conf.stylesXmlFile = "./public/xml/styles-reporte-inventario-disponible.xml"
            conf.name = query1
            conf.cols = [{
                caption: "idinventario",
                type: "number"
            }, {
                caption: "descripcioninventario",
                type: "string"
            }, {
                caption: "descripcioncategoriainventario",
                type: "string"
            }, {
                caption: "cantidaddisponibleinventario",
                type: "number"
            }, {
                caption: "costoinventario",
                type: "number"
            }, {
                caption: "cantidadminimainventario",
                type: "number"
            }]
            let resultsMapped = results.map(result =>
                Object.keys(result).map(key =>
                    typeof(result[key]) === "string" ? result[key].trim() : result[key]
                )
            )
            conf.rows = resultsMapped

            var result = nodeExcel.execute(conf)
            res.setHeader("Content-Type", "application/vnd.openxmlformats")
            res.setHeader("Content-Disposition", "attachment; filename=" + "Reporte_InventarioDisponible.xlsx")
            res.end(result, "binary")
        }).catch(function(error) {
            console.error(error)
        })
})

// api/inventario/consumido
app.get("/Excel5", function(req, res) {
    var query1 = "consumido"
    var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
    console.log(url)
    sopaapi(url)
        .then(function(results) {
            // console.log("results in server");
            // console.dir(results);
            var conf = {}
            conf.stylesXmlFile = "./public/xml/styles-reporte-inventario-consumido.xml"
            conf.name = query1
            conf.cols = [{
                caption: "idinventario",
                type: "number"
            }, {
                caption: "descripcioninventario",
                type: "string"
            }, {
                caption: "consumo",
                type: "number"
            }, {
                caption: "unidad",
                type: "string"
            }]
            let resultsMapped = results.map(result =>
                Object.keys(result).map(key =>
                    typeof(result[key]) === "string" ? result[key].trim() : result[key]
                )
            )
            conf.rows = resultsMapped

            var result = nodeExcel.execute(conf)
            res.setHeader("Content-Type", "application/vnd.openxmlformats")
            res.setHeader("Content-Disposition", "attachment; filename=" + "Reporte_InventarioConsumido.xlsx")
            res.end(result, "binary")
        }).catch(function(error) {
            console.error(error)
        })
})

app.get("/sendXMLtoEmail", function(req, res) {
    console.log("from server received GET sendXMLtoEmail")
    console.log(req.query.idXml)
    console.log(req.query.dataXml)
    res.status(200).end()
})

app.get("/execution", function(req, res) {
    var idPeriodo = req.query.idPeriodo
    var nombrePeriodo = req.query.nombrePeriodo
    var nombreEmpleado = req.query.nombreEmpleado
    var ventaTotal = req.query.ventaTotal
    var wurl = "http://" + server.address().address + ":" + server.address().port + "/" + "Excel2_DetallePeriodo?idPeriodo=" + idPeriodo
    var exec = require("child_process").exec
    var filename = "DetallePeriodo_" + idPeriodo + ".xlsx"
    console.log("EMAIL_TO: " + EMAIL_TO)
    var wget_url = 'wget ' + wurl + ' -O ' + '/tmp/' + filename + ' ; echo -e "to: ' + EMAIL_TO + '\nsubject: SOPA Reporte Ventas: ' + idPeriodo + ' " \\ "\n\nColaborador(a): ' + nombreEmpleado + '\nHa cerrado el periodo de venta: ' + nombrePeriodo + '\nMonto total recibido: ' + ventaTotal + ' Colones"  | (cat - && uuencode /tmp/' + filename + ' ' + filename + ' ) | sendmail -v  ' + EMAIL_TO + ' -fname=info@imagineing.com -F http://imagineing.com '
    console.log("wget_url: " + wget_url)
    exec(wget_url,
        function(error, stdout, stderr) {
            console.log("stdout: " + stdout)
            console.log("stderr: " + stderr)
            if (error !== null) {
                console.log("exec error: " + error)
            }
        })
    res.status(200).end()
})

app.get("/Excel2_DetallePeriodo", function(req, res) {
    var idPeriodo = req.query.idPeriodo
    // var final_round = req.body.final
    // if ( typeof final_round !== "undefined" && final_round === "true") {
    //  console.log("final round is not undefined and final_round is true")
    // console.dir(req)
    //  res.status(200).end("Done")
    // } else {
    // console.log("idPeriodo")
    // console.log(idPeriodo)
    // console.log("req")
    // console.dir(req)
    var query1 = "getPeriodDetails?idPeriodo=" + idPeriodo
    //  var wurl = "http://" + server.address().address + ":" + server.address().port + "/" + "Excel2_DetallePeriodo?final=true&idPeriodo=" + idPeriodo
    //  console.log("wurl")
    //  console.log(wurl)
    var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
    // console.log(url)
    sopaapi(url).then(function(results) {
        // console.log("results in server")
        // console.dir(results)
        var conf = {}
        conf.stylesXmlFile = "./public/xml/styles-reporte-detalle-periodos.xml"
        conf.name = "Periodo_" + idPeriodo
        conf.cols = [{
            caption: "idorden",
            type: "number"
        }, {
            caption: "idfactura",
            type: "number"
        }, {
            caption: "fechafactura",
            type: "string"
        }, {
            caption: "descripcionproducto",
            type: "string"
        }, {
            caption: "cantidadproducto",
            type: "number"
        }, {
            caption: "formapago",
            type: "string"
        }, {
            caption: "subtotal",
            type: "number"
        }, {
            caption: "porcentajedescuento",
            type: "number"
        }, {
            caption: "total",
            type: "number"
        }]
        let resultsMapped = results.map(result => Object.keys(result).map(key => typeof(result[key]) === "string" ? result[key].trim() : result[key]))
        conf.rows = resultsMapped
        // console.dir(conf)
        /* var exec = require("child_process").exec, child
              var wget_url = "wget " + wurl + " -O /tmp/reporte-periodo.xlsx; echo -e "to: jchavarria@imagineing.com\nsubject: Reporte de Periodo\n" | (cat - && uuencode /tmp/reporte-periodo.xlsx reporte-periodo.xlsx) | sendmail -v  jchavarria@imagineing.com -fname=ImagineIng.com -F http://ImagineIng.com "
              child = exec(wget_url,
                function (error, stdout, stderr) {
                console.log("stdout: " + stdout)
                console.log("stderr: " + stderr)
                if (error !== null) {
                  console.log("exec error: " + error)
                }
              })
              child() */
        var result = nodeExcel.execute(conf)
        var outputfile = "Reporte_Detalle_Periodo" + idPeriodo + ".xlsx"
        res.setHeader("Content-Type", "application/vnd.openxmlformats")
        res.setHeader("Content-Disposition", "attachment; filename=" + outputfile)

        res.end(result, "binary")
        // child()
    }).catch(function(error) {
        console.error(error)
    })
})

function getEmisorNumero() {
    //var cedEmisorNumber = "012345678901";
    try {
        var query1 = "/emisor/emisor_numero"
        var url = "http://" + server.address().address + ":" + server.address().port + query1
        console.log("Getting the emisor number");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(function(results) {
                    console.log("emisor :", results[0].emisor_numero)
                    var padding = "000";
                    EMISOR_NUMERO = String(results[0].emisor_numero)
                    if (String(results[0].emisor_numero).length == 12) {
                        EMISOR_NUMERO = String(results[0].emisor_numero)
                    } else if (String(results[0].emisor_numero).length == 11) {
                        EMISOR_NUMERO = padding.substring(0, 1) + String(results[0].emisor_numero);
                    } else if (String(results[0].emisor_numero).length == 10) {
                        EMISOR_NUMERO = padding.substring(0, 2) + String(results[0].emisor_numero);
                    } else
                        EMISOR_NUMERO = padding + String(results[0].emisor_numero);
                    //cedEmisorNumber = results[0].emisor_numero
                    resolve(String(EMISOR_NUMERO))
                })
                .catch(function(error) {
                    console.error("sopaapi() rejected with below error in getEmisorNumero():")
                    console.error(error)
                    reject(error)
                })
        })
    } catch (err) {
        console.error("An error occurred in the try catch for getEmisorNumero()")
    }
}

function getEmisorCredentials() {
    try {
        var query1 = "/credenciales_emisor"
        var url = "http://" + server.address().address + ":" + server.address().port + query1
        console.log("Getting the emisor credentials");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(function(results) {
                    if (results[0].downloadcode !== "undefined" && results[0].codigo_actividad !== "undefined") {
                        DOWNLOADCODE = results[0].downloadcode;
                        CODIGO_ACTIVIDAD = results[0].codigo_actividad;
                        if (DEBUG) {
                            console.log("getEmisorCredentials: ")
                            console.dir(results[0])
                        }
                    } else {
                        console.error("getEmisorCredentials Failed to get: ");
                        console.error("downloadcode OR codigo_actividad");
                        console.error(results[0]);
                    }
                    resolve(String(results[0]))
                })
                .catch(function(error) {
                    console.error("sopaapi() rejected with below error in getEmisorCredentials():")
                    console.error(error)
                    reject(error)
                })
        })
    } catch (err) {
        console.error("An error occurred in the try catch for getEmisorCredentials()")
    }
}


//-------------- CONSECUTIVO ------
function getNumDocumento() {
    //var cedEmisorNumber = "012345678901";
    try {
        var query1 = "get_numeroDocumento"
        var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
        console.log("Getting the doc number");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(function(results) {
                    console.log("res ", results);
                    if (typeof results[0] === "undefined") {
                        console.log("undefined numero_documento")
                        num_documento = 1
                    } else {
                        num_documento = results[0].idfactura;
                    }
                    return resolve(num_documento);
                })
                .catch(function(error) {
                    console.error("sopaapi() rejected with below error in getNumDocumento():")
                    console.error(error)
                    reject(error)
                })
        })
    } catch (err) {
        console.error("An error occurred in the try catch for getNumDocumento()")
    }
}

function getFileP12() {
    ///file_p12"
    try {
        var query1 = "file_p12"
        var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
        console.log("Getting the file_p12");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(function(results) {
                    return resolve(String(results[0].file_p12))
                })
                .catch(function(error) {
                    console.error("sopaapi() rejected with below error in getFileP12():")
                    console.error(error)
                    reject(error)
                })
        })
    } catch (err) {
        console.error("An error occurred in the try catch for getFileP12()")
    }
}
//------------ FIN CONSECUTIVO -------------
function getCasamatriz_Puntoventa() {
    //var cedEmisorNumber = "012345678901";
    try {
        var query1 = "/emisor/casamatriz_puntoventa"
        var url = "http://" + server.address().address + ":" + server.address().port + query1
        console.log("Getting the Casamatriz_Puntoventa");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(function(results) {
                    casamatriz_puntoventa = String(results[0].casamatriz) + String(results[0].puntoventa)
                    //console.log(casamatriz);
                    //console.log(puntoventa);
                    //cedEmisorNumber = results[0].emisor_numero
                    return resolve(String(results[0].casamatriz + results[0].puntoventa))
                })
                .catch(function(error) {
                    console.error("sopaapi() rejected with below error in getCasamatriz_Puntoventa():")
                    console.error(error)
                    reject(error)
                })
        })
    } catch (err) {
        console.error("An error occurred in the try catch for getCasamatriz_PuntoVenta()")
    }
}

function login_llave_criptografica() {
    ///login_llave_criptografica"

    try {
        var query1 = "login_llave_criptografica"
        var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
        console.log("Getting the login_llave_criptografica");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(function(results) {
                    console.log(results);

                    return resolve(results)
                })
                .catch(function(error) {
                    console.error("sopaapi() rejected with below error in login_llave_criptografica():")
                    console.error(error)
                    reject(error)
                })
        })
    } catch (err) {
        console.error("An error occurred in the try catch for login_llave_criptografica()")
    }

}

function obtenerXMLParaEnviar(id,tipo) {
    ///login_llave_criptografica"

    try {
        var query1 = "/factura/xml/obtener?idfactura="+id+"&tipo="+tipo;
        var url = "http://" + server.address().address + ":" + server.address().port +  query1
        console.log("Getting the //factura/xml/enviar");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(function(results) {

                    const data = JSON.stringify(results);
                    const arr = JSON.parse(data); 
                    if(tipo=="xml")
                        resolve(arr[0].xml_firmado);
                    else 
                        resolve(arr[0].acuse);                      
                })
                .catch(function(error) {
                    console.error("sopaapi() rejected with below error in obtenerXMLParaEnviar():")
                    console.error(error)
                    reject(error)
                })
        })
    } catch (err) {
        console.error("An error occurred in the try catch for login_llave_criptografica()")
    }

}


function getPin_p12() {
    try {
        var query1 = "get_pin"
        var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
        console.log("Getting the get_pin");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(function(results) {
                    console.log(results);

                    return resolve(results)
                })
                .catch(function(error) {
                    console.error("sopaapi() rejected with below error in getPin_p12():")
                    console.error(error)
                    reject(error)
                })
        })
    } catch (err) {
        console.error("An error occurred in the try catch for getPin_p12()")
    }
}



//----------------------------------------------------------------------
// Internet Connection Status
function isOnline(ONLINE_TARGET, ping) {
    //Only Works in Linux Local enviroment like RPI
    //Will be deprecated but keept for legacy
    var session = ping.createSession()
    console.log("Checking the Internet Connection")

    return new Promise(function(resolve, reject) {
        session.pingHost(ONLINE_TARGET, function(error, ONLINE_TARGET) {
            if (error) {
                if (error instanceof ping.RequestTimedOutError) {
                    console.error(ONLINE_TARGET + ": Not Alive")
                    session.close()
                    reject(error)
                } else if (error instanceof ping.DestinationUnreachableError) {
                    console.error(ONLINE_TARGET + ": DestinationUnreachableError")
                    session.close()
                    reject(error)
                } else if (error instanceof ping.PacketTooBigError) {
                    console.error(ONLINE_TARGET + ": PacketTooBigError")
                    session.close()
                    reject(error)
                } else if (error instanceof ping.ParameterProblemError) {
                    console.error(ONLINE_TARGET + ": ParameterProblemError")
                    session.close()
                    reject(error)
                } else if (error instanceof ping.RedirectReceivedError) {
                    console.error(ONLINE_TARGET + ": RedirectReceivedError")
                    session.close()
                    reject(error)
                } else if (error instanceof ping.SourceQuenchError) {
                    console.error(ONLINE_TARGET + ": SourceQuenchError")
                    session.close()
                    reject(error)
                } else if (error instanceof ping.TimeExceededError) {
                    console.error(ONLINE_TARGET + ": TimeExceededError")
                    session.close()
                    reject(error)
                } else {
                    console.error(ONLINE_TARGET + ": " + error.toString())
                    session.close()
                    reject(error)
                }
            } else {
                console.log(ONLINE_TARGET + ": Alive")
                session.close()
                resolve(true)
            }
        })
    })
    session.on("close", function() {
        console.log("socket closed")
    })
}

app.get("/api/isOnline", function(req, res) {
    try {
        isOnline(ONLINE_TARGET, ping).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(200).send(JSON.stringify(error))
        })
    } catch (error) {
        console.error(error)
    }
})


function isHaciendaOnline(HACIENDA_HTTP_ADDRESS) {

    return new Promise(function(resolve, reject) {

        try {
            console.log(HACIENDA_HTTP_ADDRESS);
            request(HACIENDA_HTTP_ADDRESS, function(error, response, body) {
                if (error) {
                    console.error("error:", error); // Print the error if one occurred
                }
                // console.log(response)
                console.log("statusCode:", response && response.statusCode); // Print the response status code if a response was received
                //console.log("body:", body); // Print the HTML for the Google homepage.
                var term = response.statusCode;
                var re = new RegExp("^2[0-8][0-9]$|^29[0-9]$|^(400)$");

                if (response && re.test(term)) {
                    resolve(true)
                    console.log("HACIENDA_HTTP_ADDRESS is alive")
                } else {
                    reject(false)
                    console.error("HACIENDA_HTTP_ADDRESS is not alive")
                    console.error(response.statusCode)
                }
            });
        } catch (error) {
            console.error(error)
            console.log(" with isHaciendaOnline(): " + HACIENDA_HTTP_ADDRESS)
            reject(error)
        }
    })
}

app.get("/api/isOnline/HaciendaAPI", function(req, res) {
    try {
        isHaciendaOnline(HACIENDA_HTTP_ADDRESS).then(data => {
            res.status(200).send(JSON.stringify(data))
        }).catch(error => {
            console.error(error)
            res.status(200).send(JSON.stringify(error))
        })
    } catch (error) {

        console.error(error)
    }
})



// ==============================================
// GENERACION DE CLAVE NUMERICA
// ==============================================
// Conjunto de cincuenta digitos los cuales deben
// ser generador por el sistema de comprobantes
// electronicos del obligado tributario de forma
// automatica y consecuiva, con las medidas de
// seguridad que garantizen la inalterabilidad,
// legitimidad, inegridad de la misma; la clave
// para cada documento electronico es unica y se
// encuentra compuesta de la manera en Articulo 5

function generacion_clave_numerica(stringPreviousClaveNumerica, tipoComprobante) {
    // stringPreviousClaveNumerica es la clave anterior
    // En caso de que no hay clave numerica anterior.
    var codPais // String[1:3]
    var dia // String[4:5]
    var mes // String[6:7]
    var ano // String[8:9]
    var cedEmisor // String[10:21]
    var consecutivo // String[22:41]
    var situacionComprobante // String[42]
    var codSeguridad // String[43:50]
    var claveNumerica // Return of this function

    let situacionComprobanteAnterior = stringPreviousClaveNumerica.substring(41, 42) // String[42]
    console.log("situacionComprobanteAnterior ", situacionComprobanteAnterior)
    return new Promise(function(resolve, reject) {
        if (situacionComprobanteAnterior === "0") {
            // Creacion de Clave por Primera Vez
            try {
                isHaciendaOnline(HACIENDA_HTTP_ADDRESS).then(data => {
                    situacionComprobante = 1 // Situacion de comprobante Normal
                    // head1() ir haciendo el resto de llamados mientras determina la situacion del internet
                    codPais = getCodPais()
                    dia = getDia()
                    mes = getMes()
                    ano = getYear()
                    cedEmisor = EMISOR_NUMERO
                    //consecutivo = new_consecutivo(tipoComprobante)
                    codSeguridad = codigoSeguridad()
                    new_consecutivo(tipoComprobante)
                        .then(new_consecutivo => {
                            claveNumerica = codPais + dia + mes + ano + cedEmisor + new_consecutivo + situacionComprobante + codSeguridad

                            console.log("claveNumerica ",claveNumerica.length )
                            resolve(claveNumerica)
                        })
                        .catch(error => {
                            console.error("new_consecutivo returned an error with tipoComprobante: " + tipoComprobante + " and situacionComprobante: " + situacionComprobante)
                            console.error(error)
                            reject(error)
                        })

                }).catch(error => {
                    console.error(error)
                    situacionComprobante = 3 // Situacion de comprobante Sin Internet
                    // head1() ir haciendo el resto de llamados mientras determina la situacion del internet
                    codPais = getCodPais()
                    dia = getDia()
                    mes = getMes()
                    ano = getYear()
                    cedEmisor = EMISOR_NUMERO
                    
                    //consecutivo = new_consecutivo(tipoComprobante)
                    codSeguridad = codigoSeguridad()
                    new_consecutivo(tipoComprobante)
                        .then(new_consecutivo => {
                            claveNumerica = codPais + dia + mes + ano + cedEmisor + new_consecutivo + situacionComprobante + codSeguridad
                            console.log("claveNumerica ",claveNumerica.length )
                            resolve(claveNumerica)
                        })
                        .catch(error => {
                            console.error("new_consecutivo returned an error with tipoComprobante: " + tipoComprobante + " and situacionComprobante: " + situacionComprobante)
                            console.error(error)
                            reject(error)
                        })

                })
            } catch (error) {
                console.error(error)
                console.error("isHaciendaOnline() function failed")
                reject(error)
            }
        } else if (situacionComprobanteAnterior === "3") {
            // Primero verificar si hay internet
            try {
                isHaciendaOnline(HACIENDA_HTTP_ADDRESS).then(data => {
                    console.log(data)
                    situacionComprobante = 2 // Situacion de comprobante Contingencia
                    // head1() // ahora si llamar a los otros metodos
                    codPais = getCodPais()
                    dia = getDia()
                    mes = getMes()
                    ano = getYear()
                    cedEmisor = EMISOR_NUMERO
                    //consecutivo = new_consecutivo(tipoComprobante)
                    codSeguridad = codigoSeguridad()
                    new_consecutivo(tipoComprobante)
                        .then(new_consecutivo => {
                            claveNumerica = codPais + dia + mes + ano + cedEmisor + new_consecutivo + situacionComprobante + codSeguridad
                            console.log("claveNumerica ",claveNumerica.length )
                            resolve(claveNumerica)
                        })
                        .catch(error => {
                            console.error("new_consecutivo returned an error with tipoComprobante: " + tipoComprobante + " and situacionComprobante: " + situacionComprobante)
                            console.error(error)
                            reject(error)
                        })

                }).catch(error => {
                    console.error(error)
                    console.log("No hay Internet. Cannot send factura to hacienda")
                    // No Actualizar y abort
                    reject(error)
                })
            } catch (error) {
                console.error(error)
                console.error("isHaciendaOnline() function failed")
                reject(error)
            }
        } else {
            // Big Error. Code should not be here.
            console.error("Big Error. Code should not be here.")
            console.error("situacionComprobanteAnterior es diferente de 0 y 3")
            console.error(stringPreviousClaveNumerica)
            reject(error)
        }
    })

}

// https:// stackoverflow.com/questions/3552461/how-to-format-a-javascript-date
var getDia = function() {
    // pending to test in a date from 1 - 9
    var today = new Date()
    return ("0" + (today.getDate())).slice(-2)
}

var getMes = function() {
    var today = new Date()
    return ("0" + (today.getMonth() + 1)).slice(-2)
}

var getYear = function() {
    var today = new Date()
    return ("0" + (today.getYear())).slice(-2)
}

var getCodPais = function() {
    return "506"
}
/* getCedEmisor = function () { }
getConsecutivo = function () { }
getCodSeguridad = function () { } */


function Fn_consecutivo(parametro) {
    //parametro : consecutivo 20 caracteres
    var casamatriz = parametro.substring(0, 3);
    var puntoventa = parametro.substring(3, 8);
    var tipoComprobante = parametro.substring(8, 10);
    var valor = "0000000000";
    var consecutivo = parametro;
    var hasta = 0;
    console.log("consecutivo ", consecutivo);

    consecutivo = consecutivo.substring(10, consecutivo.length); // obtener el numero de documento
    hasta = Number(valor.length) - Number(consecutivo.length);
    //console.log("hasta :", hasta)

    //console.log(consecutivo.length)
    valor = valor.substring(0, valor.length - consecutivo.length);
    console.log(casamatriz + puntoventa + tipoComprobante + valor + consecutivo);
    return String(casamatriz + puntoventa + tipoComprobante + valor + consecutivo);
}

var codigoSeguridad = function() {

    var cantidadNumeros = 8;
    var myArray = []
    while (myArray.length < cantidadNumeros) {
        var numeroAleatorio = Math.ceil(Math.random() * cantidadNumeros);
        var existe = false;
        for (var i = 0; i < myArray.length; i++) {
            if (myArray[i] == numeroAleatorio) {
                existe = true;
                break;
            }
        }
        if (!existe) {
            myArray[myArray.length] = numeroAleatorio;
        }

    }
    console.log("números aleatorios : " + myArray.toString());
    var numeros = myArray.toString();

    for (var i = 0; i < numeros.length; i++) {
        if (numeros[i] == ",") {
            numeros = numeros.replace(",", ""); //reemplazar las comas en la cadena por una espacio vacio
        }
    }

    console.log(numeros.length);

    return String(numeros);
}

app.get("/send_tipoComprobante", function(req, res) {
    console.log("tp :", req.query.tipoComprobante)

    var default_clave = "00000000000000000000000000000000000000000000000000"
    var tipoComprobante = req.query.tipoComprobante
    return new Promise(function(resolve, reject) {
        generacion_clave_numerica(default_clave, tipoComprobante)
            .then(new_clave_numerica => {
                var clave = "";
                getNumDocumento().then(numDocumento => {
                        new_consecutivo(tipoComprobante)
                            .then(new_consecutivo => {

                                var nd = 0;
                                if (numDocumento == 1) {
                                    nd = 1;
                                } else {
                                    nd = numDocumento;
                                }
                                var data = {
                                    clavenumerica: new_clave_numerica
                                }

                                console.log("new_clave_numerica: " + new_clave_numerica)
                                if (typeof tipoComprobante === "undefined") {
                                    clave = "";
                                } else {
                                    clave = new_clave_numerica
                                }
                                try {
                                    pool.query("UPDATE FACTURA SET clavenumerica= $1, consecutivo= $2, tipo_comprobante= $3 WHERE num_documento= $4", [clave, new_consecutivo, tipoComprobante, nd])
                                        .then(data => {
                                            console.log("clavenumerica insertada")
                                            res.status(200).send(JSON.stringify(data))
                                        }).catch(error => {
                                            console.error(error)
                                            res.status(500).end("SQL Query Failed")
                                        })
                                } catch (error) {
                                    console.log(error)
                                }

                                resolve(new_clave_numerica)
                            })
                    })
                    .catch(error => {
                        console.error("An error occured at initial_parameters() callback from new_consecutivo()")
                        reject(error)
                    })
            })
            .catch(error => {
                console.error(error)
                reject(error)
            })

    })

})

function new_consecutivo(tipoComprobante) {
    console.log("tipoComprobante :", tipoComprobante);
    //TODO
    // if tipoComprobate is valid or invalid
    // implement try catch here
    let numero_documento = 0;
    var new_consecutivo = "";
    console.log("tipoComprobante in new_consecutivo() is: " + tipoComprobante)
    return new Promise(function(resolve, reject) {
        getNumDocumento().then(data => {
                getCasamatriz_Puntoventa().then(data_cp => {
                    console.log("casa matriz y puntoventa", data_cp)
                    console.log("data in getNumDocumento resolve: ")
                    console.dir(data)
                    if (data == 1) {
                        numero_documento = 1; // new numDocumento correcto
                    } else {
                        numero_documento = data
                    }
                    //cp = CASAMATRIZ_PUNTOVENTA
                    var hasta = 0;
                    var valor = "0000000000"
                    padding = valor.substring(0, valor.length - String(numero_documento).length);
                    console.log("padding: " + padding)

                    if (typeof tipoComprobante === "undefined") {
                        new_consecutivo = new_consecutivo;
                    } else {

                        new_consecutivo = String(data_cp) + String(tipoComprobante) + String(padding) + String(numero_documento);
                    }
                    console.log("new consecutivo= ", new_consecutivo)
                    resolve(new_consecutivo)
                })
            })
            .catch(error => {
                console.error("An error occured at initial_parameters() callback from new_consecutivo()")
                reject(error)
            })
    })
}

//---------------------- FUNCION DE CLAVE NUMERICA PARA LAS NOTAS DE CREDITO Y DEBITO-------
function generacion_clave_numerica_nota(stringPreviousClaveNumerica, tipoComprobante) {
    // stringPreviousClaveNumerica es la clave anterior
    // En caso de que no hay clave numerica anterior.
    var codPais // String[1:3]
    var dia // String[4:5]
    var mes // String[6:7]
    var ano // String[8:9]
    var cedEmisor // String[10:21]
    var consecutivo // String[22:41]
    var situacionComprobante // String[42]
    var codSeguridad // String[43:50]
    var claveNumerica // Return of this function

    let situacionComprobanteAnterior = stringPreviousClaveNumerica.substring(41, 42) // String[42]
    console.log("situacionComprobanteAnterior ", situacionComprobanteAnterior)
    return new Promise(function(resolve, reject) {
        if (situacionComprobanteAnterior === "0") {
            // Creacion de Clave por Primera Vez
            try {
                isHaciendaOnline(HACIENDA_HTTP_ADDRESS).then(data => {
                    situacionComprobante = 1 // Situacion de comprobante Normal
                    // head1() ir haciendo el resto de llamados mientras determina la situacion del internet
                    codPais = "506"
                    dia = getDia()
                    mes = getMes()
                    ano = getYear()
                    cedEmisor = EMISOR_NUMERO
                    //consecutivo = new_consecutivo(tipoComprobante)
                    codSeguridad = codigoSeguridad()
                    nota_consecutivo(tipoComprobante)
                        .then(new_consecutivo => {
                            claveNumerica = codPais + dia + mes + ano + cedEmisor + new_consecutivo.consecutivo + situacionComprobante + codSeguridad
                            console.log("tamaño clave", claveNumerica.length)
                            resolve(claveNumerica)
                        })
                        .catch(error => {
                            console.error("new_consecutivo returned an error with tipoComprobante: " + tipoComprobante + " and situacionComprobante: " + situacionComprobante)
                            console.error(error)
                            reject(error)
                        })

                }).catch(error => {
                    console.error(error)
                    situacionComprobante = 3 // Situacion de comprobante Sin Internet
                    // head1() ir haciendo el resto de llamados mientras determina la situacion del internet
                    codPais = "506"
                    dia = getDia()
                    mes = getMes()
                    ano = getYear()
                    cedEmisor = EMISOR_NUMERO
                    //consecutivo = new_consecutivo(tipoComprobante)
                    codSeguridad = codigoSeguridad()
                    nota_consecutivo(tipoComprobante)
                        .then(new_consecutivo => {
                            claveNumerica = codPais + dia + mes + ano + cedEmisor + new_consecutivo.consecutivo + situacionComprobante + codSeguridad
                            console.log("tamaño clave", claveNumerica.length)
                            resolve(claveNumerica)
                        })
                        .catch(error => {
                            console.error("new_consecutivo returned an error with tipoComprobante: " + tipoComprobante + " and situacionComprobante: " + situacionComprobante)
                            console.error(error)
                            reject(error)
                        })

                })
            } catch (error) {
                console.error(error)
                console.error("isHaciendaOnline() function failed")
                reject(error)
            }
        } else if (situacionComprobanteAnterior === "3") {
            // Primero verificar si hay internet
            try {
                isHaciendaOnline(HACIENDA_HTTP_ADDRESS).then(data => {
                    console.log(data)
                    situacionComprobante = 2 // Situacion de comprobante Contingencia
                    // head1() // ahora si llamar a los otros metodos
                    codPais = "506"
                    dia = getDia()
                    mes = getMes()
                    ano = getYear()
                    cedEmisor = EMISOR_NUMERO
                    //consecutivo = new_consecutivo(tipoComprobante)
                    codSeguridad = codigoSeguridad()
                    nota_consecutivo(tipoComprobante)
                        .then(new_consecutivo => {
                            claveNumerica = codPais + dia + mes + ano + cedEmisor + new_consecutivo.consecutivo + situacionComprobante + codSeguridad
                            console.log("tamaño clave", claveNumerica.length)
                            resolve(clave_numerica)
                        })
                        .catch(error => {
                            console.error("new_consecutivo returned an error with tipoComprobante: " + tipoComprobante + " and situacionComprobante: " + situacionComprobante)
                            console.error(error)
                            reject(error)
                        })

                }).catch(error => {
                    console.error(error)
                    console.log("No hay Internet. Cannot send factura to hacienda")
                    // No Actualizar y abort
                    reject(error)
                })
            } catch (error) {
                console.error(error)
                console.error("isHaciendaOnline() function failed")
                reject(error)
            }
        } else {
            // Big Error. Code should not be here.
            console.error("Big Error. Code should not be here.")
            console.error("situacionComprobanteAnterior es diferente de 0 y 3")
            console.error(stringPreviousClaveNumerica)
            reject(error)
        }
    })
}

function nota_consecutivo(tipoComprobante) {

    return new Promise((resolve, reject) => {
        getCasamatriz_Puntoventa().then(cp => {
                getNumDocumento().then(data => {
                    var numero_documento = data + 1;
                    var casamatriz_puntoventa = String(cp);
                    var padding = "0000000000";
                    var tp = tipoComprobante;
                    padding = padding.substring(0, padding.length - String(numero_documento).length)

                    var data = {
                        consecutivo: casamatriz_puntoventa + tp + padding + numero_documento,
                        num_documento: numero_documento
                    }
                    resolve(data);
                })
            })
            .catch(err => {
                console.error(err);
            })
    })
}

let crearDocumentoXML = function(path, comprobante) {

    return new Promise((resolve, reject) => {
        try {
            //Buffer.from(comprobante, "base64").toString("ascii")
            fs.appendFile(path, comprobante, function(err) {
                if (err) {
                    reject(err);
                } else {
                    console.log("Archivo creado correctamente!");
                    resolve(true);
                }
            });

        } catch (err) {
            throw err;
        }
    })
}

let enviarCorreos = function(correo_emisor='', correo_receptor='', password='', host='', comprobante='',
    nombreinstitucion='', nombreComprobante='', ruta_PDF='', nombre_PDF='', nombre_acuse='', comprobanteAcuse='', tipo) {
    
    return new Promise((resolve, reject) => {

        try {
            var transporter = nodemailer.createTransport({
                service: host,
                auth: {
                    user: correo_emisor,
                    pass: password
                }
            });
            let mailOptions={}
            
            if(!tipo){
                mailOptions = {

                        from: correo_emisor,
                        to: correo_receptor,
                        subject: nombreinstitucion,
                        text: '',
                        attachments: [{

                                filename: nombreComprobante,
                                content: Buffer.from(comprobante, "base64").toString("ascii"),
                                contentType: "application/xml"
                            }, 
                            {

                                filename: nombre_acuse,
                                content: Buffer.from(comprobanteAcuse, "base64").toString("ascii"),
                                contentType: "application/xml"
                            }
                        ]
                    };
        }else if(tipo ==='pdf'){
            mailOptions = {

                from: correo_emisor,
                to: correo_receptor,
                subject: nombreinstitucion,
                text: '',
                attachments: [{
                        filename: nombre_PDF,
                        path: ruta_PDF,
                        contentType: "application/pdf"
                    }
                ]
            };
        }
            transporter.sendMail(mailOptions, function(error, emailData) {

                if (error) {
                    
                    console.log(error);

                    return reject(error);

                } else if (emailData) {

                    console.log("correo enviado");
                    console.log(emailData);

                    return resolve(true);
                }
            })
        } catch (err) {

            console.log(err);
            reject(err);
            
        }
    })

}

function obtenerHostCorreo(correo_emisor, i = 0) { // FUNCION RECURSIVA PARA  OBTENER EL HOST DE CORREO

    //let fin;
    let index = i;
    let indice = "";

    let fin = (indice, correo_emisor) => {
        if (indice < correo_emisor.length) {

            if (correo_emisor[indice] === ".") {
                return indice;
            } else {
                return fin(indice += 1, correo_emisor);
            }
        }
    }

    if (index < correo_emisor.length) {

        if (correo_emisor[i] === "@") {
            indice = i + 1;
            let host = correo_emisor.substring(indice, fin(indice, correo_emisor));
            return host;

        } else {

            return obtenerHostCorreo(correo_emisor, i = i + 1);

        }
    }
}


function encriptar_desencriptar_password(password, estado) {

    if (estado === "encrypt") {
        let encrypted = aes256.encrypt(Secretkey, password);
        return encrypted;

    } else {

        let decrypted = aes256.decrypt(Secretkey, password);
        return decrypted;
    }
}

function DataEncabezadoDetallesFactura(id){
    ///factura/info
    
    try{

        const query1 = "factura/info?idfactura="+id;
        const url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
        console.log("Getting the DataEncabezadoDetallesFactura");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(results => {
                    let tipo ='';
                    if(results[0].tipo == 'FE') tipo ='Factura Electrónica';
                    else if(results[0].tipo == 'TE') tipo ='Tiquete Electrónico';
                    const objResponse ={
                        idfactura:	results[0].idfactura,
                        e_nombre:	results[0].e_nombre,
                        e_nombrecomercial: results[0].e_nombrecomercial,
                        e_correoelectronico: results[0].e_correoelectronico,
                        e_otras_senas: results[0].e_otras_senas,	
                        emisor_numero: results[0].emisor_numero,
                        emisor_fax_numtelefono: results[0].emisor_fax_numtelefono,
                        emisor_telefono_numtelefono: results[0].emisor_telefono_numtelefono,
                        password: encriptar_desencriptar_password(results[0].password_email,'decrypt'),
                        e_provincia: results[0].e_provincia,
                        e_canton: results[0].e_canton,
                        e_distrito: results[0].e_distrito,
                        nombre: results[0].nombre,
                        nombrecomercial: results[0].nombrecomercial,
                        correoelectronico: results[0].correoelectronico,
                        otras_senas: results[0].otras_senas,
                        receptor_numero: results[0].receptor_numero,
                        receptor_fax_numtelefono: results[0].receptor_fax_numtelefono,
                        receptor_telefono_numtelefono: results[0].receptor_telefono_numtelefono,
                        provincia: results[0].provincia,
                        canton: results[0].canton,
                        distrito: results[0].distrito,
                        consecutivo: results[0].consecutivo,
                        clavenumerica: results[0].clavenumerica,
                        fecharegistrofactura: results[0].fecharegistrofactura,
                        plazo_credito: results[0].plazo_credito,
                        condicion_venta: results[0].condicion_venta,
                        medio_pago: results[0].medio_pago,
                        codigomoneda: results[0].codigomoneda,
                        tipocambio:	results[0].tipocambio,
                        totalservgravados: results[0].totalservgravados,
                        totalservexentos: results[0].totalservexentos,
                        totalmercanciasgravadas: results[0].totalmercanciasgravadas,
                        totalmercanciasexentas: results[0].totalmercanciasexentas,
                        totalgravado: results[0].totalgravado,
                        totalexento: results[0].totalexento,
                        totalventa: results[0].totalventa,
                        totaldescuentos: results[0].totaldescuentos,
                        totalventaneta: results[0].totalventaneta,
                        totalimpuesto: results[0].totalimpuesto,
                        totalcomprobante: results[0].totalcomprobante,
                        tipo: tipo
                    }

                    resolve(objResponse)
                })
                .catch(error => {
                    console.error("sopaapi() rejected with below error in DataEncabezadoDetallesFactura():")
                    console.error(error)
                    reject(error)
                })
        })
    }catch(err) { 

        console.error(err);
    }

}
function getEmisor() {

    try {
        var query1 = "emisor"
        var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
        console.log("Getting the emisor");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(function(results) {
                    // results[password_email]=encriptar_desencriptar_password(results.password_email);
                    results.forEach(function(item) {
                        item.password_email = encriptar_desencriptar_password(item.password_email, "decrypt");
                    })
                    return resolve(results)
                })
                .catch(function(error) {
                    console.error("sopaapi() rejected with below error in getEmisor():")
                    console.error(error)
                    reject(error)
                })
        })
    } catch (err) {
        console.error("An error occurred in the try catch for getEmisor()")
    }
}

function emisorForPDF(correoelectronico) {
    try {
        var query1 = "emiter_to_PDF?correo=" + correoelectronico;
        var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
        console.log("Getting the emisor");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(function(results) {

                    // results[password_email]=encriptar_desencriptar_password(results.password_email);
                    objEmisor = {
                        e_nombre: results[0].e_nombre,
                        emisor_numero: results[0].emisor_numero,
                        e_nombrecomercial: results[0].e_nombrecomercial,
                        e_provincia: results[0].nombre_provincia,
                        e_canton: results[0].nombre_canton,
                        e_distrito: results[0].nombre_distrito,
                        e_otras_senas: results[0].e_otras_senas,
                        emisor_telefono_numtelefono: results[0].emisor_telefono_numtelefono,
                        emisor_fax_numtelefono: results[0].emisor_fax_numtelefono,
                        e_correoelectronico: results[0].e_correoelectronico,
                        password: encriptar_desencriptar_password(results[0].password_email,'decrypt')
                    }
                    return resolve(objEmisor)
                })
                .catch(function(error) {
                    console.error("sopaapi() rejected with below error in getEmisor():")
                    console.error(error)
                    reject(error)
                })
        })
    } catch (err) {
        console.error("An error occurred in the try catch for getEmisor()")
    }
}

//-------------- CONSECUTIVO ------

//-------------- FUNCIONES PARA REPORTES PDF---------------------------------------------

function getDataReceptorToPdf(correo) {
    try {
        var query1 = "receiver_to_PDF?correo=" + correo;
        var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
        console.log("Getting the getDataReceptorToPdf");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(function(results) {
                    objReceptor = {
                        nombre: results[0].nombre,
                        nombrecomercial: results[0].nombrecomercial,
                        correoelectronico: results[0].correoelectronico,
                        otras_senas: results[0].otras_senas,
                        receptor_numero: results[0].receptor_numero,
                        receptor_fax_numtelefono: results[0].receptor_fax_numtelefono,
                        receptor_telefono_numtelefono: results[0].receptor_telefono_numtelefono,
                        provincia: results[0].nombre_provincia,
                        canton: results[0].nombre_canton,
                        distrito: results[0].nombre_distrito,
                    }
                    console.log(" data result", objReceptor);
                    resolve(objReceptor)
                })
                .catch(function(error) {
                    console.error("sopaapi() rejected with below error in getDataReceptorToPdf():")
                    console.error(error)
                    reject(error)
                })
        })
    } catch (err) {
        console.error("An error occurred in the try catch for getDataReceptorToPdf()")
    }
}

function getDataOrdenesToPdf(idfactura) {

    try {
        var query1 = "orders_to_PDF?idfactura=" + idfactura;
        var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
        console.log("Getting the orders_to_PDF");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(function(results) {
                    var obj = {};
                    for (let i = 0; i < results.length; i++) {
                        obj[i] = {
                            numerolineadetalle: results[i].numerolineadetalle,
                            cantidadproducto: results[i].cantidadproducto,
                            preciounitarioproducto: results[i].preciounitarioproducto,
                            monto: results[i].monto,
                            montodescuento: results[i].montodescuento,
                            montoitotallinea: results[i].total_orden,
                            unidadmedida: results[i].unidadmedida,
                            descripcionproducto: results[i].descripcionproducto,
                            montoimpuesto: results[i].montoimpuesto
                        }
                    }
                    return resolve(obj)
                })
                .catch(function(error) {
                    console.error("sopaapi() rejected with below error in getDataOrdenesToPdf():")
                    console.error(error)
                    reject(error)
                })
        })
    } catch (err) {
        console.error("An error occurred in the try catch for getDataOrdenesToPdf()")
    }
}

function getDataFacturaToPdf(idfactura) {
    //dataFactura_toPDF
    //idfactura

    try {
        var query1 = "dataFactura_toPDF?idfactura=" + idfactura;
        var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
        console.log("Getting the orders_to_PDF");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(function(results) {

                    let tipoFactura = '';

                    if(results[0].tipo == "TE") tipoFactura ='Tiquete Electrónico';
                    else if(results[0].tipo == "FE") tipoFactura ='Factura Electrónica';
                    else if(results[0].tipo == "ND") tipoFactura ='Nota Débito Electrónica';
                    else if(results[0].tipo == "NC") tipoFactura ='Nota Crédito Electrónica';
                    let ObjFactura = {
                        clavenumerica: results[0].clavenumerica,
                        consecutivo: results[0].consecutivo,
                        fecharegistrofactura: results[0].fecharegistrofactura,
                        plazo_credito: "",
                        condicion_venta: results[0].condicion_venta,
                        medio_pago: results[0].medio_pago,
                        totalservgravados: results[0].totalservgravados,
                        totalservexentos: results[0].totalservexentos,
                        totalmercanciasgravadas: results[0].totalmercanciasgravadas,
                        totalmercanciasexentas: results[0].totalmercanciasexentas,
                        totalgravado: results[0].totalgravado,
                        totalexento: results[0].totalexento,
                        totalventa: results[0].totalventa,
                        totaldescuentos: results[0].totaldescuentos,
                        totalventaneta: results[0].totalventaneta,
                        totalimpuesto: results[0].totalimpuesto,
                        totalcomprobante: results[0].totalcomprobante,
                        tipo: tipoFactura
                    }
                    console.log(" data result", ObjFactura);
                    return resolve(ObjFactura)
                })
                .catch(function(error) {
                    console.error("sopaapi() rejected with below error in getDataFacturaToPdf():")
                    console.error(error)
                    reject(error)
                })
        })
    } catch (err) {
        console.error("An error occurred in the try catch for getDataFacturaToPdf()")
    }
}

function getDataEmailEmisorRecetor(idfactura){
    //data-email

    try {
        var query1 = "data-email?idfactura=" + idfactura;
        var url = "http://" + server.address().address + ":" + server.address().port + "/" + query1
        console.log("Getting the data-email?");
        return new Promise(function(resolve, reject) {
            sopaapi(url)
                .then(function(results) {
                    
                    resolve({
                            e_correoelectronico: results[0].e_correoelectronico,
                            password: encriptar_desencriptar_password(results[0].password,'decrypt'),
                            correoelectronico: results[0].correoelectronico
                        });
                })
                .catch(function(error) {
                    console.error("sopaapi() rejected with below error in getDataFacturaToPdf():")
                    console.error(error)
                    reject(error)
                })
        })
    } catch (err) {
        console.error("An error occurred in the try catch for getDataFacturaToPdf()")
    }
}

//-------------------------------------------------------------------------------------------
//p4zz88oRD
// ==============================================
// MAIN LOOP EXECUTION
// Starting the Server
// ==============================================
function initial_parameters() {
    console.debug("==========  Start of initial_parameters() ==========")
    //--------------------------------------
    //TODO
    // Get casa matriz and punto venta global variables
    // Get normativa global variables
    // Get codigo de seguridad is global????    
    
     //getDataEmailEmisorRecetor(46).then(data => console.log(data))
    //DataEncabezadoDetallesFactura(46);
    getEmisorNumero()
        .then(data => {
            console.log("emisor_numero: " + data + " . It is stored in Global EMISOR_NUMERO: " + EMISOR_NUMERO)
        })
        .catch(error => {
            console.error("An error occured at initial_parameters() callback from getEmisorNumero()")
        })
    getEmisorCredentials()
        .then(data => {
            console.log("downloadCode: " + DOWNLOADCODE + " . It is stored in Global DOWNLOADCODE")
            console.log("codigo_actividad: " + CODIGO_ACTIVIDAD + " . It is stored in Global CODIGO_ACTIVIDAD")
        })
        .catch(error => {
            console.error("An error occured at initial_parameters() callback from getEmisorCredentials()")
        })
    console.debug("========== End of initial_parameters() ==========")
}

var ip = require("ip")
console.dir("Listen IP: " + ip.address())

var server = app.listen(process.env.PORT || PORT, ip.address(), function() {
    var host = server.address().address
    var port = server.address().port

    console.log("SOPON listening at http://%s:%s", host, port)
    initial_parameters();
})

var server2 = app.listen(process.env.PORT || PORT, "127.0.0.1", function() {
    var host = server2.address().address
    var port = server2.address().port
    console.log("SOPON listening at http://%s:%s", host, port)

})
//CONTENT-TYPE ES LO QUE ENVIO
//DATATYPE LO QUE ME VA DEVOLVER.

//Comandos Utiles
//pg_dump --no-acl --if-exists -c --no-owner --verbose --inserts --column-inserts postgres://postgres:postgres@127.0.0.1:5432/sopa2 > sopa2_v3.sql   ```
