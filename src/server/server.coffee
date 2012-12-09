http = require 'http'

exports.start = ->
  console.log 'Server Started'
  server = http.createServer()
  server.listen(8080)
