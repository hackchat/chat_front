class Room < ActiveRecord::Base
  REDIS = Redis.new(host: REDIS_URI.host, port: REDIS_URI.port, password: REDIS_URI.password)

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