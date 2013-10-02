
var bindableSchema = require("../.."),
model = require("../helpers/model"),
expect = require("expect.js");

describe("sync/sub load#", function() {


  var s = bindableSchema({
    name: {
      first: "string",
      last: "string",
    },
    city: {
      name: "string",
      state: "string",
      $load: function(model, next) {
        next(null, {
          name: "sf",
          state: "ca"
        });
      }
    },
    $load: function(model, next) {
      next(null, {
        name: {
          first: "craig",
          last: "condon"
        }
      });
    }
  });


  it("loads a sub field if it's missing", function(next) {
    var m = model({}, s);
    m.bind("city.name").to(function(name) {
      expect(name).to.be("sf");
      expect(m.get("firstName")).to.be(undefined);
      next();
    });
  });


  it("bubbles up load if a sub field doesn't have one", function(next) {
    var m = model({}, s);
    m.bind("name.first").to(function(name) {
      expect(name).to.be("craig");
      expect(m.get("city.name")).to.be(undefined);
      next();
    });
  })
});