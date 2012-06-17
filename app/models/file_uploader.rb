class FileUploader < AWS::S3::S3Object

  AWS::S3::Base.establish_connection!(
      access_key_id: AWS_KEY,
      secret_access_key: AWS_SECRET)

  set_current_bucket_to CURRENT_BUCKET
end