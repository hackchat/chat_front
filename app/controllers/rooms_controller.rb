class RoomsController < ApplicationController

  def index
    @rooms = current_rooms.collect do |room_perm|
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
    params[:room][:user_token] = current_user.auth_token
    room = Room.create(params[:room])
    if Rails.env.production?
      redirect_to "http://hackchat.in"
    else
      redirect_to "http://localhost:2000"
    end
  end

end