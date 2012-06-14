json.array!(@roomies) do |json, roomie|
  user = message_owner(roomie.user_token)
  json.name user.first_name
  json.avatar user.avatar
end