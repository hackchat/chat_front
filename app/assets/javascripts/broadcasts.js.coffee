Array::func_index_of = (funq)->
  for num in [0...@length]
    if funq.call(this, this[num])
      return num
  -1

getBroadcastsFromMessages = ->
  $('#new_message').submit ->
    content = $(this).find('#message_content').val()
    tokens = []
    if content.match /@/
      broadcastedNames = content.match(/@\w+ \w\./g)
      for name in broadcastedNames
        name.replace('@', '')
        roomies = window.Roomies.slice()
        index_of_name = roomies.func_index_of (roomie) ->
          $.inArray(roomie.name, broadcastedNames)
        tokens.push window.Roomies[index_of_name].user_token unless index_of_name == -1
      tokens.unique
    $(this).find('#broadcasts').val tokens.join(',')
    true #this should never stop form from submitting

$ ->
  getBroadcastsFromMessages()
  room_id = $('#current_room').val() 
  new Subscribe("/broadcasts/#{room_id}", Broadcast)