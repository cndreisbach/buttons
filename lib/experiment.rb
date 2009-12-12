require 'buttons'

class ProfileButton < Buttons::Button
  def login(username, password, remember_me = false)
  end

  def multiple_inputs(*widgets)
  end

  def no_inputs
  end
end

puts ProfileButton.to_js
