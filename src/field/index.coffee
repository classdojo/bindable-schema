normalize    = require "./normalize"
EventEmitter = require("events").EventEmitter
funwrap      = require "funwrap"
decorFactory = require "./decor"

###
 describes the skeleton of what the capabilities are of a particular
 model - doesn't actually do anything except store options
###

class Field extends EventEmitter

  ###
  ###

  decorFactory: decorFactory
  
  ###
  ###

  constructor: (@options, @plugins) ->

    # commands such as save, load, validate, etc.
    @mediator = funwrap().mediator

    options.field = @

    # name of this field
    @name = options.name

    # path to this field
    @path = @_id = (options.path or []).join(".")

    # parent field
    @parent = @options.parent

    # root field
    @root   = @parent?.root or @

    # add the children
    @_setFields options.fields

  ###
   gets the field based on the given path - passed to another method
   that's a bit more
  ###

  child: (path, closest = false) -> 
    @_getField path.split("."), 0, closest

  ###
  ###

  use: (decor) ->
    decor.create @options
    for child in @fields
      child.use decor

  ###
  ###

  setupModel: (model) ->  
    @emit "setupModel", model
    for child in @fields
      child.setupModel model

  ###
  ###

  _getField: (path, index, closest) ->

    if index is path.length
      return @

    name = path[index]
    field = @_fieldsByName[name]

    return undefined unless field

    subField = field._getField(path, index + 1, closest)

    if not subField and closest
      subField = field

    subField

  ###
  ###

  _setFields: (fields) ->

    @fields        = []
    @_fieldsByName = {}
    @_allFieldsByPath = {}

    for fieldName of fields
      @addField fieldName, fields[fieldName]

    @numFields = @fields.length
    @allFields = @_flatten []

  ###
  ###

  _flatten: (fields) ->
    fields.push @
    field._flatten(fields) for field in @fields
    fields

  ###
   adds a sub field to this field
  ###

  addField: (fieldName, options) ->

    options.parent = @
    options.path   = (@options.path or []).concat fieldName
    options.name   = fieldName

    @fields.push field = new Field options, @plugins
    @_fieldsByName[field.name] = field


module.exports = (options = {}, schema) -> new Field normalize(options), schema