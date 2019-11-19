var expect  = require('chai').expect;
var request = require('request');

var mainPage = `<!DOCTYPE html>\n<html lang="en">\n\n<head>\n    <meta charset="UTF-8">\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\n    <meta http-equiv="X-UA-Compatible" content="ie=edge">\n    <title>Login kokteLa</title>\n    <link rel="stylesheet" href="../css/login.css" />\n</head>\n<body>\n    <div class="loginmodal-container">\n        <form name="form-login" method="POST">\n            <input type="text" id="user" name="username" placeholder="Usuario">\n            <input type="password" id="pass" name="password" placeholder="Contraseña">\n            <input type="submit" value="Ingresar" class="login loginmodal-submit">\n        </form>\n        <!--<div class="login-help">\n            <a href="#">Register</a> - <a href="#">Forgot Password</a>\n        </div>-->\n    </div>\n    <!--<div id="back">\n        <form action="/" name="form=welcome" method="GET">\n            <span class="fontawsomeuser"></span>\n            <input type="submit" value="Regresar">\n        </form>\n    </div>-->\n    <div>\n      <center>\n        <button onclick="location.href=\'/emisor\'" type="button">Config Emisor</button>\n      </center>\n    </div>\n</body>\n\n</html>\n`;

it('Main page content', function(done) {
    request('http://localhost:8185' , function(error, response, body) {
        expect(body).to.equal(mainPage);
        done();
    });
});
