


class TestValidator extends require("./base")

  ###
  ###

  constructor: (options) ->
    super options
    @_test = @_getTester options.test
  
  ###
  ###

  test: (context, value, next) ->

    return next() unless value?

    onTest = (err) =>
      if err
        @_error "#{@field.path} is invalid", next
      else
        next()

    @_test.call context, String(value), onTest

  ###
  ###

  _getTester: (tester) ->

    # regex?
    if tester.test
      return (value, next) =>
        return next(false) if tester.test value
        return next(true)


    if tester.length is 2
      return tester
    else
      return (value, next) ->
        try 
          next(!tester.call(@, value))
        catch e
          next(false)

  ###
  ###

  @test: (options) -> 
    !!options.test

module.exports = TestValidator