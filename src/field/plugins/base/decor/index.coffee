class BaseDecor 
  
  ###
  ###

  constructor: (@options) ->  
    @field = options.field
    @field.on "setupModel", @setupModel
    @init()

  ###
  ###

  init: () ->

  ###
  ###

  value: (model) => model.get(@field.path)

  ###
  ###

  setupModel: (model) =>

  ###
  ###

  _command: (fn) -> 
    (model, next) =>
      fn.call @, model, (err) ->
        return next(err) if err?
        next null, model


module.exports = BaseDecor