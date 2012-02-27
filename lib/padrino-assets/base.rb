module Padrino
  module Assets
    def self.registered(app)

      # Default settings (todo: make these overwritable)
      app.set :assets_compression, lambda{ settings.environment != :development }
      app.set :assets_debug, lambda{ settings.environment != :development }
      app.set :assets_url, "/assets"
      # An array of directories to search all assets
      app.set :asset_src_files, ["js", "css", "images"].map { |dir| [ dir, ['..', 'lib', dir] ] }.flatten


      # Configure Sprockets
      #Rack::Sprockets.configure do |config|
      #  config.compress = app.settings.assets_compression
        # config.debug = app.settings.assets_debug
      #end


      # Initialize Sprokets
      app.use Rack::Sprockets,
        :root => app.root,
        :public => File.join("..", "public"),
        :load_path => app.settings.asset_src_files,
        :hosted_at => '/assets'

    end
  end
end
