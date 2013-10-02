decor = require "./decor"

class Virtual extends require("../base")
  
  ###
  ###

  schema: (schema) ->
    schema.load = (model, next) -> schema.root.load model, next
    schema.save = (model, next) -> schema.root.save model, next

  ###
  ###

  field: (field) ->
    field._syncFactory = decor
    field._sync = decor.create(field.options)

    # load from the source
    field.load = (model, next) -> field._virtual.load model, next

    # save to the source
    field.save = (model, next) -> field._virtual.save model, next

  ###
  ###

  model: (model) ->
    model.load = (next) -> schema.load model, next
    model.save = (next) -> schema.save model, next



module.exports = (schema) -> new Virtual schema