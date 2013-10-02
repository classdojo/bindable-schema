class BaseSync extends require("../base")
  
  ###
  ###

  @type: "sync"

  ###
  ###

  init: () ->
    super()

    # incase map doesn't exist
    @field.mediator.on "post map", (model, next) -> next null, model  
    @field.mediator.on "pre save", @_command @save
    @field.mediator.on "pre load", @_command @load
    @field.mediator.on "pre watching", @_command @load

    # internal
    @field.mediator.on "pre _load", @_command @_load
    @field.mediator.on "pre _save", @_command @_save

  ###
  ###

  load: (model, next) -> 
    @_load model, next

  ###
  ###

  save: (model, next) ->
    @_save model, next

  ###
  ###

  _load: (model, next) -> next()
  _save: (model, next) -> next()


module.exports = BaseSync