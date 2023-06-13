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

namespace :css do
  desc "Build your CSS bundle"
  task :build do
    unless system "yarn install && yarn build:css"
      raise "Command css:build failed, ensure yarn is installed and `yarn build:css` runs without errors or use SKIP_CSS_BUILD env variable"
    end
  end
end

unless ENV["SKIP_CSS_BUILD"]
  Rake::Task["assets:precompile"].enhance(["css:build"])
end

namespace :js do
  desc "Build your JS bundle"
  task :build do
    unless system "yarn install && yarn build"
      raise "Command build failed, ensure yarn is installed and `yarn build` runs without errors or use SKIP_JS_BUILD env variable"
    end
  end
end

unless ENV["SKIP_JS_BUILD"]
  Rake::Task["assets:precompile"].enhance(["js:build"])
end
