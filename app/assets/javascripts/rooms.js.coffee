jQuery ->
  $(".room_change").click (e) ->
    e.preventDefault()
    $('#current_room').html $(this).attr('id')
    room_id = $('#current_room').html()
    new Room(room_id, $(this).text()).handleRoomChange()
    BroadcastSubscribe.handleSubscription("/broadcasts/#{room_id}", Broadcast)
  VIMMode()
  first_room = $(".room_change").first()
  if first_room.length
    $(".room_change").first().click()
  else
    $(".chat_client").html("<h1>Hey Big Tuna,
                                get some friends to chat with.</h1>")
    $("#enter").html("").hide()
    $(".file_upload").html("").hide()

$("#new_message").live "ajax:complete", (event, xhr, status) ->
  $("#message_content").val ""
  $("#message_language").val("Plain Text")

$(window).bind "beforeunload", ->
    new Roomie({ user_token: $('#current_user').attr("user-token") }).unsubscribe()

VIMMode =  ->
  if $("#chat").length
    $("body").keypress (e) =>
      addRoomHotKeys(e)
      if e.which == 105
        $("#message_content").focus()
        e.preventDefault()
    $("body").keyup (e) ->
      if e.which == 27
        $("#message_content").blur()
    $("#message_content").keypress (e) ->
      if (e.which == 13 && e.shiftKey == false)
        $("#new_message").submit()
      e.stopPropagation()

addRoomHotKeys =  (e) ->
  if ((e.which > 48) && (e.which < 58))
    $.getJSON "#{document.URL}rooms.json", (objs) =>
      counter = 0
      for obj in objs
        if e.which == (49 + counter)
          room = new Room(obj.id, obj.name).handleRoomChange()
        counter = counter + 1

