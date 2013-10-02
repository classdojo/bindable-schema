toarray    = require "toarray"
Collection = require "./collection"
flatten    = require "flatten"


module.exports = 
  test: (options) -> options.validate
  create: (options) -> 
    new Collection options, flatten(toarray(options.validate).map((validate) ->
      field = validate.field = options.field
      field.decorFactory.create validate
    )).filter (decor) -> !!decor
