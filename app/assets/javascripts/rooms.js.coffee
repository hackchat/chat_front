$.namespace = {
  getMessages: (room_id) ->
    $.getJSON('/messages/#{room_id}.json', @renderMessages)

  renderMessages: (messages) =>
    for message in messages
      $('#chat').append Mustache.to_html($('#message_template').html(), message)

  FayeHandler: (room_id) =>
    faye = new Faye.Client("http://localhost:9292/faye")
    faye.subscribe("/messages/#{room_id}", (data) ->
                    $('#chat').append Mustache.to_html($('#message_template').html(), data)
                  )
}
$("#new_message").live "ajax:complete", (event, xhr, status) ->
  $("#message_content").val ""