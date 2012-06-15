class Subscribe

  @subscribeFaye: (channel) ->
    @faye.subscribe channel, (data) ->
                    message = new Message(data)
                    message.renderMessage()

  @unsubscribeFaye: ->
    @sub.callback =>
      @sub.cancel()

  @handleSubscription: (channel) ->
    @faye or= new Faye.Client(FAYE_DOMAIN)
    Subscribe.unsubscribeFaye() if @sub
    @sub = Subscribe.subscribeFaye(channel)

window.Subscribe = Subscribe