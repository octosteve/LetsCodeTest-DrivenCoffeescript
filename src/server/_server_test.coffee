server = require './server'
http = require 'http'
fs = require 'fs'
assert = require 'assert'

TEST_FILE = 'generated/test/test.html'

exports.tearDown = (done) ->
  if fs.existsSync TEST_FILE
    fs.unlinkSync TEST_FILE
    assert.ok !fs.existsSync(TEST_FILE), "could not delete file [#{TEST_FILE}]"
  done()

exports.test_serverServesAFile = (test) ->
  testDir = 'generated/test'
  testData = "This is served from a file"

  fs.writeFileSync TEST_FILE, testData
  server.start TEST_FILE, 8080
  request = http.get "http://localhost:8080"
  request.on "response", (response) ->
    receivedData = false
    response.setEncoding "utf8"

    test.equals 200, response.statusCode, "status code"
    response.on "data", (chunk) ->
      receivedData = true
      test.equals testData, chunk, "response text"
    response.on "end", ->
      test.ok receivedData, "should have received response data"
      server.stop ->
        test.done()

exports.test_serverRequiresFileToServe = (test) ->
  test.throws ->
    server.start()
  test.done()
exports.test_serverRunsCallbackWhenStopCompletes = (test) ->
  server.start(TEST_FILE, 8080)
  server.stop -> test.done()

exports.test_stopCalledWhenServerIsntRunningThrowsAnException = (test) ->
  test.throws ->
    server.stop()
  test.done()

exports.test_serverRequiresPortNumber = (test) ->
  test.throws ->
    server.start(TEST_FILE)
  test.done()

