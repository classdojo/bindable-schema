field     = require "./field"
bindable  = require "bindable"
Plugins   = require "./plugins"

class BindableSchema

  ###
  ###

  constructor: (definition) ->
    @plugins = new Plugins()
    @root = field @plugins, definition

  ###
  ###

  use: (plugin) ->
    @plugins.push plugin

  ###
  ###

  attach: (target) ->
    fieldInfo = new bindable.Object()
    @root.attach target, fieldInfo
    fieldInfo



module.exports = (definition) -> new BindableSchema definition