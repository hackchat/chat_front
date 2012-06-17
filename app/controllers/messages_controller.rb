class MessagesController < ApplicationController
  before_filter :require_login, only: [:create]

  def index
    @messages = Message.where(room_id: params[:room_id]).limit(100)
  end

  def create
    user = current_user
    params[:message][:user_token] = user.user_token
    params[:message][:avatar] = user.avatar
    params[:message][:name] = "#{user.first_name} #{user.last_name[0]}."
    @message = Message.create(params[:message])
    @message.broadcasts(params[:broadcasts]) unless broadcasts.blank?
    render json: true, status: :created
  end

end