class RoomiesController < ApplicationController

  def show
    @roomies = Roomie.find_all_by_room_id(params[:id])
  end

  def create
    roomie = Roomie.create(user_token: params[:user_token], room_id: params[:room_id])
    render json: roomie.to_json
  end

  def destroy
    Roomie.find_by_user_token_and_room_id(params[:user_token], params[:id])
    render json: "DERP"
  end

end
