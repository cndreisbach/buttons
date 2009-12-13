require 'rubygems'
require 'buttons'

Buttons.configure do |config|  
  config.app_root = File.dirname(__FILE__)
end

Buttons.app.start