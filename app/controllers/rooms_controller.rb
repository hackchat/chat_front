class RoomsController < ApplicationController
  before_filter :find_room, only: [:edit, :update]

  def index
    @rooms = Room.all
  end

  def create
    @room =  Room.create(params[:room])
    render json: true, status: :created if @room
  end

  def update
    @room.update_attributes(params[:room])
    render :json => @room, :status => 200 if @room.save
  end

  def show
    @room = Room.includes(:messages).find(params[:id])
  end

private

  def find_room
    @room = Room.find(params[:id])
  end
end