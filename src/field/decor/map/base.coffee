class BaseMapper extends require("../base")
  
  ###
  ###

  @type: "map"
  
  ###
  ###

  init: () ->
    super()
    @field.mediator.on "pre map", @map

  ###
  ###

  map: (model, data, next) -> next null, model, data



module.exports = BaseMapper