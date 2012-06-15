class Roomie

  constructor: (params) ->
    @room_id = params.room_id
    @user_token = params.user_token
    @avatar = params.avatar
    @name = params.name

  renderRoomie: =>
    unless $("##{@user_token}").attr("id")
      $("#roomies").append Mustache.to_html($('#roomie_template').html(), this)
    $('.pac-man-roomies').remove() if $('.pac-man-roomies')

  subscribe:  =>
    $.post("/roomies", {room_id: @room_id, user_token: @user_token})

  unsubscribe: (user_token) =>
    $.ajax({
      type: "DELETE",
      url: "/roomies/#{user_token}",
      })

  @fetch: (room_id) ->
    console.log "#{document.URL}roomies?room_id=#{room_id}.json"
    $.getJSON("#{document.URL}roomies.json?room_id=#{room_id}", @renderRoomies)

  @renderRoomies: (objs) =>
    for obj in objs
      roomie = new Roomie(obj)
      roomie.renderRoomie()

  @handleRoomie: (room_id, user_token) ->
    clearInterval(@roomieChecker) if @roomieChecker
    $("#roomies").html("<img src='/ajax-loader.gif' class='pac-man-roomies'>")
    roomie = new Roomie({ room_id: room_id, user_token: user_token })
    roomie.unsubscribe(user_token)
    roomie.subscribe()
    Roomie.fetch(room_id)
    @roomieChecker = setInterval("Roomie.fetch(#{room_id})",10000)

window.Roomie = Roomie