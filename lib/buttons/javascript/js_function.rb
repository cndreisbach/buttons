module Buttons
  module Javascript
    class JsFunction < JsVar
      attr_reader :name, :args

      def initialize(name, http_method, url, args)
        super(name)
        @http_method = http_method
        @url = url
        @args = args.map { |arg| JsArg.new(arg) }
      end
      
      def to_js
        %Q[
          this.#{name} = function #{name} (#{args_to_param_list}, _ajaxOptions) {
            #{args_to_defaults}
            #{assign_args_to_js_object}
            #{ajax_call}
          };
        ].strip_whitespace        
      end
      
      private

      def ajax_call
        %Q[
          if (_ajaxOptions === undefined || typeof(_ajaxOptions) != "object") {
            _ajaxOptions = {};
          }
          _ajaxOptions['type'] = #{@http_method.to_s.upcase.to_json};
          _ajaxOptions['url'] = #{@url.to_json};
          _ajaxOptions['data'] = data;

          if (_ajaxOptions['dataType'] === 'undefined') {
            _ajaxOptions['dataType'] = 'json';
          }

          return jQuery.ajax(_ajaxOptions);
        ]
      end
      
      def args_to_param_list
        args.map { |arg| arg.name }.compact.join(", ")
      end
      
      def args_to_defaults
        args.map_with_index { |arg, i| 
          arg.to_default(i)
        }.compact.join("\n")
      end
      
      def assign_args_to_js_object
        arg_assignments = args.map { |arg|
          "'#{arg.ruby_name}#{'[]' if arg.multiple?}': #{arg.name}"
        }.join(", ")
        
        %Q[var data = { #{arg_assignments} };]
      end
    end 
  end
end