factories = require "factories"

module.exports = factories.group [
  require("./test"),
  require("./explicit"),
  require("./sub"),
  require("./collection"),
  require("./type"),
  require("./required")
], [], require("./multi")