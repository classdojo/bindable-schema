field     = require "./field"
bindable  = require "bindable"
Plugins   = require "./plugins"

class BindableSchema

  ###
  ###

  constructor: (definition) ->
    @plugins    = new Plugins()
    @root       = field definition, @plugins
    @modelClass = @root.options.modelClass or bindable.Object

  ###
  ###

  use: (factory) ->
    plugin = factory @
    @plugins.push plugin
    @root.use plugin

  ###
  ###

  model: (data = {}) ->
    model = new @modelClass data
    model.schema = @
    @plugins.model model
    model

  ###
  ###

  watch: (target) ->
    watcher = new bindable.Object()
    @root.watch target, watcher
    watcher

module.exports = (definition) -> new BindableSchema definition
module.exports.plugins = require("./plugins/index")