$ = jQuery.sub()
Message = App.Message

class App.MessageItem extends Spine.Controller

  constructor: ->
    super

  render: ->
    @html @view("messages/message")(@)

class Index extends Spine.Controller

  constructor: ->
    super
    Message.bind 'refresh', =>
      @messages = Message.all()
      @addAll()
    Message.fetch()

  render: =>
    @html @view('messages/index')(@)

  submit: (e) ->
      e.preventDefault()
      message = Message.fromForm(e.target).save()
      $("#new_message")[0].reset()

  addAll: ->
    @render()
    addOne(message) for message in @messages

class App.Messages extends Spine.Stack
  controllers:
    index: Index

  routes:
    '/messages':          'index'

  default: 'index'
  className: 'stack messages'

addOne = (message) ->
  item = new App.MessageItem({ el: '', message })
  $("#app").find('#messages').append(item.render())
