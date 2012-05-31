$ = jQuery.sub()

MessagesController = App.Messages
RoomsController = App.Rooms


class App.MainController extends Spine.Controller
  className: 'main-view'

  constructor: ->
    super

    mainViewStack = new MainViewStack()

    @routes
      '/messages': ->
          mainViewStack.messages.active()
      '/rooms': ->
          mainViewStack.rooms.active()

    @append mainViewStack


class MainViewStack extends Spine.Stack
  className: 'main-view-content stack'

  controllers:
    messages: MessagesController
    rooms: RoomsController

  default: 'rooms'