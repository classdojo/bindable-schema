// Generated by CoffeeScript 1.7.0
(function() {
  var normalize, type;

  type = require("type-component");

  module.exports = normalize = function(options) {
    var normalizedOptions, optionName, value;
    normalizedOptions = {
      fields: {}
    };
    if (type(options) === "array") {
      options = options[0];
      normalizedOptions.collection = true;
    }
    if (type(options) === "string") {
      normalizedOptions.type = options;
      options = {};
    }
    for (optionName in options) {
      value = options[optionName];
      if (optionName.substr(0, 1) === "$") {
        normalizedOptions[optionName.substr(1)] = value;
      } else {
        normalizedOptions.fields[optionName] = normalize(value);
      }
    }
    return normalizedOptions;
  };

}).call(this);
