decor = require "./decor"

class Virtual extends require("../base")
  
  ###
  ###

  schema: (schema) ->
    # do nothing

  ###
  ###

  field: (field) ->
    field._syncFactory = decor
    field._sync = decor.create(field.options)

    field.load   = (model, next) -> field._virtual.load model, next
    field.save   = (model, next) -> field._virtual.save model, next
    field.remove = (model, next) -> field._virtual.remove model, next

  ###
  ###

  model: (model) ->
    model.load   = (next) -> schema.root.load model, next
    model.save   = (next) -> schema.root.save model, next
    model.remove = (next) -> schema.root.save model, next



module.exports = (schema) -> new Virtual schema