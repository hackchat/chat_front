class UserInfo
  attr_accessor :email, :user_token

  def self.get_by_email(email)
    email = Base64.encode64(email).strip
    resp  = Faraday.get "#{LOGIN_URL}emails/#{email}.json"
    new(JSON.parse(resp.body)["user"])
  end

  def initialize(attributes)
    self.email      = attributes["email"]
    self.user_token = attributes["user_token"]
  end

end
