window.Roomies = []
class Roomie

  constructor: (params) ->
    @room_id      = params.room_id
    @avatar       = params.avatar
    @name         = params.name
    @user_token   = params.user_token
    @status       = params.status
    $.ajaxSetup( { async:false } )
    Roomies.push this

  render: =>
    if @status == "CREATED"
      $("#roomies").append Mustache.to_html($('#roomie_template').html(), this)
    else
      $("##{@user_token}").remove()

    $('.pac-man-roomies').remove()

  subscribe:  =>
    $.post "/roomies", {
                          room_id: @room_id,
                          user_token: @user_token,
                          name: @name,
                          avatar: @avatar,
                        }

  unsubscribe: =>
    $.ajax({
      type: "DELETE",
      url: "/roomies/#{@user_token}",
      })

  @fetch: (room_id) ->
    $.getJSON("#{document.URL}roomies.json?room_id=#{room_id}", @renderRoomies)

  @renderRoomies: (objs) =>
    for obj in objs
      roomie = new Roomie(obj).render()

  @handleRoomie: (room_id, user) ->
    $("#roomies").html("<img src='/ajax-loader.gif' class='pac-man-roomies'>")
    roomie = new Roomie({ room_id: room_id, avatar: user.avatar, name: user.name, user_token: user.user_token, status: "CREATED" })
    roomie.unsubscribe()
    roomie.subscribe()
    Subscribe.handleSubscription("/roomies/#{room_id}", Roomie)
    Roomie.fetch(room_id)

window.Roomie = Roomie