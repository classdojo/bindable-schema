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

  attach: (target, info, field) ->
    for plugin in @_plugins
      plugin.attach target, info, field



module.exports = Plugins