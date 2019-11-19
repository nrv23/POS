var request = require('request-promise')

module.exports = function (url, data) {
  // console.log('arg1: ' + url);
  // console.log('arg2: ' + data);
  return new Promise(function (resolve, reject) {
    var dataType
    if (typeof url === 'undefined') {
      console.error(url)
      return reject('URL Invalid in sopa-api')
    }
    if (typeof data === 'undefined') {
      // No data provided
      request({
       url: url,
        json: true
      }, function (error, response, body) {
        if (error) {
          return reject('Unable to fecth from: ' + url)
          console.error(response)
          console.error(body)
        } else {
          return resolve(body)
        }
      }).then(function (response) {
        return resolve(response)
      }
      ).catch(function (error) {
        console.error(error)
      })
    } else {
      // Data provided
      dataType = typeof data
      console.log('dataType: ' + dataType)
    }
  })
}
//Juan Pablo de la Torre