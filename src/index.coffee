field    = require "./field"
decor    = require "./field/decor"
bindable = require "bindable"


class BindableSchema
  
  ###
  ###

  constructor: (definition) ->
    @root = field definition
    @root.use decor

  ###
  ###

  use: (decor) ->
    @root.use decor

  ###
   setups a model
  ###

  setupModel: (model) -> 
    @root.setupModel model


module.exports = (definition) -> new BindableSchema definition