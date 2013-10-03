return;
var bindableSchema = require("../.."),
model = require("../helpers/model"),
expect = require("expect.js");

describe("sync/load#", function() {


  var s = bindableSchema({
    firstName: "string",
    lastName: "string",
    $load: function(model, next) {
      model.set("__loaded", true);
      next(null, {
        firstName : "craig",
        lastName  : "condon"
      });
    }
  });




  it("can explicitly call load on a model", function(next) {
    var m = model({}, s);
    m.load(function() {
      expect(m.get("firstName")).to.be("craig");
      next();
    })
  });


  it("doesn't call load if property exists", function(next) {
    var m = model({ firstName: "john" }, s);
    m.bind("firstName").delay(1).to(function(firstName) {
      expect(m.get("__loaded")).to.be(undefined);
      next();
    }).now();
  })


  it("loads the model if a property is missing", function(next) {
    var m = model({}, s);
    m.bind("firstName").to(function(firstName) {
      expect(firstName).to.be("craig");
      next();
    });
  });
});