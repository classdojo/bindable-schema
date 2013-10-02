field    = require "./field"
decor    = require "./field/decor"
bindable = require "bindable"


class BindableSchema
  
  ###
  ###

  constructor: (definition) ->
    @root = field definition, @
    @decor = decor @

    @use decor.validate
    @use decor.sync

  ###
  ###

  use: (decor) ->
    @decor.use decor
    @root.use decor

  ###
   setups a model
  ###

  setupModel: (model) -> 
    @root.setupModel model


module.exports = (definition) -> new BindableSchema definition

# optional plugins
module.exports.validate  = decor.validate
module.exports.sync      = decor.sync