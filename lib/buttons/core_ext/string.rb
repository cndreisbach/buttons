class String
  def strip_whitespace
    self.strip.gsub(/[\n\s]+/, ' ')
  end
  
  def debuttonize
    self.underscore.gsub(/_button$/, '')
  end
end
