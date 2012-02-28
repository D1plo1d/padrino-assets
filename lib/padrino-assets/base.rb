module Padrino
  module Assets
    def self.registered(app)

      # Default settings (todo: make these overwritable)
      app.set :assets_compression, lambda{ settings.environment != :development }
      app.set :assets_debug, lambda{ settings.environment != :development }
      app.set :assets_url, "/assets"
      # An array of directories to search all assets
      app.set :asset_src_files, ["js", "css"].map { |dir| [ dir, ['..', 'lib', dir] ] }.flatten


      # CSS and JS Cache-Busting Helpers
      app.helpers do
        def css
          "<link href=\"/assets/app.css\" type=\"text/css\" media=\"screen\" rel=\"stylesheet\" />"
        end

        def js
          "<script src=\"/assets/app.js\" type=\"text/javascript\" ></script>"
        end
      end

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


      # Images
      ["/images/:image", "/img/:image"].each do |url|
        app.get url do
          path = File.join App.root, "images", params[:image]
          pass unless File.exists? path
          content_type "image/#{File.extname(path)}"
          send_file path
        end
      end
    end
  end
end
