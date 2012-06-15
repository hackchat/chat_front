jQuery ->
  $(".room_change").click (e) ->
    e.preventDefault()
    room = new Room($(this).attr('id'), $(this).text())
    room.handleRoomChange()
  VIMMode()

$("#new_message").live "ajax:complete", (event, xhr, status) ->
  $("#message_content").val ""
  $("#message_language").val("Plain Text")

$(window).load ->
  first_room = $(".room_change").first()
  if first_room.length
    $(".room_change").first().click()
  else
    $(".chat_client").html("<h1>You aren't a part of any rooms yet.</h1>")
    $("#enter").html("")
    $(".file_upload").html("")

# (window).bind 'beforeunload' ->
#   roomie = new Roomie({ room_id: $("#message_room_id").val(), user_token: $('#current_user').attr("user-token") })
#   roomie.unsubscribe($('#current_user').attr("user-token"))

# window.onbeforeunload
# async is false

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
          room = new Room(obj.id, obj.name)
          room.handleRoomChange()
        counter = counter + 1

