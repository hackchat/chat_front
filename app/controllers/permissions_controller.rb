class PermissionsController < ApplicationController

  def index
    # all rooms for which current user is an owner
  end

  def show
    # all users for specific room
  end

  def new
  end

  def create
    room = Room.find(params[:room_id])
    unless room.owned_by?(session[:user_token])
      head :status => :unauthorized && return
    end

    user_info = UserInfo.get_by_email(params[:email])
    room.create_permission_for(user_info.user_token)
    redirect_to new_room_permission_url(room)
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
