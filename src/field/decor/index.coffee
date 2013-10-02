decor = {

  # validators
  explicitValidator : require("./validate/explicit"),
  typeValidator     : require("./validate/type"),
  requiredValidator : require("./validate/required"),
  subValidator      : require("./validate/sub"),
  testValidator     : require("./validate/test")


}



module.exports = 
  create: (options) ->
    for name of decor
      clazz = decor[name]
      if clazz.test(options)
        clazz.create options