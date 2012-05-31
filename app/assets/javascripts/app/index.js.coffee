#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route

#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

class App extends Spine.Controller

  constructor: ->
    super
    Spine.Route.setup()
    @append(@rooms = new App.Rooms)
    @append(@messages = new App.Messages)

class App.Root extends Spine.Stack
  controllers:
    messages:   App.Messages
    rooms:      App.Rooms

  routes:
    '/messages'  : 'messages'
    '/rooms'     : 'rooms'

  default: 'messages'
  className: 'stack rooms'

class Spine.SubStack extends Spine.Stack

  constructor: ->
    console.log "HERE"
    for key,value of @routes
      do (key,value) =>
        @routes[key] = =>
          @active()
          @[value].active(arguments...)
    super

window.App = App