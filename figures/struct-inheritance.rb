class Element < Struct.new(:name, :symbol, :atomic_number)      
  def initialize(*args)
    super
    @poisonous = false
  end
  
  def poisonous?
    @poisonous
  end
  
  def poisonous=(bool)
    @poisonous = !!bool
  end
end
thallium = Element.new(:Thallium, :Tl, 81)
thallium.symbol #=> :Tl
thallium.poisonous = true
thallium.poisonous? #=> true
