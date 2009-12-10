require 'rubygems'
require 'facets'
require 'pp'

module Buttons
  @routes = {}
  
  def self.namespace(name)
    button = Class.new(Button)
    yield button
    @routes[name] = button
  end

  def self.routes
    @routes
  end

  class Button
    def self.to_js
      @methods.map { |name, method|
        to_js_method(name, method)
      }.join("\n\n")
    end

    def self.to_js_method(name, method)
      %Q[function #{name} (#{method[:vars].join(", ")}) { }]
    end
    
    def self.method(name, *var_names, &blk)
      @methods ||= {}
      @methods[name] = {:vars => var_names}
      
      self.send(:define_method, name) do |*vars|
        var_names.each_with_index do |var_name, idx|
          instance_variable_set("@#{var_name}", vars[idx])
        end
        
        blk.bind(self).call
      end
    end
  end
end

Buttons.namespace(:profile) do |profile|
  profile.method(:login, :username, :password) do
    pp [@username, @password]
  end
end

pp Buttons.routes[:profile].to_js

Buttons.routes[:profile].new.login('cnixon', 'password')
