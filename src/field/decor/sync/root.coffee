class RootSync extends require("./base")

  ###
  ###

  setupModel: (model) ->
    model.memoizer = undefined
    model.on "watching", (property) =>
      @field.child(property, true)?.mediator.execute("load", model)


  ###
  ###

  @test: (options) -> not options.field.parent
  @create: (options) -> new RootSync options

module.exports = RootSync