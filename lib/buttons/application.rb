require Buttons.lib_root('router')
require Buttons.lib_root('config')

module Buttons
  class Application
    include Buttons::Config

    def initialize(&block)
      @router ||= Buttons::Router.new
      @middlewares ||= []
    end

    def use(middleware, options = nil)
      @middlewares << [middleware, options]
    end

    def start
      unless app_root.nil?
        Dir[app_root('app', '**', '*.rb')].each do |ruby_file|
          require ruby_file
        end
      end
    end
    
    def add_route(http_method, path, params)
      @router.add_route(http_method, path, params)
    end
    
    def call(environment)
      rack_app = lambda { |env|
        request = ::Rack::Request.new(env)
        response = ::Rack::Response.new
        route = @router.recognize(request)

        if route
          render(request, response, route)
        else
          [404, {"Content-Type" => 'text/plain'}, "not found: #{request.path}\n\n" +
              "All routes: \n#{@router.print_routes}"
          ]
        end
      }

      @middlewares.each do |middleware, options|
        rack_app = if options
          middleware.new(rack_app, options)
        else
          middleware.new(rack_app)
        end
      end

      rack_app.call environment
    end

    def render(request, response, params)
      button_klass, method_name = params[:button], params[:method]

      response['Content-Type'] = 'text/javascript'
      content = button_klass.new(request).call_method(method_name)
      if conversion = params.delete(:convert)
        content = content.send(conversion)
      end
      response.write(content)

      response.finish
    end
  end
end