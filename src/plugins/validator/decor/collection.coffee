_ = require "underscore"
async = require "async"
type = require "type-component"

class CollectionValidator extends require("./base")


  ###
  ###

  constructor: (options, @_validator) ->
    super options

  ###
  ###

  test: (context, values = [], next) ->  


    if type(values) isnt "array"
      return next new Error "#{values} must be an array"

    async.eachSeries values, ((value, next) =>
      @_validator.test context, value, next
    ), next

  ###
  ###

  @test: (options) -> 
    options.collection
  @create: (options) -> 

    ops = _.extend {}, options
    delete ops.collection

    new CollectionValidator options, options.field._validatorFactory.create ops


module.exports = CollectionValidator