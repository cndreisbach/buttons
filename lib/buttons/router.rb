module Buttons
  class Router
    def initialize
      @routes = {}
    end

    def add_route(http_method, path, params)
      http_method = http_method.to_s.downcase

      @routes[http_method] ||= {}
      @routes[http_method][path] = params
    end

    def recognize(request)
      request_method = request.request_method.to_s.downcase

      @routes[request_method] && @routes[request_method][request.path]
    end

    def print_routes
      @routes.map do |http_method, routes|
        routes.map do |route, params|
          "%8s %s %s" % [http_method.upcase, route, params.inspect]
        end.join("\n")
      end.join("\n")
    end
  end
end
