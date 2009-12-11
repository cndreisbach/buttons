require 'buttons'
require 'pp'

module Buttons
  class Button
    def self.js_functions
      @js_functions ||= []
    end

    def self.method_added(name)
      method = self.instance_method(name)
      self.js_functions << Buttons::Javascript::JsFunction.new(name, method.get_args.first)
    end
  
    def self.to_js
      Buttons::Javascript::JsGenerator.new(self).to_js
    end
  end
end

class ProfileButton < Buttons::Button
  def login(username, password, remember_me = false)
    pp [username, password]
  end

  def multiple_inputs(*inputs)
  end

  def no_inputs
  end
end

puts ProfileButton.to_js
