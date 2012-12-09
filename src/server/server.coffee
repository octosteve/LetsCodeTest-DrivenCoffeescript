http = require 'http'
server = http.createServer()

exports.start = ->
  server.on 'request', (request, response) ->
    response.end()
  server.listen(8080)

exports.stop = (callback) ->
  server.close callback()
