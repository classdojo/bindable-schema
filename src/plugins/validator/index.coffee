validators = require "./validators"

class Validator extends require("../base")

  ###
  ###

  schema: (schema) ->
    schema.validate = (model, next) => 
      schema.root.validate arguments...

  ###
  ###

  field: (field) ->
    field._validatorFactory = validators
    field._validator = validators.create(field.options)
    field.validate = (model, next) ->
      field._validator.test model, next

  ###
  ###
  
  model: (model) ->
    model.validate = (next) =>
      model.schema.validate model, next

module.exports = (schema) -> new Validator schema