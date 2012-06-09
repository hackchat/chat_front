class Room

  def self.find_rooms
    resp = Faraday.get 'http://localhost:3000/rooms.json'
    JSON.parse(resp.body).collect do |json|
      Hashie::Mash.new(json)
    end
  end

  def self.broadcast_creation(params)
    @redis ||= Redis.new()
    @redis.publish("create", {'type' => 'room', 'room' =>
                      { 'name' => params[:name]}}.to_json)
  end

end