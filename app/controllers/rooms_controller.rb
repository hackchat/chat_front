class RoomsController < ApplicationController

  def index
    raise session.inspect
    @rooms = Room.all
  end

  def new

  end

  def create
    # Room.broadcast_creation(params)
    Room.create(params[:room])
    redirect_to rooms_path
  end

end