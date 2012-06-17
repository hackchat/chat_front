class Upload < ActiveRecord::Base
  attr_accessible :room_id, :url, :user_token, :file_name

  def upload_to_s3(file_name, file)
     FileUploader.store(file_name, file, CURRENT_BUCKET, access: :public_read)
     self.file_name = file_name
     self.url = "http://#{CURRENT_BUCKET}.s3.amazonaws.com/#{file_name}"
  end
end