
{exec} = require 'child_process'

task 'build', ->
  exec 'coffee -o lib -c src/*.coffee'

task 'clean', ->
  exec 'rm -r node_modules lib/*.js'

task 'test', ->
  exec 'NODE_ENV=test
    ./node_modules/mocha/bin/mocha
    --compilers coffee:coffee-script
    --reporter min
    --require should
    --colors
    test/detect.coffee
  ', (err, output) ->
    throw err if err
    console.log output

