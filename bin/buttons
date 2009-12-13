#!/usr/bin/env ruby
require 'rubygems'
require 'rubigen'
require 'rubigen/scripts/generate'

RubiGen::Base.sources << RubiGen::PathSource.new(:buttons, File.join(File.dirname(__FILE__), %w[.. generators]))
RubiGen::Scripts::Generate.new.run(ARGV, :generator => 'buttons_app')
