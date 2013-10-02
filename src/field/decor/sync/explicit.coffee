outcome = require "outcome"

class ExplicitSync extends require("./base")

  ###
  ###

  _load: (model, next) ->
    return next() unless @options.load
    @options.load model, outcome.e(next).s (data) =>
      @_map model, data, next

  ###
  ###

  _save: (model, next) ->
    return next() unless @options.save
    @options.save model, outcome.e(next).s (data) =>
      @_map model, data, next

  ###
  ###

  _map: (model, data, next) =>

    model.rawData = data

    @field.mediator.execute "map", model, outcome.e(next).s (model) =>
      unless @field.parent
        model.set model.rawData
      else
        model.set @field.path, model.rawData
      next()

  ###
  ###

  @test   : (options) -> options.load or options.save
  @create : (options) -> new ExplicitSync options


module.exports = ExplicitSync