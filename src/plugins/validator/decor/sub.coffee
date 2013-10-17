async = require "async"
dref  = require "dref"

class SubValidator extends require("./base")

  test: (context, value, next) ->
    async.eachSeries @field.fields, ((field, next) ->
      field.validate context, dref.get(value ? {}, field.name), next
    ), next

  @test: (options) -> Object.keys(options.field.fields).length
  @create: (options) -> new SubValidator options


module.exports = SubValidator