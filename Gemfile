gem "get_args", ">= 1.1.1"
gem "facets"
gem "json"

gem "rack", ">= 1.0.1"
gem "usher"

if RUBY_PLATFORM == "java"
  # no additional gems required
elsif RUBY_VERSION < "1.9"
  gem 'ParseTree', :require_as => 'parse_tree'
  gem 'ruby2ruby'
else
  gem 'methopara'
end


gem "riot", :only => :testing
