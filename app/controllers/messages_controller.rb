class MessagesController < ApplicationController
  before_filter :require_login, only: [:create]

  def index
    @messages = Message.find_all_by_room_id(params[:room_id])
  end

  def create
    user = current_user
    params[:message][:user_token] = user.user_token
    params[:message][:avatar] = user.avatar
    params[:message][:name] = "#{user.first_name} #{user.last_name}"
    @message = Message.create(params[:message])
    render json: true, status: :created
  end

end