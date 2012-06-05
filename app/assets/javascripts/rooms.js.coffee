jQuery ->
  getMessages = (room_id) ->
    console.log "HERE"
    $.getJSON('/messages/#{room_id}.json', messages)
    for message in messages
      $('#chat').append Mustache.to_html($('#message_template').html(), message)

  FayeHandler = (room_id) ->
    console.log "HERE"
    faye = new Faye.Client("http://localhost:9292/faye")
    faye.subscribe("/messages/#{room_id}", (data) ->
                    $('#chat').append Mustache.to_html($('#message_template').html(), message)
                  )