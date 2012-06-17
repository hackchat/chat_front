class Room

  constructor: (room_id, room_name) ->
    @room_id = room_id
    @room_name = room_name
    @user = {
             user_token: $('#current_user').attr("user-token"),
             avatar: $('#current_user').attr("avatar"),
             name: $('#current_user').attr("name")
            }
    $('#file_iframe').attr('src', "http://files.hackchat.dev/uploader?room_id=#{@room_id}&user_token=#{@user.user_token}")

  changeRoomName: =>
    $("#room_name").text(@room_name)

  handleRoomChange:  =>
    @changeRoomName()
    Roomie.handleRoomie(@room_id, @user)
    Subscribe.handleSubscription("/messages/#{@room_id}")
    Message.getMessages(@room_id)
    $("#message_room_id").val(@room_id)
    $('#file_iframe').attr('src', "http://files.hackchat.dev/uploader?room_id=#{@room_id}&user_token=#{@user.user_token}")
window.Room = Room