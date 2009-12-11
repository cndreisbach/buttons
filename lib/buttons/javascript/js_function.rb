module Buttons
  module Javascript
    class JsFunction < JsVar
      attr_reader :name, :args

      def initialize(name, args)
        super(name)
        @args = args     
      end
    end 
  end
end