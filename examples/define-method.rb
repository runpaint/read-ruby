class Conjure
  def self.conjure(name, lamb)
    define_method(name, lamb)
  end
end
# Define a new instance method with a lambda as its body
Conjure.conjure(:glark, ->{ (3..5).to_a * 2 })
Conjure.new.glark #=> [3, 4, 5, 3, 4, 5]         
