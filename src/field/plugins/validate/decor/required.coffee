class RequiredDecor extends require("./base")

  ###
  ###

  validate: (model, next) =>  
    unless @value(model)?
      next new Error "#{@field.path} must be present"
    next()

  ###
  ###

  @test   : (options) -> options.required
  @create : (options) -> new RequiredDecor options

module.exports = RequiredDecor