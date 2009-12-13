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
    JsFunction.new(:login, :post, '/login', GetArgs::ArgumentList.new(
      [ [:username], [:password], [:remember_me, true] ]
    ))
  }
  
  should("emit JavaScript") {
    topic.to_js
  }.equals(
    %Q[
      this.login = function login (username, password, rememberMe, _ajaxOptions) {
        if (rememberMe === undefined) { rememberMe = true; }
        var data = { 'username': username, 'password': password, 'remember_me': rememberMe };
        if (_ajaxOptions === undefined || typeof(_ajaxOptions) != "object") {
          _ajaxOptions = {};
        }
        _ajaxOptions['type'] = "POST";
        _ajaxOptions['url'] = "/login";
        _ajaxOptions['data'] = data; 
        if (_ajaxOptions['dataType'] === 'undefined') {
          _ajaxOptions['dataType'] = 'json';
        }
        return jQuery.ajax(_ajaxOptions);
      };
    ].strip_whitespace
  )
end

context "a JsFunction with a star argument" do
  setup {
    JsFunction.new(:add_users, :post, '/add_users', GetArgs::ArgumentList.new(
      [ [:admin_username], [:admin_password], ["*new_users"] ]
    ))
  }
  
  should("emit JavaScript") {
    topic.to_js
  }.equals(
    %Q[
      this.addUsers = function addUsers (adminUsername, adminPassword, newUsers, _ajaxOptions) {
        var data = { 'admin_username': adminUsername, 'admin_password': adminPassword, 'new_users[]': newUsers };
        if (_ajaxOptions === undefined || typeof(_ajaxOptions) != "object") {
          _ajaxOptions = {};
        }
        _ajaxOptions['type'] = "POST";
        _ajaxOptions['url'] = "/add_users";
        _ajaxOptions['data'] = data; 
        if (_ajaxOptions['dataType'] === 'undefined') {
          _ajaxOptions['dataType'] = 'json';
        }
        return jQuery.ajax(_ajaxOptions);
      };
    ].strip_whitespace
  )
end