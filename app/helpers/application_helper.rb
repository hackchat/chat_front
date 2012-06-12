module ApplicationHelper

  def current_user
    resp = Faraday.get "http://login.hackchat.in/users/#{session[:user_token]}.json"
    user = Hashie::Mash.new(JSON.parse(resp.body))
  end

  def message_owner(auth_token)
    resp = Faraday.get "http://login.hackchat.in/users/#{auth_token}.json"
    user = Hashie::Mash.new(JSON.parse(resp.body))
  end

end