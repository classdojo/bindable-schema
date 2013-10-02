// Generated by CoffeeScript 1.6.2
(function() {
  var EventEmitter, Field, decorFactory, funwrap, normalize,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  normalize = require("./normalize");

  EventEmitter = require("events").EventEmitter;

  funwrap = require("funwrap");

  decorFactory = require("./decor");

  /*
   describes the skeleton of what the capabilities are of a particular
   model - doesn't actually do anything except store options
  */


  Field = (function(_super) {
    __extends(Field, _super);

    /*
    */


    Field.prototype.decorFactory = decorFactory;

    /*
    */


    function Field(options, plugins) {
      var _ref;

      this.options = options;
      this.plugins = plugins;
      this.mediator = funwrap().mediator;
      options.field = this;
      this.name = options.name;
      this.path = this._id = (options.path || []).join(".");
      this.parent = this.options.parent;
      this.root = ((_ref = this.parent) != null ? _ref.root : void 0) || this;
      this._setFields(options.fields);
    }

    /*
     gets the field based on the given path - passed to another method
     that's a bit more
    */


    Field.prototype.getField = function(path, closest) {
      if (closest == null) {
        closest = false;
      }
      return this._getField(path.split("."), 0, closest);
    };

    /*
    */


    Field.prototype.use = function(decor) {
      var child, _i, _len, _ref, _results;

      decor.create(this.options);
      _ref = this.fields;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        _results.push(child.use(decor));
      }
      return _results;
    };

    /*
    */


    Field.prototype._getField = function(path, index, closest) {
      var field, name, subField;

      if (index === path.length) {
        return this;
      }
      name = path[index];
      field = this._fieldsByName[name];
      if (!field) {
        return void 0;
      }
      subField = field._getField(path, index + 1, closest);
      if (!subField && closest) {
        subField = field;
      }
      return subField;
    };

    /*
    */


    Field.prototype._setFields = function(fields) {
      var fieldName;

      this.fields = [];
      this._fieldsByName = {};
      this._allFieldsByPath = {};
      for (fieldName in fields) {
        this.addField(fieldName, fields[fieldName]);
      }
      this.numFields = this.fields.length;
      return this.allFields = this._flatten([]);
    };

    /*
    */


    Field.prototype._flatten = function(fields) {
      var field, _i, _len, _ref;

      fields.push(this);
      _ref = this.fields;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        field = _ref[_i];
        field._flatten(fields);
      }
      return fields;
    };

    /*
     adds a sub field to this field
    */


    Field.prototype.addField = function(fieldName, options) {
      var field;

      options.parent = this;
      options.path = (this.options.path || []).concat(fieldName);
      options.name = fieldName;
      this.fields.push(field = new Field(options, this.plugins));
      return this._fieldsByName[field.name] = field;
    };

    return Field;

  })(EventEmitter);

  module.exports = function(options, schema) {
    if (options == null) {
      options = {};
    }
    return new Field(normalize(options), schema);
  };

}).call(this);