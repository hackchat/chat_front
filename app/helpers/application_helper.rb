module ApplicationHelper

  def current_user
    resp = Faraday.get "#{LOGIN_URL}users/#{session[:user_token]}.json"
    Hashie::Mash.new(JSON.parse(resp.body))
  end

  def message_owner(auth_token)
    resp = Faraday.get "#{LOGIN_URL}users/#{auth_token}.json"
    Hashie::Mash.new(JSON.parse(resp.body))
  end

end
