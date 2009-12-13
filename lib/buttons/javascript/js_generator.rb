require "yui/compressor"

module Buttons
  module Javascript
    class JsGenerator
      def initialize(button)
        @button = button
        # @compressor = YUI::JavaScriptCompressor.new
      end

      def to_js
        js = %Q[
          (function () {
            this.#{@button.namespace.capitalize} = {};

            #{@button.js_functions.map { |function| 
              function.to_js(@button.namespace.capitalize)
            }.join("\n")}
          })();
        ]
        
        # @compressor.compress(js)
        js.strip_whitespace
      end
    end
  end
end