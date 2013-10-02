async     = require "async"

class ValidatorCollection extends require("./base")
  
  ###
  ###

  constructor: (options, @_validators) ->
    super options

  ###
  ###

  validate: (model, next) ->
    async.eachSeries @_validators, ((validator, next) ->
      validator.validate(model, next)
    ), next


module.exports = ValidatorCollection