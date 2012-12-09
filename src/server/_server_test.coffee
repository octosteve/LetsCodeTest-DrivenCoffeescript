server = require './server'
http = require 'http'
fs = require 'fs'

exports.test_serverReturnsHelloWorld = (test) ->
  server.start(8080)
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
    server.stop()

exports.test_serverServesAFile = (test) ->
  testDir = 'generated/test'
  testFile = "#{testDir}/test.html"

  try
    fs.writeFileSync testFile, "Hello World"
    test.done()
  finally
    fs.unlinkSync testFile
    test.ok !fs.existsSync(testFile), 'File should have been deleted'

exports.test_serverRunsCallbackWhenStopCompletes = (test) ->
  server.start(8080)
  server.stop -> test.done()

exports.test_stopCalledWhenServerIsntRunningThrowsAnException = (test) ->
  test.throws ->
    server.stop()
  test.done()

exports.test_serverRequiresPortNumber = (test) ->
  test.throws ->
    server.start()
  test.done()

