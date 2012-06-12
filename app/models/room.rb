class Room < ActiveRecord::Base
  attr_accessible :name

  def self.find_rooms
    resp = Faraday.get 'http://store.hackchat.in/rooms.json'
    JSON.parse(resp.body).collect do |json|
      Hashie::Mash.new(json)
    end
  end

  def self.broadcast_creation(params)
    REDIS.publish("create", build_redis_hash(params[:name]))
  end

  def self.build_redis_hash(name)
    {
      "type" => "room",
      "room" => {
                  "name" => name
                }
    }.to_json
  end

end
