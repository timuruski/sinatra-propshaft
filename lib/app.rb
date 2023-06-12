require "sinatra/base"

class App < Sinatra::Base
  register Assets

  configure do
    config.assets.paths << "assets"
  end

  get "/" do
    "Hello, #{ENV['APP_ENV']}!"
  end
end
