class Schneier
  private
  def blowfish
    "Teach a man to fish..."
  end
end
Schneier.new.blowfish #=> NoMethodError: private method `blowfish' called for #<Schneier:0x8b1d458>

class Schneier
  def backdoor
    self.blowfish
  end
end
Schneier.new.backdoor #=> NoMethodError: private method `blowfish' called for #<Schneier:0x8c8b204>

class Schneier
  def backdoor
    blowfish
  end
end
Schneier.new.backdoor #=> "Teach a man to fish..."
