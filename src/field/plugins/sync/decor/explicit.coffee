outcome = require "outcome"
dref    = require "dref"

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
    @field.mediator.execute "map", { model: model, data: data }, outcome.e(next).s (options) =>
      unless @field.parent
        model.set options.data
      else
        model.set @field.path, options.data
      next()

  ###
  ###

  @test   : (options) -> options.load or options.save
  @create : (options) -> new ExplicitSync options


module.exports = ExplicitSync