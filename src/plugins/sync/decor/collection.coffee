async = require "async"

class SyncCollection extends require("./base")
  
  ###
  ###

  constructor: (options, @_synchronizers) ->
    super options

  ###
  ###

  sync: (options, next) ->
    async.eachSeries @_synchronizers, ((synchronizer, next) ->
      synchronizer.sync options, next
    ), next


module.exports = SyncCollection