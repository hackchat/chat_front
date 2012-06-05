$ = jQuery.sub()

RoomsController = App.Rooms

class App.MainController extends Spine.Controller
  className: 'main-view'

  constructor: ->
    super

    mainViewStack = new MainViewStack()

    @routes
      '/rooms': ->
          mainViewStack.rooms.active()

    @append mainViewStack


class MainViewStack extends Spine.Stack
  className: 'main-view-content stack'

  controllers:
    rooms: RoomsController

  default: 'rooms'