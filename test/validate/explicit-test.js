
var bindableSchema = require("../.."),
model = require("../helpers/model"),
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

  


  it("can check if a username exists and pass", function(next) {
    model({ username: "craig" }, s).validate(next);
  });

  it("can check if a username exists and fail", function(next) {
    model({ username: "craigers" }, s).validate(function(err) {
      expect(err.message).to.be("username already exists");
      next();
    }); 
  });

  it("can validate the password and fail", function(next) {
    var m = model({}, s);
    m.set("password", "");
    m.validate(function(err) {
      expect(err.message).to.be("must contain at least one number");
      m.set("password", "0");
      m.validate(function(err) {
        expect(err.message).to.be("must be at least 7 characters");
        m.set("password", "0123456");
        m.validate(function(err) {
          expect(err.message).to.be("must contain at least 1 letter");
          m.set("password", "01234567Z");
          m.validate(next);
        });
      });
    })
  });
});