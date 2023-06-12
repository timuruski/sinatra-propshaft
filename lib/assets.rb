require "propshaft"
require "active_support/ordered_options"
require "active_support/core_ext/string"

# Configuration ripped from the propshaft railtie
module Assets
  def self.registered(app)
    app.set :config, ActiveSupport::OrderedOptions.new.tap { |config|
      config.assets = ActiveSupport::OrderedOptions.new
      config.assets.paths          = []
      config.assets.excluded_paths = []
      config.assets.version        = "1"
      config.assets.prefix         = "/assets"
      config.assets.quiet          = false
      config.assets.compilers      = [
        [ "text/css", Propshaft::Compilers::CssAssetUrls ],
        [ "text/css", Propshaft::Compilers::SourceMappingUrls ],
        [ "text/javascript", Propshaft::Compilers::SourceMappingUrls ]
      ]
      config.assets.sweep_cache = ENV["APP_ENV"] == "development"
      config.assets.server = ENV["APP_ENV"] == "development" || ENV["APP_ENV"] == "test"
      config.assets.relative_url_root = nil

      # After initialize
      # config.assets.relative_url_root ||= app.config.relative_url_root
      # config.assets.output_path ||=
      #   Pathname.new(File.join(app.config.paths["public"].first, app.config.assets.prefix))
    }

    app.set :assets, Propshaft::Assembly.new(app.config.assets)
  end
end
