module.exports = (schema) ->

  factories = []

  use: (factory) -> factories.push factory
  create: (options, test) -> 
    for factory in factories
      factory.create options, test


module.exports.sync     = require("./sync")
module.exports.validate = require("./validate")