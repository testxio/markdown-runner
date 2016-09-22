fs          = require 'fs'
markedast   = require 'marked-ast'
_           = require 'lodash'
runner      = require 'testx'
yaml        = require 'testx-yaml-parser'

module.exports =
  run: (filename) ->
    ast = markedast.parse "#{fs.readFileSync filename}"
    gen = (ast, idx = 0, name) ->
      item = ast[idx]
      if item.type is 'code'
        it name, -> runner.runScript yaml.parse item.code
        gen ast, idx + 1 if idx < ast.length - 1
      else if item.type is 'heading'
        next = ast[idx+1]
        name = item.text[0]
        if next?.type is 'code'
          gen ast, idx + 1, name
        else
          describe name, -> (gen ast, idx + 1, name)

    gen _.filter ast, (a) -> a.type in ['code', 'heading']
