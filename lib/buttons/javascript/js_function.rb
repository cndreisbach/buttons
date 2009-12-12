module Buttons
  module Javascript
    class JsFunction < JsVar
      attr_reader :name, :args

      def initialize(name, args)
        super(name)
        @args = args.map { |arg| JsArg.new(arg) }
      end
      
      def to_js
        %Q[
          var #{name} = function #{name} (#{args_to_param_list}) {
            #{args_to_defaults}
            #{assign_args_to_js_object}
          };
        ].strip_whitespace        
      end
      
      private
      
      def args_to_param_list
        args.map { |arg| arg.to_param }.compact.join(", ")
      end
      
      def args_to_defaults
        args.map_with_index { |arg, i| 
          arg.to_default(i)
        }.compact.join("\n")
      end
      
      def assign_args_to_js_object
        arg_assignments = args.map { |arg|
          "#{arg.ruby_name}: #{arg.name}"
        }.join(", ")
        
        %Q[var data = { #{arg_assignments} };]
      end
    end 
  end
end