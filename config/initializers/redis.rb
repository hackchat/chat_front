require 'redis'

REDIS_URL = "redis://redistogo:b8a6ecd52bed232f3d391126f0a9471c@dogfish.redistogo.com:9010"
REDIS_URI = URI.parse(REDIS_URL)
REDIS = Redis.new(host: REDIS_URI.host, port: REDIS_URI.port, password: REDIS_URI.password)