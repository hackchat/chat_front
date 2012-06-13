module ApplicationHelper

  def current_user
    resp = Faraday.get "http://localhost:4000/users/#{session[:user_token]}.json"
    Hashie::Mash.new(JSON.parse(resp.body))
  end

  def message_owner(auth_token)
    resp = Faraday.get "http://localhost:4000/users/#{auth_token}.json"
    Hashie::Mash.new(JSON.parse(resp.body))
  end

  def current_rooms
    resp = Faraday.get "http://localhost:5000/users/#{session[:user_token]}.json"
    perms = JSON.parse(resp.body)
    perms.collect do |perm|
      Hashie::Mash.new(perm)
  end

  def message_owner(auth_token)
    resp = Faraday.get "http://login.hackchat.in/users/#{auth_token}.json"
    Hashie::Mash.new(JSON.parse(resp.body))
  end

end
