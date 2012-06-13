class MessagesController < ApplicationController

  def index
    @messages = Message.find_all_by_room_id(params[:room_id])
  end

  def create
    params[:message][:user_token] = current_user.auth_token
    @message = Message.create(params[:message])
    render json: true, status: :created
  end

end