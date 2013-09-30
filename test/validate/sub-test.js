var bindableSchema = require("../.."),
expect = require("expect.js");

describe("validate/explicit#", function() {

  var s = bindableSchema({
    address: {
      city: "string"
    }
  });
  
  s.use(bindableSchema.plugins.validator);

  it("can validate a sub field", function(next) {
    s.model({ address: { city: 0 }}).validate(function(err) {
      expect(!!err).to.be(true);
      next();
    })
  });
});