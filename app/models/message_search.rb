class MessageSearch
  attr_accessor :room_id, :content, :user_token

  def initialize(room_id, content, user_token)
    self.room_id    = room_id
    self.content    = content
    self.user_token = user_token
  end

  def get_results
    Message.search do
      with :room_id, self.room_id
      fulltext self.content
    end.results
  end
end