class Dog
  def self.breed
    [new, new]
  end
end
Dog.breed #=> [#<Dog:0x95cb530>, #<Dog:0x95cb508>]
