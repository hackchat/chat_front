module ApplicationHelper

  def current_user
    puts "#{LOGIN_URL}users/#{session[:user_token]}.json"
    resp = Faraday.get "#{LOGIN_URL}users/#{session[:user_token]}.json"
    Hashie::Mash.new(JSON.parse(resp.body))
  end

  def message_owner(auth_token)
    resp = Faraday.get "#{LOGIN_URL}users/#{auth_token}.json"
    Hashie::Mash.new(JSON.parse(resp.body))
  end

  def current_room_permissions
    url = "#{PERMISSIONS_URL}users/#{session[:user_token]}.json"
    resp = Faraday.get url
    perms = JSON.parse(resp.body)
    perms.collect do |perm|
     Hashie::Mash.new(perm)
    end
  end
end
