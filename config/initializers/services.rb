if Rails.env.production?
  CHAT = "http://hackchat.in"
  PERMISSIONS_URL = "http://permissions.hackchat.in/"
  LOGIN_URL = "http://login.hackchat.in/"
  FAYE_DOMAIN = "http://hackchat.in:9292/faye"
else
  CHAT = "http://hackchat.dev/"
  PERMISSIONS_URL = "http://permissions.hackchat.dev/"
  LOGIN_URL = "http://login.hackchat.dev/"
  FAYE_DOMAIN = "http://localhost:9292/faye"
end
