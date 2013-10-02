var structr = require("structr");


var Model = structr(require("bindable").Object, {
  "override __construct": function(data, schema) {
    this._super(data);
    this.schema = schema;
    schema.setupModel(this);
  },
  "validate": function(next) {
    this.schema.root.mediator.execute("validate", this, next);
  },
  "load": function(next) {
    this.schema.root.mediator.execute("load", this, next);
  },
  "save": function(next) {
    this.schema.root.mediator.execute("save", this, next);
  }
});


module.exports = function(data, schema) {
  return new Model(data, schema);
}