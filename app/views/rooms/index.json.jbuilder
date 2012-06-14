json.array!(@rooms) do |json, room|
  json.name room.name
end