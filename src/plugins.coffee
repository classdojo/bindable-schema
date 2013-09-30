class Plugins
  
  ###
  ###

  constructor: () ->
    @_plugins = []

  ###
  ###

  push: (plugin) -> @_plugins.push plugin

  ###
  ###

  model: (model) ->
    for plugin in @_plugins
      plugin.model model
    @

  ###
  ###

  watch: (target, watcher, field) ->
    for plugin in @_plugins
      plugin.watch target, watcher, field



module.exports = Plugins