json.array!(@messages) do |json, message|
  json.(message, :id, :content, :created_at)
end