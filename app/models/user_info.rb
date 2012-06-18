class UserInfo
  attr_accessor :email, :user_token, :first_name, :last_name

  def self.get_by_email(email)
    email = Base64.encode64(email).strip
    resp  = Faraday.get "#{LOGIN_URL}emails/#{email}.json"
    # raise resp.inspect
    if resp.body != " "
      new(JSON.parse(resp.body)["user"])
    else
      []
    end
  end

  def self.get_by_user_token(token)
    resp = Faraday.get("#{LOGIN_URL}users/#{token}.json")
    new(JSON.parse(resp.body))
  end

  def initialize(attributes)
    self.email      = attributes["email"]
    self.user_token = attributes["user_token"]
    self.first_name = attributes["first_name"]
    self.last_name  = attributes["last_name"]
  end

end
