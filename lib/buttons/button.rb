module Buttons
  class Button
    def to_js
      self.class.to_js
    end
    
    class <<self
      def js_functions
        @js_functions ||= []
      end
    
      def inherited(base)
        Buttons.app.add_route(:get, "/#{base.to_s.underscore}.js", base, :to_js)
      end

      def method_added(name)
        method = instance_method(name)
        js_functions << Buttons::Javascript::JsFunction.new(name, method.get_argument_list)
      end
  
      def to_js
        Buttons::Javascript::JsGenerator.new(self).to_js
      end
    end
  end
end