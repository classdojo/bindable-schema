return;
var bindableSchema = require("../.."),
model = require("../helpers/model"),
expect = require("expect.js");

describe("validate/explicit#", function() {

  var s = bindableSchema({
    address: {
      city: "string"
    }
  });
  

  it("can validate a sub field", function(next) {
    model({ address: { city: 0 }}, s).validate(function(err) {
      expect(!!err).to.be(true);
      next();
    })
  });
});