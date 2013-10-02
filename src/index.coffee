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



module.exports = (definition) -> new BindableSchema definition