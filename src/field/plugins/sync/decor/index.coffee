module.exports = require("../factory") [

  # $load, or $save
  require("./explicit"),

  # bubbles to parents if load isn't present
  require("./bubble"),

  # root field - setup
  require("./root")
]