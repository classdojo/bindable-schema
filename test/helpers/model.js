var structr = require("structr");


var Model = structr(require("bindable").Object, {
  "override __construct": function(data, schema) {
    this._super(data);
    this.schema = schema;
  },
  "validate": function(next) {
    this.schema.root.mediator.execute("validate", this, next);
  }
});


module.exports = function(data, schema) {
  return new Model(data, schema);
}