class MessagesController < ApplicationController

  def index
    @messages = Message.find_all_by_room_id(params[:room_id])
    render json: @messages, status: :ok
  end

  def create
    @message = Message.new(params[:message])
    if @message.save
      render json: @message, status: :created
    else
      render json: false, status: :unprocessable_entity
    end
  end

end