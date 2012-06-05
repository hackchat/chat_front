class MessagesController < ApplicationController

  def create
    @message = Message.create!(params[:message])
    render json: @message, status: :created
  end

end