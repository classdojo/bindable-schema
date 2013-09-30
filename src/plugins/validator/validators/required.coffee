class RequiredValidator extends require("./base")

  ###
  ###

  test: (model, next) ->   

    unless model.get(@field.path)?
      next new Error "#{@field.path} must be present"

    next()
  
  ###
  ###

  @test: (options) -> options.required
  @create: (options) -> new RequiredValidator options
  
module.exports = RequiredValidator