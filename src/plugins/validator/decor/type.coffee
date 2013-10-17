type = require("type-component")

class TypeValidator extends require("./base")
  
  ###
  ###

  test: (context, value, next) ->
    return next() unless value?
    t = type value



    valid = t is @options.type

    switch t
      when "number" then valid = valid and !isNaN(value)
      when "string" then valid = true

    unless valid
      next new Error "#{@field.path} must be a #{@options.type}"
    else
      next()

  
  @test: (options) -> options.type and not options.collection
  @create: (options) -> new TypeValidator options

module.exports = TypeValidator