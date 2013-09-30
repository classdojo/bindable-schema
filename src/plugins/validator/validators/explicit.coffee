toarray = require "toarray"
factory = require "./factory"
Collection = require "./collection"


module.exports = 
  test: (options) -> 
    options.validate
  create: (options) -> 
    new Collection options, toarray(options.validate).map (validate) ->
      field = validate.field = options.field
      field._validatorFactory.create validate

