json.array!(@rooms) do |json, room|
  json.(room, :id, :name, :created_at)
end