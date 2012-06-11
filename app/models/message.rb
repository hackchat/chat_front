class Message < ActiveRecord::Base
  REDIS = Redis.new(host: REDIS_URI.host, port: REDIS_URI.port, password: REDIS_URI.password)
  before_create :highlight
  attr_accessible :content, :room_id, :language

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

  def highlight
    unless self.language == "Plain Text"
      self.content = Pygments.highlight(self.content,
        lexer: self.language.downcase)
    end
  end

end