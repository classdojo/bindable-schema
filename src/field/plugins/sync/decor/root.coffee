Cache  = require "./memo/cache"
Memos  = require "./memo/dictionary"

class RootSync extends require("./base")

  ###
  ###

  setupModel: (model) ->
    model._memos = new Memos()
    model._cache = new Cache model
    model.on "watching", (property) =>
      @field.child(property, true)?.mediator.execute("watching", model)

  ###
  ###

  @test: (options) -> not options.field.parent
  @create: (options) -> new RootSync options

module.exports = RootSync