require "rubyenum/version"

module RubyEnum 

  class Base

    @@all = []

    @@fields = []

    def self.all
      @@all
    end

    def self.get_fields
      @@fields
    end

    def self.fields(*args) 
      args.each do |argument|
        @@fields << argument
      end
    end

    def self.enum(symbol, *vals)
      enumObj = EnumObj.new symbol.to_s
      const_set(symbol.to_s, enumObj)
      vals.each_with_index do |val, i|
        if get_fields[i].nil?
          raise "too many arguments passed to enum. Each enum may only have as many values as fields defined."
        end
        enumObj.add_attribute(get_fields[i], val)
      end
      @@all << enumObj
    end

  end

  class EnumObj

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def add_attribute(attr_name, value)
      var = instance_variable_set(:"@#{attr_name}", value)
      define_singleton_method("#{attr_name}") do 
        var
      end
    end

  end

  ## depends on rails
  module Associations 

    def enumify(method_name, hash)
      klass = Object.const_get(hash[:with].to_s.camelize)
      
      define_method(method_name) do 
        enum_to_return = nil
        var = read_attribute(method_name)
        klass.all.each do |item|
          if item.send(hash[:use]) == var
            enum_to_return = item
            break;
          end
        end
        enum_to_return
      end

      define_method(:"#{method_name.to_s}=") do |enum|
        write_attribute(method_name, enum.send(hash[:use]))
        nil
      end

    end

  end

end


# require 'RubyEnum'
# class AnimalExample < RubyEnum::Base 

#   fields :id, :mascot

#   enum :MOUSE, 0, "jerry"
#   enum :CAT, 1, "tom"
#   enum :DOG, 2, "luigi"
#   enum :FISH, 3, "nemo"

# end

# class Zoo

#   extend RubyEnum::Associations

#   attr_accessor :animal

#   enumify :animal, :with => :animal_example, :use => :id

#   # overides getter and setter methods 
#     # animal=(EnumObj), sets the property to the :via value
#     # animal => EnumObj, gets the property from the :via value


# end


 
