{spawn, exec} = require 'child_process'

task 'lint', 'Lint Everything', ->
  lint = exec "./node_modules/.bin/coffeelint Cakefile"
  lint.stdout.on 'data', (data) -> console.log data.toString()
  lint.stderr.on 'data', (data) -> console.log data.toString()
  console.log 'Done lint'
