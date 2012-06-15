class Message

  constructor: (message) ->
    @avatar = message.avatar
    @content = message.content
    @name = message.name
    @room_id = message.room_id
    @time_stamp = message.time_stamp

  renderMessage: =>
    $('#chat').append Mustache.to_html($('#message_template').html(), this)
    $("#chat").scrollTop(11000)

  @getMessages: (room_id) ->
    $.getJSON("#{document.URL}messages.json?room_id=#{room_id}", @renderMessages)

  @renderMessages: (messages) ->
    $("#chat").html(" ")
    for message in messages
      msg = new Message(message)
      msg.renderMessage()

window.Message = Message