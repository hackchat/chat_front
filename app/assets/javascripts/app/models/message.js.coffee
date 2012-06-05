class App.Message extends Spine.Model
  @configure 'Message', 'content', 'room_id'
  @extend Spine.Model.Ajax