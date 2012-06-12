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
    REDIS.publish("create", build_redis_hash)
  end

  def build_redis_hash
    {
      "type" => "room",
      "room" => {
                  "name" => self.name,
                  "user_token" => self.user_token,
                  "owner" => true,
                  "room_id" => self.id
                }
    }.to_json
  end

end
