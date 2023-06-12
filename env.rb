ENV["APP_ENV"] ||= "development"

require "bundler/setup"

$LOAD_PATH.unshift __dir__
autoload :App, "lib/app"
autoload :Assets, "lib/assets"
