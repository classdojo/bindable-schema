async     = require "async"
toarray   = require "toarray"
type      = require "type-component"

class MultipleValidators extends require("./base")
  
  ###
  ###

  constructor: (options, @_validators) ->
    super options

  ###
  ###

  test: (context, value, next) ->
    async.eachSeries @_validators, ((validator, next) ->
      validator.test(context, value, next)
    ), next


module.exports = MultipleValidators