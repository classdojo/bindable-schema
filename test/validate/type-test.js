
var bindableSchema = require("../.."),
model = require("../helpers/model"),
expect = require("expect.js");

describe("validate/type#", function() {

  var s = bindableSchema({
    name: "string",
    age: "number"
  });


  describe("strings", function() {

    it("works with regular strings", function(next) {
      model({name:"craig"}, s).validate(next);
    });

    it("fails on numbers", function(next) {
      var m = model({}, s);
      m.set("name", 0);
      m.validate(function(err) {
        expect(!!err).to.be(true);
        next();
      });
    });


    //screws up cases such as first_name="blah", last_name=""
    it("succeeds if the string length is 0", function(next) {
      model({name:""}, s).validate(function(err) {
        expect(!!err).to.be(false);
        next();
      });
    })

    it("works with undefined", function(next) {
      var m = model({}, s);
      m.set("name", undefined);
      m.validate(next);
    })
  });


  describe("numbers", function() {
    it("works with regular numbers", function(next) {
      model({age:0}, s).validate(next);
    });
    it("fails on NaNs", function(next) {
      model({age:NaN}, s).validate(function(err) {
        expect(!!err).to.be(true);
        next();
      });
    });
  });

})