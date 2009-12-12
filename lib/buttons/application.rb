require Buttons.dir('router')

module Buttons
  def self.app
    @app ||= Buttons::Application.new
    @app
  end
  
  class Application
    attr :middlewares

    def initialize
      @router = Buttons::Router.new
      @middlewares = []
    end
    
    def add_route(http_method, path, button, method)
      @router.add_route(http_method, path, :button => button, :method => method)
    end
    
    def call(environment)
      rack_app = lambda { |env|
        request = ::Rack::Request.new(env)
        route = @router.recognize(request)

        if route
          render(request, route)
        else
          [404, {"Content-Type" => 'text/plain'}, "not found: #{request.path}\n\n" +
              "All routes: \n#{@router.print_routes}"
          ]
        end
      }

      middlewares.each do |middleware|
        rack_app = middleware.new rack_app
      end

      rack_app.call environment
    end

    def render(request, destination)
      button_klass, method_name = destination[:button], destination[:method]

      response_code = 200
      headers = {"Content-Type" => 'text/javascript'}
      content = button_klass.new(request).call_method(method_name)

      [response_code, headers, content]
    end
  end
end