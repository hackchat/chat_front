class RoomsController < ApplicationController
  before_filter :find_room, only: [:edit, :update, :destroy, :show]

  def index
    @rooms = Room.all
  end

  def create
    Room.create!(params[:room])
  end

  def edit

  end

  def update

  end

  def destroy

  end

private

  def find_room
    @room = Room.find(params[:id])
  end
end
