class RequiredValidator extends require("./base")

  ###
  ###

  test: (context, value, next) ->   

    unless value?
      next new Error "#{@field.path} must be present"

    next()
  
  ###
  ###

  @test: (options) -> options.required
  @create: (options) -> new RequiredValidator options
  
module.exports = RequiredValidator