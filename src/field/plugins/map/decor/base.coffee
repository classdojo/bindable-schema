class BaseMapper extends require("../base")
  
  ###
  ###

  @type: "map"

  ###
  ###

  init: () ->
    super()
    @refs = @field.root.options.refs or {}
    @field.mediator.on "pre map", @map

  ###
  ###

  map: (model, next) => next null, model



module.exports = BaseMapper