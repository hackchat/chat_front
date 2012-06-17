class Broadcast
  constructor: (broadcast_tokens) ->
    @client_user_token = $('#current_user').attr( 'user_token')
    
  render: =>
    unless broadcast_tokens.indexOf(client_user_token) == -1
      $('#broadcast').html("You have a new message!")
      $('#broadcast').show().slideUp(2000)

window.Broadcast = Broadcast