http = require "http"
fs = require "fs"
server = null

exports.start = (homePageFileToServe, notFoundPageToServe, portNumber) ->
  throw portException unless portNumber

  server = http.createServer()
  server.on "request", (request, response) ->
    if request.url is '/' || request.url is '/index.html'
      response.statusCode = 200
      serveFile response, homePageFileToServe
    else
      response.statusCode = 404
      serveFile response, notFoundPageToServe
  server.listen portNumber

exports.stop = (callback) ->
  server.close callback

portException = ->
  "Port Number is required"

serveFile = (response, file) ->
  fs.readFile file, (err, data) ->
    throw err if err
    response.end(data)
