class RoomsController < ApplicationController
  before_filter :require_login, only: [:index, :create]

  def index
    @rooms = Room.find_rooms_for(session[:user_token])
  end

  def new
    # Add Individuals to a room
  end

  def edit
    # Subtract Individuals from a room
  end

  def create
    params[:room][:user_token] = current_user.user_token
    room = Room.create(params[:room])
    redirect_to CHAT
  end

end