json.array!(@roomies) do |json, roomie|
  json.name truncate(roomie.name)
  json.avatar roomie.avatar
  json.room_id roomie.room_id
  json.user_token roomie.user_token
end