class Message < ActiveRecord::Base
  attr_accessible :content, :room_id
  after_create :broadcast_temp

  def self.broadcast_creation(params)
    @redis ||= Redis.new()
    @redis.publish("create", {'type' => 'message', 'message' =>
                      { 'content' => params[:content],
                        'room_id' => params[:room_id]}
                      }.to_json)
    broadcast("/messages/#{params[:room_id]}", params[:content])
  end

  def broadcast_temp
    broadcast("/messages/#{self.room_id}", self)
  end

  def broadcast(channel, data)
    message = {
               :channel => channel,
               :data => data,
               :ext => {:auth_token => FAYE_TOKEN}
               }
    uri = URI.parse("#{FAYE_DOMAIN}")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
end