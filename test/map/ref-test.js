
var bindableSchema = require("../.."),
bindable = require("bindable"),
structr = require("structr"),
model = require("../helpers/model"),
expect = require("expect.js");

describe("map/ref#", function() {

  var refs = {};

  var personSchema = bindableSchema({
    $refs: refs,
    city: {
      $ref: "city",
      $load: function(model, next) {
        next(null, {
          name: "sf",
          state: "ca"
        });
      }
    }
  });

  var citySchema = bindableSchema({
    name: "string",
    state: "string"
  });

  refs.city = structr(bindable.Object, {
    "override __construct": function(data) {
      this._super(data);
      citySchema.setupModel(this);
    }
  });

  refs.person = structr(bindable.Object, {
    "override __construct": function(data) {
      this._super(data);
      personSchema.setupModel(this);
    }
  });



  it("can properly cast using a reference", function(next) {
    var person = new refs.person();
    person.bind("city").to(function(value) {
      console.log(value);
      next();
    });
  });

});