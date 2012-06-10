class Message < ActiveRecord::Base
  attr_accessible :content, :room_id

  def self.broadcast_creation(params)
    REDIS.publish("create", self.build_redis_hash(params[:content], params[:room_id]))
  end

  def self.build_redis_hash(content, room_id)
    {
      "type" => "message",
      "message" => {
                     'content' => content,
                     'room_id' => room_id
                   }
    }.to_json
  end

end