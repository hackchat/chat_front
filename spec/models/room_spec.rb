require 'spec_helper'

describe Room do
  describe "#owned_by?" do
    it "returns true for its user_token" do
      room = Room.new(:user_token => "meow")
      room.owned_by?("meow").should be_true
    end 

    it "returns false for another value" do
      room = Room.new(:user_token => "meow")
      room.owned_by?('').should be_false
    end
  end
end
