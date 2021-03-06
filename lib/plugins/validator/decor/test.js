// Generated by CoffeeScript 1.7.0
(function() {
  var TestValidator,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  TestValidator = (function(_super) {
    __extends(TestValidator, _super);


    /*
     */

    function TestValidator(options) {
      TestValidator.__super__.constructor.call(this, options);
      this._test = this._getTester(options.test);
    }


    /*
     */

    TestValidator.prototype.test = function(context, value, next) {
      var onTest;
      if (value == null) {
        return next();
      }
      onTest = (function(_this) {
        return function(err) {
          if (err) {
            return _this._error("" + _this.field.path + " is invalid", next);
          } else {
            return next();
          }
        };
      })(this);
      return this._test.call(context, String(value), onTest);
    };


    /*
     */

    TestValidator.prototype._getTester = function(tester) {
      if (tester.test) {
        return (function(_this) {
          return function(value, next) {
            if (tester.test(value)) {
              return next(false);
            }
            return next(true);
          };
        })(this);
      }
      if (tester.length === 2) {
        return tester;
      } else {
        return function(value, next) {
          var e;
          try {
            return next(!tester.call(this, value));
          } catch (_error) {
            e = _error;
            return next(false);
          }
        };
      }
    };


    /*
     */

    TestValidator.test = function(options) {
      return !!options.test;
    };

    return TestValidator;

  })(require("./base"));

  module.exports = TestValidator;

}).call(this);
