require 'usher'
require 'pp'
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
      @router.add_route(path, :requirements => {:method => http_method}).to(
        :button => button, :method => method
      )
    end
    
    def call(environment)
      rack_app = lambda { |env|
        request = ::Rack::Request.new(env)
        response = @router.recognize(request, request.path_info)        

        if response          
          [200, {"Content-Type" => 'text/javascript'}, render(request, response.path.route.destination)]
        else
          raise @router.inspect
          [404, {"Content-Type" => 'text/plain'}, "not found: #{request.path}"]
        end
      }
 
      # call middlewares (with this app's logic being the most inner app)
      rack_app.call environment
    end

    def render(request, destination)
      button_klass, method_name = destination[:button], destination[:method]
      button_klass.new(request).call_method(method_name)
    end
  end
end