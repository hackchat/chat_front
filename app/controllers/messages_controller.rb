class MessagesController < ApplicationController

  def create
    Message.broadcast_creation(params)
  end

end