class BaseDecor 
  
  ###
  ###

  constructor: (@options) ->  
    @field = options.field
    @init()

  ###
  ###

  init: () ->

  ###
  ###

  value: (model) => model.get(@field.path)


module.exports = BaseDecor