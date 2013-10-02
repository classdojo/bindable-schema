class VanillaMap extends require("./base")

  ###
  ###
  
  init: () ->
    @field.mediator.on "map", (model, next) ->
      next null, model

  ###
  ###

  @test   : (options) -> true
  @create : (options) -> new VanillaMap options

module.exports = VanillaMap