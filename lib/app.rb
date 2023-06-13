require "sinatra/base"
require "json"

class App < Sinatra::Base
  register Assets

  set :root, File.expand_path("../", __dir__)

  configure do
    config.assets.output_path = Pathname.new(File.join(root, "public", config.assets.prefix))
    config.assets.paths << "assets"
  end

  get "/" do
    erb :hello
  end

  get "/config" do
    content_type :json
    JSON.generate({
      config: settings.config.to_h,
      root: settings.root
    })
  end
end
