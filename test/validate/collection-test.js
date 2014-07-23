
var bindableSchema = require("../.."),
bindable = require("bindable"),
expect = require("expect.js");

describe("validate/collection#", function() {

  /*var s = bindableSchema({
    ids: ["number"]
  });


  s.use(bindableSchema.plugins.validator);


  it("throws an error if ids isn't an array", function(next) {
    s.validate({ids:0}, function(err) {
      expect(err.message).to.contain("must be an array");
      next();
    })
  });

  it("can validate a collection of numbers", function(next) {
    s.validate({ids:[0, 1, 2, 3]}, function(err) {
      expect(err).to.be(null);
      next();
    })
  });*/

  describe("optional field", function () {

    var s = bindableSchema({
      loc: [{
        $required: false,
        $type: "number"
      }]
    });

    s.use(bindableSchema.plugins.validator);

    it("doesn't fail if loc isn't present", function(next) {
      s.validateField("loc", new bindable.Object({}), function (err) { 
        expect(err).to.be(undefined);
        next();
      });
    });

    it("fails if loc is the incorrect type", function(next) {
      s.validateField("loc", new bindable.Object({loc:true}), function (err) { 
        expect(err.message).not.to.be(undefined);
        next();
      });
    });
  });

  describe("required field", function () {

    var s = bindableSchema({
      loc: [{
        $required: true,
        $type: "string"
      }]
    });

    s.use(bindableSchema.plugins.validator);

    it("fails if loc isn't present", function(next) {
      s.validateField("loc", new bindable.Object(), function (err) { 
        expect(err.message).not.to.be(undefined);
        next();
      });
    });
  });
});
