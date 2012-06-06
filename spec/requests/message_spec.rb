require 'spec_helper'

describe "Message", type: :api do
  let!(:room) { FactoryGirl.create(:room) }
  it "creates a message" do
    Net::HTTP.any_instance.stub(:post_form).and_return(true)
    post messages_path(:format => "JSON"), message: { content: "hello", room_id: room.id }.as_json
    response.status.should == 201
  end
end