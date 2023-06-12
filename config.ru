require_relative "env"

if App.config.assets.server
  map App.assets.config.prefix do
    run App.assets.server
  end
end

run App
