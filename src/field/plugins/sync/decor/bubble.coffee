class BubbleSync extends require("./base")

  ###
  ###

  load: (model, next) ->
    return next() if @options.load or @value(model)?
    @field.parent.mediator.execute "_load", model, next

  ###
  ###

  save: (model, next) ->
    return next() if @options.load
    @field.parent.mediator.execute "_save", model, next
  
  ###
  ###

  @test   : (options) -> options.field.parent and (not options.load or not options.save)
  @create : (options) -> new BubbleSync options


module.exports = BubbleSync