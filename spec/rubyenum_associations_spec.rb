require 'rubyenum'
require 'spec_helper'
require 'user_role_fixture'

describe RubyEnum::Associations do
  
  before(:each) do 
    @user = User.new
    @user.role = UserRole::ADMIN

  end

  describe "#role" do
    it "stores the value of the assigned field" do 
      expect(@user.instance_variable_get(:"@role")).to be 0
    end
    
    it "returns the enum of the user" do
      expect(@user.role).to eq(UserRole::ADMIN)
    end

  end

end
