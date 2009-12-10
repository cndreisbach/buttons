require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..', 'vendor', 'gems', 'environment'))
require 'extlib'

module Buttons
  LIB_ROOT = File.dirname(__FILE__)

  def self.dir(*paths)
    File.expand_path(File.join(LIB_ROOT, 'buttons', *paths))
  end
end

require Buttons.dir('get_args')
