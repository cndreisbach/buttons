gem "rack", "1.0.1"
gem 'extlib'

if RUBY_PLATFORM == "java"
  # nothing
elsif RUBY_VERSION < "1.9"
  gem 'ParseTree', :require_as => 'parse_tree'
  gem 'ruby2ruby'
else
  gem 'methopara'
end


gem "riot", :only => :testing
