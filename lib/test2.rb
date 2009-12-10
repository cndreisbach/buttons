require 'buttons'
require 'pp'

class Button
  def self.method_added(name)
    puts "#{name}: #{self.instance_method(name).arity}"
    pp self.instance_method(name).get_args
  end
end

class ProfileButton < Button
  def login(username, password, remember_me = false)
    pp [username, password]
  end

  def multiple_inputs(*inputs)
  end

  def no_inputs(options = {})
  end
end
