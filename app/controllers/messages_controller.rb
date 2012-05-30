class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end

  def create
    @message = Message.create!(params[:message])
    render json: @message, status: :created
  end

end