class BaseValidator
  
  ###
  ###

  constructor: (@options) ->
    @field = @options.field

  ###
  ###

  test: (model, next) ->
    # OVERRIDE ME

  ###
  ###

  _error: (defaultMessage, next) ->
    return next new Error @options.message or defaultMessage

  ###
  ###

  @create: (options) -> new @ options


module.exports = BaseValidator