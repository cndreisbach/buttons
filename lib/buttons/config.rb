module Buttons
  module Config
    def app_root=(path)
      @app_root = path
    end

    def app_root(*paths)
      if @app_root
        File.expand_path(File.join(@app_root, *paths))
      end
    end
  end
end