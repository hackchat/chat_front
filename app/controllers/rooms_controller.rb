class RoomsController < ApplicationController
  before_filter :require_login, only: [:index, :create]
  def index
    @rooms = current_room_permissions.collect do |room_perm|
               Room.find(room_perm.room_id)
             end
  end

  def new
    # Add Individuals to a room
  end

  def edit
    # Subtract individuals to a room
  end

  def create
    params[:room][:user_token] = current_user.user_token
    room = Room.create(params[:room])
    redirect_to CHAT
  end

end