Think if bindable schemas as self-contained applications that have a set of instructions that control a particular model. 

```coffeescript
bindable       = require "bindable"
BindableSchema = require "bindable-schema"


class Parent extends bindable.Object

  ###
  ###

  login: () ->




schema = new BindableSchema {
  $modelClass: Parent
  firstName: "string",
  lastName: "string"
}


model = schema.model()

```