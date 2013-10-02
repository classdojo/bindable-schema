class BaseValidator extends require("../base")

  ###
  ###


  init: () ->
    @field.mediator.on "pre validate", (model, next) =>
      @validate model, (err) ->
        return next(err) if err?
        next null, model


  ###
  ###

  _error: (defaultMessage, next) ->
    return next new Error @options.message or defaultMessage

  ###
  ###

  validate: (model, next) ->

module.exports = BaseValidator