class Message < ActiveRecord::Base
  before_create :highlight
  after_create :broadcast_creation
  attr_accessible :content, :room_id, :language, :user_token, :avatar, :name

  searchable do
    text :content
    string :user_token
    integer :room_id
  end

  def broadcast_creation
    message = {
     :channel => "/messages/#{self.room_id}",
     :data => self,
     :ext => {:auth_token => "suppppyallll"}
   }
   uri = URI.parse(FAYE_DOMAIN)
   Net::HTTP.post_form(uri, :message => message.to_json) if uri
 end

 def broadcasts(token_string)
  tokens = token_string.split(',')
  message = { channel: "/broadcasts/#{self.room_id}", data: tokens,
    ext:{:auth_token => "suppppyallll" }
    }
  uri = URI.parse(FAYE_DOMAIN)
  Net::HTTP.post_form(uri, :message => message.to_json) if uri
  end

  def highlight
    unless self.language == "Plain Text"
      self.content = Pygments.highlight(self.content,
        lexer: self.language.downcase)
    end
  end

end