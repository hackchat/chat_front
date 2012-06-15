class Roomie < ActiveRecord::Base
  attr_accessible :user_token, :room_id
  validates_uniqueness_of :user_token
  after_create :add_user_info

  def add_user_info
    user = find_user(self.user_token)
    self.name = "#{user.first_name} #{user.last_name[0]}"
    self.avatar = user.avatar
    self.save
  end

  def find_user(user_token)
    resp = Faraday.get "#{LOGIN_URL}users/#{user_token}.json"
    Hashie::Mash.new(JSON.parse(resp.body))
  end
end
