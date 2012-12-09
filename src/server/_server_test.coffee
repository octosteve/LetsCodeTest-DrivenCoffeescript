server = require './server'
http = require 'http'

exports.tearDown = (done) ->
  server.stop -> done()

exports.testServerRespondsToGetRequest = (test) ->
  server.start()
  http.get "http://localhost:8080", (response) ->
    test.done()

