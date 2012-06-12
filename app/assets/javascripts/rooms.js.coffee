$.namespace = {

  getMessages: (room_id) ->
    $.getJSON("#{document.URL}messages.json/?room_id=#{room_id}", @renderMessages)

  renderMessages: (messages) =>
    for message in messages
      addOneMessage(message)

  fayeSubscribe: (room_id) =>
    faye = new Faye.Client("http://localhost:9292/faye")
    @sub = faye.subscribe("/messages/#{room_id}", (data) ->
                     addOneMessage(data)
                     console.log "JHER"
                  )
  fayeUnsubscribe: (room_id) =>
    if @sub
      @sub.callback ->
        @sub.cancel()

  handleRoomChange: (room_id, room_name) =>
    $("#chat").html(" ")
    $("#room_name").text(room_name)
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
    $.namespace.handleRoomChange($(this).attr('id'), $(this).text())
  VIMMode()

VIMMode = ->
  $("body").keypress (e) ->
      if e.which == 49
        $.namespace.handleRoomChange($(".room_change")[0].id, $(".room_change")[0].text)
      if e.which == 50
        $.namespace.handleRoomChange($(".room_change")[1].id, $(".room_change")[1].text)
      if e.which == 105
        $("#message_content").focus()
        e.preventDefault()
  $("body").keyup (e) ->
    if e.which == 27
      $("#message_content").blur()
  $("#message_content").keypress (e) ->
    e.stopPropagation()

addOneMessage = (message) ->
  $('#chat').append Mustache.to_html($('#message_template').html(), message)
  $("#chat").scrollTop(11000)