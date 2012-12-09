http = require 'http'
server = http.createServer()

exports.start = (portNumber) ->
  server.on 'request', (request, response) ->
    response.end('Hello World')
  server.listen(portNumber)

exports.stop = (callback) ->
  server.close callback()
