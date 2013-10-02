factories = require "factories"

module.exports = factories.group [
  require("./test"),
  require("./explicit"),
  require("./sub"),
  require("./type"),
  require("./required")
], [], require("./collection")