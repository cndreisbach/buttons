task :default => :test

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "buttons"
    gemspec.summary = "Buttons is a Rack framework for working with JavaScript-heavy applications."
    gemspec.description = "Buttons is a Rack framework for working with JavaScript-heavy applications. It
automatically creates Ajax endpoints for Ruby methods, and creates a set of
JavaScript functions to access those endpoints."
    gemspec.email = "crnixon@gmail.com"
    gemspec.homepage = "http://github.com/crnixon/buttons"
    gemspec.authors = ["Clinton R. Nixon"]

    gemspec.add_dependency('get_args', '>= 1.1.1')
    gemspec.add_dependency('facets')
    gemspec.add_dependency('json')
    gemspec.add_dependency('rack', '>= 1.0.1')
    gemspec.add_dependency('bundler')
    gemspec.add_dependency('rubigen')
    gemspec.add_development_dependency('riot')

#    if RUBY_PLATFORM != 'java' && RUBY_VERSION < "1.9"
#      gemspec.add_dependency('ParseTree')
#      gemspec.add_dependency('ruby2ruby')
#    end
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

Dir[File.join(File.dirname(__FILE__), 'tasks', '*.rake')].each { |file| load file }