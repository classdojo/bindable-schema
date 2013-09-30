factory   = require "./factory"
async     = require "async"
toarray   = require "toarray"
type      = require "type-component"

class ValidatorCollection extends require("./base")
  
  ###
  ###

  constructor: (options, @_validators) ->
    super options

  ###
  ###

  test: (model, next) ->
    async.eachSeries @_validators, ((validator, next) ->
      validator.test(model, next)
    ), next


module.exports = ValidatorCollection