class Broadcast
  constructor: (broadcast_tokens) ->
    @broadcast_tokens = broadcast_tokens
    @client_user_token = $('#current_user').attr('user-token')

  render: =>
    unless @broadcast_tokens.indexOf(@client_user_token) == -1
      $('#broadcast').html("You have a new message!")
      $('#broadcast').show().slideUp(2000)

class BroadcastSubscribe

  @subscribeFaye: (channel, Type) ->
    @faye.subscribe channel, (data) ->
                    new Type(data).render()

  @unsubscribeFaye: ->
    @sub.callback =>
      @sub.cancel()

  @handleSubscription: (channel, Type) ->
    @faye or= new Faye.Client(FAYE_DOMAIN)
    BroadcastSubscribe.unsubscribeFaye() if @sub
    @sub = BroadcastSubscribe.subscribeFaye(channel, Type)

window.Broadcast = Broadcast
window.BroadcastSubscribe = BroadcastSubscribe