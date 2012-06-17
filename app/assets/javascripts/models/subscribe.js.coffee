class Subscribe

  @subscribeFaye: (channel, Type) ->
    @faye.subscribe channel, (data) ->
                    new Type(data).render()

  @unsubscribeFaye: ->
    @sub.callback =>
      @sub.cancel()

  @handleSubscription: (channel, Type) ->
    @faye or= new Faye.Client(FAYE_DOMAIN)
    Subscribe.unsubscribeFaye() if @sub
    @sub = Subscribe.subscribeFaye(channel, Type)

window.Subscribe = Subscribe