validators = require "./validators"
bindable   = require "bindable"
toarray    = require "toarray"

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

  watch: (model, watcher, field) ->

    #root?
    unless field.parent
      watcher.set "$errors", new bindable.Collection()
      watcher.set "$pending", new bindable.Collection()
      return

    errors  = watcher.get("$errors")
    pending = watcher.get("$pending")

    validate = () ->
      return if field.fields.length
      watcher.set field.path + ".$validating", false
      watcher.set field.path + ".$validated", false
      watcher.set field.path + ".$pending", true
      watcher.set field.path + ".$valid", false

      unless ~(pendingIndex = pending.searchIndex { _id: field._id })
        pendingIndex = pending.length
        pending.push field

      # remove the error from the collection
      if ~(i = errors.searchIndex({ _id: field.path }))
        errors.splice i, 1

      if field.options.required and not model.get(field.path)?
        return

      watcher.set field.path + ".$validating", true

      field.validate model, (err) ->  
        watcher.set field.path + ".$validating", false
        watcher.set field.path + ".$validated", true
        watcher.set field.path + ".$pending", false
        watcher.set field.path + ".$valid", !err


        if err
          err._id = field.path
          errors.push err
        else
          pending.splice pendingIndex, 1

        watcher.set field.path + ".$error", err
        watcher.set "$valid", !pending.length

    for prop in toarray(field.options.bind or field.path)
      model.bind(prop).to(validate)

    validate()

  ###
  ###
  
  model: (model) ->
    model.validate = (next) =>
      model.schema.validate model, next

module.exports = (schema) -> new Validator schema