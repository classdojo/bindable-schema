type       = require "type-component"
_          = require "underscore"
flattenObj = require "./flattenObject"

###
###

module.exports = (obj) ->
  keys = flattenObj({v:obj}, [], {})
  hash = []
  for k of keys
    hash.push k, keys[k]
  hash.join(":")


  