module Buttons
  module Javascript
    class JsArg < JsVar
      attr_reader :name

      def initialize(var)
        @var = var
        super(@var.name)        
      end

      def method_missing(*args, &block)
        @var.send(*args, &block)
      end
      
      def default
        @var.default.to_json
      end
      
      def to_param
        if multiple? then nil else name end
      end
      
      def to_default(index)
        if multiple?
          %Q[var #{name} = arguments.slice(#{index});]
        elsif optional?
          %Q[
            if (#{name} === undefined) {
              #{name} = #{default};
            }
          ]
        end        
      end
    end 
  end
end