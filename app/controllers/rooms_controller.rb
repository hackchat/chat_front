class RoomsController < ApplicationController

  def index
    @rooms = Room.find_rooms
  end

  def new

  end

  def create
    Room.broadcast_creation(params)
    redirect_to rooms_path
  end

  # def update
  #   render :json => @room, :status => 200 if @room.save
  # end

  # def show
  #   @room = Room.includes(:messages).find(params[:id])
  # end

end