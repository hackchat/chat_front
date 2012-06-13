json.array!(@messages) do |json, message|
  json.content message.content
  json.avatar message.avatar
  json.name message.name
  json.timestamp message.created_at
  json.room_id message.room_id
end