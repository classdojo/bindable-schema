class SyncBase

  ###
  ###

  constuctor: (@options) ->
    @field = options.field

  
  ###
  ###

  load: (model, next) ->
    next()

  ###
  ###

  save: (model, next) ->
    next()


module.exports = SyncBase