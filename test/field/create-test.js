return;
var field = require("../../lib/field"),
expect = require("expect.js");

describe("field/create#", function() {

  /**
   */

  it("can create a field with a type", function() {

    var f = field({
      $type: "string"
    });

    expect(f.options.type).to.be("string");
  });


  /**
   */

  describe("sub fields", function() {

    var f = field({
      friends: [{
        address: {
          city: "string",
          state: "string"
        }
      }]
    });

    /**
     */

    it("has a reference to the parent field", function() {
      var cr = f, nr;
      ["friends", "friends.address", "friends.address.city"].forEach(function(fieldName) {
        expect((nr = f.child(fieldName)).parent).to.be(cr);
        cr = nr;
      });
    });

    /**
     */

    it("has the correct field path", function() {
      expect(f.child("friends").path).to.be("friends");
      expect(f.child("friends.address").path).to.be("friends.address");
      expect(f.child("friends.address.city").path).to.be("friends.address.city");
    });


    /**
     */

    it("can flatten all fields", function() {
      var allFields = f.allFields;
      ["","friends", "friends.address", "friends.address.city", "friends.address.state"].forEach(function(path, index) {
        expect(allFields[index].path).to.be(path);
      });
    });

    /**
     */

    it("has a reference to the root field", function() {
      expect(f.child("friends.address").root).to.be(f);
      expect(f.child("friends.address.city").root).to.be(f);
    })

    /**
     */

    it("can fetch the closest field to a property", function() {
      expect(f.child("friends.fds.fsd.fsd.fsd", true)).to.be(f.child("friends"));
    });

    /**
     */

    it("cannot fetch the closest field if no parts exist", function() {
      expect(f.child("fdf.fds.fsd.fsd.fsd", true)).to.be(undefined);
    })
  });
});