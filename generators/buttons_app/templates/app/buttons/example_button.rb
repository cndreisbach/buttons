class ExampleButton < Buttons::Button
  get :add, :multiply

  def add(operand1, operand2)
    operand1.to_i + operand2.to_i
  end
  
  def multiply(operand1, operand2)
    operand1.to_i * operand2.to_i
  end
end
