class BaseValidator extends require("../../base/decor")

  ###
  ###

  _error: (defaultMessage, next) ->
    return next new Error @options.message or defaultMessage

  ###
  ###

  validate: (model, next) ->

module.exports = BaseValidator