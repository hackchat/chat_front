$ = jQuery.sub()
Room = App.Room

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Room.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'

  constructor: ->
    super
    @active @render

  render: ->
    @html @view('rooms/new')

  back: ->
    @navigate '/rooms'

  submit: (e) ->
    e.preventDefault()
    ## TODO remove c-id
    room = Room.fromForm(e.target).save()
    @navigate '/rooms', room.id if room

class Edit extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (@id) ->
    @item = Room.find(@id)
    @render()

  render: ->
    @html @view('rooms/edit')(@item)

  back: ->
    @navigate '/rooms'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/rooms', @item.id

class Show extends Spine.Controller
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=back]': 'back'
    'submit #new_message': 'submit'

  constructor: ->
    super
    Room.bind 'refresh', @refresh
    @active (params) ->
      Room.fetch({id: params.id})
      FayeHandler(params.id)
      @change(params.id)

  refresh: =>
    @change(@id)

  change: (@id) ->
    if Room.count() > 0 and @id
      @item = Room.find(@id)
      @render()
      addOneMessage(message) for message in @item.messages if @item.messages

  render: ->
    @html @view('rooms/show')(@item)

  edit: ->
    @navigate '/rooms', @item.id, 'edit'

  back: ->
    @navigate '/rooms'

  submit: (e) ->
    e.preventDefault()
    App.Message.fromForm(e.target).save()
    $("#new_message")[0].reset()

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    Room.bind 'refresh change', @render
    Room.fetch()

  render: =>
    rooms = Room.all()
    @html @view('rooms/index')(rooms: rooms)

  edit: (e) ->
    item = $(e.target).item()
    @navigate '/rooms', item.id, 'edit'

  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')

  show: (e) ->
    item = $(e.target).item()
    @navigate '/rooms', item.id

  new: ->
    @navigate '/rooms/new'

FayeHandler = (id) ->
  faye = new Faye.Client("http://localhost:9292/faye")
  faye.subscribe("/messages/#{id}", (data) ->
                  addOneMessage(data)
                )
addOneMessage = (message) ->
  item = new App.MessageItem({ el: '', message })
  $("#app").find('#show_messages').append(item.render())

class App.Rooms extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New

  routes:
    '/rooms/new':      'new'
    '/rooms/:id/edit': 'edit'
    '/rooms/:id':      'show'
    '/rooms':          'index'

  className: 'stack rooms'