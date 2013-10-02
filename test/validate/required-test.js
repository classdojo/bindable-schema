
var bindableSchema = require("../.."),
model = require("../helpers/model"),
expect = require("expect.js");

describe("validate/required#", function() {

  var s = bindableSchema({
    name: {
      $type: "string",
      $required: true
    },
    age: {
      $required: true
    }
  });


  it("fails if the value doesn't exist", function(next) {
    model({}, s).validate(function(err) {
      expect(!!err).to.be(true);
      next();
    })
  });

  it("doesn't break if the value is 0", function(next) {
    model({name:"STR",age:0}, s).validate(next);
  });
  it("doesn't break if the value is false", function(next) {
    model({name:"AGG",age:false}, s).validate(next);
  });
});