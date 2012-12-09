http = require 'http'
server = http.createServer()

exports.start = (portNumber) ->
  throw portException() unless portNumber?
  server.on 'request', (request, response) ->
    response.end('Hello World')
  server.listen(portNumber)

exports.stop = (callback) ->
  server.close callback

portException = ->
  "Port Number is required"
