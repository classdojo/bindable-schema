toarray = require "toarray"
Multi = require "./multi"


module.exports = 
  test: (options) -> 
    options.validate
  create: (options) -> 
    new Multi options, toarray(options.validate).map (validate) ->
      field = validate.field = options.field
      field._validatorFactory.create validate

