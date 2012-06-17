class PermissionsController < ApplicationController

  def index
    resp = Faraday.get("#{PERMISSIONS_URL}rooms/#{params["room_id"]}.json")
    parsed_json = JSON.parse(resp.body)
    user_tokens = parsed_json.collect {|user| user["user_token"]}
    @users = []
    user_tokens.each do |token|
      @users << UserInfo.get_by_user_token(token)
    end
  end

  def show
    
  end

  def new
  end

  def create
    room = Room.find(params[:room_id])
    unless room.owned_by?(session[:user_token])
      head :status => :unauthorized && return
    end

    user_info = UserInfo.get_by_email(params[:email])

    if user_info == []
      flash[:notice] = "This user does not exist."
      render :new
    else
      room.create_permission_for(user_info.user_token)
      redirect_to new_room_permission_path(room)
    end
  end

  def edit
  end

  def update
  end

end