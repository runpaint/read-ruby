dog = Class.new
dog.class_eval do
  def bark
    :woof
  end
end
dog.new.bark #=> :woof
