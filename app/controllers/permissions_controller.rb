class PermissionsController < ApplicationController
  require 'uri'

  def index
    # all rooms for which current user is an owner
  end

  def show
    # all users for specific room
  end

  def new
  end

  def create
    # look up user by email
    email = URI.parse(params[:email])
    resp = Faraday.get "#{LOGIN_URL}users/#{email}.json"
    raise resp.inspect
    # Faraday.post "#{PERMISSIONS_URL}user_room_permission",
    #               { user_token: self.user_token, room_id: self.id, owner: false}
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
