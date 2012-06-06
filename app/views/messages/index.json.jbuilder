json.array!(@messages) do |json, message|
  json.(message, :id, :content, :room_id, :created_at)
end