class UserRole < RubyEnum::Base
  fields :id, :permission

  enum :ADMIN, 0, "all"
  enum :EDITOR, 1, "read/write"
  enum :READER, 2, "read"
end