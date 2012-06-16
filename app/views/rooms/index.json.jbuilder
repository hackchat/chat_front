json.array!(@rooms) do |json, room|
  json.name room.name
  json.id room.id
end