server = require './server'
http = require 'http'

exports.testHttpServer = (test) ->
  server.start()
  http.get "http://localhost:8080", (response) ->

  test.done()

