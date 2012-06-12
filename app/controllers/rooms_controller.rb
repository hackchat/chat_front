class RoomsController < ApplicationController
  # skip_before_filter :create

  def index
    @rooms = Room.all
  end

  def new

  end

  def create
    # Room.broadcast_creation(params)
    Room.create(params[:room])
    redirect_to "http://hackchat.in"
  end

end