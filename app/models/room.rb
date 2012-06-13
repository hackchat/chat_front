class Room < ActiveRecord::Base
  attr_accessible :name, :user_token
  after_create :broadcast_creation

  def self.find_rooms
    resp = Faraday.get 'http://store.hackchat.in/rooms.json'
    JSON.parse(resp.body).collect do |json|
      Hashie::Mash.new(json)
    end
  end

  def broadcast_creation
    Faraday.post "#{PERMISSIONS_URL}user_room_permission",
                  { user_token: self.user_token, room_id: self.id, owner: true}
  end


end
