require File.expand_path(File.join(File.dirname(__FILE__),
                                   '..', 'vendor', 'gems', 'environment'))
require 'facets'

module Buttons
  LIB_ROOT = File.dirname(__FILE__)

  def self.dir(*paths)
    File.expand_path(File.join(LIB_ROOT, 'buttons', *paths))
  end
end

require Buttons.dir('core_ext/string')
require Buttons.dir('application')
require Buttons.dir('javascript')
require Buttons.dir('button')