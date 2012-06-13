unless Rails.env.production?
  PERMISSIONS_URL = "http://permissions.hackchat.dev"
  LOGIN_URL = "http://login.hackchat.dev"
  FAYE_DOMAIN = "http://hackchat.dev:9292/faye"
else
  PERMISSIONS_URL = "http://permissions.hackchat.in"
  LOGIN_URL = "http://login.hackchat.in"
  FAYE_DOMAIN = "http://hackchat.in:9292/faye"
end