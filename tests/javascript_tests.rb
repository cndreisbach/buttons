require File.join(File.dirname(__FILE__), 'helper')

include Buttons::Javascript

context "a JsVar" do
  setup { JsVar.new(:remember_me) }
  
  should("convert underscore syntax to JS syntax") { 
    topic.name 
  }.equals("rememberMe")
    
  should("remember Ruby name") { topic.ruby_name }.equals("remember_me")
  
  should("remove leading asterisk") {
    JsVar.new("*names").name
  }.equals("names")
end

context "a JsArg" do
  setup {
    arg = Struct.new(:name, :default, :optional?, :foo).new(
      'arg_name', nil, true, :bar)
    JsArg.new(arg)
  }
  
  should("convert default to json") { topic.default }.equals(nil.to_json)
  
  should("forward all missing methods to arg") { topic.foo }.equals(:bar)
end

context "a JsFunction" do
  setup {
    JsFunction.new(:login, GetArgs::ArgumentList.new(
      [ [:username], [:password], [:remember_me, true] ]
    ))
  }
  
  should("emit JavaScript") {
    topic.to_js
  }.equals(
    %Q[var login = function login (username, password, rememberMe) { if (rememberMe === undefined) { rememberMe = true; } var data = { username: username, password: password, remember_me: rememberMe }; };]
  )
end

context "a JsFunction with a star argument" do
  setup {
    JsFunction.new(:add_users, GetArgs::ArgumentList.new(
      [ [:admin_username], [:admin_password], ["*new_users"] ]
    ))
  }
  
  should("emit JavaScript") {
    topic.to_js
  }.equals(
    %Q[var addUsers = function addUsers (adminUsername, adminPassword) { var newUsers = arguments.slice(2); var data = { admin_username: adminUsername, admin_password: adminPassword, new_users: newUsers }; };]
  )
end