require File.join(File.dirname(__FILE__), 'helper')

class ProfileButton < Buttons::Button
  get :show
  post :login

  def login(username, password)
    # The variable's set just to show that it's being returned.
    token = generate_login_token(username, password)
    token
  end

  def show(profile_id)
    Profile.find(profile_id)
  end
end

context "ProfileButton" do
  should("generate JS") {
    ProfileButton.to_js
  }.equals(%Q[
    (function () {
      this.Profile = {};

      Profile.login = function (username, password, _ajaxOptions) {
        var data = { 'username': username, 'password': password };
        if (_ajaxOptions === undefined || typeof(_ajaxOptions) != "object") {
          _ajaxOptions = {};
        }
        _ajaxOptions['type'] = "POST";
        _ajaxOptions['url'] = "/profile/login";
        _ajaxOptions['data'] = data;

        if (_ajaxOptions['dataType'] === 'undefined') {
          _ajaxOptions['dataType'] = 'json';
        }

        return jQuery.ajax(_ajaxOptions);
      };

      Profile.show = function (profileId, _ajaxOptions) {
        var data = { 'profile_id': profileId };
        if (_ajaxOptions === undefined || typeof(_ajaxOptions) != "object") {
          _ajaxOptions = {};
        }
        _ajaxOptions['type'] = "GET";
        _ajaxOptions['url'] = "/profile/show";
        _ajaxOptions['data'] = data;

        if (_ajaxOptions['dataType'] === 'undefined') {
          _ajaxOptions['dataType'] = 'json';
        }

        return jQuery.ajax(_ajaxOptions);
      };
    })();
  ].strip_whitespace)
end