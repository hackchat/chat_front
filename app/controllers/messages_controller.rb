class MessagesController < ApplicationController

  def index
    @messages = Message.find_all_by_room_id(params[:room_id])
    render json: @messages.as_json, status: :ok
  end

  def create
    # Message.broadcast_creation(params)
    @message = Message.create(params[:message])
    render json: true, status: :created
  end

end