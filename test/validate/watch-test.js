var bindableSchema = require("../.."),
expect = require("expect.js");

describe("validate/explicit#", function() {

  var s = bindableSchema({
    username: {
      $validate: [
        { 
          test: function(username, next) {
              setTimeout(function() {
                if(username == "craigers") {
                  return next(new Error("username exists"));
                } else {
                  next();
                }
              }, 2);  
          },
          message: "username already exists"
        }
      ]
    },
    password: {
      $validate: [
        { test: /[0-9]/  , message: "must contain at least one number" },
        { test: /.{7,}/  , message: "must be at least 7 characters" },
        { test: /[a-z]/i , message: "must contain at least 1 letter" }
      ]
    }
  });
  
  s.use(bindableSchema.plugins.validator);

  var model, watcher = s.watch(model = s.model());
  

  it("properly validates when the model changes", function() {
    model.set("password", "0");
    expect(watcher.get("password.$error").message).to.be("must be at least 7 characters");
    model.set("password", "0123456");
    expect(watcher.get("password.$error").message).to.be("must contain at least 1 letter");
  });


  it("stores all errors in a collection", function() {
    expect(watcher.get("$errors.length")).to.be(1);
    model.set("password", "01234567z");
    expect(watcher.get("$errors.length")).to.be(0);
  });


  it("can asynchronously validate a field", function(next) {
    model.set("username", "abba");
    expect(watcher.get("username.$validating")).to.be(true);
    var binding = watcher.bind("username.$validating").delay(1).to(function(value) {
      binding.dispose();
      expect(watcher.get("$errors.length")).to.be(0);
      model.set("username", "craigers");
      watcher.bind("username.$validated").once().delay(1).to(function(value) {
        expect(watcher.get("$errors.length")).to.be(1);
        expect(watcher.get("username.$error").message).to.be("username already exists");
        next();
      });
    });
  });
});