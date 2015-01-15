require "rubyenum/version"
require "pry"

module RubyEnum 

  class Base

    @@all = []
    @@fields = []

    attr_reader :name

    private_class_method :new

    def self.all
      @@all
    end

    def self.get_fields
      @@fields
    end

    def self.fields(*args) 
      args.each do |argument|
        @@fields << argument
        define_singleton_method("from_#{argument.to_s}") do |value|
          item_to_return = nil
          @@all.each do |item|
            if item.send(argument) == value 
              item_to_return = item
              break
            end
          end
          item_to_return
        end
      end
    end

    def self.value_of(symbol)
      const_get(symbol.to_s)
    end

    def self.enum(symbol, *vals)
      enumObj = new symbol.to_s
      const_set(symbol.to_s, enumObj)
      vals.each_with_index do |val, i|
        if get_fields[i].nil?
          raise "too many arguments passed to enum. Each enum may only have as many values as fields defined."
        end
        enumObj.add_attribute(get_fields[i], val)
      end
      @@all << enumObj
    end

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

  module Associations

    # let ActiveRecord define these if using rails 
    def create_helper_methods
      unless respond_to? :read_attribute
        define_method(:read_attribute) do |name|
          instance_variable_get(:"@#{name}")
        end
      end
      unless respond_to? :write_attribute
        define_method(:write_attribute) do |name, value|
          instance_variable_set(:"@#{name}", value)
        end
      end
    end

    def to_camelcase(string)
      return_string = ""
      parts = string.split("_")
      parts.each do |part|
        part[0] = part[0].upcase
        return_string += part
      end
      return_string
    end

    def enumify(method_name, hash)
      create_helper_methods
      klass = Object.const_get(to_camelcase(hash[:with].to_s))
      define_method(method_name) do 
        enum_to_return = nil
        var = read_attribute(method_name)
        klass.all.each do |item|
          if item.send(hash[:use]) == var
            enum_to_return = item
            break
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

#   enumify :animal, :with => :animal_example, :use => :id

#   # writes getter and setter methods 
#     # animal=(AnimalExample), sets the property to the :use value @animal = id
#     # animal => AnimalExample, gets the property from the :use value and converts to Enum


# end


 
