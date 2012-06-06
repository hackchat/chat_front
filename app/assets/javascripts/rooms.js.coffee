$.namespace = {

  getMessages: (room_id) ->
    $.getJSON("/messages/?room_id=#{room_id}", @renderMessages)

  renderMessages: (messages) =>
    for message in messages
      addOneMessage(message)

  fayeSubscribe: (room_id) =>
    faye = new Faye.Client("http://localhost:9292/faye")
    @sub = faye.subscribe("/messages/#{room_id}", (data) ->
                     addOneMessage(data)
                  )
  fayeUnsubscribe: (room_id) =>
    if @sub
      @sub.callback ->
        @sub.cancel()

  handleRoomChange: (room_id) =>
    $("#chat").html(" ")
    $.namespace.fayeUnsubscribe(room_id)
    $.namespace.fayeSubscribe(room_id)
    $.namespace.getMessages(room_id)
    $("#message_room_id").val(room_id)

}
$("#new_message").live "ajax:complete", (event, xhr, status) ->
  $("#message_content").val ""

jQuery ->
  $(".room_change").click (e) ->
    e.preventDefault()
    room_id = $(this).attr('id')
    $.namespace.handleRoomChange(room_id)
  $("body").keypress( (e) ->
      # console.log(e)
    )

addOneMessage = (message) ->
  $('#chat').append Mustache.to_html($('#message_template').html(), message)
