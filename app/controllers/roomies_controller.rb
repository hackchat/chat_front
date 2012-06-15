class RoomiesController < ApplicationController

  def index
    @roomies = Roomie.find_all_by_room_id(params[:room_id])
  end

  def show
    @roomie = Roomie.find(params[:id])
  end

  def create
    roomie = Roomie.create(user_token: params[:user_token], room_id: params[:room_id])
    render json: roomie.to_json
  end

  def destroy
    roomie = Roomie.find_by_user_token(params[:id])
    roomie.destroy if roomie
    render json: "DERP"
  end

end
