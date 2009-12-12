module Buttons
  class Button
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def params
      request.params
    end

    def to_js
      self.class.to_js
    end

    def call_method(method_name)
      args = []
      argument_list = self.class.argument_list[method_name]

      unless argument_list.nil?
        argument_list.each do |argument|
          param_name = argument.name.to_s
          param_name = arg_name.slice(1, arg_name.length) if argument.multiple?
          value = params[param_name]

          if value.nil? and argument.optional?
            value = argument.default
          end
          if argument.multiple?
            args + value
          else
            args << value
          end
        end
      end
      send(method_name, *args)
    end
    
    class << self      
      def js_functions
        @js_functions ||= []
      end

      def argument_list
        @argument_list ||= {}
      end
    
      def inherited(base)
        Buttons.app.add_route(:get, "/#{base.to_s.underscore}.js", base, :to_js)
      end

      def method_added(name)
        method = instance_method(name)

        argument_list[name] = method.get_argument_list
        js_functions << Buttons::Javascript::JsFunction.new(name, method.get_argument_list)
        Buttons.app.add_route(:get, "/#{self.to_s.underscore}/#{name}", self, name)
      end
  
      def to_js
        Buttons::Javascript::JsGenerator.new(self).to_js
      end
    end
  end
end