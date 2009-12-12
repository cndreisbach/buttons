require 'lib/buttons'

class ::ProfileButton < Buttons::Button
  def login(username, password)
    "logged_in #{username}!"
  end
end

run Buttons.app