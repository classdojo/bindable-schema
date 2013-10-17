return;
var bindableSchema = require("../.."),
expect = require("expect.js");

describe("validate/collection#", function() {

  var s = bindableSchema({
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
  })
});
