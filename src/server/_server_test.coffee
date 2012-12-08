"use strict"
server = require './server'
exports.testNothing = (test) ->
  test.equals 3, server.number(), "Number"
  test.done()
