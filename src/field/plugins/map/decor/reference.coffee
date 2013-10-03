dref = require "dref"

class RefMapper extends require("./base")
  
  ###
  ###

  map: (options, next) ->
    modelClass = @refs[@options.ref]

    unless modelClass
      return next new Error "reference '#{@options.ref}' does not exist"

    next null, options

  ###
  ###

  @test: (options) -> options.ref
  @create: (options) -> new RefMapper options

module.exports = RefMapper