class UploadersController < ApplicationController
  def show
    @room_id = params[:room_id]
    @user_token = params[:user_token]
    @uploaded_files = Upload.find_all_by_user_token_and_room_id(@user_token, @room_id)
  end

  def create
    if params[:file]
      file = params[:file]
      upload = Upload.new(user_token: params[:file_user_token], room_id: params[:file_room_id])
      upload.upload_to_s3(file.original_filename, file)
      upload.save
      render json: { status: :created, url: upload.url }
    else
      head 422
    end
  end
end
