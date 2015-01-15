# Rubyenum

RubyEnum is a simple implemenation of the enum pattern that you see in java, c++, etc. Why use a pattern from a scary laguage like java when we have ruby? Because Enums are awesome. Anytime you have a variety of types for an object that are merely classification, and not deserving of objects themselves, you can use an enum. 

For instance, if you have a User class that has a role attribute (admin, editor, viewer) in the past you either did:
- a) store an integer in the database and have a long list of constants to use throughout your code (the better option)
- b) Stored strings in the database like `"admin"`, or `"editor"` (the terrible option)

Enter enums

an Enum is an object that has it's own final state (such as an integer for the data), as well as a variety of methods allowing you to act upon that state. For example, this is how you might define a UserRoles enum with RubyEnum

```
class UserRoles < RubyEnum::Base
    
    fields :id, :permissions

    enum :ADMIN, 0, "all"
    enum :EDITOR, 1, "read/write"
    enum :VIEWER, 2, "read"

end

``` 

After defining the enum, you can access an instance of it via the constant and access its properties like so:

```
role = UserRoles::ADMIN
role.name #=> "ADMIN" (built in method)
role.id #=> 0
role.permissions #=> "all"
```

You can also go backwards from a field:
```
i = 1
name = "VIEWER"
UserRoles.from_id(i) #=> UserRoles::EDITOR
UserRoles.value_of(name) #=> UserRoles::VIEWER
```

Finally, they are grouped together, so you can access them all as an array:
```
UserRoles.all #=> [UserRoles::ADMIN, UserRoles::EDITOR, UserRoles::VIEWER]
```

Together, this all makes for a far more flexible, yet still very stable, method of defining constants throughout the app.

## With rails



## Installation

Add this line to your application's Gemfile:

    gem 'rubyenum'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubyenum

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( http://github.com/<my-github-username>/rubyenum/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
