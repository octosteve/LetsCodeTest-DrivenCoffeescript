server = require './server'
http = require 'http'
server.start(8080)

exports.test_serverReturnsHelloWorld = (test) ->
  request = http.get "http://localhost:8080"
  request.on 'response', (response) ->
    receivedData = false
    response.setEncoding 'utf8'

    test.equals 200, response.statusCode,  "status code"

    response.on 'data', (chunk) ->
      receivedData = true
      test.equals "Hello World", chunk, "response text"

    response.on 'end', ->
      test.ok receivedData, "should have received data"
      test.done()

exports.test_serverRunsCallbackWhenStopCompletes = (test) ->
  server.stop -> test.done()
