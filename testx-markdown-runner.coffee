fs          = require 'fs'
markedast   = require 'marked-ast'
_           = require 'lodash'
runner      = require 'testx'
yaml        = require 'testx-yaml-parser'

module.exports =
  run: (filename) ->
    ast = markedast.parse "#{fs.readFileSync filename}"
    idx = 0
    gen = (ast, level = 0, name = 'root') ->
      item = ast[idx]
      return unless item
      # console.log 'item is', idx, level, {parent: name}, item
      if item.type is 'code'
        idx += 1
        it name, -> runner.runScript yaml.parse item.code
      else if item.type is 'heading'
        next = ast[idx+1]
        name2 = item.text[0]
        if level < item.level
          idx += 1
          if next?.type is 'code'
            gen ast, item.level, "#{name}.#{name2}"
          else
            describe "#{name}.#{name2}", -> gen ast, item.level, "#{name}.#{name2}"
        else return

      gen ast, level, name

    gen _.filter ast, (a) -> a.type in ['code', 'heading']
