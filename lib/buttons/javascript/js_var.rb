module Buttons
  module Javascript
    class JsVar
      attr_reader :name

      def initialize(name)
        @ruby_name = name.to_s
        @name = @ruby_name.camelcase
      end

      def to_s
        @name
      end
    end
  end
end