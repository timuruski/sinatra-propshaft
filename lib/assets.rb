require "propshaft"

# Propshaft requires some ActiveSupport stuff.
require "active_support/ordered_options"
require "active_support/core_ext/string"
require "active_support/core_ext/integer"

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
    }

    app.set :assets, Propshaft::Assembly.new(app.config.assets)
    app.helpers Assets::Helper
  end

  module Helper
    def compute_asset_path(path, options = {})
      settings.assets.resolver.resolve(path) || raise(Propshaft::MissingAssetError.new(path))
    end
  end
end
