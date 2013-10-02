class BaseValidator extends require("../base")

  ###
  ###

  @type: "validator"

  ###
  ###


  init: () ->
    @field.mediator.on "pre validate", @_command @validate


  ###
  ###

  _error: (defaultMessage, next) ->
    return next new Error @options.message or defaultMessage

  ###
  ###

  validate: (model, next) ->

module.exports = BaseValidator