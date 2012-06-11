class Room < ActiveRecord::Base

  def self.find_rooms
    resp = Faraday.get 'http://127.0.0.1:7002/rooms.json'
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