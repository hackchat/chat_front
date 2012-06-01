class RoomsController < ApplicationController
  before_filter :find_room, only: [:edit, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def create
    Room.create!(params[:room])
    render json: true, status: :created
  end

  def edit

  end

  def update
    @room.update_attributes(params[:room])
    @room.save
    render :json => true, :status => 200
  end

  def destroy
    @room.destroy
    render :json => true, :status => 200
  end

  def show
    @room = Room.includes(:messages).find(params[:id])
  end

private

  def find_room
    @room = Room.find(params[:id])
  end
end