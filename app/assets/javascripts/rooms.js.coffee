class Room
  constructor: ->
    @faye or= new Faye.Client(FAYE_DOMAIN)

  getMessages: (room_id) ->
    $.getJSON("#{document.URL}messages.json?room_id=#{room_id}", @renderMessages)

  renderMessages: (messages) =>
    for message in messages
      addOneMessage(message)

  fayeSubscribe: (room_id) =>
    @sub = @faye.subscribe("/messages/#{room_id}", (data) ->
                     addOneMessage(data)
                  )

  fayeUnsubscribe: (room_id) =>
    if @sub
      @sub.callback =>
        @sub.cancel()

  changeRoomName: (room_name) =>
    $("#chat").html(" ")
    $("#room_name").text(room_name)

  handleFaye: (room_id) =>
    @fayeUnsubscribe(room_id)
    @fayeSubscribe(room_id)
    @handleRoomie(room_id)

  handleRoomie: (room_id) =>
    user = $('#current_user').attr("user-token")
    $.post("/roomies", {room_id: room_id, user_token: user})
    @unsubscribeRoomie(room_id, user)
    $.getJSON("#{document.URL}roomies/#{room_id}", @renderRoomies)

  unsubscribeRoomie: (room_id, user) =>
    if @old_room_id
          $.ajax({
            type: "DELETE",
            url: "/roomies/#{@old_room_id}?user_token=#{user}",
            })
    @old_room_id = room_id

  renderRoomies: (roomies) =>
    for roomie in roomies
      addOneRoomie(roomie)

  handleRoomChange: (room_id, room_name) =>
    @changeRoomName(room_name)
    @handleFaye(room_id)
    @getMessages(room_id)
    $("#message_room_id").val(room_id)

$("#new_message").live "ajax:complete", (event, xhr, status) ->
  $("#message_content").val ""

jQuery ->
  room = new Room
  $(".room_change").click (e) =>
    e.preventDefault()
    room.handleRoomChange($(this).attr('id'), $(this).text())
  VIMMode(room)

# $(window).unload ->
#   room.call_unsubscribe

VIMMode = (room) ->
  if $("#chat").length
    $("body").keypress (e) =>
        if e.which == 49
          room.handleRoomChange($(".room_change")[0].id, $(".room_change")[0].text)
        if e.which == 50
          room.handleRoomChange($(".room_change")[1].id, $(".room_change")[1].text)
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
addOneRoomie = (roomie) ->
  $('#chat').append Mustache.to_html($('#roomie_template').html(), roomie)