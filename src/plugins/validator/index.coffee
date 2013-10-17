decor      = require "./decor"
bindable   = require "bindable"
toarray    = require "toarray"

class Validator extends require("../base")

  ###
  ###

  schema: (schema) ->
    schema.validate = (context, next) => 

      schema.root.validate context, context?.toJSON?() ? context, next

  ###
  ###

  field: (field) ->
    field._validatorFactory = decor
    field._validator = decor.create(field.options)
    field.validate = (context, value, next) ->
      field._validator.test context, value, next

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

      watcher.set "$valid", !pending.length

      if field.options.required and not model.get(field.path)?
        return

      watcher.set field.path + ".$validating", true

      field.validate model, model.get(field.path), (err) ->  
        watcher.set field.path + ".$validating", false
        watcher.set field.path + ".$validated", true
        watcher.set field.path + ".$pending", false
        watcher.set field.path + ".$valid", !err


        if err
          err._id = field.path
          errors.push err
        else if ~(pendingIndex = pending.searchIndex { _id: field._id })
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