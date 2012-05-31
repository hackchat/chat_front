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

  change: (id) ->
    @item = Room.find(id)
    @render()

  render: ->
    @html @view('rooms/edit')(@item)

  back: ->
    @navigate '/rooms'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/rooms'

class Show extends Spine.Controller
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=back]': 'back'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Room.find(id)
    @render()

  render: ->
    @html @view('rooms/show')(@item)

  edit: ->
    @navigate '/rooms', @item.id, 'edit'

  back: ->
    @navigate '/rooms'

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

  default: 'index'
  className: 'stack rooms'