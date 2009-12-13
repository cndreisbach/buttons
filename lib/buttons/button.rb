require 'get_args'

module Buttons
  class Button
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def to_js
      self.class.to_js
    end

    def call_method(method_name)      
      send(method_name, *create_method_args(method_name))
    end
    
    class << self
      def inherited(base)
        Buttons.app.add_route(:get, "/#{base.to_s.debuttonize}.js", 
          :button => base, :method => :to_js)
      end

      def method_added(name)
        routes.each do |http_method, methods|
          if methods.include?(name)
            setup_route(http_method, instance_method(name))
          end
        end
      end

      def js_functions
        @js_functions ||= []
      end

      def argument_list
        @argument_list ||= {}
      end

      def routes
        @routes ||= { }
      end

      def get(*names)
        names.each do |name|
          add_route(:get, name)
        end
      end

      def post(*names)
        names.each do |name|
          add_route(:post, name)
        end
      end     
  
      def to_js
        Buttons::Javascript::JsGenerator.new(self).to_js
      end

      private

      def add_route(http_method, name)
        routes[http_method] ||= []
        routes[http_method] << name

        method = instance_method(name) rescue nil
        if method          
          setup_route(http_method, method)
        end
      end

      def setup_route(http_method, method)
        name = method.name
        route_path = "/#{self.to_s.debuttonize}/#{name}"
        argument_list[name] = method.get_argument_list
        js_functions << Buttons::Javascript::JsFunction.new(
          name, http_method, route_path, method.get_argument_list)
        Buttons.app.add_route(http_method, route_path, 
          :button => self, :method => name, :convert => 'to_json')
      end
    end

    private

    def params
      request.params
    end
    
    def create_method_args(method_name)
      args = []
      argument_list = self.class.argument_list[method_name]

      unless argument_list.nil?
        argument_list.each do |argument|
          param_name = argument.name.to_s
          param_name = param_name.slice(1, param_name.length) if argument.multiple?
          value = params[param_name]
        
          if value.nil? and argument.optional?
            value = argument.default
          end
          if argument.multiple?
            args += value
          else
            args << value
          end
        end
      end

      p args.inspect
      args
    end
  end
end