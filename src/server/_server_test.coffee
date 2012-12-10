server = require './server'
http = require 'http'
fs = require 'fs'
assert = require 'assert'

TEST_HOME_PAGE = 'generated/test/testHome.html'
TEST_404_PAGE = 'generated/test/test404.html'

exports.tearDown = (done) ->
  cleanUpFile TEST_HOME_PAGE
  cleanUpFile TEST_404_PAGE
  done()

exports.test_homePageFromFile = (test) ->
  expectedData = "This is the home page file"

  fs.writeFileSync TEST_HOME_PAGE, expectedData
  httpGet "http://localhost:8080", (response, responseData) ->
    test.equals 200, response.statusCode, "status code"
    test.equals expectedData, responseData, "response text"
    test.done()

exports.test_returns404FromFileForEverythingExceptTheHomepage = (test) ->
  expectedData = "This is the 404 page file"

  fs.writeFileSync TEST_404_PAGE, expectedData
  httpGet "http://localhost:8080/whammy", (response, responseData) ->
    test.equals 404, response.statusCode, "status code"
    test.equals expectedData, responseData, "404 Text"
    test.done()

exports.test_returnsHomePageWhenAskedForIndex = (test) ->
  testDir = 'generated/test'

  fs.writeFileSync TEST_HOME_PAGE, "foo"
  httpGet "http://localhost:8080/index.html", (response, responseData) ->
    test.equals 200, response.statusCode, "status code"
    test.done()

exports.test_requiresHomePageParameter = (test) ->
  test.throws ->
    server.start()
  test.done()

exports.test_requires404PageParameter = (test) ->
  test.throws ->
    server.start TEST_HOME_PAGE
  test.done()

exports.test_requiresPortNumber = (test) ->
  test.throws ->
    server.start(TEST_HOME_PAGE, TEST_404_PAGE)
  test.done()

exports.test_runsCallbackWhenStopCompletes = (test) ->
  server.start(TEST_HOME_PAGE, TEST_404_PAGE, 8080)
  server.stop -> test.done()

exports.test_stopThrowsAnExceptionWhenNotRunning = (test) ->
  test.throws ->
    server.stop()
  test.done()

httpGet = (url, callback) ->
  server.start TEST_HOME_PAGE, TEST_404_PAGE, 8080
  request = http.get url
  request.on "response", (response) ->
    receivedData = ""
    response.setEncoding "utf8"

    response.on "data", (chunk) ->
      receivedData += chunk
    response.on "end", ->
      server.stop ->
        callback response, receivedData

cleanUpFile = (file) ->
  if fs.existsSync file
    fs.unlinkSync file
    assert.ok !fs.existsSync(file), "cannot delete #{file}"

