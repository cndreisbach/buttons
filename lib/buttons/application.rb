require 'usher'

module Buttons
  def self.app
    @app ||= Buttons::Application.new
    @app
  end
  
  class Application
    def initialize
      @router = Usher.new
    end
    
    def add_route(http_method, path, button, method)
      # @router.add_route(path, :conditions => {:method => http_method}).to(
      #   :button => button, :method => method)
    end
    
    def call(env)
      rack_app = lambda { |env|
        http_method = env['REQUEST_METHOD'].downcase.to_sym
        path = env['PATH_INFO']
 
        [200, {}, "Hello world"]
      }
 
      # call middlewares (with this app's logic being the most inner app)
      rack_app.call env
    end
  end
end