class Roomie < ActiveRecord::Base
  attr_accessible :user_token, :room_id
  validates_uniqueness_of :user_token
end
