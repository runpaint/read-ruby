class Parent
  def says
    "Tidy your room!"
  end
end

class Child < Parent
  def says
    "In a minute..."
  end
end

Child.new.says #=> "In a minute..."

class Child
  remove_method :says
end

Child.new.says #=> "Tidy your room!"
