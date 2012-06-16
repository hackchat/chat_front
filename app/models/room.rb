class Room < ActiveRecord::Base
  attr_accessible :name, :user_token
  after_create :broadcast_creation

  def broadcast_creation
    Faraday.post "#{PERMISSIONS_URL}user_room_permission",
                  { user_token: self.user_token, room_id: self.id, owner: true}
  end

  def owned_by?(token)
    user_token == token
  end

  def create_permission_for(user_token)
    resp = Faraday.post "#{PERMISSIONS_URL}user_room_permission",
                   { user_token: user_token, room_id: id, owner: false}
    resp.status == 201
  end

  def self.find_rooms_for(user)
    room_permissions = user_room_permissions(user).map(&:room_id)
    Room.where{id.in(room_permissions)}
  end

  def self.user_room_permissions(user)
    resp = Faraday.get "#{PERMISSIONS_URL}users/#{user}.json"
    perms = JSON.parse(resp.body)
    perms.collect do |perm|
     Hashie::Mash.new(perm)
    end
  end

end
