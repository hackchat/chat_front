class Roomie < ActiveRecord::Base
  attr_accessible :user_token, :room_id, :avatar, :name, :status
  validates_uniqueness_of :user_token
  before_create :broadcast_creation
  before_destroy :broadcast_deletion

  def broadcast_creation
    self.status = "CREATED"
    faye_broadcast
  end

  def broadcast_deletion
    self.status = "DELETED"
    faye_broadcast
  end

  def faye_broadcast
    Net::HTTP.post_form(faye_uri, :message => faye_message) if faye_uri
  end

  def faye_uri
    URI.parse(FAYE_DOMAIN)
  end

  def faye_message
  {
   :channel => "/roomies/#{self.room_id}",
   :data => self,
   :ext => {:auth_token => "suppppyallll"}
  }.to_json
  end

end
