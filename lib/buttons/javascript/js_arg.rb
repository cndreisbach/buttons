module Buttons
  module Javascript
    class JsArg < JsVar
      attr_reader :name, :default

      def initialize(var)
        name, @default = *var
        super(name)
        if @name.to_s.slice(0,1) == '*'
          @name = @name.slice(1, @name.length)
          @multiple = true
        end        
      end

      def multiple?
        @multiple
      end

      def optional?
        !@default.nil?
      end
    end 
  end
end