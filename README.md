```javascript

var person   = new BindableObject(),
personSchema = new BindableSchema({
  username: {
    $validate: [    
      { min: 6, error: { message: "Username must be at least 6 characters" } },
      checkUsername
    ]
  }
});

personSchema.use(bindableSchemaValidator);


//create a watcher of a particular bindable object
var personWatcher = personSchema.attach(person);

//when the person changes, the fields will 
person.set("username", "abba");

personWatcher.get("username.$valid"); // Username must be at least 6 characters
personWatcher.get("valid.$error"); // false
personWatcher.get("$valid"); // false

//set username that exists
person.set("username", "craigonator");

//after N seconds
personWatcher.get("fields.username.error"); // username exists
```
