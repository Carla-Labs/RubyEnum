require "rubyenum/version"

module RubyEnum 

  class Base

    @@all = []

    def self.all
      @@all
    end

    def self.enum(symbol, hash)
      enumObj = EnumObj.new symbol.to_s
      const_set(symbol.to_s, enumObj)
      hash.each do |k, v|
        # define a constant mouse on the class that points to the object with these
        # fields
        enumObj.add_attribute(k, v)
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

end

# class AnimalExample < RubyEnum::Base 

#   enum :MOUSE, id: 0, mascot: "jerry"
#   enum :CAT, id: 1, mascot: "tom"
#   enum :DOG, id: 2, mascot: "luigi"
#   enum :FISH, id: 3, mascot: "nemo"

# end
 
