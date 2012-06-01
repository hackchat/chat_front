class Message < ActiveRecord::Base
  attr_accessible :content, :room_id
  after_create :broadcast_self
  belongs_to :room

  def broadcast_self
    message = {
               :channel => "/messages/#{self.room_id}",
               :data => self,
               :ext => {:auth_token => FAYE_TOKEN}
               }
    uri = URI.parse("#{FAYE_DOMAIN}/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

end
