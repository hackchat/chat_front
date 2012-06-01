class App.Room extends Spine.Model
  @configure 'Room', 'name'
  @extend Spine.Model.Ajax

  # @hasMany 'messages', 'Message'