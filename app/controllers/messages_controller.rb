class MessagesController < ApplicationController

  def index
    @messages = Message.all
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