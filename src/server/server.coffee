http = require "http"
fs = require "fs"
server = null

exports.start = (htmlFileToServe, portNumber) ->
  throw portException unless portNumber

  server = http.createServer()
  server.on "request", (request, response) ->
    fs.readFile htmlFileToServe, (err, data) ->
      throw err if err
      response.end(data)
  server.listen portNumber

exports.stop = (callback) ->
  server.close callback

portException = ->
  "Port Number is required"
