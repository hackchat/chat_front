require 'spec_helper'

describe "Message", type: :api do
  let!(:room) { FactoryGirl.create(:room) }
  it "creates a message" do
    Net::HTTP.any_instance.stub(:post_form).and_return(true)
    post messages_path(:format => "JSON"), message: { content: "hello", room_id: room.id }.as_json
    response.status.should == 201
  end
  it "gets messages for a room" do
   get messages_path(:format => "JSON"), room_id: room.id
    response.status.should == 200
  end
  it "fails to create a room" do
    Net::HTTP.any_instance.stub(:post_form).and_return(true)
    post messages_path(:format => "JSON")
    response.status.should == 422
  end
end