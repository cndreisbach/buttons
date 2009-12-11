require "yui/compressor"

module Buttons
  module Javascript
    class JsGenerator
      def initialize(button)
        @button = button
        @compressor = YUI::JavaScriptCompressor.new
      end

      def to_js
        @compressor.compress(%Q[
          (function () {
            #{@button.js_functions.map { |function| function_to_js(function) }.join("\n\n")}
          })();
        ])
      end

      def function_to_js(function)
        args = function.args.map { |arg| JsArg.new(arg) }  
        %Q[
          var #{function.name} = function #{function.name} (#{args_to_param_list(args)}) {
            #{args_to_defaults(args)}
            // code goes here
          };
        ]
      end

      def args_to_param_list(args)
        args.map { |arg| arg_to_param(arg) }.compact.join(", ")
      end

      def arg_to_param(arg)
        if arg.multiple? then nil else arg.name end
      end

      def args_to_defaults(args)
        args.map_with_index { |arg, i| arg_to_default(arg, i) }.compact.join("\n\n")
      end

      def arg_to_default(arg, index)
        if arg.multiple?
          %Q[var #{arg.name} = arguments.slice(#{index});]
        elsif arg.optional?
          %Q[
            if (#{arg.name} === undefined) {
              #{arg.name} = #{arg.default.inspect};
            }
          ]
        end      
      end
    end
  end
end