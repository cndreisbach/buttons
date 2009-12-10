if RUBY_PLATFORM == "java"
  require Buttons.dir('get_args', 'jruby_args')
elsif RUBY_VERSION < "1.9"
  require Buttons.dir('get_args', 'mri_args')
else
  require Buttons.dir('get_args', 'vm_args')
end

class UnboundMethod
  include GetArgs
end

class Method
  include GetArgs
end

