factories = reuquire "factories"


module.exports = factories.group [

  # username: { $validate: array }
  require("./explicit"),

  # username: { $required: true }
  require("./required"),

  # city: { state: "string" }
  require("./sub"),

  # username: { $test: /regex/ }
  require("./test"),

  # username: "string"
  require("./type")
], [], require("./collection")