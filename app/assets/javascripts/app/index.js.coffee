#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route

#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require ./controllers/messages
#= require ./controllers/rooms
#= require ./controllers/main_controller
#= require_tree ./views

class App extends Spine.Controller

  constructor: ->
    super
    @append(new App.MainController())
    Spine.Route.setup()

window.App = App