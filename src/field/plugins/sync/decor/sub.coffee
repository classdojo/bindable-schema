async = require "async"

class SubSync extends require("./base")
  
  ###
  ###

  load: (model, next) -> @_exec model, "load", next


  ###
  ###

  save: (model, next) -> @_exec model, "save", next


  ###
  ###

  _exec: (model, command, next) ->
    async.eachSeries @field.fields, ((field, next) ->
      field.mediator.execute command, model, next
    ), next


  ###
  ###

  @test   : (options) -> false
  @create : (options) -> new SubSync options

module.exports = SubSync