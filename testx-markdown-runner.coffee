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
      if item.type is 'code'
        # collect all code blocks directly under the heading
        parsedCodes = while item and item.type is 'code'
          parsed = yaml.parse item.code
          idx += 1
          item = ast[idx]
          parsed
        it name, -> runner.runScript c for c in parsedCodes

      else if item.type is 'heading'
        next = ast[idx+1]
        _name = item.text[0]
        if level < item.level
          idx += 1
          if next?.type is 'code'
            gen ast, item.level, _name
          else
            describe _name, -> gen ast, item.level, _name
        else return

      gen ast, level, name

    gen _.filter ast, (a) -> a.type in ['code', 'heading']
