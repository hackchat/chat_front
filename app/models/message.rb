class Message < ActiveRecord::Base
  before_create :highlight
  attr_accessible :content, :room_id, :language, :user_token

  def self.broadcast_creation(params)
    REDIS.publish("create", self.build_redis_hash(params[:content], params[:room_id], params[:auth_token]))
  end

  def self.build_redis_hash(content, room_id, auth_token)
    {
      "type" => "message",
      "message" => {
                     'content' => content,
                     'room_id' => room_id,
                     'user_token' => auth_token
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