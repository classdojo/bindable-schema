class BaseSync extends require("../base")

  @type: "sync"

  ###
  ###

  init: () ->
    super()

    @field.mediator.on "pre save", @_command @save
    @field.mediator.on "pre load", @_command @load

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