<<<<<<< HEAD
if Rails.env.production?
=======
unless Rails.env.production?
  CHAT = "http://hackchat.dev"
  PERMISSIONS_URL = "http://permissions.hackchat.dev/"
  LOGIN_URL = "http://login.hackchat.dev/"
  FAYE_DOMAIN = "http://hackchat.dev:9292/faye"
  # CHAT = "http://hackchat.dev:8080"
  # PERMISSIONS_URL = "http://permissions.hackchat.dev:8080/"
  # LOGIN_URL = "http://login.hackchat.dev:8080/"
  # FAYE_DOMAIN = "http://hackchat.dev:9292/faye"
else
>>>>>>> 1e56c12bfb295b0ae49af583e0b76fa63f974fd4
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