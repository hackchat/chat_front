require 'spec_helper'

describe "Message", type: :api do
  let!(:room) { FactoryGirl.create(:room) }
  it "creates a message" do
    Message.any_instance.stub(:broadcast).and_return(true)
    post messages_path(:format => "json"), body: { content: "hello", room_id: room.id }.to_json
    response.status.should == 201
  end
end