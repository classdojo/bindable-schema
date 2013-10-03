async = require "async"

class SubValidator extends require("./base")
  
  ###
  ###

  validate: (model, next) ->
    async.eachSeries @field.fields, ((field, next) ->
      field.validate model, next
    ), next

  ###
  ###

  @test   : (options) -> options.field.fields
  @create : (options) -> new SubValidator options

module.exports = SubValidator