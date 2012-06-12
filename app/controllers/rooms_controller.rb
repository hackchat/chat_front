class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def new

  end

  def create
    # Room.broadcast_creation(params)
    Room.create(params[:room])
    if Rails.env.production?
      redirect_to "http://hackchat.in"
    else
      redirect_to "http://localhost:2000"
    end
  end

end