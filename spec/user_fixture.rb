require 'user_role_fixture'

class User
  extend RubyEnum::Associations

  enumify :role, :with => :user_role, :use => :id
end