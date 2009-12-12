require "yui/compressor"

module Buttons
  module Javascript
    class JsGenerator
      def initialize(button)
        @button = button
        @compressor = YUI::JavaScriptCompressor.new
      end

      def to_js
        js = %Q[
          (function () {
            #{@button.js_functions.map { |function| 
              function.to_js 
            }.join("\n")}
          })();
        ]
        
        @compressor.compress(js)
      end
    end
  end
end