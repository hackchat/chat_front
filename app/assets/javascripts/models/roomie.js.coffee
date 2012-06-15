class Roomie

  constructor: (params) ->
    @room_id = params.room_id
    @user_token = params.user_token
    @avatar = params.avatar
    @name = params.name

  renderRoomie: =>
    $("#roomies").append Mustache.to_html($('#roomie_template').html(), this)

  subscribe: =>
    $.post("/roomies", {room_id: @room_id, user_token: @user_token})

  unsubscribe: =>
    $.ajax({
      type: "DELETE",
      url: "/roomies/#{@old_room_id}?user_token=#{@user_token}",
      })
    @old_room_id = @room_id

  @fetch: (room_id) ->
    $.getJSON("#{document.URL}roomies?room_id=#{room_id}.json", @renderRoomies)

  @renderRoomies: (objs) =>
    $('#roomies').html("")
    for obj in objs
      roomie = new Roomie(obj)
      roomie.renderRoomie()

  @handleRoomie: (room_id, user_token) ->
    roomie = new Roomie({ room_id: room_id, user_token: user_token })
    roomie.unsubscribe() if @old_room_id
    roomie.subscribe()
    Roomie.fetch(room_id)
    setInterval("Roomie.fetch(#{room_id})",100000)

window.Roomie = Roomie