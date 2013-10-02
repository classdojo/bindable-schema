decor = {

  ###
   validators
  ###

  # email: { $validate: [{ $test: //, message: "incorrect" }] }
  explicitValidator : require("./validate/explicit"),

  # email: "email"
  typeValidator     : require("./validate/type"),

  # username: { $required: true }
  requiredValidator : require("./validate/required"),

  # city: { state: "string" }
  subValidator      : require("./validate/sub"),

  # field: { $test: /regex/ }
  testValidator     : require("./validate/test"),

  ### 
    Sync
  ###

  # { $request: { get: function(options, next) {} }}
  explicitSync : require("./sync/explicit"),

  # sets up the model
  rootSync     : require("./sync/root"),

  # bubbles 
  bubbleSync   : require("./sync/bubble"),

  # sub
  subSync      : require("./sync/sub")



  ###
   Map
  ###

  # friend: { $ref: friend }
  refMap        : undefined

  # friends: [{ $ref: friends }]
  collectionMap : undefined

  vanillaMap    : require("./map/vanilla")

}



module.exports = 
  create: (options, test = (() -> true)) ->


    for name of decor
      clazz = decor[name]
      continue unless clazz
      if test(clazz) and clazz.test(options)
        clazz.create options