class App.MessageItem extends Spine.Controller

  constructor: ->
    super

  render: ->
    @html @view("messages/message")(@)