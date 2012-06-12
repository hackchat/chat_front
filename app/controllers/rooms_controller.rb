class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def new

  end

  def create
    # Room.broadcast_creation(params)
    Room.create(params[:room])
    redirect_to root_url
  end

end