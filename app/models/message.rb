class Message < ActiveRecord::Base
  attr_accessible :content
  after_create :broadcast_self

  def broadcast_self
    message = {
               :channel => "/messages/new",
               :data => self,
               :ext => {:auth_token => FAYE_TOKEN}
               }
    uri = URI.parse("#{FAYE_DOMAIN}/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

end
