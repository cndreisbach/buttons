module Buttons
  module Javascript
    class JsVar
      attr_reader :name, :ruby_name

      def initialize(name)
        @ruby_name = name = name.to_s.gsub(/^\*/, '')
        @name = name.camelcase
      end

      def to_s
        @name
      end
    end
  end
end