require 'rubyenum'
require 'spec_helper'
require 'user_fixture'

describe RubyEnum::Associations do
    
  describe "#all" do
    it "returns a array of the enums" do
      enums = UserRole.all
      expect(enums.size).to be 3
      expect(enums[0]).to eq UserRole::ADMIN
    end
  end

  describe "#new" do 
    it "does not allow instantiation" do 
      expect { UserRole.new }.to raise_error(NoMethodError)
    end
  end

  describe "#value_of" do
    it "returns the proper enum for a string" do
      enum = UserRole.value_of "EDITOR"
      expect(enum).to eq UserRole::EDITOR
    end

    it "returns the proper enum for a symbol" do
      enum = UserRole.value_of :READER
      expect(enum).to eq UserRole::READER
    end
  end

  describe ".fields" do
    it "creates methods to access enum from each field" do 
      enum = UserRole.from_id 1
      expect(enum).to eq UserRole::EDITOR

      enum = UserRole.from_permission "all"
      expect(enum).to eq UserRole::ADMIN
    end
  end

  describe "#get_fields" do
    it "returns an array of the defined fields" do 
      fields = UserRole.get_fields
      expect(fields.size).to be 2

      expect(fields.include? :id).to be true
      expect(fields.include? :permission).to be true
    end
  end
end