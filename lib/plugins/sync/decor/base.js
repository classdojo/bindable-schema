// Generated by CoffeeScript 1.7.0
(function() {
  var SyncBase;

  SyncBase = (function() {
    function SyncBase() {}


    /*
     */

    SyncBase.prototype.constuctor = function(options) {
      this.options = options;
      return this.field = options.field;
    };


    /*
     */

    SyncBase.prototype.load = function(model, next) {
      return next();
    };


    /*
     */

    SyncBase.prototype.save = function(model, next) {
      return next();
    };

    return SyncBase;

  })();

  module.exports = SyncBase;

}).call(this);
