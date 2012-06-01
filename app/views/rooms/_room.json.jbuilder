json.(room, :id, :name, :created_at)
json.messages(room.messages) do |json, message|
  json.partial! message
end