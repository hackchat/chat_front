class Message < ActiveRecord::Base
  attr_accessible :content, :room_id
  after_create :broadcast_self
  belongs_to :room
  validates_presence_of :content, :room_id

  def broadcast_self
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