require 'spec_helper'

describe "Room", type: :api do
  let!(:room) { FactoryGirl.create(:room) }
  let!(:rooms) { FactoryGirl.create(:room) }
  describe "GET /room.json" do
    it "LISTS ALL THE ROOMS" do
      get rooms_path(:format => "JSON")
      response.status.should be(200)
      response.body.should have_content room.name
    end
    it "Shows one room" do
      get room_path(room.id,:format => "JSON")
      response.status.should be(200)
      response.body.should have_content room.name
    end
    it "creates a room" do
      post rooms_path(:format => "JSON"), room: { :name => "my room" }
      response.status.should be(201)
    end
    it "updates a room" do
      put room_path(room.id, :format => "json"), room: { name: "new room" }
      response.status.should be(200)
      response.body.should have_content "new room"
    end
  end
end
