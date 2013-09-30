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


  it("can check if a username exists and pass", function(next) {
    s.model({ username: "craig" }).validate(next);
  });

  it("can check if a username exists and fail", function(next) {
    s.model({ username: "craigers" }).validate(function(err) {
      expect(err.message).to.be("username already exists");
      next();
    }); 
  });

  it("can validate the password and fail", function(next) {
    var model = s.model();
    model.set("password", "");
    model.validate(function(err) {
      expect(err.message).to.be("must contain at least one number");
      model.set("password", "0");
      model.validate(function(err) {
        expect(err.message).to.be("must be at least 7 characters");
        model.set("password", "0123456");
        model.validate(function(err) {
          expect(err.message).to.be("must contain at least 1 letter");
          model.set("password", "01234567Z");
          model.validate(next);
        });
      });
    })
  });
});