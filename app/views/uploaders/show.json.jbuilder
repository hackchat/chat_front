json.file_count @uploaded_files.count
json.files @uploaded_files do |json, file|
  json.partial! file
end