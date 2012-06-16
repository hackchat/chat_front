user = message_owner(@roomie.user_token)
json.name truncate(user.first_name)
json.avatar user.avatar
json.room_id @roomie.room_id
json.user_token @roomie.user_token