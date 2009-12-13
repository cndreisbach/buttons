require 'rubygems'
require 'facets'

module Buttons
  def self.lib_root(*paths)
    File.expand_path(File.join(File.dirname(__FILE__), 'buttons', *paths))
  end

  def self.app(&block)
    @app ||= Buttons::Application.new
    @app.instance_eval(&block) unless block.nil?
    @app
  end

  def self.configure
    yield app if block_given?
  end
end

require Buttons.lib_root('core_ext/string')
require Buttons.lib_root('application')
require Buttons.lib_root('javascript')
require Buttons.lib_root('button')