self #=> main
self.class #=> Object

class Classy
  self
end #=> Classy

class Classy
  self.class
end #=> Class

class Classy
  def methodical
    self
  end
end
Classy.new.methodical #=> #<Classy:0x90d2268>
