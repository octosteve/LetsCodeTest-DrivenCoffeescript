{spawn, exec} = require 'child_process'

checkNodeVersion = false

task 'lint', 'Lint Everything', ->
  invoke 'node'
  command = "./node_modules/.bin/coffeelint -r Cakefile ."
  exec command, (error, stdout, stderr) ->
    console.log stdout.toString()
    console.log stderr.toString()
    if error isnt null
      console.log "Errors prevented your task from continuing"
      process.exit(1)
    console.log "All Tests passed!"

task 'test', 'Test Everything', ->
  invoke 'lint'
  invoke 'node'
  reporter = require('nodeunit').reporters['default']
  reporter.run ['src/server/_server_test.coffee'], null, (failures) ->
    process.exit(1) if failures

task 'node', 'Verify Proper Node Version', ->
  return if checkNodeVersion

  NODE_VERSION = 'v0.8.15'
  command =  'node --version'
  sh command, (stdout) ->
    version = stdout.toString().trim()
    unless version is NODE_VERSION
      console.log "Node version #{NODE_VERSION} required"
      process.exit(1)

  checkNodeVersion = true

sh = (command, callback) ->
  exec command, (error, stdout, stderr) ->
    callback(stdout)
