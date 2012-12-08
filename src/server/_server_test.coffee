"use strict"
server = require './server'
assert = require 'assert'
exports.testNothing = (test) ->
  assert.equal 3, server.number(), "Number"
  test.done()
