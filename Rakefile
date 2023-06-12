task :environment do
  require_relative "env"
end

namespace :assets do
  desc "Compile all the assets from config.assets.paths"
  task precompile: :environment do
    App.assets.processor.process
    if ENV["APP_ENV"] == "development"
      puts "Warning: You are precompiling assets in development. App will not " \
        "serve any changed assets until you delete public/assets/.manifest.json"
    end
  end

  desc "Remove config.assets.output_path"
  task clobber: :environment do
    App.assets.processor.clobber
  end

  desc "Removes old files in config.assets.output_path"
  task clean: :environment do
    App.assets.processor.clean
  end

  desc "Print all the assets available in config.assets.paths"
  task reveal: :environment do
    puts App.assets.reveal(:logical_path).join("\n")
  end

  namespace :reveal do
    desc "Print the full path of assets available in config.assets.paths"
    task full: :environment do
      puts App.assets.reveal(:path).join("\n")
    end
  end
end
