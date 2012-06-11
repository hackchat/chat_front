json.array!(@messages) do |json, message|
  json.content message.content
  json.timestamp message.created_at
  json.room_id message.room_id

  owner = message_owner(message.user_token)

  json.first_name owner.first_name
  json.last_name owner.last_name
  json.avatar owner.avatar
end