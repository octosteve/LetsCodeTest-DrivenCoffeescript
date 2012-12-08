{spawn, exec} = require 'child_process'

task 'lint', 'Lint Everything', ->
  lint_command = "./node_modules/.bin/coffeelint -r Cakefile ."
  lint = exec lint_command, (error, stdout, stderr) ->
    console.log stdout.toString()
    console.log stderr.toString()
    if error isnt null
      console.log "Errors prevented your task from continuing"
      process.exit(1)
    console.log "All Tests passed!"

task 'test', 'Test Everything', ->
  invoke 'lint'
  reporter = require('nodeunit').reporters['minimal']
  reporter.run ['src/server/_server_test.coffee']
