module ApplicationHelper

  def current_user
    resp = Faraday.get "#{LOGIN_URL}users/#{session[:user_token]}.json"
    Hashie::Mash.new(JSON.parse(resp.body))
  end

  def message_owner(auth_token)
    resp = Faraday.get "#{LOGIN_URL}users/#{auth_token}.json"
    Hashie::Mash.new(JSON.parse(resp.body))
  end

  def current_room_permissions
    resp = Faraday.get "#{PERMISSIONS_URL}users/#{session[:user_token]}.json"
    perms = JSON.parse(resp.body)
    perms.collect do |perm|
      Hashie::Mash.new(perm)
    end
  end
end
