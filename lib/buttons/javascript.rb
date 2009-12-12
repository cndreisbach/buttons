require 'json'

require Buttons.dir('javascript', 'js_var')
require Buttons.dir('javascript', 'js_arg')
require Buttons.dir('javascript', 'js_function')
require Buttons.dir('javascript', 'js_generator')

class String
  def strip_whitespace
    self.strip.gsub(/[\n\s]+/, ' ')
  end
end
